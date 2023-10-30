Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B970171B9
	for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loIi11Uq"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6c7b3adbeb6so2980620a34.0
        for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 06:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698673725; x=1699278525; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PtMk8Gt+1gFjjXdMBkctyeZWlT2Y9aLB9DRk7MjRaQ=;
        b=loIi11UqhdFGD6KdoWmLkh6Y7aODWbrEzNsc74ETyWXRRnay7Yj/bg95BDhtl6jQwB
         ty8RQE6nkcG+HFj547FivNCdpL+7Pru69s28iFWAklruVaYQtoiTST3ez1PxZ2qDVIWt
         lF1Ip3TZXdIZN4P3PHhJ3A2pteyu1mCYjdui25qLMKpGO0d+PO6wTXiDz5d4ZWMsrhOQ
         Iy7JDKyY3DwV8U2vXTCbujWRfYDGpRjHIfNd+u0dUpOaIf68y0dQE2qGmyCFWuvcgdXi
         FmBGOm6DrQzntgR4JLu3lPgOwgeqRP7IbHcjl/NQKq4/t4p2eZgwGOkYpE8fVihurVIT
         hwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698673725; x=1699278525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PtMk8Gt+1gFjjXdMBkctyeZWlT2Y9aLB9DRk7MjRaQ=;
        b=OtKlc1I3yrYm97qSzWD8Ce5LvE/M9Nv69ZJUZv3JX+dhgHO4c4deayyBTLSGXlBaRl
         2WO3V0tcjrezVCsK9o6qwbzbRPlXkl9uaC0aUQ6QXu4/rLx7DHpiGBmA56gn0JbUa7RB
         e4ZwxBbEnZPpK0KXkNXS/M6EFGJcZhf62ExcaNvEWysouotPfGJ4CB0b6bl232XIszFO
         P8GkM/Atv5rStQRE+NNPQwsSXKnr0VMfWSo4Hxg/Zx2c5DVKMzvNSM4dd1XSk0+rX1sN
         db6i+Lejzv/N3duhX5kFlxhORZID2D4C3g1ZyUz5uSuF/IDqvh+CTVELsp0WVgqlRq50
         0uDg==
X-Gm-Message-State: AOJu0Yw2ZgbNsfEXuD7R5LAPDJMEVLRp0AAs/Ry4he6Ac1lcnM9wJJKC
	TYbam6nVeeome9FhxCYlI/ZRI/X3aHI=
X-Google-Smtp-Source: AGHT+IH425DyKC7MxT6N6Klvf1nt8bx8F20ycTGWiE/I+L2FUsIhIkTRXds6QKYwrGzG9dzhZpSM9w==
X-Received: by 2002:a05:6830:90a:b0:6c4:ae52:9599 with SMTP id v10-20020a056830090a00b006c4ae529599mr11258044ott.7.1698673725072;
        Mon, 30 Oct 2023 06:48:45 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id c18-20020ac86612000000b004181aa90b46sm3419929qtp.89.2023.10.30.06.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 06:48:44 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] station: rename ap_directed_roam to force_roam
Date: Mon, 30 Oct 2023 06:48:34 -0700
Message-Id: <20231030134837.452957-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231030134837.452957-1-prestwoj@gmail.com>
References: <20231030134837.452957-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be used for other situations where a roam is forced rather
than based on ranking.
---
 src/station.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/station.c b/src/station.c
index 1a886b19..a2358d95 100644
--- a/src/station.c
+++ b/src/station.c
@@ -126,7 +126,7 @@ struct station {
 	bool preparing_roam : 1;
 	bool roam_scan_full : 1;
 	bool signal_low : 1;
-	bool ap_directed_roaming : 1;
+	bool force_roam : 1;
 	bool scanning : 1;
 	bool autoconnect : 1;
 	bool autoconnect_can_start : 1;
@@ -2114,7 +2114,7 @@ static void station_roam_retry(struct station *station)
 	 */
 	station->preparing_roam = false;
 	station->roam_scan_full = false;
-	station->ap_directed_roaming = false;
+	station->force_roam = false;
 
 	if (station->signal_low)
 		station_roam_timeout_rearm(station, roam_retry_interval);
@@ -2145,7 +2145,7 @@ static void station_roam_failed(struct station *station)
 	 * We were told by the AP to roam, but failed.  Try ourselves or
 	 * wait for the AP to tell us to roam again
 	 */
-	if (station->ap_directed_roaming)
+	if (station->force_roam)
 		goto delayed_retry;
 
 	/*
@@ -2425,7 +2425,7 @@ static bool station_try_next_transition(struct station *station,
 			util_address_to_string(bss->addr));
 
 	/* Reset AP roam flag, at this point the roaming behaves the same */
-	station->ap_directed_roaming = false;
+	station->force_roam = false;
 
 	/* Can we use Fast Transition? */
 	if (station_can_fast_transition(hs, bss) && !no_ft)
@@ -2583,7 +2583,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 	 * to occur.
 	 */
 	bss = l_queue_find(bss_list, bss_match_bssid, current_bss->addr);
-	if (bss && !station->ap_directed_roaming) {
+	if (bss && !station->force_roam) {
 		cur_bss_rank = bss->rank;
 
 		if (hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
@@ -2961,18 +2961,18 @@ static void station_ap_directed_roam(struct station *station,
 			MAC_STR(hdr->address_3));
 
 	/*
-	 * The ap_directed_roaming flag forces IWD to roam if there are any
+	 * The force_roam flag forces IWD to roam if there are any
 	 * candidates, even if they are worse than the current BSS. This isn't
 	 * always a good idea since we may be associated to the best BSS. Where
 	 * this does matter is if the AP indicates its going down or will be
 	 * disassociating us. If either of these bits are set, set the
-	 * ap_directed_roaming flag. Otherwise still try roaming but don't
+	 * force_roam flag. Otherwise still try roaming but don't
 	 * treat it any different than a normal roam.
 	 */
 	if (req_mode & (WNM_REQUEST_MODE_DISASSOCIATION_IMMINENT |
 			WNM_REQUEST_MODE_TERMINATION_IMMINENT |
 			WNM_REQUEST_MODE_ESS_DISASSOCIATION_IMMINENT))
-		station->ap_directed_roaming = true;
+		station->force_roam = true;
 
 	if (req_mode & WNM_REQUEST_MODE_TERMINATION_IMMINENT) {
 		if (pos + 12 > body_len)
-- 
2.25.1

