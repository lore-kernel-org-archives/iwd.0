Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377B8212B3F
	for <iwd@lists.linux.dev>; Tue, 25 Mar 2025 18:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925656; cv=none; b=WY8eOcO+HYUws5g94hkm+XVAofT3y27VJgzeHcoc7O+dKo4qKhWHFlMLfoOVequed1EcutsxWI1VJLKN6PT8oPRM08YNIOZVLdHOJjjDQzM7EehYdS8KlFfc3Gz0BLnFOJnyJh7mB53W6ZQ/z25dGDmJy4OWidqK4nP9Nklqcxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925656; c=relaxed/simple;
	bh=vDMF1T7eOH6GKRhUt+QPWTp09g7OL2BHBiDtBRsFApw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hnc+aNmGs88nOcXbi77wmYjgEaaCy8okLb4goxmtzqQIx1g+eSfToAIJIuwERd82/+DaiyZ3uZsp95GTqVXo9fIFtzsmDli8A6vdIq/q7P6vouiYeaqw7HLvFD6iNkD6FFmLe64HMB4S2pYOHsDQGa1OX2hWnEL2KB+/WeukPrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jixqFrlV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jixqFrlV"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2260c91576aso101064715ad.3
        for <iwd@lists.linux.dev>; Tue, 25 Mar 2025 11:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742925654; x=1743530454; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fo6eEo8vd4Ttv2jHt80DI0ch0RyPh6KEYVVJ7ym4bGI=;
        b=jixqFrlVpHp4PWi5RxaELTP5wyU1SlpBcOHaI0UrP5RVpb3Ow2MIgzcwN0MZAV8f65
         kdNMeyXjYxd67HXvibXR2mMU4Xqbj/WtIEN+qN9azHouv9Bw6uPrXQ4fjReof+Ck+X9o
         q2wJHc1FvjVix8m0+KZOFJWsvt0csl1lFqcQsSHfHc5/bxNM1/rIJRIgqsv+6BseCQaJ
         YCIFSe9pRAeZo/XHZR0aY7rmvE7Lst/9do7MI7oZvr08jxBHRKzzBDnyHv0Px4O7wFdJ
         tXs07w07FgBJfbqjZFJeXewjmaTt2wDFaw4mupif/Jm1Yr3TD0EpCbVLF13vJFO0dCln
         psJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925654; x=1743530454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fo6eEo8vd4Ttv2jHt80DI0ch0RyPh6KEYVVJ7ym4bGI=;
        b=ihdBMaoKpMRnHnf8rniSceJeEDSNdPJPMSFv/Q4nMxsBrE4usESsxklnVeBHCLcqvn
         E+ew8BuSVLMyPpDArcu36ynpxDC6lxRV+JB5FMt5+HzJcnkG980TpnWHHQ3T4G4SW9Ro
         VAc1sIA9lah4z4mvm+y4th71jd4i1QrZEpJ+XCNdwZ5UvWPay045yKhonmpA4KjpPRSQ
         rZs7AVZ9rJE8YCNlWbO6vmYBfrFezoOl+5wJJP7BJTI1cpAnXZX/rloEkT4Ss+ZFYrsL
         cpCyO7ffF9qevwFHYfQy9P+4p2JF9CEfEdmyzApZjCfs7D6YYdMFnIR4UaWnWgCrVBpq
         Znhg==
X-Gm-Message-State: AOJu0YyiWxgyyRCbTB821NglIjaPKXug6zTiBvZh5tHVrTaPgI8dQSBQ
	GZOFVshdHsKxIxHQk+d9/G5pEYs+MMnJU/5h+mkdHr1e1xJL5aL87HImEA==
X-Gm-Gg: ASbGncu272yEuSYpI/MKsorScEp0APRgizaG+okj5DbnkpKXXo13JOilEErF2lAYbfi
	cHqveWsSN4VuzRZ9Ohu54wdQeZnu5OfT/hHFety9R7G5hhRaOn8x15XfgEIMNdbYLbW/km0rEP0
	elR3a+o0J9gREj1czZ3X2lqk30FhwR2Abnu2VvCX6P3XWh11Hi725aJRqZ3cTgmnJAa6J6Yxpvd
	S5qcLUUK++DyZx705nGL0JnPJNlduFo5vHa9+E4A6h+JVzZoM4+FEs7xhdulDY/lEfy08xGk8JW
	OI4g+d9xNKyr+084t0BLdXTp75SttI2l5zfn+SkNlG0IeOM78Jd2tchl3vvlrwORwy8+Fj7E4dQ
	0eB8=
X-Google-Smtp-Source: AGHT+IGxvDX4Fu3FA01VSxeBLNuunP9ri6gcupA6UFsuq9gxcHHVG6lZMp/O8/T8csWXcRIS9ftS4g==
X-Received: by 2002:a17:902:f649:b0:224:1157:6d26 with SMTP id d9443c01a7336-22780c544admr311231915ad.4.1742925653926;
        Tue, 25 Mar 2025 11:00:53 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811bae9asm93770515ad.138.2025.03.25.11.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:00:53 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 01/10] station: always add BSS to network blacklist on failure
Date: Tue, 25 Mar 2025 11:00:32 -0700
Message-Id: <20250325180041.238676-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
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

