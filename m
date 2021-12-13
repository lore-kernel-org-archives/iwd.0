Content-Type: multipart/mixed; boundary="===============7699078659784347050=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 9/9] dpp: handle protocol errors in ROC timeout
Date: Mon, 13 Dec 2021 12:33:32 -0800
Message-ID: <20211213203332.2191003-9-prestwoj@gmail.com>
In-Reply-To: 20211213203332.2191003-1-prestwoj@gmail.com

--===============7699078659784347050==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a standing TODO of properly handling these timeouts but
for now just treat any ROC timeout as an error if authenticating
or configuring.
---
 src/dpp.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/src/dpp.c b/src/dpp.c
index 7e41b41e..e2121915 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1105,6 +1105,26 @@ static void dpp_presence_timeout(int error, void *us=
er_data)
 {
 	struct dpp_sm *dpp =3D user_data;
 =

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
+	}
+
 	if (dpp->state !=3D DPP_STATE_PRESENCE) {
 		l_debug("DPP state changed, stopping presence announcements");
 		dpp->freqs_idx =3D 0;
@@ -1126,6 +1146,12 @@ static void dpp_presence_timeout(int error, void *us=
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

--===============7699078659784347050==--

