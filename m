Content-Type: multipart/mixed; boundary="===============5263952861137837411=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 6/6] auto-t: remove ';' in testSAE autoconnect_test.py
Date: Thu, 09 Sep 2021 15:08:48 -0700
Message-ID: <20210909220848.19376-6-prestwoj@gmail.com>
In-Reply-To: <20210909220848.19376-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5263952861137837411==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/testSAE/autoconnect_test.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/autotests/testSAE/autoconnect_test.py b/autotests/testSAE/auto=
connect_test.py
index 9095b7e9..64a60e7c 100644
--- a/autotests/testSAE/autoconnect_test.py
+++ b/autotests/testSAE/autoconnect_test.py
@@ -35,8 +35,8 @@ class Test(unittest.TestCase):
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
 =

     def test_SAE(self):
-        self.hostapd.set_value('sae_pwe', '0');
-        self.hostapd.set_value('sae_groups', '19');
+        self.hostapd.set_value('sae_pwe', '0')
+        self.hostapd.set_value('sae_groups', '19')
         self.hostapd.reload()
         self.hostapd.wait_for_event("AP-ENABLED")
 =

@@ -44,8 +44,8 @@ class Test(unittest.TestCase):
         self.validate_connection(wd)
 =

     def test_SAE_H2E(self):
-        self.hostapd.set_value('sae_pwe', '1');
-        self.hostapd.set_value('sae_groups', '20');
+        self.hostapd.set_value('sae_pwe', '1')
+        self.hostapd.set_value('sae_groups', '20')
         self.hostapd.reload()
         self.hostapd.wait_for_event("AP-ENABLED")
         wd =3D IWD(True)
-- =

2.31.1

--===============5263952861137837411==--

