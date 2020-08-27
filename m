Content-Type: multipart/mixed; boundary="===============6406051373479516274=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 11/11] ap: Start EAP-WSC authentication with WSC enrollees
Date: Thu, 27 Aug 2020 20:14:53 +0200
Message-ID: <20200827181453.61823-11-andrew.zaborowski@intel.com>
In-Reply-To: <20200827181453.61823-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6406051373479516274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After association and sending the SET_STATION commands, set up the
handshake_state and eapol_sm for EAP-WSC and start the handshake.
---
 src/ap.c | 217 ++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 176 insertions(+), 41 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 0876dc01..26dddfea 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -46,6 +46,7 @@
 #include "src/nl80211util.h"
 #include "src/frame-xchg.h"
 #include "src/wscutil.h"
+#include "src/eap-wsc.h"
 #include "src/ap.h"
 =

 struct ap_state {
@@ -91,6 +92,8 @@ struct sta_state {
 	struct eapol_sm *sm;
 	struct handshake_state *hs;
 	uint32_t gtk_query_cmd_id;
+	struct l_idle *stop_handshake_work;
+	struct l_settings *wsc_settings;
 	uint8_t wsc_uuid_e[16];
 };
 =

@@ -130,6 +133,23 @@ static void ap_stop_handshake(struct sta_state *sta)
 		handshake_state_free(sta->hs);
 		sta->hs =3D NULL;
 	}
+
+	if (sta->wsc_settings) {
+		l_settings_free(sta->wsc_settings);
+		sta->wsc_settings =3D NULL;
+	}
+
+	if (sta->stop_handshake_work) {
+		l_idle_remove(sta->stop_handshake_work);
+		sta->stop_handshake_work =3D NULL;
+	}
+}
+
+static void ap_stop_handshake_work(struct l_idle *idle, void *user_data)
+{
+	struct sta_state *sta =3D user_data;
+
+	ap_stop_handshake(sta);
 }
 =

 static void ap_sta_free(void *data)
@@ -561,6 +581,44 @@ static uint32_t ap_send_mgmt_frame(struct ap_state *ap,
 	return id;
 }
 =

