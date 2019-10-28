Content-Type: multipart/mixed; boundary="===============0107533863867595663=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] auto-t: return None with get_ordered_network(s)
Date: Mon, 28 Oct 2019 12:51:59 -0700
Message-ID: <20191028195201.21904-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0107533863867595663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If no networks are found, return None rather than an empty
array. This is easier to check by the caller (and was assumed
in some cases). Also add an exception to get_ordered_network
if no network is found.
---
 autotests/util/iwd.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 3ba5112c..35e5a693 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -376,6 +376,10 @@ class Device(IWDDBusAbstract):
         for bus_obj in self._station.GetOrderedNetworks():
             ordered_network =3D OrderedNetwork(bus_obj)
             ordered_networks.append(ordered_network)
+
+        if len(ordered_networks) =3D=3D 0:
+            return None
+
         return ordered_networks
 =

     def get_ordered_network(self, network):
@@ -385,6 +389,9 @@ class Device(IWDDBusAbstract):
         '''
         ordered_networks =3D self.get_ordered_networks()
 =

+        if not ordered_networks:
+            raise Exception('Network %s not found' % network)
+
         for n in ordered_networks:
             if n.name =3D=3D network:
                 return n
-- =

2.17.1

--===============0107533863867595663==--

