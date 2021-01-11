Content-Type: multipart/mixed; boundary="===============7427652640322705242=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 7/7] test: add a script for GetDiagnostics
Date: Mon, 11 Jan 2021 13:35:02 -0800
Message-ID: <20210111213502.551370-7-prestwoj@gmail.com>
In-Reply-To: <20210111213502.551370-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7427652640322705242==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/get-diagnostics | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100755 test/get-diagnostics

diff --git a/test/get-diagnostics b/test/get-diagnostics
new file mode 100755
index 00000000..c508c58c
--- /dev/null
+++ b/test/get-diagnostics
@@ -0,0 +1,37 @@
+#!/usr/bin/python3
+
+import sys
+import dbus
+
+# Map dict keys to units. Units can be a function/lambda which should retu=
rn the
+# entire value with units as a string.
+unit_map =3D {
+    "ConnectedBss" : None,
+    "RSSI" : "dBm",
+    "RxBitrate" : lambda k : str(100 * int(k)) + ' Kbps',
+    "RxMCS" : lambda i : str(int(i)),
+    "TxBitrate" : lambda k : str(100 * int(k)) + ' Kbps',
+    "TxMCS" : lambda i : str(int(i)),
+    "ExpectedThroughput" : "Kbps"
+}
+
+if (len(sys.argv) !=3D 2):
+    print("Usage: %s <device>" % (sys.argv[0]))
+    sys.exit(1)
+
+bus =3D dbus.SystemBus()
+device =3D dbus.Interface(bus.get_object("net.connman.iwd", sys.argv[1]),
+                                    "net.connman.iwd.StationDiagnostic")
+diagnostics =3D device.GetDiagnostics()
+
+for key, value in diagnostics.items():
+    if key in unit_map:
+        units =3D unit_map[key]
+        if units is None:
+            units =3D ''
+        elif callable(units):
+            value =3D units(value)
+            units =3D ''
+
+        print('%s : %s %s' % (key, value, units))
+
-- =

2.26.2

--===============7427652640322705242==--

