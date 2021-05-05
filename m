Content-Type: multipart/mixed; boundary="===============8801100618978446983=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] iwd-dbus: deny Roam() method for shipped dbus config
Date: Wed, 05 May 2021 08:53:27 -0700
Message-ID: <20210505155328.431557-2-prestwoj@gmail.com>
In-Reply-To: <20210505155328.431557-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8801100618978446983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is not a production method and it is recommended to deny access
unless being used for testing.
---
 src/iwd-dbus.conf | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/iwd-dbus.conf b/src/iwd-dbus.conf
index 6b07ba9e..c36401c8 100644
--- a/src/iwd-dbus.conf
+++ b/src/iwd-dbus.conf
@@ -11,20 +11,24 @@
     <allow own=3D"net.connman.iwd"/>
     <allow send_destination=3D"net.connman.iwd"/>
     <allow send_interface=3D"net.connman.iwd.Agent"/>
+    <deny send_interface=3D"net.connman.iwd.StationDiagnostic" send_member=
=3D"Roam"/>
   </policy>
 =

   <policy group=3D"wheel">
     <allow send_destination=3D"net.connman.iwd"/>
     <allow send_interface=3D"net.connman.iwd.Agent"/>
+    <deny send_interface=3D"net.connman.iwd.StationDiagnostic" send_member=
=3D"Roam"/>
   </policy>
 =

   <policy at_console=3D"true">
     <allow send_destination=3D"net.connman.iwd"/>
     <allow send_interface=3D"net.connman.iwd.Agent"/>
+    <deny send_interface=3D"net.connman.iwd.StationDiagnostic" send_member=
=3D"Roam"/>
   </policy>
 =

   <policy context=3D"default">
     <deny send_destination=3D"net.connman.iwd"/>
+    <deny send_interface=3D"net.connman.iwd.StationDiagnostic" send_member=
=3D"Roam"/>
   </policy>
 =

 </busconfig>
-- =

2.26.2

--===============8801100618978446983==--

