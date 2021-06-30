Content-Type: multipart/mixed; boundary="===============9071217176063058778=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/3] netconfig: Reserve INET_ADDRSTRLEN chars for an IPv4
 string
Date: Wed, 30 Jun 2021 21:06:35 +0200
Message-ID: <20210630190635.264095-3-andrew.zaborowski@intel.com>
In-Reply-To: <20210630190635.264095-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9071217176063058778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For consistency replace an INET6_ADDRSTRLEN instance with
INET_ADDRSTRLEN in a strictly IPv4 context in
netconfig_ipv4_select_and_install.
---
 src/netconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 20c39f0f..6a7c49d0 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -1114,7 +1114,7 @@ static void netconfig_ipv4_acd_event(enum l_acd_event=
 event, void *user_data)
 =

 static void netconfig_ipv4_select_and_install(struct netconfig *netconfig)
 {
-	char ip[INET6_ADDRSTRLEN];
+	char ip[INET_ADDRSTRLEN];
 =

 	netconfig->v4_address =3D netconfig_get_static4_address(netconfig);
 	if (netconfig->v4_address &&
-- =

2.30.2

--===============9071217176063058778==--

