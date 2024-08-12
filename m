Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DEA16D4DF
	for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723483019; cv=none; b=ANBKm85ofCKZaiBd9V2GvH5NckYq1DNTPbZqjuQMDW9ATMSvty5rUG11OL3Sw26aZditcy1f62RYngx4kxiNB9WBAWAX4OxTTkYgDyw6NMGBJ1n0PSgtOqZKSlEQXdjmdyKgTiZCR7Dg0Zb4yYlbvbGniRgjecM4QfbvX+IM/E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723483019; c=relaxed/simple;
	bh=ClcEZ3H3cApisXv5Ttm4PL5KofRxHlOdgQ2zdc78BgU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J9Dqc6lRhB/NCAmq3kSF8GlxPHaixtOERg4D7xUb5npZru5IaZnOii3j8BeTZhDZhHB27PQeZ+NRti9r57R7NA/70msvOpkg1UxWmwGrTSDfGxCB2RMduzPGQucP5jsDbW+krEuCo/D3UNxAM1RwUbVKSaVUqD4o4LumWovZN8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3UhBNr6; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3UhBNr6"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so479849966b.2
        for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 10:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723483015; x=1724087815; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e/YsVcI98Ga8C9uJHtlonm5I15d8+7Qs9Rc5jNWNgiI=;
        b=V3UhBNr6/Ji5s2sgerzGxJ4KCwAaVubJGEHnV7PKeXGJIj0DgQcQ6+AGOCApXQY6Pz
         rZaeTmXx7ciBkB9O1AxdlTTq/86VQkZCBZRNQVElVPhU2GlWdLdHZpPyWwXMZWTc8IYd
         kHXFCHDceX6piU7KiJ/h/jsa4txnVIrmLa+8xp7Sh2MIXoYm8BUISkDEL/fiTPKG4565
         UGv2P/o6PLkSQSnXlTppN6iGlLPC7rmgK4RuOeS+/jqOM63EnMrzK9egvRiTKFhWMYyg
         NbL5zTuO5AM1gEd7MGHVAw5KhaXQb/CcPphzx+KD1vhlcBLGAm7otglP3VGr9RCtuhox
         fDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723483015; x=1724087815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/YsVcI98Ga8C9uJHtlonm5I15d8+7Qs9Rc5jNWNgiI=;
        b=NLCqVc9OHjhoVjHsJ99/9ItaJR3t29iRbGikQrBn7Uexd6B2MXYvl/XomA0nunLDR6
         tnaaBwXX+pWIYA5YuHx9pN3w5CyLs/wZIqUlwSS471zfQGKwM6+O45Zx5ZAp77+hReb2
         eE+01DMkRXRxRfs5+8ADmSICvY2NifAmBs37DDj2F+Pk/LbVbUIp+9VDdQ/ofSm3Jeb/
         /zIUvhIz/I2kuD3elLpizCxyaytfj0+/MEtqGa+tgYVwig99nKXOxKMmEXoCvNfU6BbS
         uPe5uU77FufAZ4u5Vr0pIW26SCpy8CMoL/4auNWMrAfLvhV5CAtSpHvlCPwLtka8t9QR
         zZBw==
X-Gm-Message-State: AOJu0YxVR/FVcKHZtxJJfmszhuZQF8IIiPvy9JH6EMaVYURyJOrDv/Pp
	zE8gT3sWwptsRiLrYAsvNHmSRshGVAYIDlv/g276wTstKUYJ4xT9QILf/w==
X-Google-Smtp-Source: AGHT+IHDzrk0cu9RcEQFDFD8RXeOVTRvkemyFa5zjvPSpoht082il/KYOrFAlIomOKqg9m3AL66xoQ==
X-Received: by 2002:a17:907:f15a:b0:a7a:a557:4548 with SMTP id a640c23a62f3a-a80ed1c1ee5mr75970566b.21.1723483015116;
        Mon, 12 Aug 2024 10:16:55 -0700 (PDT)
Received: from LOCLAP699.vf-sint-niklaas.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb2422efsm245695466b.197.2024.08.12.10.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 10:16:54 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] sae: support default group for H2E
Date: Mon, 12 Aug 2024 10:16:49 -0700
Message-Id: <20240812171649.163687-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was seemingly trivial at face value but doing so ended up
pointing out a bug with how group_retry is set when forcing
the default group. Since group_retry is initialized to -1 the
increment in the force_default_group block results in it being
set to zero, which is actually group 20, not 19. This did not
matter for hunt and peck, but H2E actually uses the retry value
to index its pre-generated points which then breaks SAE if
forcing the default group with H2E.

To handle H2E and force_default_group, the group selection
logic will always begin iterating the group array regardless of
SAE type.
---
 src/sae.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/src/sae.c b/src/sae.c
index 9bce8faa..97c0af05 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -152,39 +152,34 @@ static int sae_choose_next_group(struct sae_sm *sm)
 {
 	const unsigned int *ecc_groups = l_ecc_supported_ike_groups();
 	bool reset = sm->group_retry >= 0;
+	unsigned int group;
 
-	/*
-	 * If this is a buggy AP in which group negotiation is broken use the
-	 * default group 19 and fail if this is a retry.
-	 */
-	if (sm->sae_type == CRYPTO_SAE_LOOPING && sm->force_default_group) {
-		if (sm->group_retry != -1) {
-			l_warn("Forced default group but was rejected!");
-			return -ENOENT;
-		}
-
-		sae_debug("Forcing default SAE group 19");
+	/* Find the next group in the list */
+	while ((group = ecc_groups[++sm->group_retry])) {
+		/*
+		 * Forcing the default group; only choose group 19. If we have
+		 * already passed 19 (due to a retry) we will exhaust all other
+		 * groups and should fail.
+		 */
+		if (sm->force_default_group && group != 19)
+			continue;
 
-		sm->group_retry++;
-		sm->group = 19;
+		/* Ensure the PT was derived for this group */
+		if (sm->sae_type == CRYPTO_SAE_HASH_TO_ELEMENT &&
+				!sm->handshake->ecc_sae_pts[sm->group_retry])
+			continue;
 
-		goto get_curve;
+		break;
 	}
 
-	do {
-		sm->group_retry++;
+	if (!group)
+		return -ENOENT;
 
-		if (ecc_groups[sm->group_retry] == 0)
-			return -ENOENT;
-	} while (sm->sae_type != CRYPTO_SAE_LOOPING &&
-			!sm->handshake->ecc_sae_pts[sm->group_retry]);
+	sm->group = group;
 
 	if (reset)
 		sae_reset_state(sm);
 
-	sm->group = ecc_groups[sm->group_retry];
-
-get_curve:
 	sae_debug("Using group %u", sm->group);
 
 	sm->curve = l_ecc_curve_from_ike_group(sm->group);
-- 
2.34.1

