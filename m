Content-Type: multipart/mixed; boundary="===============4901258330151131601=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 2/2] netconfig: Remove roaming logic
Date: Tue, 01 Oct 2019 16:39:40 -0700
Message-ID: <20191001233940.21969-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191001233940.21969-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4901258330151131601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Previously, netconfig_ipv4_select_and_install was used to install
addresses on initial connection to a network and after we have roamed.
Now for the after roaming connection scenario we have
netconfig_reconfigure. Remove roaming related code from
netconfig_ipv4_select_and_install
---
 src/netconfig.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 272a058f..70481abf 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -597,15 +597,6 @@ static void netconfig_ipv4_select_and_install(struct n=
etconfig *netconfig)
 =

 	netconfig->rtm_protocol =3D RTPROT_DHCP;
 =

-	if (netconfig->station_state =3D=3D STATION_STATE_ROAMING) {
-		/*
-		 * TODO l_dhcp_client to try to request a
-		 * previously used address.
-		 *
-		 * return;
-		 */
-	}
-
 	if (l_dhcp_client_start(netconfig->dhcp_client))
 		return;
 =

-- =

2.13.6

--===============4901258330151131601==--

