Content-Type: multipart/mixed; boundary="===============1635117875260496779=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 5/9] dpp: send presence announcements on StartEnrollee
Date: Mon, 13 Dec 2021 12:33:28 -0800
Message-ID: <20211213203332.2191003-5-prestwoj@gmail.com>
In-Reply-To: 20211213203332.2191003-1-prestwoj@gmail.com

--===============1635117875260496779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The presence procedure implemented is a far cry from what the spec
actually wants. There are two reason for this: a) the kernels offchannel
support is not at a level where it will work without rather annoying
work arounds, and b) doing the procedure outlined in the spec will
result in terrible discovery performance.

Because of this a simpler single channel announcement is recommended.
This is done if the arguments to StartEnrollee contain a frequency
list.
---
 src/dpp.c | 301 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 301 insertions(+)

diff --git a/src/dpp.c b/src/dpp.c
index 4e854780..e6477f5c 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -24,14 +24,33 @@
 #include <config.h>
 #endif
 =

+#include <errno.h>
+
 #include <ell/ell.h>
 =

+#include "linux/nl80211.h"
+
 #include "src/dbus.h"
 #include "src/netdev.h"
 #include "src/module.h"
 #include "src/dpp-util.h"
+#include "src/offchannel.h"
+#include "src/scan.h"
+#include "src/band.h"
+#include "src/wiphy.h"
+#include "src/ie.h"
+#include "src/frame-xchg.h"
+#include "src/iwd.h"
+#include "src/util.h"
 =

 static uint32_t netdev_watch;
