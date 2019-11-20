Content-Type: multipart/mixed; boundary="===============0892785961859166604=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/6] scan: fix parent TSF parsing
Date: Wed, 20 Nov 2019 09:31:42 -0800
Message-ID: <20191120173146.21452-2-prestwoj@gmail.com>
In-Reply-To: <20191120173146.21452-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0892785961859166604==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The value coming from the kernel is in the same endianness as IWD, so
just parse it as a u64 rather than le64.
---
 src/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-v2:
 * Changed the commit description to match what was being changed. This
   commit description somehow got duplicated from a previously upstreamed
   commit adding parent TSF parsing

diff --git a/src/scan.c b/src/scan.c
index e74a69c1..e007ce5d 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -1076,7 +1076,7 @@ static struct scan_bss *scan_parse_attr_bss(struct l_=
genl_attr *attr)
 			if (len !=3D sizeof(uint64_t))
 				goto fail;
 =

-			bss->parent_tsf =3D l_get_le64(data);
+			bss->parent_tsf =3D l_get_u64(data);
 			break;
 		}
 	}
-- =

2.17.1

--===============0892785961859166604==--

