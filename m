Content-Type: multipart/mixed; boundary="===============4958545618914369649=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 5/6] netconfig: Use CamelCase for IPv6 gateway setting
Date: Tue, 10 Dec 2019 15:38:36 -0800
Message-ID: <20191210233837.1499-5-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191210233837.1499-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4958545618914369649==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netconfig.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 7776f6e1..d91f4120 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -351,7 +351,11 @@ static char *netconfig_ipv6_get_gateway(struct netconf=
ig *netconfig)
 	switch (netconfig->rtm_v6_protocol) {
 	case RTPROT_STATIC:
 		gateway =3D l_settings_get_string(netconfig->active_settings,
-							"IPv6", "gateway");
+							"IPv6", "Gateway");
+		if (!gateway)
+			gateway =3D l_settings_get_string(
+						netconfig->active_settings,
+						"IPv6", "gateway");
 =

 		if (inet_pton(AF_INET6, gateway, &in6_addr) < 1) {
 			l_error("netconfig: Invalid IPv6 gateway address %s is "
-- =

2.13.6

--===============4958545618914369649==--

