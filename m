Content-Type: multipart/mixed; boundary="===============2422156252656712984=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] ap: Deduplicate writing authorized MACs into wsc_* structs
Date: Wed, 28 Apr 2021 17:48:37 +0200
Message-ID: <20210428154838.1346865-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2422156252656712984==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ap.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index f55341e8..31d3dfc2 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -606,6 +606,20 @@ static void ap_process_wsc_probe_req(struct ap_state *=
ap, const uint8_t *from,
 	}
 }
 =

+static void ap_write_authorized_macs(struct ap_state *ap,
+					size_t out_len, uint8_t *out)
+{
+	size_t len =3D ap->authorized_macs_num * 6;
+
+	if (!len)
+		return;
+
+	if (len > out_len)
+		len =3D out_len;
+
+	memcpy(out, ap->authorized_macs, len);
+}
+
 static size_t ap_get_wsc_ie_len(struct ap_state *ap,
 				enum mpdu_management_subtype type,
 				const struct mmpdu_header *client_frame,
@@ -670,16 +684,8 @@ static size_t ap_write_wsc_ie(struct ap_state *ap,
 		wsc_pr.config_methods =3D
 			WSC_CONFIGURATION_METHOD_PUSH_BUTTON;
 =

-		if (ap->authorized_macs_num) {
-			size_t len =3D ap->authorized_macs_num * 6;
-
-			if (len > sizeof(wsc_pr.authorized_macs))
-				len =3D sizeof(wsc_pr.authorized_macs);
-
-			memcpy(wsc_pr.authorized_macs,
-				ap->authorized_macs, len);
-		}
-
+		ap_write_authorized_macs(ap, sizeof(wsc_pr.authorized_macs),
+						wsc_pr.authorized_macs);
 		wsc_data =3D wsc_build_probe_response(&wsc_pr, &wsc_data_size);
 	} else if (type =3D=3D MPDU_MANAGEMENT_SUBTYPE_BEACON) {
 		struct wsc_beacon wsc_beacon =3D {};
@@ -694,16 +700,8 @@ static size_t ap_write_wsc_ie(struct ap_state *ap,
 				WSC_CONFIGURATION_METHOD_PUSH_BUTTON;
 		}
 =

-		if (ap->authorized_macs_num) {
-			size_t len =3D ap->authorized_macs_num * 6;
-
-			if (len > sizeof(wsc_beacon.authorized_macs))
-				len =3D sizeof(wsc_beacon.authorized_macs);
-
-			memcpy(wsc_beacon.authorized_macs,
-				ap->authorized_macs, len);
-		}
-
+		ap_write_authorized_macs(ap, sizeof(wsc_beacon.authorized_macs),
+						wsc_beacon.authorized_macs);
 		wsc_data =3D wsc_build_beacon(&wsc_beacon, &wsc_data_size);
 	} else if (L_IN_SET(type, MPDU_MANAGEMENT_SUBTYPE_ASSOCIATION_RESPONSE,
 			MPDU_MANAGEMENT_SUBTYPE_REASSOCIATION_RESPONSE)) {
-- =

2.27.0

--===============2422156252656712984==--

