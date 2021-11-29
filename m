Content-Type: multipart/mixed; boundary="===============4689722192850857781=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 5/6] treewide: update scan utility usage to use band_*
Date: Mon, 29 Nov 2021 15:12:59 -0800
Message-ID: <20211129231300.108873-5-prestwoj@gmail.com>
In-Reply-To: 20211129231300.108873-1-prestwoj@gmail.com

--===============4689722192850857781==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ap.c      |  9 +++++----
 src/netdev.c  |  2 +-
 src/p2p.c     | 35 ++++++++++++++++++-----------------
 src/rrm.c     | 11 ++++++-----
 src/scan.c    | 24 ++++++++++++------------
 src/station.c | 15 ++++++++-------
 src/wiphy.c   | 12 ++++++------
 src/wsc.c     | 21 +++++++++++----------
 8 files changed, 67 insertions(+), 62 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 1cbd1262..32e45865 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -57,6 +57,7 @@
 #include "src/ap.h"
 #include "src/storage.h"
 #include "src/diagnostic.h"
+#include "src/band.h"
 =

 struct ap_state {
 	struct netdev *netdev;
@@ -895,7 +896,7 @@ static uint32_t ap_send_mgmt_frame(struct ap_state *ap,
 					frame_xchg_cb_t callback,
 					void *user_data)
 {
-	uint32_t ch_freq =3D scan_channel_to_freq(ap->channel, SCAN_BAND_2_4_GHZ);
+	uint32_t ch_freq =3D band_channel_to_freq(ap->channel, BAND_FREQ_2_4_GHZ);
 	uint64_t wdev_id =3D netdev_get_wdev_id(ap->netdev);
 	struct iovec iov[2];
 =

@@ -2318,7 +2319,7 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struc=
t ap_state *ap)
 	uint32_t nl_akm =3D CRYPTO_AKM_PSK;
 	uint32_t wpa_version =3D NL80211_WPA_VERSION_2;
 	uint32_t auth_type =3D NL80211_AUTHTYPE_OPEN_SYSTEM;
-	uint32_t ch_freq =3D scan_channel_to_freq(ap->channel, SCAN_BAND_2_4_GHZ);
+	uint32_t ch_freq =3D band_channel_to_freq(ap->channel, BAND_FREQ_2_4_GHZ);
 	uint32_t ch_width =3D NL80211_CHAN_WIDTH_20;
 	unsigned int i;
 =

@@ -3066,8 +3067,8 @@ static int ap_load_config(struct ap_state *ap, const =
struct l_settings *config,
 =

 		if (!l_settings_get_uint(config, "General", "Channel",
 						&uintval) ||
-				!scan_channel_to_freq(uintval,
-							SCAN_BAND_2_4_GHZ)) {
+				!band_channel_to_freq(uintval,
+							BAND_FREQ_2_4_GHZ)) {
 			l_error("AP Channel value unsupported");
 			return -EINVAL;
 		}
diff --git a/src/netdev.c b/src/netdev.c
index e35a8b82..4662705b 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4188,7 +4188,7 @@ int netdev_join_adhoc(struct netdev *netdev, const ch=
ar *ssid,
 {
 	struct l_genl_msg *cmd;
 	uint32_t ifindex =3D netdev->index;
-	uint32_t ch_freq =3D scan_channel_to_freq(6, SCAN_BAND_2_4_GHZ);
+	uint32_t ch_freq =3D band_channel_to_freq(6, BAND_FREQ_2_4_GHZ);
 	uint32_t ch_type =3D NL80211_CHAN_HT20;
 =

 	if (netdev->type !=3D NL80211_IFTYPE_ADHOC) {
diff --git a/src/p2p.c b/src/p2p.c
index 3ae28edd..65471f09 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -61,6 +61,7 @@
 #include "src/netconfig.h"
 #include "src/ap.h"
 #include "src/p2p.h"
+#include "src/band.h"
 =

 struct p2p_device {
 	uint64_t wdev_id;
@@ -804,7 +805,7 @@ static void p2p_peer_frame_xchg(struct p2p_peer *peer, =
struct iovec *tx_body,
 	memcpy(frame + 1, tx_body, sizeof(struct iovec) * iov_cnt);
 =

 	freq =3D own_channel ?
-		scan_channel_to_freq(dev->listen_channel, SCAN_BAND_2_4_GHZ) :
+		band_channel_to_freq(dev->listen_channel, BAND_FREQ_2_4_GHZ) :
 		peer->bss->frequency;
 =

 	va_start(args, cb);
@@ -2094,14 +2095,14 @@ static void p2p_add_freq_func(uint32_t freq, void *=
user_data)
 {
 	struct p2p_channel_entries *channel_entry =3D user_data;
 	uint8_t channel;
-	enum scan_band band;
+	enum band_freq band;
 =

 	if (channel_entry->n_channels >=3D MAX_CHANNELS)
 		return;
 =

-	channel =3D scan_freq_to_channel(freq, &band);
+	channel =3D band_freq_to_channel(freq, &band);
 =

-	if (band !=3D scan_oper_class_to_band((const uint8_t *) "XX\x4",
+	if (band !=3D band_oper_class_to_band((const uint8_t *) "XX\x4",
 						channel_entry->oper_class))
 		return;
 =

@@ -2221,10 +2222,10 @@ static bool p2p_go_negotiation_confirm_cb(const str=
uct mmpdu_header *mpdu,
 		 */
 		p2p_device_interface_create(dev);
 	} else {
-		enum scan_band band =3D scan_oper_class_to_band(
+		enum band_freq band =3D band_oper_class_to_band(
 			(const uint8_t *) info.operating_channel.country,
 			info.operating_channel.oper_class);
-		uint32_t frequency =3D scan_channel_to_freq(
+		uint32_t frequency =3D band_channel_to_freq(
 					info.operating_channel.channel_num,
 					band);
 =

@@ -2590,7 +2591,7 @@ static bool p2p_go_negotiation_resp_cb(const struct m=
mpdu_header *mpdu,
 	int r;
 	struct iovec iov[16];
 	int iov_len =3D 0;
-	enum scan_band band;
+	enum band_freq band;
 	uint32_t frequency;
 =

 	l_debug("");
@@ -2743,10 +2744,10 @@ static bool p2p_go_negotiation_resp_cb(const struct=
 mmpdu_header *mpdu,
 		memcpy(&confirm_info.group_id, &dev->go_group_id,
 			sizeof(struct p2p_group_id_attr));
 	} else {
-		band =3D scan_oper_class_to_band(
+		band =3D band_oper_class_to_band(
 			(const uint8_t *) resp_info.operating_channel.country,
 			resp_info.operating_channel.oper_class);
-		frequency =3D scan_channel_to_freq(
+		frequency =3D band_channel_to_freq(
 					resp_info.operating_channel.channel_num,
 					band);
 		if (!frequency) {
@@ -3444,8 +3445,8 @@ static void p2p_device_roc_start(struct p2p_device *d=
ev)
 	 * channel than on any other channel and then we listen for a
 	 * potential GO Negotiation restart on our listen channel.
 	 */
-	listen_freq =3D scan_channel_to_freq(dev->listen_channel,
-						SCAN_BAND_2_4_GHZ);
+	listen_freq =3D band_channel_to_freq(dev->listen_channel,
+						BAND_FREQ_2_4_GHZ);
 =

 	msg =3D l_genl_msg_new_sized(NL80211_CMD_REMAIN_ON_CHANNEL, 64);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_WDEV, 8, &dev->wdev_id);
@@ -3809,7 +3810,7 @@ static bool p2p_device_scan_start(struct p2p_device *=
dev)
 =

 	for (i =3D 0; i < L_ARRAY_SIZE(channels_social); i++) {
 		int chan =3D channels_social[i];
-		uint32_t freq =3D scan_channel_to_freq(chan, SCAN_BAND_2_4_GHZ);
+		uint32_t freq =3D band_channel_to_freq(chan, BAND_FREQ_2_4_GHZ);
 =

 		scan_freq_set_add(params.freqs, freq);
 	}
@@ -3826,7 +3827,7 @@ static bool p2p_device_scan_start(struct p2p_device *=
dev)
 	for (i =3D 0; i < dev->chans_per_scan; i++) {
 		int idx =3D dev->scan_chan_idx++;
 		int chan =3D channels_scan_2_4_other[idx];
-		uint32_t freq =3D scan_channel_to_freq(chan, SCAN_BAND_2_4_GHZ);
+		uint32_t freq =3D band_channel_to_freq(chan, BAND_FREQ_2_4_GHZ);
 =

 		if (dev->scan_chan_idx >=3D
 				L_ARRAY_SIZE(channels_scan_2_4_other)) {
@@ -3997,7 +3998,7 @@ static void p2p_device_send_probe_resp(struct p2p_dev=
ice *dev,
 =

 	iov[iov_len].iov_base =3D NULL;
 =

-	freq =3D scan_channel_to_freq(dev->listen_channel, SCAN_BAND_2_4_GHZ);
+	freq =3D band_channel_to_freq(dev->listen_channel, BAND_FREQ_2_4_GHZ);
 	frame_xchg_start(dev->wdev_id, iov, freq, 0, 0, false, 0,
 				p2p_probe_resp_done, dev, NULL, NULL);
 	l_debug("Probe Response tx queued");
@@ -4019,7 +4020,7 @@ static void p2p_device_probe_cb(const struct mmpdu_he=
ader *mpdu,
 	ssize_t wsc_len;
 	struct scan_bss *bss;
 	struct p2p_channel_attr *channel;
-	enum scan_band band;
+	enum band_freq band;
 	uint32_t frequency;
 	bool from_conn_peer;
 =

@@ -4082,9 +4083,9 @@ static void p2p_device_probe_cb(const struct mmpdu_he=
ader *mpdu,
 	else
 		goto p2p_free;
 =

-	band =3D scan_oper_class_to_band((const uint8_t *) channel->country,
+	band =3D band_oper_class_to_band((const uint8_t *) channel->country,
 					channel->oper_class);
-	frequency =3D scan_channel_to_freq(channel->channel_num, band);
+	frequency =3D band_channel_to_freq(channel->channel_num, band);
 	if (!frequency)
 		goto p2p_free;
 =

diff --git a/src/rrm.c b/src/rrm.c
index cb1660c6..d1c7029d 100644
--- a/src/rrm.c
+++ b/src/rrm.c
@@ -41,6 +41,7 @@
 #include "src/nl80211util.h"
 #include "src/wiphy.h"
 #include "src/frame-xchg.h"
+#include "src/band.h"
 =

 #include "linux/nl80211.h"
 =

@@ -278,7 +279,7 @@ static size_t build_report_for_bss(struct rrm_beacon_re=
q_info *beacon,
 	struct rrm_beacon_report *report =3D (struct rrm_beacon_report *) to;
 =

 	report->oper_class =3D beacon->oper_class;
-	report->channel =3D scan_freq_to_channel(bss->frequency, NULL);
+	report->channel =3D band_freq_to_channel(bss->frequency, NULL);
 	report->scan_start_time =3D L_CPU_TO_LE64(beacon->scan_start_time);
 	report->duration =3D L_CPU_TO_LE16(beacon->duration);
 	report->frame_info =3D rrm_phy_type(bss);
@@ -310,7 +311,7 @@ static size_t build_report_for_bss(struct rrm_beacon_re=
q_info *beacon,
 static bool bss_in_request_range(struct rrm_beacon_req_info *beacon,
 					struct scan_bss *bss)
 {
-	uint8_t channel =3D scan_freq_to_channel(bss->frequency, NULL);
+	uint8_t channel =3D band_freq_to_channel(bss->frequency, NULL);
 =

 	/* Must be a table measurement */
 	if (beacon->channel =3D=3D 0 || beacon->channel =3D=3D 255)
@@ -436,10 +437,10 @@ static void rrm_handle_beacon_scan(struct rrm_state *=
rrm,
 		.duration =3D beacon->duration,
 		.duration_mandatory =3D test_bit(&beacon->info.mode, 4),
 	};
-	enum scan_band band =3D scan_oper_class_to_band(NULL, beacon->oper_class);
+	enum band_freq band =3D band_oper_class_to_band(NULL, beacon->oper_class);
 	uint32_t freq;
 =

-	freq =3D scan_channel_to_freq(beacon->channel, band);
+	freq =3D band_channel_to_freq(beacon->channel, band);
 	scan_freq_set_add(freqs, freq);
 =

 	if (passive)
@@ -485,7 +486,7 @@ static bool rrm_verify_beacon_request(const uint8_t *re=
quest, size_t len)
 	}
 =

 	/* Check this is a valid operating class */
-	if (!scan_oper_class_to_band(NULL, request[0]))
+	if (!band_oper_class_to_band(NULL, request[0]))
 		return false;
 =

 	return true;
diff --git a/src/scan.c b/src/scan.c
index 1c80dd65..a30816cc 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -2233,18 +2233,18 @@ void scan_freq_set_free(struct scan_freq_set *freqs)
 =

 bool scan_freq_set_add(struct scan_freq_set *freqs, uint32_t freq)
 {
-	enum scan_band band;
+	enum band_freq band;
 	uint8_t channel;
 =

-	channel =3D scan_freq_to_channel(freq, &band);
+	channel =3D band_freq_to_channel(freq, &band);
 	if (!channel)
 		return false;
 =

 	switch (band) {
-	case SCAN_BAND_2_4_GHZ:
+	case BAND_FREQ_2_4_GHZ:
 		freqs->channels_2ghz |=3D 1 << (channel - 1);
 		return true;
-	case SCAN_BAND_5_GHZ:
+	case BAND_FREQ_5_GHZ:
 		return l_uintset_put(freqs->channels_5ghz, channel);
 	}
 =

@@ -2253,17 +2253,17 @@ bool scan_freq_set_add(struct scan_freq_set *freqs,=
 uint32_t freq)
 =

 bool scan_freq_set_contains(const struct scan_freq_set *freqs, uint32_t fr=
eq)
 {
-	enum scan_band band;
+	enum band_freq band;
 	uint8_t channel;
 =

-	channel =3D scan_freq_to_channel(freq, &band);
+	channel =3D band_freq_to_channel(freq, &band);
 	if (!channel)
 		return false;
 =

 	switch (band) {
-	case SCAN_BAND_2_4_GHZ:
+	case BAND_FREQ_2_4_GHZ:
 		return freqs->channels_2ghz & (1 << (channel - 1));
-	case SCAN_BAND_5_GHZ:
+	case BAND_FREQ_5_GHZ:
 		return l_uintset_contains(freqs->channels_5ghz, channel);
 	}
 =

@@ -2276,12 +2276,12 @@ uint32_t scan_freq_set_get_bands(struct scan_freq_s=
et *freqs)
 	uint32_t max;
 =

 	if (freqs->channels_2ghz)
-		bands |=3D SCAN_BAND_2_4_GHZ;
+		bands |=3D BAND_FREQ_2_4_GHZ;
 =

 	max =3D l_uintset_get_max(freqs->channels_5ghz);
 =

 	if (l_uintset_find_min(freqs->channels_5ghz) <=3D max)
-		bands |=3D SCAN_BAND_5_GHZ;
+		bands |=3D BAND_FREQ_5_GHZ;
 =

 	return bands;
 }
@@ -2320,7 +2320,7 @@ static void scan_channels_5ghz_frequency(uint32_t cha=
nnel, void *user_data)
 	const struct channels_5ghz_foreach_data *channels_5ghz_data =3D user_data;
 	uint32_t freq;
 =

-	freq =3D scan_channel_to_freq(channel, SCAN_BAND_5_GHZ);
+	freq =3D band_channel_to_freq(channel, BAND_FREQ_5_GHZ);
 =

 	channels_5ghz_data->func(freq, channels_5ghz_data->user_data);
 }
@@ -2346,7 +2346,7 @@ void scan_freq_set_foreach(const struct scan_freq_set=
 *freqs,
 =

 	for (channel =3D 1; channel <=3D 14; channel++) {
 		if (freqs->channels_2ghz & (1 << (channel - 1))) {
-			freq =3D scan_channel_to_freq(channel, SCAN_BAND_2_4_GHZ);
+			freq =3D band_channel_to_freq(channel, BAND_FREQ_2_4_GHZ);
 =

 			func(freq, user_data);
 		}
diff --git a/src/station.c b/src/station.c
index 245fd780..173b944d 100644
--- a/src/station.c
+++ b/src/station.c
@@ -58,6 +58,7 @@
 #include "src/diagnostic.h"
 #include "src/frame-xchg.h"
 #include "src/sysfs.h"
+#include "src/band.h"
 =

 static struct l_queue *station_list;
 static uint32_t netdev_watch;
@@ -1646,9 +1647,9 @@ static int station_roam_scan(struct station *station,
 				struct scan_freq_set *freq_set);
 =

 static uint32_t station_freq_from_neighbor_report(const uint8_t *country,
-		struct ie_neighbor_report_info *info, enum scan_band *out_band)
+		struct ie_neighbor_report_info *info, enum band_freq *out_band)
 {
-	enum scan_band band;
+	enum band_freq band;
 	uint32_t freq;
 =

 	if (info->oper_class =3D=3D 0) {
@@ -1660,9 +1661,9 @@ static uint32_t station_freq_from_neighbor_report(con=
st uint8_t *country,
 		 * use channels in two disjoint ranges.
 		 */
 		if (info->channel_num >=3D 1 && info->channel_num <=3D 14)
-			band =3D SCAN_BAND_2_4_GHZ;
+			band =3D BAND_FREQ_2_4_GHZ;
 		else if (info->channel_num >=3D 36 && info->channel_num <=3D 169)
-			band =3D SCAN_BAND_5_GHZ;
+			band =3D BAND_FREQ_5_GHZ;
 		else {
 			l_debug("Ignored: 0 oper class with an unusual "
 				"channel number");
@@ -1670,7 +1671,7 @@ static uint32_t station_freq_from_neighbor_report(con=
st uint8_t *country,
 			return 0;
 		}
 	} else {
-		band =3D scan_oper_class_to_band(country, info->oper_class);
+		band =3D band_oper_class_to_band(country, info->oper_class);
 		if (!band) {
 			l_debug("Ignored: unsupported oper class");
 =

@@ -1678,7 +1679,7 @@ static uint32_t station_freq_from_neighbor_report(con=
st uint8_t *country,
 		}
 	}
 =

-	freq =3D scan_channel_to_freq(info->channel_num, band);
+	freq =3D band_channel_to_freq(info->channel_num, band);
 	if (!freq) {
 		l_debug("Ignored: unsupported channel");
 =

@@ -1711,7 +1712,7 @@ static void parse_neighbor_report(struct station *sta=
tion,
 	while (ie_tlv_iter_next(&iter)) {
 		struct ie_neighbor_report_info info;
 		uint32_t freq;
-		enum scan_band band;
+		enum band_freq band;
 		const uint8_t *cc =3D NULL;
 =

 		if (ie_tlv_iter_get_tag(&iter) !=3D IE_TYPE_NEIGHBOR_REPORT)
diff --git a/src/wiphy.c b/src/wiphy.c
index 339e13ca..bb1f9824 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -431,10 +431,10 @@ uint32_t wiphy_get_supported_bands(struct wiphy *wiph=
y)
 	uint32_t bands =3D 0;
 =

 	if (wiphy->band_2g)
-		bands |=3D SCAN_BAND_2_4_GHZ;
+		bands |=3D BAND_FREQ_2_4_GHZ;
 =

 	if (wiphy->band_5g)
-		bands |=3D SCAN_BAND_5_GHZ;
+		bands |=3D BAND_FREQ_5_GHZ;
 =

 	return bands;
 }
@@ -777,16 +777,16 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 	const void *ht_capabilities =3D NULL;
 	const void *ht_operation =3D NULL;
 	const struct band *bandp;
-	enum scan_band band;
+	enum band_freq band;
 =

-	if (scan_freq_to_channel(bss->frequency, &band) =3D=3D 0)
+	if (band_freq_to_channel(bss->frequency, &band) =3D=3D 0)
 		return -ENOTSUP;
 =

 	switch (band) {
-	case SCAN_BAND_2_4_GHZ:
+	case BAND_FREQ_2_4_GHZ:
 		bandp =3D wiphy->band_2g;
 		break;
-	case SCAN_BAND_5_GHZ:
+	case BAND_FREQ_5_GHZ:
 		bandp =3D wiphy->band_5g;
 		break;
 	default:
diff --git a/src/wsc.c b/src/wsc.c
index 2618497a..f7b9d8c9 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -46,6 +46,7 @@
 #include "src/iwd.h"
 #include "src/network.h"
 #include "src/wsc.h"
+#include "src/band.h"
 =

 #define WALK_TIME 120
 =

@@ -299,14 +300,14 @@ static void wsc_enrollee_handshake_event(struct hands=
hake_state *hs,
 =

 static inline enum wsc_rf_band freq_to_rf_band(uint32_t freq)
 {
-	enum scan_band band;
+	enum band_freq band;
 =

-	scan_freq_to_channel(freq, &band);
+	band_freq_to_channel(freq, &band);
 =

 	switch (band) {
-	case SCAN_BAND_2_4_GHZ:
+	case BAND_FREQ_2_4_GHZ:
 		return WSC_RF_BAND_2_4_GHZ;
-	case SCAN_BAND_5_GHZ:
+	case BAND_FREQ_5_GHZ:
 		return WSC_RF_BAND_5_0_GHZ;
 	}
 =

@@ -731,7 +732,7 @@ static bool push_button_scan_results(int err, struct l_=
queue *bss_list,
 	for (bss_entry =3D l_queue_get_entries(bss_list); bss_entry;
 				bss_entry =3D bss_entry->next) {
 		struct scan_bss *bss =3D bss_entry->data;
-		enum scan_band band;
+		enum band_freq band;
 		int err;
 =

 		l_debug("bss '%s' with SSID: %s, freq: %u",
@@ -762,10 +763,10 @@ static bool push_button_scan_results(int err, struct =
l_queue *bss_list,
 				WSC_DEVICE_PASSWORD_ID_PUSH_BUTTON)
 			continue;
 =

-		scan_freq_to_channel(bss->frequency, &band);
+		band_freq_to_channel(bss->frequency, &band);
 =

 		switch (band) {
-		case SCAN_BAND_2_4_GHZ:
+		case BAND_FREQ_2_4_GHZ:
 			if (bss_2g) {
 				l_debug("2G Session overlap error");
 				goto session_overlap;
@@ -775,7 +776,7 @@ static bool push_button_scan_results(int err, struct l_=
queue *bss_list,
 			memcpy(uuid_2g, probe_response.uuid_e, 16);
 			break;
 =

-		case SCAN_BAND_5_GHZ:
+		case BAND_FREQ_5_GHZ:
 			if (bss_5g) {
 				l_debug("5G Session overlap error");
 				goto session_overlap;
@@ -994,9 +995,9 @@ static bool wsc_initiate_scan(struct wsc_station_dbus *=
wsc,
 	req.primary_device_type.subcategory =3D 0;
 =

 	bands =3D wiphy_get_supported_bands(wiphy);
-	if (bands & SCAN_BAND_2_4_GHZ)
+	if (bands & BAND_FREQ_2_4_GHZ)
 		req.rf_bands |=3D WSC_RF_BAND_2_4_GHZ;
-	if (bands & SCAN_BAND_5_GHZ)
+	if (bands & BAND_FREQ_5_GHZ)
 		req.rf_bands |=3D WSC_RF_BAND_5_0_GHZ;
 =

 	req.association_state =3D WSC_ASSOCIATION_STATE_NOT_ASSOCIATED;
-- =

2.31.1

--===============4689722192850857781==--

