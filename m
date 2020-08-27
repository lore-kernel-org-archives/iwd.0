Content-Type: multipart/mixed; boundary="===============8402265785528256640=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 06/11] ap: Fix incoming Probe Request BSSID check
Date: Thu, 27 Aug 2020 20:14:48 +0200
Message-ID: <20200827181453.61823-6-andrew.zaborowski@intel.com>
In-Reply-To: <20200827181453.61823-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8402265785528256640==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Setting 'match' false wouldn't do anything because it was already false.
If the frame is addressed to some other non-broadcast address ignore it
directly and exit ap_probe_req_cb.
---
 src/ap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 1267e254..aef2e1dd 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -1129,11 +1129,11 @@ static void ap_probe_req_cb(const struct mmpdu_head=
er *hdr, const void *body,
 =

 	if (memcmp(hdr->address_1, bssid, 6) &&
 			!util_is_broadcast_address(hdr->address_1))
-		match =3D false;
+		return;
 =

 	if (memcmp(hdr->address_3, bssid, 6) &&
 			!util_is_broadcast_address(hdr->address_3))
-		match =3D false;
+		return;
 =

 	if (!ssid || ssid_len =3D=3D 0) /* Wildcard SSID */
 		match =3D true;
-- =

2.25.1

--===============8402265785528256640==--

