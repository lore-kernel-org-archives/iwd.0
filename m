Content-Type: multipart/mixed; boundary="===============3494662089866140682=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v2 5/6] dpp: handle CHANNEL attribute in auth request
Date: Fri, 07 Jan 2022 16:13:32 -0800
Message-ID: <20220108001333.723634-5-prestwoj@gmail.com>
In-Reply-To: 20220108001333.723634-1-prestwoj@gmail.com

--===============3494662089866140682==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When this attribute is included, the initiator is requesting all
future frames be sent on this channel. There is no reason for a
configurator to act on this attribute (at least for now) so the
request frame will be dropped in this case. Enrollees will act
on it by switching to the new channel and sending the authentication
response.
---
 src/dpp.c | 77 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 19 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 5bf004d8..35807a8c 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -91,6 +91,7 @@ struct dpp_sm {
 	size_t freqs_idx;
 	uint32_t dwell;
 	uint32_t current_freq;
+	uint32_t new_freq;
 	struct scan_freq_set *presence_list;
 =

 	uint32_t offchannel_id;
@@ -169,6 +170,7 @@ static void dpp_reset(struct dpp_sm *dpp)
 	}
 =

 	dpp->state =3D DPP_STATE_NOTHING;
+	dpp->new_freq =3D 0;
 =

 	explicit_bzero(dpp->r_nonce, dpp->nonce_len);
 	explicit_bzero(dpp->i_nonce, dpp->nonce_len);
@@ -1238,14 +1240,29 @@ static void dpp_roc_started(void *user_data)
 	struct dpp_sm *dpp =3D user_data;
 =

 	/*
-	 * If not in presence procedure or in a configurator role, just stay
-	 * on channel.
+	 * - If a configurator, nothing to do but wait for a request
+	 * - If in the presence state continue sending announcements.
+	 * - If authenticating, and this is a result of a channel switch send
+	 *   the authenticate response now.
 	 */
-	if (dpp->state !=3D DPP_STATE_PRESENCE ||
-			dpp->role =3D=3D DPP_CAPABILITY_CONFIGURATOR)
+	if (dpp->role =3D=3D DPP_CAPABILITY_CONFIGURATOR)
 		return;
 =

-	dpp_presence_announce(dpp);
+	switch (dpp->state) {
+	case DPP_STATE_PRESENCE:
+		dpp_presence_announce(dpp);
+		break;
+	case DPP_STATE_AUTHENTICATING:
+		if (dpp->new_freq) {
+			dpp->current_freq =3D dpp->new_freq;
+			dpp->new_freq =3D 0;
+			send_authenticate_response(dpp);
+		}
+
+		break;
+	default:
+		break;
+	}
 }
 =

 static void dpp_start_offchannel(struct dpp_sm *dpp, uint32_t freq);
@@ -1332,6 +1349,7 @@ static void authenticate_request(struct dpp_sm *dpp, =
const uint8_t *from,
 	uint64_t k1[L_ECC_MAX_DIGITS];
 	const void *ad0 =3D body + 2;
 	const void *ad1 =3D body + 8;
+	uint32_t freq;
 =

 	if (dpp->state !=3D DPP_STATE_PRESENCE)
 		return;
@@ -1371,20 +1389,39 @@ static void authenticate_request(struct dpp_sm *dpp=
, const uint8_t *from,
 			}
 =

 			break;
-		/*
-		 * TODO: Go on this channel for remainder of auth protocol.
-		 *
-		 * "the Responder determines whether it can use the requested
-		 * channel for the following exchanges. If so, it sends the DPP
-		 * Authentication Response frame on that channel. If not, it
-		 * discards the DPP Authentication Request frame without
-		 * replying to it."
-		 *
-		 * For the time being this feature is not being implemented and
-		 * the frame will be dropped.
-		 */
+
 		case DPP_ATTR_CHANNEL:
-			return;
+			if (len !=3D 2)
+				return;
+
+			freq =3D oci_to_frequency(l_get_u8(data),
+						l_get_u8(data + 1));
+
+			if (freq =3D=3D dpp->current_freq)
+				break;
+
+			/*
+			 * Configurators are already connected to a network, so
+			 * to preserve wireless performance the enrollee will
+			 * be required to be on this channel, not a channel it
+			 * requests.
+			 */
+			if (dpp->role =3D=3D DPP_CAPABILITY_CONFIGURATOR)
+				return;
+
+			/*
+			 * Otherwise, as an enrollee, we can jump to whatever
+			 * channel the configurator requests
+			 */
+			dpp->new_freq =3D freq;
+
+			l_debug("Configurator requested a new frequency %u",
+					dpp->new_freq);
+
+			offchannel_cancel(dpp->wdev_id, dpp->offchannel_id);
+			dpp_start_offchannel(dpp, dpp->new_freq);
+
+			break;
 		default:
 			break;
 		}
@@ -1478,7 +1515,9 @@ static void authenticate_request(struct dpp_sm *dpp, =
const uint8_t *from,
 	dpp->state =3D DPP_STATE_AUTHENTICATING;
 	dpp_reset_protocol_timer(dpp);
 =

-	send_authenticate_response(dpp);
+	/* Don't send if the frequency is changing */
+	if (!dpp->new_freq)
+		send_authenticate_response(dpp);
 =

 	return;
 =

-- =

2.31.1

--===============3494662089866140682==--

