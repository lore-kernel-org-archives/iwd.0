Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6097EEA0
	for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 22:57:55 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-30fcde6a73cso3426333f8f.2
        for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 15:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687215473; x=1689807473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzK9HZ6uVpjhY0i2Nrf/F/crkrhfQ8PjuaxZlnz7Kwo=;
        b=RYJI9x+JcSjNI0R5udgVhy43RDdea6QAnQ++vgtizBre3OPJ/ObpAueqkueClslRdD
         nWGXeW1lNcEZI1AtwMT7aAWAakhKn9kzjmJXr0oXWx8gfegXWlj7HthyA3Zy8Jr/HVxU
         KLWE8s1+xk0zghbQe+K9yKIlHJYDnFx1rYATv6f8IK/W4ugNi+0budwxKDSfLChtV6Bv
         K7PbJ4XG/WhnQ2UFvKp8NdbWuWVU6ZuG7kshkK5fODYwHHuFZH9MQRL3tO7VpVyt6/4u
         CCfb8kdW1Ml9tUyI4eGIBEhg36oqwgOnYZZavyvngsZ+icQ7LNfS7fB3HPO5euJYjVtm
         aVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687215473; x=1689807473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZzK9HZ6uVpjhY0i2Nrf/F/crkrhfQ8PjuaxZlnz7Kwo=;
        b=NpMbGar6WFwMR85ZdCYWGMJktjIlgFV+cw02DllaLmYcwN2Q5CUMTWRgXmFLMHaKOn
         SR+Oi/dkmdPgjlRkG46TZ52ghfxgao7FoZyG+HRNbCc1c4SeS4wvcPVHLch0D/pB7C4N
         Si08qnqbeTNKh1M4Rk06/uEEApQmaxoG211A3kU7TfEUFr+hJDPu1ywZ3HRxMjMnvubO
         2pK4jwtuITStXrKB6tOuX748tXm5SLUJgkK0wXq1QAy334SzUjjmdQudU3r1Uk91xdKe
         nGnCPHOoBGMTra0xVJVPYrWfZr5RMPCGqCyUl8mnlC78Fw/NJJzGUoWSTLtMineJQdyu
         QIhQ==
X-Gm-Message-State: AC+VfDyaly7SgBpnbx+5yyyrBnsjVX4P8nQQ3YleL1kbbLmNwOTEBesH
	DP5wngYWWglak9YPlFPtyquFlrmo+VSRtg==
X-Google-Smtp-Source: ACHHUZ74PiMyCQAJ37Rl+hfhtlINHNbd1uOzrn1/Du2v1HZosuQQ5yzh3lH8wzectvbn9kyEu6pD8A==
X-Received: by 2002:a5d:58d8:0:b0:311:1475:3295 with SMTP id o24-20020a5d58d8000000b0031114753295mr7723840wrf.17.1687215472815;
        Mon, 19 Jun 2023 15:57:52 -0700 (PDT)
Received: from LOCLAP699.dhl-toledo.locus ([195.55.200.178])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d4c8b000000b0030c4d8930b1sm571946wrs.91.2023.06.19.15.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 15:57:52 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/6] handshake: add force_sha1 flag to handshake_state_get_pmkid()
Date: Mon, 19 Jun 2023 15:57:41 -0700
Message-Id: <20230619225746.462791-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare adding FT_OVER_8021X to the SHA256 list for PMKID
derivation, add a flag to force SHA1 to be used with
preauthentication. The spec dictates that preauth must use SHA1
but this isn't consistent with PMKID derivation in all other
cases for the FT_OVER_8021X AKM.
---
 src/eapol.c     | 2 +-
 src/handshake.c | 7 ++++---
 src/handshake.h | 3 ++-
 src/station.c   | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 37f5eaaa..354b8fe7 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1236,7 +1236,7 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm *sm,
 	} else if (pmkid) {
 		uint8_t own_pmkid[16];
 
-		if (!handshake_state_get_pmkid(sm->handshake, own_pmkid))
+		if (!handshake_state_get_pmkid(sm->handshake, own_pmkid, false))
 			goto error_unspecified;
 
 		if (l_secure_memcmp(pmkid, own_pmkid, 16)) {
diff --git a/src/handshake.c b/src/handshake.c
index cd9b3082..7f749632 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -734,7 +734,8 @@ void handshake_state_set_pmkid(struct handshake_state *s, const uint8_t *pmkid)
 	s->have_pmkid = true;
 }
 
-bool handshake_state_get_pmkid(struct handshake_state *s, uint8_t *out_pmkid)
+bool handshake_state_get_pmkid(struct handshake_state *s, uint8_t *out_pmkid,
+				bool force_sha1)
 {
 	bool use_sha256;
 
@@ -755,8 +756,8 @@ bool handshake_state_get_pmkid(struct handshake_state *s, uint8_t *out_pmkid)
 	 * calculation."
 	 */
 
-	if (s->akm_suite & (IE_RSN_AKM_SUITE_8021X_SHA256 |
-			IE_RSN_AKM_SUITE_PSK_SHA256))
+	if (!force_sha1 && (s->akm_suite & (IE_RSN_AKM_SUITE_8021X_SHA256 |
+			IE_RSN_AKM_SUITE_PSK_SHA256)))
 		use_sha256 = true;
 	else
 		use_sha256 = false;
diff --git a/src/handshake.h b/src/handshake.h
index 863ffac7..d9505593 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -269,7 +269,8 @@ void handshake_state_install_igtk(struct handshake_state *s,
 void handshake_state_override_pairwise_cipher(struct handshake_state *s,
 					enum ie_rsn_cipher_suite pairwise);
 
-bool handshake_state_get_pmkid(struct handshake_state *s, uint8_t *out_pmkid);
+bool handshake_state_get_pmkid(struct handshake_state *s, uint8_t *out_pmkid,
+				bool force_sha1);
 
 bool handshake_decode_fte_key(struct handshake_state *s, const uint8_t *wrapped,
 				size_t key_len, uint8_t *key_out);
diff --git a/src/station.c b/src/station.c
index f830ab7a..2e819460 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2236,7 +2236,7 @@ static void station_preauthenticate_cb(struct netdev *netdev,
 					new_hs->supplicant_ie[1] + 2,
 					&rsn_info);
 
-		handshake_state_get_pmkid(new_hs, pmkid);
+		handshake_state_get_pmkid(new_hs, pmkid, true);
 
 		rsn_info.num_pmkids = 1;
 		rsn_info.pmkids = pmkid;
-- 
2.25.1

