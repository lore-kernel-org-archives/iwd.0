Content-Type: multipart/mixed; boundary="===============6160633917992184393=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/5] auto-t: add ctrl_interface to testOWE
Date: Wed, 13 Nov 2019 14:30:28 -0800
Message-ID: <20191113223032.5650-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6160633917992184393==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is now required for any test using HostapdCLI
---
 autotests/testOWE/ssidGroup20.conf | 1 +
 autotests/testOWE/ssidOWE.conf     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/autotests/testOWE/ssidGroup20.conf b/autotests/testOWE/ssidGro=
up20.conf
index 72f84091..afd5c0a4 100644
--- a/autotests/testOWE/ssidGroup20.conf
+++ b/autotests/testOWE/ssidGroup20.conf
@@ -1,3 +1,4 @@
+ctrl_interface=3D/var/run/hostapd
 hw_mode=3Dg
 channel=3D1
 ssid=3DssidGroup20
diff --git a/autotests/testOWE/ssidOWE.conf b/autotests/testOWE/ssidOWE.conf
index b9c79d82..a0a4f26c 100644
--- a/autotests/testOWE/ssidOWE.conf
+++ b/autotests/testOWE/ssidOWE.conf
@@ -1,3 +1,4 @@
+ctrl_interface=3D/var/run/hostapd
 hw_mode=3Dg
 channel=3D1
 ssid=3DssidOWE
-- =

2.17.1

--===============6160633917992184393==--

