Content-Type: multipart/mixed; boundary="===============5954945038344833398=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/4] client: special case daemon interface for non-interactive
Date: Tue, 02 Nov 2021 12:57:49 -0700
Message-ID: <20211102195752.381604-1-prestwoj@gmail.com>

--===============5954945038344833398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In non-interactive mode, when a dbus method call returns the process
exits. This is true for all methods except agent requests since e.g.
Connect() call automatically requests credentials and the client must
wait for that to return before exiting. The new daemon interface must
also be treated in the same way and not exit.
---
 client/dbus-proxy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
index ab9fb5a5..0373a3df 100644
--- a/client/dbus-proxy.c
+++ b/client/dbus-proxy.c
@@ -315,7 +315,8 @@ static void proxy_callback(struct l_dbus_message *messa=
ge, void *user_data)
 	}
 =

 	proxy =3D callback_data->user_data;
-	if (!strcmp(proxy->type->interface, IWD_AGENT_MANAGER_INTERFACE))
+	if (!strcmp(proxy->type->interface, IWD_AGENT_MANAGER_INTERFACE) ||
+			!strcmp(proxy->type->interface, IWD_DAEMON_INTERFACE))
 		return;
 =

 quit:
-- =

2.31.1

--===============5954945038344833398==--

