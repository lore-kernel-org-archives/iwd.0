Content-Type: multipart/mixed; boundary="===============4344829155972298354=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] ip-pool: Make host address valid even if prefix_len != 24
Date: Mon, 07 Jun 2021 23:26:26 +0200
Message-ID: <20210607212627.244204-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4344829155972298354==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

At the end of ip_pool_select_addr4() we'd check if the selected address
is equal to the subnet address and increment it by 1 to produce a valid
host address for the AP.  That check was always correct only with 24-bit
prefix, extend it to actually use the prefix-dependent mask instead of
0xff.  Fixes a testAP failure triggered 50% of the times because the
netmask is 28 bit long there.
---
 src/ip-pool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/ip-pool.c b/src/ip-pool.c
index 42c96bb4..e3f02d5e 100644
--- a/src/ip-pool.c
+++ b/src/ip-pool.c
@@ -236,7 +236,7 @@ check_avail:
 		selected -=3D count;
 	}
 =

-	if ((host_addr & 0xff) =3D=3D 0)
+	if ((host_addr & host_mask) =3D=3D 0)
 		host_addr +=3D 1;
 =

 done:
-- =

2.30.2

--===============4344829155972298354==--

