Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A4D78C9C
	for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704193; cv=none; b=NzYe19iJs6WgLNj0qsXzkwBfDA8pGUb5wG9yihednzz2dcKrlwVAbgrHtLjrMnI+XqEbdOlSkbuhP8pQZVS0yvbs9SMQNeqsa+EsItDTImEFGWSAFehPu1QXIJKOtf22MWnX6sXhYEhhY7ktkabYvMKj8T4fvh4UeFo02HuP85o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704193; c=relaxed/simple;
	bh=djLyw7aYUk+qkqAn0atiZBaXa2GRGxYfWD4ZFmvmdsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gMmERxT8IJzZssa4LQyDMXagexTGq1+6W45gk56InT4t7WlKvl7rZTEjKSMC1B15U7yLQl508jCGGxTRpRN1jLAHVj2mOyB8Wvl+NRks2mWrxMI8GN2WF5bt37LbBpAcvcQsM69r1yeUjqn5Izzpp0YNuT/W9q22XbwTiRSrEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fn8q2mh5; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fn8q2mh5"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7ed9f1bcb6bso11107a12.1
        for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729704191; x=1730308991; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIn+TlYTrJoVD1XDoEmtFlHWtnNeiCHFqm3HATKm+qM=;
        b=fn8q2mh5oOXVpUDlPRkV1hwOW3+MapY+GdfmvtfEE9xia/7BNSsNXge/vBIBHsVVR0
         D2xs+kjolwBWGD39xmZL+0EPyhRm9aHJ25soHtosauYLighX+z0YGu2ggJArzEMJpROy
         3mEE282hNYdQx/7YCfmqfWBrs+eVwU+E6yyh4/MigHD2z0TvhOX0RijEFkfLnQh7AEC7
         I7KYqIr81iDkRZIOyLRghVP5deqBWLCLH8aME56WB6uImQOZYq7oaCuiyGp1CIdgbheS
         6h69yR+adrDdnVGCa+DkexNDNkFa/z7UY/mNv4XO1tnTq8SNHdVQgps+RDLgMrqIKxKs
         K8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729704191; x=1730308991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIn+TlYTrJoVD1XDoEmtFlHWtnNeiCHFqm3HATKm+qM=;
        b=rDTfGz91/VQfDLrc6jckntx2g+f4vcjJo4BPFZhV55DRiCpIGp6h5PytPR9kgYvQ5z
         prn2SCa6k/n0x65ikCzkSwPCVl37T0IowDudnX7nlkt0QHZ1s5KTqUyvoprGFSqpLbor
         ax3Grznxt/ZwHPYtNLbYFuWqciOubOfc0i4Kqaf2nfj/ZURC0y/IgP/x/jANKfH1nWWd
         ffKODzvGUkLUnMdBjEvo6CNh0pIaFiVRwcjpa09Mf7Y5pz53Q6NOgpXb6ue6NQdRqYO4
         wQTOGeFDwc6379ScX67wi4zBtM4l8ahSm4EK6w+DOJtd6d1G43uP2TPuFcsE+E0lkRq/
         KJmQ==
X-Gm-Message-State: AOJu0YzpJ+7eM6hjM6rFmPfjXog7S09nVXS/SxgvT/dnKsl4kHqVVQKs
	sa4xzkevPpKtUFNqvSFwvEnN1gaykOIhJXcWavJ9TVkqzw78t0IQIfrXRhNU
X-Google-Smtp-Source: AGHT+IGH0DC/kN6ddr14P0Ofgf5h/wN5HKMxfGoPed/a8UYfT3QKJPCqWACYqpKC8cus4V33BmSAJQ==
X-Received: by 2002:a05:6a20:ce44:b0:1d9:3acd:68ea with SMTP id adf61e73a8af0-1d978b2da6dmr4587949637.25.1729704191394;
        Wed, 23 Oct 2024 10:23:11 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1407ed7sm6551923b3a.214.2024.10.23.10.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 10:23:11 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] network: fix OWE transition BSS selection
Date: Wed, 23 Oct 2024 10:22:56 -0700
Message-Id: <20241023172257.112771-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023172257.112771-1-prestwoj@gmail.com>
References: <20241023172257.112771-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The selection loop was choosing an initial candidate purely for
use of the "fallback_to_blacklist" flag. But we have a similar
case with OWE transitional networks where we avoid the legacy
open network in preference for OWE:

/* Don't want to connect to the Open BSS if possible */
if (!bss->rsne)
	continue;

If no OWE network gets selected we may iterate all BSS's and end
the loop, which then returns NULL.

To fix this move the blacklist check earlier and still ignore any
BSS's in the blacklist. Also add a new flag in the selection loop
indicating an open network was skipped. If we then exhaust all
other BSS's we can return this candidate.
---
 src/network.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/src/network.c b/src/network.c
index 5a856fb4..dd09a98d 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1281,6 +1281,7 @@ struct scan_bss *network_bss_select(struct network *network,
 	struct l_queue *bss_list = network->bss_list;
 	const struct l_queue_entry *bss_entry;
 	struct scan_bss *candidate = NULL;
+	bool skipped_open = false;
 
 	for (bss_entry = l_queue_get_entries(bss_list); bss_entry;
 			bss_entry = bss_entry->next) {
@@ -1300,30 +1301,34 @@ struct scan_bss *network_bss_select(struct network *network,
 		if (!candidate)
 			candidate = bss;
 
+		/* check if temporarily blacklisted */
+		if (l_queue_find(network->blacklist, match_bss, bss))
+			continue;
+
+		if (blacklist_contains_bss(bss->addr))
+			continue;
+
 		/* OWE Transition BSS */
 		if (bss->owe_trans) {
 			/* Don't want to connect to the Open BSS if possible */
-			if (!bss->rsne)
+			if (!bss->rsne) {
+				skipped_open = true;
 				continue;
+			}
 
 			/* Candidate is not OWE, set this as new candidate */
 			if (!(candidate->owe_trans && candidate->rsne))
 				candidate = bss;
 		}
 
-		/* check if temporarily blacklisted */
-		if (l_queue_find(network->blacklist, match_bss, bss))
-			continue;
-
-		if (!blacklist_contains_bss(bss->addr))
-			return bss;
+		return candidate;
 	}
 
 	/*
 	 * No BSS was found, but if we are falling back to blacklisted BSS's we
 	 * can just use the first connectable candidate found above.
 	 */
-	if (fallback_to_blacklist)
+	if (fallback_to_blacklist || skipped_open)
 		return candidate;
 
 	return NULL;
-- 
2.34.1

