Content-Type: multipart/mixed; boundary="===============3726351750403318124=="
MIME-Version: 1.0
From: Tim Kourt <tim.a.kourt@linux.intel.com>
Subject: [PATCH] network: Change func. signature
Date: Tue, 09 Jun 2020 18:23:56 -0700
Message-ID: <20200610012356.19703-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3726351750403318124==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Change signature of network_connect_new_hidden_network to take
reference to the caller's l_dbus_message struct. This allows to
set the caller's l_dbus_message struct to NULL after replying in
the case of a failure.

=3D=3D201=3D=3D    at 0x467C15: l_dbus_message_unref (dbus-message.c:412)
=3D=3D201=3D=3D    by 0x412A51: station_hidden_network_scan_results (statio=
n.c:2504)
=3D=3D201=3D=3D    by 0x41EAEA: scan_finished (scan.c:1505)
=3D=3D201=3D=3D    by 0x41EC10: get_scan_done (scan.c:1535)
=3D=3D201=3D=3D    by 0x462592: destroy_request (genl.c:673)
=3D=3D201=3D=3D    by 0x462987: process_unicast (genl.c:988)
=3D=3D201=3D=3D    by 0x462987: received_data (genl.c:1087)
=3D=3D201=3D=3D    by 0x45F5A2: io_callback (io.c:126)
=3D=3D201=3D=3D    by 0x45E8FD: l_main_iterate (main.c:474)
=3D=3D201=3D=3D    by 0x45E9BB: l_main_run (main.c:521)
=3D=3D201=3D=3D    by 0x45EBCA: l_main_run_with_signal (main.c:643)
=3D=3D201=3D=3D    by 0x403B15: main (main.c:512)
---
 src/network.c | 12 ++++++------
 src/network.h |  2 +-
 src/station.c |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/network.c b/src/network.c
index c08d7e72..170db3e5 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1166,7 +1166,7 @@ static struct l_dbus_message *network_connect(struct =
l_dbus *dbus,
 }
 =

 void network_connect_new_hidden_network(struct network *network,
-						struct l_dbus_message *message)
+						struct l_dbus_message **message)
 {
 	struct station *station =3D network->station;
 	struct scan_bss *bss;
@@ -1183,7 +1183,7 @@ void network_connect_new_hidden_network(struct networ=
k *network,
 	bss =3D network_bss_select(network, true);
 	if (!bss) {
 		/* This should never happened for the hidden networks. */
-		error =3D dbus_error_not_supported(message);
+		error =3D dbus_error_not_supported(*message);
 		goto reply_error;
 	}
 =

@@ -1192,13 +1192,13 @@ void network_connect_new_hidden_network(struct netw=
ork *network,
 =

 	switch (network_get_security(network)) {
 	case SECURITY_PSK:
-		error =3D network_connect_psk(network, bss, message);
+		error =3D network_connect_psk(network, bss, *message);
 		break;
 	case SECURITY_NONE:
-		station_connect_network(station, network, bss, message);
+		station_connect_network(station, network, bss, *message);
 		return;
 	default:
-		error =3D dbus_error_not_supported(message);
+		error =3D dbus_error_not_supported(*message);
 		break;
 	}
 =

@@ -1208,7 +1208,7 @@ void network_connect_new_hidden_network(struct networ=
k *network,
 	return;
 =

 reply_error:
-	dbus_pending_reply(&message, error);
+	dbus_pending_reply(message, error);
 }
 =

 void network_blacklist_add(struct network *network, struct scan_bss *bss)
diff --git a/src/network.h b/src/network.h
index 8e0ed636..fbb120a7 100644
--- a/src/network.h
+++ b/src/network.h
@@ -70,7 +70,7 @@ int network_rank_compare(const void *a, const void *b, vo=
id *user);
 void network_rank_update(struct network *network, bool connected);
 =

 void network_connect_new_hidden_network(struct network *network,
-						struct l_dbus_message *message);
+					struct l_dbus_message **message);
 =

 void network_blacklist_add(struct network *network, struct scan_bss *bss);
 =

diff --git a/src/station.c b/src/station.c
index 583016ab..87fadc3f 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2500,7 +2500,7 @@ next:
 =

 	network =3D network_psk ? : network_open;
 =

-	network_connect_new_hidden_network(network, msg);
+	network_connect_new_hidden_network(network, &msg);
 	l_dbus_message_unref(msg);
 =

 	return true;
-- =

2.13.6

--===============3726351750403318124==--

