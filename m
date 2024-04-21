Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FAE12E5D
	for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713703965; cv=none; b=bgEhPlzFIHKUunSyoV8nH39As2VfQzk59ouTDV9EMs1atIeTJ3BNechwVd4LTjUSVKRwlgCfCqXxzHLnl+1kr+ze6RH95HxmuGeqIjfQyxGTqg/2FrawfJSlI6sjJ62vNP6sycQIFKM1lnratpypbK0KcVEjfGx6S58N/cEFJQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713703965; c=relaxed/simple;
	bh=mOrBtvb/O87DA9cM+OzwQGRSxUY6LlePRXqX2XtUbX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RfS8k6ZzJ4ReXPG982gUX49/G1SNrmVSoO7yzGn8ziL5aBFqPTnQsSGdj8Hno+6UikhcVsSSrV1vkOgh1aT6cPbdET/uZ2NOooqyKB7n+jkZiXnJEwpejWXt9C7AAMBSpR47Z3RpcqQ6Qi2rs+njRS43CLHDmD3/J7RWS4wJlSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnUtn90u; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnUtn90u"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5e152c757a5so1912671a12.2
        for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 05:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713703963; x=1714308763; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LzaY6A57nF1oLrl5mii6eRbRZ0QKu/MJ5EaRnOTB94=;
        b=mnUtn90uGSNLxhDWCXDxRQfMFrQKRieNg+PHVziJtbXpM5D63cmwhSqatqm7kJ2CWh
         osE/tTzsG9HE06So/2ROzCm5exBsOUki7j6dL1uurK/TiafV59frv+aHBLlSzlUhQlTg
         pYSwvuL/WX/AEyRrXvQ/NTjNb9P2zm2bjfjz+Ksry2ZojwgC0eDMoYIGj3jA7Tw+95pZ
         aK0qclYD5A0Msymrj5UKgaxL/W32bLU2WCNr3GQDssiNHyuEVGofTpUdWFtOu0IdsIxZ
         xe5+Aby8R3GwiBaO92Jv3WF++paoVIr2HSSt8jpJPTfsdGB7mPAqCA/fEqkk2oTFYfa8
         2a5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713703963; x=1714308763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LzaY6A57nF1oLrl5mii6eRbRZ0QKu/MJ5EaRnOTB94=;
        b=gXYPtd5PNotLjeL3JDSg+evvdwrC6h6YyIW8pMkUP3DSUO4HId98gyhreqxSDg1TnC
         S3Oy5KGlQjzDoXsqly/e37Ms9pw1RawvxbMSx8GPPXb7FcwgT2bwvFK2+ZP+iIWCKPv2
         Oe2LtkPg0i4RbvkE98ni4KajlFFeTa5Lhms6Et3dDlok9SjB082vHIdKv/LgxRzCA6PQ
         nJbL20rAN1gZutH8lYvphCVd33cWNThp+zdxeEDVhetN2PNHyHZydJsJn1m37tS9ihRi
         ZvvDHeWAIJzAgipRQsNixKYDq+XpUF8Fl+RBorhP1iKi33zQMU32blaXtFDLt0fC2iPp
         HuYA==
X-Gm-Message-State: AOJu0YyDKCAS0TW4huWMWSKuGYhvDSic+NTbcDDypbXPGxe9fv5Yfujr
	d8cskyqmQs+Qtf0GpnisYQCFHbsug9ZcEN3Q7buOHVdHw0KHIHJk9EavmD4G1UQ=
X-Google-Smtp-Source: AGHT+IH9oJal4FWJYTOElKfBMUd1yvJAs0/8E7Mgcky1Gav9dimq6UlHytILPdsH6pS604RMKTi7NA==
X-Received: by 2002:a05:6a20:9144:b0:1a7:919f:2b60 with SMTP id x4-20020a056a20914400b001a7919f2b60mr8064815pzc.37.1713703963337;
        Sun, 21 Apr 2024 05:52:43 -0700 (PDT)
Received: from localhost ([185.169.0.163])
        by smtp.gmail.com with ESMTPSA id az24-20020a17090b029800b0029bacd0f271sm7619545pjb.31.2024.04.21.05.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 05:52:43 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH 04/11] sae: refactor and add function sae_calculate_keys
Date: Sun, 21 Apr 2024 05:50:34 -0700
Message-ID: <20240421125050.6649-5-brandtwjohn@gmail.com>
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

