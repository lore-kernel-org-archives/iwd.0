Content-Type: multipart/mixed; boundary="===============5170593888791409423=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 08/13] p2p: Use a longer DHCP timeout
Date: Fri, 31 Jul 2020 03:31:31 +0200
Message-ID: <20200731013136.65057-8-andrew.zaborowski@intel.com>
In-Reply-To: <20200731013136.65057-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5170593888791409423==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With some devices the 10 seconds are not enough for the P2P Group Owner
to give us an address but I think we still want to use a timeout as
short as possible so that the user doesn't wait too long if the
connection isn't working.
---
 src/p2p.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/p2p.c b/src/p2p.c
index da98f2a7..3b38f738 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -667,7 +667,7 @@ static void p2p_start_dhcp(struct p2p_device *dev)
 =

 	if (!l_settings_get_uint(iwd_get_config(), "P2P", "DHCPTimeout",
 					&dhcp_timeout_val))
-		dhcp_timeout_val =3D 10;	/* 10s default */
+		dhcp_timeout_val =3D 20;	/* 20s default */
 =

 	if (!dev->conn_netconfig) {
 		dev->conn_netconfig =3D netconfig_new(ifindex);
-- =

2.25.1

--===============5170593888791409423==--

