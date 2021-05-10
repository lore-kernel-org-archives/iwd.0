Content-Type: multipart/mixed; boundary="===============0476953783987401529=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 06/11] ap: Move the DHCP server freeing to ap_reset
Date: Mon, 10 May 2021 10:58:01 +0200
Message-ID: <20210510085806.174213-6-andrew.zaborowski@intel.com>
In-Reply-To: <20210510085806.174213-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0476953783987401529==
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
index 37b71a6f..9813a90d 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -244,8 +244,10 @@ static void ap_reset(struct ap_state *ap)
 		ap->cleanup_addr4 =3D false;
 	}
 =

-	if (ap->netconfig_dhcp)
-		l_dhcp_server_stop(ap->netconfig_dhcp);
+	if (ap->netconfig_dhcp) {
+		l_dhcp_server_destroy(ap->netconfig_dhcp);
+		ap->netconfig_dhcp =3D NULL;
+	}
 =

 	l_queue_destroy(ap->netconfig_addr4_dump, l_free);
 	ap->netconfig_addr4_dump =3D NULL;
@@ -3125,8 +3127,6 @@ void ap_free(struct ap_state *ap)
 {
 	ap_reset(ap);
 	l_genl_family_free(ap->nl80211);
-	if (ap->netconfig_dhcp)
-		l_dhcp_server_destroy(ap->netconfig_dhcp);
 	l_free(ap);
 }
 =

-- =

2.27.0

--===============0476953783987401529==--

