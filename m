Content-Type: multipart/mixed; boundary="===============6979773328073743524=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 4/5] netdev: handle non-fatal auth-proto returns
Date: Wed, 08 Sep 2021 14:32:00 -0700
Message-ID: <20210908213201.97115-4-prestwoj@gmail.com>
In-Reply-To: <20210908213201.97115-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6979773328073743524==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds -EBADMSG/-ENOMSG to be handled specially by allowing the
frame to be dropped, similar to 0 or -EAGAIN. The difference though
is that a non-zero authenticate status will result in the kernel
not re-transmitting which ultimately could leave IWD in a connecting
state with no way of leaving. Because of this we handle a non-zero
status for these two returns as a failed connection.

In addition the kernel treats a few special error codes (and the auth
transaction as more context) special for SAE. For this a helper was
added which checks for these conditions.
---
 src/netdev.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

v4:
 * Added helper funtion to handle the special return codes the
   kernel handles. This logic should mirror the kernels check for
   these conditions.

diff --git a/src/netdev.c b/src/netdev.c
index 7909c37e..12de74b2 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2644,6 +2644,30 @@ static void netdev_cmd_ft_reassociate_cb(struct l_ge=
nl_msg *msg,
 	}
 }
 =

+static bool netdev_sae_frame_ok(struct netdev *netdev,
+					const struct mmpdu_authentication *auth)
+{
+	uint16_t status =3D auth->status;
+	uint16_t trans =3D auth->transaction_sequence;
+
+	if (netdev->handshake->akm_suite !=3D IE_RSN_AKM_SUITE_SAE_SHA256)
+		return false;
+
+	/*
+	 * We must copy the kernels logic here to only drop frames slilently
+	 * that will result in an automatic retransmission. The kernel only does
+	 * this for SAE auth frames if the following conditions are met (as seen
+	 * in net/mac80211/mlme.c:ieee80211_rx_mgmt_auth()):
+	 */
+	if (status =3D=3D MMPDU_STATUS_CODE_ANTI_CLOGGING_TOKEN_REQ ||
+			(trans =3D=3D 1 &&
+			(status =3D=3D MMPDU_STATUS_CODE_SAE_HASH_TO_ELEMENT ||
+			status =3D=3D MMPDU_STATUS_CODE_SAE_PK)))
+		return true;
+
+	return false;
+}
+
 static void netdev_authenticate_event(struct l_genl_msg *msg,
 							struct netdev *netdev)
 {
@@ -2717,7 +2741,20 @@ static void netdev_authenticate_event(struct l_genl_=
msg *msg,
 		ret =3D auth_proto_rx_authenticate(netdev->ap, frame, frame_len);
 		if (ret =3D=3D 0 || ret =3D=3D -EAGAIN)
 			return;
-		else if (ret > 0)
+		else if (ret =3D=3D -EBADMSG || ret =3D=3D -ENOMSG) {
+			/*
+			 * Only drop if the status is success. Otherwise
+			 * dropping the message here would prevent the kernel
+			 * from re-transmitting, leaving IWD in this connecting
+			 * state. If this happens the only option is to fail the
+			 * connection here.
+			 */
+			if (status_code =3D=3D 0)
+				return;
+
+			if (netdev_sae_frame_ok(netdev, auth))
+				return;
+		} else if (ret > 0)
 			status_code =3D (uint16_t)ret;
 	}
 =

-- =

2.31.1

--===============6979773328073743524==--

