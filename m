Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC48A930
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 00:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956523; cv=none; b=li0jVBqjstLQAAnFquCICRY3kPxOBrdztTjKcX4ncfhAvi9y7Y+p/u4tXDYTWBliCUR+fvQFR0TMqvfX8rSz6XJaPfobwIkeX8uatwARX02xuFu+SdoJQwLYILs5MwU9My1xiIWZybpPui+RLloC6Icp2i8BwKrGTAu0FzMY2+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956523; c=relaxed/simple;
	bh=h7dsVWt/9UiLbZuYBDVMV64DtHh+7oJZAnDX14IP4Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJRRXHxWX+sA7hgEeKj5bSh/WdUHY/pOH7jz0+b2CF5PvFwatnh/dqvR9/NybF7OSdW0g/ArS+DpM0xpaG7Imp6kXJrvhtoLETy99+sl9dNMuUWBh6wG1n0+Or3KNkewoWaQBV7Mr66fVmxBRAiqMI5dlcne410gkO0ppvCBZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhRpfQSq; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhRpfQSq"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6123726725eso1223112a12.3
        for <iwd@lists.linux.dev>; Sun, 05 May 2024 17:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714956521; x=1715561321; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qHGirSnaACK44IoejWoHlILwfNvSGtABQpMM0/KdUc=;
        b=fhRpfQSqeq5O/9TtHlHzOP5k2PIRYL1Hnt4ROr+17mG/iwY493MCSkRKUb6x7GnIuS
         fub+gfD7pm3ob3zCVBdOYIuw5E9qveCu54kvJA4QCFFWW+xq0sh8/u+AcgfKtcEjnq2C
         B5xsQ6eSXm0T+7OuvegemFEpE8dplmApyOkFskRcfiLGSp6me6+aOL7/GCiFqIeemK8/
         TMT0hD7G4pvHR84aZM7Ia5X54xSldIX7CxBTltR0haiJrlmaMYhSrhsXFHV34VkYkRsf
         aFohGY70l8Eb14Jrqe6P+LIiKXnAspSXpLJ1lKIHn++496vfSzUEqHYLY5YsmsKGWrwZ
         /cMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714956521; x=1715561321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qHGirSnaACK44IoejWoHlILwfNvSGtABQpMM0/KdUc=;
        b=euybyb0Lfhxn6ys4vA0c67Hmv9scHG0GxXXr20lk+tpb7Bz5xVYGW7mW/XVf+lXnN1
         qnutEqcSgPX+hElBUkO63I0H9VPRb8m+TMfzPu8hO5wSfU5FgdFBYUqKmSXXORAaDDRD
         yVdmK+kZs+WpISC66pcMXEJIvmRqgzupsOVtmpsuO8u3BNF9gG1vtZhktW+BfRil+FiO
         wUGMMgXf3H3pRY1JKXfGf97mxJ4K2tq9vPKIXulodwaNcAkdd8vapPSt7MJLAiyDyza6
         JFbXbz1PsmZZOLqBAo4fqFoh5o3USZXxpx6bN1gDq+geUm5LU4mDexq9ipg2r5Jkd/08
         4shA==
X-Gm-Message-State: AOJu0Yx/53xGl25IQ/zBEahK5afHvtXmhatFSEES3CEZ5HfKESDNguYi
	r9XlLXx/W9yMnJn4b+WZSkstQttZ/nZp0CUffaI8k0CBt71stc8UIhKU5g==
X-Google-Smtp-Source: AGHT+IHNGICo4/thHDS5AUPv0dlNYf4K0EtvkZ+s8ixlurZdlO2mp8JQWa+ozMTJlsTFqmSHPHuZRA==
X-Received: by 2002:a05:6a21:6d9e:b0:1a9:88ac:df47 with SMTP id wl30-20020a056a216d9e00b001a988acdf47mr8977217pzb.36.1714956520741;
        Sun, 05 May 2024 17:48:40 -0700 (PDT)
Received: from localhost ([192.145.118.41])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b001e4458831f7sm7136587plk.77.2024.05.05.17.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 17:48:40 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH v2 06/18] sae: make sae_process_commit callable in AP mode
Date: Sun,  5 May 2024 17:30:29 -0700
Message-ID: <20240506003518.320176-7-brandtwjohn@gmail.com>
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

As an AP, the function sae_process_commit will pick the group offered by
the client. In a subsuquent commit the offered group will first be
verified before calling sae_process_commit. The AP will reply with a
Commit frame, calculate current keys, and move to the COMMITTED state.
---
 src/sae.c | 67 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 20 deletions(-)

