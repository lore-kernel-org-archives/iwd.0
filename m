Content-Type: multipart/mixed; boundary="===============0698849959831835373=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 1/2] netconfig: Don't re-install IPv4 address on re-configure
Date: Tue, 01 Oct 2019 16:39:39 -0700
Message-ID: <20191001233940.21969-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0698849959831835373==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netconfig.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 4e294512..272a058f 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -645,17 +645,9 @@ bool netconfig_configure(struct netconfig *netconfig,
 bool netconfig_reconfigure(struct netconfig *netconfig)
 {
 	if (netconfig->rtm_protocol =3D=3D RTPROT_DHCP) {
-		/*
-		 *
-		 * TODO l_dhcp_client to try to request a
-		 * previously used address.
-		 *
-		 * return;
-		 */
+		/* TODO l_dhcp_client sending a DHCP inform request */
 	}
 =

-	netconfig_ipv4_select_and_install(netconfig);
-
 	/* TODO: IPv6 addressing */
 =

 	return true;
-- =

2.13.6

--===============0698849959831835373==--

