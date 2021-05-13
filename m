Content-Type: multipart/mixed; boundary="===============7019795772716300130=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 1/9] ap: Make rtnl global static
Date: Thu, 13 May 2021 20:47:10 +0200
Message-ID: <20210513184718.265483-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7019795772716300130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/ap.c b/src/ap.c
index 8851cb85..7eac07d7 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -141,7 +141,7 @@ struct ap_ip_pool {
 =

 struct ap_ip_pool pool;
 static uint32_t netdev_watch;
-struct l_netlink *rtnl;
+static struct l_netlink *rtnl;
 =

 /*
  * Creates pool of IPs which AP intefaces can use. Each call to ip_pool_get
-- =

2.27.0

--===============7019795772716300130==--

