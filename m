Content-Type: multipart/mixed; boundary="===============0208330254492202505=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 7/8] p2putil: Replace constants with wifi_alliance_oui
Date: Thu, 24 Oct 2019 06:29:59 +0200
Message-ID: <20191024043000.13687-7-andrew.zaborowski@intel.com>
In-Reply-To: <20191024043000.13687-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0208330254492202505==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/p2putil.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/p2putil.c b/src/p2putil.c
index 79371168..7d1a7ad2 100644
--- a/src/p2putil.c
+++ b/src/p2putil.c
@@ -2216,9 +2216,9 @@ static uint8_t *p2p_build_action_frame(bool public, u=
int8_t frame_subtype,
 	} else
 		ret[pos++] =3D 0x7f; /* Category: Vendor Specific */
 =

-	ret[pos++] =3D 0x50;	/* OUI: Wi-Fi Alliance */
-	ret[pos++] =3D 0x6f;
-	ret[pos++] =3D 0x9a;
+	ret[pos++] =3D wifi_alliance_oui[0];
+	ret[pos++] =3D wifi_alliance_oui[1];
+	ret[pos++] =3D wifi_alliance_oui[2];
 	ret[pos++] =3D 0x09;	/* OUI type: Wi-Fi Alliance P2P v1.0 */
 	ret[pos++] =3D frame_subtype;
 	ret[pos++] =3D dialog_token;
-- =

2.20.1

--===============0208330254492202505==--

