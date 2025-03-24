Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F933EEC5
	for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825770; cv=none; b=pB+nw544LR6lf9TAwNuu8xakgwZkuslNPEbqRGagtNLmh8Q2eR19o8bJZ9SnKPfLbDD3FzkRgPuq66uxMt+iA+x/v6VnJa37eVcluCEOeqD5zd74GDmn+ZNsd2lDKTiv+0YTrXQWv9sVTt3R06T2gZEtrctt6EPJE7C78gFxxKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825770; c=relaxed/simple;
	bh=zS7ZgTnrLcpCa6Hgpg9yTGAZAAhIDnALjmgEWaKQYdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GTKL4cX2KSOOEJhZxj0DYOGk5BEp3LuBJ9OGRgbLKy02IK8K//8LPAvG8dX50PLX0y0nvTyohK+TNcDjoXkFgg+nS09Vt7HCwvQLb4CKtK7q6Jy/jzPU9q57QT28YXQ9wQdGQ4et+krv9OYzzIsf5HG3zNUB8ZGT3vqIoD/qDNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbQywY61; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbQywY61"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223a7065ff8so8994525ad.0
        for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 07:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742825768; x=1743430568; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwolN0JqN16IIQGx/QcM2yePHjLgWmEMxmMHP7W14+M=;
        b=NbQywY61XJY/ZHcq71osxRVYES30a0+Om9UlUTKFog5R1tBaaKjuCJhv+Jke9HCWeM
         oc+yx95j5yYH29kZu6MCBI/CkP8+84/mgU/gv7GjXxVNEqjcyeaIplGDe4xGwmJ9OQMg
         ef4w8is85LdPZdNx+lVoRDm96+jw9Kn9H0t+7Ab9cOEJq5dp9xMjO2E6rkX2spKCre7W
         J/BXO4aVc2Jw7ycS5juBD1H6578WMu/HXVU89b0VDHTfsUFoXhTbET2FyAN0bbjOhGLi
         vQA9cBa5NSnjuD+m+raIqcr16AkAo4YbiJY9NhfmkOnWJhG67xz+Nh9SqKZPTT2gZJ1C
         MmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742825768; x=1743430568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwolN0JqN16IIQGx/QcM2yePHjLgWmEMxmMHP7W14+M=;
        b=DoMMMBPXXj5o70K5qVHyh6dB140Bwc/e/mATyl0O1PMpAywSjez/Pi+PXPAbFZwgq7
         iOesA1bH/1+XOl1TBh1gbenMgH10Hzp5kJ9tmWHQVHT2CZRxnI3qtGivugM2YhzJLSfu
         8E9PzvPYhpobdrKlJMPju0ooFyST6Ue7IeQWgZHmZNgocZKFSVgnJ1gC1XcLmUUECHYO
         BtDo58JhEfw3AHAQZc3icT+5XFmmez7xUnXLmzkTiPyILV6CkbY2W7Rqj+tmXIdcVHDC
         w5FDCJT2qskXASDcYWtaqlGTbEOua+EV3rhEG3Ue3QXlMO3JIGqIdFH/Ya8ygTNoOiJR
         gBxA==
X-Gm-Message-State: AOJu0Yyn/ZCnGWynosaSjsKSDylZsRoXXG48HcSOH+I1xtNeaOf50MA6
	zY5XPKiAua1REp3WvqZdlhpCXjU/FwiypEFKDVFo1ZoFp154OJODE3vcPA==
X-Gm-Gg: ASbGncsUE32/rX+Gybr6W0DzAekvYuqAUw7Y7fPBZDP95FOV32+ZoDLbDLUwe6A4s5I
	mGotMco+1VtcWEUIY/4YdeF8Isn8Ac2YIdwpIACTT3oZJ6UKqPHw9rCDAe1VlPaTSg1G+Zhyc2Y
	SEFyrX5xEcnavUfjAVLRTqAJGfoORkS6yXUGbxhlzHWfQsVqOiQxNg9ELX52kSWnwXzoHJk5+Hn
	OrDxnVt874rRnCe0KzoyETrrkaqCUE2smE8uMs+k1Gnieu2NJf82RBRTGPGqkuRn0y3HIDFPhZk
	OJBsSvjU8d1MoUNDEYVzZZnRta5YYTjpSehgCrMUqoVh8mhg/Nnw2eA=
X-Google-Smtp-Source: AGHT+IFxkiwo25qcGdrROSiMXnpOBSIWT50CMiA1BipbkqlK50z7uxAqN2e2BFuoM+DhdqMG/RWfEA==
X-Received: by 2002:a17:902:d48f:b0:220:c86d:d7eb with SMTP id d9443c01a7336-22780e15340mr218102215ad.36.1742825768252;
        Mon, 24 Mar 2025 07:16:08 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd54efsm8007868b3a.37.2025.03.24.07.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:16:07 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 10/13] station: roam blacklist AP even mid-roam
Date: Mon, 24 Mar 2025 07:15:35 -0700
Message-Id: <20250324141538.144578-11-prestwoj@gmail.com>
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

If an AP directed roam frame comes in while IWD is roaming its
still valuable to parse that frame and blacklist the BSS that
sent it.

This can happen most frequently during a roam scan while connected
to an overloaded BSS that is requesting IWD roams elsewhere.
---
 src/station.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/src/station.c b/src/station.c
index b96419be..066ca337 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3162,12 +3162,10 @@ static void station_ap_directed_roam(struct station *station,
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
@@ -3231,8 +3229,13 @@ static void station_ap_directed_roam(struct station *station,
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
@@ -3259,15 +3262,24 @@ static void station_ap_directed_roam(struct station *station,
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

