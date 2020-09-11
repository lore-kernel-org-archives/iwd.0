Content-Type: multipart/mixed; boundary="===============8731879212309408686=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] auto-t: fix set_neighbor SSID escaping
Date: Fri, 11 Sep 2020 11:11:28 -0700
Message-ID: <20200911181130.73148-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8731879212309408686==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Before the re-write there was interesting escapes being used for
set_neighbor. Curiously now hostapd fails to set the neighbor due
to these escapes so they have been removed.
---
 autotests/util/hostapd.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 3f0edd9e..7c0d8385 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -152,7 +152,7 @@ class HostapdCLI:
         return [line for line in lines.split('\n') if line]
 =

     def set_neighbor(self, addr, ssid, nr):
-        cmd =3D self.cmdline + ['set_neighbor', addr, 'ssid=3D\\""%s"\\"' =
% ssid, 'nr=3D%s' % nr]
+        cmd =3D self.cmdline + ['set_neighbor', addr, 'ssid=3D"%s"' % ssid=
, 'nr=3D%s' % nr]
         ctx.start_process(cmd, wait=3DTrue)
 =

     def send_bss_transition(self, device, nr_list):
-- =

2.26.2

--===============8731879212309408686==--

