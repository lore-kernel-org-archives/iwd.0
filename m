Content-Type: multipart/mixed; boundary="===============0616235922930213517=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 05/11] ap: Drop unused variable
Date: Thu, 27 Aug 2020 20:14:47 +0200
Message-ID: <20200827181453.61823-5-andrew.zaborowski@intel.com>
In-Reply-To: <20200827181453.61823-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0616235922930213517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ap.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 821423ac..1267e254 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -443,12 +443,9 @@ static void ap_start_rsna(struct sta_state *sta, const=
 uint8_t *gtk_rsc)
 	struct ap_state *ap =3D sta->ap;
 	struct netdev *netdev =3D sta->ap->netdev;
 	const uint8_t *own_addr =3D netdev_get_address(netdev);
-	struct scan_bss bss;
 	struct ie_rsn_info rsn;
 	uint8_t bss_rsne[24];
 =

-	memset(&bss, 0, sizeof(bss));
-
 	ap_set_rsn_info(ap, &rsn);
 	/*
 	 * TODO: This assumes the length that ap_set_rsn_info() requires. If
-- =

2.25.1

--===============0616235922930213517==--

