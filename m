Content-Type: multipart/mixed; boundary="===============4769064744013239161=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 03/11] auto-t: fix hwsim.py to use Destroy rather than Remove
Date: Thu, 17 Dec 2020 11:36:03 -0800
Message-ID: <20201217193611.1177006-3-prestwoj@gmail.com>
In-Reply-To: <20201217193611.1177006-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4769064744013239161==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is no Remove() method, but since this code never was used it
remained incorrect for quite some time.
---
 autotests/util/hwsim.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index 415bfc90..b0e6a089 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -203,7 +203,7 @@ class Radio(HwsimDBusAbstract):
         return [str(addr) for addr in self._properties['Addresses']]
 =

     def remove(self):
-        self._iface.Remove(reply_handler=3Dself._success,
+        self._iface.Destroy(reply_handler=3Dself._success,
                 error_handler=3Dself._failure)
 =

         self._wait_for_async_op()
-- =

2.26.2

--===============4769064744013239161==--

