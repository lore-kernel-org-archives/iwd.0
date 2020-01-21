Content-Type: multipart/mixed; boundary="===============8846665198256943529=="
MIME-Version: 1.0
From: Torstein =?unknown-8bit?q?Huseb=C3=B8?= <torstein@huseboe.net>
Subject: [PATCH] Treewide: fix typos
Date: Tue, 21 Jan 2020 07:21:38 +0100
Message-ID: <20200121062138.21074-1-torstein@huseboe.net>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8846665198256943529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/testutil.py | 2 +-
 doc/access-point-api.txt   | 2 +-
 doc/adhoc-api.txt          | 2 +-
 doc/features.txt           | 2 +-
 doc/network-api.txt        | 2 +-
 doc/station-api.txt        | 2 +-
 doc/wpa-auth.txt           | 2 +-
 monitor/nlmon.c            | 6 +++---
 monitor/pcap.c             | 2 +-
 plugins/sim_hardcoded.c    | 2 +-
 src/adhoc.c                | 2 +-
 src/anqputil.c             | 4 ++--
 src/eap-mschapv2.c         | 2 +-
 src/eap-pwd.c              | 2 +-
 src/eap-sim.c              | 2 +-
 src/eap-tls-common.c       | 2 +-
 src/eap-wsc.c              | 2 +-
 src/erp.c                  | 2 +-
 src/handshake.c            | 4 ++--
 src/hotspot.c              | 2 +-
 src/ie.c                   | 4 ++--
 src/manager.c              | 4 ++--
 src/netdev.c               | 6 +++---
 src/netdev.h               | 2 +-
 src/network.c              | 2 +-
 src/sae.c                  | 2 +-
 src/scan.c                 | 2 +-
 src/station.c              | 6 +++---
 src/wsc.c                  | 4 ++--
 tools/hwsim.c              | 2 +-
 unit/test-cmac-aes.c       | 4 ++--
 unit/test-ie.c             | 8 ++++----
 unit/test-sae.c            | 4 ++--
 33 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/autotests/util/testutil.py b/autotests/util/testutil.py
index e02a299417..aaa4e7e1b1 100644
--- a/autotests/util/testutil.py
+++ b/autotests/util/testutil.py
@@ -1,5 +1,5 @@
 #! /usr/bin/python3
-# Rougly based on wpa_supplicant's mac80211_hwsim/tools/hwsim_test.c utili=
ty.
+# Roughly based on wpa_supplicant's mac80211_hwsim/tools/hwsim_test.c util=
ity.
 import socket
 import fcntl
 import struct
diff --git a/doc/access-point-api.txt b/doc/access-point-api.txt
index 11235f8308..9ee06baaa4 100644
--- a/doc/access-point-api.txt
+++ b/doc/access-point-api.txt
@@ -1,4 +1,4 @@
-Access Point hiearchy
+Access Point hierarchy
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

 Service		net.connman.iwd
diff --git a/doc/adhoc-api.txt b/doc/adhoc-api.txt
index a60e351da8..8c4013f6b6 100644
--- a/doc/adhoc-api.txt
+++ b/doc/adhoc-api.txt
@@ -1,4 +1,4 @@
-Ad-Hoc hiearchy
+Ad-Hoc hierarchy
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

 Service		net.connman.iwd
diff --git a/doc/features.txt b/doc/features.txt
index 47c86e9e30..a5f35eaf00 100644
--- a/doc/features.txt
+++ b/doc/features.txt
@@ -71,7 +71,7 @@ on open networks, by using ECDH to negotiate a PMK.
 =

 - IWD supports SAE (Simultaneous Authentication of Equals). SAE is require=
d for
 the WPA3 certification. SAE uses a Diffie-Hellman key exchange to produce =
the
-PMK thats used in the 4-way handshake. Support for hybrid WPA3/WPA2 AP's is
+PMK that's used in the 4-way handshake. Support for hybrid WPA3/WPA2 AP's =
is
 also implemented, where WPA3 is preferred.
 =

 Wireless monitor
