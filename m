Content-Type: multipart/mixed; boundary="===============2963942761869209648=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 07/10] ap: Move the DHCP server freeing to ap_reset
Date: Fri, 05 Mar 2021 16:09:33 +0100
Message-ID: <20210305150936.868546-7-andrew.zaborowski@intel.com>
In-Reply-To: <20210305150936.868546-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2963942761869209648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some callers of ap_reset(ap)/l_free(ap) would not call
l_dhcp_server_destroy() causing some likely leaks.  It's easier to call
it directly from inside ap_reset().
---
 src/ap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 1b856c23..c9eec2a7 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -394,8 +394,10 @@ static void ap_reset(struct ap_state *ap)
 	ap_config_free(ap->config);
 	ap->config =3D NULL;
 =

-	if (ap->dhcp)
-		l_dhcp_server_stop(ap->dhcp);
+	if (ap->dhcp) {
+		l_dhcp_server_destroy(ap->dhcp);
+		ap->dhcp =3D NULL;
+	}
 =

 	l_queue_destroy(ap->rtnl_addr4_dump, l_free);
 	ap->rtnl_addr4_dump =3D NULL;
@@ -2924,8 +2926,6 @@ void ap_free(struct ap_state *ap)
 {
 	ap_reset(ap);
 	l_genl_family_free(ap->nl80211);
-	if (ap->dhcp)
-		l_dhcp_server_destroy(ap->dhcp);
 	l_free(ap);
 }
 =

-- =

2.27.0

--===============2963942761869209648==--

