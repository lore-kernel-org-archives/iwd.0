Content-Type: multipart/mixed; boundary="===============3274611393545905975=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/6] ap: Add authorized_macs parameter
Date: Tue, 04 Aug 2020 16:53:03 +0200
Message-ID: <20200804145303.151878-6-andrew.zaborowski@intel.com>
In-Reply-To: <20200804145303.151878-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3274611393545905975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ap.c | 31 ++++++++++++++++++++++++++++++-
 src/ap.h |  1 +
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/src/ap.c b/src/ap.c
index 412f307d..f7fb17ea 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -55,6 +55,8 @@ struct ap_state {
 	void *user_data;
 	char *ssid;
 	uint8_t channel;
+	uint8_t *authorized_macs;
+	int authorized_macs_num;
 =

 	unsigned int ciphers;
 	enum ie_rsn_cipher_suite group_cipher;
@@ -136,6 +138,7 @@ static void ap_reset(struct ap_state *ap)
 	if (ap->rates)
 		l_uintset_free(ap->rates);
 =

+	l_free(ap->authorized_macs);
 	ap->started =3D false;
 }
 =

@@ -1243,6 +1246,19 @@ static void ap_auth_cb(const struct mmpdu_header *hd=
r, const void *body,
 			memcmp(hdr->address_3, bssid, 6))
 		return;
 =

+	if (ap->authorized_macs) {
+		int i;
+
+		for (i =3D 0; i < ap->authorized_macs_num; i++)
+			if (!memcmp(from, ap->authorized_macs + i * 6, 6))
+				break;
+
+		if (i =3D=3D ap->authorized_macs_num) {
+			ap_auth_reply(ap, from, MMPDU_REASON_CODE_UNSPECIFIED);
+			return;
+		}
+	}
+
 	/* Only Open System authentication implemented here */
 	if (L_LE16_TO_CPU(auth->algorithm) !=3D
 			MMPDU_AUTH_ALGO_OPEN_SYSTEM) {
@@ -1447,6 +1463,7 @@ static void ap_mlme_notify(struct l_genl_msg *msg, vo=
id *user_data)
  */
 struct ap_state *ap_start(struct netdev *netdev, const char *ssid,
 				const char *psk, int channel, bool no_cck_rates,
+				const uint8_t **authorized_macs,
 				ap_event_func_t event_func, void *user_data)
 {
 	struct ap_state *ap;
@@ -1469,6 +1486,18 @@ struct ap_state *ap_start(struct netdev *netdev, con=
st char *ssid,
 		ap->channel =3D 6;
 	}
 =

+	if (authorized_macs) {
+		int i;
+
+		for (i =3D 0; authorized_macs[i]; i++);
+		ap->authorized_macs =3D l_malloc(i * 6);
+		ap->authorized_macs_num =3D i;
+
+		for (i =3D 0; authorized_macs[i]; i++)
+			memcpy(ap->authorized_macs + i * 6, authorized_macs[i],
+				6);
+	}
+
 	/* TODO: Add all ciphers supported by wiphy */
 	ap->ciphers =3D wiphy_select_cipher(wiphy, 0xffff);
 	ap->group_cipher =3D wiphy_select_cipher(wiphy, 0xffff);
@@ -1735,7 +1764,7 @@ static struct l_dbus_message *ap_dbus_start(struct l_=
dbus *dbus,
 	if (!l_dbus_message_get_arguments(message, "ss", &ssid, &wpa2_psk))
 		return dbus_error_invalid_args(message);
 =

-	ap_if->ap =3D ap_start(ap_if->netdev, ssid, wpa2_psk, 0, false,
+	ap_if->ap =3D ap_start(ap_if->netdev, ssid, wpa2_psk, 0, false, NULL,
 				ap_if_event_func, ap_if);
 	if (!ap_if->ap)
 		return dbus_error_invalid_args(message);
diff --git a/src/ap.h b/src/ap.h
index 2da0596f..b007b657 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -47,6 +47,7 @@ typedef void (*ap_stopped_func_t)(void *user_data);
 =

 struct ap_state *ap_start(struct netdev *netdev, const char *ssid,
 				const char *psk, int channel, bool no_cck_rates,
+				const uint8_t **authorized_macs,
 				ap_event_func_t event_func, void *user_data);
 void ap_shutdown(struct ap_state *ap, ap_stopped_func_t stopped_func,
 			void *user_data);
-- =

2.25.1

--===============3274611393545905975==--