diff --git a/doc/network-api.txt b/doc/network-api.txt
index 7d059f8e5f..77536e28c1 100644
--- a/doc/network-api.txt
+++ b/doc/network-api.txt
@@ -49,4 +49,4 @@ Properties	string Name [readonly]
 			Contains the path of the KnownNetwork object
 			corresponding to this Network.  If the network
 			is not provisioned or has not been connected to
-			before, the property is ommitted.
+			before, the property is omitted.
diff --git a/doc/station-api.txt b/doc/station-api.txt
index 2d0fa08a80..b2131890e5 100644
--- a/doc/station-api.txt
+++ b/doc/station-api.txt
@@ -120,7 +120,7 @@ Methods		void Scan()
 			order.  The number and distance between requested
 			threshold values is a compromise between resolution
 			and the frequency of system wakeups and
-			context-switches that are going to be occuring to
+			context-switches that are going to be occurring to
 			update the client's signal meter.  Only one agent
 			can be registered at any time.
 =

diff --git a/doc/wpa-auth.txt b/doc/wpa-auth.txt
index 731e882b84..8d179f7682 100644
--- a/doc/wpa-auth.txt
+++ b/doc/wpa-auth.txt
@@ -91,7 +91,7 @@ Overall Process
   AP.
 =

 - Once Message 3 is received from the AP, the STA sanity checks certain
-  paremeters (Key Replay Counter, ANonce, MIC).  The RSN received from the=
 AP
+  parameters (Key Replay Counter, ANonce, MIC).  The RSN received from the=
 AP
   is also checked against the one received in Message 3.  If everything ch=
