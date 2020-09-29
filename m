Content-Type: multipart/mixed; boundary="===============8034304489536494577=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/6] wscutil: Fix subcategory string lookup
Date: Tue, 29 Sep 2020 18:37:06 +0200
Message-ID: <20200929163717.754459-3-andrew.zaborowski@intel.com>
In-Reply-To: <20200929163717.754459-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8034304489536494577==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The device type category array is indexed by the category ID so if we're
skipping i =3D=3D 0 in the iteration, we should also skip the 0'th element
in device_type_categories.
---
 src/wscutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wscutil.c b/src/wscutil.c
index f5ff5d75..81b175d8 100644
--- a/src/wscutil.c
+++ b/src/wscutil.c
@@ -3031,7 +3031,7 @@ bool wsc_device_type_to_dbus_str(const struct wsc_pri=
mary_device_type *val,
 bool wsc_device_type_from_subcategory_str(struct wsc_primary_device_type *=
out,
 						const char *subcategory_str)
 {
-	struct device_type_category_info *cat =3D device_type_categories;
+	struct device_type_category_info *cat =3D device_type_categories + 1;
 	unsigned int i;
 =

 	for (i =3D 1; i < L_ARRAY_SIZE(device_type_categories); i++, cat++) {
-- =

2.25.1

--===============8034304489536494577==--

