Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40942C8DE
	for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 12:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713703953; cv=none; b=l+ErKnn7S0zwZghDm65eEaJF3bvrUHfBqW/lEsIr4+B2JmTAFg1gMfvQ0ffBifsZkvBz+adyxdb4v2x+BSPnK1SrOazvg+s5rK/pgKD4dfvAZtNKbO8B1bQHXmdWsmuoXLv3h8I/znccJgcslcqvsRyybuNFP1+zr/+Rqfcsj7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713703953; c=relaxed/simple;
	bh=ZH5x9ATGv2Xx/ubGDt4J9KfabwYuBMBME0PJ2i2205o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tD641x2ayJ9w2D3NBHFXo+4vvFoT+oAPa+SwkNDJBkF09nc9+zWLlMPzLQVduk/nz1heEf9IaoqhbyKbGDGO0jOpNc3iQzUYH38o/RhVQVfeM1gH5eXjfa0T9woPjxTgbb/9+nkQBK7uGl3olL8UpG2J1vsFlBLXpNzDAkenz3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcPyMEcz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcPyMEcz"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f28bb6d747so342376b3a.3
        for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 05:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713703951; x=1714308751; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lB//zIMayDnKBIFfFR1upol5JgGtsL17HmLjVPPniA=;
        b=PcPyMEczJpwissdb/5DQawRnY3HC0T2CBnu4Mce8N9SX2wFjJu6uey4yneXWflMgUi
         Dm+/IQOnJ8KjI1jdni1Iwhut3nIjY/ncFYKbD62a6LXVFa0qZItM2jBhaouuQhIw0s+i
         RL6Awz7gVg3iF4yCwUgLdaRhnC6CQ1uz+XS8b1qMXzTzHDR4PgJYOBADKGuCT8tkiSmC
         cBm3g2GJOSPorsYpAiTiu+TGwG/skuFEvx1OG4jfzg2bNAeMA0uqE5agyC08CdlWc/5F
         RLuyyXEqWtO5Iz3pyc0WPDq/LqX7IOVa855U2zjF+Bzsq7tYRwHdJ+fKPOD44na6F4ds
         0hzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713703951; x=1714308751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lB//zIMayDnKBIFfFR1upol5JgGtsL17HmLjVPPniA=;
        b=U901kor23l/EDh9dLAo4II/VjAaG6PdKVVhT5OyfVnCaBn9OAbXGwS/6Aj6D4KYAGc
         0sqvQIFgLKEV4R+I1AGPwAGnnmZAz0Sb1S4yiGE1VCT+UufOA+l4wYvLIrC/FCX6GDBA
         3g8J4eoS/sP9EerlBtafLWvacOXjP8dIwziYKLvHfVtowD4suCv0C+BbujTk7IkOnMLa
         GELBqEwnOeuNZP8aWZXim3NP69GhABxN0e2dUpDCH6t4n/yopIA3V5LDaXPq62Nh70ls
         U7nI8Qe4KRfJqxCKxbCn1cYc7fquVX6hk6BuCPbGMGUHlqtCqT/z9/5VML+CwRW+sJeD
         9iRg==
X-Gm-Message-State: AOJu0YzAaK3qeHiEwThDbY5l87YfMQWBlHWLgC7qK9jiwjdYNfVVIGTr
	7MgvHWP5rKjbVcldw8+nl6BOTwH/QxJxkXwF2+vTqaUW8/aaE67ORvoHyzglynk=
X-Google-Smtp-Source: AGHT+IFNjmPv30b0UOzFHuXSnqbzteGyS0BCTtuhgsWKMRfT/6HlJ0v8Urnw+wXqJj/sI1ESxyCZWg==
X-Received: by 2002:a05:6a21:8015:b0:1a9:8152:511c with SMTP id ou21-20020a056a21801500b001a98152511cmr5888735pzb.62.1713703951392;
        Sun, 21 Apr 2024 05:52:31 -0700 (PDT)
