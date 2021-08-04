Content-Type: multipart/mixed; boundary="===============4389098355282961186=="
MIME-Version: 1.0
From: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Subject: [RFC connman v1 1/1] gsupplicant: Add support for WPA3-Personal
 transition mode
Date: Wed, 04 Aug 2021 18:23:15 -0300
Message-ID: <20210804212315.265376-2-ariel.dalessandro@collabora.com>
In-Reply-To: <20210804212315.265376-1-ariel.dalessandro@collabora.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4389098355282961186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This commit adds support for WPA3-Personal transition mode, which
supports both WPA2-Personal (PSK) and WPA3-Personal (SAE).

Based on the AP accepted key management protocols, connman configures
wpa_supplicant as follows:

* WPA3-Personal-only mode: key_mgmt=3D"SAE" ; ieee80211w=3D2
* WPA3-Personal transition mode: key_mgmt=3D"SAE WPA-PSK" ; ieee80211w=3D1

Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
---
 gsupplicant/supplicant.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/gsupplicant/supplicant.c b/gsupplicant/supplicant.c
index 58c78fd1..8316f48a 100644
--- a/gsupplicant/supplicant.c
+++ b/gsupplicant/supplicant.c
@@ -4903,17 +4903,16 @@ static void add_network_security_proto(DBusMessageI=
ter *dict,
 	g_free(proto);
 }
 =

-static void add_network_ieee80211w(DBusMessageIter *dict, GSupplicantSSID =
*ssid)
+static void add_network_ieee80211w(DBusMessageIter *dict, GSupplicantSSID =
*ssid,
+				   GSupplicantMfpOptions ieee80211w)
 {
-	if (!(ssid->keymgmt & G_SUPPLICANT_KEYMGMT_SAE))
-		return;
-
 	supplicant_dbus_dict_append_basic(dict, "ieee80211w", DBUS_TYPE_UINT32,
-					  &ssid->ieee80211w);
+					  &ieee80211w);
 }
 =

 static void add_network_security(DBusMessageIter *dict, GSupplicantSSID *s=
sid)
 {
+	GSupplicantMfpOptions ieee80211w;
 	char *key_mgmt;
 =

 	switch (ssid->security) {
@@ -4929,10 +4928,22 @@ static void add_network_security(DBusMessageIter *d=
ict, GSupplicantSSID *ssid)
 		add_network_security_ciphers(dict, ssid);
 		break;
 	case G_SUPPLICANT_SECURITY_PSK:
-		if (ssid->keymgmt & G_SUPPLICANT_KEYMGMT_SAE)
-			key_mgmt =3D "SAE";
-		else
+		if (ssid->keymgmt & G_SUPPLICANT_KEYMGMT_SAE) {
+			if (ssid->keymgmt & G_SUPPLICANT_KEYMGMT_WPA_PSK) {
+				/*
+				 * WPA3-Personal transition mode: supports both
+				 * WPA2-Personal (PSK) and WPA3-Personal (SAE)
+				 */
+				key_mgmt =3D "SAE WPA-PSK";
+				ieee80211w =3D G_SUPPLICANT_MFP_OPTIONAL;
+			} else {
+				key_mgmt =3D "SAE";
+				ieee80211w =3D G_SUPPLICANT_MFP_REQUIRED;
+			}
+			add_network_ieee80211w(dict, ssid, ieee80211w);
+		} else {
 			key_mgmt =3D "WPA-PSK";
+		}
 		add_network_security_psk(dict, ssid);
 		add_network_security_ciphers(dict, ssid);
 		add_network_security_proto(dict, ssid);
@@ -4994,8 +5005,6 @@ static void interface_add_network_params(DBusMessageI=
ter *iter, void *user_data)
 =

 	add_network_security(&dict, ssid);
 =

-	add_network_ieee80211w(&dict, ssid);
-
 	supplicant_dbus_dict_append_fixed_array(&dict, "ssid",
 					DBUS_TYPE_BYTE, &ssid->ssid,
 						ssid->ssid_len);
-- =

2.30.2

--===============4389098355282961186==--

