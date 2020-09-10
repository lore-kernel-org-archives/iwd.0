Content-Type: multipart/mixed; boundary="===============9090614740620077130=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 07/26] auto-t: remove wiphy.py
Date: Thu, 10 Sep 2020 11:58:36 -0700
Message-ID: <20200910185855.27833-7-prestwoj@gmail.com>
In-Reply-To: <20200910185855.27833-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9090614740620077130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is no longer needed
---
 autotests/util/wiphy.py | 32 --------------------------------
 1 file changed, 32 deletions(-)
 delete mode 100644 autotests/util/wiphy.py

diff --git a/autotests/util/wiphy.py b/autotests/util/wiphy.py
deleted file mode 100644
index 3f94d87b..00000000
--- a/autotests/util/wiphy.py
+++ /dev/null
@@ -1,32 +0,0 @@
-#! /usr/bin/python3
-import os
-import collections
-
-wiphy_map =3D {}
-
-Wiphy =3D collections.namedtuple('Wiphy', ['name', 'use', 'interface_map'])
-
-Intf =3D collections.namedtuple('Intf',
-        ['name', 'wiphy', 'ctrl_interface', 'config'])
-
-def parse_list():
-    for entry in os.environ['TEST_WIPHY_LIST'].split('\n'):
-        wname, use_str =3D entry.split('=3D', 1)
-        use =3D use_str.split(',')
-
-        if wname not in wiphy_map:
-            wiphy_map[wname] =3D Wiphy(use=3Duse[0], name=3Dwname, interfa=
ce_map=3D{})
-
-        if len(use) <=3D 1:
-            continue
-
-        intf =3D {}
-        intf['name'] =3D None
-        intf['wiphy'] =3D wiphy_map[wname]
-        intf['ctrl_interface'] =3D None
-        intf['config'] =3D None
-        intf.update(dict([param.split('=3D', 1) for param in use[1:]]))
-
-        wiphy_map[wname].interface_map[intf['name']] =3D Intf(**intf)
-
-parse_list()
-- =

2.21.3

--===============9090614740620077130==--

