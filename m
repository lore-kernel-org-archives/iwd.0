Content-Type: multipart/mixed; boundary="===============6637006233042303280=="
MIME-Version: 1.0
From: Jesse Lentz <jesse at twosheds.org>
To: iwd at lists.01.org
Subject: [PATCH] Allow SignalLevelAgent method calls in dbus policy
Date: Fri, 20 May 2022 14:48:57 -0400
Message-ID: <20220520184857.9451-1-jesse@twosheds.org>

--===============6637006233042303280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The SignalLevelAgent API is currently broken by the system bus's
security policy, which blocks iwd's outgoing method call messages. This
patch punches a hole for method calls on the
net.connman.iwd.SignalLevelAgent interface.
---
 src/iwd-dbus.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/iwd-dbus.conf b/src/iwd-dbus.conf
index 4b3636e0..7fc2e68c 100644
--- a/src/iwd-dbus.conf
+++ b/src/iwd-dbus.conf
@@ -11,6 +11,7 @@
     <allow own=3D"net.connman.iwd"/>
     <allow send_destination=3D"net.connman.iwd"/>
     <allow send_interface=3D"net.connman.iwd.Agent"/>
+    <allow send_interface=3D"net.connman.iwd.SignalLevelAgent"/>
   </policy>
 =

   <policy group=3D"wheel">
-- =

2.36.0

--===============6637006233042303280==--

