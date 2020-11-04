Content-Type: multipart/mixed; boundary="===============7564581436653137616=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] auto-t: add copy_to_ap utility
Date: Wed, 04 Nov 2020 08:48:08 -0800
Message-ID: <20201104164810.2777541-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7564581436653137616==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/iwd.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 3ffd9f23..775fc6a5 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -1036,6 +1036,7 @@ class IWD(AsyncOpAbstract):
     def clear_storage(storage_dir=3DIWD_STORAGE_DIR):
         os.system('rm -rf ' + storage_dir + '/*')
         os.system('rm -rf ' + storage_dir + '/hotspot/*')
+        os.system('rm -rf ' + storage_dir + '/ap/*')
 =

     @staticmethod
     def create_in_storage(file_name, file_content):
@@ -1063,6 +1064,13 @@ class IWD(AsyncOpAbstract):
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

--===============7564581436653137616==--

