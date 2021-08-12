Content-Type: multipart/mixed; boundary="===============1189420930280154410=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/6] auto-t: iwd.py: scan only on needed frequencies
Date: Thu, 12 Aug 2021 16:12:31 -0700
Message-ID: <20210812231233.747743-4-prestwoj@gmail.com>
In-Reply-To: <20210812231233.747743-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1189420930280154410==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

get_ordered_network() now scans automatically and has been updated
to use the StationDebug.Scan() API rather than doing a full
dbus scan (unless full_scan =3D True). The frequencies to be scanned
are picked automatically based on the current hostapd status
(hidden behind ctx.hostapd.get_frequency()).
---
 autotests/util/iwd.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 7bb4c9f0..cee1b99d 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -414,7 +414,7 @@ class Device(IWDDBusAbstract):
 =

         self._wait_for_async_op()
 =

-    def get_ordered_networks(self, scan_if_needed =3D True):
+    def get_ordered_networks(self, scan_if_needed =3D True, full_scan =3D =
False):
         '''Return the list of networks found in the most recent
            scan, sorted by their user interface importance
            score as calculated by iwd.  If the device is
@@ -440,7 +440,10 @@ class Device(IWDDBusAbstract):
         IWD._wait_for_object_condition(self, condition)
 =

         try:
-            self.scan()
+            if full_scan:
+                self.scan()
+            else:
+                self.debug_scan(ctx.get_frequencies())
         except InProgressEx:
             pass
 =

@@ -458,7 +461,7 @@ class Device(IWDDBusAbstract):
 =

         return None
 =

-    def get_ordered_network(self, network, scan_if_needed =3D True):
+    def get_ordered_network(self, network, scan_if_needed =3D True, full_s=
can =3D False):
         '''Returns a single network from ordered network call, or None if =
the
            network wasn't found. If the network is not found an exception =
is
            raised, this removes the need to extra asserts in autotests.
-- =

2.31.1

--===============1189420930280154410==--

