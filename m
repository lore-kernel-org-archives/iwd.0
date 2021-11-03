Content-Type: multipart/mixed; boundary="===============8373602457205923477=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 2/4] netconfig: remove sysfs static functions
Date: Wed, 03 Nov 2021 15:15:00 -0700
Message-ID: <20211103221502.470442-2-prestwoj@gmail.com>
In-Reply-To: 20211103221502.470442-1-prestwoj@gmail.com

--===============8373602457205923477==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netconfig.c | 33 +--------------------------------
 1 file changed, 1 insertion(+), 32 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index df9abd00..6e885546 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -50,6 +50,7 @@
 #include "src/util.h"
 #include "src/ie.h"
 #include "src/netconfig.h"
+#include "src/sysfs.h"
 =

 struct netconfig {
 	uint32_t ifindex;
@@ -102,38 +103,6 @@ static void do_debug(const char *str, void *user_data)
 	l_info("%s%s", prefix, str);
 }
 =

-static int write_string(const char *file, const char *value)
-{
-	size_t l =3D strlen(value);
-	int fd;
-	int r;
-
-	fd =3D L_TFR(open(file, O_WRONLY));
-	if (fd < 0)
-		return -errno;
-
-	r =3D L_TFR(write(fd, value, l));
-	L_TFR(close(fd));
-
-	return r;
-}
-
-static int sysfs_write_ipv6_setting(const char *ifname, const char *settin=
g,
-					const char *value)
-{
-	int r;
-
-	L_AUTO_FREE_VAR(char *, file) =3D
-		l_strdup_printf("/proc/sys/net/ipv6/conf/%s/%s",
-							ifname, setting);
-
-	r =3D write_string(file, value);
-	if (r < 0)
-		l_error("Unable to write %s to %s", setting, file);
-
-	return r;
-}
-
 static void netconfig_free_settings(struct netconfig *netconfig)
 {
 	l_rtnl_address_free(netconfig->v4_address);
-- =

2.31.1

--===============8373602457205923477==--

