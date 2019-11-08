Content-Type: multipart/mixed; boundary="===============2843252415982386169=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 2/4] scan: Fix bit checking for interworking
Date: Fri, 08 Nov 2019 17:04:00 -0500
Message-ID: <20191108220402.10282-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191108220402.10282-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2843252415982386169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The checker function will later be changed to match the bit setter.
---
 src/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/scan.c b/src/scan.c
index 4bc95afe..f1317686 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -305,7 +305,7 @@ static struct l_genl_msg *scan_build_cmd(struct scan_co=
ntext *sc,
 	iov[iov_elems].iov_len =3D ext_capa[1] + 2;
 	iov_elems++;
 =

-	if (util_is_bit_set(ext_capa[3], 7)) {
+	if (util_is_bit_set(ext_capa[2 + 3], 7)) {
 		/* Order 12 - Interworking */
 		interworking[0] =3D IE_TYPE_INTERWORKING;
 		interworking[1] =3D 1;
-- =

2.21.0

--===============2843252415982386169==--

