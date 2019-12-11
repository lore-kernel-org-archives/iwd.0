Content-Type: multipart/mixed; boundary="===============8984807871919770726=="
MIME-Version: 1.0
From: xdavidwu <xdavidwuph@gmail.com>
Subject: [PATCH] eap-gtc: Try to auth even if request not Password
Date: Wed, 11 Dec 2019 20:39:04 +0800
Message-ID: <20191211123904.27413-1-xdavidwuph@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8984807871919770726==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There are some server implementations that send requests that are
not "Password" but still want us send password. This commit modify
the behavior to send a warning and still try to auth with password.

This makes me able to auth with server in my school which sends
"Enter Aruba Login".

wpa_supplicant does not check if it is "Password".
---
 src/eap-gtc.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/src/eap-gtc.c b/src/eap-gtc.c
index 9302257e..7788d44c 100644
--- a/src/eap-gtc.c
+++ b/src/eap-gtc.c
@@ -56,11 +56,9 @@ static void eap_gtc_handle_request(struct eap_state *eap,
 	size_t secret_len =3D strlen(gtc->password);
 	uint8_t response[5 + secret_len];
 =

-	if (len < 8)
-		goto error;
-
-	if (strncmp((const char *)pkt, "Password", 8))
-		goto error;
+	if (len < 8 || strncmp((const char *)pkt, "Password", 8))
+		l_warn("GTC request not understood, proceeding anyway: %.*s",
+				(int) len, (const char *) pkt);
 =

 	memcpy(response + 5, gtc->password, secret_len);
 =

@@ -69,10 +67,6 @@ static void eap_gtc_handle_request(struct eap_state *eap,
 	eap_method_success(eap);
 =

 	return;
-
-error:
-	l_error("invalid GTC request");
-	eap_method_error(eap);
 }
 =

 static int eap_gtc_check_settings(struct l_settings *settings,
-- =

2.24.1

--===============8984807871919770726==--

