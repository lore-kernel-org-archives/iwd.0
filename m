Content-Type: multipart/mixed; boundary="===============0907608184163225514=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 4/6] ap: React to NL80211_CMD_STOP_AP events
Date: Sat, 15 Feb 2020 01:17:46 +0100
Message-ID: <20200215001748.20819-4-andrew.zaborowski@intel.com>
In-Reply-To: <20200215001748.20819-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0907608184163225514==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These events will tell use when our AP gets stopped without our request,
for example due to suspend/resume.
---
 src/ap.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index 569f8572..9c2ce272 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -57,6 +57,7 @@ struct ap_state {
 	struct l_uintset *rates;
 	uint8_t pmk[32];
 	uint32_t start_stop_cmd_id;
+	uint32_t mlme_watch;
 	uint8_t gtk[CRYPTO_MAX_GTK_LEN];
 	uint8_t gtk_index;
 =

@@ -1393,6 +1394,26 @@ static struct l_genl_msg *ap_build_cmd_start_ap(stru=
ct ap_state *ap)
 	return cmd;
 }
 =

+static void ap_mlme_notify(struct l_genl_msg *msg, void *user_data)
+{
+	struct ap_state *ap =3D user_data;
+	uint32_t ifindex;
+
+	if (nl80211_parse_attrs(msg, NL80211_ATTR_IFINDEX, &ifindex,
+				NL80211_ATTR_UNSPEC) < 0 ||
+			ifindex !=3D netdev_get_ifindex(ap->netdev))
+		return;
+
+	switch (l_genl_msg_get_command(msg)) {
+	case NL80211_CMD_STOP_AP:
+		if (ap->start_stop_cmd_id)
+			break;
+
+		ap_reset(ap);
+		break;
+	}
+}
+
 static int ap_start(struct ap_state *ap, const char *ssid, const char *psk,
 		struct l_dbus_message *message)
 {
@@ -1448,6 +1469,11 @@ static int ap_start(struct ap_state *ap, const char =
*ssid, const char *psk,
 				NULL, 0, ap_deauth_cb, ap, NULL))
 		goto error;
 =

+	ap->mlme_watch =3D l_genl_family_register(ap->nl80211, "mlme",
+						ap_mlme_notify, ap, NULL);
+	if (!ap->mlme_watch)
+		l_error("Registering for MLME notification failed");
+
 	cmd =3D ap_build_cmd_start_ap(ap);
 	if (!cmd)
 		goto error;
@@ -1514,6 +1540,9 @@ static int ap_stop(struct ap_state *ap, struct l_dbus=
_message *message)
 	if (ap->start_stop_cmd_id)
 		l_genl_family_cancel(ap->nl80211, ap->start_stop_cmd_id);
 =

+	if (ap->mlme_watch)
+		l_genl_family_unregister(ap->nl80211, ap->mlme_watch);
+
 	ap->start_stop_cmd_id =3D l_genl_family_send(ap->nl80211, cmd, ap_stop_cb,
 							ap, NULL);
 	if (!ap->start_stop_cmd_id) {
-- =

2.20.1

--===============0907608184163225514==--

