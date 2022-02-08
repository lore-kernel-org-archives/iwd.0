Content-Type: multipart/mixed; boundary="===============1377556826837740633=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/2] auto-t: iwd.py: add wait argument to scan()
Date: Tue, 08 Feb 2022 09:35:38 -0800
Message-ID: <20220208173539.493712-1-prestwoj@gmail.com>

--===============1377556826837740633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Lets the test continue without waiting for the method return
---
 autotests/util/iwd.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 54b4819e..170dd96b 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -450,7 +450,7 @@ class Device(IWDDBusAbstract):
         self._station_debug._prop_proxy.Set(IWD_STATION_DEBUG_INTERFACE,
                                             'AutoConnect', value)
 =

-    def scan(self):
+    def scan(self, wait=3DTrue):
         '''Schedule a network scan.
 =

            Possible exception: BusyEx
@@ -460,7 +460,8 @@ class Device(IWDDBusAbstract):
                                reply_handler=3Dself._success,
                                error_handler=3Dself._failure)
 =

-        self._wait_for_async_op()
+        if wait:
+            self._wait_for_async_op()
 =

     def disconnect(self):
         '''Disconnect from the network
-- =

2.31.1

--===============1377556826837740633==--

