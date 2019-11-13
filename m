Content-Type: multipart/mixed; boundary="===============3278472433649693116=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/5] auto-t: add ctrl_interface to testHotspot
Date: Wed, 13 Nov 2019 14:30:31 -0800
Message-ID: <20191113223032.5650-4-prestwoj@gmail.com>
In-Reply-To: <20191113223032.5650-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3278472433649693116==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is now required for any test using HostapdCLI
---
 autotests/testHotspot/ssidHotspotUnconfigured.conf | 1 +
 autotests/testHotspot/ssidWPA2-1.conf              | 1 +
 autotests/testHotspot/ssidWPA2-2.conf              | 1 +
 autotests/testHotspot/ssidWPA2-3.conf              | 1 +
 4 files changed, 4 insertions(+)

diff --git a/autotests/testHotspot/ssidHotspotUnconfigured.conf b/autotests=
/testHotspot/ssidHotspotUnconfigured.conf
index 5eff0b10..287dab6c 100644
--- a/autotests/testHotspot/ssidHotspotUnconfigured.conf
+++ b/autotests/testHotspot/ssidHotspotUnconfigured.conf
@@ -1,3 +1,4 @@
+ctrl_interface=3D/var/run/hostapd
 hw_mode=3Dg
 channel=3D1
 wpa=3D2
diff --git a/autotests/testHotspot/ssidWPA2-1.conf b/autotests/testHotspot/=
ssidWPA2-1.conf
index bc1b760c..0c9aede5 100644
--- a/autotests/testHotspot/ssidWPA2-1.conf
+++ b/autotests/testHotspot/ssidWPA2-1.conf
@@ -1,3 +1,4 @@
+ctrl_interface=3D/var/run/hostapd
 hw_mode=3Dg
 channel=3D2
 ssid=3DssidWPA2-1
diff --git a/autotests/testHotspot/ssidWPA2-2.conf b/autotests/testHotspot/=
ssidWPA2-2.conf
index 59b05986..2058d4a3 100644
--- a/autotests/testHotspot/ssidWPA2-2.conf
+++ b/autotests/testHotspot/ssidWPA2-2.conf
@@ -1,3 +1,4 @@
+ctrl_interface=3D/var/run/hostapd
 hw_mode=3Dg
 channel=3D3
 ssid=3DssidWPA2-2
diff --git a/autotests/testHotspot/ssidWPA2-3.conf b/autotests/testHotspot/=
ssidWPA2-3.conf
index c330eb8a..d536ebd1 100644
--- a/autotests/testHotspot/ssidWPA2-3.conf
+++ b/autotests/testHotspot/ssidWPA2-3.conf
@@ -1,3 +1,4 @@
+ctrl_interface=3D/var/run/hostapd
 hw_mode=3Dg
 channel=3D4
 ssid=3DssidWPA2-3
-- =

2.17.1

--===============3278472433649693116==--

