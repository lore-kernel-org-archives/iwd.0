Content-Type: multipart/mixed; boundary="===============4379839287864354260=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] auto-t: add missing config files (testOWE-transition)
Date: Wed, 22 Dec 2021 16:23:35 -0800
Message-ID: <20211223002335.14823-1-prestwoj@gmail.com>

--===============4379839287864354260==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testOWE-transition/ssidOWE-2.conf  | 9 +++++++++
 autotests/testOWE-transition/ssidOpen-2.conf | 3 +++
 2 files changed, 12 insertions(+)
 create mode 100644 autotests/testOWE-transition/ssidOWE-2.conf
 create mode 100644 autotests/testOWE-transition/ssidOpen-2.conf

diff --git a/autotests/testOWE-transition/ssidOWE-2.conf b/autotests/testOW=
E-transition/ssidOWE-2.conf
new file mode 100644
index 00000000..a8a9023c
--- /dev/null
+++ b/autotests/testOWE-transition/ssidOWE-2.conf
@@ -0,0 +1,9 @@
+ssid=3Dowe-hidden-2
+bssid=3D02:00:00:00:f3:00
+channel=3D1
+ignore_broadcast_ssid=3D1
+ieee80211w=3D1
+
+wpa=3D2
+wpa_key_mgmt=3DOWE
+rsn_pairwise=3DCCMP
diff --git a/autotests/testOWE-transition/ssidOpen-2.conf b/autotests/testO=
WE-transition/ssidOpen-2.conf
new file mode 100644
index 00000000..0a9f7628
--- /dev/null
+++ b/autotests/testOWE-transition/ssidOpen-2.conf
@@ -0,0 +1,3 @@
+channel=3D1
+ssid=3Dtransition-2
+bssid=3D02:00:00:00:f2:00
-- =

2.31.1

--===============4379839287864354260==--

