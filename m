Content-Type: multipart/mixed; boundary="===============5810835225700906875=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 06/17] auto-t: iwd.py: release namespace on IWD close
Date: Thu, 25 Feb 2021 14:00:55 -0800
Message-ID: <20210225220106.1728411-6-prestwoj@gmail.com>
In-Reply-To: <20210225220106.1728411-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5810835225700906875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/iwd.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 8ea1dfb9..6cd7a1a8 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -989,6 +989,8 @@ class IWD(AsyncOpAbstract):
             self.namespace.stop_process(self._iwd_proc)
             self._iwd_proc =3D None
 =

+        self.namespace =3D None
+
     @property
     def _object_manager(self):
         if self._object_manager_if is None:
-- =

2.26.2

--===============5810835225700906875==--

