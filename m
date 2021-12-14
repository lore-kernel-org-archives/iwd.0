Content-Type: multipart/mixed; boundary="===============2836101067757809074=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 09/10] dpp: handle protocol errors in ROC timeout
Date: Tue, 14 Dec 2021 10:12:24 -0800
Message-ID: <20211214181225.2308043-9-prestwoj@gmail.com>
In-Reply-To: 20211214181225.2308043-1-prestwoj@gmail.com

--===============2836101067757809074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a standing TODO of properly handling these timeouts but
for now just treat any ROC timeout as an error if authenticating
or configuring.
---
 src/dpp.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 25cebfd3..a147e8c0 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1117,10 +1117,24 @@ static void dpp_presence_timeout(int error, void *u=
ser_data)
 {
 	struct dpp_sm *dpp =3D user_data;
 =

-	if (dpp->state !=3D DPP_STATE_PRESENCE) {
-		l_debug("DPP state changed, stopping presence announcements");
-		dpp->freqs_idx =3D 0;
+	switch (dpp->state) {
+	case DPP_STATE_PRESENCE:
+		break;
+	case DPP_STATE_NOTHING:
+		/* Protocol already terminated */
 		return;
+	case DPP_STATE_AUTHENTICATING:
+	case DPP_STATE_CONFIGURING:
+		/*
+		 * TODO: If either the auth or config protocol is running we
+		 * need to stay on channel until the specified timeouts.
+		 * Unfortunately the kernel makes this very inconvenient since
+		 * there is no way to stay on channel indefinitely or any way
+		 * of knowing what duration the kernel/card actually chooses.
+		 *
+		 * For now just treat this as a failure.
+		 */
+		goto protocol_failed;
 	}
 =

 	dpp->freqs_idx++;
@@ -1138,6 +1152,12 @@ static void dpp_presence_timeout(int error, void *us=
er_data)
 	dpp->offchannel_id =3D offchannel_start(netdev_get_wdev_id(dpp->netdev),
 			dpp->current_freq, dpp->dwell, dpp_roc_started,
 			dpp, dpp_presence_timeout);
+	return;
+
+protocol_failed:
+	dpp_reset(dpp);
+	dpp_free_auth_data(dpp);
+	return;
 }
 =

 /*
-- =

2.31.1

--===============2836101067757809074==--

