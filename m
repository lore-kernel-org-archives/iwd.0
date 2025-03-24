Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3347081A
	for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742825769; cv=none; b=N1LoIlxu3InOT4X6reCjAFdrG5+7zo7rgRb78378t9dBGpRUQcsscRWOJAHyBoUNXGLELDrvJNrVrfgP6p76hlqcpgn1/dWQmPvOfVnqBobzEG/+DJ8gzZjztpYdjnuUvlKxncnHoWND561dMNdO+mwI5p28LVai4eQWtzMpmjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742825769; c=relaxed/simple;
	bh=RfBNyIe54xobimPzlrPZqfLahyeisttQzw6pyUwd76I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q9CxZS2BvRlsY+eqZ7I47PrV1KIUhwXC1suRai7LIqlKANPrYoYQvYxZ0xe2wYnDUORW/kigcc0NQ4997lJpMnWfcE+EV/QgUudL5MYyXz/YaD0mrsGHoUe9HlFb5ROm39aIWKJCDFs8zhNcnMKE/1/Dd++1eMi2mgYJA2SbatI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/DE4g9H; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/DE4g9H"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-224100e9a5cso83328565ad.2
        for <iwd@lists.linux.dev>; Mon, 24 Mar 2025 07:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742825767; x=1743430567; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLnp/QEGKYUb/a138PIdGcUtNZEdbdq2D1FarrPhoUQ=;
        b=M/DE4g9H/7Bz/V0kWlmIqf+d6m3c2RzYCOBCNNC3gpX3NVZPV9/IF9I46q4VWnhsDJ
         8W7m8i5P5zmm4sivcQ6v5TqbmcnTgIywSeqYXcRHGfIcU2yidiPERJHhKrGj1bpq7jFn
         /2nh8q/ut+P3zAGudPZk/0Yl0cp7uX4WIyQ90tVGphNcxyojEOm6Agt1K2Bx6IwiKHdq
         Uxi3J+G1X5Wkjkabgjpq6EoKf+dCIczifxqm3yi7dZemEVFfRLLzUjIa2P+tRhfckbJJ
         pUR9CqnDP99gdoAzO+Qtmy+Bq7iQccZ3l/qsXDp8v3Q0DYWDTRtPVX2pCqNuN8kGAts8
         8DiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742825767; x=1743430567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLnp/QEGKYUb/a138PIdGcUtNZEdbdq2D1FarrPhoUQ=;
        b=AYaqodxRjtg13RcQuwCBqVGJBw6SAJ1vZRYiqLq+cxF+nh4tehpQJPCgxTaQVzbRaN
         NFNe+Zos53Gygl15DbtLBIbcLxP7lS267sMqgjDwJz8xCMC6WoWdGgBviGcymQwO77IH
         OiUvIAdpBkhWTmlC0DuRo3e9h3EwZ8xLmnWdtKssqnyXq+jQO2HGOuP8cvMrQeIAj9h3
         7wkWITZJH8lrn0+YWGzabDez+NDKL5nemxUOP3RXPGi87E1NCRRJ9mO7NQsFyTZRapt2
         1ebSqqyGI6dAUcoZp2urg2RlJ1iu8Lys5N3CBfgBPHS/WhBzW4S5J9iNLXGxquu9Wk/T
         hSGQ==
X-Gm-Message-State: AOJu0YylP+6lzGsqGsChIW/dMpcMD7htPklSgZ+fg7a2iwm/tlf7qvoB
	r25tRmw0D8flmGsKzsRCopokfIyQrGOsWxumn+1azT59HmDL/2GITEVjqg==
X-Gm-Gg: ASbGnctglR6TZODDj3DdSofag6KHI8eBt7NKW+FNi3HjpH6Wn53AnrpbUxrUy35SzE0
	4nlmb9mbPUx17hV6QYsi1EU39KY91IXOfQc1cuEzMmOkNTUbpzNJ5GmZJToxmfnLN8OHNtUxnSV
	iKUEcw5wTS4sPsg9Jh0bZyurmkKmrKOPtYnEsWulqRthsdZFtklulliHZZ+intTT4s+3z+A8ZA1
	OtaoR3ffFwr/3OCpCpjdAC/K+uXEuoNsE7Tb8SsT6G0/c1bXJL5WY0VCGfB0saMKBXNCKu3tWdi
	1TtlcEQsXZ95lY0JT1g4zSO/NHsc48OiI1Ify9pTXXHXUbdgmrbFaco=
X-Google-Smtp-Source: AGHT+IHgMD9n3qxobX7TwhLjtwWBluxlZ1YZR/t4OkxoqriHzdJ/8Yk44gRouifhw51pCUWDkzjDog==
X-Received: by 2002:a05:6a00:843:b0:732:5611:cbb5 with SMTP id d2e1a72fcca58-739059d770bmr21960787b3a.11.1742825766383;
        Mon, 24 Mar 2025 07:16:06 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd54efsm8007868b3a.37.2025.03.24.07.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:16:05 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 09/13] station: roam blacklist BSS when a roam is requested
Date: Mon, 24 Mar 2025 07:15:34 -0700
Message-Id: <20250324141538.144578-10-prestwoj@gmail.com>
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

If the BSS is requesting IWD roam elsewhere add this BSS to the
blacklist using BLACKLIST_REASON_ROAM_REQUESTED. This will lower
the chances of IWD roaming/connecting back to this BSS in the
future.

In addition we also needed to update the roam_bss sorting to use
__scan_bss_rank_compare so we sort based on the new groupings
rather than only rank/rssi.
---
 src/station.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/station.c b/src/station.c
index c4ba9413..b96419be 100644
--- a/src/station.c
+++ b/src/station.c
@@ -184,11 +184,7 @@ static int roam_bss_rank_compare(const void *a, const void *b, void *user_data)
 {
 	const struct roam_bss *new_bss = a, *bss = b;
 
-	if (bss->rank == new_bss->rank)
-		return (bss->signal_strength >
-					new_bss->signal_strength) ? 1 : -1;
-
-	return (bss->rank > new_bss->rank) ? 1 : -1;
+	return __scan_bss_rank_compare(new_bss, bss);
 }
 
 struct wiphy *station_get_wiphy(struct station *station)
@@ -3268,6 +3264,10 @@ static void station_ap_directed_roam(struct station *station,
 	l_timeout_remove(station->roam_trigger_timeout);
 	station->roam_trigger_timeout = NULL;
 
+	blacklist_add_bss(station->connected_bss->addr,
+				BLACKLIST_REASON_ROAM_REQUESTED);
+	station_debug_event(station, "ap-roam-blacklist-added");
+
 	if (req_mode & WNM_REQUEST_MODE_PREFERRED_CANDIDATE_LIST) {
 		l_debug("roam: AP sent a preferred candidate list");
 		station_neighbor_report_cb(station->netdev, 0, body + pos,
-- 
2.34.1

