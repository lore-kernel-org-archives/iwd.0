Content-Type: multipart/mixed; boundary="===============5938327185759021116=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 2/3] auto-t: hostapd.py: add remove_neighbor()
Date: Wed, 19 Jan 2022 14:26:51 -0800
Message-ID: <20220119222652.2299217-2-prestwoj@gmail.com>
In-Reply-To: 20220119222652.2299217-1-prestwoj@gmail.com

--===============5938327185759021116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/hostapd.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 97422efc..4ae7c42d 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -168,6 +168,10 @@ class HostapdCLI(object):
         cmd =3D self.cmdline + ['set_neighbor', addr, 'ssid=3D"%s"' % ssid=
, 'nr=3D%s' % nr]
         ctx.start_process(cmd).wait()
 =

+    def remove_neighbor(self, addr):
+        cmd =3D self.cmdline + ['remove_neighbor', addr]
+        ctx.start_process(cmd).wait()
+
     def send_bss_transition(self, device, nr_list):
         # Send a BSS transition to a station (device). nr_list should be an
         # array of tuples containing the BSS address and neighbor report.
-- =

2.31.1

--===============5938327185759021116==--