Received: from localhost ([185.169.0.163])
        by smtp.gmail.com with ESMTPSA id e7-20020a17090a77c700b002a55d8a99d5sm7538838pjs.22.2024.04.21.05.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 05:52:31 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH 02/11] ap: accept PSK/SAE in auth depending on config
Date: Sun, 21 Apr 2024 05:50:32 -0700
Message-ID: <20240421125050.6649-3-brandtwjohn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240421125050.6649-1-brandtwjohn@gmail.com>
References: <20240421125050.6649-1-brandtwjohn@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On reception of an authentication frame, accept both PSK and SAE as AKM
depending on the config. Save the client's AKM for later use.
---
 src/ap.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index d50f9e4f..14268551 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -132,6 +132,7 @@ struct sta_state {
 	uint8_t *assoc_ies;
 	size_t assoc_ies_len;
 	uint8_t *assoc_rsne;
+	enum ie_rsn_akm_suite akm_suite;
 	struct eapol_sm *sm;
 	struct handshake_state *hs;
 	uint32_t gtk_query_cmd_id;
@@ -2606,6 +2607,7 @@ static void ap_auth_cb(const struct mmpdu_header *hdr, const void *body,
 	const uint8_t *from = hdr->address_2;
 	const uint8_t *bssid = netdev_get_address(ap->netdev);
 	struct sta_state *sta;
+	enum ie_rsn_akm_suite akm_suite;
 
 	l_info("AP Authentication from %s", util_address_to_string(from));
 
@@ -2627,17 +2629,27 @@ static void ap_auth_cb(const struct mmpdu_header *hdr, const void *body,
 		}
 	}
 
-	/* Only Open System authentication implemented here */
-	if (L_LE16_TO_CPU(auth->algorithm) !=
-			MMPDU_AUTH_ALGO_OPEN_SYSTEM) {
+	if ((ap->akm_suites & IE_RSN_AKM_SUITE_SAE_SHA256) &&
+	    (L_LE16_TO_CPU(auth->algorithm) == MMPDU_AUTH_ALGO_SAE) ) {
+		/* When using SAE it must be COMMIT or CONFIRM frame */
+		if (L_LE16_TO_CPU(auth->transaction_sequence) > 2) {
+			ap_auth_reply(ap, from, MMPDU_REASON_CODE_UNSPECIFIED);
+			return;
+		}
+		akm_suite = IE_RSN_AKM_SUITE_SAE_SHA256;
+	} else if ((ap->akm_suites & IE_RSN_AKM_SUITE_PSK) &&
+		   (L_LE16_TO_CPU(auth->algorithm) == MMPDU_AUTH_ALGO_OPEN_SYSTEM) ) {
+		/* When using PSK it must be Open System authentication */
+		if (L_LE16_TO_CPU(auth->transaction_sequence) != 1) {
+			ap_auth_reply(ap, from, MMPDU_REASON_CODE_UNSPECIFIED);
+			return;
+		}
+		akm_suite = IE_RSN_AKM_SUITE_PSK;
+	} else {
 		ap_auth_reply(ap, from, MMPDU_REASON_CODE_UNSPECIFIED);
 		return;
 	}
 
-	if (L_LE16_TO_CPU(auth->transaction_sequence) != 1) {
-		ap_auth_reply(ap, from, MMPDU_REASON_CODE_UNSPECIFIED);
-		return;
-	}
 
 	sta = l_queue_find(ap->sta_states, ap_sta_match_addr, from);
 
@@ -2666,6 +2678,8 @@ static void ap_auth_cb(const struct mmpdu_header *hdr, const void *body,
 	if (!ap->sta_states)
 		ap->sta_states = l_queue_new();
 
+	sta->akm_suite = akm_suite;
+
 	l_queue_push_tail(ap->sta_states, sta);
 
 	/*
-- 
2.44.0

