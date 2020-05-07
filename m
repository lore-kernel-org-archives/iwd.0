Content-Type: multipart/mixed; boundary="===============5232843956897129777=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 3/5] auto-t: Return None instead of empty known net list
Date: Thu, 07 May 2020 12:20:21 -0700
Message-ID: <20200507192023.11498-3-tim.a.kourt@linux.intel.com>
In-Reply-To: <20200507192023.11498-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5232843956897129777==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To match the original behavior of get_ordered_networks,
return None for the empty list of known networks after the scan
is complete
---
 autotests/util/iwd.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index c8d11f91..b9eeb0ff 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -395,7 +395,10 @@ class Device(IWDDBusAbstract):
             ordered_network =3D OrderedNetwork(bus_obj)
             ordered_networks.append(ordered_network)
 =

-        return ordered_networks
+        if len(ordered_networks) > 0:
+            return ordered_networks
+
+        return None
 =

     def get_ordered_network(self, network, scan_if_needed =3D False):
         '''Returns a single network from ordered network call, or None if =
the
-- =

2.13.6

--===============5232843956897129777==--

