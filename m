Content-Type: multipart/mixed; boundary="===============3857047838909625316=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/3] eap-gtc: limit password length to maximum
Date: Fri, 06 Mar 2020 11:16:27 -0800
Message-ID: <20200306191628.5461-2-prestwoj@gmail.com>
In-Reply-To: <20200306191628.5461-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3857047838909625316==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The password for EAP-GTC is directly used in an EAP response. The
response buffer is created on the stack so an overly large password
could cause a stack overflow.
---
 src/eap-gtc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-v3:
 * Defined maximum locally to not depend on iwd.h

diff --git a/src/eap-gtc.c b/src/eap-gtc.c
index 7788d44c..f895ec61 100644
--- a/src/eap-gtc.c
+++ b/src/eap-gtc.c
@@ -32,6 +32,8 @@
 #include "src/eap.h"
 #include "src/eap-private.h"
 =

+#define EAP_GTC_MAX_PASSWORD_LEN	2048
+
 struct eap_gtc_state {
 	char *password;
 };
@@ -148,6 +150,14 @@ static bool eap_gtc_load_settings(struct eap_state *ea=
p,
 			return false;
 	}
 =

+	/*
+	 * Limit length to prevent a stack overflow
+	 */
+	if (strlen(password) > EAP_GTC_MAX_PASSWORD_LEN) {
+		l_free(password);
+		return false;
+	}
+
 	gtc =3D l_new(struct eap_gtc_state, 1);
 	gtc->password =3D password;
 =

-- =

2.17.1

--===============3857047838909625316==--

