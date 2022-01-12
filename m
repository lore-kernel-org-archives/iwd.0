Content-Type: multipart/mixed; boundary="===============1508942735540292254=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 03/10] dpp: don't send StartEnrollee reply until offchannel
 starts
Date: Tue, 11 Jan 2022 16:55:51 -0800
Message-ID: <20220112005558.1158405-3-prestwoj@gmail.com>
In-Reply-To: 20220112005558.1158405-1-prestwoj@gmail.com

--===============1508942735540292254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

IWD may be in the middle of some long operation, e.g. scanning.
If the URI is returned before IWD is ready, a configurator could
start sending frames and IWD either wont receive them, or will
be unable to respond quickly.
---
 src/dpp.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 98d2a75c..c10ec978 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -118,6 +118,8 @@ struct dpp_sm {
 =

 	struct dpp_configuration *config;
 	uint32_t connect_scan_id;
+
+	struct l_dbus_message *message;
 };
 =

 static void dpp_free_auth_data(struct dpp_sm *dpp)
@@ -1257,6 +1259,15 @@ static void dpp_roc_started(void *user_data)
 =

 	switch (dpp->state) {
 	case DPP_STATE_PRESENCE:
+		if (dpp->message) {
+			struct l_dbus_message *reply =3D
+				l_dbus_message_new_method_return(dpp->message);
+
+			l_dbus_message_set_arguments(reply, "s", dpp->uri);
+
+			dbus_pending_reply(&dpp->message, reply);
+		}
+
 		dpp_presence_announce(dpp);
 		break;
 	case DPP_STATE_AUTHENTICATING:
@@ -1694,7 +1705,6 @@ static struct l_dbus_message *dpp_dbus_start_enrollee=
(struct l_dbus *dbus,
 {
 	struct dpp_sm *dpp =3D user_data;
 	uint32_t freq =3D band_channel_to_freq(6, BAND_FREQ_2_4_GHZ);
-	struct l_dbus_message *reply;
 	struct station *station =3D station_find(netdev_get_ifindex(dpp->netdev));
 =

 	if (dpp->state !=3D DPP_STATE_NOTHING)
@@ -1720,6 +1730,8 @@ static struct l_dbus_message *dpp_dbus_start_enrollee=
(struct l_dbus *dbus,
 =

 	l_debug("DPP Start Enrollee: %s", dpp->uri);
 =

+	dpp->message =3D l_dbus_message_ref(message);
+
 	/*
 	 * Going off spec here. Select a single channel to send presence
 	 * announcements on. This will be advertised in the URI. The full
@@ -1727,11 +1739,7 @@ static struct l_dbus_message *dpp_dbus_start_enrolle=
e(struct l_dbus *dbus,
 	 */
 	dpp_start_presence(dpp, &freq, 1);
 =

-	reply =3D l_dbus_message_new_method_return(message);
-
-	l_dbus_message_set_arguments(reply, "s", dpp->uri);
-
-	return reply;
+	return NULL;
 }
 =

 static struct l_dbus_message *dpp_dbus_start_configurator(struct l_dbus *d=
bus,
-- =

2.31.1

--===============1508942735540292254==--

