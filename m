Content-Type: multipart/mixed; boundary="===============3595888224386567732=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 12/12] dpp: fix dpp_offchannel_start corner cases
Date: Tue, 18 Jan 2022 13:25:12 -0800
Message-ID: <20220118212512.2017977-12-prestwoj@gmail.com>
In-Reply-To: 20220118212512.2017977-1-prestwoj@gmail.com

--===============3595888224386567732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The purpose of this was to have a single utility to both cancel an
existing offchannel operation (if one exists) and start a new one.

The problem was the previous offchannel operation was being canceled
first which opened up the radio work queue to other items. This is
not desireable as, for example, a scan would end up breaking the
DPP protocol most likely.

Starting the new offchannel then canceling is the correct order of
operations but to do this required saving the new ID, canceling, then
setting offchannel_id to the new ID so dpp_presence_timeout wouldn't
overwrite the new ID to zero.

This also removes an explicit call to offchannel_cancel which is
already done by dpp_offchannel_start.
---
 src/dpp.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 80567c1a..ee1497c0 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1422,12 +1422,28 @@ protocol_failed:
 =

 static void dpp_start_offchannel(struct dpp_sm *dpp, uint32_t freq)
 {
+	/*
+	 * This needs to be handled carefully for a few reasons:
+	 *
+	 * First, the next offchannel operation needs to be started prior to
+	 * canceling an existing one. This is so the offchannel work can
+	 * continue uninterrupted without any other work items starting in
+	 * between canceling and starting the next (e.g. if a scan request is
+	 * sitting in the queue).
+	 *
+	 * Second, dpp_presence_timeout resets dpp->offchannel_id to zero which
+	 * is why the new ID is saved and only set to dpp->offchannel_id once
+	 * the previous offchannel work is cancelled (i.e. destroy() has been
+	 * called).
+	 */
+	uint32_t id =3D offchannel_start(netdev_get_wdev_id(dpp->netdev),
+				freq, dpp->dwell, dpp_roc_started,
+				dpp, dpp_presence_timeout);
+
 	if (dpp->offchannel_id)
 		offchannel_cancel(dpp->wdev_id, dpp->offchannel_id);
 =

-	dpp->offchannel_id =3D offchannel_start(netdev_get_wdev_id(dpp->netdev),
-				freq, dpp->dwell, dpp_roc_started,
-				dpp, dpp_presence_timeout);
+	dpp->offchannel_id =3D id;
 }
 =

 static void authenticate_request(struct dpp_sm *dpp, const uint8_t *from,
@@ -1520,7 +1536,6 @@ static void authenticate_request(struct dpp_sm *dpp, =
const uint8_t *from,
 			l_debug("Configurator requested a new frequency %u",
 					dpp->new_freq);
 =

-			offchannel_cancel(dpp->wdev_id, dpp->offchannel_id);
 			dpp_start_offchannel(dpp, dpp->new_freq);
 =

 			break;
-- =

2.31.1

--===============3595888224386567732==--

