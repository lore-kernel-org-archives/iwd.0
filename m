Content-Type: multipart/mixed; boundary="===============2292671113116648427=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] auto-t: hostapd.py: update Process changes
Date: Wed, 25 Aug 2021 15:17:24 -0700
Message-ID: <20210825221726.784086-2-prestwoj@gmail.com>
In-Reply-To: <20210825221726.784086-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2292671113116648427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/hostapd.py | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 2dcf38f9..10104862 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -132,18 +132,18 @@ class HostapdCLI(object):
 =

     def set_value(self, key, value):
         cmd =3D self.cmdline + ['set', key, value]
-        ctx.start_process(cmd, wait=3DTrue)
+        ctx.start_process(cmd).wait()
 =

     def wps_push_button(self):
-        ctx.start_process(self.cmdline + ['wps_pbc'], wait=3DTrue)
+        ctx.start_process(self.cmdline + ['wps_pbc']).wait()
 =

     def wps_pin(self, pin):
         cmd =3D self.cmdline + ['wps_pin', 'any', pin]
-        ctx.start_process(cmd, wait=3DTrue)
+        ctx.start_process(cmd).wait()
 =

     def deauthenticate(self, client_address):
         cmd =3D self.cmdline + ['deauthenticate', client_address]
-        ctx.start_process(cmd, wait=3DTrue)
+        ctx.start_process(cmd).wait()
 =

     def eapol_reauth(self, client_address):
         cmd =3D 'IFNAME=3D' + self.ifname + ' EAPOL_REAUTH ' + client_addr=
ess
@@ -152,12 +152,13 @@ class HostapdCLI(object):
     def reload(self):
         # Seemingly all three commands needed for the instance to notice
         # interface's address change
-        ctx.start_process(self.cmdline + ['reload'], wait=3DTrue)
-        ctx.start_process(self.cmdline + ['disable'], wait=3DTrue)
-        ctx.start_process(self.cmdline + ['enable'], wait=3DTrue)
+        ctx.start_process(self.cmdline + ['reload']).wait()
+        ctx.start_process(self.cmdline + ['disable']).wait()
+        ctx.start_process(self.cmdline + ['enable']).wait()
 =

     def list_sta(self):
-        proc =3D ctx.start_process(self.cmdline + ['list_sta'], wait=3DTru=
e, need_out=3DTrue)
+        proc =3D ctx.start_process(self.cmdline + ['list_sta'])
+        proc.wait()
 =

         if not proc.out:
             return []
@@ -166,7 +167,7 @@ class HostapdCLI(object):
 =

     def set_neighbor(self, addr, ssid, nr):
         cmd =3D self.cmdline + ['set_neighbor', addr, 'ssid=3D"%s"' % ssid=
, 'nr=3D%s' % nr]
-        ctx.start_process(cmd, wait=3DTrue)
+        ctx.start_process(cmd).wait()
 =

     def send_bss_transition(self, device, nr_list):
         # Send a BSS transition to a station (device). nr_list should be an
@@ -189,7 +190,8 @@ class HostapdCLI(object):
                         (addr, bss_info, op_class, chan_num, phy_num)]
             pref +=3D 1
 =

-        proc =3D ctx.start_process(cmd, wait=3DTrue, need_out=3DTrue)
+        proc =3D ctx.start_process(cmd)
+        proc.wait()
 =

         if 'OK' not in proc.out:
             raise Exception('BSS_TM_REQ failed, is hostapd built with CONF=
IG_WNM_AP=3Dy?')
@@ -199,13 +201,14 @@ class HostapdCLI(object):
             Send a RRM Beacon request
         '''
         cmd =3D self.cmdline + ['req_beacon', addr, request]
-        ctx.start_process(cmd, wait=3DTrue)
+        ctx.start_process(cmd).wait()
 =

     @property
     def bssid(self):
         cmd =3D self.cmdline + ['status']
-        status =3D ctx.start_process(cmd, wait=3DTrue, need_out=3DTrue).out
-        status =3D status.split('\n')
+        proc =3D ctx.start_process(cmd)
+        proc.wait()
+        status =3D proc.out.split('\n')
 =

         bssid =3D [x for x in status if x.startswith('bssid')]
         bssid =3D bssid[0].split('=3D')
@@ -214,8 +217,9 @@ class HostapdCLI(object):
     @property
     def frequency(self):
         cmd =3D self.cmdline + ['status']
-        status =3D ctx.start_process(cmd, wait=3DTrue, need_out=3DTrue).out
-        status =3D status.split('\n')
+        proc =3D ctx.start_process(cmd)
+        proc.wait()
+        status =3D proc.out.split('\n')
 =

         frequency =3D [x for x in status if x.startswith('freq')][0]
         frequency =3D frequency.split('=3D')[1]
-- =

2.31.1

--===============2292671113116648427==--

