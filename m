Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6991E32A2
	for <iwd@lists.linux.dev>; Mon, 10 Mar 2025 21:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642881; cv=none; b=PxFuGFB7Z513Lpf/FiCQgmEFuMwyS5ZBNV2NKao4iXjnEUeSj85MdyZ+F6eX2ou7PRgM6zCZEX9zNERVe6IxFvhK0Vhub6pNPqkAui5KzW/LTIF5EgpBlap3Ics8yAtkyrQoxsrnu6uaq/1RTjD6n+H/rWRUu8QgN3AX71bvAzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642881; c=relaxed/simple;
	bh=o2x0Ur23K6ROQ9Ffza91iYrSRrhVZcbPnX3Xljp+LA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=THlHs9xJSHTUML9qVnP1IXZrgQ7j0DqaaslAW58MQqljnvbTfoJNQrarH7tBQmTmJQKk0lXTvUPygOn2O5FdB2sk1hx3Ark5T8gOfSqt+VfaDUhDP9GsNALWwKPRzwIGmY299xo64/vwSMJyHZCXgboGysQh1HgFdtGt7r7CAoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8Km8xLk; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8Km8xLk"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47690a4ec97so11388531cf.2
        for <iwd@lists.linux.dev>; Mon, 10 Mar 2025 14:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741642878; x=1742247678; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvVT/A/3zKMBlutOB57nnV1meZrYFUQH+dqnTWyCI6g=;
        b=N8Km8xLkvm8MmQKvQS8rkT3OyguCbn5m0JpvXe3jqLKqlTSDXJdSkFToGeTliTXyNf
         gR1wka0dZwyh/sp69Fau/R53ZaIuKmWsj+Z6p1zM2rIVlNFrpSt0GY+Iwt8Jo4Ia14tZ
         Pe5xkJevTNSOBzSLlRdhnJEwOZvYzzW6pNKWIl3jhdxvQhmJhE0NX0u2qiAOjMu7R+l8
         jpLLR40Okj4vSmg43FhiKpffL6iFR0XK2xHZUTpEr6Wmc6Vbq9hj10eVlh7Yigh6nGF5
         nByq4dBUe5rWvpxe5cP+BTasrjb6dV9yEcz2iFUozWsNchCgNEgvIt1C1R+YijLBZfLj
         soAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741642878; x=1742247678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvVT/A/3zKMBlutOB57nnV1meZrYFUQH+dqnTWyCI6g=;
        b=NvtUptNbKMXq/vktoYNa1PUc2Q83EO6DKgoRPdN/fR0lWf9xYTmHTzmEU8OSerYRkF
         Le/XiK3nU9wX/herCEtQ6TZyKeyPxnDK0N7AqFAJzN6Pi0nOUGqI/vpqzC1JHhr/O3WF
         22lXKkzkcXPRDNzGC6rYBYFPl1rXMk2HSo7tOld6noSj2vK06ifiRs41OeaVhX2LBwZM
         30XYrZImTvZh5MHb2I+ZpinaB1OQ90zJekKcE5LojsEGGxE3Iy6k5OJOyJbR8e9I3M/w
         NrJswKSDPKElLP2pGRvjsxe4RO2am/Ttc9/U6WoRncuyespBdn3a8+Du0lFbFH4TpX8W
         sUGA==
X-Gm-Message-State: AOJu0YzmZdob8gSb/PlS0tF2j/SZtzFjRcdx/vPJBWv0sJs7uYkwYPaU
	rCvJqIMX/FNiiSBFl9dR70fT6VnT6UqqY3lBeTrT/Us+7w++QSOv15p1/A==
X-Gm-Gg: ASbGnctd6R2SnvSneoaLACrCd5+krZTzwIRm0n2ufVKRRLJwOEnX2K44PiJefG95oY+
	Wuza7qFnymzYgVjPVkuHpj4hWMN3CERRRGoTtLUwzYKh+5WakebUoixAhNlDjQRsoe662XdUp49
	ItklIzQmMzs8uiTbAenuc8ivPZWCYQnkQmJzNPzZdqsr/xn1oKJChAsjOE8NCmjdxASY0bFb25s
	YecJg6SEd6y93m6qI3QkpDgEVoP27xdve3qSvTXeL/YgNtVE99SYCyeKhRYTylf69q2Nxk7BksF
	npfB3zvQdk0hsDhkou6PtwKXOfnVtm8nADZVchNS54kDtRl5JbcKCiUHt5ky/AHzWmasTOqFCs0
	3KUA=
