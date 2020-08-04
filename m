Content-Type: multipart/mixed; boundary="===============0176947354197399789=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/6] ap: Add a no_cck_rates flag
Date: Tue, 04 Aug 2020 16:53:02 +0200
Message-ID: <20200804145303.151878-5-andrew.zaborowski@intel.com>
In-Reply-To: <20200804145303.151878-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0176947354197399789==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ap.c | 33 ++++++++++++++++++++++++++-------
 src/ap.h |  2 +-
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index dd0aa224..412f307d 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -71,6 +71,7 @@ struct ap_state {
 =

 	bool started : 1;
 	bool gtk_set : 1;
+	bool no_cck_rates : 1;
 };
 =

 struct sta_state {
@@ -382,6 +383,11 @@ static uint32_t ap_send_mgmt_frame(struct ap_state *ap,
 		l_genl_msg_append_attr(msg, NL80211_ATTR_DONT_WAIT_FOR_ACK,
 					0, NULL);
 =

+	if (ap->no_cck_rates)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_TX_NO_CCK_RATE, 0,
+					NULL);
+
+
 	id =3D l_genl_family_send(ap->nl80211, msg, callback, user_data, NULL);
 =

 	if (!id)
@@ -1440,7 +1446,7 @@ static void ap_mlme_notify(struct l_genl_msg *msg, vo=
id *user_data)
  * @channel is optional.
  */
 struct ap_state *ap_start(struct netdev *netdev, const char *ssid,
-				const char *psk, int channel,
+				const char *psk, int channel, bool no_cck_rates,
 				ap_event_func_t event_func, void *user_data)
 {
 	struct ap_state *ap;
@@ -1452,6 +1458,7 @@ struct ap_state *ap_start(struct netdev *netdev, cons=
t char *ssid,
 	ap->nl80211 =3D l_genl_family_new(iwd_get_genl(), NL80211_GENL_NAME);
 	ap->ssid =3D l_strdup(ssid);
 	ap->netdev =3D netdev;
+	ap->no_cck_rates =3D no_cck_rates;
 	ap->event_func =3D event_func;
 	ap->user_data =3D user_data;
 =

@@ -1466,11 +1473,23 @@ struct ap_state *ap_start(struct netdev *netdev, co=
nst char *ssid,
 	ap->ciphers =3D wiphy_select_cipher(wiphy, 0xffff);
 	ap->group_cipher =3D wiphy_select_cipher(wiphy, 0xffff);
 	ap->beacon_interval =3D 100;
-	/* TODO: Use actual supported rates */
-	ap->rates =3D l_uintset_new(200);
-	l_uintset_put(ap->rates, 2); /* 1 Mbps*/
-	l_uintset_put(ap->rates, 11); /* 5.5 Mbps*/
-	l_uintset_put(ap->rates, 22); /* 11 Mbps*/
+
+	/* TODO: Pick from actual supported rates */
+	if (no_cck_rates) {
+		l_uintset_put(ap->rates, 12); /* 6 Mbps*/
+		l_uintset_put(ap->rates, 18); /* 9 Mbps*/
+		l_uintset_put(ap->rates, 24); /* 12 Mbps*/
+		l_uintset_put(ap->rates, 36); /* 18 Mbps*/
+		l_uintset_put(ap->rates, 48); /* 24 Mbps*/
+		l_uintset_put(ap->rates, 72); /* 36 Mbps*/
+		l_uintset_put(ap->rates, 96); /* 48 Mbps*/
+		l_uintset_put(ap->rates, 108); /* 54 Mbps*/
+	} else {
+		ap->rates =3D l_uintset_new(200);
+		l_uintset_put(ap->rates, 2); /* 1 Mbps*/
+		l_uintset_put(ap->rates, 11); /* 5.5 Mbps*/
+		l_uintset_put(ap->rates, 22); /* 11 Mbps*/
+	}
 =

 	if (crypto_psk_from_passphrase(psk, (uint8_t *) ssid, strlen(ssid),
 					ap->pmk) < 0)
@@ -1716,7 +1735,7 @@ static struct l_dbus_message *ap_dbus_start(struct l_=
dbus *dbus,
 	if (!l_dbus_message_get_arguments(message, "ss", &ssid, &wpa2_psk))
 		return dbus_error_invalid_args(message);
 =

-	ap_if->ap =3D ap_start(ap_if->netdev, ssid, wpa2_psk, 0,
+	ap_if->ap =3D ap_start(ap_if->netdev, ssid, wpa2_psk, 0, false,
 				ap_if_event_func, ap_if);
 	if (!ap_if->ap)
 		return dbus_error_invalid_args(message);
diff --git a/src/ap.h b/src/ap.h
index 1fd8b63e..2da0596f 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -46,7 +46,7 @@ typedef void (*ap_event_func_t)(enum ap_event_type type, =
const void *event_data,
 typedef void (*ap_stopped_func_t)(void *user_data);
 =

 struct ap_state *ap_start(struct netdev *netdev, const char *ssid,
-				const char *psk, int channel,
+				const char *psk, int channel, bool no_cck_rates,
 				ap_event_func_t event_func, void *user_data);
 void ap_shutdown(struct ap_state *ap, ap_stopped_func_t stopped_func,
 			void *user_data);
-- =

2.25.1

--===============0176947354197399789==--

