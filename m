Content-Type: multipart/mixed; boundary="===============6263626252671436184=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/6] scan: parse parent TSF value in scan results
Date: Wed, 20 Nov 2019 09:25:55 -0800
Message-ID: <20191120172559.21029-2-prestwoj@gmail.com>
In-Reply-To: <20191120172559.21029-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6263626252671436184==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

RRM can include this in measurement reports if present in scans
---
 src/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

--===============6263626252671436184==--

