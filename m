Content-Type: multipart/mixed; boundary="===============1125164168494273134=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] netdev: fix asymmetry in handshake events
Date: Mon, 04 Jan 2021 15:32:57 -0800
Message-ID: <20210104233257.21793-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1125164168494273134==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A failed/timed out handshake can sometimes result in no
HANDSHAKE_EVENT_FAILED event. This is because if IWD receives
a deauth before the eapol timeout expires the handshake is
cleaned up without any error being signaled. This ends up being
ok because netdev has its own handshake failed event associated
with the connect attempt which station/others handle
appropriately.

The issue lies more with what a handshake event consumer would
expect. Not receiving a failed event in the case of a failure
is unexpected. Future changes will rely on symmetry of these
events so it is being fixed now.

This case can be detected inside the netdev death event handler
by checking if last_code was ever set. If last_code is zero,
and netdev is not operational we have hit this situation and
netdev needs to manually trigger HANDSHAKE_EVENT_FAILED.
---
 src/netdev.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index bf35b1ee..ebbcbbbc 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -869,6 +869,24 @@ static void netdev_disconnect_event(struct l_genl_msg =
*msg,
 	l_info("Received Deauthentication event, reason: %hu, from_ap: %s",
 			reason_code, disconnect_by_ap ? "true" : "false");
 =

+	/*
+	 * In some cases of a failed handshake the AP will send a deauth before
+	 * IWD's eapol timer expires. This causes asymmetry in the handshake
+	 * started/failed events because the eapol timer would get cleaned up by
+	 * netdev_connect_free below and no failed event would be sent. We can
+	 * detect this because last_code is only set via netdev_handshake_failed
+	 * which indicates the handshake failed event DID fire. If no failed
+	 * event fired, and netdev is not operational, something went wrong in
+	 * the handshake and this deauth event is the AP rejecting it. In this
+	 * case signal the failed event which will ultimately clean up the
+	 * connection via netdev_handshake_failed.
+	 */
+	if (!netdev->operational && !netdev->last_code) {
+		handshake_event(netdev->handshake, HANDSHAKE_EVENT_FAILED,
+				reason_code);
+		return;
+	}
+
 	event_filter =3D netdev->event_filter;
 	event_data =3D netdev->user_data;
 	netdev_connect_free(netdev);
-- =

2.26.2

--===============1125164168494273134==--