+static struct l_genl_family *nl80211;
+static uint8_t broadcast[] =3D {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+
+enum dpp_state {
+	DPP_STATE_NOTHING,
+	DPP_STATE_PRESENCE,
+};
 =

 struct dpp_sm {
 	struct netdev *netdev;
@@ -47,14 +66,121 @@ struct dpp_sm {
 	size_t nonce_len;
 	struct l_ecc_scalar *boot_private;
 	struct l_ecc_point *boot_public;
+
+	enum dpp_state state;
+
+	uint32_t *freqs;
+	size_t freqs_len;
+	size_t freqs_idx;
+	uint32_t dwell;
+	uint32_t current_freq;
+	uint32_t presence_scan_id;
+	struct scan_freq_set *presence_list;
+
+	uint32_t offchannel_id;
 };
 =

+static void dpp_send_frame_cb(struct l_genl_msg *msg, void *user_data)
+{
+	if (l_genl_msg_get_error(msg) < 0)
+		l_error("Error sending frame");
+}
+
+static void dpp_send_frame(uint64_t wdev_id, struct iovec *iov, size_t iov=
_len,
+			uint32_t freq)
+{
+	struct l_genl_msg *msg;
+
+	msg =3D l_genl_msg_new_sized(NL80211_CMD_FRAME, 512);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_WDEV, 8, &wdev_id);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY_FREQ, 4, &freq);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_OFFCHANNEL_TX_OK, 0, NULL);
+	l_genl_msg_append_attrv(msg, NL80211_ATTR_FRAME, iov, iov_len);
+
+	l_debug("Sending frame on frequency %u", freq);
+
+	if (!l_genl_family_send(nl80211, msg, dpp_send_frame_cb, NULL, NULL))
+		l_error("Could not send CMD_FRAME");
+}
+
+static size_t dpp_append_attr(uint8_t *to, enum dpp_attribute_type type,
+				void *attr, size_t attr_len)
+{
+	l_put_le16(type, to);
+	l_put_le16(attr_len, to + 2);
+	memcpy(to + 4, attr, attr_len);
+
+	return attr_len + 4;
+}
+
+static size_t dpp_build_header(const uint8_t *src, const uint8_t *dest,
+				enum dpp_frame_type type,
+				uint8_t buf[static 32])
+{
+	uint8_t *ptr =3D buf + 24;
+
+	memset(buf, 0, 32);
+
+	l_put_le16(0x00d0, buf);
+	memcpy(buf + 4, dest, 6);
+	memcpy(buf + 10, src, 6);
+	memcpy(buf + 16, broadcast, 6);
+
+	*ptr++ =3D 0x04;			/* Category: Public */
+	*ptr++ =3D 0x09;			/* Action: Vendor specific usage */
+	memcpy(ptr, wifi_alliance_oui, 3);
+	ptr +=3D 3;
+	*ptr++ =3D 0x1a;			/* WiFi Alliance DPP OI type */
+	*ptr++ =3D 1;			/* Cryptosuite */
+	*ptr++ =3D type;
+
+	return ptr - buf;
+}
+
+static void dpp_presence_announce(struct dpp_sm *dpp)
+{
+	struct netdev *netdev =3D dpp->netdev;
+	uint8_t hdr[32];
+	uint8_t attrs[32 + 4];
+	uint8_t hash[32];
+	uint8_t *ptr =3D attrs;
+	const uint8_t *addr =3D netdev_get_address(netdev);
+	struct iovec iov[3];
+
+	iov[0].iov_len =3D dpp_build_header(addr, broadcast,
+					DPP_FRAME_PRESENCE_ANNOUNCEMENT, hdr);
+	iov[0].iov_base =3D hdr;
+
+	dpp_hash(L_CHECKSUM_SHA256, hash, 2, "chirp", strlen("chirp"),
+			dpp->pub_asn1, dpp->pub_asn1_len);
+
+	ptr +=3D dpp_append_attr(ptr, DPP_ATTR_RESPONDER_BOOT_KEY_HASH, hash, 32);
+
+	iov[1].iov_base =3D attrs;
+	iov[1].iov_len =3D ptr - attrs;
+	iov[2].iov_base =3D NULL;
+
+	l_debug("Sending presense annoucement on frequency %u and waiting %u",
+		dpp->current_freq, dpp->dwell);
+
+	dpp_send_frame(netdev_get_wdev_id(netdev), iov, 2, dpp->current_freq);
+}
+
+static void dpp_roc_started(void *user_data)
+{
+	struct dpp_sm *dpp =3D user_data;
+
+	dpp_presence_announce(dpp);
+}
+
 static void dpp_create(struct netdev *netdev)
 {
 	struct l_dbus *dbus =3D dbus_get_bus();
 	struct dpp_sm *dpp =3D l_new(struct dpp_sm, 1);
 =

 	dpp->netdev =3D netdev;
+	dpp->state =3D DPP_STATE_NOTHING;
+	dpp->wdev_id =3D netdev_get_wdev_id(netdev);
 =

 	l_dbus_object_add_interface(dbus, netdev_get_path(netdev),
 					IWD_DPP_INTERFACE, dpp);
@@ -81,12 +207,22 @@ static void dpp_reset(struct dpp_sm *dpp)
 		l_ecc_scalar_free(dpp->boot_private);
 		dpp->boot_private =3D NULL;
 	}
+
+	dpp->state =3D DPP_STATE_NOTHING;
 }
 =

 static void dpp_free(struct dpp_sm *dpp)
 {
 	dpp_reset(dpp);
 =

+	if (dpp->freqs)
+		l_free(dpp->freqs);
+
+	if (dpp->offchannel_id) {
+		offchannel_cancel(dpp->wdev_id, dpp->offchannel_id);
+		dpp->offchannel_id =3D 0;
+	}
+
 	l_free(dpp);
 }
 =

@@ -107,6 +243,140 @@ static void dpp_netdev_watch(struct netdev *netdev,
 	}
 }
 =

