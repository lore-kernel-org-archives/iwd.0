Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4801C3029
	for <iwd@lists.linux.dev>; Fri, 28 Mar 2025 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172984; cv=none; b=qKy+hu2vNZjK6Kn2soO422evDLR6mNWDn1xWZiWjeESOrnqVZdMg5aUd5Y+91hba4wa8+iVNBhu2qLf7w0+/o6XEp/pLswqtON++Ewf0AJdPZzFRZG6RvCCNxBV1zT57Mk2dRC3OEOKHNHS7ZdzCuzD/3ZXw/dsj6q0md1ESOtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172984; c=relaxed/simple;
	bh=vDMF1T7eOH6GKRhUt+QPWTp09g7OL2BHBiDtBRsFApw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NQHGq49ZelDeY3s2MYbKCffIKzT+D6RAvF0Uhu5tWZXxpCfoUU/caxbLz2dmwRXCEClyCrZH5FgrEqRz2JNV6a4LUdlIEYb6WesBBo8y9lx8pdDFNrWY3EYuwfIlxeExwd6tmtTkXdOTPRefvWb/EPy44POF7q9L4C5ZTONGMss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Twzphd8o; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Twzphd8o"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22409077c06so68824865ad.1
        for <iwd@lists.linux.dev>; Fri, 28 Mar 2025 07:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743172982; x=1743777782; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fo6eEo8vd4Ttv2jHt80DI0ch0RyPh6KEYVVJ7ym4bGI=;
        b=Twzphd8oO2jk/gGkItbKe6gIP1qJfE58f1jV+SwEvFUBIV54DlwA7NUHky+Gm8bPj/
         ocNk+eVMIQeevQ7ppynuEawSIW9n0nZjp3rIU3auAhyrlYdgf31cDtI3+ufDoWK/a2+t
         84o9ELav172RTD3vpBJMDH/xLxloCA8nx7icFS6R9J353PaccooohCDiADMuiyXtD3oH
         9qnMsvkr3Qj8BDu11JDiA+foq3ibfziL3hHG6QIlFqMGsV7j3HadKpBMT+fmL3KBZW1w
         rHtpHYbnmhGXydp4DQ3FaOcB+Z9eviHDMvF/XnlhDGSt7hdj3plBmClUS1nOT3a0g3i1
         JuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743172982; x=1743777782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fo6eEo8vd4Ttv2jHt80DI0ch0RyPh6KEYVVJ7ym4bGI=;
        b=RlZaHHb3AEe/mdu2GF8SE1DzV/tutEHM47fID+6h+ii9yVZaQarCa/qN21y0XYD3JI
         /2bWRxwpjz52QxkLQOpQfreXFU7GSMu51jp0+kqg2xm4HGT2HQdPPQAk9t6sWoec++92
         5xTYEkM1ysV/g1gmKek0r+s+efYkq9oj1Uxx9iRlvWoQMXPnlurI2v74M8JHthaRa07E
         +bKH1OzfwVOcpku3HgnN4uiSMYCOqmBfskd6r4Q2VmGsrtUR+YrAuN3osPH1DSx2ubZV
         ByiEtJ72ww901CMmKLs+RLu9SCWAd+p0MZL+ft5kMu2EFTi3DVBo4p6aslVxLl5Ik4wt
         /dOA==
X-Gm-Message-State: AOJu0YzN/XDSVP4Yj42KfdD9TDcTRki06ugb5JbGJRX3No06zoT+Lb6o
	/Gh82oE0uBuSphzUjOLyOANdUjZEIQUhOI+XX7ehxP5wMKqXS21dLEcxBA==
X-Gm-Gg: ASbGncuRP/xRoGw+OABlF6chqWDt6SAvmryThK6PMPsxQ9FaU/Unwh89rOkcEnEIEWZ
	S0cXaCRKyqlYPGFDUhOXqsBUmZNbRpOXrCFhcznTv/YWZXYHYQZjzJHV7BLpiFVL0d7Wrx6COO8
	o0wuKLzojCeILZODvUhcpFPNfd0vXWJWgrHHOW3O9tyIsmxq/KkIS7ZN7uJQqb1ZTgXO768ZBsr
	ro8V8TZ24IF8v0z4lDWH4pgl/40jUi37W3X/JXZpnpAFqO8wHq03jtSGJnQ7HJSuBoiJLiTDRMO
	wqLo20UF7FFkW8qW0GlSrX3DD+R221/DWjQpiodB/lBhsPfWjmIuhhv9IVj1U9D06PaDd3HX5GT
	dnEoblGoz3A==
X-Google-Smtp-Source: AGHT+IFhMdTByEauCZRnBIyUIpXqYbAzIq7p+sEpQznLlDwMGCmSlFLm12y1mTwIWL840qW1yrRl9w==
X-Received: by 2002:a17:902:d4c5:b0:229:1cef:4c83 with SMTP id d9443c01a7336-2291cef5008mr65381955ad.4.1743172981806;
        Fri, 28 Mar 2025 07:43:01 -0700 (PDT)
Received: from LOCLAP699.locus-demo-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eee2288sm18885515ad.87.2025.03.28.07.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 07:43:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 01/11] station: always add BSS to network blacklist on failure
Date: Fri, 28 Mar 2025 07:42:43 -0700
Message-Id: <20250328144253.421425-1-prestwoj@gmail.com>
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

