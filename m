Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F90264600
	for <iwd@lists.linux.dev>; Tue, 25 Mar 2025 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925667; cv=none; b=D1IKLDwPjOT7JmP9zkvXUzj4Hr19gUTw20emGvnTH/eTYO6zr3FOjfrmeDe67kF8qvBCiuqXCsOeLQr+KnS9ptlTEVg/PmcTnkSz7XDbTsP5LXjMuvoLV+QuJm3iT7Q+vORtkAmQlNLKscSn9Wb379BEss8TVGPNKMNDYJzaVRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925667; c=relaxed/simple;
	bh=nELu9OFTEa6XsAiLRXtpzRqBbfDJQGEgP2eLgbBhwz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j3xwNSDxiSj9hOrCBIaJ8D7FreOWhav7Uty2gZm7qEby/oFVM7tuTATftNK0l2ykREo92PvOXkjr+q8npppa4rRHNNVYppkwddwv/YlQCvzPx5qs8uWHKco/2rjsvU9XFUOU7GSlgn4F+oDZP9D5nhxQYJPEcELgQ9k3134e5W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dH6G9sim; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dH6G9sim"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3035858c687so3295252a91.2
        for <iwd@lists.linux.dev>; Tue, 25 Mar 2025 11:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742925665; x=1743530465; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JN3iebsV26wS0QMcVWCeeCferANC3ioEY1u+4hwA2SQ=;
        b=dH6G9simvnBBbRmCASH7ehkJUqc6kt24Wkj1gzX7Fuf+5X0tCv07R6CySSwSd4GIw3
         9wDL6MnY0sHlb22eXUgBoUZNZm/6dlw4rvSzLPFQnjIw4X8/UC7/YlAeWWVbFoMCRrA/
         x7eyDxmZq1LZrSbtWo4+qxztvbxUwhQPvtjTjSqbmmB0XWzX/o3QaQsDmhoMxkgYtbxh
         FmqjNxj7XPG+E4UiAb+G4SPDtPgsuqTdR6WQfSwA7uug0hYYkNE+Y67yHZnPkRJNe9VF
         +PnTMvuhpm4Qv1iVNLB17WObIFN7NK+w+XV6VCa6+qwk7o9en3UL9p14wIX8EyGJuF/x
         9S/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925665; x=1743530465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JN3iebsV26wS0QMcVWCeeCferANC3ioEY1u+4hwA2SQ=;
        b=AM0vWfBahcxF6YhcAoL5uRcXxH5UE4Fg6uMy1ltiHyTTr8ZSO02TyXQVQksUphjt6C
         Ud854TMevdM9x5nwpGm+UT+f2rfCeNYEbBnrpslJvcJo4mT4vXgLOYw3RW9ObFDJRQNv
         pYyRh5GTFwlXJYsFD9dxZ5T7nhjEkkhFDDQD+MulW9UTkLW6/tn9GHb1OEJMw8s8YM6q
         1TnUeFRmzepv2JLCbzXVIRR+kFLvHe8IozHVw/Ev6QbSVD3SQhjCJO9pABaRpmmW/Y5C
         bYVKInlkBtO1k3lTmaVuTlNhXFS7gA6/1ydqo/XLxpxRvqrELdE16lKhdZWwxIlD7wXg
         Wp1w==
X-Gm-Message-State: AOJu0YwUtuuuRmpYb1wdOzCZuGmOgwvrk5O3PnQjOduLRfMrUTZ8HB9v
	e0eLGpJ275eYTdpJZc1ICthBOnBHX8mvlt0zT0qFrR+RKbeQ2d3kLEqEWQ==
X-Gm-Gg: ASbGncuH5J0pzJnPjcwTbb8/iXNRgEKshnGWrZho4wJnPimdxl8Y3n5am9r1JbI85Kj
	poBY+UBkdh6cU1NsgMn2hpKkA8TCNuTj2pxRUK/v+t4nfYckJGhlC0GA3wIki+gDanx0loQU7qz
	cNFuBB1XcNFf1QCyA/L/svihZieeNgWDCCDuIAXivj7BQA4ZbLrv+S8geBZAAYyniAfambFWZmJ
	/MXQ8sO6V0rLbDV8UgIlW9tx3/IYSx53aDqni6hVjzh3HSfos8zdNcdce9+mgEHzYyz33IM7yVO
	EtHJAQP87p8sfc+vCvoYmHmaVqrM8EiqVmm8FF/L/qPzDwkOKCHOzcx6QhOc3aDhsJevIR8SfSA
	3WAk=
