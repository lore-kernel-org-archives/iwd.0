Content-Type: multipart/mixed; boundary="===============4703830736110049744=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 07/10] owe: check for error return getting shared_secret
Date: Wed, 16 Oct 2019 15:29:50 -0700
Message-ID: <20191016222953.513-7-prestwoj@gmail.com>
In-Reply-To: <20191016222953.513-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4703830736110049744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/owe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/owe.c b/src/owe.c
index daaf1f30..9af3a0de 100644
--- a/src/owe.c
+++ b/src/owe.c
@@ -165,9 +165,11 @@ static bool owe_compute_keys(struct owe_sm *owe, const=
 void *public_key,
 	l_ecc_point_free(other_public);
 =

 	nbytes =3D l_ecc_scalar_get_data(shared_secret, ss_buf, sizeof(ss_buf));
-
 	l_ecc_scalar_free(shared_secret);
 =

+	if (nbytes < 0)
+		return false;
+
 	ptr +=3D l_ecc_point_get_x(owe->public_key, ptr, sizeof(key));
 	memcpy(ptr, public_key, nbytes);
 	ptr +=3D nbytes;
-- =

2.17.1

--===============4703830736110049744==--

