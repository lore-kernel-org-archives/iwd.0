Content-Type: multipart/mixed; boundary="===============2648741078558914771=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/3] eap-gtc: limit password length to maximum
Date: Fri, 06 Mar 2020 10:34:37 -0800
Message-ID: <20200306183437.31440-3-prestwoj@gmail.com>
In-Reply-To: <20200306183437.31440-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2648741078558914771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The password for EAP-GTC is directly used in an EAP response. The
response buffer is created on the stack so an overly large password
could cause a stack overflow.
---
 src/eap-gtc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/eap-gtc.c b/src/eap-gtc.c
index 7788d44c..19447b0f 100644
--- a/src/eap-gtc.c
+++ b/src/eap-gtc.c
@@ -31,6 +31,7 @@
 #include "src/missing.h"
 #include "src/eap.h"
 #include "src/eap-private.h"
+#include "src/iwd.h"
 =

 struct eap_gtc_state {
 	char *password;
@@ -148,6 +149,14 @@ static bool eap_gtc_load_settings(struct eap_state *ea=
p,
 			return false;
 	}
 =

+	/*
+	 * Limit length to prevent a stack overflow
+	 */
+	if (strlen(password) > IWD_MAX_PASSWORD_LEN) {
+		l_free(password);
+		return false;
+	}
+
 	gtc =3D l_new(struct eap_gtc_state, 1);
 	gtc->password =3D password;
 =

-- =

2.17.1

--===============2648741078558914771==--

