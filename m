Content-Type: multipart/mixed; boundary="===============0150037332574784644=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 06/13] p2p: Add a null-check before use
Date: Fri, 31 Jul 2020 03:31:29 +0200
Message-ID: <20200731013136.65057-6-andrew.zaborowski@intel.com>
In-Reply-To: <20200731013136.65057-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0150037332574784644==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

p2p_connection_reset may be called as a result of a WFD service
unregistering and p2p_own_wfd is going to be NULL, don't update
p2p_own_wfd->available in this case.
---
 src/p2p.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/p2p.c b/src/p2p.c
index aaecb8ee..06416bd8 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -486,7 +486,9 @@ static void p2p_connection_reset(struct p2p_device *dev)
 	if (dev->conn_own_wfd) {
 		l_free(dev->conn_own_wfd);
 		dev->conn_own_wfd =3D NULL;
-		p2p_own_wfd->available =3D true;
+
+		if (p2p_own_wfd)
+			p2p_own_wfd->available =3D true;
 	}
 =

 	explicit_bzero(dev->conn_psk, 32);
-- =

2.25.1

--===============0150037332574784644==--

