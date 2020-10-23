Content-Type: multipart/mixed; boundary="===============5323028848243723798=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] auto-t: wait for mode change to finish on stop_ap
Date: Fri, 23 Oct 2020 15:18:59 -0700
Message-ID: <20201023221900.1974722-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5323028848243723798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/iwd.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 9bfc8c1a..c65dd4a2 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -481,7 +481,10 @@ class Device(IWDDBusAbstract):
         self._wait_for_async_op()
 =

     def stop_ap(self):
-        self._prop_proxy.Set(IWD_DEVICE_INTERFACE, 'Mode', 'station')
+        self._prop_proxy.Set(IWD_DEVICE_INTERFACE, 'Mode', 'station',
+                                reply_handler=3Dself._success,
+                                error_handler=3Dself._failure)
+        self._wait_for_async_op()
 =

     def connect_hidden_network(self, name):
         '''Connect to a hidden network
-- =

2.26.2

--===============5323028848243723798==--

