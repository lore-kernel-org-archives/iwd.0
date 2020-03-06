Content-Type: multipart/mixed; boundary="===============8922359261929204661=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/3] network: enforce max EAP/pkey password length
Date: Fri, 06 Mar 2020 11:16:28 -0800
Message-ID: <20200306191628.5461-3-prestwoj@gmail.com>
In-Reply-To: <20200306191628.5461-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8922359261929204661==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/network.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/src/network.c b/src/network.c
index fe6ba867..c08d7e72 100644
--- a/src/network.c
+++ b/src/network.c
@@ -892,7 +892,15 @@ static void eap_password_callback(enum agent_result re=
sult, const char *value,
 	struct eap_secret_request *req =3D user_data;
 =

 	req->network->agent_request =3D 0;
-	req->secret->value =3D l_strdup(value);
+
+	if (value) {
+		if (strlen(value) < IWD_MAX_PASSWORD_LEN)
+			req->secret->value =3D l_strdup(value);
+		else {
+			l_error("EAP password too long");
+			result =3D AGENT_RESULT_FAILED;
+		}
+	}
 =

 	req->callback(result, message, req);
 }
@@ -910,11 +918,18 @@ static void eap_user_password_callback(enum agent_res=
ult result,
 		size_t len1 =3D strlen(user) + 1;
 		size_t len2 =3D strlen(passwd) + 1;
 =

+		if (len2 > IWD_MAX_PASSWORD_LEN) {
+			l_error("EAP password too long");
+			result =3D AGENT_RESULT_FAILED;
+			goto done;
+		}
+
 		req->secret->value =3D l_malloc(len1 + len2);
 		memcpy(req->secret->value, user, len1);
 		memcpy(req->secret->value + len1, passwd, len2);
 	}
 =

+done:
 	req->callback(result, message, req);
 }
 =

-- =

2.17.1

--===============8922359261929204661==--

