Content-Type: multipart/mixed; boundary="===============8403026193638314952=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <alvin@pqrs.dk>
Subject: [PATCH 2/3] netdev: add a channel switch event
Date: Thu, 27 May 2021 16:22:28 +0200
Message-ID: <20210527142229.1213074-2-alvin@pqrs.dk>
In-Reply-To: <20210527142229.1213074-1-alvin@pqrs.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8403026193638314952==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>

If the connected BSS announces that it is switching operating channel,
the kernel may emit the NL80211_CMD_CH_SWTICH_NOTIFY event when the
switch is complete. Add a new netdev event NETDEV_EVENT_CHANNEL_SWITCHED
to signal to interested modules that the connected BSS has changed
channel. The event carries a pointer to the new channel's frequency.
---
 src/netdev.c | 38 ++++++++++++++++++++++++++++++++++++++
 src/netdev.h |  1 +
 2 files changed, 39 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 9a2afe1d18be..8430a331249c 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4536,6 +4536,41 @@ failed:
 =

 }
 =

+static void netdev_channel_switch_event(struct l_genl_msg *msg,
+					struct netdev *netdev)
+{
+	struct l_genl_attr attr;
+	uint16_t type, len;
+	const void *data;
+	uint32_t *freq=3D NULL;
+
+	l_debug("");
+
+	if (!l_genl_attr_init(&attr, msg))
+		return;
+
+	while (l_genl_attr_next(&attr, &type, &len, &data)) {
+		switch (type) {
+		case NL80211_ATTR_WIPHY_FREQ:
+			if (len !=3D 4)
+				continue;
+
+			freq =3D (uint32_t *) data;
+			break;
+		}
+	}
+
+	if (!freq)
+		return;
+
+	l_debug("Channel switch event, frequency: %u", *freq);
+
+	if (netdev->event_filter) {
+		netdev->event_filter(netdev, NETDEV_EVENT_CHANNEL_SWITCHED, freq,
+					netdev->user_data);
+	}
+}
+
 static void netdev_mlme_notify(struct l_genl_msg *msg, void *user_data)
 {
 	struct netdev *netdev =3D NULL;
@@ -4561,6 +4596,9 @@ static void netdev_mlme_notify(struct l_genl_msg *msg=
, void *user_data)
 	case NL80211_CMD_ROAM:
 		netdev_roam_event(msg, netdev);
 		break;
+	case NL80211_CMD_CH_SWITCH_NOTIFY:
+		netdev_channel_switch_event(msg, netdev);
+		break;
 	case NL80211_CMD_CONNECT:
 		netdev_connect_event(msg, netdev);
 		break;
diff --git a/src/netdev.h b/src/netdev.h
index f625957bb760..ee944bceef8a 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -43,6 +43,7 @@ enum netdev_event {
 	NETDEV_EVENT_ASSOCIATING,
 	NETDEV_EVENT_ROAMING,
 	NETDEV_EVENT_ROAMED,
+	NETDEV_EVENT_CHANNEL_SWITCHED,
 	NETDEV_EVENT_DISCONNECT_BY_AP,
 	NETDEV_EVENT_DISCONNECT_BY_SME,
 	NETDEV_EVENT_RSSI_THRESHOLD_LOW,
-- =

2.31.1

--===============8403026193638314952==--

