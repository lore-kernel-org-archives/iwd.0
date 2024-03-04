Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B6D20323
	for <iwd@lists.linux.dev>; Mon,  4 Mar 2024 16:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570958; cv=none; b=BeQHlfq2jR2+YnJlSjp0DXwl/VOlA71c8yAesXqNXPCupAv31Y4R1BysXKc9bvfd4TYugd0yT/HU++Ae0giJJYrXKUnWMPVak1/XSAc8kRdsEK92Oi6SChQJa4PQbKMBl8zQdTayK5Z4Co/1KkXPo+Cpjf1YZvO5cIS5dFwL+6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570958; c=relaxed/simple;
	bh=DoDbaFq/tRaaRrzbG/D5UYTxQx9yveG5Zb+1OZEcJJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DZoxdrMGwuciOcwSCZ5AsyVg4wGh8+CSs90HfpimaoQMTmKnfsyQACibytMeMFA5TEglzN5y/d3Y1NWTv6YtZSFbNOn/Oc3aRLqO+saot/YqJnobbGauuB8LJGyhwKIsju90fSNk6f4ks+E1OlGqwfo/1hEcLeDsbrDN8yG8ia4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3xKJiwi; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3xKJiwi"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so4202012a12.1
        for <iwd@lists.linux.dev>; Mon, 04 Mar 2024 08:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709570956; x=1710175756; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=my3yXByJ/TUzRz7KNXfNC3XtRu9W2osDqJMyGwNvrFg=;
        b=W3xKJiwi34Wj9JkXcBdRJY/wMwbkU8mC2952cPxTvETAI8UEu+PQ0dLump5FNTir4Z
         ryIrUf7vvA3ymiB+b+sDfud/5NQw5eJcCtfCPL0lRXwFmLDMOJCq42sYnL+wvzngGPcs
         LkIo9IdpsWjEZQ1tmw2nnkmCldV8oslcwFpcg61W5jRVmgPtl7ETmVYehmiiLZpEWIuz
         wkP015yeyBasuxY7mBkXjiw9haFVs7AKU27p9zW+7tvUuuE8iJTo0tIjBID18VgahwzX
         4yqEkwASkQaLSJ8+5gBxDk556NBlOZXEkLYy4NWn1p6OHC0l98jRSvQ4ENctGNcNL62Z
         xABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709570956; x=1710175756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=my3yXByJ/TUzRz7KNXfNC3XtRu9W2osDqJMyGwNvrFg=;
        b=DBo8aavf4M5TPcoqAfIPsQgMrkhvtDaSaXLAwTwhJNVgU8XMiwygjv1hUPv1lKYVyM
         Id86OuLQjR5Nhl6GZUBFp1fxHPbMKQeRRd4zdq32/F5IpuL3k4R4PjntKR7Tv20NXoFG
         dvn1Wad13894pJ061yVlXzwuehktbL6umrD1U2Ho6b6vASVpwbw8VaDdQueQl8cKYb/c
         IkVOIURJqpLnND0KQLphkJj1OTgyiZ1QyBY/ubPSVtVX6XSa+BFc5E83npxKR8k4RzUO
         sg2fWXop4EjrnOvDGrDmHtmZmexvnrCkgu9XAgFq8Lz3z6HJZekcS/qJJM9EpvBSL6Ox
         Lfrw==
X-Gm-Message-State: AOJu0YwINRPLNjNF1SfXHZiUzP3LkF7f35jwJZ8/1QHt8xNIeNIEhV8I
	Y/V9iZM14ybqnPIyFTRgvPXjk4560XLmUzxrlUi/7XwIOUr4+tIpwHIse3ni
X-Google-Smtp-Source: AGHT+IGBdJL9evt/3LqscKdalTwqDpLGD1gew3p6cnJPHq4mj64FGR82w8YyvMsYwAkQBWvLAEewYA==
X-Received: by 2002:a0c:eb06:0:b0:690:5cf1:e14f with SMTP id j6-20020a0ceb06000000b006905cf1e14fmr7938867qvp.44.1709570934819;
        Mon, 04 Mar 2024 08:48:54 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id qq1-20020a0562142c0100b0068fdc55ec7dsm3858466qvb.68.2024.03.04.08.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 08:48:54 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/5] ie: remove unneeded initialization
Date: Mon,  4 Mar 2024 08:48:43 -0800
Message-Id: <20240304164846.1783148-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304164846.1783148-1-prestwoj@gmail.com>
References: <20240304164846.1783148-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/ie.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/ie.c b/src/ie.c
index a51724aa..86f33f2a 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -1178,9 +1178,6 @@ static int build_ciphers_common(const struct ie_rsn_info *info, uint8_t *to,
 	countptr = to + pos;
 	pos += 2;
 
-	akm_suite = IE_RSN_AKM_SUITE_8021X;
-	count = 0;
-
 	for (count = 0, akm_suite = IE_RSN_AKM_SUITE_8021X;
 			akm_suite <= IE_RSN_AKM_SUITE_OSEN;
 				akm_suite <<= 1) {
-- 
2.34.1

