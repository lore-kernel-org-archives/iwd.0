Content-Type: multipart/mixed; boundary="===============1389611457117032055=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH 09/16] eap-wsc: Validate enrollee_nonce (N1) in M{2,4,6,8}
Date: Thu, 13 Aug 2020 02:53:25 +0200
Message-ID: <20200813005325.295054-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1389611457117032055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/eap-wsc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/eap-wsc.c b/src/eap-wsc.c
index 0fec29c6..ccb52979 100644
--- a/src/eap-wsc.c
+++ b/src/eap-wsc.c
@@ -479,6 +479,10 @@ static void eap_wsc_handle_m8(struct eap_state *eap,
 		return;
 	}
 =

+	if (memcmp(m8.enrollee_nonce, wsc->m1->enrollee_nonce,
+						sizeof(m8.enrollee_nonce)))
+		return;
+
 	if (!authenticator_check(wsc, pdu, len))
 		return;
 =

@@ -580,6 +584,10 @@ static void eap_wsc_handle_m6(struct eap_state *eap,
 	if (wsc_parse_m6(pdu, len, &m6, &encrypted) !=3D 0)
 		goto send_nack;
 =

+	if (memcmp(m6.enrollee_nonce, wsc->m1->enrollee_nonce,
+						sizeof(m6.enrollee_nonce)))
+		return;
+
 	if (!authenticator_check(wsc, pdu, len))
 		return;
 =

@@ -677,6 +685,10 @@ static void eap_wsc_handle_m4(struct eap_state *eap,
 	if (wsc_parse_m4(pdu, len, &m4, &encrypted) !=3D 0)
 		goto send_nack;
 =

+	if (memcmp(m4.enrollee_nonce, wsc->m1->enrollee_nonce,
+						sizeof(m4.enrollee_nonce)))
+		return;
+
 	if (!authenticator_check(wsc, pdu, len))
 		return;
 =

@@ -815,6 +827,10 @@ static void eap_wsc_handle_m2(struct eap_state *eap,
 		return;
 	}
 =

+	if (memcmp(wsc->m2->enrollee_nonce, wsc->m1->enrollee_nonce,
+					sizeof(wsc->m2->enrollee_nonce)))
+		return;
+
 	if (!l_key_validate_dh_payload(wsc->m2->public_key,
 					sizeof(wsc->m2->public_key),
 					crypto_dh5_prime,
-- =

2.25.1

--===============1389611457117032055==--

