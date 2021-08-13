Content-Type: multipart/mixed; boundary="===============0804005950262785314=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] auto-t: iwd.py: allow renaming in copy_to_storage
Date: Fri, 13 Aug 2021 12:55:06 -0700
Message-ID: <20210813195507.807892-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0804005950262785314==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

By providing a 'name' keyword argument the file copied will be
renamed to that.
---
 autotests/util/iwd.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 36b8f6f9..737b2beb 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -1152,11 +1152,14 @@ class IWD(AsyncOpAbstract):
         fo.close()
 =

     @staticmethod
-    def copy_to_storage(source, storage_dir=3DIWD_STORAGE_DIR):
+    def copy_to_storage(source, storage_dir=3DIWD_STORAGE_DIR, name=3DNone=
):
         import shutil
 =

         assert not os.path.isabs(source)
 =

+        if name:
+            storage_dir +=3D '/%s' % name
+
         shutil.copy(source, storage_dir)
 =

     @staticmethod
-- =

2.31.1

--===============0804005950262785314==--

