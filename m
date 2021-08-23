Content-Type: multipart/mixed; boundary="===============2741238377631550603=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] auto-t: testSAQuery remove ungraceful restart
Date: Mon, 23 Aug 2021 11:32:20 -0700
Message-ID: <20210823183221.558154-2-prestwoj@gmail.com>
In-Reply-To: <20210823183221.558154-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2741238377631550603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Instead the same effect can be seen by just ifdown/ifup the interface.
---
 autotests/testSAQuery/connection_test.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/autotests/testSAQuery/connection_test.py b/autotests/testSAQue=
ry/connection_test.py
index 3a66d118..03280d0e 100644
--- a/autotests/testSAQuery/connection_test.py
+++ b/autotests/testSAQuery/connection_test.py
@@ -38,7 +38,10 @@ class Test(unittest.TestCase):
         # Make AP go down ungracefully, when hostapd comes back up it shou=
ld
         # send an unprotected disassociate frame so the client will re-aut=
h.
         # This will kick off the SA Query procedure
-        hostapd.ungraceful_restart()
+        hostapd.interface.set_interface_state('down')
+        hostapd.interface.set_interface_state('up')
+
+        hostapd.wait_for_event('INTERFACE-ENABLED')
 =

         condition =3D 'not obj.connected'
         wd.wait_for_object_condition(ordered_network.network_object, condi=
tion)
-- =

2.31.1

--===============2741238377631550603==--

