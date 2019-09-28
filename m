Content-Type: multipart/mixed; boundary="===============6917284020154852526=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH v2 09/14] netconfig: Request all known IPv6 addresses
Date: Fri, 27 Sep 2019 17:12:28 -0700
Message-ID: <20190928001233.19217-9-tim.a.kourt@linux.intel.com>
In-Reply-To: <20190928001233.19217-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6917284020154852526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/netconfig.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/src/netconfig.c b/src/netconfig.c
index 140de63a..6f97eed5 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -401,6 +401,22 @@ static void netconfig_ifaddr_ipv6_notify(uint16_t type=
, const void *data,
 	}
 }
 =

+static void netconfig_ifaddr_ipv6_cmd_cb(int error, uint16_t type,
+						const void *data, uint32_t len,
+						void *user_data)
+{
+	if (error) {
+		l_error("netconfig: ifaddr IPv6 command failure. "
+				"Error %d: %s", error, strerror(-error));
+		return;
+	}
+
+	if (type !=3D RTM_NEWADDR)
+		return;
+
+	netconfig_ifaddr_ipv6_notify(type, data, len, user_data);
+}
+
 static void netconfig_route_cmd_cb(int error, uint16_t type,
 						const void *data, uint32_t len,
 						void *user_data)
@@ -831,6 +847,14 @@ static int netconfig_init(void)
 		goto error;
 	}
 =

+	r =3D rtnl_ifaddr_ipv6_get(rtnl, netconfig_ifaddr_ipv6_cmd_cb, NULL,
+									NULL);
+	if (!r) {
+		l_error("netconfig: Failed to get IPv6 addresses from RTNL"
+								" link.");
+		goto error;
+	}
+
 	if (!l_settings_get_uint(iwd_get_config(), "General",
 							"route_priority_offset",
 							&ROUTE_PRIORITY_OFFSET))
-- =

2.13.6

--===============6917284020154852526==--

