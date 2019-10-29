Content-Type: multipart/mixed; boundary="===============7136975264124725639=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/5] rrm: add radio resource management module
Date: Tue, 29 Oct 2019 10:50:42 -0700
Message-ID: <20191029175043.27745-4-prestwoj@gmail.com>
In-Reply-To: <20191029175043.27745-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7136975264124725639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This module takes care of radio measurements which an AP can request.
There are many types of requests, and for now only beacon requests
are supported.

IWD will filter certain types of beacon requests that are NOT
supported:

 - AP channel reports. Only single channel requests will be supported
 - Autonomous measurements. Only direct requests will be supported.
   IWD will not accept requets to trigger reports under certain
   conditions (SNR/RSSI thresholds, etc.)
 - Timed measurements. Only immediate measurements will be performed.
   The accuracy for timed measurements cannot be reliably guaranteed
   due to kernel scheduling/queues.
 - Full reporting detail. The AP can request the STA return the full
   set of IEs in a beacon. IWD does not currently save all IEs, plus
   there is quite a bit of complexity involved as certain IEs get
   truncated, and there are other length limitations.

There are other limitations not specific to beacon requests:

 - IWD will support single measurement requests per report. Multiple
   measurement request IEs can be included, but the reports will be
   sent out separately.

 - IWD will limit the number of requests it responds to in a given
   amount of time. As it stands now this is hard coded to 2 requests
   per second maximum. This will prevent DoS attacks.

 - IWD will not accept any measurement requests from APs it is not
   connected to, and will not accept any requests until connected.
---
 Makefile.am |   1 +
 src/rrm.c   | 764 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 765 insertions(+)
 create mode 100644 src/rrm.c

diff --git a/Makefile.am b/Makefile.am
index 823b7d02..f3c34680 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -226,6 +226,7 @@ src_iwd_SOURCES =3D src/main.c linux/nl80211.h src/iwd.=
h src/missing.h \
 					src/hotspot.c \
 					src/p2putil.h src/p2putil.c \
 					src/module.c \
+					src/rrm.c \
 					$(eap_sources) \
 					$(builtin_sources)
 =

