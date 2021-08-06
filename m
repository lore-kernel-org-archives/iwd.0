Content-Type: multipart/mixed; boundary="===============5020467204175370101=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/5] network: add __network_connect
Date: Fri, 06 Aug 2021 16:02:09 -0700
Message-ID: <20210806230212.381657-2-prestwoj@gmail.com>
In-Reply-To: <20210806230212.381657-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5020467204175370101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is to support the ConnectBssid developer method which
bypasses the BSS selection logic in order to force a connection
to a specific BSS.
---
 src/network.c | 63 +++++++++++++++++++++++++++++----------------------
 src/network.h |  4 ++++
 2 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/src/network.c b/src/network.c
index 4f3855e8..e160d788 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1497,35 +1497,11 @@ error:
 	return reply;
 }
 =

-static struct l_dbus_message *network_connect(struct l_dbus *dbus,
-						struct l_dbus_message *message,
-						void *user_data)
+struct l_dbus_message *__network_connect(struct network *network,
+						struct scan_bss *bss,
+						struct l_dbus_message *message)
 {
-	struct network *network =3D user_data;
 	struct station *station =3D network->station;
-	struct scan_bss *bss;
-
-	l_debug("");
-
-	if (network =3D=3D station_get_connected_network(station))
-		/*
-		 * The requested network is already connected, return success.
-		 */
-		return l_dbus_message_new_method_return(message);
-
-	if (network->agent_request)
-		return dbus_error_busy(message);
-
-	/*
-	 * Select the best BSS to use at this time.  If we have to query the
-	 * agent this may not be the final choice because BSS visibility can
-	 * change while we wait for the agent.
-	 */
-	bss =3D network_bss_select(network, true);
-
-	/* None of the BSSes is compatible with our stack */
-	if (!bss)
-		return dbus_error_not_supported(message);
 =

 	switch (network_get_security(network)) {
 	case SECURITY_PSK:
@@ -1559,6 +1535,39 @@ static struct l_dbus_message *network_connect(struct=
 l_dbus *dbus,
 	}
 }
 =

+static struct l_dbus_message *network_connect(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct network *network =3D user_data;
+	struct station *station =3D network->station;
+	struct scan_bss *bss;
+
+	l_debug("");
+
+	if (network =3D=3D station_get_connected_network(station))
+		/*
+		 * The requested network is already connected, return success.
+		 */
+		return l_dbus_message_new_method_return(message);
+
+	if (network->agent_request)
+		return dbus_error_busy(message);
+
+	/*
+	 * Select the best BSS to use at this time.  If we have to query the
+	 * agent this may not be the final choice because BSS visibility can
+	 * change while we wait for the agent.
+	 */
+	bss =3D network_bss_select(network, true);
+
+	/* None of the BSSes is compatible with our stack */
+	if (!bss)
+		return dbus_error_not_supported(message);
+
+	return __network_connect(network, bss, message);
+}
+
 /*
  * Returns an error message in case an error occurs.  Otherwise this funct=
ion
  * returns NULL and takes a reference to message.  Callers should unref
diff --git a/src/network.h b/src/network.h
index 2cca7ffb..0c6cb21a 100644
--- a/src/network.h
+++ b/src/network.h
@@ -92,3 +92,7 @@ struct erp_cache_entry *network_get_erp_cache(struct netw=
ork *network);
 =

 const struct l_queue_entry *network_bss_list_get_entries(
 						struct network *network);
+
+struct l_dbus_message *__network_connect(struct network *network,
+						struct scan_bss *bss,
+						struct l_dbus_message *message);
-- =

2.31.1

--===============5020467204175370101==--

