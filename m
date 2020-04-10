Content-Type: multipart/mixed; boundary="===============0993586009742183528=="
MIME-Version: 1.0
From: Rosen Penev <rosenp@gmail.com>
Subject: [PATCH 2/3] module: add void to empty argument functions
Date: Thu, 09 Apr 2020 17:38:30 -0700
Message-ID: <20200410003831.258910-2-rosenp@gmail.com>
In-Reply-To: <20200410003831.258910-1-rosenp@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0993586009742183528==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Found with clang's -Wstrict-prototypes
---
 src/module.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/module.h b/src/module.h
index c0f1c6c1..8e1a9904 100644
--- a/src/module.h
+++ b/src/module.h
@@ -47,5 +47,5 @@ struct iwd_module_depends {
 			.target =3D #dep,					\
 		};
 =

-int iwd_modules_init();
-void iwd_modules_exit();
+int iwd_modules_init(void);
+void iwd_modules_exit(void);
-- =

2.25.1

--===============0993586009742183528==--

