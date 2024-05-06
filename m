Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05899A926
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 00:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956486; cv=none; b=bIJC93jUDjEn5Pl3B5svMbn/yNNPCqwp2yVMhw9xopoNJXomLX4hdMn8FncFDrYPmKrX+qG20mF2LYFyOi3QuXTYt32BWx0CYq+qwfjmiQWGjluGUDRJOfXdR7iZaIj691zChh4Rqlb14Ji0hWaN61DB9Ss2mcrYDTX9IafymwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956486; c=relaxed/simple;
	bh=0dTOU953Ko/R+LGqBWluYSwr7Lid0eqL4mwHjutpo/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wa8zvzO6FBZK9q60wRY3ZGa7FzjYP4HksmHZO88c6wJlri3gJ+uxzgTLsXOPW6oh4evaA3q7+fWO2eex657ZW+D3dAS7fMTFP5nXdofB65N5Wj7cywRuXpuQ3iChaTQ2wUxj3BTDJg8ZLPTabSPt0fSwX/rGSdF4EKh9PZnmMQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5mJ+Ho/; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5mJ+Ho/"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-602801ea164so998424a12.0
        for <iwd@lists.linux.dev>; Sun, 05 May 2024 17:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714956484; x=1715561284; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xuKzms716d8gYfRXHdFYfGzv/exCi/KSc543e/jq0o=;
        b=Y5mJ+Ho/HNLFKeKjrzVjxm28OSLaG7JYAgEnDtTmh0nZyuofTnzTnvUMw6388LAY+T
         cEOfzo7Gu7FLpDbj8rSVggCqn53ncuCeoJqzx5nKjnXzFaWRLVfZ5+DTW+bOWuKfbRVB
         /3h0zCiUoRCFq6NfpL4tbvRpR9fSwgf4H2BtyeZCPYgQQsiB2g/pB1ekZqKM0mlQ8C+3
         PODLyQJp7CjpKdJthb+72BrWeGZCZnFMHoUGk/punfGE6fE8YhdvaTyMNllndrVm1yEU
         NmJb+AjgLQ3ceB5uPditO4HVKPEaccFO48L+sUl3gEu1jWOOmFMhGa7eEKa2Uulw6hE6
         lsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714956484; x=1715561284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xuKzms716d8gYfRXHdFYfGzv/exCi/KSc543e/jq0o=;
        b=D2jsDdkZC9shV/oGLRM/R3PbOHL9YE6K/Ig+f7Jy8pMmqxDFA91672fa2lf8jUUqOr
         ypGGqhYNvF0dvlszoCN18yggl2L29AeuOydCRAuE1G14X29cm4K/DAB6bG64OdpgXzQN
         3HdA426gq6U0ycAL0WWbBtimeoW5V7VgDAvnuKi1dIxSwsyYpPD0jRbdLFIO/O2KzO5O
         v6nGLcSZtNJkGWv3cRUTpSJ5SPxnkvIt2BeR8pulv35kB8BOxABxHE2NXCgncEUHfn+M
         1rkWM47DNjk7eZJK3OO+r6hV2DVX++s79MAdboaRWi+z20jKAsJbC6TeNKRSRqIsSWuF
         eZmA==
X-Gm-Message-State: AOJu0Yx87At38Bmf3qHzpvM3AHrHJHp1V2Gqk1GFvRGBax1qTQYVlZ4V
	vy87rJPJ4Qpy7eIUa02aV0SZLI6WDg0nGlBqSGXS9sWr8/GMvJ8sQqlVUQ==
X-Google-Smtp-Source: AGHT+IFSVb4HUI3/3nvzdSjM8kkaD1SZwRsHRE4uAUssFfsZKNh/N557I4yi6Rd2febd3Y3ygHO8bQ==
X-Received: by 2002:a05:6a20:72a8:b0:1af:aec3:2841 with SMTP id o40-20020a056a2072a800b001afaec32841mr1714097pzk.56.1714956483956;
        Sun, 05 May 2024 17:48:03 -0700 (PDT)
Received: from localhost ([192.145.118.41])
        by smtp.gmail.com with ESMTPSA id ch2-20020a17090af40200b002abdb19f499sm6895053pjb.26.2024.05.05.17.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 17:48:03 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH v2 02/18] ap: accept PSK/SAE in auth depending on config
Date: Sun,  5 May 2024 17:30:25 -0700
Message-ID: <20240506003518.320176-3-brandtwjohn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506003518.320176-1-brandtwjohn@gmail.com>
References: <20240506003518.320176-1-brandtwjohn@gmail.com>
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
 src/ap.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index d50f9e4f..cd253ce3 100644
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
 
@@ -2627,17 +2629,28 @@ static void ap_auth_cb(const struct mmpdu_header *hdr, const void *body,
 		}
 	}
 
-	/* Only Open System authentication implemented here */
-	if (L_LE16_TO_CPU(auth->algorithm) !=
-			MMPDU_AUTH_ALGO_OPEN_SYSTEM) {
+	if ((ap->akm_suites & IE_RSN_AKM_SUITE_SAE_SHA256) &&
+	    (L_LE16_TO_CPU(auth->algorithm) == MMPDU_AUTH_ALGO_SAE) ) {
+		/* When using SAE it must be COMMIT or CONFIRM frame */
+		if (L_LE16_TO_CPU(auth->transaction_sequence) != 1 &&
+		    L_LE16_TO_CPU(auth->transaction_sequence) != 2) {
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
 
@@ -2666,6 +2679,8 @@ static void ap_auth_cb(const struct mmpdu_header *hdr, const void *body,
 	if (!ap->sta_states)
 		ap->sta_states = l_queue_new();
 
+	sta->akm_suite = akm_suite;
+
 	l_queue_push_tail(ap->sta_states, sta);
 
 	/*
-- 
2.45.0

