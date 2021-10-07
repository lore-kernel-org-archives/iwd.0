Content-Type: multipart/mixed; boundary="===============4082298933110464824=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 11/13] auto-t: hostapd.py: add resend_m3
Date: Thu, 07 Oct 2021 13:49:55 -0700
Message-ID: <20211007204957.3745985-11-prestwoj@gmail.com>
In-Reply-To: 20211007204957.3745985-1-prestwoj@gmail.com

--===============4082298933110464824==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This forces hostapd to resend message 3 of the 4-way handshake
---
 autotests/util/hostapd.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 22802be6..5d17da6b 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -212,6 +212,10 @@ class HostapdCLI(object):
         cmd =3D 'REKEY_GTK'
         self.ctrl_sock.sendall(cmd.encode('utf-8'))
 =

+    def resend_m3(self, address):
+        cmd =3D 'RESEND_M3 %s' % address
+        self.ctrl_sock.sendall(cmd.encode('utf-8'))
+
     @property
     def bssid(self):
         cmd =3D self.cmdline + ['status']
-- =

2.31.1

--===============4082298933110464824==--

