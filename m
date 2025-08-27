Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEE534A32D
	for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299318; cv=none; b=moTPSHJKTNpGkkyd5oGcLbyozEDr7lnQnFizPmdiKLMf6Y83/34MiJ3908xLRZ5vhLVse+CyNxW8gR/GnZadv/Mtm1cWgBArSDJGz3fbdfxmfpXJactXdPN3eaMXGW/UnR9aZR9BvBANkKY2JJ9IPCrdBVHtwdKpx1ZF5cx0cdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299318; c=relaxed/simple;
	bh=WqtMKtHxKS/yUyQH+RcZR6D79Jl2V0MltTfVE65bBxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CUPOJRRV5Mt6bSTTkriGix4xed++QUGH8brImJlDNO5K5ZHROUWohad05+FTPNYMmyo0N75qif70mh/9qd7RVUpXcB5d+qPyeWBrVMFuSEoSWKXEyNlnoFEPFFBBJGh59ArX0RTShTj4EItMoDVAoHa/13abYXPn/mnzamXI7A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQYkbJVg; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQYkbJVg"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b47173749dbso4696937a12.1
        for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 05:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756299311; x=1756904111; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3xNeJW4zEeKL5oDftHS3ORaZRiBkFCn97F9u37Kobs=;
        b=WQYkbJVg6oyGZE7gJJthygUc1jO3JR+KiEOUhGKViySsxrscX5OmeorTc+A6szJFVk
         XZq1uMfPzDOYpJ0LqMGr5CWEXfOs6mWAV5Ffs01Ca4GM+KuKX39atDynC3eEx49y767a
         gXe4fu/CtjTBUrxbpJ2pdRtp7icqbWCf7OSkMHp3NkAC52CBO7UQ9avMyCbg1EHis/zg
         ZIbdERvvC8VAmjXWufXHt5RGk6WzZi7QLvkYPxDJw2UuQHG3qMcEwb/KfBxGI3slM0LN
         pLeocLxs1H/hhloW7Oh5KTaEOmlsBa8JKouk5Gy5IQGnWFBKL6LtG1sBfoWzCV2tzV+o
         22Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299311; x=1756904111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v3xNeJW4zEeKL5oDftHS3ORaZRiBkFCn97F9u37Kobs=;
        b=c8KSaPpNZ1bVACVrftPTLO1lTquygP9B530mFLffyoxx3YZn9eMLWSsUACxoz/S9d8
         mlUnvT+ViMKjxinoSz0yeJzxvPcexEuz+FNuF0FHemJ5dV/D7HzXHBRUwF2dkKERQRCH
         yMeHY2Ew3X0ISFK9JxtZnoU2Jyoq+I5/pq2+1dAv3f+37ahYFwzwOrcPQRel7QEKZlDl
         wz675sy+KvXn+xAWNjuhfUqmCNFWhKiUMXL96f3SN6rsVA1vc/DugzupUFgL+UEE/OCD
         b/lc4pJId3fnm6D3eSOc4o0aTJBb9YBa4N7upLgLAI4xQ4r6FOFgw5OSrnbMl3PTvdXk
         p1DQ==
X-Gm-Message-State: AOJu0YzkmcLxhHb7GeEMcIC+NDWCBp+vY+mokfC41IAgqDKRUyIYQUc4
	U16W6QZ7JUrYQu2uYnOcK9tvTiH69O20KQDpHpPdxnRqmqVf+pRXZDr4hPpDlQ==
