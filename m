Content-Type: multipart/mixed; boundary="===============5769388382740364832=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 11/13] build: add ELL dhcp-util.c to build
Date: Tue, 20 Oct 2020 11:02:54 -0700
Message-ID: <20201020180256.1630120-11-prestwoj@gmail.com>
In-Reply-To: <20201020180256.1630120-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5769388382740364832==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.am b/Makefile.am
index 1ee414cb..7ed8baa9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -121,6 +121,7 @@ ell_sources =3D ell/private.h \
 			ell/dhcp-transport.c \
 			ell/dhcp-lease.c \
 			ell/dhcp-util.c \
+			ell/dhcp-server.c \
 			ell/cert-private.h \
 			ell/cert.c \
 			ell/ecc-external.c \
-- =

2.26.2

--===============5769388382740364832==--

