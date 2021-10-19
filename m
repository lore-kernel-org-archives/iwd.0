Content-Type: multipart/mixed; boundary="===============8916358153967541312=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 7/8] auto-t: hostapd.py: add chan_switch()
Date: Tue, 19 Oct 2021 11:19:09 -0700
Message-ID: <20211019181910.558043-7-prestwoj@gmail.com>
In-Reply-To: 20211019181910.558043-1-prestwoj@gmail.com

--===============8916358153967541312==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Forces hostapd to channel switch
---
 autotests/util/hostapd.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 5d17da6b..97422efc 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -216,6 +216,14 @@ class HostapdCLI(object):
         cmd =3D 'RESEND_M3 %s' % address
         self.ctrl_sock.sendall(cmd.encode('utf-8'))
 =

+    def chan_switch(self, channel):
+        if channel > len(chan_freq_map):
+            raise Exception("Only 2.4GHz channels supported for chan_switc=
h")
+
+        cmd =3D self.cmdline + ['chan_switch', '50', str(chan_freq_map[cha=
nnel])]
+        ctx.start_process(cmd).wait()
+        self.wait_for_event('AP-CSA-FINISHED')
+
     @property
     def bssid(self):
         cmd =3D self.cmdline + ['status']
-- =

2.31.1

--===============8916358153967541312==--

