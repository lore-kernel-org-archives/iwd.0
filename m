Content-Type: multipart/mixed; boundary="===============7510462782875271791=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/4] auto-t: use tearDownClass in hidden network test
Date: Wed, 20 Oct 2021 13:53:31 -0700
Message-ID: <20211020205331.734405-4-prestwoj@gmail.com>
In-Reply-To: 20211020205331.734405-1-prestwoj@gmail.com

--===============7510462782875271791==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A failure in this test could leave stale network profiles, which
may cause future tests to fail.
---
 autotests/testHiddenNetworks/open_network_test.py | 2 ++
 autotests/testHiddenNetworks/wpa_network_test.py  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/autotests/testHiddenNetworks/open_network_test.py b/autotests/=
testHiddenNetworks/open_network_test.py
index 7d1407c0..2cc0f75b 100644
--- a/autotests/testHiddenNetworks/open_network_test.py
+++ b/autotests/testHiddenNetworks/open_network_test.py
@@ -24,6 +24,8 @@ class TestOpenNetwork(unittest.TestCase):
         tca.validate('ssidHiddenOpen', False)
         tca.validate('ssidHiddenOpen', True)
 =

+    @classmethod
+    def tearDownClass(cls):
         IWD.clear_storage()
 =

 if __name__ =3D=3D '__main__':
diff --git a/autotests/testHiddenNetworks/wpa_network_test.py b/autotests/t=
estHiddenNetworks/wpa_network_test.py
index 800f8312..d8166b1b 100644
--- a/autotests/testHiddenNetworks/wpa_network_test.py
+++ b/autotests/testHiddenNetworks/wpa_network_test.py
@@ -25,6 +25,8 @@ class TestWpaNetwork(unittest.TestCase):
         tca.validate('ssidHiddenWPA', False, None, True)
         tca.validate('ssidHiddenWPA', True, None, True)
 =

+    @classmethod
+    def tearDownClass(cls):
         IWD.clear_storage()
 =

 if __name__ =3D=3D '__main__':
-- =

2.31.1

--===============7510462782875271791==--

