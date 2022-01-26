Content-Type: multipart/mixed; boundary="===============7226098723041499553=="
MIME-Version: 1.0
From: Diederik de Haas <didi.debian at cknow.org>
To: iwd at lists.01.org
Subject: [PATCH v2] dbus: Remove 'at_console', add 'netdev' settings
Date: Wed, 26 Jan 2022 21:01:03 +0100
Message-ID: <20220126200103.16017-1-didi.debian@cknow.org>

--===============7226098723041499553==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The 'at_console' D-Bus policy setting has been deprecated for more then
10 years and could be ignored at any time in the future. Moreover, while
the intend was to allow locally logged on users to interact with iwd, it
didn't actually do that.
More info at https://www.spinics.net/lists/linux-bluetooth/msg75267.html
and https://gitlab.freedesktop.org/dbus/dbus/-/issues/52
Therefor remove the 'at_console' setting block.

On Debian (based) systems, there is a standard defined group which is
allowed to manage network interfaces, and that is the 'netdev' group.
So add a D-Bus setting block to grant the 'netdev' group that access.
---
Changes since v1:
- Added 'dbus' prefix to primary commit message and shortened it to
  less then 50 chars
- Reformatted secondary commit message to max 72 chars and fixed a
  small typo (_ -> ')

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

--===============7226098723041499553==--