ecks
   out, then Message 4 is constructed and sent to the AP.
 =

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 6b0afef8a4..77f5dda429 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -2994,7 +2994,7 @@ static void print_p2p_status(unsigned int level, cons=
t char *label,
 		{ P2P_STATUS_FAIL_LIMIT_REACHED, "Fail; limit reached" },
 		{ P2P_STATUS_FAIL_INVALID_PARAMS, "Fail; invalid parameters" },
 		{ P2P_STATUS_FAIL_UNABLE_TO_ACCOMMODATE_REQUEST, "Fail; unable "
-			"to accomodate request" },
+			"to accommodate request" },
 		{ P2P_STATUS_FAIL_PREV_PROTOCOL_ERROR, "Fail; previous protocol"
 			" error, or distruptive behavior" },
 		{ P2P_STATUS_FAIL_NO_COMMON_CHANNELS, "Fail; no common "
@@ -3519,7 +3519,7 @@ static void print_p2p_advertised_svc_info(unsigned in=
t level, const char *label,
 =

 		print_attr(level, "%s:", label);
 =

-		print_attr(level, "Servce advertisement: ID 0x%08x",
+		print_attr(level, "Service advertisement: ID 0x%08x",
 				l_get_le32(bytes + 0));
 		print_wsc_utf8_string(level + 1, "Service Name",
 					bytes + 6, bytes[6], 255);
@@ -4096,7 +4096,7 @@ static void print_public_action_frame(unsigned int le=
vel, const uint8_t *body,
 		[22] =3D "HCCA TXOP Advertisement",
 		[23] =3D "HCCA TXOP Response",
 		[24] =3D "Public Key",
-		[25] =3D "Channel Availabilty Query",
+		[25] =3D "Channel Availability Query",
 		[26] =3D "Channel Schedule Management",
 		[27] =3D "Contact Verification Signal",
 		[28] =3D "GDD Enablement Request",
diff --git a/monitor/pcap.c b/monitor/pcap.c
index c5ca901529..fb29eea8e5 100644
--- a/monitor/pcap.c
+++ b/monitor/pcap.c
@@ -148,7 +148,7 @@ struct pcap *pcap_create(const char *pathname)
 	}
 =

 	if (len !=3D PCAP_HDR_SIZE) {
-		fprintf(stderr, "Written PCAP header size mimatch\n");
+		fprintf(stderr, "Written PCAP header size mismatch\n");
 		goto failed;
 	}
 =

diff --git a/plugins/sim_hardcoded.c b/plugins/sim_hardcoded.c
index e61404c960..463c39fe1d 100644
--- a/plugins/sim_hardcoded.c
+++ b/plugins/sim_hardcoded.c
@@ -51,7 +51,7 @@ static struct hardcoded_sim *sim;
  * to - result of XOR array
  * a - array 1
  * b - array 2
- * len - size of aray
+ * len - size of array
  */
 #define XOR(to, a, b, len) \
 	for (i =3D 0; i < len; i++) { \
diff --git a/src/adhoc.c b/src/adhoc.c
index 52164a0a1b..a8ff8c3a03 100644
--- a/src/adhoc.c
+++ b/src/adhoc.c
@@ -227,7 +227,7 @@ static struct eapol_sm *adhoc_new_sm(struct sta_state *=
sta, bool authenticator,
 =

 	handshake_state_set_event_func(hs, adhoc_handshake_event, sta);
 	handshake_state_set_ssid(hs, (void *)adhoc->ssid, strlen(adhoc->ssid));
-	/* we dont have the connecting peer rsn info, so just set ap =3D=3D own */
+	/* we don't have the connecting peer rsn info, so just set ap =3D=3D own =
*/
 	handshake_state_set_authenticator_ie(hs, bss_rsne);
 	handshake_state_set_supplicant_ie(hs, bss_rsne);
 	handshake_state_set_pmk(hs, adhoc->pmk, 32);
diff --git a/src/anqputil.c b/src/anqputil.c
index fdc3af5848..098185cfb4 100644
--- a/src/anqputil.c
+++ b/src/anqputil.c
@@ -148,9 +148,9 @@ char **anqp_parse_nai_realms(const unsigned char *anqp,=
 unsigned int len)
 		/*
 		 * The method list is a variable field, so the only way to
 		 * reliably increment anqp is by realm_len at the very end since
-		 * we dont know how many bytes parse_eap advanced (it does
+		 * we don't know how many bytes parse_eap advanced (it does
 		 * internal length checking so it should not overflow). We
-		 * cant incrementally advance anqp/len, hence the hardcoded
+		 * can't incrementally advance anqp/len, hence the hardcoded
 		 * length and pointer adjustments.
 		 */
 =

diff --git a/src/eap-mschapv2.c b/src/eap-mschapv2.c
index 61a97952f8..3ede349888 100644
--- a/src/eap-mschapv2.c
+++ b/src/eap-mschapv2.c
@@ -77,7 +77,7 @@ struct mschapv2_response {
 } __attribute__((packed));
 =

 /**
- * Generate the asymetric start keys from our mschapv2 master key for MPPE
+ * Generate the asymmetric start keys from our mschapv2 master key for MPPE
  * This function is specified in:
  * https://tools.ietf.org/html/draft-ietf-pppext-mschapv2-keys-02
  *
diff --git a/src/eap-pwd.c b/src/eap-pwd.c
index f1b019550a..74d0997f49 100644
--- a/src/eap-pwd.c
+++ b/src/eap-pwd.c
@@ -481,7 +481,7 @@ static void eap_pwd_handle_confirm(struct eap_state *ea=
p,
 =

 	/*
 	 * We just need to store clen/plen once. Since all these buffers are
-	 * created with enough bytes in mind we know these wont fail. Also, all
+	 * created with enough bytes in mind we know these won't fail. Also, all
 	 * scalar/point objects were created with the same curve, so it can be
 	 * safe to assume the return values will not change from what clen/plen
 	 * already are.
diff --git a/src/eap-sim.c b/src/eap-sim.c
index 6e97694742..b29211f65d 100644
--- a/src/eap-sim.c
+++ b/src/eap-sim.c
@@ -467,7 +467,7 @@ static void handle_challenge(struct eap_state *eap, con=
st uint8_t *pkt,
 		case EAP_SIM_AT_IV:
 		case EAP_SIM_AT_ENCR_DATA:
 		case EAP_SIM_AT_MAC:
-			/* need a case for these so the default wont get hit */
+			/* need a case for these so the default won't get hit */
 			break;
 =

 		default:
diff --git a/src/eap-tls-common.c b/src/eap-tls-common.c
index 698a4797d8..080e4f27dd 100644
--- a/src/eap-tls-common.c
+++ b/src/eap-tls-common.c
@@ -401,7 +401,7 @@ static int eap_tls_init_request_assembly(struct eap_sta=
te *eap,
 	len -=3D 4;
 =

 	if (!tls_msg_len || tls_msg_len > EAP_TLS_PDU_MAX_LEN) {
-		l_warn("%s: Fragmented pkt size is outside of alowed"
+		l_warn("%s: Fragmented pkt size is outside of allowed"
 				" boundaries [1, %u]", eap_get_method_name(eap),
 							EAP_TLS_PDU_MAX_LEN);
 =

diff --git a/src/eap-wsc.c b/src/eap-wsc.c
index 2466ccc604..9fa1405f10 100644
--- a/src/eap-wsc.c
+++ b/src/eap-wsc.c
@@ -986,7 +986,7 @@ static void eap_wsc_handle_request(struct eap_state *ea=
p,
 					wsc->rx_pdu_buf_len >
 							EAP_WSC_PDU_MAX_LEN) {
 				l_warn("Fragmented pkt size is outside of "
-					"alowed boundaries [1, %u]",
+					"allowed boundaries [1, %u]",
 					EAP_WSC_PDU_MAX_LEN);
 				return;
 			}
diff --git a/src/erp.c b/src/erp.c
index ab6a16f83b..cacd37d150 100644
--- a/src/erp.c
+++ b/src/erp.c
@@ -296,7 +296,7 @@ static bool erp_derive_emsk_name(const uint8_t *session=
_id, size_t session_len,
 /*
  * RFC 6696 - Section 4.1 and 4.3 - rRK and rIK derivation
  *
- * All reauth keys form a hiearchy, and all ultimately are derived from the
+ * All reauth keys form a hierarchy, and all ultimately are derived from t=
he
  * EMSK. All keys follow the rule:
  *
  * "The length of the <key> MUST be equal to the length of the parent key =
used
diff --git a/src/handshake.c b/src/handshake.c
index bb4663c793..86a6650d5e 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -145,8 +145,8 @@ static bool handshake_state_setup_own_ciphers(struct ha=
ndshake_state *s,
 	s->group_management_cipher =3D info->group_management_cipher;
 =

 	/*
-	 * Dont set MFP for OSEN otherwise EAPoL will attempt to negotiate a
-	 * iGTK which is not allowe for OSEN.
+	 * Don't set MFP for OSEN otherwise EAPoL will attempt to negotiate a
+	 * iGTK which is not allow for OSEN.
 	 */
 	if (!s->osen_ie)
 		s->mfp =3D info->mfpc;
diff --git a/src/hotspot.c b/src/hotspot.c
index 6a95757bc6..fb75ef1366 100644
--- a/src/hotspot.c
+++ b/src/hotspot.c
@@ -212,7 +212,7 @@ static const uint8_t *hotspot_match_roaming_consortium(
 						&rc3, &rc3_len) < 0)
 		return NULL;
 =

-	/* rc1 is guarenteed to be set if the above returns success */
+	/* rc1 is guaranteed to be set if the above returns success */
 	if (rc1_len =3D=3D config->rc_len && !memcmp(rc1, config->rc, rc1_len)) {
 		if (rc_len_out)
 			*rc_len_out =3D rc1_len;
diff --git a/src/ie.c b/src/ie.c
index 4390add54e..9b1127ce82 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -1585,7 +1585,7 @@ int ie_parse_bss_load_from_data(const uint8_t *data, =
uint8_t len,
 }
 =

 /*
- * We have to store this mapping since basic rates dont come with a conven=
ient
+ * We have to store this mapping since basic rates don't come with a conve=
nient
  * MCS index. Rates are stored as they are encoded in the Supported Rates =
IE.
  * This does not include non 802.11g data rates, e.g. 1/2/4Mbps. This data=
 was
  * taken from 802.11 Section 17.3.10.2 and Table 10-7.
@@ -1994,7 +1994,7 @@ static int ie_parse_vht_capability(struct ie_tlv_iter=
 *vht_iter,
 	 * combinations (width, MCS, NSS), saving the highest data rate we find.
 	 *
 	 * We could calculate a maximum data rate separately for TX/RX, but
-	 * since this is only used for BSS ranking, the minumum between the
+	 * since this is only used for BSS ranking, the minimum between the
 	 * two should be good enough.
 	 */
 	for (width =3D sizeof(vht_width_map[0]) - 1; width >=3D 0; width--) {
diff --git a/src/manager.c b/src/manager.c
index 4ad0f03c5f..a5de2842d9 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -275,7 +275,7 @@ static void manager_get_interface_cb(struct l_genl_msg =
*msg, void *user_data)
 		return;
 =

 	if (wiphy !=3D state->id) {
-		l_debug("Wiphy attribute mis-match, wanted: %u, got %u",
+		l_debug("Wiphy attribute mismatch, wanted: %u, got %u",
 				state->id, wiphy);
 		return;
 	}
@@ -515,7 +515,7 @@ static void manager_new_wiphy_event(struct l_genl_msg *=
msg)
 	/*
 	 * Until fixed, a NEW_WIPHY event will not include all the information
 	 * that may be available, but a dump will. Because of this we do both
-	 * GET_WIPHY/GET_INTERFACE, same as we would during initalization.
+	 * GET_WIPHY/GET_INTERFACE, same as we would during initialization.
 	 */
 	msg =3D l_genl_msg_new_sized(NL80211_CMD_GET_WIPHY, 128);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_SPLIT_WIPHY_DUMP, 0, NULL);
diff --git a/src/netdev.c b/src/netdev.c
index 0a287a4282..1fbf3d3b89 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -227,7 +227,7 @@ struct handshake_state *netdev_handshake_state_new(stru=
ct netdev *netdev)
 	nhs->netdev =3D netdev;
 	/*
 	 * Since GTK/IGTK are optional (NO_GROUP_TRAFFIC), we set them as
-	 * 'installed' upon initalization. If/When the gtk/igtk callback is
+	 * 'installed' upon initialization. If/When the gtk/igtk callback is
 	 * called they will get set to false until we have received a successful
 	 * callback from nl80211. From these callbacks we can check that all
 	 * the keys have been installed, and only then trigger the handshake
@@ -1536,7 +1536,7 @@ static void netdev_qos_map_cb(struct l_genl_msg *msg,=
 void *user_data)
  * to let the kernel know is to receive the IE, then give it right back...
  *
  * The kernel/driver/firmware *could* simply obtain this information as the
- * frame comes in and not require userspace to forward it back... but that=
s a
+ * frame comes in and not require userspace to forward it back... but that=
's a
  * battle for another day.
  */
 static void netdev_send_qos_map_set(struct netdev *netdev,
@@ -2401,7 +2401,7 @@ static int netdev_connect_common(struct netdev *netde=
v,
 	netdev->handshake =3D hs;
 	netdev->sm =3D sm;
 	netdev->frequency =3D bss->frequency;
-	netdev->cur_rssi_low =3D false; /* Gets udpated on the 1st CQM event */
+	netdev->cur_rssi_low =3D false; /* Gets updated on the 1st CQM event */
 	netdev->cur_rssi =3D bss->signal_strength / 100;
 	netdev_rssi_level_init(netdev);
 =

diff --git a/src/netdev.h b/src/netdev.h
index f87e7e494b..58b63fbd08 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -87,7 +87,7 @@ typedef void (*netdev_connect_cb_t)(struct netdev *netdev,
  * Notify function for netdev events. Depending on the event type, event_d=
ata
  * will have different meanings:
  *
- * NETDEV_EVENT_AUTHENTICATING - unsused
+ * NETDEV_EVENT_AUTHENTICATING - unused
  * NETDEV_EVENT_ASSOCIATING - unused
  * NETDEV_EVENT_LOST_BEACON - unused
  * NETDEV_EVENT_DISCONNECT_BY_AP - MMPDU_REASON_CODE
diff --git a/src/network.c b/src/network.c
index 29cd4e13c4..fe6ba867ba 100644
--- a/src/network.c
+++ b/src/network.c
@@ -552,7 +552,7 @@ int network_autoconnect(struct network *network, struct=
 scan_bss *bss)
 =

 	if (!wiphy_select_cipher(wiphy, rsn.pairwise_ciphers) ||
 			!wiphy_select_cipher(wiphy, rsn.group_cipher)) {
-		l_debug("Cipher mis-match");
+		l_debug("Cipher mismatch");
 		ret =3D -ENETUNREACH;
 		goto close_settings;
 	}
diff --git a/src/sae.c b/src/sae.c
index c247f5a492..6abbad5e61 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -354,7 +354,7 @@ static bool sae_build_commit(struct sae_sm *sm, const u=
int8_t *addr1,
 =

 	/*
 	 * Several cases require retransmitting the same commit message. The
-	 * anti-clogging code path requires this as well as the retransmition
+	 * anti-clogging code path requires this as well as the retransmission
 	 * timeout.
 	 */
 old_commit:
diff --git a/src/scan.c b/src/scan.c
index 97b37c689e..c3ae3f8bfc 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -879,7 +879,7 @@ static bool scan_parse_vendor_specific(struct scan_bss =
*bss, const void *data,
 =

 /*
  * Fully parses the Advertisement Protocol Element. The only thing being l=
ooked
- * for is the ANQP protocol ID, but this could be burried behind several o=
ther
+ * for is the ANQP protocol ID, but this could be buried behind several ot=
her
  * advertisement tuples so the entire IE may need to be parsed.
  */
 static bool scan_parse_advertisement_protocol(struct scan_bss *bss,
diff --git a/src/station.c b/src/station.c
index c60294238e..6ec7eb4bb6 100644
--- a/src/station.c
+++ b/src/station.c
@@ -678,7 +678,7 @@ static void station_handshake_event(struct handshake_st=
ate *hs,
 	case HANDSHAKE_EVENT_SETTING_KEYS_FAILED:
 	case HANDSHAKE_EVENT_EAP_NOTIFY:
 		/*
-		 * currently we dont care about any other events. The
+		 * currently we don't care about any other events. The
 		 * netdev_connect_cb will notify us when the connection is
 		 * complete.
 		 */
@@ -2068,7 +2068,7 @@ void station_ap_directed_roam(struct station *station,
 =

 =

 	if (req_mode & WNM_REQUEST_MODE_PREFERRED_CANDIDATE_LIST) {
-		l_debug("roam: AP sent a preffered candidate list");
+		l_debug("roam: AP sent a preferred candidate list");
 		station_neighbor_report_cb(station->netdev, 0, body + pos,
 				body_len - pos,station);
 	} else {
@@ -2162,7 +2162,7 @@ static bool station_retry_with_reason(struct station =
*station,
 					uint16_t reason_code)
 {
 	/*
-	 * We dont want to cause a retry and blacklist if the password was
+	 * We don't want to cause a retry and blacklist if the password was
 	 * incorrect. Otherwise we would just continue to fail.
 	 *
 	 * Other reason codes can be added here if its decided we want to
diff --git a/src/wsc.c b/src/wsc.c
index f90129f92d..393e8d8d7e 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -90,7 +90,7 @@ static struct l_dbus_message *wsc_error_walk_time_expired(
 	return l_dbus_message_new_error(msg,
 					IWD_WSC_INTERFACE ".WalkTimeExpired",
 					"No APs in PushButton mode found in "
-					"the alloted time");
+					"the allotted time");
 }
 =

 static struct l_dbus_message *wsc_error_time_expired(struct l_dbus_message=
 *msg)
@@ -98,7 +98,7 @@ static struct l_dbus_message *wsc_error_time_expired(stru=
ct l_dbus_message *msg)
 	return l_dbus_message_new_error(msg,
 					IWD_WSC_INTERFACE ".TimeExpired",
 					"No APs in PIN mode found in "
-					"the alloted time");
+					"the allotted time");
 }
 =

 static void wsc_enrollee_connect_cb(struct netdev *netdev,
diff --git a/tools/hwsim.c b/tools/hwsim.c
index 91963d545d..4dade8dc15 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -1353,7 +1353,7 @@ static bool interface_info_match_dst(const void *a, c=
onst void *b)
 /*
  * Process frames in a similar way to how the kernel built-in hwsim medium
  * does this, with an additional optimization for unicast frames and
- * additonal modifications to frames decided by user-configurable rules.
+ * additional modifications to frames decided by user-configurable rules.
  */
 static void process_frame(struct hwsim_frame *frame)
 {
diff --git a/unit/test-cmac-aes.c b/unit/test-cmac-aes.c
index 0de68bcdc0..365265f683 100644
--- a/unit/test-cmac-aes.c
+++ b/unit/test-cmac-aes.c
@@ -149,8 +149,8 @@ int main(int argc, char *argv[])
 =

 	l_test_add("/cmac-aes/Example 1", cmac_test, &example_1);
 	l_test_add("/cmac-aes/Example 2", cmac_test, &example_2);
-	l_test_add("/cmac-aes/Exmaple 3", cmac_test, &example_3);
-	l_test_add("/cmac-aes/Exmaple 4", cmac_test, &example_4);
+	l_test_add("/cmac-aes/Example 3", cmac_test, &example_3);
+	l_test_add("/cmac-aes/Example 4", cmac_test, &example_4);
 =

 done:
 	return l_test_run();
diff --git a/unit/test-ie.c b/unit/test-ie.c
index a7821045b5..6dd074b5b5 100644
--- a/unit/test-ie.c
+++ b/unit/test-ie.c
@@ -78,7 +78,7 @@ static const unsigned char beacon_frame[] =3D {
 	0xff, 0xff, 0xc8, 0xd7, 0x19, 0x39, 0xbe, 0x77,
 	0xc8, 0xd7, 0x19, 0x39, 0xbe, 0x77, 0x50, 0xa2,
 =

-	/* IEEE 802.11 wireless LAN managment frame
+	/* IEEE 802.11 wireless LAN management frame
 	 * - Fixed parameters (12 bytes)
 	 */
 	0x87, 0x81, 0x31, 0xe6, 0x29, 0x02, 0x00, 0x00,
@@ -742,11 +742,11 @@ int main(int argc, char *argv[])
 				ie_test_wpa_build_compact_info,
 				&ie_wpa_info_test_5);
 =

-	l_test_add("/ie/Concatentation/WSC/Test Case 1",
+	l_test_add("/ie/Concatenation/WSC/Test Case 1",
 				ie_test_concat_wsc, &ie_tlv_concat_test_data_1);
-	l_test_add("/ie/Concatentation/WSC/Test Case 2",
+	l_test_add("/ie/Concatenation/WSC/Test Case 2",
 				ie_test_concat_wsc, &ie_tlv_concat_test_data_2);
-	l_test_add("/ie/Concatentation/WSC/Test Case 3",
+	l_test_add("/ie/Concatenation/WSC/Test Case 3",
 				ie_test_concat_wsc, &ie_tlv_concat_test_data_3);
 =

 	l_test_add("/ie/Encapsulation/WSC/Test Case 1",
diff --git a/unit/test-sae.c b/unit/test-sae.c
index 71b0d6260a..2d984160f2 100644
--- a/unit/test-sae.c
+++ b/unit/test-sae.c
@@ -369,7 +369,7 @@ static void test_malformed_commit(const void *arg)
 =

 	len =3D setup_auth_frame(frame, aa, 1, 0, aa_commit, sizeof(aa_commit));
 =

-	/* dont send entire commit */
+	/* don't send entire commit */
 	assert(auth_proto_rx_authenticate(ap, (uint8_t *)frame, len - 20) !=3D 0);
 =

 	test_destruct(td);
@@ -394,7 +394,7 @@ static void test_malformed_confirm(const void *arg)
 	frame =3D alloca(sizeof(struct authenticate_frame) + sizeof(aa_confirm));
 	len =3D setup_auth_frame(frame, aa, 2, 0, aa_confirm, sizeof(aa_confirm));
 =

-	/* dont send entire confirm */
+	/* don't send entire confirm */
 	assert(auth_proto_rx_authenticate(ap, (uint8_t *)frame, len - 10) !=3D 0);
 =

 	test_destruct(td);
-- =

2.25.0

--===============8846665198256943529==--

