Content-Type: multipart/mixed; boundary="===============8129942198822164066=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/6] plugin: remove plugin source
Date: Wed, 16 Sep 2020 12:39:43 -0700
Message-ID: <20200916193945.683476-4-prestwoj@gmail.com>
In-Reply-To: <20200916193945.683476-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8129942198822164066==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/plugin.c | 97 ----------------------------------------------------
 src/plugin.h | 24 -------------
 2 files changed, 121 deletions(-)
 delete mode 100644 src/plugin.c
 delete mode 100644 src/plugin.h

diff --git a/src/plugin.c b/src/plugin.c
deleted file mode 100644
index b5dc828a..00000000
--- a/src/plugin.c
+++ /dev/null
@@ -1,97 +0,0 @@
-/*
- *
- *  Wireless daemon for Linux
- *
- *  Copyright (C) 2017-2019  Intel Corporation. All rights reserved.
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <fnmatch.h>
-
-#include <ell/ell.h>
-#include <ell/plugin.h>
-
-#include "src/builtin.h"
-#include "src/plugin.h"
-
-static bool check_plugin(struct l_plugin_desc *desc,
-						char **include, char **exclude)
-{
-	char *pattern;
-	unsigned int i;
-
-	if (!include)
-		goto check_blacklist;
-
-	for (i =3D 0; (pattern =3D include[i]); i++) {
-		if (fnmatch(pattern, desc->name, 0) !=3D 0)
-			continue;
-
-		goto check_blacklist;
-	}
-
-	l_debug("whitelist filtered plugin: %s", desc->name);
-	return false;
-
-check_blacklist:
-	if (!exclude)
-		return true;
-
-	for (i =3D 0; (pattern =3D exclude[i]); i++) {
-		if (fnmatch(pattern, desc->name, 0) =3D=3D 0) {
-			l_debug("blacklist filtered plugin: %s", desc->name);
-			return false;
-		}
-	}
-
-	return true;
-}
-
-int plugin_init(const char *include, const char *exclude)
-{
-	char **inc =3D NULL;
-	char **exc =3D NULL;
-	int i;
-
-	if (include)
-		inc =3D l_strsplit_set(include, ",");
-
-	if (exclude)
-		exc =3D l_strsplit_set(exclude, ",");
-
-	for (i =3D 0; __iwd_builtin[i]; i++) {
-		if (check_plugin(__iwd_builtin[i], inc, exc))
-			l_plugin_add(__iwd_builtin[i],
-					__iwd_builtin[i]->version);
-	}
-
-	l_plugin_load(NULL, NULL, NULL);
-
-	l_strfreev(inc);
-	l_strfreev(exc);
-
-	return 1;
-}
-
-void plugin_exit(void)
-{
-	l_plugin_unload();
-}
diff --git a/src/plugin.h b/src/plugin.h
deleted file mode 100644
index 1c1cbc07..00000000
--- a/src/plugin.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- *
- *  Wireless daemon for Linux
- *
- *  Copyright (C) 2017-2019  Intel Corporation. All rights reserved.
- *
- *  This library is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU Lesser General Public
- *  License as published by the Free Software Foundation; either
- *  version 2.1 of the License, or (at your option) any later version.
- *
- *  This library is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  Lesser General Public License for more details.
- *
- *  You should have received a copy of the GNU Lesser General Public
- *  License along with this library; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
- *
- */
-
-int plugin_init(const char *include, const char *exclude);
-void plugin_exit(void);
-- =

2.26.2

--===============8129942198822164066==--

