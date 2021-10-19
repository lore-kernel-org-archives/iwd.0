Content-Type: multipart/mixed; boundary="===============0781161799099151949=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 5/8] nl80211cmd: make CH_SWITCH_STARTED_NOTIFY name unique
Date: Tue, 19 Oct 2021 11:19:07 -0700
Message-ID: <20211019181910.558043-5-prestwoj@gmail.com>
In-Reply-To: 20211019181910.558043-1-prestwoj@gmail.com

--===============0781161799099151949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There are several events for channel switching, and nl80211cmd was
naming two of them "Channel Switch Notify". Change
CH_SWITCH_STARTED_NOTIFY to "Channel Switch Started Notify" to
distinguish the two events.
---
 src/nl80211cmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/nl80211cmd.c b/src/nl80211cmd.c
index 3096af0f..065d52af 100644
--- a/src/nl80211cmd.c
+++ b/src/nl80211cmd.c
@@ -142,7 +142,8 @@ static const struct {
 	{ NL80211_CMD_GET_MPP,			"Get Mesh Proxy Path"	},
 	{ NL80211_CMD_JOIN_OCB,			"Join OCB Network"	},
 	{ NL80211_CMD_LEAVE_OCB,		"Leave OCB Network"	},
-	{ NL80211_CMD_CH_SWITCH_STARTED_NOTIFY, "Channel Switch Notify"	},
+	{ NL80211_CMD_CH_SWITCH_STARTED_NOTIFY,
+					"Channel Switch Started Notify"},
 	{ NL80211_CMD_TDLS_CHANNEL_SWITCH,	"TDLS Channel Switch"	},
 	{ NL80211_CMD_TDLS_CANCEL_CHANNEL_SWITCH,
 						"Cancel TLDS Channel Switch" },
-- =

2.31.1

--===============0781161799099151949==--

