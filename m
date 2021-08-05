Content-Type: multipart/mixed; boundary="===============7231278382719359974=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/6] netdev: rename in_ft flag to in_roam
Date: Thu, 05 Aug 2021 08:19:54 -0700
Message-ID: <20210805151958.288829-2-prestwoj@gmail.com>
In-Reply-To: <20210805151958.288829-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7231278382719359974==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The 'in_ft' flag's only purpose now is to ignore disconnect events.
Since disconnect events also occur with reassociations this flag
was renamed to make it more general purpose rather than only
significant for FT roams.
---
 src/netdev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index ff9110ea..eebced05 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -174,7 +174,7 @@ struct netdev {
 	bool operational : 1;
 	bool rekey_offload_support : 1;
 	bool pae_over_nl80211 : 1;
-	bool in_ft : 1;
+	bool in_roam : 1;
 	bool cur_rssi_low : 1;
 	bool use_4addr : 1;
 	bool ignore_connect_event : 1;
@@ -755,7 +755,7 @@ static void netdev_connect_free(struct netdev *netdev)
 	netdev->user_data =3D NULL;
 	netdev->result =3D NETDEV_RESULT_OK;
 	netdev->last_code =3D 0;
-	netdev->in_ft =3D false;
+	netdev->in_roam =3D false;
 	netdev->ignore_connect_event =3D false;
 	netdev->expect_connect_failure =3D false;
 	netdev->cur_rssi_low =3D false;
@@ -1098,7 +1098,7 @@ static void netdev_disconnect_event(struct l_genl_msg=
 *msg,
 	l_debug("");
 =

 	if (!netdev->connected || netdev->disconnect_cmd_id > 0 ||
-			netdev->in_ft)
+			netdev->in_roam)
 		return;
 =

 	if (!l_genl_attr_init(&attr, msg)) {
@@ -2533,7 +2533,7 @@ static void netdev_associate_event(struct l_genl_msg =
*msg,
 				eapol_sm_set_require_handshake(netdev->sm,
 								false);
 =

-			netdev->in_ft =3D false;
+			netdev->in_roam =3D false;
 			netdev->associated =3D true;
 			return;
 		} else if (ret =3D=3D -EAGAIN) {
@@ -3865,7 +3865,7 @@ static void prepare_ft(struct netdev *netdev, struct =
scan_bss *target_bss)
 =

 	netdev->associated =3D false;
 	netdev->operational =3D false;
-	netdev->in_ft =3D true;
+	netdev->in_roam =3D true;
 =

 	/*
 	 * Cancel commands that could be running because of EAPoL activity
-- =

2.31.1

--===============7231278382719359974==--

