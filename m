Content-Type: multipart/mixed; boundary="===============6187609794399911208=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 6/9] ap: Move the DHCP server freeing to ap_reset
Date: Thu, 13 May 2021 20:47:15 +0200
Message-ID: <20210513184718.265483-6-andrew.zaborowski@intel.com>
In-Reply-To: <20210513184718.265483-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6187609794399911208==
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
index 587b908b..cffb2906 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -244,8 +244,10 @@ static void ap_reset(struct ap_state *ap)
 	l_free(ap->netconfig_addr4_str);
 	ap->netconfig_addr4_str =3D NULL;
 =

-	if (ap->netconfig_dhcp)
-		l_dhcp_server_stop(ap->netconfig_dhcp);
+	if (ap->netconfig_dhcp) {
+		l_dhcp_server_destroy(ap->netconfig_dhcp);
+		ap->netconfig_dhcp =3D NULL;
+	}
 }
 =

 static void ap_del_station(struct sta_state *sta, uint16_t reason,
@@ -3063,8 +3065,6 @@ void ap_free(struct ap_state *ap)
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

--===============6187609794399911208==--

