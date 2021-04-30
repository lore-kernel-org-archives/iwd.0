Content-Type: multipart/mixed; boundary="===============3465441569768789559=="
MIME-Version: 1.0
From: Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH] client: Show WEP networks as unsupported
Date: Fri, 30 Apr 2021 13:42:38 -0400
Message-ID: <20210430174238.1027448-1-sean.anderson@seco.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3465441569768789559==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

WEP networks are not supported by iwd. However, the only indication is the
message "Operation not supported" while trying to connect. It is not clear
enough that this is due to intentional lack of support (as opposed to some
kind of misconfiguration). This patch explicitly lists WEP networks shown
with get-networks as unsupported. Hopefully this will make it clearer for
those of us not as familiar with iwd.

CC: James Prestwood <prestwoj@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>
CC: Denis Kenzior <denkenz@gmail.com>
---
 client/station.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/client/station.c b/client/station.c
index de25d12b..425b10a1 100644
--- a/client/station.c
+++ b/client/station.c
@@ -352,7 +352,7 @@ static void ordered_networks_display(struct l_queue *or=
dered_networks)
 =

 	display_table_header("Available networks", "%s%-*s%-*s%-*s%*s",
 					MARGIN, 2, "", 32, "Network name",
-					10, "Security", 6, "Signal");
+					18, "Security", 6, "Signal");
 =

 	if (!l_queue_length(ordered_networks)) {
 		display("No networks available\n");
@@ -369,13 +369,16 @@ static void ordered_networks_display(struct l_queue *=
ordered_networks)
 		const char *network_name =3D network_get_name(network_i);
 		const char *network_type =3D network_get_type(network_i);
 =

+		if (!strcmp(network_type, "wep"))
+			network_type =3D "wep (unsupported)";
+
 		if (display_signal_as_dbms)
 			dbms =3D l_strdup_printf("%d", network->signal_strength);
 =

 		display("%s%-*s%-*s%-*s%-*s\n", MARGIN, 2,
 			network_is_connected(network_i) ?
 				COLOR_BOLDGRAY "> " COLOR_OFF : "",
-			32, network_name, 10, network_type,
+			32, network_name, 18, network_type,
 			6, display_signal_as_dbms ? dbms :
 				dbms_tostars(network->signal_strength));
 =

-- =

2.25.1

--===============3465441569768789559==--

