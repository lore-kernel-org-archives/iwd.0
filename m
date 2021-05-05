Content-Type: multipart/mixed; boundary="===============4235308629862675181=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/3] test: add test utility for Roam() method
Date: Wed, 05 May 2021 11:23:55 -0700
Message-ID: <20210505182355.454265-3-prestwoj@gmail.com>
In-Reply-To: <20210505182355.454265-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4235308629862675181==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/force-roam | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100755 test/force-roam

diff --git a/test/force-roam b/test/force-roam
new file mode 100755
index 00000000..b590c84a
--- /dev/null
+++ b/test/force-roam
@@ -0,0 +1,16 @@
+#!/usr/bin/python3
+
+import sys
+import dbus
+
+if (len(sys.argv) !=3D 3):
+    print("Usage: %s <device> <mac>" % (sys.argv[0]))
+    sys.exit(1)
+
+bus =3D dbus.SystemBus()
+device =3D dbus.Interface(bus.get_object("net.connman.iwd", sys.argv[1]),
+                                    "net.connman.iwd.StationDiagnostic")
+
+mac =3D sys.argv[2].replace(':', '')
+
+device.Roam(dbus.ByteArray.fromhex(mac))
-- =

2.26.2

--===============4235308629862675181==--

