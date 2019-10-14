Content-Type: multipart/mixed; boundary="===============6993047152695182961=="
MIME-Version: 1.0
From: Florian Klink <flokli@flokli.de>
Subject: [PATCH] doc: fix typo systemd->system
Date: Mon, 14 Oct 2019 23:11:57 +0200
Message-ID: <20191014211157.26340-1-flokli@flokli.de>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6993047152695182961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Even though this is equal on most distros, we're not quite there yet.
---
 src/iwd.conf.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/iwd.conf.rst b/src/iwd.conf.rst
index 34d54df0..e70eedf1 100644
--- a/src/iwd.conf.rst
+++ b/src/iwd.conf.rst
@@ -21,7 +21,7 @@ SYNOPSIS
 DESCRIPTION
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-The /etc/iwd/main.conf file configures the systemd-wide settings for iwd(8)
+The /etc/iwd/main.conf file configures the system-wide settings for iwd(8).
 =

 SEE ALSO
 =3D=3D=3D=3D=3D=3D=3D=3D
-- =

2.23.0

--===============6993047152695182961==--

