Content-Type: multipart/mixed; boundary="===============0361360201998007872=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/4] test: Add a sample Wi-Fi Display source app
Date: Thu, 16 Jul 2020 02:10:18 +0200
Message-ID: <20200716001018.311387-4-andrew.zaborowski@intel.com>
In-Reply-To: <20200716001018.311387-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0361360201998007872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/wfd-source | 1318 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1318 insertions(+)
 create mode 100755 test/wfd-source

diff --git a/test/wfd-source b/test/wfd-source
new file mode 100755
index 00000000..0845d090
--- /dev/null
+++ b/test/wfd-source
@@ -0,0 +1,1318 @@
+#! /usr/bin/python3
+#
+# Copyright (C) 2020  Intel Corporation
+#
+# A simplified WFD source that streams the X11 screen using gstreamer
+# A more complete solution would create a virtual screen visible through t=
he normal system calls, xrandr, etc.,
+# with its pixel aspect ratio, EDID data and what not.  This would allow t=
he user to configure it like a real
+# display in mirror mode or side-by-side mode.
+
+import sys
+import dbus
+import dbus.mainloop.glib
+import socket
+import collections
+import collections.abc
+import random
+import dataclasses
+
+import gi
+gi.require_version('GLib', '2.0')
+gi.require_version('Gst', '1.0')
+gi.require_version('Gtk', '3.0')
+from gi.repository import GLib, Gst, Gtk, Gdk, Pango
+
+class WFDRTSPServer:
+    class RTSPException(Exception):
+        pass
+
+    def __init__(self, port, state_handler, error_handler):
+        # Should start the TCP server only on the P2P connection's local I=
P but we won't
+        # know the IP or interface name until after the connection is esta=
blished.  At that
+        # time the sink may try to make the TCP connection at any time so =
our listen
+        # socket should be up before this.
+        server_address =3D ('0.0.0.0', port)
+        self.server =3D socket.socket(socket.AF_INET, socket.SOCK_STREAM)
+        self.server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEPORT, 1)
+        self.server.bind(server_address)
+        self.server.listen(1)
+        GLib.io_add_watch(self.server, GLib.IO_IN, self.handle_connection)
+        self.conn =3D None
+        self.tx_queue =3D []
+        self.rx_queue =3D b''
+
+        self.state_handler =3D state_handler
+        self.error_handler =3D error_handler
+        self.sm_init()
+
+    def handle_data_out(self, conn, *args):
+        try:
+            cmd =3D self.tx_queue.pop(0)
+            sent =3D self.conn.send(cmd)
+
+            if sent < len(cmd):
+                self.tx_queue.insert(0, cmd[sent:])
+
+            return len(self.tx_queue) > 0
+        except Exception as e:
+            self.error_handler(e)
+            return False
+
+    def tx_queue_append(self, cmd):
+        if not self.tx_queue:
+            GLib.io_add_watch(self.conn.fileno(), GLib.IO_OUT, self.handle=
_data_out)
+
+        self.tx_queue.append(cmd.encode('utf-8'))
+        self.debug('queued cmd: ' + cmd)
+
+    def handle_data_hup(self, conn, *args):
+        try:
+            self.debug('HUP')
+            self.error('Disconnected')
+        except Exception as e:
+            self.error_handler(e)
+            return False
+
+    def handle_data_in(self, conn, *args):
+        try:
+            newdata =3D self.conn.recv(4096)
+            if len(newdata) =3D=3D 0:
+                self.debug('recv returned 0 bytes')
+                # Disconnect from P2P
+                self.error('Disconnected')
+                return False
+
+            self.debug('received data: ' + str(newdata))
+            self.rx_queue +=3D newdata
+
+            while b'\r\n\r\n' in self.rx_queue:
+                msg, content =3D self.rx_queue.split(b'\r\n\r\n', 1)
+                lines =3D msg.split(b'\r\n')
+
+                headers =3D {}
+                for line in lines[1:]:
+                    if b':' not in line:
+                        # Bad syntax
+                        rxbuf =3D b''
+                        return True
+
+                    name, value =3D line.decode('utf8').split(':', 1)
+                    name =3D name.lower()
+                    while len(value) and value[0] =3D=3D ' ':
+                        value =3D value[1:]
+
+                    if name in headers:
+                        # Duplicate
+                        rxbuf =3D b''
+                        return True
+
+                    headers[name] =3D value
+
+                cl =3D 0
+                if 'content-length' in headers:
+                    try:
+                        cl =3D int(headers['content-length'])
+                        if cl < 1 or cl > 1000:
+                            raise Exception('')
+                    except:
+                        # Bad syntax
+                        rxbuf =3D b''
+                        return True
+
+                    if len(content) < cl:
+                        # Wait for more data
+                        return True
+
+                top_line =3D lines[0].decode('utf8').split(None, 2)
+                self.rx_queue =3D self.rx_queue[len(msg) + 4 + cl:]
+                content =3D content[:cl]
+
+                if top_line[2] =3D=3D 'RTSP/1.0':
+                    self.source_handle_message(method=3Dtop_line[0], targe=
t=3Dtop_line[1], headers=3Dheaders, content=3Dcontent)
+                elif top_line[0] =3D=3D 'RTSP/1.0':
+                    try:
+                        status =3D int(top_line[1])
+                        if status < 1 or status > 999:
+                            raise Exception('Status out of range')
+                    except:
+                        self.error('Couldn\'t parse response status')
+
+                    self.source_handle_message(status=3Dstatus, reason=3Dt=
op_line[2], headers=3Dheaders, content=3Dcontent)
+                else:
+                    # Bad protocol
+                    self.error('Unknown protocol in ' + str(top_line))
+
+            return True
+        except Exception as e:
+            self.error_handler(e)
+            return False
+
+    def handle_connection(self, sock, *args):
+        try:
+            if self.conn:
+                return False
+            self.conn, addr =3D sock.accept()
+            self.debug('RTSP connection from: ' + str(addr))
+            self.remote_ip =3D addr[0]
+
+            if self.expected_remote_ip and self.remote_ip !=3D self.expect=
ed_remote_ip:
+                self.conn.close()
+                self.conn =3D None
+                self.debug('Connection refused, bad source address')
+                return True
+
+            sock.close()
+            self.server =3D None
+            GLib.io_add_watch(self.conn.fileno(), GLib.IO_IN, self.handle_=
data_in)
+            GLib.io_add_watch(self.conn.fileno(), GLib.IO_HUP, self.handle=
_data_hup)
+
+            self._state =3D 'init'
+            self.source_handle_message()
+            return False
+        except Exception as e:
+            self.error_handler(e)
+            return False
+
+    def error(self, msg):
+        self.enter_state('failed')
+        e =3D WFDRTSPServer.RTSPException('State ' + self._state + ': ' + =
msg)
+        self.debug('error: ' + msg)
+        raise e
+
+    def warning(self, msg):
+        self.debug('warning: ' + msg)
+        print('Warning: ' + msg + '\n')
+
+    def debug(self, msg):
+        pass
+
+    @property
+    def state(self):
+        return self._state
+
+    def enter_state(self, new_state):
+        self.debug('state change: ' + self._state + ' -> ' + new_state)
+        self._state =3D new_state
+        self.state_handler()
+
+    @property
+    def ready(self):
+        return self._state in ['streaming', 'paused']
+
+    def sm_init(self):
+        self._state =3D 'waiting-rtsp'
+        self.local_params =3D {
+            'wfd_video_formats': '00 00 01 08 00000000 00000000 00000040 0=
0 0000 0000 00 none none'
+        }
+        self.remote_params =3D {}
+        self.local_methods =3D [ 'org.wfa.wfd1.0', 'SET_PARAMETER', 'GET_P=
ARAMETER', 'PLAY', 'SETUP', 'TEARDOWN' ]
+        self.presentation_url =3D [ 'rtsp://127.0.0.1/wfd1.0/streamid=3D0'=
, 'none' ] # Table 88
+        self.session_stream_url =3D None
+        self.session_id =3D None
+        self.session_timeout =3D 60
+        self.local_cseq =3D 0
+        self.remote_cseq =3D None
+        self.last_method =3D None
+        self.last_require =3D []
+        self.last_params =3D []
+        self.remote_rtp_port =3D None
+        self.remote_rtcp_port =3D None
+        self.local_rtp_port =3D None
+        self.local_rtcp_port =3D None
+        self.use_tcp =3D None
+        self.rtp_pipeline =3D None
+        self.rtsp_keepalive =3D None
+        self.rtsp_keepalive_timeout =3D None
+        self.expected_remote_ip =3D None
+        self.remote_ip =3D None
+
+    def close(self):
+        # Avoid passing self to io watches so that the refcount can ever r=
each 0 and
+        # all this can be done in __del__
+        if self.rtsp_keepalive:
+            GLib.source_remove(self.rtsp_keepalive)
+            self.rtsp_keepalive =3D None
+        if self.rtsp_keepalive_timeout:
+            GLib.source_remove(self.rtsp_keepalive_timeout)
+            self.rtsp_keepalive_timeout =3D None
+        if self.rtp_pipeline:
+            self.rtp_pipeline.set_state(Gst.State.NULL)
+            self.rtp_pipeline =3D None
+        if self.server:
+            self.server.close()
+            self.server =3D None
+        if self.conn:
+            self.conn.close()
+            self.conn =3D None
+
+    def set_local_interface(self, new_value):
+        pass
+
+    def set_remote_ip(self, new_value):
+        self.expected_remote_ip =3D new_value
+
+        if self.conn and self.remote_ip !=3D self.expected_remote_ip:
+            self.error_handler(WFDRTSPServer.RTSPException('Connection was=
 from a wrong IP')) # TODO: do this in an idle cb
+
+    def validate_msg(self, method, expected_method, status, reason, header=
s, target, content):
+        if expected_method is None:
+            # Expected a response, not a request
+            if method is not None:
+                self.error('Received a "' + method + '" request where a re=
sponse was expected')
+            if status < 200 or status > 299:
+                self.error('Response status ' + str(status) + ' and reason=
: ' + reason)
+            if status !=3D 200:
+                self.warning('Response status was ' + str(status) + ' ("' =
+ reason + '") in state ' + self._state)
+
+            try:
+                if int(headers['cseq']) !=3D self.local_cseq:
+                    self.error('Response CSeq doesn\'t match')
+            except:
+                self.error('Missing or unparsable CSeq in a response')
+
+            if self.last_method =3D=3D 'OPTIONS':
+                if 'public' not in headers:
+                    self.error('Missing "Public" header in OPTIONS respons=
e')
+                public =3D [ m.strip() for m in headers['public'].split(',=
') ]
+                missing =3D [ m for m in self.last_require if m not in pub=
lic ]
+                if missing:
+                    self.error('Missing required method(s) "' + '", "'.joi=
n(missing) + '" in OPTIONS response')
+
+            if self.last_method =3D=3D 'GET_PARAMETER':
+                params =3D {}
+                for line in content.split(b'\r\n'):
+                    if b':' not in line:
+                        continue
+                    k, v =3D line.decode('utf8').split(':', 1)
+                    if k.strip() in params:
+                        self.error('Duplicate key "' + k + '" in GET_PARAM=
ETER response')
+                    params[k.strip()] =3D v.strip()
+                missing =3D [ p for p in self.last_params if p not in para=
ms ]
+                if missing: # Not an error
+                    self.warning('Missing key(s) "' + '", "'.join(missing)=
 + '" in GET_PARAMETER response')
+                self.remote_params.update(params)
+
+            return
+
+        if method is None:
+            self.error('Received an RTSP response where a ' + expected_met=
hod + ' was expected')
+
+        if method !=3D expected_method:
+            self.error('Received a "' + method + '" request where a ' + ex=
pected_method + ' was expected')
+        try:
+            if self.remote_cseq is not None and int(headers['cseq']) <=3D =
self.remote_cseq:
+                self.error('Unchanged CSeq in a new request')
+            self.remote_cseq =3D int(headers['cseq'])
+        except:
+            self.error('Missing or unparsable CSeq in a new request')
+        if method =3D=3D 'OPTIONS' and 'require' not in headers:
+            self.error('Missing "Require" header in OPTIONS request')
+        elif method =3D=3D 'SETUP' and 'transport' not in headers:
+            self.error('Missing "Transport" header in SETUP request')
+        elif method =3D=3D 'SETUP' and (target not in self.presentation_ur=
l or target =3D=3D 'none'):
+            self.error('Unknown target "' + target + '" in SETUP request')
+        elif method =3D=3D 'PLAY' and ('session' not in headers  or header=
s['session'] !=3D self.session_id):
+            self.error('Missing or invalid "Session" header in PLAY reques=
t')
+        elif method =3D=3D 'PLAY' and target !=3D self.session_stream_url:
+            self.error('Unknown target "' + target + '" in PLAY request')
+        elif method =3D=3D 'PAUSE' and 'session' not in headers:
+            self.error('Missing "Session" header in PAUSE request')
+        elif method =3D=3D 'PAUSE' and target !=3D self.session_stream_url:
+            self.error('Unknown target "' + target + '" in PAUSE request')
+        elif method =3D=3D 'TEARDOWN' and 'session' not in headers:
+            self.error('Missing "Session" header in TEARDOWN request')
+        elif method =3D=3D 'TEARDOWN' and target !=3D self.session_stream_=
url:
+            self.error('Unknown target "' + target + '" in TEARDOWN reques=
t')
+        elif method =3D=3D 'SET_PARAMETER':
+            pass
+
+    def request(self, method, target, require=3D[], params=3D[]):
+        content =3D ''
+        cmd =3D method + ' ' + target + ' RTSP/1.0\r\n'
+
+        self.local_cseq +=3D 1
+        cmd +=3D 'CSeq: ' + str(self.local_cseq) + '\r\n'
+
+        if require:
+            cmd +=3D 'Require: ' + ', '.join(require) + '\r\n'
+
+        if params:
+            if isinstance(params, collections.abc.Mapping):
+                content =3D ''.join([ k + ': ' + params[k] + '\r\n' for k =
in params ])
+            else:
+                content =3D ''.join([ k + '\r\n' for k in params ])
+            content_type =3D 'text/parameters'
+
+        if content:
+            cmd +=3D 'Content-Type: ' + content_type + '\r\n'
+            cmd +=3D 'Content-Length: ' + str(len(content)) + '\r\n'
+
+        cmd +=3D '\r\n'
+        self.tx_queue_append(cmd + content)
+        self.last_method =3D method
+        self.last_require =3D require
+        self.last_params =3D params
+
+    def response(self, public=3D[], session=3DNone, transport=3DNone):
+        cmd =3D 'RTSP/1.0 200 OK\r\n'
+
+        cmd +=3D 'CSeq: ' + str(self.remote_cseq) + '\r\n'
+
+        if public:
+            cmd +=3D 'Public: ' + ', '.join(public) + '\r\n'
+        if session is not None:
+            cmd +=3D 'Session: ' + session + '\r\n'
+        if transport is not None:
+            cmd +=3D 'Transport: ' + transport + '\r\n'
+
+        cmd +=3D '\r\n'
+        self.tx_queue_append(cmd)
+
+    def parse_video_formats(self, value):
+        # TODO
+        pass
+
+    def parse_client_rtp_ports(self, value):
+        profile, rtp_p0_str, rtp_p1_str, mode =3D value.split()
+        try:
+            rtp_p0 =3D int(rtp_p0_str)
+            rtp_p1 =3D int(rtp_p1_str)
+        except:
+            self.error('Can\'t parse rtp-port in wfd-client-rtp-ports: ' +=
 value)
+        if rtp_p0 < 1 or rtp_p0 > 65535:
+            self.error('rtp-port0 not valid for Primary Sink: ' + rtp_p0_s=
tr)
+        if rtp_p1 !=3D 0: # Table 90
+            self.error('rtp-port1 not valid for Primary Sink: ' + rtp_p1_s=
tr)
+        if profile not in ['RTP/AVP/UDP;unicast', 'RTP/AVP/TCP;unicast']:
+            self.error('Unknown RTP transport in wfd-client-rtp-ports: ' +=
 profile)
+        if mode !=3D 'mode=3Dplay':
+            self.error('Unknown mode in wfd-client-rtp-ports: ' + mode)
+        self.remote_rtp_port =3D rtp_p0
+        self.use_tcp =3D (profile =3D=3D 'RTP/AVP/TCP;unicast')
+
+    def parse_transport(self, value):
+        params =3D value.split(';')
+        if len(params) < 3:
+            self.error('Can\'t split SETUP Transport header into profile a=
nd port numbers: ' + value)
+        profile =3D ';'.join(params[0:2])
+        if profile not in ['RTP/AVP/UDP;unicast', 'RTP/AVP/TCP;unicast']:
+            self.error('Unknown RTP transport in SETUP Transport header: '=
 + profile)
+        if self.use_tcp !=3D (profile =3D=3D 'RTP/AVP/TCP;unicast'):
+            self.error('RTP transport in SETUP Transport header different =
from what we sent in M4: ' + profile)
+        client_port_strs =3D [p for p in params[2:] if p.startswith('clien=
t_port=3D')]
+        if len(client_port_strs) !=3D 1:
+            self.error('Can\'t find client-port in SETUP Transport header:=
 ' + value)
+        client_ports =3D client_port_strs[0].split('=3D', 1)[1].split('-')
+        try:
+            rtp_port =3D int(client_ports[0])
+            if len(client_ports) > 1:
+                rtcp_port =3D int(client_ports[1])
+        except:
+            self.error('Can\'t parse client-port in SETUP Transport header=
: ' + client_port_strs[0])
+        if rtp_port !=3D self.remote_rtp_port:
+            self.error('client-port in SETUP Transport header doesn\'t mat=
ch what we sent in M4: ' + str(rtp_port))
+        if len(client_ports) > 1:
+            if rtcp_port < 1 or rtcp_port > 65535 or rtcp_port =3D=3D rtp_=
port: # Actually must be rtp_port + 1...
+                self.error('Optional RTCP port not valid in SETUP Transpor=
t header: ' + str(rtcp_port))
+            self.remote_rtcp_port =3D rtcp_port
+
+    def on_gst_message(self, bus, message):
+        t =3D message.type
+        if t =3D=3D Gst.MessageType.EOS:
+            self.error('Gstreamer end-of-stream')
+        elif t =3D=3D Gst.MessageType.STATE_CHANGED:
+            old, new, pending =3D message.parse_state_changed()
+            self.debug('Gstreamer state change for ' + message.src.name + =
' from ' + str(old) + ' to ' + str(new) + ', pending=3D' + str(pending))
+        elif t =3D=3D Gst.MessageType.INFO:
+            err, debug =3D message.parse_info()
+            self.debug('Gstreamer info for ' + message.src.name + ': ' + s=
tr(err) + '\nDebug: ' + str(debug))
+        elif t =3D=3D Gst.MessageType.WARNING:
+            err, debug =3D message.parse_warning()
+            self.debug('Gstreamer warning for ' + message.src.name + ': ' =
+ str(err) + '\nDebug: ' + str(debug))
+        elif t =3D=3D Gst.MessageType.ERROR:
+            err, debug =3D message.parse_error()
+            self.error('Gstreamer error for ' + message.src.name + ': ' + =
str(err) + '\nDebug: ' + str(debug))
+        else:
+            self.debug('Gstreamer message of type ' + str(t) + ' for ' + m=
essage.src.name + ': ' + str(message))
+        return True
+
+    def gst_force_keyframe(self):
+        enc =3D self.rtp_pipeline.get_by_name('videnc')
+        sink =3D enc.get_static_pad('sink')
+        timestamp =3D Gst.CLOCK_TIME_NONE # can/should we use sink.query_p=
osition?
+
+        s =3D Gst.Structure('GstForceKeyUnit')
+        s.set_value('timestamp', timestamp, 'uint64')
+        s.set_value('stream-time', timestamp, 'uint64')
+        s.set_value('all-headers', True)
+        # TODO: can we also send this event directly to the element instea=
d of the pad?
+        sink.send_event(Gst.event_new_custom(Gst.EVENT_CUSTOM_DOWNSTREAM, =
s))
+
+    def rtsp_keepalive_timeout_cb(self):
+        try:
+            self.rtsp_keepalive_timeout =3D None
+            self.error('Keep-alive response timed out')
+        except Exception as e:
+            self.error_handler(e)
+            return False
+
+    def rtsp_keepalive_cb(self):
+        try:
+            # Send M16
+            # May need to start being careful with other requests that may=
 be running...
+            self.request('GET_PARAMETER', 'rtsp://localhost/wfd1.0')
+            self.rtsp_keepalive_timeout =3D GLib.timeout_add_seconds(5, se=
lf.rtsp_keepalive_timeout_cb)
+            return True
+        except Exception as e:
+            self.error_handler(e)
+            return False
+
+    def source_handle_message(self, method=3DNone, target=3DNone, status=
=3DNone, reason=3DNone, headers=3D{}, content=3DNone):
+        # TODO: check the 6s timeouts as per Section 6.5
+        # Source side M1-M8 simplified state machine
+        if self._state =3D=3D 'init':
+            # Send M1
+            self.request('OPTIONS', '*', require=3D['org.wfa.wfd1.0'])
+            self.enter_state('M1')
+        elif self._state =3D=3D 'M1':
+            # Validate M1 response
+            self.validate_msg(method, None, status, reason, headers, None,=
 content)
+            methods =3D [ m.strip() for m in headers['public'].split(',') ]
+            required =3D [ 'org.wfa.wfd1.0', 'SET_PARAMETER', 'GET_PARAMET=
ER' ]
+            missing =3D [ m for m in required if m not in methods ]
+            if missing:
+                self.error('Missing required method(s) "' + '", "'.join(mi=
ssing) + '" in OPTIONS response')
+            self.enter_state('M2')
+        elif self._state =3D=3D 'M2':
+            # Validate M2
+            self.validate_msg(method, 'OPTIONS', status, reason, headers, =
target, content)
+            if target not in [ '*' ] + self.presentation_url:
+                self.error('Unknown OPTIONS target "' + target + '"')
+            required =3D [ m.strip() for m in headers['require'].split(','=
) ]
+            missing =3D [ m for m in required if m not in self.local_metho=
ds ]
+            if missing:
+                self.error('Required methods in OPTIONS request that we do=
n\'t support: ' + ','.join(missing))
+
+            # Send M2 response
+            self.response(public=3Dself.local_methods)
+            # Send M3
+            self.request('GET_PARAMETER', 'rtsp://localhost/wfd1.0', param=
s=3D['wfd_audio_codecs', 'wfd_video_formats', 'wfd_client_rtp_ports', 'wfd_=
display_edid', 'wfd_uibc_capability'])
+            self.enter_state('M3')
+        elif self._state =3D=3D 'M3':
+            # Validate M3 response
+            self.validate_msg(method, None, status, reason, headers, None,=
 content)
+            if 'wfd_video_formats' not in self.remote_params or 'wfd_clien=
t_rtp_ports' not in self.remote_params:
+                self.error('Required parameters missing from GET_PARAMETER=
 response')
+            self.parse_video_formats(self.remote_params['wfd_video_formats=
'])
+            self.parse_client_rtp_ports(self.remote_params['wfd_client_rtp=
_ports'])
+            # Send M4
+            params =3D {
+                'wfd_video_formats': self.local_params['wfd_video_formats'=
],
+                'wfd_client_rtp_ports': self.remote_params['wfd_client_rtp=
_ports'],
+                'wfd_presentation_URL': self.presentation_url[0] + ' ' + s=
elf.presentation_url[1],
+                # TODO: include wfd_audio_codecs if audio present, make vi=
deo optional, too
+                # TODO: support wfd2_video_formats and wfd2_audio_codecs
+            }
+            self.request('SET_PARAMETER', 'rtsp://localhost/wfd1.0', param=
s=3Dparams)
+            self.enter_state('M4')
+        elif self._state =3D=3D 'M4':
+            # Validate M4 response
+            self.validate_msg(method, None, status, reason, headers, None,=
 content)
+            # Send M5
+            self.request('SET_PARAMETER', 'rtsp://localhost/wfd1.0', param=
s=3D{'wfd_trigger_method': 'SETUP'})
+            self.enter_state('M5')
+        elif self._state =3D=3D 'M5':
+            # Validate M5 response
+            self.validate_msg(method, None, status, reason, headers, None,=
 content)
+            self.enter_state('M6')
+        elif self._state =3D=3D 'M6':
+            # Validate M6
+            self.validate_msg(method, 'SETUP', status, reason, headers, ta=
rget, content)
+            self.parse_transport(headers['transport'])
+            self.session_stream_url =3D target
+            self.session_id =3D str(random.randint(a=3D1, b=3D999999))
+            self.local_rtp_port =3D random.randint(a=3D20000, b=3D30000)
+            if self.remote_rtcp_port is not None:
+                self.local_rtcp_port =3D self.local_rtp_port + 1
+            profile =3D'RTP/AVP/TCP;unicast' if self.use_tcp else 'RTP/AVP=
/UDP;unicast'
+            client_port =3D str(self.remote_rtp_port) + (('-' + str(self.r=
emote_rtcp_port)) if self.remote_rtcp_port is not None else '')
+            server_port =3D str(self.local_rtp_port) + (('-' + str(self.lo=
cal_rtcp_port)) if self.local_rtcp_port is not None else '')
+            transport =3D profile + ';client_port' + client_port + ';serve=
r_port=3D' + server_port
+            # Section B.1
+            pipeline =3D ('ximagesrc name=3Dsrc use-damage=3Dfalse do-time=
stamp=3Dtrue ! capsfilter name=3Dfps caps=3Dvideo/x-raw,framerate=3D10/1' +
+                ' ! videoscale method=3D0 ! capsfilter name=3Dres caps=3Dv=
ideo/x-raw,width=3D800,height=3D600' +
+                ' ! videoconvert ! video/x-raw,format=3DI420 ! x264enc tun=
e=3Dzerolatency speed-preset=3Dultrafast name=3Dvidenc' +
+                ' ! queue' + # TODO: add leaky=3Ddownstream
+                ' ! mpegtsmux name=3Dmux' +
+                ' ! rtpmp2tpay pt=3D33 mtu=3D1472 ! .send_rtp_sink rtpsess=
ion name=3Dsession .send_rtp_src' +
+                ' ! udpsink host=3D' + self.remote_ip + ' port=3D' + str(s=
elf.remote_rtp_port) + ' bind-port=3D' + str(self.local_rtp_port)) # TODO: =
bind-address
+
+            if self.local_rtcp_port is not None:
+                pipeline +=3D ' session.send_rtcp_src ! udpsink name=3Drtc=
p_sink host=3D' + self.remote_ip + \
+                    ' port=3D' + str(self.remote_rtcp_port) + ' bind-port=
=3D' + str(self.local_rtcp_port) # TODO: bind-address
+
+            self.rtp_pipeline =3D Gst.parse_launch(pipeline)
+            bus =3D self.rtp_pipeline.get_bus()
+            bus.enable_sync_message_emission()
+            bus.add_signal_watch()
+            bus.connect('sync-message', self.on_gst_message)
+
+            # Send M6 response
+            self.response(session=3Dself.session_id + ';timeout=3D' + str(=
self.session_timeout), transport=3Dtransport)
+            self.enter_state('M7')
+        elif self._state in ['M7', 'paused']:
+            # Validate M7
+            self.validate_msg(method, 'PLAY', status, reason, headers, tar=
get, content)
+            # Send M7 response
+            self.response()
+            self.rtp_pipeline.set_state(Gst.State.PLAYING)
+            # Set up the keep-alive timer, interval must be less than time=
out minus 5 seconds
+            self.rtsp_keepalive =3D GLib.timeout_add_seconds(self.session_=
timeout - 10, self.rtsp_keepalive_cb)
+            self.enter_state('streaming')
+        elif self._state =3D=3D 'streaming':
+            if method is None:
+                if self.rtsp_keepalive_timeout:
+                    # The M16 response is not to be validated (Section 6.4=
.16)
+                    GLib.source_remove(self.rtsp_keepalive_timeout)
+                    self.rtsp_keepalive_timeout =3D None
+                    return
+                self.error('Received an RTSP response where a request was =
expected')
+            if method =3D=3D 'PAUSE':
+                self.validate_msg(method, 'PAUSE', status, reason, headers=
, target, content)
+                self.rtp_pipeline.set_state(Gst.State.PAUSED)
+                self.enter_state('paused')
+                self.response()
+                return
+            if method =3D=3D 'SET_PARAMETER':
+                # TODO: parse the stuff, on 'wfd-idr-request\r\n' (no semi=
colon) call the following:
+                self.gst_force_keyframe()
+                self.response()
+                return
+            if method =3D=3D 'TEARDOWN':
+                # The spec suggests a more graceful teardown but we just c=
lose the connection
+                self.error('Teardown requested')
+            self.error('Unsupported method "' + method + '"')
+
+WIPHY_IF =3D 'net.connman.iwd.Adapter'
+DEVICE_IF =3D 'net.connman.iwd.p2p.Device'
+PEER_IF =3D 'net.connman.iwd.p2p.Peer'
+WSC_IF =3D 'net.connman.iwd.SimpleConfiguration'
+WFD_IF =3D 'net.connman.iwd.p2p.Display'
+SVC_MGR_IF =3D 'net.connman.iwd.p2p.ServiceManager'
+
+class WFDSource(Gtk.Window):
+    @dataclasses.dataclass
+    class Device:
+        props: dict
+        dev_proxy: dbus.Interface
+        props_proxy: dbus.Interface
+        peers: dict
+        sorted_peers: list
+        widget: Gtk.Widget
+        expanded: bool
+        scan_request: bool
+        selected_peer: object
+        connecting_peer: object
+        disconnecting_peer: object
+        connected: list
+        dbus_call: dbus.lowlevel.PendingCall
+
+    @dataclasses.dataclass
+    class Peer:
+        peer_proxy: dbus.Interface
+        wfd_proxy: dbus.Interface
+        wsc_proxy: dbus.Interface
+        widget: Gtk.Widget
+        rtsp: WFDRTSPServer
+
+    def __init__(self):
+        Gtk.Window.__init__(self, type=3DGtk.WindowType.TOPLEVEL, title=3D=
'WFD Source')
+        self.set_decorated(True)
+        self.set_resizable(False)
+        self.connect('destroy', self.on_destroy, "WM destroy")
+        self.set_size_request(900, 300)
+        self.device_box =3D Gtk.Box(orientation=3DGtk.Orientation.VERTICAL)
+        leftscroll =3D Gtk.ScrolledWindow(hscrollbar_policy=3DGtk.PolicyTy=
pe.NEVER)
+        leftscroll.add(self.device_box)
+        self.infolabel1 =3D Gtk.Label()
+        self.infolabel1.set_ellipsize(Pango.EllipsizeMode.START)
+        infopane =3D Gtk.Box(orientation=3DGtk.Orientation.HORIZONTAL)
+        infopane.pack_start(self.infolabel1, False, False, padding=3D10)
+        rightscroll =3D Gtk.ScrolledWindow(hscrollbar_policy=3DGtk.PolicyT=
ype.NEVER, vscrollbar_policy=3DGtk.PolicyType.NEVER)
+        rightscroll.add(infopane)
+        paned =3D Gtk.Paned(orientation=3DGtk.Orientation.HORIZONTAL)
+        paned.pack1(leftscroll, True, True)
+        paned.pack2(rightscroll, False, False)
+        paned.set_wide_handle(True)
+        paned.props.position =3D 400
+        paned.props.position_set =3D True
+        self.add(paned)
+        self.show_all()
+        self.connect('notify::is-active', self.on_notify_is_active)
+
+        self.rtsp_port =3D 7236
+        self.devices =3D None
+        self.objects =3D {}
+        self.dbus =3D dbus.SystemBus()
+        self.dbus.watch_name_owner('net.connman.iwd', self.on_name_owner_c=
hange)
+        self.on_name_owner_change('dummy' if self.dbus.name_has_owner('net=
.connman.iwd') else '')
+
+    def on_name_owner_change(self, new_name):
+        if not new_name:
+            if self.devices is None:
+                return True
+
+            for dev_path in self.devices:
+                device =3D self.devices[dev_path]
+                if device.connecting_peer or device.disconnecting_peer:
+                    device.dbus_call.cancel()
+
+                for peer_path in device.peers:
+                    peer =3D device.peers[peer_path]
+                    if peer.rtsp:
+                        peer.rtsp.close()
+
+            self.devices =3D None
+            self.objects =3D {}
+            self.populate_devices()
+            self.dbus.remove_signal_receiver(self.on_properties_changed)
+            self.dbus.remove_signal_receiver(self.on_interfaces_added)
+            self.dbus.remove_signal_receiver(self.on_interfaces_removed)
+            return True
+
+        if self.devices is not None:
+            return True
+
+        manager =3D dbus.Interface(self.dbus.get_object('net.connman.iwd',=
 '/'), 'org.freedesktop.DBus.ObjectManager')
+        self.devices =3D {}
+        self.objects =3D manager.GetManagedObjects()
+
+        for path in self.objects:
+            if DEVICE_IF in self.objects[path]:
+                self.add_dev(path)
+        for path in self.objects:
+            if PEER_IF in self.objects[path]:
+                self.add_peer(path)
+
+        self.populate_devices()
+
+        self.dbus.add_signal_receiver(self.on_properties_changed,
+            bus_name=3D"net.connman.iwd",
+            dbus_interface=3D"org.freedesktop.DBus.Properties",
+            signal_name=3D"PropertiesChanged",
+            path_keyword=3D"path")
+        self.dbus.add_signal_receiver(self.on_interfaces_added,
+            bus_name=3D"net.connman.iwd",
+            dbus_interface=3D"org.freedesktop.DBus.ObjectManager",
+            signal_name=3D"InterfacesAdded")
+        self.dbus.add_signal_receiver(self.on_interfaces_removed,
+            bus_name=3D"net.connman.iwd",
+            dbus_interface=3D"org.freedesktop.DBus.ObjectManager",
+            signal_name=3D"InterfacesRemoved")
+
+        svc_mgr =3D dbus.Interface(self.dbus.get_object('net.connman.iwd',=
 '/net/connman/iwd'), SVC_MGR_IF)
+        svc_mgr.RegisterDisplayService({
+            'Source': True,
+            'Port': dbus.UInt16(self.rtsp_port)
+        })
+
+        return True
+
+    def add_dev(self, path):
+        obj_proxy =3D self.dbus.get_object('net.connman.iwd', path)
+        # Default to expanded for first device found
+        expanded =3D len(self.devices) =3D=3D 0
+        self.devices[path] =3D WFDSource.Device(
+            props=3Dself.objects[path][DEVICE_IF],
+            dev_proxy=3Ddbus.Interface(obj_proxy, DEVICE_IF),
+            props_proxy=3Ddbus.Interface(obj_proxy, 'org.freedesktop.DBus.=
Properties'),
+            peers=3D{},
+            sorted_peers=3D[],
+            widget=3DNone,
+            expanded=3Dexpanded,
+            scan_request=3DFalse,
+            selected_peer=3DNone,
+            connecting_peer=3DNone,
+            disconnecting_peer=3DNone,
+            connected=3D[],
+            dbus_call=3DNone)
+
+    def add_peer(self, path):
+        dev_path =3D self.objects[path][PEER_IF]['Device']
+        if dev_path not in self.devices or path in self.devices[dev_path].=
peers:
+            return False
+
+        self.devices[dev_path].peers[path] =3D WFDSource.Peer(
+            peer_proxy=3DNone,
+            wfd_proxy=3DNone,
+            wsc_proxy=3DNone,
+            widget=3DNone,
+            rtsp=3DNone)
+        return True
+
+    def on_properties_changed(self, interface, changed, invalidated, path):
+        if path not in self.objects:
+            self.objects[path] =3D {}
+        if interface not in self.objects[path]:
+            self.objects[path][interface] =3D {}
+
+        self.objects[path][interface].update(changed)
+        for prop in invalidated:
+            if prop in self.objects[path][interface]:
+                del self.objects[path][interface][prop]
+
+        if path in self.devices:
+            self.update_dev_props(path)
+            if interface =3D=3D DEVICE_IF and 'AvailableConnections' in ch=
anged:
+                self.update_selected_peer(path)
+
+        if PEER_IF in self.objects[path]:
+            dev_path =3D self.objects[path][PEER_IF]['Device']
+            if dev_path in self.devices:
+                device =3D self.devices[dev_path]
+                if path in device.peers:
+                    peer =3D device.peers[path]
+                    if interface =3D=3D PEER_IF and 'Connected' in changed:
+                        if changed['Connected'] and peer not in device.con=
nected:
+                            device.connected.append(peer)
+                        elif not changed['Connected'] and peer in device.c=
onnected:
+                            device.connected.remove(peer)
+                        self.update_dev_props(dev_path)
+                        self.update_peer_props(dev_path, path)
+                        if peer !=3D device.selected_peer:
+                            self.update_selected_peer(dev_path)
+                    if interface =3D=3D PEER_IF and peer.rtsp:
+                        if 'ConnectedInterface' in changed:
+                            peer.rtsp.set_local_interface(changed['Connect=
edInterface'])
+                        if 'ConnectedIp' in changed:
+                            peer.rtsp.set_remote_ip(changed['ConnectedIp'])
+
+                self.update_peer_props(dev_path, path)
+
+        return True
+
+    def on_interfaces_added(self, path, interfaces):
+        if path not in self.objects:
+            self.objects[path] =3D {}
+        self.objects[path].update(interfaces)
+
+        if DEVICE_IF in interfaces:
+            self.add_dev(path)
+            # This should happen rarely enough that we can repopulate the =
whole list
+            self.populate_devices()
+
+        update_dev_props =3D False
+        if PEER_IF in interfaces:
+            update_dev_props =3D self.add_peer(path)
+
+        if PEER_IF in self.objects[path]:
+            dev_path =3D self.objects[path][PEER_IF]['Device']
+            if dev_path in self.devices:
+                if update_dev_props:
+                    # Update device's peer count
+                    self.update_dev_props(dev_path)
+                self.update_peer_props(dev_path, path)
+
+    def on_interfaces_removed(self, path, interfaces):
+        if path not in self.objects:
+            return
+
+        dev_path =3D None
+        if PEER_IF in interfaces or WFD_IF in interfaces or WSC_IF in inte=
rfaces:
+            if PEER_IF in self.objects[path]:
+                dev_path =3D self.objects[path][PEER_IF]['Device']
+
+        for i in interfaces:
+            if i in self.objects[path]:
+                del self.objects[path][i]
+        if len(self.objects[path]) =3D=3D 0:
+            del self.objects[path]
+
+        if DEVICE_IF in interfaces and path in self.devices:
+            device =3D self.devices[path]
+            if device.connecting_peer or device.disconnecting_peer:
+                device.dbus_call.cancel()
+            # TODO: check if connected
+            del self.devices[path]
+            # This should happen rarely enough that we can repopulate the =
whole list
+            self.populate_devices()
+
+        if dev_path is not None and dev_path in self.devices:
+            device =3D self.devices[dev_path]
+            if path in device.peers:
+                # Make sure the widget is removed
+                self.update_peer_props(dev_path, path)
+                if PEER_IF in interfaces:
+                    del device.peers[path]
+                    # Update device's peer count
+                    self.update_dev_props(dev_path)
+
+    def populate_devices(self):
+        self.device_box.foreach(lambda x, y: self.device_box.remove(x), No=
ne)
+
+        if self.devices is None:
+            label =3D Gtk.Label(label=3D"Not connected to IWD")
+            self.device_box.pack_start(label, expand=3DTrue, fill=3DTrue, =
padding=3D0)
+            self.device_box.show_all()
+            return
+
+        if len(self.devices) =3D=3D 0:
+            label =3D Gtk.Label(label=3D"No P2P-capable adapters :-(")
+            self.device_box.pack_start(label, expand=3DTrue, fill=3DTrue, =
padding=3D0)
+            self.device_box.show_all()
+            return
+
+        for path in self.devices:
+            label =3D Gtk.Label()
+            label.set_halign(Gtk.Align.START)
+            label.set_line_wrap(False)
+            label.set_single_line_mode(False)
+            label.set_ellipsize(Pango.EllipsizeMode.END)
+            switch =3D Gtk.Switch()
+            switch.connect('state-set', self.on_dev_enabled, path)
+            switch.set_halign(Gtk.Align.END)
+            switch.set_valign(Gtk.Align.START)
+            box =3D Gtk.Box(orientation=3DGtk.Orientation.HORIZONTAL)
+            box.pack_start(label, expand=3DTrue, fill=3DTrue, padding=3D0)
+            box.pack_end(switch, expand=3DFalse, fill=3DFalse, padding=3D0)
+            peer_list =3D Gtk.ListBox() # can also use an IconView.. or ma=
ke it switchable
+            peer_list.set_size_request(150, 120)
+            peer_list.set_selection_mode(Gtk.SelectionMode.SINGLE)
+            peer_list.set_placeholder(Gtk.Label(label=3D'No Wi-Fi Displays=
 discovered yet...'))
+            peer_list.connect('row-selected', self.on_peer_selected, path)
+            frame =3D Gtk.Frame()
+            frame.props.margin =3D 10
+            frame.add(peer_list)
+            expander =3D Gtk.Expander()
+            expander.set_label_fill(True)
+            expander.set_expanded(self.devices[path].expanded)
+            expander.set_label_widget(box)
+            expander.add(frame)
+            expander.connect('notify::expanded', self.on_dev_expanded, pat=
h)
+            expander.show_all()
+            self.device_box.add(expander)
+            self.devices[path].widget =3D expander
+            self.update_dev_props(path)
+            GLib.idle_add(self.expander_workaround, expander)
+
+            for peer_path in self.devices[path].peers:
+                self.update_peer_props(path, peer_path)
+
+            # Basically implement Gtk.Expander's set_label_fill which for =
some reason
+            # doesn't do anything.  Use size-allocate because configure-ev=
ent doesn't work either...
+            self.margin_left =3D None
+            def on_exp_resize(widget, event):
+                if self.margin_left is None:
+                    self.margin_left =3D box.get_allocation().x
+                posx, posy =3D expander.translate_coordinates(self, 0, 0)
+                # Add posx to force the label widget (box) to be aligned t=
o the left side of the
+                # window even if GTK already decided to push the expander =
off the left side with a
+                # negative allocation.x.  This way it won't push it any fu=
rther left as the available
+                # space shrinks.
+                box.set_size_request(max(posx + expander.get_allocated_wid=
th() - self.margin_left - 1, 0), -1)
+                return False
+            expander.connect('size-allocate', on_exp_resize)
+
+    def expander_workaround(self, widget):
+        box =3D widget.get_label_widget()
+        widget.set_label_widget(None)
+        widget.set_label_widget(box)
+        return False
+
+    def update_dev_props(self, path):
+        device =3D self.devices[path]
+        if not device.props['Enabled']:
+            state =3D 'disabled'
+        elif device.disconnecting_peer is not None:
+            state =3D 'disconnecting...'
+        elif device.connecting_peer is not None:
+            state =3D 'connecting...'
+        elif len(device.connected) > 0:
+            if all([not peer.rtsp or peer.rtsp.ready for peer in device.co=
nnected]):
+                state =3D 'connected'
+            else:
+                state =3D 'negotiating...'
+        elif device.scan_request:
+            state =3D 'discovering... (' + str(len(device.peers)) + ')'
+        else:
+            state =3D 'idle'
+
+        label, switch =3D device.widget.get_label_widget().get_children()
+        dev_str =3D self.get_dev_string(path)
+        name =3D str(device.props['Name'])
+        label.set_markup(dev_str + '\n<small>' + ('Local name: ' + name + =
'\n' if dev_str !=3D name else '') + 'State: ' + state + '</small>')
+        switch.set_active(device.props['Enabled'])
+
+    def update_peer_props(self, dev_path, path):
+        device =3D self.devices[dev_path]
+        peer =3D device.peers[path]
+        props =3D self.objects[path] if path in self.objects else {}
+        peer_list =3D device.widget.get_child().get_child()
+        if peer.widget is None:
+            if PEER_IF not in props or WFD_IF not in props or WSC_IF not i=
n props:
+                return
+            if not props[WFD_IF]['Sink']:
+                return
+
+            name =3D str(props[PEER_IF]['Name'])
+            device.sorted_peers.append(name)
+            device.sorted_peers.sort()
+            index =3D device.sorted_peers.index(name)
+
+            obj_proxy =3D self.dbus.get_object('net.connman.iwd', path)
+            peer.peer_proxy=3Ddbus.Interface(obj_proxy, PEER_IF)
+            peer.wfd_proxy=3Ddbus.Interface(obj_proxy, WFD_IF)
+            peer.wsc_proxy=3Ddbus.Interface(obj_proxy, WSC_IF)
+            label =3D Gtk.Label()
+            label.set_halign(Gtk.Align.START)
+            label.set_single_line_mode(True)
+            label.set_ellipsize(Pango.EllipsizeMode.END)
+            event_box =3D Gtk.EventBox()
+            event_box.add(label)
+            event_box.connect('button-press-event', self.on_peer_click, (d=
ev_path, path))
+            button =3D Gtk.Button()
+            button.set_use_stock(True)
+            button.connect('clicked', self.on_peer_button, (dev_path, path=
))
+            box =3D Gtk.Box(orientation=3DGtk.Orientation.HORIZONTAL)
+            box.props.margin =3D 5;
+            box.pack_start(event_box, expand=3DTrue, fill=3DTrue, padding=
=3D0)
+            box.pack_end(button, expand=3DFalse, fill=3DFalse, padding=3D0)
+            peer.widget =3D Gtk.ListBoxRow()
+            peer.widget.add(box)
+            peer_list.insert(peer.widget, index)
+            peer.widget.show_all()
+        elif (PEER_IF not in props or WFD_IF not in props or WSC_IF not in=
 props or not props[WFD_IF]['Sink']) and peer.widget:
+            del device.sorted_peers[peer.widget.get_index()]
+            peer_list.remove(peer.widget)
+            if peer =3D=3D device.selected_peer:
+                device.selected_peer =3D None
+                self.update_info(dev_path, None)
+            if peer =3D=3D device.connecting_peer:
+                device.dbus_call.cancel()
+                device.connecting_peer =3D None
+                self.update_selected_peer(dev_path)
+            if peer =3D=3D device.disconnecting_peer:
+                device.dbus_call.cancel()
+                device.disconnecting_peer =3D None
+                self.update_selected_peer(dev_path)
+            if peer in device.connected:
+                device.connected.remove(peer)
+                self.update_selected_peer(dev_path)
+            peer.peer_proxy =3D None
+            peer.wfd_proxy =3D None
+            peer.wsc_proxy =3D None
+            peer.widget =3D None
+            if peer.rtsp:
+                peer.rtsp.close()
+                peer.rtsp =3D None
+            return
+
+        subcat =3D 'unknown type'
+        if 'DeviceSubcategory' in props[PEER_IF]:
+            subcat =3D props[PEER_IF]['DeviceSubcategory']
+
+        weight =3D 'heavy' if peer in device.connected else 'normal'
+        box =3D peer.widget.get_child()
+        event_box, button =3D box.get_children()
+        label, =3D event_box.get_children()
+        label.set_markup('<span weight=3D"' + weight + '">' + props[PEER_I=
F]['Name'] + '</span> <span foreground=3D"grey" size=3D"small">' + subcat +=
 '</span>')
+
+        if device.disconnecting_peer or (device.connecting_peer and peer !=
=3D device.connecting_peer):
+            # This peer's row should not have any buttons
+            button.hide()
+        elif peer =3D=3D device.connecting_peer:
+            button.set_label('Cancel')
+            button.show()
+        elif peer in device.connected:
+            if not peer.rtsp or peer.rtsp.ready:
+                button.set_label('Disconnect')
+            else:
+                button.set_label('Cancel')
+            button.show()
+        elif peer =3D=3D device.selected_peer and device.props['AvailableC=
onnections'] > 0:
+            button.set_label('Connect')
+            button.show()
+        else:
+            button.hide()
+
+        if peer =3D=3D device.selected_peer:
+            self.update_info(dev_path, path)
+
+    def update_selected_peer(self, dev_path):
+        device =3D self.devices[dev_path]
+        if device.selected_peer:
+            sel_path =3D self.get_peer_path(device, device.selected_peer)
+            self.update_peer_props(dev_path, sel_path)
+
+    def update_info(self, dev_path, path):
+        device =3D self.devices[dev_path]
+        if path is None:
+            self.infolabel1.set_text('')
+            return
+
+        peer =3D device.peers[path]
+
+        if peer =3D=3D device.connecting_peer:
+            state =3D 'IWD connecting'
+        elif peer =3D=3D device.disconnecting_peer:
+            state =3D 'disconnecting'
+        elif peer in device.connected:
+            if peer.rtsp is not None:
+                if peer.rtsp.ready:
+                    state =3D peer.rtsp.state
+                else:
+                    state =3D 'RTSP negotiation: ' + peer.rtsp.state
+            else:
+                state =3D 'connected'
+        else:
+            state =3D 'not connected'
+
+        subcat =3D 'unknown'
+        if 'DeviceSubcategory' in self.objects[path][PEER_IF]:
+            subcat =3D self.objects[path][PEER_IF]['DeviceSubcategory']
+
+        text =3D ('Connection state: ' + state + '\n' +
+                'Device category: ' + self.objects[path][PEER_IF]['DeviceC=
ategory'] + '\n'
+                'Device subcategory: ' + subcat + '\n')
+
+        if WFD_IF in self.objects[path]:
+            if self.objects[path][WFD_IF]['Source']:
+                if self.objects[path][WFD_IF]['Sink']:
+                    t =3D 'dual-role'
+                else:
+                    t =3D 'source'
+            else:
+                t =3D 'sink'
+            text +=3D 'WFD device type: ' + t + '\n'
+
+            if self.objects[path][WFD_IF]['Sink']:
+                text +=3D 'Audio: ' + ('yes' if self.objects[path][WFD_IF]=
['HasAudio'] else 'no') + '\n'
+
+            text +=3D 'UIBC: ' + ('yes' if self.objects[path][WFD_IF]['Has=
UIBC'] else 'no') + '\n'
+
+            text +=3D 'Content protection: ' + ('yes' if self.objects[path=
][WFD_IF]['HasContentProtection'] else 'no') + '\n'
+
+        self.infolabel1.set_text(text)
+        # TODO: more info in labels 2 and so on
+
+    # Direct method calls on dbus.Interface's don't return dbus.lowlevel.P=
endingCall objects so
+    # we have to use bus.call_async to make cancellable async calls
+    def async_call(self, proxy, method, signature=3D'', *args, **kwargs):
+        return self.dbus.call_async(proxy.bus_name, proxy.object_path, pro=
xy.dbus_interface, method, signature, args, **kwargs)
+
+    def connect_peer(self, dev_path, path):
+        device =3D self.devices[dev_path]
+        peer =3D device.peers[path]
+
+        def on_reply():
+            device.connected.append(peer)
+            device.connecting_peer =3D None
+            # Local interface and remote IP get set in the PropertiesChang=
ed handler
+            self.update_dev_props(dev_path)
+            self.update_peer_props(dev_path, path)
+            if peer !=3D device.selected_peer:
+                self.update_selected_peer(dev_path)
+
+        def on_error(excp):
+            device.connecting_peer =3D None
+            if peer.rtsp:
+                peer.rtsp.close()
+                peer.rtsp =3D None
+            self.update_dev_props(dev_path)
+            self.update_peer_props(dev_path, path)
+            if peer !=3D device.selected_peer:
+                self.update_selected_peer(dev_path)
+            dialog =3D Gtk.MessageDialog(parent=3Dself, message_type=3DGtk=
.MessageType.ERROR, buttons=3DGtk.ButtonsType.OK, text=3D'Connection failed=
')
+            dialog.format_secondary_text('Connection to ' + self.objects[p=
ath][PEER_IF]['Name'] + ' failed: ' + repr(excp))
+            dialog.show()
+
+            def on_ok(response, *args):
+                dialog.destroy()
+
+            dialog.connect('response', on_ok)
+
+        def on_rtsp_state():
+            self.update_dev_props(dev_path)
+            self.update_peer_props(dev_path, path)
+            if peer !=3D device.selected_peer:
+                self.update_selected_peer(dev_path)
+
+        def on_rtsp_error(excp):
+            self.disconnect_peer(dev_path, path)
+            dialog =3D Gtk.MessageDialog(parent=3Dself, message_type=3DGtk=
.MessageType.ERROR, buttons=3DGtk.ButtonsType.OK, text=3D'Negotiation faile=
d')
+            dialog.format_secondary_text('RTSP error when talking to ' + s=
elf.objects[path][PEER_IF]['Name'] + ': ' + repr(excp))
+            dialog.show()
+
+            def on_ok(response, *args):
+                dialog.destroy()
+
+            dialog.connect('response', on_ok)
+
+        # Cannot use peer.wsc_proxy.PushButton()
+        device.dbus_call =3D self.async_call(peer.wsc_proxy, 'PushButton',=
 reply_handler=3Don_reply, error_handler=3Don_error, timeout=3D120)
+        device.connecting_peer =3D peer
+        # Create the RTSP server now so it's ready as soon as the P2P conn=
ection succeeds even if
+        # we haven't received the DBus reply yet
+        peer.rtsp =3D WFDRTSPServer(self.rtsp_port, on_rtsp_state, on_rtsp=
_error)
+        self.update_dev_props(dev_path)
+        self.update_peer_props(dev_path, path)
+        if peer !=3D device.selected_peer:
+            self.update_selected_peer(dev_path)
+
+    def disconnect_peer(self, dev_path, path):
+        device =3D self.devices[dev_path]
+        peer =3D device.peers[path]
+
+        def on_reply():
+            device.disconnecting_peer =3D None
+            self.update_dev_props(dev_path)
+            self.update_peer_props(dev_path, path)
+            if peer !=3D device.selected_peer:
+                self.update_selected_peer(dev_path)
+
+        def on_error(excp):
+            device.disconnecting_peer =3D None
+            self.update_dev_props(dev_path)
+            self.update_peer_props(dev_path, path)
+            if peer !=3D device.selected_peer:
+                self.update_selected_peer(dev_path)
+
+            if isinstance(excp, dbus.exceptions.DBusException) and excp.ge=
t_dbus_name() =3D=3D 'net.connman.iwd.NotConnected':
+                return
+
+            dialog =3D Gtk.MessageDialog(parent=3Dself, message_type=3DGtk=
.MessageType.ERROR, buttons=3DGtk.ButtonsType.OK, text=3D'Disconnecting fai=
led')
+            dialog.format_secondary_text('Disconnecting from ' + self.obje=
cts[path][PEER_IF]['Name'] + ' failed: ' + repr(excp))
+            dialog.show()
+
+            def on_ok(response, *args):
+                dialog.destroy()
+
+            dialog.connect('response', on_ok)
+
+        if peer =3D=3D device.connecting_peer:
+            device.dbus_call.cancel()
+            device.connecting_peer =3D None
+
+        if peer in device.connected:
+            device.connected.remove(peer)
+
+        if peer.rtsp:
+            peer.rtsp.close()
+            peer.rtsp =3D None
+
+        device.dbus_call =3D self.async_call(peer.peer_proxy, 'Disconnect'=
, reply_handler=3Don_reply, error_handler=3Don_error)
+        device.disconnecting_peer =3D peer
+        self.update_dev_props(dev_path)
+        self.update_peer_props(dev_path, path)
+        if peer !=3D device.selected_peer:
+            self.update_selected_peer(dev_path)
+
+    def on_peer_click(self, widget, event, data):
+        if event.button !=3D 1 or event.type !=3D Gdk.EventType._2BUTTON_P=
RESS:
+            return False
+        dev_path, path =3D data
+        device =3D self.devices[dev_path]
+        if device.disconnecting_peer:
+            return True
+        if device.connecting_peer or not device.props['AvailableConnection=
s']:
+            # Should we auto-disconnect from the connected peer? Show an "=
Are you sure?" dialog?
+            return True
+        self.connect_peer(dev_path, path)
+        return True
+
+    def on_peer_button(self, widget, data):
+        dev_path, path =3D data
+        action =3D widget.get_label()
+        device =3D self.devices[dev_path]
+        if device.disconnecting_peer:
+            return True
+        if action =3D=3D 'Connect':
+            self.connect_peer(dev_path, path)
+        elif action in ['Disconnect', 'Cancel']:
+            self.disconnect_peer(dev_path, path)
+        return True
+
+    def get_peer_path(self, device, peer):
+        for path in device.peers:
+            if device.peers[path] =3D=3D device.selected_peer:
+                return path
+        return None
+
+    def on_peer_selected(self, widget, row, dev_path):
+        device =3D self.devices[dev_path]
+
+        if device.selected_peer is not None:
+            if device.selected_peer.widget =3D=3D row:
+                return True
+
+            path =3D self.get_peer_path(device, device.selected_peer)
+            device.selected_peer =3D None
+            self.update_peer_props(dev_path, path)
+            self.update_info(dev_path, None)
+
+        if row is None:
+            return True
+
+        for path in device.peers:
+            if device.peers[path].widget =3D=3D row:
+                device.selected_peer =3D device.peers[path]
+                self.update_peer_props(dev_path, path)
+                return True
+
+    def update_dev_scan_request(self, path):
+        device =3D self.devices[path]
+        should_request =3D device.expanded and self.is_active()
+        if device.scan_request =3D=3D should_request:
+            return
+
+        device.scan_request =3D should_request
+        if device.scan_request:
+            device.dev_proxy.RequestDiscovery()
+        else:
+            device.dev_proxy.ReleaseDiscovery()
+        self.update_dev_props(path)
+
+    def on_notify_is_active(self, window, value):
+        if self.devices is None:
+            return True
+
+        for path in self.devices:
+            self.update_dev_scan_request(path)
+        return True
+
+    def on_dev_enabled(self, switch, state, path):
+        device =3D self.devices[path]
+        if device.props['Enabled'] =3D=3D state:
+            return
+        device.props['Enabled'] =3D state
+        device.props_proxy.Set(DEVICE_IF, 'Enabled', state)
+        return True
+
+    def on_dev_expanded(self, expander, value, path):
+        device =3D self.devices[path]
+        device.expanded =3D expander.get_expanded()
+        self.update_dev_scan_request(path)
+        return True
+
+    def get_dev_string(self, path):
+        wiphy =3D self.objects[path][WIPHY_IF]
+        if 'Model' in wiphy:
+            return wiphy['Model']
+        if 'Vendor' in wiphy:
+            return wiphy['Vendor']
+        return wiphy['Name']
+
+    def on_destroy(self, widget, data):
+        global mainloop
+        if self.devices is not None:
+            svc_mgr =3D dbus.Interface(self.dbus.get_object('net.connman.i=
wd', '/net/connman/iwd'), SVC_MGR_IF)
+            svc_mgr.UnregisterDisplayService()
+            self.on_name_owner_change('')
+        mainloop.quit()
+        return False
+
+dbus.mainloop.glib.DBusGMainLoop(set_as_default=3DTrue)
+Gst.init(None)
+WFDSource()
+mainloop =3D GLib.MainLoop()
+mainloop.run()
-- =

2.25.1

--===============0361360201998007872==--

