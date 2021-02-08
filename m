Content-Type: multipart/mixed; boundary="===============5646951467700410352=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] unit: test-sae: zero out frame buffers
Date: Mon, 08 Feb 2021 14:23:14 -0800
Message-ID: <20210208222314.618508-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5646951467700410352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Not all the authenticate frame elements are set and were assumed
to be zero. Since alloca does not memset data it needs to be
done explicitly.
---
 unit/test-sae.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/unit/test-sae.c b/unit/test-sae.c
index 2d984160..10367cf9 100644
--- a/unit/test-sae.c
+++ b/unit/test-sae.c
@@ -202,6 +202,7 @@ static size_t setup_auth_frame(struct authenticate_fram=
e *frame,
 				uint16_t trans, uint16_t status,
 				const uint8_t *data, size_t len)
 {
+	memset(frame, 0, sizeof(struct authenticate_frame));
 	memcpy(frame->hdr.address_2, addr, 6);
 =

 	frame->hdr.fc.type =3D MPDU_TYPE_MANAGEMENT;
-- =

2.26.2

--===============5646951467700410352==--

