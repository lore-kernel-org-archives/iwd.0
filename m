Content-Type: multipart/mixed; boundary="===============0688966428142725379=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] netconfig: Make gateway optional for client
Date: Tue, 08 Jun 2021 16:42:29 +0200
Message-ID: <20210608144229.256776-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0688966428142725379==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Don't require a gateway address from the settings file or from the DHCP
server when doing netconfig.  Failing when the gateway address was
missing was breaking P2P but also small local networks.
---
 src/netconfig.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 7665d786..316431ee 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -652,11 +652,17 @@ static bool netconfig_ipv4_routes_install(struct netc=
onfig *netconfig)
 =

 	gateway =3D netconfig_ipv4_get_gateway(netconfig);
 	if (!gateway) {
-		l_error("netconfig: Failed to obtain gateway from %s.",
+		l_debug("No gateway obtained from %s.",
 				netconfig->rtm_protocol =3D=3D RTPROT_STATIC ?
 				"setting file" : "DHCPv4 lease");
 =

-		return false;
+		if (netconfig->notify) {
+			netconfig->notify(NETCONFIG_EVENT_CONNECTED,
+						netconfig->user_data);
+			netconfig->notify =3D NULL;
+		}
+
+		return true;
 	}
 =

 	netconfig->route4_add_gateway_cmd_id =3D
-- =

2.30.2

--===============0688966428142725379==--

