Content-Type: multipart/mixed; boundary="===============1458315613795658254=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/6] auto-t: modify copy_to_storage to take optional dir
Date: Thu, 17 Sep 2020 14:32:42 -0700
Message-ID: <20200917213247.788181-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1458315613795658254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is to prepare for testing EAD, and in this case we need
to copy the 8021x config to /var/lib/ead instead of IWD's
config dir.
---
 autotests/util/iwd.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 67bb6e41..e812a4e4 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -921,12 +921,12 @@ class IWD(AsyncOpAbstract):
         fo.close()
 =

     @staticmethod
-    def copy_to_storage(source):
+    def copy_to_storage(source, storage_dir=3DIWD_STORAGE_DIR):
         import shutil
 =

         assert not os.path.isabs(source)
 =

-        shutil.copy(source, IWD_STORAGE_DIR)
+        shutil.copy(source, storage_dir)
 =

     @staticmethod
     def copy_to_hotspot(source):
-- =

2.26.2

--===============1458315613795658254==--

