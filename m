Content-Type: multipart/mixed; boundary="===============2950980040928073480=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH] autotests: Work around wpa_s config issue in testP2P
Date: Mon, 06 Jun 2022 11:01:54 +0200
Message-ID: <20220606090154.980544-1-andrew.zaborowski@intel.com>

--===============2950980040928073480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since commit 922fa099721903b106a7bc1ccd1ffe8c4a7bce69 in hostap, our
setting of config_methods on P2P-client interface was ignored.  Work
around that commit, in addition to the previous workaround we have in
this test, to again ensure the correct config_methods value is used.
---
 autotests/testP2P/connection_test.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/autotests/testP2P/connection_test.py b/autotests/testP2P/conne=
ction_test.py
index 383e0cef..479076e8 100644
--- a/autotests/testP2P/connection_test.py
+++ b/autotests/testP2P/connection_test.py
@@ -87,7 +87,12 @@ class Test(unittest.TestCase):
             # For some reason wpa_supplicant's newly created P2P-client in=
terface doesn't inherit
             # the settings from the main interface which were loaded from =
the config file
             # (P2P-device and P2P-GO interfaces do), we need to set config=
_methods again.
+            #
+            # Additionally since hostap commit 922fa099721903b106a7bc1ccd1=
ffe8c4a7bce69,
+            # just setting config_methods to the same value we used last t=
ime is detected as
+            # a NOOP so we need to set it to a different value first for i=
t to take effect.
             peer_ifname =3D 'p2p-' + wpas.interface.name + '-0'
+            wpas.set('config_methods', '', ifname=3Dpeer_ifname)
             wpas.set('config_methods', wpas.config['config_methods'], ifna=
me=3Dpeer_ifname)
             wpas.set('device_name', wpas.config['device_name'], ifname=3Dp=
eer_ifname)
             wpas.set('device_type', wpas.config['device_type'], ifname=3Dp=
eer_ifname)
-- =

2.34.1

--===============2950980040928073480==--

