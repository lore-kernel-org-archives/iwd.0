Content-Type: multipart/mixed; boundary="===============4457376228830852903=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] client: Init variable before usage
Date: Fri, 18 Oct 2019 14:58:03 -0700
Message-ID: <20191018215803.19398-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4457376228830852903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Uninitialized 'password' variable used to cause an error when --password
option wasn't avaiable
---
 client/agent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/agent.c b/client/agent.c
index 5844acdd..5ed6538f 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -240,7 +240,7 @@ static struct l_dbus_message *request_user_password_com=
mand_option(
 						struct l_dbus_message *message)
 {
 	struct l_dbus_message *reply;
-	const char *password;
+	const char *password =3D NULL;
 =

 	command_option_get(COMMAND_OPTION_PASSWORD, &password);
 	if (!password)
-- =

2.13.6

--===============4457376228830852903==--

