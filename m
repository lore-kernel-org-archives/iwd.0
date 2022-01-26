Content-Type: multipart/mixed; boundary="===============5346255351795200588=="
MIME-Version: 1.0
From: Diederik de Haas <didi.debian at cknow.org>
To: iwd at lists.01.org
Subject: [PATCH] Remove 'at_console' and add 'netdev' D-Bus policy setting
Date: Wed, 26 Jan 2022 15:04:23 +0100
Message-ID: <20220126140423.3974-1-didi.debian@cknow.org>

--===============5346255351795200588==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The 'at_console' D-Bus policy setting has been deprecated for more then
10 years and could be ignored at any time in the future. Moreover, while the
intend was to allow locally logged on users to interact with iwd, it didn't
actually do that. https://www.spinics.net/lists/linux-bluetooth/msg75267.ht=
ml
and https://gitlab.freedesktop.org/dbus/dbus/-/issues/52 contain more
details. Therefor remove the 'at_console_ setting block.

On Debian (based) systems, there is a standard defined group which is
allowed to manage network interfaces, and that is the 'netdev' group.
So add a D-Bus setting block to grant the 'netdev' group that access.
---
 src/iwd-dbus.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/iwd-dbus.conf b/src/iwd-dbus.conf
index 6b07ba9e..257b0b14 100644
--- a/src/iwd-dbus.conf
+++ b/src/iwd-dbus.conf
@@ -18,7 +18,7 @@
     <allow send_interface=3D"net.connman.iwd.Agent"/>
   </policy>
 =

-  <policy at_console=3D"true">
+  <policy group=3D"netdev">
     <allow send_destination=3D"net.connman.iwd"/>
     <allow send_interface=3D"net.connman.iwd.Agent"/>
   </policy>
-- =

2.34.1

--===============5346255351795200588==--

