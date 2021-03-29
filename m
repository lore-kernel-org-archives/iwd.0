Content-Type: multipart/mixed; boundary="===============5718884359657290894=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/3] sae: add counter for associate retries
Date: Mon, 29 Mar 2021 13:43:50 -0700
Message-ID: <20210329204351.718429-2-prestwoj@gmail.com>
In-Reply-To: <20210329204351.718429-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5718884359657290894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If there is an associate timeout, retry a few times in case
it was just a fluke. At this point SAE is fully negotiated
so it makes sense to attempt to save the connection.
---
 src/sae.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/src/sae.c b/src/sae.c
index ade5e24c..b6cc0b15 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -37,6 +37,7 @@
 =

 #define SAE_RETRANSMIT_TIMEOUT	2
 #define SAE_SYNC_MAX		3
+#define SAE_MAX_ASSOC_RETRY	3
 =

 enum sae_state {
 	SAE_STATE_NOTHING =3D 0,
@@ -73,6 +74,7 @@ struct sae_sm {
 	uint16_t rc;
 	/* remote peer */
 	uint8_t peer[6];
+	uint8_t assoc_retry;
 =

 	sae_tx_authenticate_func_t tx_auth;
 	sae_tx_associate_func_t tx_assoc;
@@ -670,7 +672,7 @@ static bool sae_send_commit(struct sae_sm *sm, bool ret=
ry)
 	return true;
 }
 =

-static bool sae_timeout(struct auth_proto *ap)
+static bool sae_auth_timeout(struct auth_proto *ap)
 {
 	struct sae_sm *sm =3D l_container_of(ap, struct sae_sm, ap);
 =

@@ -699,6 +701,20 @@ static bool sae_timeout(struct auth_proto *ap)
 	return true;
 }
 =

+static bool sae_assoc_timeout(struct auth_proto *ap)
+{
+	struct sae_sm *sm =3D l_container_of(ap, struct sae_sm, ap);
+
+	if (sm->assoc_retry >=3D SAE_MAX_ASSOC_RETRY)
+		return false;
+
+	sm->assoc_retry++;
+
+	sm->tx_assoc(sm->user_data);
+
+	return true;
+}
+
 /*
  * 802.11-2016 - Section 12.4.8.6.4
  * If the Status code is ANTI_CLOGGING_TOKEN_REQUIRED, a new SAE Commit me=
ssage
@@ -1178,7 +1194,8 @@ struct auth_proto *sae_sm_new(struct handshake_state =
*hs,
 	sm->ap.free =3D sae_free;
 	sm->ap.rx_authenticate =3D sae_rx_authenticate;
 	sm->ap.rx_associate =3D sae_rx_associate;
-	sm->ap.auth_timeout =3D sae_timeout;
+	sm->ap.auth_timeout =3D sae_auth_timeout;
+	sm->ap.assoc_timeout =3D sae_assoc_timeout;
 =

 	return &sm->ap;
 }
-- =

2.26.2

--===============5718884359657290894==--

