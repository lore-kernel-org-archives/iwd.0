Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D0F2F5A
	for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825756; cv=none; b=O5CwU6/aApuHsq+h08wmjFvyYBrFktvJ1XqFBFAu5xzoP5vafWXyVCvimPj5dzZ9DTa8njIkYsSLmN4uXD8ZHUgE4q1ras9DkbsQ9rFPAW/UkxyZWXPjQNpJUqyR8gOe+1s2ohC94oeBj2tvCh7+kcotiAa9m78VoDqro6m7qG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825756; c=relaxed/simple;
	bh=vDMF1T7eOH6GKRhUt+QPWTp09g7OL2BHBiDtBRsFApw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lng819V0nrsMy53At8s2vlj+hxXXtKhLi5+r/wqoXcnVgLxyLpUZ5gEkoJvvwuunmIl2Mz9y1LSwjflLgQdSfOP1kz+nIGsuSKuth36HTC8EdlY4qKL/cknaxALMS79iEZaX1KGdpXRLQkyX0gou3WqNtSDLTzXM3kT+mZU+kyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTuKsjdC; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTuKsjdC"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2279915e06eso28348835ad.1
        for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 07:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742825753; x=1743430553; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fo6eEo8vd4Ttv2jHt80DI0ch0RyPh6KEYVVJ7ym4bGI=;
        b=FTuKsjdCcVSTlLQs8b+vHMLgNMcJeXohGLiOoxQTy9JuOA0zcKWO1aHLiUSwIv/EKF
         ySfj1/CwZBeAqqu77S0tBbRQKF2FnTor00r/SfPuvRlvl3+pXbV2uR/aUM+zPisKjbZF
         ISFBqqT6B7556H/pS+CObA+TNjENSvojJxpM2EwJLRi3IV/qsjJSulmTTgNd/y5Gq6nl
         CjJnd/wZZuTpUaokDp6LWJhsF2WzRl5bWofJ9Jz2ySNP0nO57cS0pyF0Q/vgUc+eC9RD
         3wM0biNWidC88pbJkU5ThQKmGLuQSg3K0tTYVUdHSqDnwl2FpmqpZyGF5UUZrEum1t3H
         6Vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742825753; x=1743430553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fo6eEo8vd4Ttv2jHt80DI0ch0RyPh6KEYVVJ7ym4bGI=;
        b=jNrm7pRe33MqM5VePtfMdeb4CHibovOLCzkOp46igQCwC1D54vhcdDDM1Z1u7THgvR
         qX2cZopW3Wcx3jNMLjPro7yLcumZyNT3aWXewUBu544ocVXxCcEaxs9hFjl5TGXU93wR
         A1/7stQk9UBjU5sRfYFax6GMAiLRnD2sc1fB+YhSDe1w5/vBRbWwHSUolhfgkShdSKLE
         nMef2goxjsX3aF36mXWv7xY/Dwu7mv9R//CZh6zihlwEP6q1vi36s9+hB4doPBvqhZdY
         ZkkxpFaMOA06wTJdxaN6+GRlMBVEdWZZcAGCPCUXECfwKuQbofh43RQuyN1yJdZMc8bY
         zMlg==
X-Gm-Message-State: AOJu0YwOUkydOLTwnFxKvfjpEb7q+wuMugmwUMJiE9au0jz6Uq/93xmm
	uRZvFl75JrDm++c43tCk9PHPbofli7UG5ICIjG+RCDml00Uwr+lo3BJCmQ==
X-Gm-Gg: ASbGncsJX/Alb5E6GGIh+b4Ln7Kw5u5c4MHD/6wSvYKFfI6UMximeABAkSk2asc9lPB
	GJUFMLp9mArP/q5UPkA3whI9koieConGyJwVmVM3AvAqUnDeddhygOcxsFNI0I7Y94zvub/FpP8
	qXnldWAvfAdtmCxSlfeSQIlI+sGgkTM5uLMzytey47fgz3u/QXTgYuhAA3pDOJg2iZO/HW1l0Nj
	V1lAV4G5kIfmiRs7jt5NTt4wCCLUOHFZL3TX3pxqslpjOrMg5ThnDtygIw+F0ncEGewdVOuVUhV
	SamaxRAMTOYChnHtmiyj/Z8v7eTxCN+VqDg/4KepcT+cj5LNqQJgu7k=
