Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E1E12E5D
	for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713703959; cv=none; b=P1XxEHeeBdZWpgZXNKY2oqEMUKKgRGno1O7RRqwsad04FJwUzXbhaX00xENiHeOeAoY7Thud18RZT/fZsokoDvv6+UksDvJAoAlghGlgiavDo9y8qhCqDGWLNo6tNTZgnLjcPPh+iZbhrRIbS3Rq/tTbPejB3ZzKqaH9WphKTIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713703959; c=relaxed/simple;
	bh=XS3N9TXiZR2t9btDNSsbSR2l4D53tczUBHoPxliL248=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5Fi/LLKn4AjUs9IBeGJUsUgG849k5ANt8t0mbxrnf9nYvnysN6z88XGD8EWt9l3mnW9baKl7RQm2IZ9gdPSmw0MCPP8rfCqRHcgL9rI6huUHp+wZTwFp4exSZZQGhk0aeuk91Ny/TdYHsFD/fTnjikX0HY1rReiJd8r7OY9ujc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLHg00z2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLHg00z2"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e3f17c64daso23446665ad.3
        for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 05:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713703957; x=1714308757; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qizgE6fsw46paMjka8kiwSg1lVdq4XDQntLc2mKU4Bw=;
        b=ZLHg00z2faxtzxfEAWqIiJSc0hQ7T6tkEFLtAA7QO13VvrdVrN9ktSXbne2m7nYYvc
         uNObK4cReumkOyqsKkOS+wxXtpW7V7E3FmuNewABUzRzGeXtYS4Q/V1AwzS2EakLny/1
         NUHeooTAg/mGVZ2tWvwQnmWZ4bb9kQ8nxjix2nvdqoJJUpSaiAywFzsZRB6bl88b4TAy
         dgJdK8I5PIs0GPm4LzF/VAX38RQ4d1NIa1/6Iq/0c0BcqrOrc3MNqFoYl/bBUVpKq26E
         mKuJKvdLpDNPferiJbl4Tj36OOsweTB9oIk9eHFMWUMHc1iRBFkQmXuuHYWYiDCXv5p1
         rngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713703957; x=1714308757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qizgE6fsw46paMjka8kiwSg1lVdq4XDQntLc2mKU4Bw=;
        b=dKwOlYQ2O6YYO+Yd6diCqzuA0UJZuOPIcDCtze0tg1Fq4hHys8qFap74fmfOsKOVV+
         4X3VfCPCTb9Ptbcm5uK/hv3mzBT0tbFGtLuoaqYAuzpo/oeub08PezlZqeJP0IIz0tfE
         gQeK7svpQcfxB22IGh1gf3FkCkpPPiCI4bIvaSNo37mf3wQK833HK3KUTpBggGDOnyz7
         Sobn+Hos7oMmhfDBbx4FfBHrb7R6Xp37Pqcg/xkQwjKiM+ZfkSAFi8r/OXQxlq99McOx
         f/ETo/d1PQHAHpS17G+k9v4ehWla+fCq58wahlyBMuK1ec/vg5Umv/iE5cGPPHa72VSS
         gujQ==
X-Gm-Message-State: AOJu0Yy1WjjObR5NdWTQvIZIzcXm/FHiPqPuY5E1/eDkkAV8+OYhkgzK
	dg9ops7JDy5vRxFlxVFKGlBVTAgwdwtLnLJ/N7S7U6h4tzx6OnYkJI2pJ11Xdnk=
X-Google-Smtp-Source: AGHT+IG6StZmp1j0W5Kk8uMuIu0PYNVDF7wFcD7sZpqF+62fCq6vZvjHNOCJyNWy/orEjemhn1iukw==
X-Received: by 2002:a17:902:8210:b0:1e5:c0ee:a7f5 with SMTP id x16-20020a170902821000b001e5c0eea7f5mr6522751pln.24.1713703957438;
        Sun, 21 Apr 2024 05:52:37 -0700 (PDT)
Received: from localhost ([185.169.0.163])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e5c800b001e420abf8c1sm6303975plf.165.2024.04.21.05.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 05:52:37 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH 03/11] sae: add function sae_set_group
Date: Sun, 21 Apr 2024 05:50:33 -0700
Message-ID: <20240421125050.6649-4-brandtwjohn@gmail.com>
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

Refactor code by adding function sae_set_group. This will make the next
commits easier where basic SAE support for APs is added.
---
 src/sae.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/src/sae.c b/src/sae.c
index bf9fb0ff..c133386f 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -148,6 +148,16 @@ static void sae_reset_state(struct sae_sm *sm)
 	sm->pwe = NULL;
 }
 
+static int sae_set_group(struct sae_sm *sm, int group)
+{
+	sae_debug("Using group %u", group);
+
+	sm->group = group;
+	sm->curve = l_ecc_curve_from_ike_group(group);
+
+	return 0;
+}
+
 static int sae_choose_next_group(struct sae_sm *sm)
 {
 	const unsigned int *ecc_groups = l_ecc_supported_ike_groups();
@@ -166,9 +176,7 @@ static int sae_choose_next_group(struct sae_sm *sm)
 		sae_debug("Forcing default SAE group 19");
 
 		sm->group_retry++;
-		sm->group = 19;
-
-		goto get_curve;
+		return sae_set_group(sm, 19);
 	}
 
 	do {
@@ -182,14 +190,7 @@ static int sae_choose_next_group(struct sae_sm *sm)
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
2.44.0

