Content-Type: multipart/mixed; boundary="===============0675448361291770652=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] auto-t: remove scanning wait from testHiddenNetworks
Date: Wed, 06 May 2020 08:58:07 -0700
Message-ID: <20200506155807.4434-2-prestwoj@gmail.com>
In-Reply-To: <20200506155807.4434-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0675448361291770652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Same deal as with testKnownNetworks, the wait for scanning to stop
has been removed since scanning may not be running at this point.
---
 autotests/testHiddenNetworks/validation.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/autotests/testHiddenNetworks/validation.py b/autotests/testHid=
denNetworks/validation.py
index 9c433623..551f12c7 100644
--- a/autotests/testHiddenNetworks/validation.py
+++ b/autotests/testHiddenNetworks/validation.py
@@ -50,8 +50,6 @@ class TestConnectAutoConnect(unittest.TestCase):
         device =3D devices[0]
 =

         if autoconnect:
-            condition =3D 'obj.scanning'
-            wd.wait_for_object_condition(device, condition)
             condition =3D 'not obj.scanning'
             wd.wait_for_object_condition(device, condition)
 =

-- =

2.21.1

--===============0675448361291770652==--

