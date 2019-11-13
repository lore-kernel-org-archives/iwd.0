Content-Type: multipart/mixed; boundary="===============4987585863217977716=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/5] auto-t: add ctrl_interface to testFILS
Date: Wed, 13 Nov 2019 14:30:29 -0800
Message-ID: <20191113223032.5650-2-prestwoj@gmail.com>
In-Reply-To: <20191113223032.5650-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4987585863217977716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is now required for any test using HostapdCLI
---
 autotests/testFILS/ssidFILS-256.conf | 1 +
 autotests/testFILS/ssidFILS-384.conf | 1 +
 2 files changed, 2 insertions(+)

diff --git a/autotests/testFILS/ssidFILS-256.conf b/autotests/testFILS/ssid=
FILS-256.conf
index bf86d3f4..b3f3139a 100644
--- a/autotests/testFILS/ssidFILS-256.conf
+++ b/autotests/testFILS/ssidFILS-256.conf
@@ -1,3 +1,4 @@
+ctrl_interface=3D/var/run/hostapd
 hw_mode=3Dg
 channel=3D1
 ssid=3DssidFILS-256
diff --git a/autotests/testFILS/ssidFILS-384.conf b/autotests/testFILS/ssid=
FILS-384.conf
index a090d537..9a3a3059 100644
--- a/autotests/testFILS/ssidFILS-384.conf
+++ b/autotests/testFILS/ssidFILS-384.conf
@@ -1,3 +1,4 @@
+ctrl_interface=3D/var/run/hostapd
 hw_mode=3Dg
 channel=3D1
 ssid=3DssidFILS-384
-- =

2.17.1

--===============4987585863217977716==--

