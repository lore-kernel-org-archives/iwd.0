Content-Type: multipart/mixed; boundary="===============8092385176733661296=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 7/7] netconfig: Set more correct buffer length
Date: Mon, 25 Jan 2021 18:56:17 +0100
Message-ID: <20210125175617.2417412-7-andrew.zaborowski@intel.com>
In-Reply-To: <20210125175617.2417412-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8092385176733661296==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use INET_ADDRSTRLEN as the IPv4 address buffer size to avoid confusion.
---
 src/netconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index e7a6a402..cf092b78 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -608,7 +608,7 @@ static bool netconfig_ipv4_routes_install(struct netcon=
fig *netconfig)
 	L_AUTO_FREE_VAR(char *, gateway) =3D NULL;
 	struct in_addr in_addr;
 	char *network;
-	char ip[INET6_ADDRSTRLEN];
+	char ip[INET_ADDRSTRLEN];
 	unsigned int prefix_len =3D
 		l_rtnl_address_get_prefix_length(netconfig->v4_address);
 =

-- =

2.27.0

--===============8092385176733661296==--