Refactor code by moving code to the new function sae_calculate_keys.
This will make it easier in the next commits to add SAE support for AP
mode.
---
 src/sae.c | 83 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/src/sae.c b/src/sae.c
index c133386f..314fc28f 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -683,10 +683,9 @@ static bool sae_send_confirm(struct sae_sm *sm)
 	return true;
 }
 
-static int sae_process_commit(struct sae_sm *sm, const uint8_t *from,
-					const uint8_t *frame, size_t len)
+
+static int sae_calculate_keys(struct sae_sm *sm)
 {
-	uint8_t *ptr = (uint8_t *) frame;
 	unsigned int nbytes = l_ecc_curve_get_scalar_bytes(sm->curve);
 	enum l_checksum_type hash =
 		crypto_sae_hash_from_ecc_prime_len(sm->sae_type, nbytes);
@@ -702,39 +701,6 @@ static int sae_process_commit(struct sae_sm *sm, const uint8_t *from,
 	struct l_ecc_scalar *tmp_scalar;
 	struct l_ecc_scalar *order;
 
-	ptr += 2;
-
-	sm->p_scalar = l_ecc_scalar_new(sm->curve, ptr, nbytes);
-	if (!sm->p_scalar) {
-		l_error("Server sent invalid P_Scalar during commit");
-		return sae_reject(sm, SAE_STATE_COMMITTED,
-				MMPDU_STATUS_CODE_UNSUPP_FINITE_CYCLIC_GROUP);
-	}
-
-	ptr += nbytes;
-
-	sm->p_element = l_ecc_point_from_data(sm->curve, L_ECC_POINT_TYPE_FULL,
-						ptr, nbytes * 2);
-	if (!sm->p_element) {
-		l_error("Server sent invalid P_Element during commit");
-		return sae_reject(sm, SAE_STATE_COMMITTED,
-				MMPDU_STATUS_CODE_UNSUPP_FINITE_CYCLIC_GROUP);
-	}
-
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
-	sm->sc++;
-
 	/*
 	 * K = scalar-op(rand, (element-op(scalar-op(peer-commit-scalar, PWE),
 	 *			PEER-COMMIT-ELEMENT)))
@@ -823,6 +789,51 @@ static int sae_process_commit(struct sae_sm *sm, const uint8_t *from,
 	/* don't set the handshakes pmkid until confirm is verified */
 	memcpy(sm->pmkid, tmp, 16);
 
+	return 0;
+}
+
+
+static int sae_process_commit(struct sae_sm *sm, const uint8_t *from,
+					const uint8_t *frame, size_t len)
+{
+	uint8_t *ptr = (uint8_t *) frame;
+	unsigned int nbytes = l_ecc_curve_get_scalar_bytes(sm->curve);
+
+	ptr += 2;
+
+	sm->p_scalar = l_ecc_scalar_new(sm->curve, ptr, nbytes);
+	if (!sm->p_scalar) {
+		l_error("Server sent invalid P_Scalar during commit");
+		return sae_reject(sm, SAE_STATE_COMMITTED,
+				MMPDU_STATUS_CODE_UNSUPP_FINITE_CYCLIC_GROUP);
+	}
+
+	ptr += nbytes;
+
+	sm->p_element = l_ecc_point_from_data(sm->curve, L_ECC_POINT_TYPE_FULL,
+						ptr, nbytes * 2);
+	if (!sm->p_element) {
+		l_error("Server sent invalid P_Element during commit");
+		return sae_reject(sm, SAE_STATE_COMMITTED,
+				MMPDU_STATUS_CODE_UNSUPP_FINITE_CYCLIC_GROUP);
+	}
+
+	/*
+	 * If they match those sent as part of the protocol instance's own
+	 * SAE Commit message, the frame shall be silently discarded (because
+	 * it is evidence of a reflection attack) and the t0 (retransmission)
+	 * timer shall be set.
+	 */
+	if (l_ecc_scalars_are_equal(sm->p_scalar, sm->scalar) ||
+			l_ecc_points_are_equal(sm->p_element, sm->element)) {
+		l_warn("peer scalar or element matched own, discarding frame");
+		return -ENOMSG;
+	}
+
+	sm->sc++;
+
+	sae_calculate_keys(sm);
+
 	if (!sae_send_confirm(sm))
 		return -EPROTO;
 
-- 
2.44.0

