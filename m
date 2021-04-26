Content-Type: multipart/mixed; boundary="===============3224153973405119504=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/5] wscutil: Move DeviceType parsing from p2p & eap-wsc to a
 function
Date: Mon, 26 Apr 2021 15:26:35 +0200
Message-ID: <20210426132638.758600-2-andrew.zaborowski@intel.com>
In-Reply-To: <20210426132638.758600-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3224153973405119504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Move the WSC Primary Device Type parsing from p2p.c and eap-wsc.c to a
common function in wscutil.c supporting both formats so that it can be
used in ap.c too.
---
 src/eap-wsc.c |  9 +--------
 src/p2p.c     | 43 ++++++-------------------------------------
 src/wscutil.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 src/wscutil.h |  2 ++
 4 files changed, 54 insertions(+), 45 deletions(-)

diff --git a/src/eap-wsc.c b/src/eap-wsc.c
index 78a52b4e..bbf32ed3 100644
--- a/src/eap-wsc.c
+++ b/src/eap-wsc.c
@@ -1742,19 +1742,12 @@ static bool load_primary_device_type(struct l_setti=
ngs *settings,
 					struct wsc_primary_device_type *pdt)
 {
 	const char *v;
-	int r;
 =

 	v =3D l_settings_get_value(settings, "WSC", "PrimaryDeviceType");
 	if (!v)
 		return false;
 =

-	r =3D sscanf(v, "%hx-%2hhx%2hhx%2hhx%2hhx-%2hx", &pdt->category,
-			&pdt->oui[0], &pdt->oui[1], &pdt->oui[2],
-			&pdt->oui_type, &pdt->subcategory);
-	if (r !=3D 6)
-		return false;
-
-	return true;
+	return wsc_device_type_from_setting_str(v, pdt);
 }
 =

 static bool load_constrained_string(struct l_settings *settings,
diff --git a/src/p2p.c b/src/p2p.c
index f0324d31..89d8c4ac 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -4355,43 +4355,12 @@ struct p2p_device *p2p_device_update_from_genl(stru=
ct l_genl_msg *msg,
 =

 	str =3D l_settings_get_string(iwd_get_config(), "P2P", "DeviceType");
 =

-	/*
-	 * Standard WSC subcategories are unique and more specific than
-	 * categories so there's no point for the user to specify the
-	 * category if they choose to use the string format.
-	 *
-	 * As an example our default value (Computer - PC) can be
-	 * encoded as either of:
-	 *
-	 * DeviceType=3Dpc
-	 * DeviceType=3D0x00010050f2040001
-	 */
-	if (str && !wsc_device_type_from_subcategory_str(
-					&dev->device_info.primary_device_type,
-					str)) {
-		unsigned long long u;
-		char *endp;
-
-		u =3D strtoull(str, &endp, 0);
-
-		/*
-		 * Accept any custom category, OUI and subcategory values but
-		 * require non-zero category as a sanity check.
-		 */
-		if (*endp !=3D '\0' || (u & 0xffff000000000000ll) =3D=3D 0)
-			l_error("[P2P].DeviceType must be a subcategory string "
-				"or a 64-bit integer encoding the full Primary"
-				" Device Type attribute: "
-				"<Category>|<OUI>|<OUI Type>|<Subcategory>");
-		else {
-			dev->device_info.primary_device_type.category =3D u >> 48;
-			dev->device_info.primary_device_type.oui[0] =3D u >> 40;
-			dev->device_info.primary_device_type.oui[1] =3D u >> 32;
-			dev->device_info.primary_device_type.oui[2] =3D u >> 24;
-			dev->device_info.primary_device_type.oui_type =3D u >> 16;
-			dev->device_info.primary_device_type.subcategory =3D u;
-		}
-	}
+	if (str && !wsc_device_type_from_setting_str(str,
+					&dev->device_info.primary_device_type))
+		l_error("[P2P].DeviceType must be a subcategory string "
+			"or a 64-bit integer encoding the full Primary"
+			" Device Type attribute: "
+			"<Category>|<OUI>|<OUI Type>|<Subcategory>");
 =

 	l_free(str);
 =

diff --git a/src/wscutil.c b/src/wscutil.c
index 49e73d7f..a48d2aa5 100644
--- a/src/wscutil.c
+++ b/src/wscutil.c
@@ -3050,3 +3050,48 @@ bool wsc_device_type_from_subcategory_str(struct wsc=
_primary_device_type *out,
 =

 	return false;
 }
+
+bool wsc_device_type_from_setting_str(const char *value,
+					struct wsc_primary_device_type *out)
+{
+	unsigned long long u;
+	char *endp;
+
+	if (!value)
+		return false;
+
+	/*
+	 * Standard WSC subcategories are unique and more specific than
+	 * categories so there's no point for the user to specify the
+	 * category if they choose to use the string format.
+	 *
+	 * As an example our default value (Computer - PC) can be
+	 * encoded as either of:
+	 *
+	 * DeviceType=3Dpc
+	 * DeviceType=3D0x00010050f2040001
+	 * DeviceType=3D1-0050f204-1
+	 */
+	if (wsc_device_type_from_subcategory_str(out, value))
+		true;
+
+	u =3D strtoull(value, &endp, 0);
+
+	/*
+	 * Accept any custom category, OUI and subcategory values but require
+	 * non-zero category as a sanity check.
+	 */
+	if (*endp =3D=3D '\0' && (u & 0xffff000000000000ll) !=3D 0) {
+		out->category =3D u >> 48;
+		out->oui[0] =3D u >> 40;
+		out->oui[1] =3D u >> 32;
+		out->oui[2] =3D u >> 24;
+		out->oui_type =3D u >> 16;
+		out->subcategory =3D u;
+		return true;
+	}
+
+	return sscanf(value, "%hx-%2hhx%2hhx%2hhx%2hhx-%2hx", &out->category,
+			&out->oui[0], &out->oui[1], &out->oui[2],
+			&out->oui_type, &out->subcategory) =3D=3D 6;
+}
diff --git a/src/wscutil.h b/src/wscutil.h
index 5bb26d84..1d603d8f 100644
--- a/src/wscutil.h
+++ b/src/wscutil.h
@@ -681,3 +681,5 @@ bool wsc_device_type_to_dbus_str(const struct wsc_prima=
ry_device_type *val,
 					const char **subcategory_str);
 bool wsc_device_type_from_subcategory_str(struct wsc_primary_device_type *=
out,
 						const char *subcategory_str);
+bool wsc_device_type_from_setting_str(const char *value,
+					struct wsc_primary_device_type *out);
-- =

2.27.0

--===============3224153973405119504==--

