Content-Type: multipart/mixed; boundary="===============5026906804794919125=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 10/11] station: make station_can_fast_transition more robust
Date: Wed, 12 May 2021 16:01:47 -0700
Message-ID: <20210512230148.370858-10-prestwoj@gmail.com>
In-Reply-To: <20210512230148.370858-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5026906804794919125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Check that the current handshake is using an FT AKM and that the
target BSS AKM suites contain an FT AKM.
---
 src/station.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/src/station.c b/src/station.c
index 385bb272..325121f1 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1796,10 +1796,23 @@ static bool station_can_fast_transition(struct hand=
shake_state *hs,
 						&mdid, NULL, NULL) < 0)
 		return false;
 =

-	if (bss->mde_present && l_get_le16(bss->mde) =3D=3D mdid)
-		return true;
+	if (!(bss->mde_present && l_get_le16(bss->mde) =3D=3D mdid))
+		return false;
 =

-	return false;
+	if (hs->supplicant_ie !=3D NULL) {
+		struct ie_rsn_info rsn_info;
+
+		if (!IE_AKM_IS_FT(hs->akm_suite))
+			return false;
+
+		if (scan_bss_get_rsn_info(bss, &rsn_info) < 0)
+			return false;
+
+		if (!IE_AKM_IS_FT(rsn_info.akm_suites))
+			return false;
+	}
+
+	return true;
 }
 =

 static void station_transition_start(struct station *station,
-- =

2.31.1

--===============5026906804794919125==--

