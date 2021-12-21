Content-Type: multipart/mixed; boundary="===============7651720291239649140=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 1/6] dpp: add timeout for auth/config protocols
Date: Mon, 20 Dec 2021 16:07:42 -0800
Message-ID: <20211221000747.56696-1-prestwoj@gmail.com>

--===============7651720291239649140==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This also allows the card to re-issue ROC if it ends in the middle of
authenticating or configuring as well as add a maximum timeout for
auth/config protocols.

IO errors were also handled as these sometimes can happen with
certain drivers but are not fatal.
---
 src/dpp.c | 48 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 10 deletions(-)

v2:
 * Moved timeout cleanup into this patch

diff --git a/src/dpp.c b/src/dpp.c
index 69dbeb1e..8288aa6c 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -98,6 +98,9 @@ struct dpp_sm {
 	struct l_ecc_point *i_proto_public;
 =

 	uint8_t diag_token;
+
+	/* Timeout of either auth/config protocol */
+	struct l_timeout *timeout;
 };
 =

 static void dpp_free_auth_data(struct dpp_sm *dpp)
@@ -135,6 +138,11 @@ static void dpp_reset(struct dpp_sm *dpp)
 		dpp->offchannel_id =3D 0;
 	}
 =

+	if (dpp->timeout) {
+		l_timeout_remove(dpp->timeout);
+		dpp->timeout =3D NULL;
+	}
+
 	dpp->state =3D DPP_STATE_NOTHING;
 =

 	dpp_free_auth_data(dpp);
@@ -239,6 +247,24 @@ static size_t dpp_build_config_header(const uint8_t *s=
rc, const uint8_t *dest,
 	return ptr - buf;
 }
 =

+static void dpp_protocol_timeout(struct l_timeout *timeout, void *user_dat=
a)
+{
+	struct dpp_sm *dpp =3D user_data;
+
+	l_debug("DPP timed out");
+
+	dpp_reset(dpp);
+}
+
+static void dpp_reset_protocol_timer(struct dpp_sm *dpp)
+{
+	if (dpp->timeout)
+		l_timeout_modify(dpp->timeout, 10);
+	else
+		dpp->timeout =3D l_timeout_create(10, dpp_protocol_timeout,
+						dpp, NULL);
+}
+
 /*
  * The configuration protocols use of AD components is somewhat confusing
  * since the request/response frames are of a different format than the re=
st.
@@ -733,6 +759,7 @@ static void authenticate_confirm(struct dpp_sm *dpp, co=
nst uint8_t *from,
 =

 	l_debug("Authentication successful");
 =

+	dpp_reset_protocol_timer(dpp);
 	dpp_configuration_start(dpp, from);
 =

 	return;
@@ -941,6 +968,7 @@ static void authenticate_request(struct dpp_sm *dpp, co=
nst uint8_t *from,
 	memcpy(dpp->auth_addr, from, 6);
 =

 	dpp->state =3D DPP_STATE_AUTHENTICATING;
+	dpp_reset_protocol_timer(dpp);
 =

 	send_authenticate_response(dpp, r_auth);
 =

@@ -1013,6 +1041,12 @@ static void dpp_roc_started(void *user_data)
 {
 	struct dpp_sm *dpp =3D user_data;
 =

+	/*
+	 * If not in presence procedure, just stay on channel.
+	 */
+	if (dpp->state !=3D DPP_STATE_PRESENCE)
+		return;
+
 	dpp_presence_announce(dpp);
 }
 =

@@ -1082,6 +1116,8 @@ static void dpp_presence_timeout(int error, void *use=
r_data)
 	 */
 	if (error =3D=3D -ECANCELED)
 		return;
+	else if (error =3D=3D -EIO)
+		goto next_roc;
 	else if (error < 0)
 		goto protocol_failed;
 =

@@ -1093,16 +1129,7 @@ static void dpp_presence_timeout(int error, void *us=
er_data)
 		return;
 	case DPP_STATE_AUTHENTICATING:
 	case DPP_STATE_CONFIGURING:
-		/*
-		 * TODO: If either the auth or config protocol is running we
-		 * need to stay on channel until the specified timeouts.
-		 * Unfortunately the kernel makes this very inconvenient since
-		 * there is no way to stay on channel indefinitely or any way
-		 * of knowing what duration the kernel/card actually chooses.
-		 *
-		 * For now just treat this as a failure.
-		 */
-		goto protocol_failed;
+		goto next_roc;
 	}
 =

 	dpp->freqs_idx++;
@@ -1117,6 +1144,7 @@ static void dpp_presence_timeout(int error, void *use=
r_data)
 	l_debug("Presence timeout, moving to next frequency %u, duration %u",
 			dpp->current_freq, dpp->dwell);
 =

+next_roc:
 	dpp->offchannel_id =3D offchannel_start(netdev_get_wdev_id(dpp->netdev),
 			dpp->current_freq, dpp->dwell, dpp_roc_started,
 			dpp, dpp_presence_timeout);
-- =

2.31.1

--===============7651720291239649140==--

