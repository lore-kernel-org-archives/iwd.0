Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD44468B
	for <iwd@lists.linux.dev>; Mon, 26 Sep 2022 18:52:06 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id go6so7152049pjb.2
        for <iwd@lists.linux.dev>; Mon, 26 Sep 2022 11:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ITC5IZz3L8Y8JX+F/EmYt4YUsUY5e/AZOpXyj3Az49M=;
        b=JoacY7NKiNvXFGc4CiiiW4DMpEQWF94ADnlVkQPLqgAP/OXc38mXZWKoua7lTJMjkn
         ffuvD8/J67+DT1QDKmRee9URDq/2N8keoXs9b6b5xmvYf0wVPJqS9pz8DyC+eo8VcLwv
         CDw4FFOFc8/OtTJi5EGDHAv1ztltdpX/R2Ee9t3GMd4zhBTqL4cmnH261YeMwSd/x3Ei
         ubJm4hFO3jIhpvwVdypEWfjUDrWmT0UgMjSSzlPCSS7GIPKc29iTPvaxMO5eoX1tNv8h
         pqOr4j1xsb9M9dWUykHUpC6d3BYtqSp1hEVRcsAvNdxmVDG0tyZZ0NemGxRrLSfPAUuY
         LXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ITC5IZz3L8Y8JX+F/EmYt4YUsUY5e/AZOpXyj3Az49M=;
        b=NoMlBeIetQNPVEfqIPues6kD67CKs1gsoKN/q+WtfNMh0R8J+8Lx5SP5nwiEKXHn02
         qM3WCrwLJPLaBAY6qgMJ0qCstSTpVqMxV5jH4GB82GHLxk8KVU88c1IR/3n9rxN/Gmsk
         8Fx6ESscHPQ/nQL3z3ZHTekgL+K6fdAw7+LI5vhH/+4/SvPWoZGDOlA/RxrzmTjMYwAZ
         G5bDt728E2RnQ82ADkGys5zzMW9NAtxYhUUS1XsnJDqNkGE4cV+MLVLbs2GSZYVC96oO
         rReU18P6jMq/lETgDEpW7SBFCreGqFwOXQiIu09rAQ4rM9qdcI/vDa9/BrepzoNv8cKB
         fVAw==
X-Gm-Message-State: ACrzQf3p0MYKKi2zN4clHs9vVDqKMOy3kehGE8TdaPjZwDyIwuXRezAP
	Z+iZiosCjQIO8jMo/ubgm49hRfY3p+4=
X-Google-Smtp-Source: AMsMyM4mAoW9Jf5OIan7TdRAO0wdY0Cv/6qbKF9NJdnpGM2DfSOV6qHhusdbLtLxNXBTxInP7mWfTA==
X-Received: by 2002:a17:903:18b:b0:176:afb8:b4ab with SMTP id z11-20020a170903018b00b00176afb8b4abmr23883638plg.80.1664218325648;
        Mon, 26 Sep 2022 11:52:05 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id p14-20020a17090b010e00b00202d36b7403sm7111115pjz.25.2022.09.26.11.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 11:52:05 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] sae: add IWD_SAE_DEBUG for more SAE debug messages
Date: Mon, 26 Sep 2022 11:52:01 -0700
Message-Id: <20220926185202.52479-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SAE will now check for IWD_SAE_DEBUG and enable more debug logging
using the new macro, sae_debug.
---
 src/sae.c | 70 +++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 12 deletions(-)

diff --git a/src/sae.c b/src/sae.c
index 859ec94b..cfd4d650 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -37,6 +37,9 @@
 #include "src/mpdu.h"
 #include "src/auth-proto.h"
 #include "src/sae.h"
+#include "src/module.h"
+
+static bool debug;
 
 /* SHA-512 is the highest supported hashing function as of 802.11-2020 */
 #define SAE_MAX_HASH_LEN 64
@@ -45,6 +48,12 @@
 #define SAE_SYNC_MAX		3
 #define SAE_MAX_ASSOC_RETRY	3
 
+#define sae_debug(fmat, ...) \
+({	\
+	if (debug) \
+		l_info("[SAE]: "fmat, ##__VA_ARGS__); \
+})
+
 enum sae_state {
 	SAE_STATE_NOTHING = 0,
 	SAE_STATE_COMMITTED = 1,
@@ -154,7 +163,7 @@ static int sae_choose_next_group(struct sae_sm *sm)
 			return -ENOENT;
 		}
 
-		l_debug("Forcing default SAE group 19");
+		sae_debug("Forcing default SAE group 19");
 
 		sm->group_retry++;
 		sm->group = 19;
@@ -176,6 +185,8 @@ static int sae_choose_next_group(struct sae_sm *sm)
 	sm->group = ecc_groups[sm->group_retry];
 
 get_curve:
+	sae_debug("Using group %u", sm->group);
+
 	sm->curve = l_ecc_curve_from_ike_group(sm->group);
 
 	return 0;
@@ -327,6 +338,9 @@ static int sae_reject(struct sae_sm *sm, uint16_t transaction, uint16_t status)
 		ptr += 2;
 	}
 
+	sae_debug("Rejecting exchange transaction=%u status=%u",
+			transaction, status);
+
 	sm->tx_auth(reject, ptr - reject, sm->user_data);
 
 	return status;
