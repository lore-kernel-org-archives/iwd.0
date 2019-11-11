Content-Type: multipart/mixed; boundary="===============8020266385536147576=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] modules: Unload modules in reverse order from loading
Date: Mon, 11 Nov 2019 13:34:17 +0100
Message-ID: <20191111123417.2103-2-andrew.zaborowski@intel.com>
In-Reply-To: <20191111123417.2103-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8020266385536147576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Make sure a module A that is needed by B is not unloaded before B.
---
 src/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/module.c b/src/module.c
index 9eb282f0..a8f82015 100644
--- a/src/module.c
+++ b/src/module.c
@@ -173,7 +173,7 @@ void iwd_modules_exit()
 		return;
 =

 	for (i =3D 0; i < n_modules; i++) {
-		desc =3D modules_sorted[i];
+		desc =3D modules_sorted[n_modules - 1 - i];
 		if (!desc->active)
 			continue;
 =

-- =

2.20.1

--===============8020266385536147576==--

