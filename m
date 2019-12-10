Content-Type: multipart/mixed; boundary="===============6441318576513534060=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH 4/6] netconfig: Use CamelCase for IPv6 address settings
Date: Tue, 10 Dec 2019 15:38:35 -0800
Message-ID: <20191210233837.1499-4-tim.a.kourt@linux.intel.com>
In-Reply-To: <20191210233837.1499-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6441318576513534060==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netconfig.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 58a08b35..7776f6e1 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -290,9 +290,13 @@ static struct netconfig_ifaddr *netconfig_ipv6_get_ifa=
ddr(
 	switch (proto) {
 	case RTPROT_STATIC:
 		ip =3D l_settings_get_string(netconfig->active_settings, "IPv6",
-									"ip");
-		if (!ip)
-			return NULL;
+								"Address");
+		if (!ip) {
+			ip =3D l_settings_get_string(netconfig->active_settings,
+								"IPv6", "ip");
+			if (!ip)
+				return NULL;
+		}
 =

 		ifaddr =3D l_new(struct netconfig_ifaddr, 1);
 		ifaddr->ip =3D ip;
-- =

2.13.6

--===============6441318576513534060==--

