Content-Type: multipart/mixed; boundary="===============5754881965820920110=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/5] ap: Move the DHCP server freeing to ap_reset
Date: Tue, 02 Mar 2021 13:08:11 +0100
Message-ID: <20210302120813.757731-3-andrew.zaborowski@intel.com>
In-Reply-To: <20210302120813.757731-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5754881965820920110==
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
index c5e6c43e..5425823a 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -250,8 +250,10 @@ static void ap_reset(struct ap_state *ap)
 	if (ap->own_ip)
 		l_free(ap->own_ip);
 =

-	if (ap->server)
-		l_dhcp_server_stop(ap->server);
+	if (ap->server) {
+		l_dhcp_server_destroy(ap->server);
+		ap->server =3D NULL;
+	}
 =

 	if (ap->profile) {
 		l_settings_free(ap->profile);
@@ -3075,8 +3077,6 @@ void ap_free(struct ap_state *ap)
 {
 	ap_reset(ap);
 	l_genl_family_free(ap->nl80211);
-	if (ap->server)
-		l_dhcp_server_destroy(ap->server);
 	l_free(ap);
 }
 =

-- =

2.27.0

--===============5754881965820920110==--

