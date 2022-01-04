Content-Type: multipart/mixed; boundary="===============2085679864214318073=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/6] auto-t: wpas.py: don't require strict match on
 wait_for_event
Date: Tue, 04 Jan 2022 10:18:52 -0800
Message-ID: <20220104181857.103331-1-prestwoj@gmail.com>

--===============2085679864214318073==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

wait_for_event was checking the event string presence in the rx_data
array which meant the event string had to match perfectly to any
received events. This poses problems with events that include additional
information which the caller may not be able to know or does not care
about. For example:

DPP-RX src=3D02:00:00:00:02:00 freq=3D2437 type=3D11

Waiting for this event previously would require the caller know src, freq,
and type. If the caller only wants to wait for DPP-RX, it can now do that.
---
 autotests/util/wpas.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/autotests/util/wpas.py b/autotests/util/wpas.py
index 8fb725f8..5680ec2a 100644
--- a/autotests/util/wpas.py
+++ b/autotests/util/wpas.py
@@ -70,9 +70,10 @@ class Wpas:
         while True:
             context.iteration(may_block=3DTrue)
 =

-            if event in self._rx_data:
-                GLib.source_remove(timeout)
-                return self._rx_data
+            for e in self._rx_data:
+                if event in e:
+                    GLib.source_remove(timeout)
+                    return self._rx_data
 =

             if self._wait_timed_out:
                 raise TimeoutError('waiting for wpas event timed out')
-- =

2.31.1

--===============2085679864214318073==--

