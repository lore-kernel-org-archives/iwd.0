Content-Type: multipart/mixed; boundary="===============6653174271845582223=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 13/15] autotests: Add missing space in wpas P2P_CONNECT
 commands
Date: Fri, 04 Jun 2021 03:50:50 +0200
Message-ID: <20210604015052.163727-13-andrew.zaborowski@intel.com>
In-Reply-To: <20210604015052.163727-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6653174271845582223==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/wpas.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/autotests/util/wpas.py b/autotests/util/wpas.py
index ec19b101..c54becbc 100644
--- a/autotests/util/wpas.py
+++ b/autotests/util/wpas.py
@@ -203,20 +203,20 @@ class Wpas:
     def p2p_connect(self, peer, pin=3DNone, go_intent=3DNone):
         self._rx_data =3D []
         self._ctrl_request('P2P_CONNECT ' + peer['p2p_dev_addr'] + ' ' + (=
'pbc' if pin is None else pin) +
-                        ('' if go_intent is None else 'go_intent=3D' + str=
(go_intent)))
+                        ('' if go_intent is None else ' go_intent=3D' + st=
r(go_intent)))
         self.wait_for_event('OK')
 =

     def p2p_accept_go_neg_request(self, request, pin=3DNone, go_intent=3DN=
one):
         self._rx_data =3D []
         self._ctrl_request('P2P_CONNECT ' + request['p2p_dev_addr'] + ' ' =
+ ('pbc' if pin is None else pin) +
-                        ('' if go_intent is None else 'go_intent=3D' + str=
(go_intent)))
+                        ('' if go_intent is None else ' go_intent=3D' + st=
r(go_intent)))
         self.wait_for_event('OK')
 =

     # Pre-accept the next GO Negotiation Request from this peer to avoid t=
he extra Respone + Request frames
     def p2p_authorize(self, peer, pin=3DNone, go_intent=3DNone):
         self._rx_data =3D []
         self._ctrl_request('P2P_CONNECT ' + peer['p2p_dev_addr'] + ' ' + (=
'pbc' if pin is None else pin) +
-                        ('' if go_intent is None else 'go_intent=3D' + str=
(go_intent)) + ' auth')
+                        ('' if go_intent is None else ' go_intent=3D' + st=
r(go_intent)) + ' auth')
         self.wait_for_event('OK')
 =

     # Probably needed: remove references to self so that the GC can call _=
_del__ automatically
-- =

2.30.2

--===============6653174271845582223==--