X-Google-Smtp-Source: AGHT+IFaEYJLxlso9jEsUmS2pzPavpJtAdxdJ5x3LmYl+x+JZxJojNC3xnbtL8CD/phgJj53W+qLAA==
X-Received: by 2002:a05:622a:111:b0:476:8ee8:d8a1 with SMTP id d75a77b69052e-4769964b5d5mr16111591cf.45.1741642878097;
        Mon, 10 Mar 2025 14:41:18 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476772de5absm30487841cf.66.2025.03.10.14.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 14:41:17 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/8] blacklist: add new blacklist reason, ROAM_REQUESTED
Date: Mon, 10 Mar 2025 14:40:56 -0700
Message-Id: <20250310214059.20809-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310214059.20809-1-prestwoj@gmail.com>
References: <20250310214059.20809-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a new blacklist reason as well as an option to configure
the timeout. This blacklist reason will be used in cases where a
BSS has requested IWD roam elsewhere. At that time a new blacklist
entry will be added which will be used along with some other criteria
to determine if IWD should connect/roam to that BSS again.
---
 src/blacklist.c | 16 ++++++++++++++++
 src/blacklist.h |  7 +++++++
 2 files changed, 23 insertions(+)

diff --git a/src/blacklist.c b/src/blacklist.c
index eef3f730..178cb41c 100644
--- a/src/blacklist.c
+++ b/src/blacklist.c
@@ -45,6 +45,7 @@
 
 static uint64_t blacklist_multiplier;
 static uint64_t blacklist_initial_timeout;
+static uint64_t blacklist_roam_initial_timeout;
 static uint64_t blacklist_max_timeout;
 
 struct blacklist_entry {
@@ -86,6 +87,13 @@ static struct blacklist_entry *blacklist_entry_new(const uint8_t *addr,
 		added = 0;
 		expires = 0;
 		break;
+	case BLACKLIST_REASON_ROAM_REQUESTED:
+		if (!blacklist_roam_initial_timeout)
+			return NULL;
+
+		added = l_time_now();
+		expires = l_time_offset(added, blacklist_roam_initial_timeout);
+		break;
 	default:
 		l_warn("Unhandled blacklist reason: %u", reason);
 		return NULL;
@@ -211,6 +219,14 @@ static int blacklist_init(void)
 	/* For easier user configuration the timeout values are in seconds */
 	blacklist_initial_timeout *= L_USEC_PER_SEC;
 
+	if (!l_settings_get_uint64(config, "Blacklist",
+					"InitialRoamRequestedTimeout",
+					&blacklist_roam_initial_timeout))
+		blacklist_roam_initial_timeout = BLACKLIST_DEFAULT_TIMEOUT;
+
+	/* For easier user configuration the timeout values are in seconds */
+	blacklist_roam_initial_timeout *= L_USEC_PER_SEC;
+
 	if (!l_settings_get_uint64(config, "Blacklist",
 					"Multiplier",
 					&blacklist_multiplier))
diff --git a/src/blacklist.h b/src/blacklist.h
index 6ce26aba..ec4c6de3 100644
--- a/src/blacklist.h
+++ b/src/blacklist.h
@@ -33,6 +33,13 @@ enum blacklist_reason {
 	 * appropriate (after a connection/disconnection)
 	 */
 	BLACKLIST_REASON_TEMPORARY,
+	/*
+	 * This type of blacklist is added when a BSS requests IWD roams
+	 * elsewhere. This is to aid in preventing IWD from roaming/connecting
+	 * back to that BSS in the future unless there are no other "good"
+	 * candidates to connect to.
+	 */
+	BLACKLIST_REASON_ROAM_REQUESTED,
 };
 
 void blacklist_add_bss(const uint8_t *addr, enum blacklist_reason reason);
-- 
2.34.1

