Content-Type: multipart/mixed; boundary="===============4228042447904553924=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 5/5] network: Stop autoconnect during agent request or ANQP
Date: Thu, 08 Oct 2020 10:49:11 +0200
Message-ID: <20201008084911.1046485-5-andrew.zaborowski@intel.com>
In-Reply-To: <20201008084911.1046485-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4228042447904553924==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Stop autoconnect whenever we're saving a pending DBus message and resume
when we return the error response.

One event that may be unhandled here is when we cancel the agent request
in network_unregister which may happen when the station interface goes
DOWN or when the network goes out of range and expires.
---
 src/network.c | 14 ++++++++++++--
 src/station.c |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/network.c b/src/network.c
index 388bc17a..08f855d2 100644
--- a/src/network.c
+++ b/src/network.c
@@ -827,6 +827,7 @@ static void passphrase_callback(enum agent_result resul=
t,
 =

 err:
 	network_settings_close(network);
+	station_set_autoconnect(station, true);
 }
 =

 static struct l_dbus_message *network_connect_psk(struct network *network,
@@ -862,6 +863,8 @@ static struct l_dbus_message *network_connect_psk(struc=
t network *network,
 =

 		if (!network->agent_request)
 			return dbus_error_no_agent(message);
+
+		station_set_autoconnect(station, false);
 	} else
 		station_connect_network(station, network, bss, message);
 =

@@ -992,8 +995,10 @@ static bool eap_send_agent_req(struct network *network,
 		break;
 	}
 =

-	if (network->agent_request)
+	if (network->agent_request) {
+		station_set_autoconnect(network->station, false);
 		return true;
+	}
 =

 	eap_secret_request_free(req);
 	return false;
@@ -1071,6 +1076,7 @@ static void eap_secret_done(enum agent_result result,
 	dbus_pending_reply(&message, dbus_error_no_agent(message));
 err:
 	network_settings_close(network);
+	station_set_autoconnect(network->station, true);
 }
 =

 static struct l_dbus_message *network_connect_8021x(struct network *networ=
k,
@@ -1180,6 +1186,7 @@ static struct l_dbus_message *network_connect(struct =
l_dbus *dbus,
 						l_dbus_message_ref(message);
 			l_debug("Pending ANQP request, delaying connect to %s",
 						network->ssid);
+			station_set_autoconnect(station, false);
 			return NULL;
 		}
 =

@@ -1530,6 +1537,7 @@ static void anqp_watch_changed(enum station_anqp_stat=
e state,
 			reply =3D dbus_error_not_configured(
 						network->connect_after_anqp);
 			dbus_pending_reply(&network->connect_after_anqp, reply);
+			station_set_autoconnect(network->station, true);
 			return;
 		}
 =

@@ -1537,8 +1545,10 @@ static void anqp_watch_changed(enum station_anqp_sta=
te state,
 					network_bss_select(network, true),
 					network->connect_after_anqp);
 =

-		if (reply)
+		if (reply) {
 			l_dbus_send(dbus_get_bus(), reply);
+			station_set_autoconnect(network->station, true);
+		}
 =

 		l_dbus_message_unref(network->connect_after_anqp);
 		network->connect_after_anqp =3D NULL;
diff --git a/src/station.c b/src/station.c
index befc4e25..120a11ea 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2520,6 +2520,7 @@ void station_connect_network(struct station *station,=
 struct network *network,
 =

 error:
 	l_dbus_send(dbus, dbus_error_from_errno(err, message));
+	station_set_autoconnect(station, true);
 }
 =

 static void station_hidden_network_scan_triggered(int err, void *user_data)
-- =

2.25.1

--===============4228042447904553924==--

