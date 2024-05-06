Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F4F8BFA
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 00:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956508; cv=none; b=TrWZFIVsBLns9z5VDZ1n3trZxWM+WjiPOcij1hk90/tweXguegNQelrzEBUMQWaGYe/I3ou6eAu1TxQcTS1xEdWVdQx0WpD/AQmZZYHndUE79M3b55tjid+IyZ/gc53IfoLyoAT7Xwae32C2+6H4bGZAMjOHGgcYMv637cZ/Zv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956508; c=relaxed/simple;
	bh=OeuAfC5/i4anyI1Sr1JU8BOz6JYpFG5PZ8FtkVWlGnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ocXlYmccR50C+Z3XTJF1mcUgVrENJItAZkt9m8lShKz7Lbxr4tuK9bTjKbC5LeWBN3e4NtKFyRLb2WKeW5t8VWG8ALzNeKXv7r7E98SRvbMM0EmU3nXCjhiBwQ/2WPADfloYX1aoZMVJW8YoAZJ+kPdMSK2AwK9qMAuybJnQaZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZD6GNb2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZD6GNb2"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ec4b2400b6so9095725ad.3
        for <iwd@lists.linux.dev>; Sun, 05 May 2024 17:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714956506; x=1715561306; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ogxyIB/BEIoUGrPRouwJmtOO4YR/Fl+j9yOQFR7H35w=;
        b=OZD6GNb2bx4sop69f2SMm/E4y5jxEktNnw/+Oj2APhuYvUQpVx1/m2sdlD+hUn1zma
         pMyqvmk0KL3r92SgqmQTu3vsrrDCFa3p6M30icoh9qhkYPzLUUK7f6o7dpCfTgZS6bkl
         8JqffMymVGo7OuEe7sCjtBPxokSGArlELEv7T/iBWuMV4gKUcxTPxUzeF49XeFoPaNkI
         VT5b82e2tb+8vsFocVZglKyX4U9xt3oAb8UKnZDNDuPwMazlalk7Y6wH8a+43AGUSa04
         owleKviVVl8SsuVf798bCPpE4rS5XSN4pZ2sjJKtoJ0ouZQioRZBiA6BmV02jZI7ZMZM
         t9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714956506; x=1715561306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogxyIB/BEIoUGrPRouwJmtOO4YR/Fl+j9yOQFR7H35w=;
        b=jpYiFozGhJ/jg9XDAaIiwrDu/U39ZQtp6EtmRIXIbl8n5aJxw2aUcwwbVNrN5+IPEL
         WphLOKyrAlSmf3iC5QCelLCCOHUntTeQNTBoftCiIfH2jgTYu7r+CFLzpibU15+23b9M
         j6N7ws5aH1HT8469iFBcG3NIcrciCpIdMGB9PA4AHQLXiQzn/evA9BZ5ccADfG9PqDNN
         Pa4oxly0njeq6NHp1G0OMi3vXbjkPzFuI6+7NBJS3HzFLwgH9LVEuVP7JzAxeRDgRqnt
         Dotg0f/IfonYO+9/dEFmHxp2eeBUQoyG8HhYNGLh/T4jo70ZgfPbfM2bZnC9B1ge0zyc
         COeQ==
X-Gm-Message-State: AOJu0YyusrDMDZqh1G+qiFeizHBmMl/1fOFjTiZRu67EQ65eazAiS6Tv
	uwW8y6TBH0lJp7Wi3Y7TheWV2J+ITanJJ6M0fOp0WiyVdhNmoVQ41qDg2g==
X-Google-Smtp-Source: AGHT+IG1HehAPQCiegyZk8dnRXiNG62f3o+vIrIoH5oa4DxL7WqwLZ/iWEDYUgxqCZW2njXrEPU4pA==
X-Received: by 2002:a17:902:dacb:b0:1eb:527e:a8ad with SMTP id q11-20020a170902dacb00b001eb527ea8admr12654660plx.51.1714956506119;
        Sun, 05 May 2024 17:48:26 -0700 (PDT)
Received: from localhost ([192.145.118.41])
        by smtp.gmail.com with ESMTPSA id d13-20020a170903230d00b001e43df03096sm7030342plh.30.2024.05.05.17.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 17:48:25 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH v2 04/18] sae: add function sae_set_group
Date: Sun,  5 May 2024 17:30:27 -0700
Message-ID: <20240506003518.320176-5-brandtwjohn@gmail.com>
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

Refactor code by adding function sae_set_group. This will make the next
commits easier where basic SAE support for APs is added.
---
 src/sae.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/src/sae.c b/src/sae.c
index bf9fb0ff..4e0b73d8 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -148,6 +148,18 @@ static void sae_reset_state(struct sae_sm *sm)
 	sm->pwe = NULL;
 }
 
+static int sae_set_group(struct sae_sm *sm, int group)
+{
+	sm->curve = l_ecc_curve_from_ike_group(group);
+	if (sm->curve == NULL)
+		return -ENOENT;
+
+	sae_debug("Using group %u", group);
+	sm->group = group;
+
+	return 0;
+}
+
 static int sae_choose_next_group(struct sae_sm *sm)
 {
 	const unsigned int *ecc_groups = l_ecc_supported_ike_groups();
@@ -166,9 +178,7 @@ static int sae_choose_next_group(struct sae_sm *sm)
 		sae_debug("Forcing default SAE group 19");
 
 		sm->group_retry++;
-		sm->group = 19;
-
-		goto get_curve;
+		return sae_set_group(sm, 19);
 	}
 
 	do {
@@ -182,14 +192,7 @@ static int sae_choose_next_group(struct sae_sm *sm)
 	if (reset)
 		sae_reset_state(sm);
 
-	sm->group = ecc_groups[sm->group_retry];
-
-get_curve:
-	sae_debug("Using group %u", sm->group);
-
-	sm->curve = l_ecc_curve_from_ike_group(sm->group);
-
-	return 0;
+	return sae_set_group(sm, ecc_groups[sm->group_retry]);
 }
 
 static int sae_valid_group(struct sae_sm *sm, unsigned int group)
-- 
2.45.0

