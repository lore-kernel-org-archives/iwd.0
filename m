Content-Type: multipart/mixed; boundary="===============7264328273967581654=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: [PATCH 6/9] netconfig: Don't start ACD with FILS IP Assignment
Date: Mon, 08 Nov 2021 12:28:35 +0100
Message-ID: <20211108112838.372416-6-andrew.zaborowski@intel.com>
In-Reply-To: 20211108112838.372416-1-andrew.zaborowski@intel.com

--===============7264328273967581654==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Restore the older behaviour where ACD was started only with static
addressing.  There are various arguments for saving setup time by not
doing ACD when a wifi network has IP addresses managed centrally (and
some arguments against), for now just restore the behaviour from before
FILS IP Assignment was added.
---
 src/netconfig.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 3a67c890..bffa7da4 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -1622,22 +1622,28 @@ static bool netconfig_ipv4_select_and_install(struc=
t netconfig *netconfig)
 							ip)))
 			return false;
 =

-		netconfig->acd =3D l_acd_new(netconfig->ifindex);
-		l_acd_set_event_handler(netconfig->acd,
-					netconfig_ipv4_acd_event, netconfig,
-					NULL);
-		if (getenv("IWD_ACD_DEBUG"))
-			l_acd_set_debug(netconfig->acd, do_debug,
-					"[ACD] ", NULL);
-
-		if (!l_acd_start(netconfig->acd, ip)) {
-			l_error("failed to start ACD, continuing anyways");
-			l_acd_destroy(netconfig->acd);
-			netconfig->acd =3D NULL;
+		if (netconfig->rtm_protocol =3D=3D RTPROT_STATIC) {
+			netconfig->acd =3D l_acd_new(netconfig->ifindex);
+			l_acd_set_event_handler(netconfig->acd,
+						netconfig_ipv4_acd_event,
+						netconfig, NULL);
 =

-			netconfig_set(netconfig, AF_INET, changed);
-		} else
+			if (getenv("IWD_ACD_DEBUG"))
+				l_acd_set_debug(netconfig->acd, do_debug,
+						"[ACD] ", NULL);
+
+			if (!l_acd_start(netconfig->acd, ip)) {
+				l_error("failed to start ACD, continuing "
+					"anyways");
+				l_acd_destroy(netconfig->acd);
+				netconfig->acd =3D NULL;
+			}
+		}
+
+		if (netconfig->acd)
 			netconfig->pending_v4_set |=3D changed;
+		else
+			netconfig_set(netconfig, AF_INET, changed);
 =

 		return true;
 	}
-- =

2.32.0

--===============7264328273967581654==--

