Content-Type: multipart/mixed; boundary="===============8742211871730116131=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 05/16] eapol: Use eapol_sm_write in authenticator mode
Date: Thu, 13 Aug 2020 02:50:15 +0200
Message-ID: <20200813005026.294950-5-andrew.zaborowski@intel.com>
In-Reply-To: <20200813005026.294950-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8742211871730116131==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Throughout the supplicant mode we'd use the eapol_sm_write wrapper but
in the authenticator mode we'd call __eapol_tx_packet directly.  Adapt
eapol_sm_write to use the right destination address and use it
consistently.
---
 src/eapol.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 38c7956e..299de13f 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -904,8 +904,11 @@ void eapol_sm_set_user_data(struct eapol_sm *sm, void =
*user_data)
 static void eapol_sm_write(struct eapol_sm *sm, const struct eapol_frame *=
ef,
 				bool noencrypt)
 {
-	__eapol_tx_packet(sm->handshake->ifindex, sm->handshake->aa, ETH_P_PAE,
-				ef, noencrypt);
+	const uint8_t *dst =3D sm->handshake->authenticator ?
+		sm->handshake->spa : sm->handshake->aa;
+
+	__eapol_tx_packet(sm->handshake->ifindex, dst, ETH_P_PAE, ef,
+				noencrypt);
 }
 =

 static inline void handshake_failed(struct eapol_sm *sm, uint16_t reason_c=
ode)
@@ -1024,7 +1027,6 @@ static void eapol_set_key_timeout(struct eapol_sm *sm,
 /* 802.11-2016 Section 12.7.6.2 */
 static void eapol_send_ptk_1_of_4(struct eapol_sm *sm)
 {
-	uint32_t ifindex =3D sm->handshake->ifindex;
 	const uint8_t *aa =3D sm->handshake->aa;
 	uint8_t frame_buf[512];
 	struct eapol_key *ek =3D (struct eapol_key *) frame_buf;
@@ -1062,8 +1064,7 @@ static void eapol_send_ptk_1_of_4(struct eapol_sm *sm)
 	l_debug("STA: "MAC" retries=3D%u", MAC_STR(sm->handshake->spa),
 			sm->frame_retry);
 =

-	__eapol_tx_packet(ifindex, sm->handshake->spa, ETH_P_PAE,
-				(struct eapol_frame *) ek, false);
+	eapol_sm_write(sm, (struct eapol_frame *) ek, false);
 }
 =

 static void eapol_ptk_1_of_4_retry(struct l_timeout *timeout, void *user_d=
ata)
@@ -1265,7 +1266,6 @@ error_unspecified:
 /* 802.11-2016 Section 12.7.6.4 */
 static void eapol_send_ptk_3_of_4(struct eapol_sm *sm)
 {
-	uint32_t ifindex =3D sm->handshake->ifindex;
 	uint8_t frame_buf[512];
 	unsigned int rsne_len =3D sm->handshake->authenticator_ie[1] + 2;
 	uint8_t key_data_buf[128 + rsne_len];
@@ -1335,8 +1335,7 @@ static void eapol_send_ptk_3_of_4(struct eapol_sm *sm)
 	l_debug("STA: "MAC" retries=3D%u", MAC_STR(sm->handshake->spa),
 			sm->frame_retry);
 =

-	__eapol_tx_packet(ifindex, sm->handshake->spa, ETH_P_PAE,
-				(struct eapol_frame *) ek, false);
+	eapol_sm_write(sm, (struct eapol_frame *) ek, false);
 }
 =

 static void eapol_ptk_3_of_4_retry(struct l_timeout *timeout,
-- =

2.25.1

--===============8742211871730116131==--

