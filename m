Content-Type: multipart/mixed; boundary="===============2907535225003700580=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/6] test: Update paths in list-devices
Date: Sat, 15 Feb 2020 01:17:47 +0100
Message-ID: <20200215001748.20819-5-andrew.zaborowski@intel.com>
In-Reply-To: <20200215001748.20819-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2907535225003700580==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/list-devices | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/test/list-devices b/test/list-devices
index 301dea6a..fb76d3ca 100755
--- a/test/list-devices
+++ b/test/list-devices
@@ -21,7 +21,8 @@ for path in objects:
         node =3D node.children[subpath]
     node.interfaces.update(objects[path])
 =

-for path, phy in tree.children.items():
+root =3D tree.children['/net'].children['/net/connman'].children['/net/con=
nman/iwd']
+for path, phy in root.children.items():
     if 'net.connman.iwd.Adapter' not in phy.interfaces:
         continue
 =

-- =

2.20.1

--===============2907535225003700580==--

