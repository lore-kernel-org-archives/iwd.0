Content-Type: multipart/mixed; boundary="===============3161322531352435576=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/5] ap: massage code to make static analysis happy
Date: Mon, 08 Feb 2021 12:19:58 -0800
Message-ID: <20210208201958.607049-5-prestwoj@gmail.com>
In-Reply-To: <20210208201958.607049-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3161322531352435576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is no functional change here but checking the return
value makes static analysis much happier. Checking the
return and setting the default inside the if clause is also
consistent with how IWD does it many other places.
---
 src/ap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 162b456b..407a2596 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -3305,7 +3305,7 @@ static void ap_netdev_watch(struct netdev *netdev,
 static int ap_init(void)
 {
 	const struct l_settings *settings =3D iwd_get_config();
-	bool dhcp_enable =3D false;
+	bool dhcp_enable;
 =

 	netdev_watch =3D netdev_watch_add(ap_netdev_watch, NULL, NULL);
 =

@@ -3320,8 +3320,9 @@ static int ap_init(void)
 	 * DHCP server. If no value is found or it is false do not create a
 	 * DHCP server.
 	 */
-	l_settings_get_bool(settings, "General", "EnableNetworkConfiguration",
-				&dhcp_enable);
+	if (!l_settings_get_bool(settings, "General",
+				"EnableNetworkConfiguration", &dhcp_enable))
+		dhcp_enable =3D false;
 =

 	if (dhcp_enable) {
 		L_AUTO_FREE_VAR(char *, ip_prefix);
-- =

2.26.2

--===============3161322531352435576==--

