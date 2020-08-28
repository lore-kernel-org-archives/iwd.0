Content-Type: multipart/mixed; boundary="===============4938378468185425136=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 12/15] auto-t: replace hard-coded interfaces
Date: Fri, 28 Aug 2020 09:40:47 -0700
Message-ID: <20200828164050.1456-13-prestwoj@gmail.com>
In-Reply-To: <20200828164050.1456-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4938378468185425136==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

test-runner now supports interface name replacement inside hostapd
config files. Since a given test configuration doesn't know what
interface names there will be $ifaceN can be specified instead e.g.

rsn_preauth_interfaces=3D$iface0 $iface1

The $ifaceN values will be replace with actual interface names when
the test is started.

This patch also removes ctrl_interface inside the hostapd config
files as this is no longer required.
---
 autotests/testPreauth-roam/eaptls-preauth-1.conf | 3 +--
 autotests/testPreauth-roam/eaptls-preauth-2.conf | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/autotests/testPreauth-roam/eaptls-preauth-1.conf b/autotests/t=
estPreauth-roam/eaptls-preauth-1.conf
index 0c7f96a7..bc808ed7 100644
--- a/autotests/testPreauth-roam/eaptls-preauth-1.conf
+++ b/autotests/testPreauth-roam/eaptls-preauth-1.conf
@@ -2,7 +2,6 @@ hw_mode=3Dg
 channel=3D1
 ssid=3DTestPreauth
 utf8_ssid=3D1
-ctrl_interface=3D/var/run/hostapd
 =

 wpa=3D2
 wpa_key_mgmt=3DWPA-EAP
@@ -24,7 +23,7 @@ radius_server_auth_port=3D1812
 nas_identifier=3Dtesteap1
 =

 rsn_preauth=3D1
-rsn_preauth_interfaces=3Dwln0 wln1
+rsn_preauth_interfaces=3D$iface0 $iface1
 disable_pmksa_caching=3D0
 =

 # Allow PMK cache to be shared opportunistically among configured interfac=
es
diff --git a/autotests/testPreauth-roam/eaptls-preauth-2.conf b/autotests/t=
estPreauth-roam/eaptls-preauth-2.conf
index bddcca69..6d3a18e7 100644
--- a/autotests/testPreauth-roam/eaptls-preauth-2.conf
+++ b/autotests/testPreauth-roam/eaptls-preauth-2.conf
@@ -2,7 +2,6 @@ hw_mode=3Dg
 channel=3D2
 ssid=3DTestPreauth
 utf8_ssid=3D1
-ctrl_interface=3D/var/run/hostapd
 =

 wpa=3D2
 wpa_key_mgmt=3DWPA-EAP
@@ -20,7 +19,7 @@ auth_server_port=3D1812
 auth_server_shared_secret=3Dsecret
 =

 rsn_preauth=3D1
-rsn_preauth_interfaces=3Dwln0 wln1
+rsn_preauth_interfaces=3D$iface0 $iface1
 disable_pmksa_caching=3D0
 =

 # Allow PMK cache to be shared opportunistically among configured interfac=
es
-- =

2.21.1

--===============4938378468185425136==--

