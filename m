Content-Type: multipart/mixed; boundary="===============8345794605418662703=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 3/4] scan: Separate IE attr creation into logical block
Date: Fri, 08 Nov 2019 17:04:01 -0500
Message-ID: <20191108220402.10282-3-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191108220402.10282-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8345794605418662703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This also introduces the max IE lenght check and exludes the addition
of IEs for the drivers that don't support it.
---
 src/scan.c | 51 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index f1317686..a3d6e5d8 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -266,34 +266,15 @@ static void scan_build_attr_scan_frequencies(struct l=
_genl_msg *msg,
 	l_genl_msg_leave_nested(msg);
 }
 =

-static bool scan_mac_address_randomization_is_disabled(void)
-{
-	const struct l_settings *config =3D iwd_get_config();
-	bool disabled;
-
-	if (!l_settings_get_bool(config, "Scan",
-					"DisableMacAddressRandomization",
-					&disabled))
-		return false;
-
-	return disabled;
-}
-
-static struct l_genl_msg *scan_build_cmd(struct scan_context *sc,
-					bool ignore_flush_flag, bool is_passive,
+static void scan_build_attr_ie(struct l_genl_msg *msg,
+					struct scan_context *sc,
 					const struct scan_parameters *params)
 {
-	struct l_genl_msg *msg;
-	uint32_t flags =3D 0;
 	struct iovec iov[3];
 	unsigned int iov_elems =3D 0;
 	const uint8_t *ext_capa;
 	uint8_t interworking[3];
 =

-	msg =3D l_genl_msg_new(NL80211_CMD_TRIGGER_SCAN);
-
-	l_genl_msg_append_attr(msg, NL80211_ATTR_WDEV, 8, &sc->wdev_id);
-
 	ext_capa =3D wiphy_get_extended_capabilities(sc->wiphy,
 							NL80211_IFTYPE_STATION);
 	/*
@@ -325,6 +306,34 @@ static struct l_genl_msg *scan_build_cmd(struct scan_c=
ontext *sc,
 	}
 =

 	l_genl_msg_append_attrv(msg, NL80211_ATTR_IE, iov, iov_elems);
+}
+
+static bool scan_mac_address_randomization_is_disabled(void)
+{
+	const struct l_settings *config =3D iwd_get_config();
+	bool disabled;
+
+	if (!l_settings_get_bool(config, "Scan",
+					"DisableMacAddressRandomization",
+					&disabled))
+		return false;
+
+	return disabled;
+}
+
+static struct l_genl_msg *scan_build_cmd(struct scan_context *sc,
+					bool ignore_flush_flag, bool is_passive,
+					const struct scan_parameters *params)
+{
+	struct l_genl_msg *msg;
+	uint32_t flags =3D 0;
+
+	msg =3D l_genl_msg_new(NL80211_CMD_TRIGGER_SCAN);
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_WDEV, 8, &sc->wdev_id);
+
+	if (wiphy_get_max_scan_ie_len(sc->wiphy))
+		scan_build_attr_ie(msg, sc, params);
 =

 	if (params->freqs)
 		scan_build_attr_scan_frequencies(msg, params->freqs);
-- =

2.21.0

--===============8345794605418662703==--

