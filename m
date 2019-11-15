Content-Type: multipart/mixed; boundary="===============4060781325108464455=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] auto-t: add RRM test for scan duration
Date: Fri, 15 Nov 2019 10:06:08 -0800
Message-ID: <20191115180608.31564-4-prestwoj@gmail.com>
In-Reply-To: <20191115180608.31564-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4060781325108464455==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mac80211_hwsim does not actually support SET_SCAN_DWELL, but since we are
not setting duration mandatory the request should still be accepted.
---
 autotests/testRRM/connection_test.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/autotests/testRRM/connection_test.py b/autotests/testRRM/conne=
ction_test.py
index 93fd6cb8..74733e19 100644
--- a/autotests/testRRM/connection_test.py
+++ b/autotests/testRRM/connection_test.py
@@ -21,6 +21,8 @@ beacon_with_ssid =3D '51000000000002ffffffffffff020100000=
77373696452524d'
 beacon_passive =3D '510b0000000000ffffffffffff020100'
 # Active beacon with wildcard BSSID
 beacon_active =3D '510b0000000001ffffffffffff020100'
+# Passive beacon with duration set
+beacon_passive_duration =3D '510b0000c80000ffffffffffff020100'
 =

 class Test(unittest.TestCase):
 =

@@ -91,6 +93,16 @@ class Test(unittest.TestCase):
         hapd.req_beacon(device.address, beacon_active)
         # TODO: See if we are scanning here (scan not initiated from stati=
on)
 =

+        event =3D hapd.wait_for_event('BEACON-RESP-RX')
+        if event:
+            print(event)
+
+        sleep(0.5)
+
+         # This should passive scan on channel 11, returning otherSSID
+        hapd.req_beacon(device.address, beacon_passive_duration)
+        # TODO: See if we are scanning here (scan not initiated from stati=
on)
+
         event =3D hapd.wait_for_event('BEACON-RESP-RX')
         if event:
             print(event)
-- =

2.17.1

--===============4060781325108464455==--

