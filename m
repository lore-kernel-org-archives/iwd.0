Content-Type: multipart/mixed; boundary="===============7589250590900450771=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <alvin@pqrs.dk>
Subject: [PATCH v2] netdev: update the netdev's frequency on channel switch
 events
Date: Thu, 05 Aug 2021 17:40:24 +0200
Message-ID: <20210805154024.3019732-1-alvin@pqrs.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7589250590900450771==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>

While we correctly emit a NETDEV_EVENT_CHANNEL_SWITCHED event from
netdev for other modules to respond to, we fail to actually update the
frequency of the netdev object in question. Since the netdev frequency
is used elsewhere (e.g. to send action frames), it needs updating too.

Fixes: 5eb0b7ca8e04 ("netdev: add a channel switch event")
---
 src/netdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index d7182d64b0e0..2ae76a1eca68 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4710,6 +4710,8 @@ static void netdev_channel_switch_event(struct l_genl=
_msg *msg,
 =

 	l_debug("Channel switch event, frequency: %u", *freq);
 =

+	netdev->frequency =3D *freq;
+
 	if (!netdev->event_filter)
 		return;
 =

-- =

2.32.0

--===============7589250590900450771==--

