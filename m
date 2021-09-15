Content-Type: multipart/mixed; boundary="===============6274747308194091945=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 10/13] network: support connect during OWE hidden scan
Date: Wed, 15 Sep 2021 10:36:21 -0700
Message-ID: <20210915173624.11917-10-prestwoj@gmail.com>
In-Reply-To: 20210915173624.11917-1-prestwoj@gmail.com

--===============6274747308194091945==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Similar to ANQP a connect call could come in while station is
scanning for OWE hidden networks. This is supported in the same
manor by saving away the dbus message and resuming the connection
after the hidden OWE scan.
---
 src/network.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/src/network.c b/src/network.c
index d985f811..48314a05 100644
--- a/src/network.c
+++ b/src/network.c
@@ -83,11 +83,13 @@ struct network {
 	bool ask_passphrase:1; /* Whether we should force-ask agent */
 	bool is_hs20:1;
 	bool anqp_pending:1;	/* Set if there is a pending ANQP request */
+	bool owe_hidden_pending:1;
 	uint8_t transition_disable; /* Temporary cache until info is set */
 	bool have_transition_disable:1;
 	int rank;
 	/* Holds DBus Connect() message if it comes in before ANQP finishes */
 	struct l_dbus_message *connect_after_anqp;
+	struct l_dbus_message *connect_after_owe_hidden;
 };
 =

 static bool network_settings_load(struct network *network)
@@ -1506,6 +1508,17 @@ struct l_dbus_message *__network_connect(struct netw=
ork *network,
 	case SECURITY_PSK:
 		return network_connect_psk(network, bss, message);
 	case SECURITY_NONE:
+		if (network->connect_after_owe_hidden)
+			return dbus_error_busy(message);
+
+		/* Save message and connect after OWE hidden scan is done */
+		if (network->owe_hidden_pending) {
+			network->connect_after_owe_hidden =3D
+						l_dbus_message_ref(message);
+			l_debug("Pending OWE hidden scan, delaying connect");
+			return NULL;
+		}
+
 		station_connect_network(station, network, bss, message);
 		return NULL;
 	case SECURITY_8021X:
@@ -1901,11 +1914,17 @@ static void known_networks_changed(enum known_netwo=
rks_event event,
 static void event_watch_changed(enum station_event state,
 				struct network *network, void *user_data)
 {
-	network->anqp_pending =3D state =3D=3D STATION_EVENT_ANQP_STARTED;
+	struct l_dbus_message *reply;
 =

-	if (state =3D=3D STATION_EVENT_ANQP_FINISHED &&
-						network->connect_after_anqp) {
-		struct l_dbus_message *reply;
+	switch (state) {
+	case STATION_EVENT_ANQP_STARTED:
+		network->anqp_pending =3D true;
+		break;
+	case STATION_EVENT_ANQP_FINISHED:
+		network->anqp_pending =3D false;
+
+		if (!network->connect_after_anqp)
+			return;
 =

 		l_debug("ANQP complete, resuming connect to %s", network->ssid);
 =

@@ -1925,6 +1944,27 @@ static void event_watch_changed(enum station_event s=
tate,
 =

 		l_dbus_message_unref(network->connect_after_anqp);
 		network->connect_after_anqp =3D NULL;
+
+		break;
+	case STATION_EVENT_OWE_HIDDEN_STARTED:
+		network->owe_hidden_pending =3D true;
+		break;
+	case STATION_EVENT_OWE_HIDDEN_FINISHED:
+		network->owe_hidden_pending =3D false;
+
+		if (!network->connect_after_owe_hidden)
+			return;
+
+		reply =3D __network_connect(network,
+					network_bss_select(network, true),
+					network->connect_after_owe_hidden);
+		if (reply)
+			l_dbus_send(dbus_get_bus(), reply);
+
+		l_dbus_message_unref(network->connect_after_owe_hidden);
+		network->connect_after_owe_hidden =3D NULL;
+
+		break;
 	}
 }
 =

-- =

2.31.1

--===============6274747308194091945==--

