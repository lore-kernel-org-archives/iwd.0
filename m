Content-Type: multipart/mixed; boundary="===============1176157484986538425=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/4] sysfs: introduce sysfs module
Date: Wed, 03 Nov 2021 15:14:59 -0700
Message-ID: <20211103221502.470442-1-prestwoj@gmail.com>

--===============1176157484986538425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Netconfig was the only user of sysfs but now other modules will
also need it.

Adding existing API for IPv6 settings, a IPv4 and IPv6 'supports'
checker, and a setter for IPv4 settings.
---
 Makefile.am |   1 +
 src/sysfs.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/sysfs.h |  28 ++++++++++++++
 3 files changed, 138 insertions(+)
 create mode 100644 src/sysfs.c
 create mode 100644 src/sysfs.h

diff --git a/Makefile.am b/Makefile.am
index a6dafe63..275dd1b9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -246,6 +246,7 @@ src_iwd_SOURCES =3D src/main.c linux/nl80211.h src/iwd.=
h src/missing.h \
 					src/diagnostic.h src/diagnostic.c \
 					src/ip-pool.h src/ip-pool.c \
 					src/band.h src/band.c \
+					src/sysfs.h src/sysfs.c \
 					$(eap_sources) \
 					$(builtin_sources)
 =

diff --git a/src/sysfs.c b/src/sysfs.c
new file mode 100644
index 00000000..d7972fc4
--- /dev/null
+++ b/src/sysfs.c
@@ -0,0 +1,109 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2021  Intel Corporation. All rights reserved.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <sys/stat.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#include <ell/ell.h>
+
+#include "src/sysfs.h"
+
+static int write_string(const char *file, const char *value)
+{
+	size_t l =3D strlen(value);
+	int fd;
+	int r;
+
+	fd =3D L_TFR(open(file, O_WRONLY));
+	if (fd < 0)
+		return -errno;
+
+	r =3D L_TFR(write(fd, value, l));
+	L_TFR(close(fd));
+
+	return r;
+}
+
+static bool sysfs_supports_ip_setting(const char *ipv, const char *ifname,
+					const char *setting)
+{
+	struct stat st;
+	int err;
+	L_AUTO_FREE_VAR(char *, file) =3D
+		l_strdup_printf("/proc/sys/net/%s/conf/%s/%s", ipv,
+							ifname, setting);
+
+	err =3D stat(file, &st);
+
+	if (!err && S_ISREG(st.st_mode) !=3D 0)
+		return true;
+
+	return false;
+}
+
+bool sysfs_supports_ipv6_setting(const char *ifname, const char *setting)
+{
+	return sysfs_supports_ip_setting("ipv6", ifname, setting);
+}
+
+int sysfs_write_ipv6_setting(const char *ifname, const char *setting,
+					const char *value)
+{
+	int r;
+
+	L_AUTO_FREE_VAR(char *, file) =3D
+		l_strdup_printf("/proc/sys/net/ipv6/conf/%s/%s",
+							ifname, setting);
+
+	r =3D write_string(file, value);
+	if (r < 0)
+		l_error("Unable to write %s to %s", setting, file);
+
+	return r;
+}
+
+bool sysfs_supports_ipv4_setting(const char *ifname, const char *setting)
+{
+	return sysfs_supports_ip_setting("ipv4", ifname, setting);
+}
+
+int sysfs_write_ipv4_setting(const char *ifname, const char *setting,
+					const char *value)
+{
+	int r;
+
+	L_AUTO_FREE_VAR(char *, file) =3D
+		l_strdup_printf("/proc/sys/net/ipv4/conf/%s/%s",
+							ifname, setting);
+
+	r =3D write_string(file, value);
+	if (r < 0)
+		l_error("Unable to write %s to %s", setting, file);
+
+	return r;
+}
diff --git a/src/sysfs.h b/src/sysfs.h
new file mode 100644
index 00000000..60207c13
--- /dev/null
+++ b/src/sysfs.h
@@ -0,0 +1,28 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2021  Intel Corporation. All rights reserved.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+bool sysfs_supports_ipv6_setting(const char *ifname, const char *setting);
+int sysfs_write_ipv6_setting(const char *ifname, const char *setting,
+					const char *value);
+bool sysfs_supports_ipv4_setting(const char *ifname, const char *setting);
+int sysfs_write_ipv4_setting(const char *ifname, const char *setting,
+					const char *value);
-- =

2.31.1

--===============1176157484986538425==--

