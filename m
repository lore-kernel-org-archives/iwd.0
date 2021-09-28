Content-Type: multipart/mixed; boundary="===============0879824321800765417=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 1/9] fils: support OCI in reassociation
Date: Tue, 28 Sep 2021 14:27:36 -0700
Message-ID: <20210928212744.717276-1-prestwoj@gmail.com>

--===============0879824321800765417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/fils.c   | 35 +++++++++++++++++++++++++++++++++--
 src/fils.h   |  2 ++
 src/netdev.c |  1 +
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/src/fils.c b/src/fils.c
index f661f1bf..c05281bb 100644
--- a/src/fils.c
+++ b/src/fils.c
@@ -37,6 +37,7 @@
 #include "src/missing.h"
 #include "src/erp.h"
 #include "src/auth-proto.h"
+#include "src/band.h"
 =

 #define FILS_NONCE_LEN		16
 #define FILS_SESSION_LEN	8
@@ -49,6 +50,7 @@ struct fils_sm {
 =

 	fils_tx_authenticate_func_t auth;
 	fils_tx_associate_func_t assoc;
+	fils_get_oci_func_t get_oci;
 =

 	uint8_t nonce[FILS_NONCE_LEN];
 	uint8_t anonce[FILS_NONCE_LEN];
@@ -148,12 +150,13 @@ static int fils_derive_key_data(struct fils_sm *fils)
 	uint8_t data[44];
 	uint8_t *ptr =3D data;
 	size_t hash_len;
-	struct iovec iov[4];
+	struct iovec iov[5];
 	size_t iov_elems =3D 0;
 	size_t fils_ft_len =3D 0;
 	bool sha384;
 	size_t ie_len;
 	uint8_t *rsne =3D NULL;
+	uint8_t oci[6];
 =

 	rmsk =3D erp_get_rmsk(fils->erp, &rmsk_len);
 =

@@ -302,6 +305,23 @@ static int fils_derive_key_data(struct fils_sm *fils)
 		iov_elems +=3D 1;
 	}
 =

+	/*
+	 * IEEE 802.11 Section 12.11.2.6.2
+	 * "If dot11RSNAOperatingChannelValidationActivated is true and AP
+	 * indicates OCVC capability, the STA shall include OCI element in the
+	 * request"
+	 */
+	if (fils->hs->supplicant_ocvc && fils->hs->chandef) {
+		oci[0] =3D IE_TYPE_EXTENSION;
+		oci[1] =3D 4;
+		oci[2] =3D IE_TYPE_OCI & 0xff;
+		oci_from_chandef(fils->hs->chandef, oci + 3);
+
+		iov[iov_elems].iov_base =3D oci;
+		iov[iov_elems].iov_len =3D 6;
+		iov_elems++;
+	}
+
 	memcpy(data, fils->nonce, sizeof(fils->nonce));
 	memcpy(data + sizeof(fils->nonce), fils->anonce, sizeof(fils->anonce));
 =

@@ -436,12 +456,20 @@ static int fils_rx_authenticate(struct auth_proto *dr=
iver, const uint8_t *frame,
 	if (erp_rx_packet(fils->erp, wrapped, wrapped_len) < 0)
 		goto invalid_ies;
 =

-	return fils_derive_key_data(fils);
+	return fils->get_oci(fils->user_data);
+
 =

 invalid_ies:
 	return MMPDU_STATUS_CODE_INVALID_ELEMENT;
 }
 =

+static int fils_rx_oci(struct auth_proto *driver)
+{
+	struct fils_sm *fils =3D l_container_of(driver, struct fils_sm, ap);
+
+	return fils_derive_key_data(fils);
+}
+
 static int fils_rx_associate(struct auth_proto *driver, const uint8_t *fra=
me,
 				size_t len)
 {
@@ -564,6 +592,7 @@ invalid_ies:
 struct auth_proto *fils_sm_new(struct handshake_state *hs,
 				fils_tx_authenticate_func_t auth,
 				fils_tx_associate_func_t assoc,
+				fils_get_oci_func_t get_oci,
 				void *user_data)
 {
 	struct fils_sm *fils;
@@ -572,11 +601,13 @@ struct auth_proto *fils_sm_new(struct handshake_state=
 *hs,
 =

 	fils->auth =3D auth;
 	fils->assoc =3D assoc;
+	fils->get_oci =3D get_oci;
 	fils->user_data =3D user_data;
 	fils->hs =3D hs;
 =

 	fils->ap.start =3D fils_start;
 	fils->ap.free =3D fils_free;
+	fils->ap.rx_oci =3D fils_rx_oci;
 	fils->ap.rx_authenticate =3D fils_rx_authenticate;
 	fils->ap.rx_associate =3D fils_rx_associate;
 =

diff --git a/src/fils.h b/src/fils.h
index f9e83d94..3da4ee4e 100644
--- a/src/fils.h
+++ b/src/fils.h
@@ -30,8 +30,10 @@ typedef void (*fils_tx_associate_func_t)(struct iovec *i=
ov, size_t iov_len,
 					const uint8_t *kek, size_t kek_len,
 					const uint8_t *nonces, size_t nonces_len,
 					void *user_data);
+typedef int (*fils_get_oci_func_t)(void *user_data);
 =

 struct auth_proto *fils_sm_new(struct handshake_state *hs,
 				fils_tx_authenticate_func_t auth,
 				fils_tx_associate_func_t assoc,
+				fils_get_oci_func_t get_oci,
 				void *user_data);
diff --git a/src/netdev.c b/src/netdev.c
index 91fffeb3..38598259 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3689,6 +3689,7 @@ static void netdev_connect_common(struct netdev *netd=
ev,
 	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384:
 		netdev->ap =3D fils_sm_new(hs, netdev_fils_tx_authenticate,
 						netdev_fils_tx_associate,
+						netdev_get_oci,
 						netdev);
 		break;
 	default:
-- =

2.31.1

--===============0879824321800765417==--

