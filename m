Content-Type: multipart/mixed; boundary="===============6120565590290568415=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/4] auto-t: disable update_config for testDPP
Date: Fri, 15 Apr 2022 09:59:21 -0700
Message-ID: <20220415165921.9892-4-prestwoj@gmail.com>
In-Reply-To: 20220415165921.9892-1-prestwoj@gmail.com

--===============6120565590290568415==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

update_config=3D1 lets wpa_supplicant write config changes
to the config file. In the real world this is what you want
so your DPP credentials are persistant. But for testing this
is not correct since multiple tests use the same config file
and expect it to be pristine.

Occationally wpa_supplicant was connecting to the AP without
running DPP because the config already had the network
credentials.
---
 autotests/testDPP/wpas.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autotests/testDPP/wpas.conf b/autotests/testDPP/wpas.conf
index 5ec815b4..521fb29b 100644
--- a/autotests/testDPP/wpas.conf
+++ b/autotests/testDPP/wpas.conf
@@ -1,5 +1,5 @@
 ctrl_interface=3D/tmp/rad1-p2p-wpas
 =

-update_config=3D1
+update_config=3D0
 pmf=3D2
 dpp_config_processing=3D2
-- =

2.34.1

--===============6120565590290568415==--