X-Gm-Gg: ASbGncuep8ySWC98/06eE6Ar9fcrxD8uByFkNC7h4KHDfhg2PG4BV0oOz+JbCSuBI/A
	3oEVz5waOheztDfBI5ZNWr/6Xpd+cnpir57sSzmFnYfLLgu95ItUZ1U5xsBpXWBlJlMoR/FSjr0
	qNq0G2tQPjI9EDTzrCPweLhceZS0ITgGTiIwXgqaRJpkPzXMNPIbYpxdnwyXmRdy8v0VFQK2Yz9
	walAJsb1N6gZnjm7zKAB9vXw85/d5sykFgWZWVpjo2kIzwcmJkeI03+xeXzgEP4+/Fa22l7RhfD
	p2H9yl/Sna//XMpuh+qx3xIY9TEm4y6L3A0eknLm/ReyDz9r4Nr9V4ksU/4Mp/vtBxWoUFZUDyj
	DmmdYdFMtXXErQXquAiqnDxWgSIzgu/M7E5loF9G7MJoroTHO2u5x6hKFw0YB3HMY7MitY8YKJy
	85SLAlbraY
X-Google-Smtp-Source: AGHT+IHnI9qS7roDGfCGNFhdUXOPCQZULTnDsk73a9uXLsB+Yjux2w11qAroImO7StNPrbxq05sXEA==
X-Received: by 2002:a17:902:e888:b0:240:640a:c560 with SMTP id d9443c01a7336-2462ee54507mr269351915ad.24.1756299311453;
        Wed, 27 Aug 2025 05:55:11 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687c75b5sm121650955ad.66.2025.08.27.05.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:55:10 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 08/11] station: get neighbor report on BSS TM request
Date: Wed, 27 Aug 2025 05:54:58 -0700
Message-Id: <20250827125501.477908-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827125501.477908-1-prestwoj@gmail.com>
References: <20250827125501.477908-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a BSS is requesting IWD roam elsewhere but does not include a
preferred candidate list try getting a neighbor report before doing
a full scan.

If the limited scan based on the candidate list comes up empty this
would previously result in IWD giving up on the AP roam entirely.
This patch also improves that behavior slightly by doing a full
scan afterwards as a last ditch effort. If no BSS's are found after
that, IWD will give up on the AP roam.
---
 src/station.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index 66395a5b..3d8eb36b 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2440,8 +2440,16 @@ static void station_roam_failed(struct station *station)
 	 * We were told by the AP to roam, but failed.  Try ourselves or
 	 * wait for the AP to tell us to roam again
 	 */
-	if (station->ap_directed_roaming)
+	if (station->ap_directed_roaming) {
+		/*
+		 * The candidate list from the AP (or neighbor report) found
+		 * no BSS's. Force a full scan
+		 */
+		if (!station->roam_scan_full)
+			goto full_scan;
+
 		goto delayed_retry;
+	}
 
 	/*
 	 * If we tried a limited scan, failed and the signal is still low,
@@ -2453,6 +2461,7 @@ static void station_roam_failed(struct station *station)
 		 * the scan here, so that the destroy callback is not called
 		 * after the return of this function
 		 */
+full_scan:
 		scan_cancel(netdev_get_wdev_id(station->netdev),
 						station->roam_scan_id);
 
@@ -3045,6 +3054,7 @@ static int station_roam_scan(struct station *station,
 	if (!freq_set) {
 		station->roam_scan_full = true;
 		params.freqs = allowed;
+		station_debug_event(station, "full-roam-scan");
 	} else
 		scan_freq_set_constrain(freq_set, allowed);
 
@@ -3378,7 +3388,15 @@ static void station_ap_directed_roam(struct station *station,
 		station_neighbor_report_cb(station->netdev, 0, body + pos,
 				body_len - pos, station);
 	} else {
-		l_debug("roam: AP did not include a preferred candidate list");
+		if (station->connected_bss->cap_rm_neighbor_report) {
+			if (!netdev_neighbor_report_req(station->netdev,
+					station_neighbor_report_cb))
+				return;
+
+			l_warn("failed to request neighbor report!");
+		}
+
+		l_debug("full scan after BSS transition request");
 		if (station_roam_scan(station, NULL) < 0)
 			station_roam_failed(station);
 	}
-- 
2.34.1

