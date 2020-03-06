Content-Type: multipart/mixed; boundary="===============3763684345054379591=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/3] agent: enforce a maximum passphrase length
Date: Fri, 06 Mar 2020 10:34:36 -0800
Message-ID: <20200306183437.31440-2-prestwoj@gmail.com>
In-Reply-To: <20200306183437.31440-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3763684345054379591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/agent.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/agent.c b/src/agent.c
index d213f3cd..c221cbd8 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -159,6 +159,9 @@ static void passphrase_reply(struct l_dbus_message *rep=
ly,
 	if (!l_dbus_message_get_arguments(reply, "s", &passphrase))
 		goto done;
 =

+	if (strlen(passphrase) > IWD_MAX_PASSWORD_LEN)
+		goto done;
+
 	result =3D AGENT_RESULT_OK;
 =

 done:
@@ -181,6 +184,9 @@ static void user_name_passwd_reply(struct l_dbus_messag=
e *reply,
 	if (!l_dbus_message_get_arguments(reply, "ss", &username, &passwd))
 		goto done;
 =

+	if (strlen(passwd) > IWD_MAX_PASSWORD_LEN)
+		goto done;
+
 	result =3D AGENT_RESULT_OK;
 =

 done:
-- =

2.17.1

--===============3763684345054379591==--

