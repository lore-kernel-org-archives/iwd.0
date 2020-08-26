Content-Type: multipart/mixed; boundary="===============4725477875727461377=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 2/2] ap: Add an optional client count limit parameter
Date: Wed, 26 Aug 2020 02:18:54 +0200
Message-ID: <20200826001854.502627-2-andrew.zaborowski@intel.com>
In-Reply-To: <20200826001854.502627-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4725477875727461377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add ap_config.max_stations, we'll probably want to set it to 1 for P2P
groups but this setting is also available in Android etc. when doing
tethering.
---
 src/ap.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/ap.h |  1 +
 2 files changed, 65 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index ff8ced18..bae7508f 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -86,6 +86,7 @@ struct sta_state {
 	struct eapol_sm *sm;
 	struct handshake_state *hs;
 	uint32_t gtk_query_cmd_id;
+	struct l_idle *remove_work;
 };
 =

 static uint32_t netdev_watch;
@@ -134,6 +135,9 @@ static void ap_sta_free(void *data)
 	if (sta->hs)
 		handshake_state_free(sta->hs);
 =

+	if (sta->remove_work)
+		l_idle_remove(sta->remove_work);
+
 	l_free(sta);
 }
 =

@@ -421,6 +425,37 @@ static uint32_t ap_send_mgmt_frame(struct ap_state *ap,
 	return id;
 }
 =

+static unsigned int ap_get_sta_count(struct ap_state *ap)
+{
+	const struct l_queue_entry *entry;
+	unsigned int cnt =3D 0;
+
+	for (entry =3D l_queue_get_entries(ap->sta_states); entry;
+			entry =3D entry->next) {
+		struct sta_state *sta =3D entry->data;
+
+		if (sta->rsna)
+			cnt++;
+	}
+
+	return cnt;
+}
+
+static void ap_sta_remove_work(struct l_idle *idle, void *user_data)
+{
+	struct sta_state *sta =3D user_data;
+
+	l_idle_remove(idle);
+	sta->remove_work =3D NULL;
+
+	if (!sta->hs)
+		return;
+
+	netdev_handshake_failed(sta->hs, MMPDU_REASON_CODE_DISASSOC_AP_BUSY);
+	sta->sm =3D NULL;
+	ap_remove_sta(sta);
+}
+
 static void ap_handshake_event(struct handshake_state *hs,
 		enum handshake_event event, void *user_data, ...)
 {
@@ -430,6 +465,28 @@ static void ap_handshake_event(struct handshake_state =
*hs,
 	va_start(args, user_data);
 =

 	switch (event) {
+	case HANDSHAKE_EVENT_SETTING_KEYS:
+		/*
+		 * config->max_stations limits the number of fully connected
+		 * STAs, i.e. the clients who have the credentials, so that
+		 * those that don't have them can't keep the legit ones from
+		 * connecting.  We've checked that we're below the limit when
+		 * processing the Authentication frame, just so that we don't
+		 * start a new handshake knowing that we can't accept another
+		 * STA, but the definitive check is here just before
+		 * authorizing the STA.
+		 */
+		if (sta->ap->config->max_stations &&
+				ap_get_sta_count(sta->ap) >=3D
+				sta->ap->config->max_stations) {
+			l_debug("STA over max_stations limit being removed "
+				"after successfull handshake");
+			sta->remove_work =3D l_idle_create(ap_sta_remove_work,
+								sta, NULL);
+			return;
+		}
+
+		break;
 	case HANDSHAKE_EVENT_COMPLETE:
 		ap_new_rsna(sta);
 		break;
@@ -1311,6 +1368,13 @@ static void ap_auth_cb(const struct mmpdu_header *hd=
r, const void *body,
 	if (sta)
 		goto done;
 =

+	if (ap->config->max_stations &&
+			ap_get_sta_count(ap) >=3D ap->config->max_stations) {
+		l_debug("STA rejected because we're at max_station");
+		ap_auth_reply(ap, from, MMPDU_REASON_CODE_DISASSOC_AP_BUSY);
+		return;
+	}
+
 	/*
 	 * Per 12.3.3.2.3 with Open System the state change is immediate,
 	 * no waiting for the response to be ACKed as with the association
diff --git a/src/ap.h b/src/ap.h
index 3ca9467f..ebd84864 100644
--- a/src/ap.h
+++ b/src/ap.h
@@ -59,6 +59,7 @@ struct ap_config {
 	char *psk;
 	uint8_t channel;
 	uint8_t **authorized_macs;
+	unsigned int max_stations;
 	bool no_cck_rates : 1;
 };
 =

-- =

2.25.1

--===============4725477875727461377==--

