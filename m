Content-Type: multipart/mixed; boundary="===============1197455806575173705=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/3] wfd-source: Allow alternative URLs in SETUP request
Date: Fri, 31 Jul 2020 21:09:03 +0200
Message-ID: <20200731190903.73835-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200731190903.73835-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1197455806575173705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some WFD sinks issue an RTSP SETUP request with the target
'rtsp://<source-ip>/wfd1.0/streamid=3D0' so add that URL to the targets we
allow for SETUP.
---
 test/wfd-source | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/test/wfd-source b/test/wfd-source
index 6557b51e..e74d0adf 100755
--- a/test/wfd-source
+++ b/test/wfd-source
@@ -17,6 +17,10 @@ import random
 import dataclasses
 import traceback
 import codecs
+try:
+    import netifaces
+except:
+    pass
 =

 import gi
 gi.require_version('GLib', '2.0')
@@ -216,6 +220,7 @@ class WFDRTSPServer:
         self.remote_params =3D {}
         self.local_methods =3D [ 'org.wfa.wfd1.0', 'SET_PARAMETER', 'GET_P=
ARAMETER', 'PLAY', 'SETUP', 'TEARDOWN' ]
         self.presentation_url =3D [ 'rtsp://127.0.0.1/wfd1.0/streamid=3D0'=
, 'none' ] # Table 88
+        self.alternative_urls =3D [ 'rtsp://localhost/wfd1.0/streamid=3D0'=
 ]
         self.session_stream_url =3D None
         self.session_id =3D None
         self.session_timeout =3D 60
@@ -282,7 +287,11 @@ class WFDRTSPServer:
             self.conn =3D None
 =

     def set_local_interface(self, new_value):
-        pass
+        try:
+            local_ip =3D netifaces.ifaddresses(new_value)[netifaces.AF_INE=
T][0]['addr']
+            self.alternative_urls.append('rtsp://' + local_ip + '/wfd1.0/s=
treamid=3D0')
+        except:
+            pass
 =

     def set_remote_ip(self, new_value):
         self.expected_remote_ip =3D new_value
@@ -345,7 +354,7 @@ class WFDRTSPServer:
             self.error('Missing "Require" header in OPTIONS request')
         elif method =3D=3D 'SETUP' and 'transport' not in headers:
             self.error('Missing "Transport" header in SETUP request')
-        elif method =3D=3D 'SETUP' and (target not in self.presentation_ur=
l or target =3D=3D 'none'):
+        elif method =3D=3D 'SETUP' and (target not in self.presentation_ur=
l + self.alternative_urls or target =3D=3D 'none'):
             self.error('Unknown target "' + target + '" in SETUP request')
         elif method =3D=3D 'PLAY' and ('session' not in headers  or header=
s['session'] !=3D self.session_id):
             self.error('Missing or invalid "Session" header in PLAY reques=
t')
-- =

2.25.1

--===============1197455806575173705==--