X-Google-Smtp-Source: AGHT+IGsMa1WNA5KNiq35/z2rXg/5Du330zhbZcXR4eAQYbneXA7EYALaiv5d2weWKpAD3MTTNnHeg==
X-Received: by 2002:a05:6a00:179f:b0:736:a4ca:62e1 with SMTP id d2e1a72fcca58-7390597ec8fmr20386424b3a.6.1742825752448;
        Mon, 24 Mar 2025 07:15:52 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd54efsm8007868b3a.37.2025.03.24.07.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:15:52 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 01/13] station: always network (temp) blacklist on failure
Date: Mon, 24 Mar 2025 07:15:26 -0700
Message-Id: <20250324141538.144578-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324141538.144578-1-prestwoj@gmail.com>
References: <20250324141538.144578-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allowing the timeout blacklist to be disabled has introduced a bug
where a failed connection will not result in the BSS list to be
traversed. This causes IWD to retry the same BSS over and over which
be either a) have some issue preventing a connection or b) may simply
be unreachable/out of range.

This is because IWD was inherently relying on the timeout blacklist
to flag BSS's on failures. With it disabled there was nothing to tell
network_bss_select that we should skip the BSS and it would return
the same BSS indefinitely.

To fix this some of the blacklisting logic was re-worked in station.
Now, a BSS will always get network blacklisted upon a failure. This
allows network.c to traverse to the next BSS upon failure.

For auth/assoc failures we will then only timeout blacklist under
certain conditions, i.e. the status code was not in the temporary
list.

Fixes: 77639d2d452e ("blacklist: allow configuration to disable the blacklist")
---
 src/station.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/src/station.c b/src/station.c
index 5403c332..0b20e785 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3402,6 +3402,13 @@ static bool station_retry_with_reason(struct station *station,
 
 	blacklist_add_bss(station->connected_bss->addr);
 
+	/*
+	 * Network blacklist the BSS as well, since the timeout blacklist could
+	 * be disabled
+	 */
+	network_blacklist_add(station->connected_network,
+				station->connected_bss);
+
 try_next:
 	return station_try_next_bss(station);
 }
@@ -3449,6 +3456,10 @@ static bool station_pmksa_fallback(struct station *station, uint16_t status)
 static bool station_retry_with_status(struct station *station,
 					uint16_t status_code)
 {
+	/* If PMKSA failed don't blacklist so we can retry this BSS */
+	if (station_pmksa_fallback(station, status_code))
+		goto try_next;
+
 	/*
 	 * Certain Auth/Assoc failures should not cause a timeout blacklist.
 	 * In these cases we want to only temporarily blacklist the BSS until
@@ -3459,12 +3470,18 @@ static bool station_retry_with_status(struct station *station,
 	 *       specific BSS on our next attempt. There is currently no way to
 	 *       obtain that IE, but this should be done in the future.
 	 */
-	if (IS_TEMPORARY_STATUS(status_code))
-		network_blacklist_add(station->connected_network,
-						station->connected_bss);
-	else if (!station_pmksa_fallback(station, status_code))
+	if (!IS_TEMPORARY_STATUS(status_code))
 		blacklist_add_bss(station->connected_bss->addr);
 
+	/*
+	 * Unconditionally network blacklist the BSS if we are retrying. This
+	 * will allow network_bss_select to traverse the BSS list and ignore
+	 * BSS's which have previously failed
+	 */
+	network_blacklist_add(station->connected_network,
+				station->connected_bss);
+
+try_next:
 	iwd_notice(IWD_NOTICE_CONNECT_FAILED, "status: %u", status_code);
 
 	return station_try_next_bss(station);
-- 
2.34.1

