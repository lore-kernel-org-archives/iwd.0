Content-Type: multipart/mixed; boundary="===============4875576768469777909=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/8] anqp: print MAC when sending ANQP request
Date: Wed, 18 Aug 2021 15:09:27 -0700
Message-ID: <20210818220934.295721-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4875576768469777909==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/anqp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/anqp.c b/src/anqp.c
index 9f216305..a3c46635 100644
--- a/src/anqp.c
+++ b/src/anqp.c
@@ -248,7 +248,7 @@ uint32_t anqp_request(uint64_t wdev_id, const uint8_t *=
addr,
 	iov[0].iov_len =3D request->frame_len;
 	iov[1].iov_base =3D NULL;
 =

-	l_debug("Sending ANQP request");
+	l_debug("Sending ANQP request to "MAC, MAC_STR(bss->addr));
 =

 	request->id =3D frame_xchg_start(request->wdev_id, iov,
 				request->frequency, 0, 300, 0,
-- =

2.31.1

--===============4875576768469777909==--