diff --git a/src/sae.c b/src/sae.c
index 7787a390..7ba9b0eb 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -48,6 +48,8 @@ static bool debug;
 #define SAE_SYNC_MAX		3
 #define SAE_MAX_ASSOC_RETRY	3
 
+static bool sae_send_commit(struct sae_sm *sm, bool retry);
+
 #define sae_debug(fmat, ...) \
 ({	\
 	if (debug) \
@@ -321,6 +323,21 @@ static ssize_t sae_cn(struct sae_sm *sm, uint16_t send_confirm,
 	return ret;
 }
 
+static bool sae_check_reflection(struct sae_sm *sm)
+{
+	/*
+	 * If they match those sent as part of the protocol instance's own
+	 * SAE Commit message, the frame shall be silently discarded (because
+	 * it is evidence of a reflection attack) and the t0 (retransmission)
+	 * timer shall be set.
+	 */
+	if ((sm->scalar && sm->p_scalar && l_ecc_scalars_are_equal(sm->scalar, sm->p_scalar)) ||
+	    (sm->element && sm->p_element && l_ecc_points_are_equal(sm->element, sm->p_element)))
+		return false;
+
+	return true;
+}
+
 static int sae_reject(struct sae_sm *sm, uint16_t transaction, uint16_t status)
 {
 	uint8_t reject[6];
@@ -593,6 +610,10 @@ static int sae_build_commit(struct sae_sm *sm, const uint8_t *addr1,
 
 	l_ecc_scalar_free(mask);
 
+	/* ensure the scalar and element are different from peer */
+	if (!sae_check_reflection(sm))
+		return -EPROTO;
+
 	/*
 	 * Several cases require retransmitting the same commit message. The
 	 * anti-clogging code path requires this as well as the retransmission
@@ -799,9 +820,13 @@ static int sae_process_commit(struct sae_sm *sm, const uint8_t *from,
 					const uint8_t *frame, size_t len)
 {
 	uint8_t *ptr = (uint8_t *) frame;
-	unsigned int nbytes = l_ecc_curve_get_scalar_bytes(sm->curve);
+	unsigned int nbytes;
 	int r;
 
+	if (sm->handshake->authenticator && sae_set_group(sm, l_get_le16(frame)) < 0)
+		return -1;
+
+	nbytes = l_ecc_curve_get_scalar_bytes(sm->curve);
 	ptr += 2;
 
 	sm->p_scalar = l_ecc_scalar_new(sm->curve, ptr, nbytes);
@@ -821,28 +846,30 @@ static int sae_process_commit(struct sae_sm *sm, const uint8_t *from,
 				MMPDU_STATUS_CODE_UNSUPP_FINITE_CYCLIC_GROUP);
 	}
 
-	/*
-	 * If they match those sent as part of the protocol instance's own
-	 * SAE Commit message, the frame shall be silently discarded (because
-	 * it is evidence of a reflection attack) and the t0 (retransmission)
-	 * timer shall be set.
-	 */
-	if (l_ecc_scalars_are_equal(sm->p_scalar, sm->scalar) ||
-			l_ecc_points_are_equal(sm->p_element, sm->element)) {
-		l_warn("peer scalar or element matched own, discarding frame");
-		return -ENOMSG;
-	}
-
 	sm->sc++;
 
-	r = sae_calculate_keys(sm);
-	if (r != 0)
-		return r;
+	if (sm->handshake->authenticator) {
+		if (!sae_send_commit(sm, false))
+			return -EPROTO;
+
+		r = sae_calculate_keys(sm);
+		if (r != 0)
+			return r;
 
-	if (!sae_send_confirm(sm))
-		return -EPROTO;
+		sm->state = SAE_STATE_COMMITTED;
+	} else {
+		if (!sae_check_reflection(sm))
+			return -EPROTO;
 
-	sm->state = SAE_STATE_CONFIRMED;
+		r = sae_calculate_keys(sm);
+		if (r != 0)
+			return r;
+
+		if (!sae_send_confirm(sm))
+			return -EPROTO;
+
+		sm->state = SAE_STATE_CONFIRMED;
+	}
 
 	return 0;
 }
@@ -1013,7 +1040,7 @@ static int sae_verify_nothing(struct sae_sm *sm, uint16_t transaction,
 	/*
 	 * TODO: This does not handle the transition from NOTHING -> CONFIRMED
 	 * as this is only relevant to the AP or in Mesh mode which is not
-	 * yet supported.
+	 * yet fully supported.
 	 */
 	if (transaction != SAE_STATE_COMMITTED)
 		return -EBADMSG;
-- 
2.45.0

