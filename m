Content-Type: multipart/mixed; boundary="===============7756296765660823498=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/5] auto-t: add ctrl_interface to testHT-VHT
Date: Wed, 13 Nov 2019 14:30:30 -0800
Message-ID: <20191113223032.5650-3-prestwoj@gmail.com>
In-Reply-To: <20191113223032.5650-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7756296765660823498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is now required for any test using HostapdCLI
---
 autotests/testHT-VHT/ht.conf         | 1 +
 autotests/testHT-VHT/non-ht-vht.conf | 1 +
 autotests/testHT-VHT/vht.conf        | 1 +
 3 files changed, 3 insertions(+)

diff --git a/autotests/testHT-VHT/ht.conf b/autotests/testHT-VHT/ht.conf
index b5dbc0d5..9a84b063 100644
--- a/autotests/testHT-VHT/ht.conf
+++ b/autotests/testHT-VHT/ht.conf
@@ -1,3 +1,4 @@
+ctrl_interface=3D/var/run/hostapd
 hw_mode=3Da
 channel=3D2
 ssid=3DtestSSID
diff --git a/autotests/testHT-VHT/non-ht-vht.conf b/autotests/testHT-VHT/no=
n-ht-vht.conf
index ae6e2dac..6df06a02 100644
--- a/autotests/testHT-VHT/non-ht-vht.conf
+++ b/autotests/testHT-VHT/non-ht-vht.conf
@@ -1,3 +1,4 @@
+ctrl_interface=3D/var/run/hostapd
 hw_mode=3Dg
 channel=3D1
 ssid=3DtestSSID
diff --git a/autotests/testHT-VHT/vht.conf b/autotests/testHT-VHT/vht.conf
index 23453a76..9a7ec0d7 100644
--- a/autotests/testHT-VHT/vht.conf
+++ b/autotests/testHT-VHT/vht.conf
@@ -1,3 +1,4 @@
+ctrl_interface=3D/var/run/hostapd
 ssid=3DtestSSID
 wpa=3D2
 wpa_pairwise=3DCCMP
-- =

2.17.1

--===============7756296765660823498==--

