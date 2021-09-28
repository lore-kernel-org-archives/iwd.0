Content-Type: multipart/mixed; boundary="===============0286842008178870779=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH v3 5/5] eapol: netdev: allow rekeys using FT-FILS
Date: Tue, 28 Sep 2021 15:25:53 -0700
Message-ID: <20210928222553.1096611-5-prestwoj@gmail.com>
In-Reply-To: 20210928222553.1096611-1-prestwoj@gmail.com

--===============0286842008178870779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Rekeying was overlooked when implementing FT-FILS and there were
many places where the AKM was never checked and the rekey was
failing.
---
 src/eapol.c  | 17 ++++++++++++-----
 src/netdev.c |  5 +----
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 3c9581bc..09883645 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -231,6 +231,11 @@ static size_t eapol_get_mic_length(enum ie_rsn_akm_sui=
te akm, size_t pmk_len)
 			l_error("Invalid PMK length of %zu for OWE", pmk_len);
 			return 0;
 		}
+	case IE_RSN_AKM_SUITE_FILS_SHA256:
+	case IE_RSN_AKM_SUITE_FILS_SHA384:
+	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
+	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384:
+		return 0;
 	default:
 		return 16;
 	}
@@ -254,6 +259,8 @@ uint8_t *eapol_decrypt_key_data(enum ie_rsn_akm_suite a=
km, const uint8_t *kek,
 		switch (akm) {
 		case IE_RSN_AKM_SUITE_FILS_SHA256:
 		case IE_RSN_AKM_SUITE_FILS_SHA384:
+		case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
+		case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384:
 			if (key_data_len < 16)
 				return NULL;
 =

@@ -329,13 +336,16 @@ uint8_t *eapol_decrypt_key_data(enum ie_rsn_akm_suite=
 akm, const uint8_t *kek,
 			break;
 		case IE_RSN_AKM_SUITE_FILS_SHA256:
 		case IE_RSN_AKM_SUITE_FILS_SHA384:
+		case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
+		case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384:
 		{
 			struct iovec ad[1];
 =

 			ad[0].iov_base =3D (void *)frame;
 			ad[0].iov_len =3D key_data - (const uint8_t *)frame;
 =

-			if (akm =3D=3D IE_RSN_AKM_SUITE_FILS_SHA256)
+			if (akm =3D=3D IE_RSN_AKM_SUITE_FILS_SHA256 || akm =3D=3D
+					IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256)
 				kek_len =3D 32;
 			else
 				kek_len =3D 64;
@@ -1220,10 +1230,7 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm =
*sm,
 			goto error_unspecified;
 	}
 =

-	if (sm->handshake->akm_suite &
-			(IE_RSN_AKM_SUITE_FT_OVER_8021X |
-			 IE_RSN_AKM_SUITE_FT_USING_PSK |
-			 IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256)) {
+	if (IE_AKM_IS_FT(sm->handshake->akm_suite)) {
 		/*
 		 * Rebuild the RSNE to include the PMKR1Name and append
 		 * MDE + FTE.
diff --git a/src/netdev.c b/src/netdev.c
index de6af614..c6867ce3 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2565,10 +2565,7 @@ process_resp_ies:
 			netdev->owe_sm =3D NULL;
 		}
 =

-		/* FILS handles its own FT key derivation */
-		if (fte && !(netdev->handshake->akm_suite &
-				(IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256 |
-				IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384))) {
+		if (fte) {
 			uint32_t kck_len =3D
 				handshake_state_get_kck_len(netdev->handshake);
 			/*
-- =

2.31.1

--===============0286842008178870779==--

