Content-Type: multipart/mixed; boundary="===============5076509744310452890=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH] netdev: add SA Query delay with OCV enabled
Date: Tue, 26 Oct 2021 15:24:27 -0700
Message-ID: <20211026222427.1264435-1-prestwoj@gmail.com>

--===============5076509744310452890==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The way a SA Query was done following a channel switch was slightly
incorrect. One because it is only needed when OCVC is set, and two
because IWD was not waiting a random delay between 0 and 5000us as
lined out by the spec. This patch fixes both these issues.
---
 src/netdev.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index c6618546..96e473a9 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -142,6 +142,7 @@ struct netdev {
 	uint16_t last_code; /* reason or status, depending on result */
 	struct l_timeout *neighbor_report_timeout;
 	struct l_timeout *sa_query_timeout;
+	struct l_timeout *sa_query_delay;
 	struct l_timeout *group_handshake_timeout;
 	uint16_t sa_query_id;
 	uint8_t prev_snonce[32];
@@ -797,6 +798,11 @@ static void netdev_connect_free(struct netdev *netdev)
 		netdev->sa_query_timeout =3D NULL;
 	}
 =

+	if (netdev->sa_query_delay) {
+		l_timeout_remove(netdev->sa_query_delay);
+		netdev->sa_query_delay =3D NULL;
+	}
+
 	if (netdev->group_handshake_timeout) {
 		l_timeout_remove(netdev->group_handshake_timeout);
 		netdev->group_handshake_timeout =3D NULL;
@@ -5351,6 +5357,17 @@ failed:
 =

 }
 =

+static void netdev_send_sa_query_delay(struct l_timeout *timeout,
+					void *user_data)
+{
+	struct netdev *netdev =3D user_data;
+
+	netdev_send_sa_query_request(netdev);
+
+	l_timeout_remove(netdev->sa_query_delay);
+	netdev->sa_query_delay =3D NULL;
+}
+
 static void netdev_channel_switch_event(struct l_genl_msg *msg,
 					struct netdev *netdev)
 {
@@ -5368,7 +5385,20 @@ static void netdev_channel_switch_event(struct l_gen=
l_msg *msg,
 =

 	handshake_state_set_chandef(netdev->handshake, l_steal_ptr(chandef));
 =

-	netdev_send_sa_query_request(netdev);
+	/*
+	 * IEEE 802.11-2020 11.9.3.2
+	 * "If the STA chooses to perform the specified switch and
+	 * dot11RSNAOperatingChannelValidationActivated is true and the AP has
+	 * indicated OCVC capability, after switching to the new channel the STA
+	 * shall wait a random delay uniformly-distributed in the range between
+	 * zero and 5000us, and then initiate the SA query procedure"
+	 */
+	if (netdev->handshake->supplicant_ocvc &&
+					netdev->handshake->authenticator_ocvc)
+		netdev->sa_query_delay =3D l_timeout_create_ms(
+						l_getrandom_uint32() % 5,
+						netdev_send_sa_query_delay,
+						netdev, NULL);
 =

 	if (!netdev->event_filter)
 		return;
-- =

2.31.1

--===============5076509744310452890==--

