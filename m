Content-Type: multipart/mixed; boundary="===============6058741354455535213=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/3] wfd-source: Add stream utility buttons
Date: Fri, 31 Jul 2020 20:56:44 +0200
Message-ID: <20200731185645.73515-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200731185645.73515-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6058741354455535213==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add two buttons to the UI when the stream is playing: one for forcing an
H.264 key-frame (IDR) and one for restarting the stream in gstreamer.
---
 test/wfd-source | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/test/wfd-source b/test/wfd-source
index fad5f16e..bbd62c7c 100755
--- a/test/wfd-source
+++ b/test/wfd-source
@@ -588,6 +588,11 @@ class WFDRTSPServer:
         # TODO: can we also send this event directly to the element instea=
d of the pad?
         sink.send_event(Gst.Event.new_custom(Gst.EventType.CUSTOM_DOWNSTRE=
AM, s))
 =

+    def reset_stream(self):
+        if self.rtp_pipeline.get_state(timeout=3D0)[1] =3D=3D Gst.State.PL=
AYING:
+            self.rtp_pipeline.set_state(Gst.State.PAUSED)
+            self.rtp_pipeline.set_state(Gst.State.PLAYING)
+
     def rtsp_keepalive_timeout_cb(self):
         try:
             self.rtsp_keepalive_timeout =3D None
@@ -1313,6 +1318,25 @@ class WFDSource(Gtk.Window):
 =

             self.add_info_str('Peer content protection', 'yes' if self.obj=
ects[path][WFD_IF]['HasContentProtection'] else 'no')
 =

+        if peer.rtsp is not None and peer.rtsp.ready:
+            def force_keyframe(widget):
+                peer.rtsp.force_keyframe()
+                return True
+            def reset_stream(widget):
+                peer.rtsp.reset_stream()
+                return True
+            # The idea for these buttons is to make sure any parameter cha=
nges get fully applied
+            button1 =3D Gtk.Button()
+            button1.set_label('Force keyframe')
+            button1.connect('clicked', force_keyframe)
+            button2 =3D Gtk.Button()
+            button2.set_label('Reset stream')
+            button2.connect('clicked', reset_stream)
+            box =3D Gtk.Box(orientation=3DGtk.Orientation.HORIZONTAL)
+            box.pack_start(button1, expand=3DFalse, fill=3DFalse, padding=
=3D3)
+            box.pack_start(button2, expand=3DFalse, fill=3DFalse, padding=
=3D3)
+            self.infopane.add(box)
+
         if self.rtsp_props is None:
             self.rtsp_props, self.rtsp_init_values =3D WFDRTSPServer.get_i=
nit_props()
 =

-- =

2.25.1

--===============6058741354455535213==--

