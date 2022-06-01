Content-Type: multipart/mixed; boundary="===============6543054654627430240=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/2] auto-t: correctly import Mapping from collections
Date: Wed, 01 Jun 2022 09:05:47 -0700
Message-ID: <20220601160548.262018-1-prestwoj@gmail.com>

--===============6543054654627430240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current way this was being done was to import collections and
use collections.Mapping. This has been deprecated since python 3.3
but has worked up until python 3.10. After python 3.10 this will
no longer work, and Mapping must be imported from collections.abc.
---
 autotests/util/ead.py   | 4 ++--
 autotests/util/hwsim.py | 6 +++---
 autotests/util/iwd.py   | 5 +++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/autotests/util/ead.py b/autotests/util/ead.py
index 06716914..00596042 100644
--- a/autotests/util/ead.py
+++ b/autotests/util/ead.py
@@ -3,9 +3,9 @@
 from gi.repository import GLib
 import dbus
 import time
-import collections
 =

 import iwd
+from collections.abc import Mapping
 from config import ctx
 =

 EAD_SERVICE =3D                   'net.connman.ead'
@@ -38,7 +38,7 @@ class Adapter(iwd.IWDDBusAbstract):
         return self._properties['Authenticated']
 =

 =

-class AdapterList(collections.Mapping):
+class AdapterList(Mapping):
     def __init__(self, ead):
         self._dict =3D {}
 =

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index b8eec252..5456d30b 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -1,8 +1,8 @@
 #!/usr/bin/python3
 import dbus
 import sys
-import collections
 =

+from collections.abc import Mapping
 from weakref import WeakValueDictionary
 from abc import ABCMeta, abstractmethod
 from enum import Enum
@@ -210,7 +210,7 @@ class Rule(HwsimDBusAbstract):
                prefix + '\tDelay:\t' + str(self.delay) + '\n' + \
                prefix + '\tEnabled:\t' + str(self.enabled) + '\n'
 =

-class RuleSet(collections.Mapping):
+class RuleSet(Mapping):
     def __init__(self, hwsim, objects):
         self._dict =3D {}
         self._rule_manager =3D hwsim.rule_manager
@@ -275,7 +275,7 @@ class Radio(HwsimDBusAbstract):
                prefix + '\tName:\t\t' + self.name + '\n' + \
                prefix + '\tAddresses:\t' + repr(self.destination) + '\n'
 =

-class RadioList(collections.Mapping):
+class RadioList(Mapping):
     def __init__(self, hwsim, objects):
         self._dict =3D {}
         self._radio_manager =3D hwsim.radio_manager
diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index a2062258..6cee1e07 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -8,10 +8,11 @@ import sys
 import os
 import threading
 import time
-import collections
+import collections.abc
 import datetime
 import weakref
 =

+from collections.abc import Mapping
 from abc import ABCMeta, abstractmethod
 from enum import Enum
 =

@@ -1018,7 +1019,7 @@ class P2PPeer(IWDDBusAbstract):
         self._iface.Disconnect()
 =

 =

-class DeviceList(collections.Mapping):
+class DeviceList(Mapping):
     def __init__(self, iwd):
         self._dict =3D {}
         self._p2p_dict =3D {}
-- =

2.34.1

--===============6543054654627430240==--

