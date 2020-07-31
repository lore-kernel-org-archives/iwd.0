Content-Type: multipart/mixed; boundary="===============2285438040541838987=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 11/13] wfd-source: Display some stream properties
Date: Fri, 31 Jul 2020 03:31:34 +0200
Message-ID: <20200731013136.65057-11-andrew.zaborowski@intel.com>
In-Reply-To: <20200731013136.65057-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2285438040541838987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Define a bunch of stream parameters each with a getter and an optional
setter.  In the right pane of the window show widgets for these
properties, some as just labels and some as editable controls depending
on the type of the property.  Parse the EDID data.
---
 test/wfd-source | 361 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 326 insertions(+), 35 deletions(-)

diff --git a/test/wfd-source b/test/wfd-source
index 09b47a27..261ae750 100755
--- a/test/wfd-source
+++ b/test/wfd-source
@@ -16,6 +16,7 @@ import collections.abc
 import random
 import dataclasses
 import traceback
+import codecs
 =

 import gi
 gi.require_version('GLib', '2.0')
@@ -27,7 +28,9 @@ class WFDRTSPServer:
     class RTSPException(Exception):
         pass
 =

-    def __init__(self, port, state_handler, error_handler):
+    Prop =3D collections.namedtuple('Prop', ['name', 'desc', 'getter', 'se=
tter', 'type', 'vals'])
+
+    def __init__(self, port, state_handler, error_handler, init_values, pr=
op_handler):
         # Should start the TCP server only on the P2P connection's local I=
P but we won't
         # know the IP or interface name until after the connection is esta=
blished.  At that
         # time the sink may try to make the TCP connection at any time so =
our listen
@@ -44,7 +47,8 @@ class WFDRTSPServer:
 =

         self.state_handler =3D state_handler
         self.error_handler =3D error_handler
-        self.sm_init()
+        self.prop_handler =3D prop_handler
+        self.sm_init(init_values)
 =

     def handle_data_out(self, conn, *args):
         try:
@@ -200,7 +204,11 @@ class WFDRTSPServer:
     def ready(self):
         return self._state in ['streaming', 'paused']
 =

-    def sm_init(self):
+    @property
+    def props(self):
+        return self._props
+
+    def sm_init(self, init_values):
         self._state =3D 'waiting-rtsp'
         self.local_params =3D {
             'wfd_video_formats': '00 00 01 08 00000000 00000000 00000040 0=
0 0000 0000 00 none none'
@@ -226,6 +234,33 @@ class WFDRTSPServer:
         self.rtsp_keepalive_timeout =3D None
         self.expected_remote_ip =3D None
         self.remote_ip =3D None
+        self.init_width =3D init_values['width']
+        self.init_height =3D init_values['height']
+        self.rtcp_enabled =3D init_values['rtcp_enabled']
+
+        self._props =3D []
+
+    @staticmethod
+    def get_init_props():
+        props =3D []
+        values =3D {
+            'width': 800,
+            'height': 600,
+            'rtcp_enabled': True
+        }
+
+        def set_val(key, val):
+            values[key] =3D val
+        props.append(WFDRTSPServer.Prop('Output width', 'Scale the video s=
tream to this X resolution for sending',
+            lambda: values['width'], lambda x: set_val('width', x), int, (=
640, 1920)))
+        props.append(WFDRTSPServer.Prop('Output height', 'Scale the video =
stream to this Y resolution for sending',
+            lambda: values['height'], lambda x: set_val('height', x), int,=
 (480, 1080)))
+        props.append(WFDRTSPServer.Prop('Enable RTCP', 'Use RTCP if the Si=
nk requests it during setup',
+            lambda: values['rtcp_enabled'], lambda x: set_val('rtcp_enable=
d', x), bool, None))
+        # TODO: Enable Audio
+        # TODO: Audio source
+
+        return props, values
 =

     def close(self):
         # Avoid passing self to io watches so that the refcount can ever r=
each 0 and
@@ -431,6 +466,94 @@ class WFDRTSPServer:
                 self.error('Optional RTCP port not valid in SETUP Transpor=
t header: ' + str(rtcp_port))
             self.remote_rtcp_port =3D rtcp_port
 =

+        self._props.append(WFDRTSPServer.Prop('RTP transport', '', lambda:=
 'TCP' if self.use_tcp else 'UDP', None, str, None))
+        self._props.append(WFDRTSPServer.Prop('Remote RTP port', '', lambd=
a: self.remote_rtp_port, None, int, None))
+        self._props.append(WFDRTSPServer.Prop('Remote RTCP port', '', lamb=
da: self.remote_rtcp_port, None, int, None))
+
+    def parse_display_edid(self):
+        try:
+            len_str, hex_str =3D self.remote_params['wfd_display_edid'].sp=
lit(' ', 1)
+            if len(len_str.strip()) !=3D 4:
+                raise Exception('edid-block-count length is not 4 hex digi=
ts')
+            blocks =3D int(len_str, 16)
+            edid =3D codecs.decode(hex_str.strip(), 'hex')
+            if blocks < 1 or blocks > 256 or blocks * 128 !=3D len(edid):
+                raise Exception('edid-block-count value wrong')
+        except:
+            edid =3D None
+
+        self._props.append(WFDRTSPServer.Prop('EDID info', 'Remote display=
\'s EDID data', lambda: edid, None, bytes, None))
+
+    def create_running_props(self):
+        src =3D self.rtp_pipeline.get_by_name('src')
+        fps =3D self.rtp_pipeline.get_by_name('fps')
+        enc =3D self.rtp_pipeline.get_by_name('videnc')
+        res =3D self.rtp_pipeline.get_by_name('res')
+        sink =3D self.rtp_pipeline.get_by_name('sink')
+        self.pipeline_props =3D []
+
+        srcpadcaps =3D src.srcpads[0].get_allowed_caps()
+        width =3D srcpadcaps[0]['width']
+        height =3D srcpadcaps[0]['height']
+        props =3D []
+        props.append(WFDRTSPServer.Prop('Local width', 'Local screen X res=
olution', lambda: width, None, int, None))
+        props.append(WFDRTSPServer.Prop('Local height', 'Local screen Y re=
solution', lambda: height, None, int, None))
+
+        def set_use_damage(val):
+            src.props.use_damage =3D val
+        props.append(WFDRTSPServer.Prop('Use XDamage', 'Try to use XDamage=
 to reduce bandwidth usage',
+            lambda: src.props.use_damage, set_use_damage, bool, None))
+
+        src.props.endx =3D width
+        src.props.endy =3D height
+        def set_startx(val):
+            src.set_property('startx', min(val, src.props.endx - 1))
+        def set_starty(val):
+            src.set_property('starty', min(val, src.props.endy - 1))
+        def set_endx(val):
+            src.set_property('endx', max(val, src.props.startx + 1))
+        def set_endy(val):
+            src.set_property('endy', max(val, src.props.starty + 1))
+        props.append(WFDRTSPServer.Prop('Window min X', 'Skip this many pi=
xels on the left side of the local screen',
+            lambda: src.props.startx, set_startx, int, (0, width - 1)))
+        props.append(WFDRTSPServer.Prop('Window min Y', 'Skip this many pi=
xels on the top of the local screen',
+            lambda: src.props.starty, set_starty, int, (0, height - 1)))
+        props.append(WFDRTSPServer.Prop('Window max X', 'Send screen conte=
nts only up to this X coordinate',
+            lambda: src.props.endx, set_endx, int, (1, width)))
+        props.append(WFDRTSPServer.Prop('Window max Y', 'Send screen conte=
nts only up to this Y coordinate',
+            lambda: src.props.endy, set_endy, int, (1, height)))
+
+        def set_framerate(val):
+            fps.props.caps[0]['framerate'] =3D Gst.Fraction(val)
+        def set_width(val):
+            res.props.caps[0]['width'] =3D val
+        def set_height(val):
+            res.props.caps[0]['height'] =3D val
+        props.append(WFDRTSPServer.Prop('Framerate', 'Try to output this m=
any frames per second',
+            lambda: int(fps.props.caps[0]['framerate'].num), set_framerate=
, int, (1, 30)))
+        props.append(WFDRTSPServer.Prop('Output width', 'Scale the video s=
tream to this X resolution for sending',
+            lambda: res.props.caps[0]['width'], set_width, int, (640, 1920=
)))
+        props.append(WFDRTSPServer.Prop('Output height', 'Scale the video =
stream to this Y resolution for sending',
+            lambda: res.props.caps[0]['height'], set_height, int, (480, 10=
80)))
+
+        preset_values =3D ['veryslow', 'slower', 'slow', 'medium', 'fast',=
 'faster', 'veryfast', 'superfast', 'ultrafast', 'placebo']
+        preset_map =3D {'veryslow': 9, 'slower': 8, 'slow': 7, 'medium': 6=
, 'fast': 5, 'faster': 4, 'veryfast': 3, 'superfast': 2, 'ultrafast': 1, 'p=
lacebo': 10}
+
+        def set_speed_preset(val):
+            enc.props.speed_preset =3D preset_map[val]
+        props.append(WFDRTSPServer.Prop('H.264 speed preset', 'Speed/quali=
ty setting of the H.264 encoder to optimise bandwidth/latency',
+            lambda: enc.props.speed_preset.value_nick, set_speed_preset, s=
tr, preset_values))
+
+        def set_max_lateness(val):
+            if val <=3D 0:
+                sink.props.max_lateness =3D -1
+            else:
+                sink.props.max_lateness =3D val * 1000000 # milliseconds t=
o nanoseconds
+        props.append(WFDRTSPServer.Prop('Max lateness', 'Maximum number of=
 milliseconds that a buffer can be late before it is dropped, or 0 for unli=
mited',
+            lambda: 0 if sink.props.max_lateness =3D=3D -1 else sink.props=
.max_lateness / 1000000, set_max_lateness, int, (-1, 3000)))
+
+        return props
+
     def on_gst_message(self, bus, message):
         t =3D message.type
         if t =3D=3D Gst.MessageType.EOS:
@@ -438,6 +561,8 @@ class WFDRTSPServer:
         elif t =3D=3D Gst.MessageType.STATE_CHANGED:
             old, new, pending =3D message.parse_state_changed()
             self.debug('Gstreamer state change for ' + message.src.name + =
' from ' + str(old) + ' to ' + str(new) + ', pending=3D' + str(pending))
+            if message.src =3D=3D self.rtp_pipeline:
+                self.prop_handler()
         elif t =3D=3D Gst.MessageType.INFO:
             err, debug =3D message.parse_info()
             self.debug('Gstreamer info for ' + message.src.name + ': ' + s=
tr(err) + '\nDebug: ' + str(debug))
@@ -511,7 +636,8 @@ class WFDRTSPServer:
             # Send M2 response
             self.response(public=3Dself.local_methods)
             # Send M3
-            self.request('GET_PARAMETER', 'rtsp://localhost/wfd1.0', param=
s=3D['wfd_audio_codecs', 'wfd_video_formats', 'wfd_client_rtp_ports', 'wfd_=
display_edid', 'wfd_uibc_capability'])
+            params =3D ['wfd_audio_codecs', 'wfd_video_formats', 'wfd_clie=
nt_rtp_ports', 'wfd_display_edid', 'wfd_uibc_capability']
+            self.request('GET_PARAMETER', 'rtsp://localhost/wfd1.0', param=
s=3Dparams)
             self.enter_state('M3')
         elif self._state =3D=3D 'M3':
             # Validate M3 response
@@ -520,6 +646,8 @@ class WFDRTSPServer:
                 self.error('Required parameters missing from GET_PARAMETER=
 response')
             self.parse_video_formats(self.remote_params['wfd_video_formats=
'])
             self.parse_client_rtp_ports(self.remote_params['wfd_client_rtp=
_ports'])
+            self.parse_display_edid()
+            self.prop_handler()
             # Send M4
             params =3D {
                 'wfd_video_formats': self.local_params['wfd_video_formats'=
],
@@ -547,7 +675,7 @@ class WFDRTSPServer:
             self.session_stream_url =3D target
             self.session_id =3D str(random.randint(a=3D1, b=3D999999))
             self.local_rtp_port =3D random.randint(a=3D20000, b=3D30000)
-            if self.remote_rtcp_port is not None:
+            if self.remote_rtcp_port is not None and self.rtcp_enabled:
                 self.local_rtcp_port =3D self.local_rtp_port + 1
             profile =3D'RTP/AVP/TCP;unicast' if self.use_tcp else 'RTP/AVP=
/UDP;unicast'
             client_port =3D str(self.remote_rtp_port) + (('-' + str(self.r=
emote_rtcp_port)) if self.remote_rtcp_port is not None else '')
@@ -555,22 +683,26 @@ class WFDRTSPServer:
             transport =3D profile + ';client_port' + client_port + ';serve=
r_port=3D' + server_port
             # Section B.1
             pipeline =3D ('ximagesrc name=3Dsrc use-damage=3Dfalse do-time=
stamp=3Dtrue ! capsfilter name=3Dfps caps=3Dvideo/x-raw,framerate=3D10/1' +
-                ' ! videoscale method=3D0 ! capsfilter name=3Dres caps=3Dv=
ideo/x-raw,width=3D800,height=3D600' +
+                ' ! videoscale method=3D0 ! capsfilter name=3Dres caps=3Dv=
ideo/x-raw,width=3D' + str(self.init_width) + ',height=3D' + str(self.init_=
height) +
                 ' ! videoconvert ! video/x-raw,format=3DI420 ! x264enc tun=
e=3Dzerolatency speed-preset=3Dultrafast name=3Dvidenc' +
                 ' ! queue' + # TODO: add leaky=3Ddownstream
                 ' ! mpegtsmux name=3Dmux' +
                 ' ! rtpmp2tpay pt=3D33 mtu=3D1472 ! .send_rtp_sink rtpsess=
ion name=3Dsession .send_rtp_src' +
-                ' ! udpsink host=3D' + self.remote_ip + ' port=3D' + str(s=
elf.remote_rtp_port) + ' bind-port=3D' + str(self.local_rtp_port)) # TODO: =
bind-address
-
+                ' ! udpsink name=3Dsink host=3D' + self.remote_ip + ' port=
=3D' + str(self.remote_rtp_port) + ' bind-port=3D' + str(self.local_rtp_por=
t)) # TODO: bind-address
             if self.local_rtcp_port is not None:
                 pipeline +=3D ' session.send_rtcp_src ! udpsink name=3Drtc=
p_sink host=3D' + self.remote_ip + \
                     ' port=3D' + str(self.remote_rtcp_port) + ' bind-port=
=3D' + str(self.local_rtcp_port) # TODO: bind-address
+            self._props.append(WFDRTSPServer.Prop('RTCP enabled', 'Whether=
 we\'re currently sending RTCP data',
+                lambda: self.local_rtcp_port is not None, None, bool, None=
))
 =

             self.rtp_pipeline =3D Gst.parse_launch(pipeline)
             bus =3D self.rtp_pipeline.get_bus()
             bus.enable_sync_message_emission()
             bus.add_signal_watch()
-            bus.connect('sync-message', self.on_gst_message)
+            bus.connect('message', self.on_gst_message)
+
+            self._props +=3D self.create_running_props()
+            self.prop_handler()
 =

             # Send M6 response
             self.response(session=3Dself.session_id + ';timeout=3D' + str(=
self.session_timeout), transport=3Dtransport)
@@ -653,12 +785,16 @@ class WFDSource(Gtk.Window):
         self.device_box =3D Gtk.Box(orientation=3DGtk.Orientation.VERTICAL)
         leftscroll =3D Gtk.ScrolledWindow(hscrollbar_policy=3DGtk.PolicyTy=
pe.NEVER)
         leftscroll.add(self.device_box)
-        self.infolabel1 =3D Gtk.Label()
-        self.infolabel1.set_ellipsize(Pango.EllipsizeMode.START)
-        infopane =3D Gtk.Box(orientation=3DGtk.Orientation.HORIZONTAL)
-        infopane.pack_start(self.infolabel1, False, False, padding=3D10)
-        rightscroll =3D Gtk.ScrolledWindow(hscrollbar_policy=3DGtk.PolicyT=
ype.NEVER, vscrollbar_policy=3DGtk.PolicyType.NEVER)
-        rightscroll.add(infopane)
+        self.infopane =3D Gtk.FlowBox(orientation=3DGtk.Orientation.VERTIC=
AL)
+        self.infopane.set_selection_mode(Gtk.SelectionMode.NONE)
+        self.infopane.set_max_children_per_line(20)
+        self.infopane.set_min_children_per_line(3)
+        self.infopane.set_column_spacing(20)
+        self.infopane.set_row_spacing(5)
+        self.infopane.set_valign(Gtk.Align.START)
+        self.infopane.set_halign(Gtk.Align.START)
+        rightscroll =3D Gtk.ScrolledWindow(vscrollbar_policy=3DGtk.PolicyT=
ype.NEVER)
+        rightscroll.add(self.infopane)
         paned =3D Gtk.Paned(orientation=3DGtk.Orientation.HORIZONTAL)
         paned.pack1(leftscroll, True, True)
         paned.pack2(rightscroll, False, False)
@@ -669,6 +805,8 @@ class WFDSource(Gtk.Window):
         self.show_all()
         self.connect('notify::is-active', self.on_notify_is_active)
 =

+        self.rtsp_props =3D None
+        self.rtsp_init_values =3D {}
         self.rtsp_port =3D 7236
         self.devices =3D None
         self.objects =3D {}
@@ -1001,11 +1139,13 @@ class WFDSource(Gtk.Window):
             peer_list.insert(peer.widget, index)
             peer.widget.show_all()
         elif (PEER_IF not in props or WFD_IF not in props or WSC_IF not in=
 props or not props[WFD_IF]['Sink']) and peer.widget:
-            del device.sorted_peers[peer.widget.get_index()]
-            peer_list.remove(peer.widget)
+            tmp =3D peer.widget
+            peer.widget =3D None
+            del device.sorted_peers[tmp.get_index()]
+            peer_list.remove(tmp)
             if peer =3D=3D device.selected_peer:
                 device.selected_peer =3D None
-                self.update_info(dev_path, None)
+                self.update_info_pane(dev_path, None)
             if peer =3D=3D device.connecting_peer:
                 device.dbus_call.cancel()
                 device.connecting_peer =3D None
@@ -1020,7 +1160,6 @@ class WFDSource(Gtk.Window):
             peer.peer_proxy =3D None
             peer.wfd_proxy =3D None
             peer.wsc_proxy =3D None
-            peer.widget =3D None
             if peer.rtsp:
                 peer.rtsp.close()
                 peer.rtsp =3D None
@@ -1055,7 +1194,7 @@ class WFDSource(Gtk.Window):
             button.hide()
 =

         if peer =3D=3D device.selected_peer:
-            self.update_info(dev_path, path)
+            self.update_info_pane(dev_path, path)
 =

     def update_selected_peer(self, dev_path):
         device =3D self.devices[dev_path]
@@ -1063,12 +1202,74 @@ class WFDSource(Gtk.Window):
             sel_path =3D self.get_peer_path(device, device.selected_peer)
             self.update_peer_props(dev_path, sel_path)
 =

-    def update_info(self, dev_path, path):
-        device =3D self.devices[dev_path]
+    def add_info(self, name, desc, valuewidget):
+        namelabel =3D Gtk.Label(label=3Dname + ':', xalign=3D0)
+        box =3D Gtk.Box(orientation=3DGtk.Orientation.HORIZONTAL)
+        box.pack_start(namelabel, expand=3DFalse, fill=3DFalse, padding=3D=
3)
+        if valuewidget:
+            box.pack_end(valuewidget, expand=3DFalse, fill=3DFalse, paddin=
g=3D3)
+        if desc:
+            box.set_tooltip_text(desc)
+        self.infopane.add(box)
+
+    def add_info_str(self, name, value):
+        vlabel =3D Gtk.Label(xalign=3D0)
+        vlabel.set_markup('<span weight=3D"bold">' + value + '</span>')
+        self.add_info(name, None, vlabel)
+
+    def add_info_prop(self, prop):
+        val =3D prop.getter()
+        if prop.setter is None:
+            if val is None:
+                return
+            if prop.type =3D=3D bool:
+                vals =3D prop.vals if prop.vals is not None else ['no', 'y=
es']
+                text =3D vals[val]
+            elif prop.name =3D=3D 'EDID info':
+                text =3D WFDSource.edid_to_text(val)
+                if isinstance(text, collections.abc.Sequence):
+                    self.add_info(prop.name, prop.desc, None)
+                    for name, val in text:
+                        if val:
+                            v =3D Gtk.Label(xalign=3D0)
+                            v.set_markup('<span weight=3D"bold">=C2=BB ' +=
 str(val) + '</span>')
+                            self.add_info(name, prop.desc, v)
+                        else:
+                            self.add_info(name, prop.desc, None)
+                    return
+            else:
+                text =3D str(val)
+            v =3D Gtk.Label(xalign=3D0)
+            v.set_markup('<span weight=3D"bold">' + text + '</span>')
+        elif val is None:
+            return
+        elif prop.type =3D=3D bool:
+            v =3D Gtk.Switch()
+            v.set_active(val)
+            v.connect('state-set', lambda switch, state: prop.setter(state=
))
+        elif prop.type =3D=3D int:
+            v =3D Gtk.SpinButton.new_with_range(min=3Dprop.vals[0], max=3D=
prop.vals[1], step=3Dprop.vals[2] if len(prop.vals) > 2 else 1)
+            v.set_value(val)
+            v.connect('value-changed', lambda sb: prop.setter(int(sb.get_v=
alue())))
+        elif prop.type =3D=3D str:
+            if prop.vals:
+                v =3D Gtk.ComboBoxText()
+                for option in prop.vals:
+                    v.append(option, option)
+                v.set_active_id(val)
+                v.connect('changed', lambda entry: prop.setter(entry.get_a=
ctive_text()))
+            else:
+                v =3D Gtk.Entry(text=3Dval)
+                v.connect('changed', lambda entry: prop.setter(entry.get_t=
ext()))
+        self.add_info(prop.name, prop.desc, v)
+
+    def update_info_pane(self, dev_path, path):
+        self.infopane.foreach(lambda x, y: self.infopane.remove(x), None)
+
         if path is None:
-            self.infolabel1.set_text('')
             return
 =

+        device =3D self.devices[dev_path]
         peer =3D device.peers[path]
 =

         if peer =3D=3D device.connecting_peer:
@@ -1085,14 +1286,13 @@ class WFDSource(Gtk.Window):
                 state =3D 'connected'
         else:
             state =3D 'not connected'
+        self.add_info_str('Connection state', state)
 =

         subcat =3D 'unknown'
         if 'DeviceSubcategory' in self.objects[path][PEER_IF]:
             subcat =3D self.objects[path][PEER_IF]['DeviceSubcategory']
-
-        text =3D ('Connection state: ' + state + '\n' +
-                'Device category: ' + self.objects[path][PEER_IF]['DeviceC=
ategory'] + '\n'
-                'Device subcategory: ' + subcat + '\n')
+        self.add_info_str('Peer category', self.objects[path][PEER_IF]['De=
viceCategory'])
+        self.add_info_str('Peer subcategory', subcat)
 =

         if WFD_IF in self.objects[path]:
             if self.objects[path][WFD_IF]['Source']:
@@ -1102,17 +1302,27 @@ class WFDSource(Gtk.Window):
                     t =3D 'source'
             else:
                 t =3D 'sink'
-            text +=3D 'WFD device type: ' + t + '\n'
+            self.add_info_str('Peer WFD type', t)
 =

             if self.objects[path][WFD_IF]['Sink']:
-                text +=3D 'Audio: ' + ('yes' if self.objects[path][WFD_IF]=
['HasAudio'] else 'no') + '\n'
+                self.add_info_str('Peer audio support', 'yes' if self.obje=
cts[path][WFD_IF]['HasAudio'] else 'no')
+
+            self.add_info_str('Peer UIBC support', 'yes' if self.objects[p=
ath][WFD_IF]['HasUIBC'] else 'no')
+
+            self.add_info_str('Peer content protection', 'yes' if self.obj=
ects[path][WFD_IF]['HasContentProtection'] else 'no')
 =

-            text +=3D 'UIBC: ' + ('yes' if self.objects[path][WFD_IF]['Has=
UIBC'] else 'no') + '\n'
+        if self.rtsp_props is None:
+            self.rtsp_props, self.rtsp_init_values =3D WFDRTSPServer.get_i=
nit_props()
+
+        if peer.rtsp is not None:
+            props =3D peer.rtsp.props
+        else:
+            props =3D self.rtsp_props
 =

-            text +=3D 'Content protection: ' + ('yes' if self.objects[path=
][WFD_IF]['HasContentProtection'] else 'no') + '\n'
+        for prop in props:
+            self.add_info_prop(prop)
 =

-        self.infolabel1.set_text(text)
-        # TODO: more info in labels 2 and so on
+        self.infopane.show_all()
 =

     # Direct method calls on dbus.Interface's don't return dbus.lowlevel.P=
endingCall objects so
     # we have to use bus.call_async to make cancellable async calls
@@ -1172,12 +1382,17 @@ class WFDSource(Gtk.Window):
 =

             dialog.connect('response', on_ok)
 =

+        def on_rtsp_props_changed():
+            # Should also check if the infopane is currently showing a sel=
ected peer on another device...
+            if peer =3D=3D device.selected_peer:
+                self.update_info_pane(dev_path, path)
+
         # Cannot use peer.wsc_proxy.PushButton()
         device.dbus_call =3D self.async_call(peer.wsc_proxy, 'PushButton',=
 reply_handler=3Don_reply, error_handler=3Don_error, timeout=3D120)
         device.connecting_peer =3D peer
         # Create the RTSP server now so it's ready as soon as the P2P conn=
ection succeeds even if
         # we haven't received the DBus reply yet
-        peer.rtsp =3D WFDRTSPServer(self.rtsp_port, on_rtsp_state, on_rtsp=
_error)
+        peer.rtsp =3D WFDRTSPServer(self.rtsp_port, on_rtsp_state, on_rtsp=
_error, self.rtsp_init_values, on_rtsp_props_changed)
         self.update_dev_props(dev_path)
         self.update_peer_props(dev_path, path)
         if peer !=3D device.selected_peer:
@@ -1272,7 +1487,7 @@ class WFDSource(Gtk.Window):
             path =3D self.get_peer_path(device, device.selected_peer)
             device.selected_peer =3D None
             self.update_peer_props(dev_path, path)
-            self.update_info(dev_path, None)
+            self.update_info_pane(dev_path, None)
 =

         if row is None:
             return True
@@ -1335,6 +1550,82 @@ class WFDSource(Gtk.Window):
         mainloop.quit()
         return False
 =

+    @staticmethod
+    def edid_to_text(edid):
+        if edid is None:
+            return 'unavailable'
+        if len(edid) < 128:
+            return 'invalid (too short)'
+        if edid[0:8] !=3D b'\0\xff\xff\xff\xff\xff\xff\0':
+            return 'invalid (bad magic)'
+        if sum(edid[0:128]) & 255 !=3D 0:
+            return 'invalid (bad checksum)'
+
+        header =3D edid[0:20]
+        manf_id =3D (header[8] << 8) + header[9]
+        text =3D [('Header', '')]
+        text.append(('=C2=BB Version', str(header[18]) + '.' + str(header[=
19])))
+        text.append(('=C2=BB Manufacturer ID', chr(64 + ((manf_id >> 10) &=
 31)) + chr(64 + ((manf_id >> 5) & 31)) + chr(64 + ((manf_id >> 0) & 31))))
+        text.append(('=C2=BB Product code', hex((header[11] << 8) + header=
[10])))
+        text.append(('=C2=BB Serial', hex((header[15] << 24) +(header[14] =
<< 16) +  (header[13] << 8) + header[12])))
+        text.append(('=C2=BB Manufactured', str(1990 + header[17]) + ' wee=
k ' + str(header[16])))
+
+        basic_params =3D edid[20:25]
+        text.append(('Basic parameters', ''))
+        if basic_params[0] & 0x80:
+            intf_table =3D {
+                2: 'HDMIa',
+                3: 'HDMIb',
+                4: 'MDDI',
+                5: 'DisplayPort'
+            }
+            dt_table =3D {
+                0: 'RGB 4:4:4',
+                1: 'RGB 4:4:4 + YCrCb 4:4:4',
+                2: 'RGB 4:4:4 + YCrCb 4:2:2',
+                3: 'RGB 4:4:4 + YCrCb 4:4:4 + YCrCb 4:2:2'
+            }
+            bpp =3D (basic_params[0] >> 4) & 7
+            intf =3D (basic_params[0] >> 0) & 7
+
+            text.append(('=C2=BB Video input type', 'digital'))
+            text.append(('=C2=BB Bit depth', 'undefined' if bpp in [0, 7] =
else str(4 + bpp * 2)))
+            text.append(('=C2=BB Interface', 'undefined' if intf not in in=
tf_table else intf_table[intf]))
+        else:
+            level_table =3D {
+                0: '+0.7 / -0.3 V',
+                1: '+0.714 / -0.286 V',
+                2: '+1.0 / -0.4 V',
+                3: '+0.7 / 0 V'
+            }
+            dt_table =3D {
+                0: 'monochrome/grayscale',
+                1: 'RGB color',
+                2: 'non-RGB color',
+                3: 'undefined'
+            }
+            text.append(('=C2=BB Video input type', 'analog'))
+            text.append(('=C2=BB Video white/sync level', level_table[(bas=
ic_parmas[0] >> 5) & 3]))
+
+        if basic_params[1] and basic_params[2]:
+            text.append(('=C2=BB Screen width', str(basic_params[1]) + ' c=
m'))
+            text.append(('=C2=BB Screen height', str(basic_params[2]) + ' =
cm'))
+        elif basic_params[2] =3D=3D 0:
+            text.append(('=C2=BB Landscape aspect ratio', str((basic_param=
s[1] + 99) * 0.01)))
+        else:
+            text.append(('=C2=BB Portrait aspect ratio', str(100.0 / (basi=
c_params[2] + 99))))
+
+        text.append(('=C2=BB Gamma', str((basic_params[3] + 100) * 0.01)))
+        text.append(('=C2=BB DPMS Standby', 'supported' if (basic_params[4=
] >> 7) & 1 else 'unsupported'))
+        text.append(('=C2=BB DPMS Suspend', 'supported' if (basic_params[4=
] >> 6) & 1 else 'unsupported'))
+        text.append(('=C2=BB DPMS Active-off', 'supported' if (basic_param=
s[4] >> 5) & 1 else 'unsupported'))
+        text.append(('=C2=BB Color type', dt_table[(basic_params[4] >> 3) =
& 3]))
+        text.append(('=C2=BB sRGB color space', 'yes' if (basic_params[4] =
>> 2) & 1 else 'no'))
+        text.append(('=C2=BB Continuous timings', 'yes' if (basic_params[4=
] >> 0) & 1 else 'no'))
+
+        # TODO: timing information and extensions
+        return text
+
 dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
 Gst.init(None)
 WFDSource()
-- =

2.25.1

--===============2285438040541838987==--

