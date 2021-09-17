Content-Type: multipart/mixed; boundary="===============3556011963527965978=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] network: reply to pending messages on network_unregister
Date: Fri, 17 Sep 2021 16:16:10 -0700
Message-ID: <20210917231610.27853-1-prestwoj@gmail.com>

--===============3556011963527965978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If there is a connect_after_* message for ANQP or OWE hidden networks
reply to these before unregistering the network.
---
 src/network.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/network.c b/src/network.c
index 711fb296..7240b029 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1745,6 +1745,14 @@ static void network_unregister(struct network *netwo=
rk, int reason)
 {
 	struct l_dbus *dbus =3D dbus_get_bus();
 =

+	if (network->connect_after_anqp)
+		dbus_pending_reply(&network->connect_after_anqp,
+			dbus_error_aborted(network->connect_after_anqp));
+
+	if (network->connect_after_owe_hidden)
+		dbus_pending_reply(&network->connect_after_owe_hidden,
+			dbus_error_aborted(network->connect_after_owe_hidden));
+
 	agent_request_cancel(network->agent_request, reason);
 	network_settings_close(network);
 =

-- =

2.31.1

--===============3556011963527965978==--

