Content-Type: multipart/mixed; boundary="===============0911523423713384788=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] auto-t: simplify copy_to_hotspot
Date: Wed, 04 Nov 2020 08:48:09 -0800
Message-ID: <20201104164810.2777541-2-prestwoj@gmail.com>
In-Reply-To: <20201104164810.2777541-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0911523423713384788==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since copy_to_storage can take an arbitrary destination path now
we can reuse that instead of duplicating code.
---
 autotests/util/iwd.py | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 775fc6a5..d7235f2d 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -1055,14 +1055,10 @@ class IWD(AsyncOpAbstract):
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

--===============0911523423713384788==--

