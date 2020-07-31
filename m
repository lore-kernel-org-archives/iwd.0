Content-Type: multipart/mixed; boundary="===============2740565049974989338=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 10/13] wfd-source: Support wfd-idr-request
Date: Fri, 31 Jul 2020 03:31:33 +0200
Message-ID: <20200731013136.65057-10-andrew.zaborowski@intel.com>
In-Reply-To: <20200731013136.65057-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2740565049974989338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/wfd-source | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/test/wfd-source b/test/wfd-source
index c9ad3c34..09b47a27 100755
--- a/test/wfd-source
+++ b/test/wfd-source
@@ -21,7 +21,7 @@ import gi
 gi.require_version('GLib', '2.0')
 gi.require_version('Gst', '1.0')
 gi.require_version('Gtk', '3.0')
-from gi.repository import GLib, Gst, Gtk, Gdk, Pango
+from gi.repository import GLib, Gst, Gtk, Gdk, Pango, GObject
 =

 class WFDRTSPServer:
     class RTSPException(Exception):
@@ -325,7 +325,21 @@ class WFDRTSPServer:
         elif method =3D=3D 'TEARDOWN' and target !=3D self.session_stream_=
url:
             self.error('Unknown target "' + target + '" in TEARDOWN reques=
t')
         elif method =3D=3D 'SET_PARAMETER':
-            pass
+            params =3D []
+            names =3D []
+            for line in content.split(b'\r\n'):
+                param =3D (line.decode('utf8').strip(), None)
+                if not param[0]:
+                    continue
+                if ':' in param[0]:
+                    k, v =3D param[0].split(':', 1)
+                    param =3D (k.strip(), v.strip())
+                if param[0] in names:
+                    self.error('Duplicate key "' + param[0] + '" in SET_PA=
RAMETER response')
+
+                names.append(param[0])
+                params.append(param)
+            self.last_params =3D params
 =

     def request(self, method, target, require=3D[], params=3D[]):
         content =3D ''
@@ -437,17 +451,17 @@ class WFDRTSPServer:
             self.debug('Gstreamer message of type ' + str(t) + ' for ' + m=
essage.src.name + ': ' + str(message))
         return True
 =

-    def gst_force_keyframe(self):
+    def force_keyframe(self):
         enc =3D self.rtp_pipeline.get_by_name('videnc')
         sink =3D enc.get_static_pad('sink')
         timestamp =3D Gst.CLOCK_TIME_NONE # can/should we use sink.query_p=
osition?
 =

         s =3D Gst.Structure('GstForceKeyUnit')
-        s.set_value('timestamp', timestamp, 'uint64')
-        s.set_value('stream-time', timestamp, 'uint64')
-        s.set_value('all-headers', True)
+        s.set_value('timestamp', GObject.Value(GObject.TYPE_UINT64, timest=
amp))
+        s.set_value('stream-time', GObject.Value(GObject.TYPE_UINT64, time=
stamp))
+        s.set_value('all-headers', GObject.Value(GObject.TYPE_BOOLEAN, Tru=
e))
         # TODO: can we also send this event directly to the element instea=
d of the pad?
-        sink.send_event(Gst.event_new_custom(Gst.EVENT_CUSTOM_DOWNSTREAM, =
s))
+        sink.send_event(Gst.Event.new_custom(Gst.EventType.CUSTOM_DOWNSTRE=
AM, s))
 =

     def rtsp_keepalive_timeout_cb(self):
         try:
@@ -585,9 +599,13 @@ class WFDRTSPServer:
                 self.response()
                 return
             if method =3D=3D 'SET_PARAMETER':
-                # TODO: parse the stuff, on 'wfd-idr-request\r\n' (no semi=
colon) call the following:
-                self.gst_force_keyframe()
-                self.response()
+                self.validate_msg(method, 'SET_PARAMETER', status, reason,=
 headers, target, content)
+                for k, v in self.last_params:
+                    if k =3D=3D 'wfd_idr_request' and v is None:
+                        self.force_keyframe()
+                        self.response()
+                    else:
+                        self.error('Unknown request "' + k + '" with value=
 ' + repr(v))
                 return
             if method =3D=3D 'TEARDOWN':
                 # The spec suggests a more graceful teardown but we just c=
lose the connection
-- =

2.25.1

--===============2740565049974989338==--

