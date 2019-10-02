Content-Type: multipart/mixed; boundary="===============1529102121076574156=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 4/4] netconfig: Fix return type for module init
Date: Wed, 02 Oct 2019 13:39:59 -0700
Message-ID: <20191002203959.5582-4-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191002203959.5582-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1529102121076574156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 2175d9be..285d5fef 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -1087,7 +1087,7 @@ static int netconfig_init(void)
 								!enabled) {
 		l_warn("netconfig: Network configuration with the IP addresses "
 								"is disabled.");
-		return false;
+		return 0;
 	}
 =

 	rtnl =3D l_netlink_new(NETLINK_ROUTE);
-- =

2.13.6

--===============1529102121076574156==--

