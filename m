Content-Type: multipart/mixed; boundary="===============9138450942613123945=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/2] auto-t: fix eapol_reauth utility
Date: Tue, 24 May 2022 13:31:44 -0700
Message-ID: <20220524203145.3218063-1-prestwoj@gmail.com>

--===============9138450942613123945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This was passing IFNAME=3D along with EAPOL_REAUTH which does not work
in the context of a hostapd socket where the iface is already implied.
This fixes that issue as well as resets the events array and actually
waits for the required events afterwards.
---
 autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py | 3 ---
 autotests/util/hostapd.py                            | 5 ++++-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py b/autotes=
ts/testEAP-PEAPv0-CryptoBinding/NoISK_test.py
index 9a1fa52c..0323fdc1 100644
--- a/autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py
+++ b/autotests/testEAP-PEAPv0-CryptoBinding/NoISK_test.py
@@ -37,9 +37,6 @@ class Test(unittest.TestCase):
 =

         hostapd.eapol_reauth(device.address)
 =

-        hostapd.wait_for_event('CTRL-EVENT-EAP-STARTED')
-        hostapd.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
-
         condition =3D 'obj.state =3D=3D DeviceState.connected'
         wd.wait_for_object_condition(device, condition)
 =

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 6a9f37c7..ff5a97c1 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -163,8 +163,11 @@ class HostapdCLI(object):
         ctx.start_process(cmd).wait()
 =

     def eapol_reauth(self, client_address):
-        cmd =3D 'IFNAME=3D' + self.ifname + ' EAPOL_REAUTH ' + client_addr=
ess
+        self.events =3D []
+        cmd =3D 'EAPOL_REAUTH ' + client_address
         self.ctrl_sock.sendall(cmd.encode('utf-8'))
+        self.wait_for_event('CTRL-EVENT-EAP-STARTED')
+        self.wait_for_event('CTRL-EVENT-EAP-SUCCESS')
 =

     def reload(self):
         # Seemingly all three commands needed for the instance to notice
-- =

2.34.1

--===============9138450942613123945==--

