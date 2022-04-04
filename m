Content-Type: multipart/mixed; boundary="===============8695558021109688035=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/2] auto-t: delay rekeys in extended key ID test
Date: Mon, 04 Apr 2022 08:54:33 -0700
Message-ID: <20220404155433.733337-2-prestwoj@gmail.com>

--===============8695558021109688035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The test was rekeying in a loop which ends up confusing hostapd
depending on the timing of when it gets the REKEY command and any
responses from IWD. UML seemed to handle this fine but not QEMU.

Instead delay the rekey a bit to allow it to fully complete before
sending another.
---
 autotests/testWPA2-ext-key-id/connection_test.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/autotests/testWPA2-ext-key-id/connection_test.py b/autotests/t=
estWPA2-ext-key-id/connection_test.py
index afd48149..d77a216b 100644
--- a/autotests/testWPA2-ext-key-id/connection_test.py
+++ b/autotests/testWPA2-ext-key-id/connection_test.py
@@ -50,6 +50,8 @@ class Test(unittest.TestCase):
             testutil.test_iface_operstate()
             testutil.test_ifaces_connected()
 =

+            wd.wait(0.5)
+
         device.disconnect()
 =

         condition =3D 'not obj.connected'
-- =

2.34.1

--===============8695558021109688035==--