@@ -631,6 +645,9 @@ static bool sae_send_confirm(struct sae_sm *sm)
 	memcpy(ptr, confirm, r);
 	ptr += r;
 
+	sae_debug("Sending Confirm to "MAC" sc=%u",
+			MAC_STR(sm->handshake->aa), sm->sc);
+
 	sm->tx_auth(body, ptr - body, sm->user_data);
 	return true;
 }
@@ -827,6 +844,8 @@ static int sae_process_confirm(struct sae_sm *sm, const uint8_t *from,
 
 	sm->state = SAE_STATE_ACCEPTED;
 
+	sae_debug("Sending Associate to "MAC, MAC_STR(sm->handshake->aa));
+
 	sm->tx_assoc(sm->user_data);
 
 	return 0;
@@ -844,6 +863,8 @@ static bool sae_send_commit(struct sae_sm *sm, bool retry)
 	if (r < 0)
 		return false;
 
+	sae_debug("Sending Commit to "MAC, MAC_STR(hs->aa));
+
 	sm->tx_auth(commit, r, sm->user_data);
 
 	return true;
@@ -858,6 +879,8 @@ static bool sae_assoc_timeout(struct auth_proto *ap)
 
 	sm->assoc_retry++;
 
+	sae_debug("Retry Associate to "MAC, MAC_STR(sm->handshake->aa));
+
 	sm->tx_assoc(sm->user_data);
 
 	return true;
@@ -921,6 +944,8 @@ static int sae_process_anti_clogging(struct sae_sm *sm, const uint8_t *ptr,
 		return -EBADMSG;
 	}
 
+	sae_debug("Processed anti-clogging token");
+
 	l_free(sm->token);
 	sm->token = l_memdup(ptr, len);
 	sm->token_len = len;
@@ -1036,6 +1061,9 @@ static int sae_verify_committed(struct sae_sm *sm, uint16_t transaction,
 			goto reject_unsupp_group;
 		}
 
+		sae_debug("AP rejected group, trying again with group %u",
+				sm->group);
+
 		sm->sync = 0;
 		sae_send_commit(sm, false);
 
@@ -1297,8 +1325,6 @@ static int sae_verify_packet(struct sae_sm *sm, uint16_t trans,
 				uint16_t status, const uint8_t *frame,
 				size_t len)
 {
-	l_debug("rx trans=%u, state=%s", trans, sae_state_to_str(sm->state));
-
 	if (trans != SAE_STATE_COMMITTED && trans != SAE_STATE_CONFIRMED)
 		return -EBADMSG;
 
@@ -1324,16 +1350,23 @@ static int sae_rx_authenticate(struct auth_proto *ap,
 	const struct mmpdu_header *hdr = (const struct mmpdu_header *) frame;
 	const struct mmpdu_authentication *auth = mmpdu_body(hdr);
 	int ret;
+	uint16_t transaction = L_LE16_TO_CPU(auth->transaction_sequence);
+	uint16_t status = L_LE16_TO_CPU(auth->status);
+
+	sae_debug("Received frame transaction=%u status=%u state=%s",
+			transaction, status, sae_state_to_str(sm->state));
 
 	len -= mmpdu_header_len(hdr);
 
-	ret = sae_verify_packet(sm, L_LE16_TO_CPU(auth->transaction_sequence),
-					L_LE16_TO_CPU(auth->status),
-					auth->ies, len - 6);
-	if (ret != 0)
+	ret = sae_verify_packet(sm, transaction, status, auth->ies, len - 6);
+	if (ret != 0) {
+		if (ret < 0 && ret != -EAGAIN)
+			sae_debug("Frame did not verify (%s)", strerror(-ret));
+
 		return ret;
+	}
 
-	switch (L_LE16_TO_CPU(auth->transaction_sequence)) {
+	switch (transaction) {
 	case SAE_STATE_COMMITTED:
 		return sae_process_commit(sm, hdr->address_2, auth->ies,
 						len - 6);
@@ -1341,8 +1374,7 @@ static int sae_rx_authenticate(struct auth_proto *ap,
 		return sae_process_confirm(sm, hdr->address_2, auth->ies,
 						len - 6);
 	default:
-		l_error("invalid transaction sequence %u",
-				L_LE16_TO_CPU(auth->transaction_sequence));
+		l_error("invalid transaction sequence %u", transaction);
 	}
 
 	/* should never get here */
@@ -1442,12 +1474,26 @@ struct auth_proto *sae_sm_new(struct handshake_state *hs,
 						hs->authenticator_rsnxe;
 
 	if (ie_rsnxe_capable(rsnxe, IE_RSNX_SAE_H2E) && hs->ecc_sae_pts) {
-		l_debug("Using SAE H2E");
+		sae_debug("Using SAE H2E");
 		sm->sae_type = CRYPTO_SAE_HASH_TO_ELEMENT;
 	} else {
-		l_debug("Using SAE Hunting and Pecking");
+		sae_debug("Using SAE Hunting and Pecking");
 		sm->sae_type = CRYPTO_SAE_LOOPING;
 	}
 
 	return &sm->ap;
 }
+
+static int sae_init(void)
+{
+	if (getenv("IWD_SAE_DEBUG"))
+		debug = true;
+
+	return 0;
+}
+
+static void sae_exit(void)
+{
+}
+
+IWD_MODULE(sae, sae_init, sae_exit);
-- 
2.34.3

