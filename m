Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E171A44C7C
	for <iwd@lists.linux.dev>; Mon,  6 Jan 2025 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177677; cv=none; b=OHT+FGB+ZX23scTy4hmjywwphqHUiVfNVb6yD6YJqYOUkOYHGnU97JTaKXjuh2Rf0cc0p9CWpR4f+1AKYS+dy0NEsD1PdJdW5BL0KGyM6UCRfAMZcssze13w4qXHIFbjnwfExZxOEQSjYMC8m2UZGYkWihSEFsZTm6hhvOtGLQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177677; c=relaxed/simple;
	bh=WQe2CofyA0AU5qgoj463zU77VgVu8wZsHrLeOYCrRUE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bCBnJEwK9IY1sS2CTVcjzKi5gi9qJ+JLSXp6VryKqKBWfx3lJ7PPpbFMwvURBh5LOTDjVZ5Z3OP4pL0vVq0g+HQ7hNViJrE8WsLI5zapyyOmAeh6qPStk+V/VT4XRIoxYDAH3M/UGj8IUoLSZKnGj4xOwcZXwNcmrWDB+aMuteQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GWUlXdaM; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWUlXdaM"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-467725245a2so96480041cf.3
        for <iwd@lists.linux.dev>; Mon, 06 Jan 2025 07:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736177674; x=1736782474; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=irHvVh81pThMMJqVAmyAGs+lPfcZMrl9SYS3CgwCrKo=;
        b=GWUlXdaMY9E95ziGX8y9/YTNVe9TMHOaPUVrG1nyr7g0cd7Tl7wDexqVZQt1ETMwMy
         fJYUBYWgijcM5yZi95Wr1XEbvOLIytDNJVI9sBsKOh+1jpuF2by9WMQWXU5gA5PxGQwH
         WSh1twV3H7U31etGLOjJDayrJE4gk6jtjdGYCUt19L3sI1GIOBqUu6hTJzNuHxu28RBK
         ifGQATSP8i/YwfJh+LLoIgx+CRx4h6v5Z7V62rociTIWYdFQagK34mPN4K9He/j2YwN+
         lt2auLWKnwzagvbquwLZ1rHSfoXHaIpQrj0xDzDdEiYuXXsplnizEOrIytSgTUcGvjQH
         cTkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736177674; x=1736782474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=irHvVh81pThMMJqVAmyAGs+lPfcZMrl9SYS3CgwCrKo=;
        b=iVoAr53BW2pWTFBAYxk8dxrSHkRkuhL9vo+CupL8TgufsYbZYAQjeaEJXlRvhe6ToJ
         12vJptLtWLH6Ab5VryRin1UzHPCBtNuk1c0zYntoJZfTpmVDRtoBlBgYb2L9rPvJRsN+
         5cmqElgklGYld7LTZOBqc0iPqE/wgtSaI/DaeAKQ7Bxh9CByagei8WBkfxrWYxb8CxFm
         Mkn+13acVnU5UjDxWBXgWkrk+HBW4BsUNuxEJzs/MbyCrZNXiiXdD95jGvsuwok9rygb
         Cif8eNEX3Zy4cBi0qXMeF7QF1riPkbHzU2HvUY14XtK4d+dkVwKsG3MGnTe1O9CTHgSg
         TUdw==
X-Gm-Message-State: AOJu0YxtjTGpK8oL2N/WtdohrDlcXd8u9JtVMImg6ffyiM8v96xfSSN1
	umlrN9D77x4N48TW3scmX8r08lelljjyX8qv8TQpafnW0JwhCEOv4Qezjw==
X-Gm-Gg: ASbGncts8Gq6I1kZs8JeTonhO6BGEmU1YIjd/kcOhhFvvp/YPeXzPAs3klSjqKOZ02g
	f2+ggj4q+tp/n4l8Qg20mKbP3LykznghJyRTmbWa5oKiGxVv4emQZHSQGUyPYpT0ApXyofQMXna
	kDR2Gu6oPsOHAGEP9EFRuO6GsoSpHRkTrlpannGvsgPjmtRJFeb/nFNfs71TH7ogDrPE/uhAbq0
	MfZ2NTqYlfzhHa4TYfzN6Fo7U59POfETgL0xEBj889800cZzS2mkMIeSv1mn2ryfCh8TwwYZSC8
	4ik6zDhxuUXw7tw=
X-Google-Smtp-Source: AGHT+IHe53LJ1SigwBYaX2Fu9z44aFBYo1kdkFJODOXJ5cuu+KPAPPo7DHlYil6LtkL0NsE9mIRSqQ==
X-Received: by 2002:a05:622a:347:b0:467:84df:92ee with SMTP id d75a77b69052e-46a4a9a69f8mr975045181cf.40.1736177674416;
        Mon, 06 Jan 2025 07:34:34 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3e6a60bfsm176334001cf.47.2025.01.06.07.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 07:34:34 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2] handshake: add more debugging around PMKSA caching
Date: Mon,  6 Jan 2025 07:34:30 -0800
Message-Id: <20250106153430.132452-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of just printing the PMKSA pointer separate this into two
separate debug messages, one for if the PMKSA exists and the other
if it does not. In addition print out the MAC of the AP so we have
a reference of which PMKSA this is.
---
 src/handshake.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/handshake.c b/src/handshake.c
index f73f91d1..bee31beb 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -1272,10 +1272,12 @@ void handshake_state_cache_pmksa(struct handshake_state *s)
 {
 	struct pmksa *pmksa = handshake_state_steal_pmksa(s);
 
-	l_debug("%p", pmksa);
-
-	if (!pmksa)
+	if (!pmksa) {
+		l_debug("No PMKSA for "MAC, MAC_STR(s->aa));
 		return;
+	}
+
+	l_debug("Caching PMKSA for "MAC, MAC_STR(s->aa));
 
 	if (L_WARN_ON(pmksa_cache_put(pmksa) < 0))
 		l_free(pmksa);
-- 
2.34.1