+static void dpp_presence_timeout(int error, void *user_data)
+{
+	struct dpp_sm *dpp =3D user_data;
+
+	if (dpp->state !=3D DPP_STATE_PRESENCE) {
+		l_debug("DPP state changed, stopping presence announcements");
+		dpp->freqs_idx =3D 0;
+		return;
+	}
+
+	dpp->freqs_idx++;
+
+	if (dpp->freqs_idx >=3D dpp->freqs_len) {
+		l_debug("Max retries on presence announcements");
+		dpp->freqs_idx =3D 0;
+	}
+
+	dpp->current_freq =3D dpp->freqs[dpp->freqs_idx];
+
+	l_debug("Presence timeout, moving to next frequency %u, duration %u",
+			dpp->current_freq, dpp->dwell);
+
+	dpp->offchannel_id =3D offchannel_start(netdev_get_wdev_id(dpp->netdev),
+			dpp->current_freq, dpp->dwell, dpp_roc_started,
+			dpp, dpp_presence_timeout);
+}
+
+/*
+ * EasyConnect 2.0 - 6.2.2
+ */
+static uint32_t *dpp_add_default_channels(struct dpp_sm *dpp, size_t *len_=
out)
+{
+	struct wiphy *wiphy =3D wiphy_find_by_wdev(
+					netdev_get_wdev_id(dpp->netdev));
+	const struct scan_freq_set *list =3D wiphy_get_supported_freqs(wiphy);
+	uint32_t freq;
+
+	if (!dpp->presence_list)
+		dpp->presence_list =3D scan_freq_set_new();
+
+	scan_freq_set_add(dpp->presence_list, band_channel_to_freq(6,
+						BAND_FREQ_2_4_GHZ));
+	/*
+	 * "5 GHz: Channel 44 (5.220 GHz) if local regulations permit operation
+	 * only in the 5.150 - 5.250 GHz band and Channel 149 (5.745 GHz)
+	 * otherwise"
+	 */
+	freq =3D band_channel_to_freq(149, BAND_FREQ_5_GHZ);
+
+	if (scan_freq_set_contains(list, freq))
+		scan_freq_set_add(dpp->presence_list, freq);
+	else
+		scan_freq_set_add(dpp->presence_list,
+				band_channel_to_freq(44, BAND_FREQ_5_GHZ));
+
+	/* TODO: 60GHz: Channel 2 */
+
+	return scan_freq_set_to_fixed_array(dpp->presence_list, len_out);
+}
+
+/*
+ * TODO: There is an entire procedure defined in the spec where you increa=
se
+ * the ROC timeout with each unsuccessful iteration of channels, wait on c=
hannel
+ * for long periods of time etc. Due to offchannel issues in the kernel th=
is
+ * procedure is not being fully implemented. In reality doing this would r=
esult
+ * in quite terrible DPP performance anyways. Its recommended to supply a
+ * single channel argument to StartEnrollee and only operate on that chann=
el.
+ */
+static void dpp_start_presence_announcements(struct dpp_sm *dpp,
+						uint32_t *limit_freqs,
+						size_t limit_len)
+{
+	uint32_t max_roc =3D wiphy_get_max_roc_duration(
+					wiphy_find_by_wdev(dpp->wdev_id));
+
+	if (2000 < max_roc)
+		max_roc =3D 2000;
+
+	if (limit_freqs) {
+		dpp->freqs =3D limit_freqs;
+		dpp->freqs_len =3D limit_len;
+	} else
+		dpp->freqs =3D dpp_add_default_channels(dpp, &dpp->freqs_len);
+
+	dpp->presence_scan_id =3D 0;
+	dpp->dwell =3D max_roc;
+	dpp->freqs_idx =3D 0;
+	dpp->current_freq =3D dpp->freqs[0];
+
+	dpp->offchannel_id =3D offchannel_start(netdev_get_wdev_id(dpp->netdev),
+			dpp->current_freq, dpp->dwell, dpp_roc_started,
+			dpp, dpp_presence_timeout);
+}
+
+static void dpp_trigger_scan(int error, void *user_data)
+{
+	struct dpp_sm *dpp =3D user_data;
+
+	if (error < 0)
+		dpp_start_presence_announcements(dpp, NULL, 0);
+}
+
+static bool dpp_scan_notify(int error, struct l_queue *bss_list,
+			const struct scan_freq_set *freqs, void *user_data)
+{
+	struct dpp_sm *dpp =3D user_data;
+	const struct l_queue_entry *bss_entry;
+
+	for (bss_entry =3D l_queue_get_entries(bss_list); bss_entry;
+						bss_entry =3D bss_entry->next) {
+		struct scan_bss *bss =3D bss_entry->data;
+
+		if (bss->dpp_configurator)
+			scan_freq_set_add(dpp->presence_list, bss->frequency);
+	}
+
+	dpp_start_presence_announcements(dpp, NULL, 0);
+
+	return false;
+}
+
+static void dpp_start_presence_scan(struct dpp_sm *dpp)
+{
+	/*
+	 * Scan for Configurator Connectivity element. If there is some problem
+	 * issuing the scan we can still continue and send presence frames
+	 */
+	dpp->presence_scan_id =3D scan_active(dpp->wdev_id, NULL, 0,
+						dpp_trigger_scan,
+						dpp_scan_notify, dpp, NULL);
+	if (!dpp->presence_scan_id)
+		dpp_start_presence_announcements(dpp, NULL, 0);
+}
+
 static bool dpp_parse_enrollee_params(struct l_dbus_message *message,
 					const char **info_out,
 					const char **host_out,
@@ -183,6 +453,9 @@ static struct l_dbus_message *dpp_dbus_start_enrollee(s=
truct l_dbus *dbus,
 	if (!netdev_get_is_up(dpp->netdev))
 		return dbus_error_not_available(message);
 =

+	if (dpp->state !=3D DPP_STATE_NOTHING)
+		return dbus_error_already_exists(message);
+
 	if (!dpp_parse_enrollee_params(message, &info, &host, &freqs,
 					&freqs_len))
 		return dbus_error_invalid_args(message);
@@ -204,11 +477,33 @@ static struct l_dbus_message *dpp_dbus_start_enrollee=
(struct l_dbus *dbus,
 					netdev_get_address(dpp->netdev), freqs,
 					freqs_len, info, host);
 =

+	dpp->state =3D DPP_STATE_PRESENCE;
+
 	l_debug("DPP Start Enrollee: %s", dpp->uri);
 =

 	l_dbus_property_changed(dbus_get_bus(), netdev_get_path(dpp->netdev),
 					IWD_DPP_INTERFACE, "Uri");
 =

+	/*
+	 * Going off spec here. If the user requests specific frequencies only
+	 * sit on those channels for presence announcements. This addresses
+	 * issues when a large channel list is built up. Any more than a few
+	 * (one is best) channels results in horrible performance.
+	 */
+	if (freqs)
+		dpp_start_presence_announcements(dpp, freqs, freqs_len);
+	else {
+		/*
+		 * TODO: A main.conf option could be used to force the full
+		 * presence procedure, which would take into account any
+		 * matching AP frequencies, the default list, and any requested
+		 * over DBus. Again, as mentioned above, this probably is never
+		 * a good idea.
+		 */
+		l_free(freqs);
+		dpp_start_presence_scan(dpp);
+	}
+
 	return l_dbus_message_new_method_return(message);
 }
 =

@@ -259,6 +554,12 @@ static void dpp_destroy_interface(void *user_data)
 =

 static int dpp_init(void)
 {
+	nl80211 =3D l_genl_family_new(iwd_get_genl(), NL80211_GENL_NAME);
+	if (!nl80211) {
+		l_error("Failed to obtain nl80211");
+		return -EIO;
+	}
+
 	netdev_watch =3D netdev_watch_add(dpp_netdev_watch, NULL, NULL);
 =

 	l_dbus_register_interface(dbus_get_bus(), IWD_DPP_INTERFACE,
-- =

2.31.1

--===============1635117875260496779==--

