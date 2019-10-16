Content-Type: multipart/mixed; boundary="===============1248789649708806464=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 09/10] owe: fix potential uninitialized variable
Date: Wed, 16 Oct 2019 15:29:52 -0700
Message-ID: <20191016222953.513-9-prestwoj@gmail.com>
In-Reply-To: <20191016222953.513-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1248789649708806464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/owe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/owe.c b/src/owe.c
index 9fff986f..afdd32ea 100644
--- a/src/owe.c
+++ b/src/owe.c
@@ -246,7 +246,7 @@ static int owe_rx_associate(struct auth_proto *ap, cons=
t uint8_t *frame,
 	size_t owe_dh_len =3D 0;
 	const uint8_t *owe_dh =3D NULL;
 	struct ie_rsn_info info;
-	bool akm_found;
+	bool akm_found =3D false;
 	const void *data;
 =

 	mpdu =3D mpdu_validate(frame, len);
-- =

2.17.1

--===============1248789649708806464==--

