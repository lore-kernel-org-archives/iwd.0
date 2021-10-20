Content-Type: multipart/mixed; boundary="===============8279685986565628801=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/4] auto-t: fix testConnectAutoconnect
Date: Wed, 20 Oct 2021 13:53:29 -0700
Message-ID: <20211020205331.734405-2-prestwoj@gmail.com>
In-Reply-To: 20211020205331.734405-1-prestwoj@gmail.com

--===============8279685986565628801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There was no open ssid provisioning file, which was fine as the
first test should have created one. But to be safe, include one
explicitly and use the proper setUp/tearDown functions.
---
 autotests/testConnectAutoconnect/open_network_test.py | 4 ++++
 autotests/testConnectAutoconnect/ssidOpen.open        | 1 +
 2 files changed, 5 insertions(+)
 create mode 100644 autotests/testConnectAutoconnect/ssidOpen.open

diff --git a/autotests/testConnectAutoconnect/open_network_test.py b/autote=
sts/testConnectAutoconnect/open_network_test.py
index 187f2342..0af66923 100644
--- a/autotests/testConnectAutoconnect/open_network_test.py
+++ b/autotests/testConnectAutoconnect/open_network_test.py
@@ -24,6 +24,10 @@ class TestOpenNetwork(unittest.TestCase):
         tca.validate('ssidOpen', False)
         tca.validate('ssidOpen', True)
 =

+    def setUp(self):
+        IWD.copy_to_storage('ssidOpen.open')
+
+    def tearDown(self):
         IWD.clear_storage()
 =

 if __name__ =3D=3D '__main__':
diff --git a/autotests/testConnectAutoconnect/ssidOpen.open b/autotests/tes=
tConnectAutoconnect/ssidOpen.open
new file mode 100644
index 00000000..8b137891
--- /dev/null
+++ b/autotests/testConnectAutoconnect/ssidOpen.open
@@ -0,0 +1 @@
+
-- =

2.31.1

--===============8279685986565628801==--

