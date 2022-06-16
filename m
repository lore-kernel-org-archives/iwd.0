Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2649161
	for <iwd@lists.linux.dev>; Thu, 16 Jun 2022 00:02:49 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so1967378wma.4
        for <iwd@lists.linux.dev>; Wed, 15 Jun 2022 17:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2dDbwvFgz76PsafAvHmieGDJCVxo8ZlIG5n+Gj5BMRg=;
        b=MUv+sXjjZENGkkbEQXEpu5FDx0ss2e3B5BTnqvOpe/MuCs36yIKSZvx4QsCFBQcxy8
         9YJ8TyxnK9lwjgGVYQs5sKGfXK40D8q92VtSxiebGiCz9Ms71zn98D8Oy9OcXB/CDS53
         JEAkCyZLmL34yefBBTadTm0Qzfb9t/qY17n7FxwzpoAH8cQyWFlEgzx4OXnv9ceX9n/S
         qHobpJhsgF6SbZkSgv5DIgXVNYzr+qHi+wuHLa5n43eZGhiPR81ZKHcPReBDsP/vyTYt
         mC5Oy8wqvfLD8TnIaBnpc23+tjbOo1VA7n0RE1iJE/AZe9QqX8MZ0hG46oxYniuedFjb
         iN6g==
X-Gm-Message-State: AOAM532dRf+x7PKwNF4zzkG9ykEBsL0fkDMtMURU24sk8O2yVkzpXKwL
	gH5tYXLyOfdGGlkUp/Blp1OAPrdb16Y=
X-Google-Smtp-Source: ABdhPJzFpQKMpoDQ2lxDUelfUe6xsofXdcjQBye9xG14nHgthHSOVJL5MDME6Q/NlTbcGp4WyAj4dw==
X-Received: by 2002:a05:600c:358c:b0:39c:97ed:baa5 with SMTP id p12-20020a05600c358c00b0039c97edbaa5mr12724779wmq.77.1655337767755;
        Wed, 15 Jun 2022 17:02:47 -0700 (PDT)
Received: from iss.Home ([82.213.231.20])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm337452wrb.45.2022.06.15.17.02.46
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:02:47 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 09/15] autotests: Ensure storage_dir exists, clean up
Date: Thu, 16 Jun 2022 02:02:25 +0200
Message-Id: <20220616000231.1966008-9-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
References: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In iwd.py make sure all the static methods that touch IWD storage take the
storage_dir parameter instead of hardcoding IWD_STORAGE_DIR, and make
sure that parameter is actually used.

Create the directory if it doesn't exist before copying files into it.
This fixes a problem in testNetconfig where

`IWD.copy_to_storage('ssidTKIP.psk', '/tmp/storage')`

would result in /tmp/storage being created as a file, rather than a
directory containing a file, and resulting in IWD failing to start with:

`Failed to create /tmp/storage`

runner.py creates /tmp/iwd but that doesn't account for IWD sessions
with a custom storage dir path.
---
 autotests/testNetconfig/static_test.py |  2 +-
 autotests/util/iwd.py                  | 39 ++++++++++++++++----------
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/autotests/testNetconfig/static_test.py b/autotests/testNetconfig/static_test.py
index e82dbaeb..8d5710c1 100644
--- a/autotests/testNetconfig/static_test.py
+++ b/autotests/testNetconfig/static_test.py
@@ -91,7 +91,7 @@ class Test(unittest.TestCase):
 
     @classmethod
     def tearDownClass(cls):
-        IWD.clear_storage()
+        IWD.clear_storage(storage_dir='/tmp/storage')
         cls.dhcpd_pid.kill()
 
 if __name__ == '__main__':
diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 6cee1e07..f609e37e 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -1086,7 +1086,7 @@ class IWD(AsyncOpAbstract):
     psk_agent = None
 
     def __init__(self, start_iwd_daemon = False, iwd_config_dir = '/tmp',
-                            iwd_storage_dir = '/tmp/iwd', namespace=ctx):
+                            iwd_storage_dir = IWD_STORAGE_DIR, namespace=ctx):
         self.namespace = namespace
         self._bus = namespace.get_bus()
 
@@ -1197,40 +1197,49 @@ class IWD(AsyncOpAbstract):
         os.system('rm -rf ' + storage_dir + '/ap/*')
 
     @staticmethod
-    def create_in_storage(file_name, file_content):
-        fo = open(IWD_STORAGE_DIR + '/' + file_name, 'w')
+    def create_in_storage(file_name, file_content, storage_dir=IWD_STORAGE_DIR):
+        fo = open(storage_dir + '/' + file_name, 'w')
 
         fo.write(file_content)
         fo.close()
 
+    @staticmethod
+    def _ensure_storage_dir_exists(storage_dir):
+        if not os.path.exists(storage_dir):
+            os.mkdir(storage_dir)
+
     @staticmethod
     def copy_to_storage(source, storage_dir=IWD_STORAGE_DIR, name=None):
         import shutil
 
         assert not os.path.isabs(source)
 
+        target = storage_dir
         if name:
-            storage_dir += '/%s' % name
+            target += '/%s' % name
 
-        shutil.copy(source, storage_dir)
+        IWD._ensure_storage_dir_exists(storage_dir)
+        shutil.copy(source, target)
 
     @staticmethod
-    def copy_to_hotspot(source):
-        if not os.path.exists(IWD_STORAGE_DIR + "/hotspot"):
-            os.mkdir(IWD_STORAGE_DIR + "/hotspot")
+    def copy_to_hotspot(source, storage_dir=IWD_STORAGE_DIR):
+        IWD._ensure_storage_dir_exists(storage_dir)
+
+        if not os.path.exists(storage_dir + "/hotspot"):
+            os.mkdir(storage_dir + "/hotspot")
 
-        IWD.copy_to_storage(source, IWD_STORAGE_DIR + "/hotspot")
+        IWD.copy_to_storage(source, storage_dir + "/hotspot")
 
     @staticmethod
-    def copy_to_ap(source):
-        if not os.path.exists(IWD_STORAGE_DIR + "/ap"):
-            os.mkdir(IWD_STORAGE_DIR + "/ap")
+    def copy_to_ap(source, storage_dir=IWD_STORAGE_DIR):
+        if not os.path.exists(storage_dir + "/ap"):
+            os.mkdir(storage_dir + "/ap")
 
-        IWD.copy_to_storage(source, IWD_STORAGE_DIR + '/ap/')
+        IWD.copy_to_storage(source, storage_dir + '/ap/')
 
     @staticmethod
-    def remove_from_storage(file_name):
-        os.system('rm -rf ' + IWD_STORAGE_DIR + '/\'' + file_name + '\'')
+    def remove_from_storage(file_name, storage_dir=IWD_STORAGE_DIR):
+        os.system('rm -rf ' + storage_dir + '/\'' + file_name + '\'')
 
     def list_devices(self, wait_to_appear = 0, max_wait = 50, p2p = False):
         if not wait_to_appear:
-- 
2.34.1

