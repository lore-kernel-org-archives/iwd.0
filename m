Content-Type: multipart/mixed; boundary="===============2343089471298053758=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 8/9] auto-t: add regular 8021x AKM to FT-FILS tests
Date: Thu, 29 Jul 2021 15:21:53 -0700
Message-ID: <20210729222154.159542-8-prestwoj@gmail.com>
In-Reply-To: <20210729222154.159542-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2343089471298053758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After some code changes the FT-FILS AKM was no longer selectable
inside network_can_connect_bss. This normally shouldn't matter
since station ends up selecting the AKM explicitly, including
passing the fils_hint, but since the autotests only included
FT-FILS AKMs this caused the transition to fail with no available
BSS's.

To fix this the standard 8021x AKM was added to the hostapd
configs. This allows these BSS's to be selected when attempting
to roam, but since FT-FILS is the only other AKM it will be used
for the actual transition.
---
 autotests/testFT-FILS-SHA256/ft-eap-ccmp-2.conf | 2 +-
 autotests/testFT-FILS-SHA384/ft-eap-ccmp-2.conf | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/autotests/testFT-FILS-SHA256/ft-eap-ccmp-2.conf b/autotests/te=
stFT-FILS-SHA256/ft-eap-ccmp-2.conf
index 24266ea9..585f1ca1 100644
--- a/autotests/testFT-FILS-SHA256/ft-eap-ccmp-2.conf
+++ b/autotests/testFT-FILS-SHA256/ft-eap-ccmp-2.conf
@@ -9,7 +9,7 @@ nas_identifier=3Ddummy2
 wpa=3D2
 # Can support WPA-EAP and FT-EAP (space separated list) at the same
 # time but we want to force FT
-wpa_key_mgmt=3DFT-FILS-SHA256
+wpa_key_mgmt=3DWPA-EAP FT-FILS-SHA256
 wpa_pairwise=3DCCMP
 ieee8021x=3D1
 =

diff --git a/autotests/testFT-FILS-SHA384/ft-eap-ccmp-2.conf b/autotests/te=
stFT-FILS-SHA384/ft-eap-ccmp-2.conf
index 8af73cbc..a6bdf641 100644
--- a/autotests/testFT-FILS-SHA384/ft-eap-ccmp-2.conf
+++ b/autotests/testFT-FILS-SHA384/ft-eap-ccmp-2.conf
@@ -9,7 +9,7 @@ nas_identifier=3Ddummy2
 wpa=3D2
 # Can support WPA-EAP and FT-EAP (space separated list) at the same
 # time but we want to force FT
-wpa_key_mgmt=3DFT-FILS-SHA384
+wpa_key_mgmt=3DWPA-EAP FT-FILS-SHA384
 wpa_pairwise=3DCCMP
 ieee8021x=3D1
 =

-- =

2.31.1

--===============2343089471298053758==--

