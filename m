Content-Type: multipart/mixed; boundary="===============1758178277620608599=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/4] auto-t: iwd.py: use args[0] for station debug interface
Date: Mon, 22 Nov 2021 12:44:24 -0800
Message-ID: <20211122204425.3567479-3-prestwoj@gmail.com>
In-Reply-To: 20211122204425.3567479-1-prestwoj@gmail.com

--===============1758178277620608599==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Passing *args, **kwargs into StationDebug ended up initializing the
class with Station properties since devices can be initialized from
existing property dictionaries. Since the object path is all
StationDebug needs, pass args[0] instead.
---
 autotests/util/iwd.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 5e1e2721..185a31fe 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -287,7 +287,7 @@ class Device(IWDDBusAbstract):
 =

         IWDDBusAbstract.__init__(self, *args, **kwargs)
 =

-        self._station_debug =3D StationDebug(*args, **kwargs)
+        self._station_debug =3D StationDebug(args[0])
 =

     @property
     def _wps_manager(self):
-- =

2.31.1

--===============1758178277620608599==--

