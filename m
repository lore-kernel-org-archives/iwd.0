Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B981E3771C
	for <iwd@lists.linux.dev>; Mon, 13 May 2024 18:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715623251; cv=none; b=hU+pBnwoq1rpwdi61ZM8HaYgnITQnLOs/g5wdv7E/5bKQCJKErxoHLi+LjQwWP/Eg/WtCMqBx7ftRMH3PZCHah5CkVDKIDYqou5QOdo2mYXJjjdZXLdALPozzwMHj63Sm9pabzNpd1vWN9K0b2woYMyWaE2Z5YBmPn58NbuqakA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715623251; c=relaxed/simple;
	bh=TKWHuG/tbsMV8V76BucLoYhc+rcmGhtQ2T0+f3CTANc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NjGCi2/KC4T4O/Zh/6sd35uB2eW41QD7aaTfXYa4MVw19v/eCMrdON2BiLJ+xd+nEgFKt7mjcshmptksv9K2ulTDBzN/nvLobG5xGctZ6mzz57LTWpyArr+hdX3XWAXDIf6DRooiAu91CDPNXdF/rR1Ml3YLfpkKfTv6y9GGsqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfW1m4cl; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfW1m4cl"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-792b934de39so419519585a.3
        for <iwd@lists.linux.dev>; Mon, 13 May 2024 11:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715623248; x=1716228048; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knn2iLBvhcrVipri5wYgGGxxl4wlCeOxBhzDhdyvaIM=;
        b=nfW1m4clNqv7FNrfl/KMHCwjnFHnzVRmYbmh5PtF5vq0LrbjPrSrfRq333cNLnnMuP
         PbJJEiYYPb0R1HHlCKwvWwG20iAHadtvohGteyhzjZLqbsP+2w/Yg9hm/t/eHGhSp+DH
         KfTfWRqFFkRjfRX6uJgPv9nY5vD9B4kWkFdxcKvPKD6xWl7iwc5sLp+YrdhX3CkU1Gj0
         D1xs8rl7NAH29qJjj4hgYkuG1A3LwSk+k4YYuB9X3m0tTJOx1Rca3T3a4yJXtiJFr1N6
         YFGyvm0ajRqY03IGWcqrTzb8Wodm4gpOjIsoCbED4VI0nj7d4Uet2+54MwZwc5esLEy1
         RkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715623248; x=1716228048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knn2iLBvhcrVipri5wYgGGxxl4wlCeOxBhzDhdyvaIM=;
        b=LsZS6sT3iSKVZwqW2hu40IlhrTAWn6L5hX1BWBwcD39wn3i87oRA+wPHbUdrOZXUNk
         2qHV3iPosX2FoXuLO6OuTVvNhPtFVUzbW13OoA685lmpnniljQDQUQgFlxsXDzwMv8OT
         FEksKS+lR7Z62sQrtkglM4uhf8YPeZqXfdtYBel4TmxOvKp1iybVc3Q7hFKe7pxHoeFp
         3t+d3sG8OpUn3sDyAHFBzvd9b6smB6BtIUuGvcoIdY4u8gk5xpmY7cvpgDJiPnnjXuc+
         x+kQ4NwTaqOVGVJgJPfGALJaMDESXi1pxU5SYcnVPLn5Egfw2hahJfqbJiKb47L7dQYM
         +smg==
X-Gm-Message-State: AOJu0YyIg6ToEwFStFSD06J9pqSPIE7u3wlfXQzblFoAjZVs9Qb0rf7M
	Ab4fDWEwMSv5kysn654cCRMM9YclzZsVQFRm0G+focgt2PsWS1Ljeav9vw==
X-Google-Smtp-Source: AGHT+IEXMKXjYqey38SrptVyUu6q2u00SMkk8Rou0C7DMEZX3rIvwXPPz1cQi5t3rBfqX4FPXNUumQ==
X-Received: by 2002:a05:620a:cc3:b0:792:ad22:68fa with SMTP id af79cd13be357-792c75ff7d9mr984903485a.76.1715623248410;
        Mon, 13 May 2024 11:00:48 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2a4b38sm479404385a.66.2024.05.13.11.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 11:00:48 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] ie: remove is_ie_default_sae_group_oui
Date: Mon, 13 May 2024 11:00:41 -0700
Message-Id: <20240513180042.257401-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513180042.257401-1-prestwoj@gmail.com>
References: <20240513180042.257401-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is no longer used and instead a generic option was added
rather than referencing a static OUI list.
---
 src/ie.c | 26 --------------------------
 src/ie.h |  1 -
 2 files changed, 27 deletions(-)

diff --git a/src/ie.c b/src/ie.c
index 86f33f2a..b180291a 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -1509,32 +1509,6 @@ bool is_ie_wpa_ie(const uint8_t *data, uint8_t len)
 	return false;
 }
 
-/*
- * List of vendor OUIs (prefixed with a length byte) which require forcing
- * the default SAE group.
- */
-static const uint8_t use_default_sae_group_ouis[][5] = {
-	{ 0x04, 0xf4, 0xf5, 0xe8, 0x05 },
-};
-
-bool is_ie_default_sae_group_oui(const uint8_t *data, uint16_t len)
-{
-	unsigned int i;
-	const uint8_t *oui;
-
-	for (i = 0; i < L_ARRAY_SIZE(use_default_sae_group_ouis); i++) {
-		oui = use_default_sae_group_ouis[i];
-
-		if (len < oui[0])
-			continue;
-
-		if (!memcmp(oui + 1, data, oui[0]))
-			return true;
-	}
-
-	return false;
-}
-
 int ie_parse_wpa(struct ie_tlv_iter *iter, struct ie_rsn_info *out_info)
 {
 	const uint8_t *data = iter->data;
diff --git a/src/ie.h b/src/ie.h
index 9ada64bf..024eacaa 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -634,7 +634,6 @@ int ie_parse_wpa_from_data(const uint8_t *data, size_t len,
 						struct ie_rsn_info *info);
 bool is_ie_wfa_ie(const uint8_t *data, uint8_t len, uint8_t oi_type);
 bool is_ie_wpa_ie(const uint8_t *data, uint8_t len);
-bool is_ie_default_sae_group_oui(const uint8_t *data, uint16_t len);
 
 bool ie_build_wpa(const struct ie_rsn_info *info, uint8_t *to);
 
-- 
2.34.1