diff --git a/src/rrm.c b/src/rrm.c
new file mode 100644
index 00000000..e9a94a09
--- /dev/null
+++ b/src/rrm.c
@@ -0,0 +1,764 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2019  Intel Corporation. All rights reserved.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdint.h>
+#include <math.h>
+#include <linux/if_ether.h>
+
+#include <ell/ell.h>
+
+#include "src/mpdu.h"
+#include "src/netdev.h"
+#include "src/iwd.h"
+#include "src/ie.h"
+#include "src/util.h"
+#include "src/station.h"
+#include "src/scan.h"
+#include "src/nl80211util.h"
+
+#include "linux/nl80211.h"
+
+/* Limit requests per second */
+#define MAX_REQUESTS_PER_SEC		2
+/* Microseconds between requests */
+#define MIN_MICROS_BETWEEN_REQUESTS	(1000000 / MAX_REQUESTS_PER_SEC)
+
+/* 802.11-2016 Table 9-90 */
+#define REPORT_DETAIL_NO_FIELDS_OR_ELEMS		0
+#define REPORT_DETAIL_ALL_FIELDS_AND_ANY_REQUEST_ELEMS	1
+#define REPORT_DETAIL_ALL_FIELDS_AND_ELEMS		2
+
+/* 802.11-2016 Table 9-192 */
+#define REPORT_REJECT_LATE	(1 << 0)
+#define REPORT_REJECT_INCAPABLE	(1 << 1)
+#define REPORT_REJECT_REFUSED	(1 << 2)
+
+/* 802.11-2016 Table 9-87 */
+enum rrm_beacon_req_mode {
+	RRM_BEACON_REQ_MODE_PASSIVE =3D	0,
+	RRM_BEACON_REQ_MODE_ACTIVE =3D	1,
+	RRM_BEACON_REQ_MODE_TABLE =3D	2,
+};
+
+/* 802.11-2016 Table 9-88 */
+enum rrm_beacon_req_subelem_id {
+	RRM_BEACON_REQ_SUBELEM_ID_SSID			=3D 0,
+	RRM_BEACON_REQ_SUBELEM_ID_BEACON_REPORTING	=3D 1,
+	RRM_BEACON_REQ_SUBELEM_ID_REPORTING_DETAIL	=3D 2,
+	/* 3 - 9 reserved */
+	RRM_BEACON_REQ_SUBELEM_ID_REQUEST		=3D 10,
+	RRM_BEACON_REQ_SUBELEM_ID_EXT_REQUEST		=3D 11,
+	/* 12 - 50 reserved */
+	RRM_BEACON_REQ_SUBELEM_ID_AP_CHAN_REPORT	=3D 51,
+	/* 52 - 162 reserved */
+	RRM_BEACON_REQ_SUBELEM_ID_WIDE_BAND_SWITCH	=3D 163,
+	/* 164 - 220 reserved */
+	RRM_BEACON_REQ_SUBELEM_ID_VENDOR		=3D 221,
+	/* 222 - 255 reserved */
+};
+
+/* 802.11-2016 Annex C - dot11PHYType */
+enum rrm_phy_type {
+	RRM_PHY_TYPE_DSSS	=3D 2,
+	RRM_PHY_TYPE_OFDM	=3D 4,
+	RRM_PHY_TYPE_HRDSSS	=3D 5,
+	RRM_PHY_TYPE_ERP	=3D 6,
+	RRM_PHY_TYPE_HT		=3D 7,
+	RRM_PHY_TYPE_DMG	=3D 8,
+	RRM_PHY_TYPE_VHT	=3D 9,
+	RRM_PHY_TYPE_TVHT	=3D 10,
+};
+
+/*
+ * Basically the same as 802.11-2016 9.4.2.21.7
+ *
+ * Note: Not packed as this is only for saving values for response
+ */
+struct rrm_beacon_req_info {
+	uint8_t oper_class;
+	uint8_t channel;	/* The single channel provided in request */
+	uint8_t bssid[6];
+	char *ssid;
+};
+
+struct rrm_request_info {
+	uint32_t ifindex;
+	uint8_t from[6];
+	uint8_t dialog_token; /* dialog token in Radio Measurement Request */
+	uint8_t mtoken; /* token in measurement request element */
+	uint8_t mode;
+	uint8_t type;
+
+	/* TODO: once more measurements are supported this can be a union */
+	struct rrm_beacon_req_info *beacon;
+};
+
+static uint64_t last_request_us;
+static const uint8_t wildcard_bss[6] =3D { 0xff, 0xff, 0xff, 0xff, 0xff, 0=
xff };
+static struct l_genl_family *nl80211;
+static uint32_t netdev_watch;
+static uint32_t unicast_watch;
+
+static void rrm_info_destroy(void *data)
+{
+	struct rrm_request_info *info =3D data;
+
+	if (info->beacon) {
+		l_free(info->beacon->ssid);
+		l_free(info->beacon);
+	}
+
+	l_free(info);
+}
+
+static uint8_t rrm_phy_type(struct scan_bss *bss)
+{
+	if (bss->vht_capable)
+		return RRM_PHY_TYPE_VHT;
+
+	if (bss->ht_capable)
+		return RRM_PHY_TYPE_HT;
+
+	/*
+	 * Default to 802.11g phy type. You can get quite fancy here determining
+	 * the phy type by looking at the frequency and operator class among
+	 * other things. Since 802.11a/b are so old, defaulting to 802.11g just
+	 * removes a lot of complexity. Above, HT/VHT are easy as all you need
+	 * to look for is the presence of the IE.
+	 */
+	return RRM_PHY_TYPE_ERP;
+}
+
+static void rrm_send_response_cb(struct l_genl_msg *msg, void *user_data)
+{
+	int err =3D l_genl_msg_get_error(msg);
+
+	if (err < 0)
+		l_error("Error sending response: %d", err);
+}
+
+static bool rrm_send_response(uint32_t ifindex, const uint8_t *dest,
+				const uint8_t *frame, size_t len)
+{
+	struct station *station =3D station_find(ifindex);
+	struct netdev *netdev =3D netdev_find(ifindex);
+	struct scan_bss *connected_bss =3D station_get_connected_bss(station);
+	const uint8_t *own_addr =3D netdev_get_address(netdev);
+	uint32_t own_freq =3D connected_bss->frequency;
+	struct l_genl_msg *msg;
+	struct iovec iov;
+
+	iov.iov_base =3D (void *)frame;
+	iov.iov_len =3D len;
+
+	msg =3D nl80211_build_cmd_frame(ifindex, own_addr, dest,
+					own_freq, &iov, 1);
+
+	if (!l_genl_family_send(nl80211, msg, rrm_send_response_cb,
+					NULL, NULL)) {
+		l_genl_msg_unref(msg);
+		l_error("Failed to send report for "MAC, MAC_STR(dest));
+		return false;
+	}
+
+	return true;
+}
+
+static bool rrm_reject_measurement_request(struct rrm_request_info *info,
+						uint8_t mode)
+{
+	uint8_t frame[8];
+
+	frame[0] =3D 0x05; /* Category: Radio Measurement */
+	frame[1] =3D 0x01; /* Action: Radio Measurement Report */
+	frame[2] =3D info->dialog_token;
+	frame[3] =3D IE_TYPE_MEASUREMENT_REQUEST;
+	frame[4] =3D 3;
+	frame[5] =3D info->mtoken;
+	frame[6] =3D mode;
+	frame[7] =3D info->type;
+
+	if (!rrm_send_response(info->ifindex, info->from, frame, sizeof(frame)))
+		return false;
+
+	rrm_info_destroy(info);
+
+	return true;
+}
+
+static void rrm_build_measurement_report(struct rrm_request_info *info,
+				const void *report, size_t report_len,
+				uint8_t *to)
+{
+	*to++ =3D IE_TYPE_MEASUREMENT_REPORT;
+	*to++ =3D 3 + report_len;
+	*to++ =3D info->mtoken;
+	*to++ =3D 0;
+	*to++ =3D info->type;
+
+	if (report)
+		memcpy(to, report, report_len);
+}
+
+static void rrm_register_frame_cb(struct l_genl_msg *msg, void *user_data)
+{
+	if (l_genl_msg_get_error(msg) < 0)
+		l_error("Could not register frame watch type %04x: %i",
+			L_PTR_TO_UINT(user_data), l_genl_msg_get_error(msg));
+}
+
+static void rrm_register_frame(uint32_t ifindex)
+{
+	struct l_genl_msg *msg;
+	uint16_t frame_type =3D 0x00d0;
+	uint8_t prefix[] =3D { 0x05, 0x00 }; /* Radio Measurment Request */
+
+	msg =3D l_genl_msg_new_sized(NL80211_CMD_REGISTER_FRAME, 34);
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &ifindex);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME_TYPE, 2, &frame_type);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_FRAME_MATCH,
+					sizeof(prefix), prefix);
+
+	l_genl_family_send(nl80211, msg, rrm_register_frame_cb,
+			L_UINT_TO_PTR(frame_type), NULL);
+}
+
+static void rrm_netdev_watch(struct netdev *netdev,
+				enum netdev_watch_event event, void *user_data)
+{
+	switch (event) {
+	case NETDEV_WATCH_EVENT_NEW:
+		rrm_register_frame(netdev_get_ifindex(netdev));
+		return;
+	default:
+		break;
+	}
+}
+
+/*
+ * 802.11-2016 11.11.9.1 Beacon report
+ *
+ * "If the stored beacon information is based on a measurement made by
+ *  the reporting STA, and if the actual measurement start time,
+ *  measurement duration, and Parent TSF are available for this
+ *  measurement, then the beacon report shall include the actual
+ *  measurement start time, measurement duration, and Parent TSF;
+ *  otherwise the actual measurement start time, measurement duration,
+ *  and Parent TSF shall be set to 0. The RCPI and RSNI for that stored
+ *  beacon measurement may be included in the beacon report; otherwise
+ *  the beacon report shall indicate that RCPI and RSNI measurements
+ *  are not available"
+ *
+ * Since accurate timing is unreliable we are setting start/duration/TSF t=
ime to
+ * zero for all cases (table, passive, active).
+ */
+static size_t build_report_for_bss(struct rrm_request_info *info,
+					struct scan_bss *bss,
+					uint8_t *to)
+{
+	uint8_t *start =3D to;
+	double dbms =3D bss->signal_strength / 100;
+
+	*to++ =3D info->beacon->oper_class;
+	*to++ =3D scan_freq_to_channel(bss->frequency, NULL);
+	/* skip start time/duration */
+	memset(to, 0, 10);
+	to +=3D 10;
+	*to++ =3D rrm_phy_type(bss);
+
+	/* 802.11 Table 9-154 - RCPI values */
+	if (dbms < -109.5)
+		*to++ =3D 0;
+	else if (dbms >=3D -109.5 && dbms < 0)
+		*to++ =3D (uint8_t)floor(2 * (dbms + 110));
+	else
+		*to++ =3D 220;
+
+	/* RSNI not available (could get this from GET_SURVEY) */
+	*to++ =3D 255;
+	memcpy(to, bss->addr, 6);
+	to +=3D 6;
+	/* Antenna identifier unknown */
+	*to++ =3D 0;
+	/* Parent TSF - zero */
+	memset(to, 0, 4);
+	to +=3D 4;
+
+	/*
+	 * TODO: Support optional subelements
+	 *
+	 * (see "TODO: Support Reported Frame Body..." below)
+	 */
+
+	return to - start;
+}
+
+static bool bss_in_request_range(struct rrm_request_info *info,
+					struct scan_bss *bss)
+{
+	uint8_t channel =3D scan_freq_to_channel(bss->frequency, NULL);
+
+	/* Must be a table measurement */
+	if (info->beacon->channel =3D=3D 0 || info->beacon->channel =3D=3D 255)
+		return true;
+
+	if (info->beacon->channel =3D=3D channel)
+		return true;
+
+	return false;
+}
+
+static bool rrm_report_results(struct rrm_request_info *info,
+				struct l_queue *bss_list)
+{
+	bool wildcard =3D memcmp(info->beacon->bssid, wildcard_bss, 6) =3D=3D 0;
+	const struct l_queue_entry *entry;
+	uint8_t frame[512];
+	uint8_t *ptr =3D frame;
+
+	*ptr++ =3D 0x05; /* Category: Radio Measurement */
+	*ptr++ =3D 0x01; /* Action: Radio Measurement Report */
+	*ptr++ =3D info->dialog_token;
+
+	for (entry =3D l_queue_get_entries(bss_list); entry;
+							entry =3D entry->next) {
+		struct scan_bss *bss =3D entry->data;
+		uint8_t report[257];
+		size_t report_len;
+
+		/* If request included a specific BSSID match only this BSS */
+		if (!wildcard && memcmp(bss->addr, info->beacon->bssid, 6) !=3D 0)
+			continue;
+
+		/* If request was for a certain SSID, match only this SSID */
+		if (info->beacon->ssid && strncmp(info->beacon->ssid,
+							(const char *)bss->ssid,
+							sizeof(bss->ssid)) !=3D 0)
+			continue;
+
+		/*
+		 * The kernel may have returned a cached scan, so we have to
+		 * sort out any non-matching frequencies before building the
+		 * report
+		 */
+		if (!bss_in_request_range(info, bss))
+			continue;
+
+		report_len =3D build_report_for_bss(info, bss, report);
+
+		rrm_build_measurement_report(info, report, report_len, ptr);
+
+		ptr +=3D report_len + 5;
+	}
+
+	return rrm_send_response(info->ifindex, info->from, frame, ptr - frame);
+}
+
+static bool rrm_handle_beacon_table(struct rrm_request_info *info)
+{
+	struct station *station =3D station_find(info->ifindex);
+	struct l_queue *bss_list;
+
+	bss_list =3D station_get_bss_list(station);
+	if (!bss_list)
+		return rrm_reject_measurement_request(info,
+						REPORT_REJECT_INCAPABLE);
+
+	if (!rrm_report_results(info, bss_list))
+		l_error("Error reporting beacon table results");
+
+	/*
+	 * Table measurements do not require any async operations so info is
+	 * freed here always.
+	 */
+	rrm_info_destroy(info);
+
+	return true;
+}
+
+static bool rrm_scan_results(int err, struct l_queue *bss_list, void *user=
data)
+{
+	struct rrm_request_info *info =3D userdata;
+
+	l_debug("RRM scan results for %u APs", l_queue_length(bss_list));
+
+	rrm_report_results(info, bss_list);
+	/* We aren't saving this BSS list */
+	return false;
+}
+
+static void rrm_scan_triggered(int err, void *userdata)
+{
+	struct rrm_request_info *info =3D userdata;
+
+	if (err < 0) {
+		l_error("Could not start RRM scan");
+		rrm_reject_measurement_request(info, REPORT_REJECT_INCAPABLE);
+	}
+}
+
+static bool rrm_handle_beacon_scan(struct rrm_request_info *info,
+					bool passive)
+{
+	struct netdev *netdev =3D netdev_find(info->ifindex);
+	struct scan_freq_set *freqs =3D scan_freq_set_new();
+	struct scan_parameters params =3D { .freqs =3D freqs, .flush =3D true };
+	enum scan_band band =3D scan_oper_class_to_band(NULL,
+						info->beacon->oper_class);
+	uint32_t freq;
+	uint32_t scan_id;
+
+	freq =3D scan_channel_to_freq(info->beacon->channel, band);
+	scan_freq_set_add(freqs, freq);
+
+	if (passive)
+		scan_id =3D scan_passive(netdev_get_wdev_id(netdev), freqs,
+						rrm_scan_triggered,
+						rrm_scan_results, info,
+						rrm_info_destroy);
+	else
+		scan_id =3D scan_active_full(netdev_get_wdev_id(netdev), &params,
+						rrm_scan_triggered,
+						rrm_scan_results, info,
+						rrm_info_destroy);
+
+	scan_freq_set_free(freqs);
+
+	return scan_id !=3D 0;
+}
+
+static bool rrm_verify_beacon_request(const uint8_t *request, size_t len)
+{
+	if (len < 13)
+		return false;
+
+	if (request[6] !=3D RRM_BEACON_REQ_MODE_TABLE) {
+		/*
+		 * Rejecting any iterative measurements, only accepting explicit
+		 * channels and operating classes except for table measurements.
+		 */
+		if (request[0] =3D=3D 0 || request[0] =3D=3D 255 ||
+					request[1] =3D=3D 0 || request[1] =3D=3D 255)
+			return false;
+
+		/*
+		 * Not handling interval/duration requests. We can omit this
+		 * check for table requests since we just return whatever we
+		 * have cached.
+		 */
+		if (!util_mem_is_zero(request + 2, 4))
+			return false;
+	}
+
+	/* Check this is a valid operating class */
+	if (!scan_oper_class_to_band(NULL, request[0]))
+		return false;
+
+	return true;
+}
+
+static bool rrm_handle_beacon_request(struct rrm_request_info *info,
+					const uint8_t *request, size_t len)
+{
+	struct ie_tlv_iter iter;
+	/*
+	 * 802.11-2016 - Table 9-90
+	 *
+	 * "All fixed-length fields and elements (default, used when Reporting
+	 *  Detail subelement is not included in a Beacon request)"
+	 */
+	uint8_t detail =3D REPORT_DETAIL_NO_FIELDS_OR_ELEMS;
+
+	if (!rrm_verify_beacon_request(request, len))
+		return rrm_reject_measurement_request(info,
+							REPORT_REJECT_REFUSED);
+
+	info->beacon =3D l_new(struct rrm_beacon_req_info, 1);
+
+	info->beacon->oper_class =3D request[0];
+	info->beacon->channel =3D request[1];
+	memcpy(info->beacon->bssid, request + 7, 6);
+
+	ie_tlv_iter_init(&iter, request + 13, len - 13);
+
+	while (ie_tlv_iter_next(&iter)) {
+		uint8_t length =3D ie_tlv_iter_get_length(&iter);
+		const unsigned char *data =3D ie_tlv_iter_get_data(&iter);
+
+		switch (ie_tlv_iter_get_tag(&iter)) {
+		case RRM_BEACON_REQ_SUBELEM_ID_SSID:
+			/*
+			 * Zero length is wildcard SSID, which has the same
+			 * effect as no SSID.
+			 */
+			if (length > 0 && length < 32)
+				info->beacon->ssid =3D l_strndup(
+							(const char *)data,
+							length);
+
+			break;
+		case RRM_BEACON_REQ_SUBELEM_ID_REPORTING_DETAIL:
+			if (length !=3D 1) {
+				l_error("Invalid length in reporting detail");
+				return false;
+			}
+
+			detail =3D l_get_u8(data);
+			break;
+		case RRM_BEACON_REQ_SUBELEM_ID_BEACON_REPORTING:
+			/*
+			 * 802.11-2016 9.4.2.21.7
+			 *
+			 * "The Beacon reporting subelement is optionally
+			 *  present in a Beacon request for repeated
+			 *  measurements; otherwise it is not present"
+			 *
+			 * Since repeated measurements are not supported we can
+			 * reject this request now.
+			 */
+		case RRM_BEACON_REQ_SUBELEM_ID_AP_CHAN_REPORT:
+			/*
+			 * Only supporting single channel requests
+			 */
+			return rrm_reject_measurement_request(info,
+						REPORT_REJECT_INCAPABLE);
+		}
+	}
+
+	/*
+	 * TODO: Support Reported Frame Body of 1 and 2. This requires that all
+	 * fixed length fields are available from the scan request. Currently
+	 * scan.c parses out only the details we care about. There is also
+	 * limitations on length, and some IEs are treated specially and
+	 * truncated. This adds quite a bit of complexity. For now skip these
+	 * types of frame body reports.
+	 */
+	if (detail !=3D REPORT_DETAIL_NO_FIELDS_OR_ELEMS) {
+		l_debug("Unsupported report detail");
+		return rrm_reject_measurement_request(info,
+						REPORT_REJECT_INCAPABLE);
+	}
+
+	/* Mode */
+	switch (request[6]) {
+	case RRM_BEACON_REQ_MODE_PASSIVE:
+		return rrm_handle_beacon_scan(info, true);
+	case RRM_BEACON_REQ_MODE_ACTIVE:
+		return rrm_handle_beacon_scan(info, false);
+	case RRM_BEACON_REQ_MODE_TABLE:
+		return rrm_handle_beacon_table(info);
+	default:
+		l_error("Unknown beacon mode %u", request[6]);
+		return rrm_reject_measurement_request(info,
+							REPORT_REJECT_REFUSED);
+	}
+}
+
+static bool rrm_handle_measurement_request(struct rrm_request_info *info,
+				const uint8_t *data, size_t len)
+{
+	if (len < 3)
+		return false;
+
+	info->mtoken =3D data[0];
+	info->mode =3D data[1];
+	info->type =3D data[2];
+
+	/* 'Enable' bit is set */
+	if (util_is_bit_set(info->mode, 1)) {
+		/*
+		 * 802.11-2016 11.11.8
+		 *
+		 * "A STA may also refuse to enable triggered autonomous
+		 * reporting. In this case a Measurement Report element shall be
+		 * returned to the requesting STA with the refused bit set to 1"
+		 *
+		 * At least for the time being, we will not support autonomous
+		 * reporting, so decline any request to do so.
+		 */
+		return rrm_reject_measurement_request(info,
+							REPORT_REJECT_REFUSED);
+	}
+
+	/* TODO: handle other measurement types */
+	switch (info->type) {
+	case 5: /* Beacon Request */
+		return rrm_handle_beacon_request(info, data + 3, len - 3);
+	default:
+		l_error("Measurement type %u not supported", info->type);
+		return rrm_reject_measurement_request(info,
+						REPORT_REJECT_INCAPABLE);
+	}
+}
+
+static void rrm_unicast_notify(struct l_genl_msg *msg, void *user_data)
+{
+	struct station *station;
+	struct scan_bss *bss;
+	const struct mmpdu_header *mpdu =3D NULL;
+	const uint8_t *request;
+	struct l_genl_attr attr;
+	uint16_t type, len;
+	uint16_t frame_len =3D 0;
+	const void *data;
+	uint8_t cmd;
+	uint32_t ifindex =3D 0;
+	struct ie_tlv_iter iter;
+
+	cmd =3D l_genl_msg_get_command(msg);
+	if (cmd !=3D NL80211_CMD_FRAME)
+		return;
+
+	if (!l_genl_attr_init(&attr, msg))
+		return;
+
+	while (l_genl_attr_next(&attr, &type, &len, &data)) {
+		switch (type) {
+		case NL80211_ATTR_IFINDEX:
+			if (len !=3D sizeof(uint32_t)) {
+				l_warn("Invalid interface index attribute");
+				return;
+			}
+
+			ifindex =3D *((uint32_t *) data);
+
+			break;
+		case NL80211_ATTR_FRAME:
+			if (mpdu)
+				return;
+
+			mpdu =3D mpdu_validate(data, len);
+			if (!mpdu)
+				l_error("Frame didn't validate as MMPDU");
+
+			frame_len =3D len;
+			break;
+		}
+	}
+
+	if (!ifindex || !mpdu)
+		return;
+
+	station =3D station_find(ifindex);
+	if (!station)
+		return;
+
+	if (station_get_state(station) !=3D STATION_STATE_CONNECTED)
+		return;
+
+	bss =3D station_get_connected_bss(station);
+	if (!bss)
+		return;
+
+	/* Not from connected AP */
+	if (memcmp(bss->addr, mpdu->address_2, 6) !=3D 0)
+		return;
+
+	request =3D mmpdu_body(mpdu);
+
+	frame_len -=3D mmpdu_header_len(mpdu);
+
+	if (frame_len < 5)
+		return;
+
+	if (request[0] !=3D 0x05)
+		return;
+
+	if (request[1] !=3D 0x00)
+		return;
+
+	/*
+	 * We have reached our max requests per second, no point in continuing
+	 */
+	if (l_time_now() - last_request_us < MIN_MICROS_BETWEEN_REQUESTS) {
+		l_debug("Max requests per second reached, ignoring request");
+		return;
+	}
+
+	/* Update time regardless of success */
+	last_request_us =3D l_time_now();
+
+	ie_tlv_iter_init(&iter, request + 5, frame_len - 5);
+
+	while (ie_tlv_iter_next(&iter)) {
+		struct rrm_request_info *info;
+
+		if (ie_tlv_iter_get_tag(&iter) !=3D IE_TYPE_MEASUREMENT_REQUEST)
+			continue;
+
+		info =3D l_new(struct rrm_request_info, 1);
+
+		info->ifindex =3D ifindex;
+		memcpy(info->from, mpdu->address_2, 6);
+		info->dialog_token =3D request[2];
+
+		if (!rrm_handle_measurement_request(info,
+					ie_tlv_iter_get_data(&iter),
+					ie_tlv_iter_get_length(&iter))) {
+			/*
+			 * A failure here means there was some problem
+			 * responding, or the request data was invalid. In
+			 * either case its best to just bail on this set of
+			 * requests.
+			 */
+			rrm_info_destroy(info);
+			return;
+		}
+	}
+}
+
+static int rrm_init(void)
+{
+	struct l_genl *genl =3D iwd_get_genl();
+
+	nl80211 =3D l_genl_family_new(genl, NL80211_GENL_NAME);
+
+	netdev_watch =3D  netdev_watch_add(rrm_netdev_watch, NULL, NULL);
+
+	unicast_watch =3D l_genl_add_unicast_watch(genl, NL80211_GENL_NAME,
+						rrm_unicast_notify,
+						NULL, NULL);
+
+	last_request_us =3D l_time_now();
+
+	return 0;
+}
+
+static void rrm_exit(void)
+{
+	struct l_genl *genl =3D iwd_get_genl();
+
+	l_genl_family_free(nl80211);
+	nl80211 =3D NULL;
+
+	netdev_watch_remove(netdev_watch);
+
+	l_genl_remove_unicast_watch(genl, unicast_watch);
+}
+
+IWD_MODULE(rrm, rrm_init, rrm_exit);
+IWD_MODULE_DEPENDS(rrm, netdev);
-- =

2.17.1

--===============7136975264124725639==--

