Content-Type: multipart/mixed; boundary="===============8947533950764043352=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 02/13] auto-t: add copy_to_ap utility
Date: Tue, 20 Oct 2020 11:02:45 -0700
Message-ID: <20201020180256.1630120-2-prestwoj@gmail.com>
In-Reply-To: <20201020180256.1630120-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8947533950764043352==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/iwd.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index dc4f93a2..fb22412d 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -1027,6 +1027,7 @@ class IWD(AsyncOpAbstract):
     def clear_storage(storage_dir=3DIWD_STORAGE_DIR):
         os.system('rm -rf ' + storage_dir + '/*')
         os.system('rm -rf ' + storage_dir + '/hotspot/*')
+        os.system('rm -rf ' + storage_dir + '/ap/*')
 =

     @staticmethod
     def create_in_storage(file_name, file_content):
@@ -1054,6 +1055,13 @@ class IWD(AsyncOpAbstract):
 =

         shutil.copy(source, IWD_STORAGE_DIR + "/hotspot")
 =

+    @staticmethod
+    def copy_to_ap(source):
+        if not os.path.exists(IWD_STORAGE_DIR + "/ap"):
+            os.mkdir(IWD_STORAGE_DIR + "/ap")
+
+        IWD.copy_to_storage(source, IWD_STORAGE_DIR + '/ap/')
+
     @staticmethod
     def remove_from_storage(file_name):
         os.system('rm -rf ' + IWD_STORAGE_DIR + '/\'' + file_name + '\'')
-- =

2.26.2

--===============8947533950764043352==--

