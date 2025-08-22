Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4310A2D641F
	for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892300; cv=none; b=RRqVVselIb/6fyficqAgNuuXq58XrT20UaLye2TDL3u2TLEWdqs4k50/u00nzUhgq8Ign9pRZHzqiJq7RwHxJK+7Dil3ANZgSjxPNVjR6yEZgw0Mg4pxbRS9ssx5lj+sp30N/kBkrNbVSc2WYRGJB92qH1UVZWzBYxGRNk3xIzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892300; c=relaxed/simple;
	bh=Q40k4njED19tMvHkzflOswt2NKyrA6vyuA7BA+63Lv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r595Ga44RIhkTMqyfdD/qGYWFYyrFd78zKWB0i99hKc2xrDtDqIXhp3g9l3vSZJBo5CWR1vchrG3oRGedk+kd2YiL/Pp5fP5pgwhbFkolf4HJG+WXH50yima0PjorxJuFV8+L/Ufm5PT9fvNNYirlx5A/QMg9/rMPVdgilGWcQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHCUckWp; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHCUckWp"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b109c6b9fcso26966061cf.3
        for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 12:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755892298; x=1756497098; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22D0UU7qqfFkLhEIXpwsiLoB5s8BI5j8uqmrKOsMUOs=;
        b=DHCUckWpzcQcRjy12+Z67SRIYkHsk+XOAvxv7zynIAhuKw+lEulfpPwlLSu+19o8Na
         gY2DDi7AkV2PGx+i48C7ZUbkwlXMIdkbqFQLIKtklGYNpnZjs/S4gpMNXs+x+pWlRm80
         NXCcrpHt2oCkDci7vtHgpMct2vZAmYAmtb7TcM8Ym4vqbFsLmw70+KsWElzWjb7eMLGW
         9eFPUw9CpScpnzVpL2lhIaUpi91rcorqN1FsWG537xxa641+LvONKKq3faCZzzqWr9T8
         wbqLUdCybImk63T7Jg541GGKDagS6ZljoTv5ustLYzZndXpQFgKrmaQZEmmHgONIZo0K
         akBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755892298; x=1756497098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22D0UU7qqfFkLhEIXpwsiLoB5s8BI5j8uqmrKOsMUOs=;
        b=SdxUtbYtQG4oqGW7xjYuvGvFZpflYGTdAsc+q3ZXc3MFeKPQoJ+iNTzIU+VzDVreLd
         jsHsvM8PTQmtm7zeI2+TYpw721vjiwb8+Crk9A2gLaRGwuawuPF4KOKrkpBnvKdihrHn
         NM9GvMNNk0SxHDqwIGwt1KbNfGlLO9oJJl7xPeAi28DbjdVltAryd6yIulkSDwWijobf
         v5uemuxs0kwlCv/8m9FGVtOq9TMTagL1y0a+QnNBQ5VUPbG1MTkeJzcZ8NpT51ErTUkC
         Y+3QVrIlc5pKXdYj27GLa+5XblRxhqLKtGcWt31LGKZfu4UtLCDvqe19gna34EI/sUOJ
         XlSg==
X-Gm-Message-State: AOJu0YwsEca7rvhU++a+YH1Flp4wdXTaI/HPYU2Or67+SWQCXmuySk6w
	sBXeuQ1z2WdZPXjq1mz8cz4w7yF0knHsDwm7wsnZGoaWf+Lh+w2wSvfB54JqCw==
X-Gm-Gg: ASbGncuH2ERgDmqtDh9hZGXhLkTMBXo/KPwlOQwmYKKfmR2+7FIhM6SACemKm0VQSXv
	0XsdPKuPrP2A3N1nsQeqbo59UhY17JImpBGJST8xTVcv/TxiGx8zDq1r2PZMTZ+5UHzE0bvTKfC
	61vsD+cG58XuoWm7ndvVCN59Y6x922n5RG0FMSnfO54nLIUQqkm8qDMmPc54iVBtxg4WwjQKClg
	hXwKjV3QE/ITsEC7kOUmc9G7wnQsfJLbLwKYSjGCg9M4dUg3HaJmA9fZjo1GVWEsqzrI1Im3ttp
	EdGjWJlJ9lDKd6ppr0Al7sJQjc7x8cgUYeU7ylwU8Jf6+pcyLbsdqYQXh9dSH7jyKFdQwiBzmq1
	4grG5lSazOGovVq3KRdXgtBAWCql/MYujjXmWu04Shm0=
X-Google-Smtp-Source: AGHT+IFE5Rvb/kb8ztpMoyCFZqdX6VIu6dgZBzXkQHF06me2AGuyVEK474+YYIv4fF0V78KIYjpbNw==
X-Received: by 2002:a05:622a:181e:b0:4b0:c1c0:158b with SMTP id d75a77b69052e-4b2aaa3c6abmr49056181cf.29.1755892297535;
        Fri, 22 Aug 2025 12:51:37 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e45c4asm4913221cf.46.2025.08.22.12.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 12:51:37 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 12/15] station: get neighbor report on BSS TM request
Date: Fri, 22 Aug 2025 12:51:15 -0700
Message-Id: <20250822195118.271122-12-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822195118.271122-1-prestwoj@gmail.com>
References: <20250822195118.271122-1-prestwoj@gmail.com>
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
index 339ee73c..4919f89e 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2435,8 +2435,16 @@ static void station_roam_failed(struct station *station)
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
@@ -2448,6 +2456,8 @@ static void station_roam_failed(struct station *station)
 		 * the scan here, so that the destroy callback is not called
 		 * after the return of this function
 		 */
+full_scan:
+		station_debug_event(station, "full-roam-scan");
 		scan_cancel(netdev_get_wdev_id(station->netdev),
 						station->roam_scan_id);
 
@@ -3373,7 +3383,15 @@ static void station_ap_directed_roam(struct station *station,
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

