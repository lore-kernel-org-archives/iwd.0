Content-Type: multipart/mixed; boundary="===============4821634333595941082=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: fix hostapd.ungraceful_restart
Date: Mon, 13 Jul 2020 11:02:01 -0700
Message-ID: <20200713180201.21931-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4821634333595941082==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was killing hostapd, but not re-initializing any of the
control socket information so any use of hostapd.wait_for_event
after hostapd.ungraceful_restart would cause an exception.
---
 autotests/util/hostapd.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 49047f38..c3a4a0d0 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -193,6 +193,8 @@ class HostapdCLI:
         '''
             Ungracefully kill and restart hostapd
         '''
+        self.ctrl_sock.close()
+
         intf =3D hostapd_map[self.ifname]
         os.system('killall -9 hostapd')
         os.system('ifconfig %s down' % intf.name)
@@ -203,6 +205,9 @@ class HostapdCLI:
         # set flag so hostapd can be killed after the test
         self._hostapd_restarted =3D True
 =

+        # New hostapd process, so re-init
+        self.__init__(intf)
+
     def req_beacon(self, addr, request):
         '''
             Send a RRM Beacon request
-- =

2.21.1

--===============4821634333595941082==--

