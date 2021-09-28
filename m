Content-Type: multipart/mixed; boundary="===============4343267675036584512=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 5/6] auto-t: hostapd.py: add rekey() utility
Date: Tue, 28 Sep 2021 15:36:08 -0700
Message-ID: <20210928223609.1163537-5-prestwoj@gmail.com>
In-Reply-To: 20210928223609.1163537-1-prestwoj@gmail.com

--===============4343267675036584512==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Forces GTK/PTK rekeys
---
 autotests/util/hostapd.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 7cb3225a..9f2dc745 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -202,6 +202,12 @@ class HostapdCLI(object):
         cmd =3D self.cmdline + ['req_beacon', addr, request]
         ctx.start_process(cmd).wait()
 =

+    def rekey(self, address):
+        cmd =3D 'REKEY_GTK'
+        self.ctrl_sock.sendall(cmd.encode('utf-8'))
+        cmd =3D 'REKEY_PTK %s' % address
+        self.ctrl_sock.sendall(cmd.encode('utf-8'))
+
     @property
     def bssid(self):
         cmd =3D self.cmdline + ['status']
-- =

2.31.1

--===============4343267675036584512==--

