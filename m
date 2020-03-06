Content-Type: multipart/mixed; boundary="===============5461225620681875555=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] agent: enforce a maximum passphrase length
Date: Fri, 06 Mar 2020 09:48:42 -0800
Message-ID: <20200306174843.26578-3-prestwoj@gmail.com>
In-Reply-To: <20200306174843.26578-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5461225620681875555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/agent.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/agent.c b/src/agent.c
index d213f3cd..44039a89 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -159,6 +159,9 @@ static void passphrase_reply(struct l_dbus_message *rep=
ly,
 	if (!l_dbus_message_get_arguments(reply, "s", &passphrase))
 		goto done;
 =

+	if (strlen(passphrase) > IWD_MAX_PASSPHRASE_LEN)
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

+	if (strlen(passwd) > IWD_MAX_PASSPHRASE_LEN)
+		goto done;
+
 	result =3D AGENT_RESULT_OK;
 =

 done:
-- =

2.17.1

--===============5461225620681875555==--

