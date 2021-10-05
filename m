Content-Type: multipart/mixed; boundary="===============4847610455538422351=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 09/11] auto-t: hostapd.py: separate GTK and PTK rekeys
Date: Tue, 05 Oct 2021 15:00:49 -0700
Message-ID: <20211005220051.4018694-9-prestwoj@gmail.com>
In-Reply-To: 20211005220051.4018694-1-prestwoj@gmail.com

--===============4847610455538422351==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

REKEY_GTK kicks off the GTK only handshake where REKEY_PTK does
both (via the 4-way). The way this utility was written was causing
hostapd some major issues since both REKEY_GTK and REKEY_PTK was
used.

Instead if address is set only do REKEY_PTK. This will also rekey
the GTK via the 4-way handshake.

If no address is set do REKEY_GTK which will only rekey the GTK.
---
 autotests/util/hostapd.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 9f2dc745..22802be6 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -202,11 +202,15 @@ class HostapdCLI(object):
         cmd =3D self.cmdline + ['req_beacon', addr, request]
         ctx.start_process(cmd).wait()
 =

-    def rekey(self, address):
+    def rekey(self, address=3DNone):
+        if address:
+            cmd =3D 'REKEY_PTK %s' % address
+            self.ctrl_sock.sendall(cmd.encode('utf-8'))
+            self.wait_for_event('EAPOL-4WAY-HS-COMPLETED')
+            return
+
         cmd =3D 'REKEY_GTK'
         self.ctrl_sock.sendall(cmd.encode('utf-8'))
-        cmd =3D 'REKEY_PTK %s' % address
-        self.ctrl_sock.sendall(cmd.encode('utf-8'))
 =

     @property
     def bssid(self):
-- =

2.31.1

--===============4847610455538422351==--

