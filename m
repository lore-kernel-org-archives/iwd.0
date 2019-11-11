Content-Type: multipart/mixed; boundary="===============5488471616400847201=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/2] module: Fix variable names
Date: Mon, 11 Nov 2019 13:34:16 +0100
Message-ID: <20191111123417.2103-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5488471616400847201==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Apparently the intention was for the dependent module's name to appear
in the variable name resulting from using IWD_MODULE_DEPENDS, so the
dependencies all have unique names (apparently not critical).
---
 src/module.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/module.h b/src/module.h
index b0102cba..c0f1c6c1 100644
--- a/src/module.h
+++ b/src/module.h
@@ -40,7 +40,7 @@ struct iwd_module_depends {
 =

 #define IWD_MODULE_DEPENDS(name, dep)					\
 	static struct iwd_module_depends				\
-				__iwd_module__##name_##dep		\
+				__iwd_module__##name##_##dep		\
 		__attribute__((used, section("__iwd_module_dep"),       \
 					aligned(8))) =3D {		\
 			.self =3D #name,					\
-- =

2.20.1

--===============5488471616400847201==--