+static void ap_start_handshake(struct sta_state *sta)
+{
+	struct ap_state *ap =3D sta->ap;
+	const uint8_t *own_addr =3D netdev_get_address(ap->netdev);
+	struct ie_rsn_info rsn;
+	uint8_t bss_rsne[24];
+
+	handshake_state_set_ssid(sta->hs, (void *) ap->config->ssid,
+					strlen(ap->config->ssid));
+	handshake_state_set_authenticator_address(sta->hs, own_addr);
+	handshake_state_set_supplicant_address(sta->hs, sta->addr);
+
+	ap_set_rsn_info(ap, &rsn);
+	/*
+	 * Note: This assumes the length that ap_set_rsn_info() requires. If
+	 * ap_set_rsn_info() changes then this will need to be updated.
+	 */
+	ie_build_rsne(&rsn, bss_rsne);
+	handshake_state_set_authenticator_ie(sta->hs, bss_rsne);
+
+	sta->sm =3D eapol_sm_new(sta->hs);
+	if (!sta->sm) {
+		ap_stop_handshake(sta);
+		l_error("could not create sm object");
+		goto error;
+	}
+
+	eapol_sm_set_listen_interval(sta->sm, sta->listen_interval);
+
+	eapol_register(sta->sm);
+	eapol_start(sta->sm);
+
+	return;
+
+error:
+	ap_del_station(sta, MMPDU_REASON_CODE_UNSPECIFIED, true);
+}
+
 static void ap_handshake_event(struct handshake_state *hs,
 		enum handshake_event event, void *user_data, ...)
 {
@@ -588,53 +646,18 @@ static void ap_handshake_event(struct handshake_state=
 *hs,
 =

 static void ap_start_rsna(struct sta_state *sta, const uint8_t *gtk_rsc)
 {
-	struct ap_state *ap =3D sta->ap;
-	struct netdev *netdev =3D sta->ap->netdev;
-	const uint8_t *own_addr =3D netdev_get_address(netdev);
-	struct ie_rsn_info rsn;
-	uint8_t bss_rsne[24];
-
-	ap_set_rsn_info(ap, &rsn);
-	/*
-	 * TODO: This assumes the length that ap_set_rsn_info() requires. If
-	 * ap_set_rsn_info() changes then this will need to be updated.
-	 */
-	ie_build_rsne(&rsn, bss_rsne);
-
 	/* this handshake setup assumes PSK network */
-	sta->hs =3D netdev_handshake_state_new(netdev);
-
-	handshake_state_set_event_func(sta->hs, ap_handshake_event, sta);
-	handshake_state_set_ssid(sta->hs, (void *) ap->config->ssid,
-					strlen(ap->config->ssid));
+	sta->hs =3D netdev_handshake_state_new(sta->ap->netdev);
 	handshake_state_set_authenticator(sta->hs, true);
-	handshake_state_set_authenticator_ie(sta->hs, bss_rsne);
+	handshake_state_set_event_func(sta->hs, ap_handshake_event, sta);
 	handshake_state_set_supplicant_ie(sta->hs, sta->assoc_rsne);
-	handshake_state_set_pmk(sta->hs, ap->pmk, 32);
-	handshake_state_set_authenticator_address(sta->hs, own_addr);
-	handshake_state_set_supplicant_address(sta->hs, sta->addr);
+	handshake_state_set_pmk(sta->hs, sta->ap->pmk, 32);
 =

 	if (gtk_rsc)
-		handshake_state_set_gtk(sta->hs, ap->gtk, ap->gtk_index,
-					gtk_rsc);
-
-	sta->sm =3D eapol_sm_new(sta->hs);
-	if (!sta->sm) {
-		handshake_state_free(sta->hs);
-		sta->hs =3D NULL;
-		l_error("could not create sm object");
-		goto error;
-	}
-
-	eapol_sm_set_listen_interval(sta->sm, sta->listen_interval);
+		handshake_state_set_gtk(sta->hs, sta->ap->gtk,
+					sta->ap->gtk_index, gtk_rsc);
 =

-	eapol_register(sta->sm);
-	eapol_start(sta->sm);
-
-	return;
-
-error:
-	ap_del_station(sta, MMPDU_REASON_CODE_UNSPECIFIED, true);
+	ap_start_handshake(sta);
 }
 =

 static void ap_gtk_query_cb(struct l_genl_msg *msg, void *user_data)
@@ -673,6 +696,105 @@ static bool ap_wsc_pbc_record_expire(void *data, void=
 *user_data)
 	return true;
 }
 =

+static void ap_stop_handshake_schedule(struct sta_state *sta)
+{
+	if (sta->stop_handshake_work)
+		return;
+
+	sta->stop_handshake_work =3D l_idle_create(ap_stop_handshake_work,
+							sta, NULL);
+}
+
+static void ap_wsc_handshake_event(struct handshake_state *hs,
+		enum handshake_event event, void *user_data, ...)
+{
+	struct sta_state *sta =3D user_data;
+	va_list args;
+	struct ap_event_registration_success_data event_data;
+	struct ap_pbc_record_expiry_data expiry_data;
+
+	va_start(args, user_data);
+
+	switch (event) {
+	case HANDSHAKE_EVENT_FAILED:
+		sta->sm =3D NULL;
+		ap_stop_handshake_schedule(sta);
+		/*
+		 * Some diagrams in WSC v2.0.5 indicate we should
+		 * automatically deauthenticate the Enrollee.  The text
+		 * generally indicates the Enrollee may disassociate
+		 * meaning that we should neither deauthenticate nor
+		 * disassociate it automatically.  Some places indicate
+		 * that the enrollee can send a new EAPoL-Start right away
+		 * on an unsuccessful registration, we don't implement
+		 * this for now.  STA remains associated but not authorized
+		 * and basically has no other option than to re-associate
+		 * or disassociate/deauthenticate.
+		 */
+		break;
+	case HANDSHAKE_EVENT_EAP_NOTIFY:
+		if (va_arg(args, unsigned int) !=3D EAP_WSC_EVENT_CREDENTIAL_SENT)
+			break;
+
+		/*
+		 * WSC v2.0.5 Section 11.3:
+		 * "If the Registrar successfully runs the PBC method to
+		 * completion with an Enrollee, that Enrollee's probe requests
+		 * are removed from the Monitor Time check the next time the
+		 * Registrar's PBC button is pressed."
+		 */
+		expiry_data.min_time =3D 0;
+		expiry_data.mac =3D sta->addr;
+		l_queue_foreach_remove(sta->ap->wsc_pbc_probes,
+					ap_wsc_pbc_record_expire,
+					&expiry_data);
+
+		event_data.mac =3D sta->addr;
+		sta->ap->event_func(AP_EVENT_REGISTRATION_SUCCESS, &event_data,
+					sta->ap->user_data);
+		break;
+	default:
+		break;
+	}
+
+	va_end(args);
+}
+
+static void ap_start_eap_wsc(struct sta_state *sta)
+{
+	struct ap_state *ap =3D sta->ap;
+	L_AUTO_FREE_VAR(char *, uuid_r_str) =3D NULL;
+	L_AUTO_FREE_VAR(char *, uuid_e_str) =3D NULL;
+
+	uuid_r_str =3D l_util_hexstring(ap->wsc_uuid_r, 16);
+	uuid_e_str =3D l_util_hexstring(sta->wsc_uuid_e, 16);
+
+	sta->wsc_settings =3D l_settings_new();
+	l_settings_set_string(sta->wsc_settings, "Security", "EAP-Method",
+				"WSC-R");
+	l_settings_set_string(sta->wsc_settings, "WSC", "EnrolleeMAC",
+				util_address_to_string(sta->addr));
+	l_settings_set_string(sta->wsc_settings, "WSC", "UUID-R",
+				uuid_r_str);
+	l_settings_set_string(sta->wsc_settings, "WSC", "UUID-E",
+				uuid_e_str);
+	l_settings_set_uint(sta->wsc_settings, "WSC", "RFBand",
+				WSC_RF_BAND_2_4_GHZ);
+	l_settings_set_uint(sta->wsc_settings, "WSC", "ConfigurationMethods",
+				WSC_CONFIGURATION_METHOD_PUSH_BUTTON);
+	l_settings_set_string(sta->wsc_settings, "WSC", "WPA2-SSID",
+				ap->config->ssid);
+	l_settings_set_string(sta->wsc_settings, "WSC", "WPA2-Passphrase",
+				ap->config->psk);
+
+	sta->hs =3D netdev_handshake_state_new(ap->netdev);
+	handshake_state_set_authenticator(sta->hs, true);
+	handshake_state_set_event_func(sta->hs, ap_wsc_handshake_event, sta);
+	handshake_state_set_8021x_config(sta->hs, sta->wsc_settings);
+
+	ap_start_handshake(sta);
+}
+
 static struct l_genl_msg *ap_build_cmd_del_key(struct ap_state *ap)
 {
 	uint32_t ifindex =3D netdev_get_ifindex(ap->netdev);
@@ -739,6 +861,19 @@ static void ap_associate_sta_cb(struct l_genl_msg *msg=
, void *user_data)
 		return;
 	}
 =

+	/*
+	 * WSC v2.0.5 Section 8.2:
+	 * "Therefore if a WSC IE is present in the (re)association request,
+	 * the AP shall engage in EAP-WSC with the station and shall not
+	 * attempt any other security handshake."
+	 *
+	 * So no need for group traffic, skip the GTK setup below.
+	 */
+	if (!sta->assoc_rsne) {
+		ap_start_eap_wsc(sta);
+		return;
+	}
+
 	/*
 	 * Set up the group key.  If this is our first STA then we have
 	 * to add the new GTK to the kernel.  In theory we should be
-- =

2.25.1

--===============6406051373479516274==--

