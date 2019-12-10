Content-Type: multipart/mixed; boundary="===============7543630599253058551=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 2/6] netconfig: Use CamelCase for IPv4 gateway setting
Date: Tue, 10 Dec 2019 15:38:33 -0800
Message-ID: <20191210233837.1499-2-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191210233837.1499-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7543630599253058551==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netconfig.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index df9d7ce4..0d5f9464 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -204,12 +204,18 @@ static struct netconfig_ifaddr *netconfig_ipv4_get_if=
addr(
 static char *netconfig_ipv4_get_gateway(struct netconfig *netconfig)
 {
 	const struct l_dhcp_lease *lease;
+	char *gateway;
 =

 	switch (netconfig->rtm_protocol) {
 	case RTPROT_STATIC:
+		gateway =3D l_settings_get_string(netconfig->active_settings,
+							"IPv4", "Gateway");
+		if (!gateway)
+			gateway =3D l_settings_get_string(
+						netconfig->active_settings,
+						"IPv4", "gateway");
 =

-		return l_settings_get_string(netconfig->active_settings,
-							"IPv4", "gateway");
+		return gateway;
 =

 	case RTPROT_DHCP:
 		lease =3D l_dhcp_client_get_lease(netconfig->dhcp_client);
-- =

2.13.6

--===============7543630599253058551==--

