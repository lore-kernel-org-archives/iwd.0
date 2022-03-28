Content-Type: multipart/mixed; boundary="===============6544547950250077790=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v4 11/13] dpp: fail if disconnected during DPP protocol
Date: Mon, 28 Mar 2022 10:28:40 -0700
Message-ID: <20220328172842.1660272-12-prestwoj@gmail.com>
In-Reply-To: 20220328172842.1660272-1-prestwoj@gmail.com

--===============6544547950250077790==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If the connected BSS is NULL IWD was disconnected and this should
trigger a protocol termination.
---
 src/dpp.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index f2421b69..de8e6e14 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1294,7 +1294,7 @@ static void dpp_presence_announce(struct dpp_sm *dpp)
 	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
 }
 =

-static void dpp_send_authenticate_request(struct dpp_sm *dpp)
+static bool dpp_send_authenticate_request(struct dpp_sm *dpp)
 {
 	uint8_t hdr[32];
 	uint8_t attrs[256];
@@ -1305,6 +1305,12 @@ static void dpp_send_authenticate_request(struct dpp=
_sm *dpp)
 	struct station *station =3D station_find(netdev_get_ifindex(dpp->netdev));
 	struct scan_bss *bss =3D station_get_connected_bss(station);
 =

+	/* Got disconnected by the time the peer was discovered */
+	if (!bss) {
+		dpp_reset(dpp);
+		return false;
+	}
+
 	l_ecc_point_get_data(dpp->own_proto_public, i_proto_key,
 				sizeof(i_proto_key));
 =

@@ -1337,6 +1343,8 @@ static void dpp_send_authenticate_request(struct dpp_=
sm *dpp)
 	iov[1].iov_len =3D ptr - attrs;
 =

 	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
+
+	return true;
 }
 =

 static void dpp_roc_started(void *user_data)
@@ -1948,7 +1956,8 @@ static void dpp_handle_presence_announcement(struct d=
pp_sm *dpp,
 =

 	dpp->state =3D DPP_STATE_AUTHENTICATING;
 =

-	dpp_send_authenticate_request(dpp);
+	if (!dpp_send_authenticate_request(dpp))
+		return;
 =

 	/*
 	 * Should we wait for an ACK then go offchannel?
-- =

2.34.1

--===============6544547950250077790==--

