Content-Type: multipart/mixed; boundary="===============1917003892002696395=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 3/6] auto-t: wpas.py: add wait_for_result
Date: Tue, 04 Jan 2022 10:18:54 -0800
Message-ID: <20220104181857.103331-3-prestwoj@gmail.com>
In-Reply-To: 20220104181857.103331-1-prestwoj@gmail.com

--===============1917003892002696395==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some wpa_cli utilities return some result which isn't possible to
get with wait_for_event unless you know what the result will be.
This adds wait_for_result which just returns the first event that
comes in.
---
 autotests/util/wpas.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/autotests/util/wpas.py b/autotests/util/wpas.py
index 5680ec2a..b5b539f4 100644
--- a/autotests/util/wpas.py
+++ b/autotests/util/wpas.py
@@ -70,6 +70,9 @@ class Wpas:
         while True:
             context.iteration(may_block=3DTrue)
 =

+            if not event and len(self._rx_data) >=3D 1:
+                return self._rx_data[0]
+
             for e in self._rx_data:
                 if event in e:
                     GLib.source_remove(timeout)
@@ -78,6 +81,10 @@ class Wpas:
             if self._wait_timed_out:
                 raise TimeoutError('waiting for wpas event timed out')
 =

+    def wait_for_result(self, timeout=3D10):
+        self._rx_data =3D []
+        return self.wait_for_event(None, timeout=3Dtimeout)
+
     def _event_parse(self, line):
         # Unescape event parameter values in '', other escaping rules not =
implemented
         key =3D None
-- =

2.31.1

--===============1917003892002696395==--

