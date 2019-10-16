Content-Type: multipart/mixed; boundary="===============1340951571858923329=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 08/10] owe: fix potential double free on error
Date: Wed, 16 Oct 2019 15:29:51 -0700
Message-ID: <20191016222953.513-8-prestwoj@gmail.com>
In-Reply-To: <20191016222953.513-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1340951571858923329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/owe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/owe.c b/src/owe.c
index 9af3a0de..9fff986f 100644
--- a/src/owe.c
+++ b/src/owe.c
@@ -217,7 +217,6 @@ static bool owe_compute_keys(struct owe_sm *owe, const =
void *public_key,
 =

 failed:
 	memset(ss_buf, 0, sizeof(ss_buf));
-	l_ecc_scalar_free(shared_secret);
 	return false;
 }
 =

-- =

2.17.1

--===============1340951571858923329==--

