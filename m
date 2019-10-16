Content-Type: multipart/mixed; boundary="===============4376141321972302940=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 10/10] sae: check return getting k_point
Date: Wed, 16 Oct 2019 15:29:53 -0700
Message-ID: <20191016222953.513-10-prestwoj@gmail.com>
In-Reply-To: <20191016222953.513-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4376141321972302940==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/sae.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/sae.c b/src/sae.c
index 8f9425f1..232a63b9 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -498,6 +498,9 @@ static int sae_process_commit(struct sae_sm *sm, const =
uint8_t *from,
 =

 	l_ecc_point_free(k_point);
 =

+	if (klen < 0)
+		goto reject;
+
 	/* keyseed =3D H(<0>32, k) */
 	hmac_sha256(zero_key, 32, k, klen, keyseed, 32);
 =

-- =

2.17.1

--===============4376141321972302940==--

