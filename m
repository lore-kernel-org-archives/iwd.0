Content-Type: multipart/mixed; boundary="===============8511224405842752946=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 06/11] dpp: send presence announcements on StartEnrollee
Date: Wed, 15 Dec 2021 09:58:09 -0800
Message-ID: <20211215175814.2467124-6-prestwoj@gmail.com>
In-Reply-To: 20211215175814.2467124-1-prestwoj@gmail.com

--===============8511224405842752946==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The presence procedure implemented is a far cry from what the spec
actually wants. There are two reason for this: a) the kernels offchannel
support is not at a level where it will work without rather annoying
work arounds, and b) doing the procedure outlined in the spec will
result in terrible discovery performance.

Because of this a simpler single channel announcement is done by default
and the full presence procedure is left out until/if it is needed.
---
 src/dpp.c | 242 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 242 insertions(+)

v3:
 * Removed old headers left from previous patch set
 * memdup freqs since its on the stack
 * Few other minor fixes

diff --git a/src/dpp.c b/src/dpp.c
index dbab71c1..13a1ed75 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -24,15 +24,32 @@
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
 #include "src/band.h"
+#include "src/frame-xchg.h"
+#include "src/offchannel.h"
+#include "src/wiphy.h"
+#include "src/ie.h"
+#include "src/iwd.h"
+#include "src/util.h"
 =

 static uint32_t netdev_watch;
+static struct l_genl_family *nl80211;
+static uint8_t broadcast[] =3D { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };
+
+enum dpp_state {
+	DPP_STATE_NOTHING,
+	DPP_STATE_PRESENCE,
+};
 =

 struct dpp_sm {
 	struct netdev *netdev;
@@ -48,14 +65,119 @@ struct dpp_sm {
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
+	struct iovec iov[2];
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
 	dpp->curve =3D l_ecc_curve_from_ike_group(19);
 	dpp->key_len =3D l_ecc_curve_get_scalar_bytes(dpp->curve);
 	dpp->nonce_len =3D dpp_nonce_len_from_key_len(dpp->key_len);
@@ -93,12 +215,22 @@ static void dpp_reset(struct dpp_sm *dpp)
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

@@ -124,6 +256,98 @@ static void dpp_netdev_watch(struct netdev *netdev,
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
+ * in quite terrible DPP performance anyways.
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
+		dpp->freqs =3D l_memdup(limit_freqs, sizeof(uint32_t) * limit_len);
+		dpp->freqs_len =3D limit_len;
+	} else
+		dpp->freqs =3D dpp_add_default_channels(dpp, &dpp->freqs_len);
+
+	dpp->dwell =3D max_roc;
+	dpp->freqs_idx =3D 0;
+	dpp->current_freq =3D dpp->freqs[0];
+
+	dpp->offchannel_id =3D offchannel_start(netdev_get_wdev_id(dpp->netdev),
+			dpp->current_freq, dpp->dwell, dpp_roc_started,
+			dpp, dpp_presence_timeout);
+}
+
 static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
@@ -132,12 +356,24 @@ static struct l_dbus_message *dpp_dbus_start_enrollee=
(struct l_dbus *dbus,
 	uint32_t freq =3D band_channel_to_freq(6, BAND_FREQ_2_4_GHZ);
 	struct l_dbus_message *reply;
 =

+	if (dpp->state !=3D DPP_STATE_NOTHING)
+		return dbus_error_busy(message);
+
 	dpp->uri =3D dpp_generate_uri(dpp->pub_asn1, dpp->pub_asn1_len, 2,
 					netdev_get_address(dpp->netdev), &freq,
 					1, NULL, NULL);
 =

+	dpp->state =3D DPP_STATE_PRESENCE;
+
 	l_debug("DPP Start Enrollee: %s", dpp->uri);
 =

+	/*
+	 * Going off spec here. Select a single channel to send presence
+	 * announcements on. This will be advertised in the URI. The full
+	 * presence procedure can be implemented if it is ever needed.
+	 */
+	dpp_start_presence_announcements(dpp, &freq, 1);
+
 	reply =3D l_dbus_message_new_method_return(message);
 =

 	l_dbus_message_set_arguments(reply, "s", dpp->uri);
@@ -173,6 +409,12 @@ static void dpp_destroy_interface(void *user_data)
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

--===============8511224405842752946==--

