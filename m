Content-Type: multipart/mixed; boundary="===============1910990233790761084=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 09/13] wfd-source: Print call trace on error
Date: Fri, 31 Jul 2020 03:31:32 +0200
Message-ID: <20200731013136.65057-9-andrew.zaborowski@intel.com>
In-Reply-To: <20200731013136.65057-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1910990233790761084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/wfd-source | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/test/wfd-source b/test/wfd-source
index 557093a9..c9ad3c34 100755
--- a/test/wfd-source
+++ b/test/wfd-source
@@ -15,6 +15,7 @@ import collections
 import collections.abc
 import random
 import dataclasses
+import traceback
 =

 import gi
 gi.require_version('GLib', '2.0')
@@ -1139,8 +1140,13 @@ class WFDSource(Gtk.Window):
 =

         def on_rtsp_error(excp):
             self.disconnect_peer(dev_path, path)
+            tb =3D ''
+            try:
+                tb =3D '\n\nDebug info: ' + traceback.format_exc()
+            except:
+                pass
             dialog =3D Gtk.MessageDialog(parent=3Dself, message_type=3DGtk=
.MessageType.ERROR, buttons=3DGtk.ButtonsType.OK, text=3D'Negotiation faile=
d')
-            dialog.format_secondary_text('RTSP error when talking to ' + s=
elf.objects[path][PEER_IF]['Name'] + ': ' + repr(excp))
+            dialog.format_secondary_text('RTSP error when talking to ' + s=
elf.objects[path][PEER_IF]['Name'] + ': ' + repr(excp) + tb)
             dialog.show()
 =

             def on_ok(response, *args):
-- =

2.25.1

--===============1910990233790761084==--

