Content-Type: multipart/mixed; boundary="===============8734947548357877804=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/9] auto-t: hostapd: catch local socket remove exception
Date: Thu, 29 Jul 2021 15:21:47 -0700
Message-ID: <20210729222154.159542-2-prestwoj@gmail.com>
In-Reply-To: <20210729222154.159542-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8734947548357877804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This happens if hostapd is killed ungracefully which is done in
some tests.
---
 autotests/util/hostapd.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 4e694c84..6031b1dc 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -118,7 +118,11 @@ class HostapdCLI:
             return
 =

         self.ctrl_sock.close()
-        os.remove(self.local_ctrl)
+
+        try:
+            os.remove(self.local_ctrl)
+        except:
+            pass
 =

         if self._hostapd_restarted:
             ctx.stop_process(ctx.hostapd.process, force)
-- =

2.31.1

--===============8734947548357877804==--

