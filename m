Content-Type: multipart/mixed; boundary="===============8169410425459430545=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v5 4/4] dpp: handle protocol errors in ROC timeout
Date: Fri, 17 Dec 2021 11:14:51 -0800
Message-ID: <20211217191451.179444-4-prestwoj@gmail.com>
In-Reply-To: 20211217191451.179444-1-prestwoj@gmail.com

--===============8169410425459430545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a standing TODO of properly handling these timeouts but
for now just treat any ROC timeout as an error if authenticating
or configuring.
---
 src/dpp.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index cf322e7d..f86ea6bd 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1070,10 +1070,34 @@ static void dpp_presence_timeout(int error, void *u=
ser_data)
 {
 	struct dpp_sm *dpp =3D user_data;
 =

-	if (dpp->state !=3D DPP_STATE_PRESENCE) {
-		l_debug("DPP state changed, stopping presence announcements");
-		dpp->freqs_idx =3D 0;
+	/*
+	 * If cancelled this is likely due to netdev going down or from Stop().
+	 * Otherwise there was some other problem which is probably not
+	 * recoverable.
+	 */
+	if (error =3D=3D -ECANCELED)
 		return;
+	else if (error < 0)
+		goto protocol_failed;
+
+	switch (dpp->state) {
+	case DPP_STATE_PRESENCE:
+		break;
+	case DPP_STATE_NOTHING:
+		/* Protocol already terminated */
+		return;
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
@@ -1091,6 +1115,12 @@ static void dpp_presence_timeout(int error, void *us=
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

--===============8169410425459430545==--