X-Google-Smtp-Source: AGHT+IEy0TE+tzsdchfUduwz8/wOI9M+wcQM+xVaTTOTaGuY965XKe+VUGCCU6mNgCG89WMzMZ7Wug==
X-Received: by 2002:a17:90b:510e:b0:301:1bce:c255 with SMTP id 98e67ed59e1d1-3030fee56bdmr26827798a91.27.1742925664995;
        Tue, 25 Mar 2025 11:01:04 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811bae9asm93770515ad.138.2025.03.25.11.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:01:04 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 08/10] station: roam blacklist AP even mid-roam
Date: Tue, 25 Mar 2025 11:00:39 -0700
Message-Id: <20250325180041.238676-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250325180041.238676-1-prestwoj@gmail.com>
References: <20250325180041.238676-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an AP directed roam frame comes in while IWD is roaming its
still valuable to parse that frame and blacklist the BSS that
sent it.

This can happen most frequently during a roam scan while connected
to an overloaded BSS that is requesting IWD roams elsewhere.
---
 src/station.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/src/station.c b/src/station.c
index e3c7c189..c84b777a 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3241,12 +3241,10 @@ static void station_ap_directed_roam(struct station *station,
 	uint8_t req_mode;
 	uint16_t dtimer;
 	uint8_t valid_interval;
+	bool can_roam = !station_cannot_roam(station);
 
 	l_debug("ifindex: %u", netdev_get_ifindex(station->netdev));
 
-	if (station_cannot_roam(station))
-		return;
-
 	if (station->state != STATION_STATE_CONNECTED) {
 		l_debug("roam: unexpected AP directed roam -- ignore");
 		return;
@@ -3310,8 +3308,13 @@ static void station_ap_directed_roam(struct station *station,
 	 * disassociating us. If either of these bits are set, set the
 	 * ap_directed_roaming flag. Otherwise still try roaming but don't
 	 * treat it any different than a normal roam.
+	 *
+	 * The only exception here is if we are in the middle of roaming
+	 * (can_roam == false) since we cannot reliably know if the roam scan
+	 * included frequencies from potential candidates in this request,
+	 * forcing a roam in this case might result in unintended behavior.
 	 */
-	if (req_mode & (WNM_REQUEST_MODE_DISASSOCIATION_IMMINENT |
+	if (can_roam && req_mode & (WNM_REQUEST_MODE_DISASSOCIATION_IMMINENT |
 			WNM_REQUEST_MODE_TERMINATION_IMMINENT |
 			WNM_REQUEST_MODE_ESS_DISASSOCIATION_IMMINENT))
 		station->ap_directed_roaming = true;
@@ -3338,15 +3341,24 @@ static void station_ap_directed_roam(struct station *station,
 		pos += url_len;
 	}
 
+	blacklist_add_bss(station->connected_bss->addr,
+				BLACKLIST_REASON_ROAM_REQUESTED);
+	station_debug_event(station, "ap-roam-blacklist-added");
+
+	/*
+	 * Validating the frame and blacklisting should still be done even if
+	 * we are mid-roam. Its important to track the BSS requesting the
+	 * transition so when the current roam completes IWD will be less likely
+	 * to roam back to the current BSS.
+	 */
+	if (!can_roam)
+		return;
+
 	station->preparing_roam = true;
 
 	l_timeout_remove(station->roam_trigger_timeout);
 	station->roam_trigger_timeout = NULL;
 
-	blacklist_add_bss(station->connected_bss->addr,
-				BLACKLIST_REASON_ROAM_REQUESTED);
-	station_debug_event(station, "ap-roam-blacklist-added");
-
 	if (req_mode & WNM_REQUEST_MODE_PREFERRED_CANDIDATE_LIST) {
 		l_debug("roam: AP sent a preferred candidate list");
 		station_neighbor_report_cb(station->netdev, 0, body + pos,
-- 
2.34.1

