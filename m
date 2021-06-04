Content-Type: multipart/mixed; boundary="===============7937285929911027977=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 12/15] autotests: Initialise P2PPeer objects with correct
 namespace
Date: Fri, 04 Jun 2021 03:50:49 +0200
Message-ID: <20210604015052.163727-12-andrew.zaborowski@intel.com>
In-Reply-To: <20210604015052.163727-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7937285929911027977==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/iwd.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index e6421088..350e1aca 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -826,7 +826,7 @@ class P2PDevice(IWDDBusAbstract):
         self._peer_dict =3D {}
 =

         for path, rssi in self._iface.GetPeers():
-            self._peer_dict[path] =3D old_dict[path] if path in old_dict e=
lse P2PPeer(path)
+            self._peer_dict[path] =3D old_dict[path] if path in old_dict e=
lse P2PPeer(path, namespace=3Dself._namespace)
             self._peer_dict[path].rssi =3D rssi
 =

         return self._peer_dict
-- =

2.30.2

--===============7937285929911027977==--

