Content-Type: multipart/mixed; boundary="===============4691815535584891564=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/4] network: delay connect if ANQP has not completed
Date: Fri, 12 Jun 2020 12:14:12 -0700
Message-ID: <20200612191414.13413-2-prestwoj@gmail.com>
In-Reply-To: <20200612191414.13413-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4691815535584891564==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Using the new station ANQP watch network can delay the connection
request until after ANQP has finished. Since station may be
autoconnecting we must also add a check in network_autoconnect
which prevents it from autoconnecting if we have a pending Connect
request.
---
 src/network.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

v3:
 - Check for agent_request during network_autoconnect rather than
   connect_after_anqp.

diff --git a/src/network.c b/src/network.c
index 170db3e5..c0c6f1b0 100644
--- a/src/network.c
+++ b/src/network.c
@@ -52,6 +52,7 @@
 #include "src/util.h"
 =

 static uint32_t known_networks_watch;
+static uint32_t anqp_watch;
 =

 struct network {
 	char ssid[33];
@@ -72,7 +73,10 @@ struct network {
 	bool update_psk:1;  /* Whether PSK should be written to storage */
 	bool ask_passphrase:1; /* Whether we should force-ask agent */
 	bool is_hs20:1;
+	bool anqp_pending:1;	/* Set if there is a pending ANQP request */
 	int rank;
+	/* Holds DBus Connect() message if it comes in before ANQP finishes */
+	struct l_dbus_message *connect_after_anqp;
 };
 =

 static bool network_settings_load(struct network *network)
@@ -521,6 +525,10 @@ int network_autoconnect(struct network *network, struc=
t scan_bss *bss)
 	bool is_rsn;
 	int ret;
 =

+	/* already waiting for an agent request, connect in progress */
+	if (network->agent_request)
+		return -EALREADY;
+
 	switch (security) {
 	case SECURITY_NONE:
 		is_rsn =3D false;
@@ -1102,6 +1110,9 @@ static struct l_dbus_message *network_connect_8021x(s=
truct network *network,
 			goto error;
 		}
 =

+		/* Unset this since we are now ready to connect */
+		network->connect_after_anqp =3D NULL;
+
 		station_connect_network(station, network, bss, message);
 =

 		return NULL;
@@ -1156,6 +1167,22 @@ static struct l_dbus_message *network_connect(struct=
 l_dbus *dbus,
 		station_connect_network(station, network, bss, message);
 		return NULL;
 	case SECURITY_8021X:
+		if (network->connect_after_anqp)
+			return dbus_error_busy(message);
+
+		/*
+		 * If there is an ongoing ANQP request we must wait for that to
+		 * finish. Save the message and wait for the ANQP watch to
+		 * fire
+		 */
+		if (network->anqp_pending) {
+			network->connect_after_anqp =3D
+						l_dbus_message_ref(message);
+			l_debug("Pending ANQP request, delaying connect to %s",
+						network->ssid);
+			return NULL;
+		}
+
 		if (!network_settings_load(network))
 			return dbus_error_not_configured(message);
 =

@@ -1484,6 +1511,40 @@ static void known_networks_changed(enum known_networ=
ks_event event,
 	}
 }
 =

+static void anqp_watch_changed(enum station_anqp_state state,
+				struct network *network, void *user_data)
+{
+	network->anqp_pending =3D state =3D=3D STATION_ANQP_STARTED;
+
+	if (state =3D=3D STATION_ANQP_FINISHED && network->connect_after_anqp) {
+		struct l_dbus_message *reply;
+
+		l_debug("ANQP complete, resuming connect to %s", network->ssid);
+
+		if (!network_settings_load(network)) {
+			reply =3D dbus_error_not_configured(
+						network->connect_after_anqp);
+			dbus_pending_reply(&network->connect_after_anqp, reply);
+			return;
+		}
+
+		reply =3D network_connect_8021x(network,
+					network_bss_select(network, true),
+					network->connect_after_anqp);
+
+		if (reply)
+			l_dbus_send(dbus_get_bus(), reply);
+
+		/*
+		 * Unref since network_connect_8021x will hold its own ref, but
+		 * don't NULL this yet because agent requests may be required,
+		 * and we still want this network to be in a 'pending' type of
+		 * state so autoconnect doesn't try and connect again.
+		 */
+		l_dbus_message_unref(network->connect_after_anqp);
+	}
+}
+
 static void setup_network_interface(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_method(interface, "Connect", 0,
@@ -1517,6 +1578,8 @@ static int network_init(void)
 	known_networks_watch =3D
 		known_networks_watch_add(known_networks_changed, NULL, NULL);
 =

+	anqp_watch =3D station_add_anqp_watch(anqp_watch_changed, NULL, NULL);
+
 	return 0;
 }
 =

@@ -1525,6 +1588,9 @@ static void network_exit(void)
 	known_networks_watch_remove(known_networks_watch);
 	known_networks_watch =3D 0;
 =

+	station_remove_anqp_watch(anqp_watch);
+	anqp_watch =3D 0;
+
 	l_dbus_unregister_interface(dbus_get_bus(), IWD_NETWORK_INTERFACE);
 }
 =

-- =

2.21.1

--===============4691815535584891564==--

