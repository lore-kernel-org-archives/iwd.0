Content-Type: multipart/mixed; boundary="===============1409669180041021924=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 03/13] auto-t: simplify copy_to_hotspot
Date: Tue, 20 Oct 2020 11:02:46 -0700
Message-ID: <20201020180256.1630120-3-prestwoj@gmail.com>
In-Reply-To: <20201020180256.1630120-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1409669180041021924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since copy_to_storage can take an arbitrary destination path now
we can reuse that instead of duplicating code.
---
 autotests/util/iwd.py | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index fb22412d..9bfc8c1a 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -1046,14 +1046,10 @@ class IWD(AsyncOpAbstract):
 =

     @staticmethod
     def copy_to_hotspot(source):
-        import shutil
-
-        assert not os.path.isabs(source)
-
         if not os.path.exists(IWD_STORAGE_DIR + "/hotspot"):
             os.mkdir(IWD_STORAGE_DIR + "/hotspot")
 =

-        shutil.copy(source, IWD_STORAGE_DIR + "/hotspot")
+        IWD.copy_to_storage(source, IWD_STORAGE_DIR + "/hotspot")
 =

     @staticmethod
     def copy_to_ap(source):
-- =

2.26.2

--===============1409669180041021924==--

