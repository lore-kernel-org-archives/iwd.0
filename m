Content-Type: multipart/mixed; boundary="===============3570896842349936503=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 3/5] network: Check if network busy before new connection
Date: Thu, 08 Oct 2020 10:49:09 +0200
Message-ID: <20201008084911.1046485-3-andrew.zaborowski@intel.com>
In-Reply-To: <20201008084911.1046485-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3570896842349936503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Check if we have an ongoing agent call before starting a new connection
attempt and potentially overwriting network->agent_request.
---
 src/network.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/network.c b/src/network.c
index 3e856aa1..388bc17a 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1146,6 +1146,9 @@ static struct l_dbus_message *network_connect(struct =
l_dbus *dbus,
 		 */
 		return l_dbus_message_new_method_return(message);
 =

+	if (network->agent_request)
+		return dbus_error_busy(message);
+
 	/*
 	 * Select the best BSS to use at this time.  If we have to query the
 	 * agent this may not be the final choice because BSS visibility can
@@ -1198,6 +1201,11 @@ void network_connect_new_hidden_network(struct netwo=
rk *network,
 =

 	l_debug("");
 =

+	if (network->agent_request) {
+		error =3D dbus_error_busy(*message);
+		goto reply_error;
+	}
+
 	/*
 	 * This is not a Known Network.  If connection succeeds, either
 	 * network_sync_psk or network_connected will save this network
-- =

2.25.1

--===============3570896842349936503==--

