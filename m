Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BD83C0C
	for <iwd@lists.linux.dev>; Fri, 28 Mar 2025 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172995; cv=none; b=a8KQl/Ro0RyHoCjmikLvjzotVcJJsr3wTkqjk5420PU+eR5pjCBhN++0B1+/Ut/zdzDs9dVJ/9+bR+V/w/W/sPJZsv/BcoggQsVoM9Mvrjg3gmR4EGtyBXd4CS/xl+O0tS3/97MvObKwvVrhdLI250LIQgVHWkhxCKWaKp3AAZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172995; c=relaxed/simple;
	bh=xA9BpN09RDsdkCywfrjSEpD3TirIQRl5EBvkyw0FGno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QXc1xStrZBmtuC2l+EmYkPwdQa2ExkA9+lH1c9CLE9tix2+3eelPkheN4f8XJWJl4H66W/XZA8o0J2GXtrDj44TFp8O+Rd4UA6RQTQxKouHc7ZARdcWmkltiBxv0BlRHYx4V+OAeqEsttnC+XHgC7KtXet3RUMm+rxs352hjRlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6GsEifk; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6GsEifk"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-226185948ffso47240325ad.0
        for <iwd@lists.linux.dev>; Fri, 28 Mar 2025 07:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743172993; x=1743777793; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hWLWpPTMl0TqPjilzbOwQgfh81bG06uryhjp90dH49U=;
        b=i6GsEifkiqtaQNNHxrtlCetZVsAUlCCfrAr0uUqriLptmb+4RpfUNQoU1MYEp9OxHm
         1fKBwKxoKsQvBPzK4GCmLjQ6iYj2x9RhoHYGuNDsrrVRy7eD27hI2C6/R0A0khTLbwYT
         QlZLfvExfKM4tBOdQpra7kauyVD5KBpxApnFHIfwjncpjETH/MwQKwd0TKnU29/FuZ8h
         78w7KB53/0LOgu8hf4CrPFHF8BW6DuTwr7Ee8holWT75hClJFF/AVuJcqpIApbCu3pXw
         hkdrvmPaRbPKUl1M6xfYZbjKaAF0uRWE2AVR5hzKrNBYvOLf5XbVkf0D7HSve6geYTe3
         4+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743172993; x=1743777793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hWLWpPTMl0TqPjilzbOwQgfh81bG06uryhjp90dH49U=;
        b=ckMwNI0zFNe0zccWz5LqMshM9mkprupjwgp0tZUiHWvf/FFUypgIGZ/WLko3Z28yxi
         SCGCOesI0qGSWiQOB1VrDLM5ImbJETlvZHpciFeMbwHOygdeohn2JBRDvtSmQg8ArTgP
         JfYU5o9gMkOBGa6GUAJ9yrwousQaQC3hM3uhGNcsZlCMfu2v538jzo0GCMdtFYS6w43l
         73EA07pgK6TnF9OvuEyqpE8EmQEBzNLbLHHXjTNspy6dTVguVhIxzVfnvplmiVjs4MD6
         I46K+/Zm4XiguILEmSu/SLtKXVYwcn8IabpheqIiDlpPJJFzXAOqvJ6fV4wPMvAXKDeY
         yOhQ==
X-Gm-Message-State: AOJu0Ywk5+zRoVNiLuzLsY8BFV7Odd/nLteP+a3IymTTfxr8hv8+0qrk
	Avu43zXRhtsPggCUnGRcHIyZRrVmdbKn/GefvVaI7RE9QWW/CSWnahQqyw==
X-Gm-Gg: ASbGncvujS834kFQZksLvlSZm/p6EClVPoikoYJBklrYjfTnhdae/9rSYJ6IeZ9ZFlN
	H5qaA0uUcfMSgw1DKBzdYdiSqCeZN53pg7rTXNPETf6voIRn3cJ4n6luwXFSijACiylX3Ky5P2V
	fY4U3WneVoLeVbp41LXSChYYgY//pHRrQlpBW/SeaFxdimZX38AM1OfwDr5KxfMevCt4Z0ZR7Qr
	kpVyiSO+urwvghlLIDBI9xhrGNIla2SKywFvmWZh7a8EIB3m3GoxtFe3M0SSrGmbGcBg1vB8pTV
	m+Jytk7t0vNRonF4VoT2pbXtwOEMUaCwzFLBivRpJwXr12URa98sYtsb88gCFtKahD+Gx3W38y8
	=
X-Google-Smtp-Source: AGHT+IE+chfJTjrJ52G54NgpH+3OTG1bfaZUT9e82NG3Jj7v7bRlABpQiJLiuAeWa7c3os6/HSiFyg==
X-Received: by 2002:a17:902:ebc3:b0:223:3ef1:a30a with SMTP id d9443c01a7336-22804966733mr121871765ad.45.1743172993252;
        Fri, 28 Mar 2025 07:43:13 -0700 (PDT)
Received: from LOCLAP699.locus-demo-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eee2288sm18885515ad.87.2025.03.28.07.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 07:43:12 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 08/11] station: roam blacklist AP even mid-roam
Date: Fri, 28 Mar 2025 07:42:50 -0700
Message-Id: <20250328144253.421425-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328144253.421425-1-prestwoj@gmail.com>
References: <20250328144253.421425-1-prestwoj@gmail.com>
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
index 623cfdca..c5529842 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3225,12 +3225,10 @@ static void station_ap_directed_roam(struct station *station,
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
@@ -3294,8 +3292,13 @@ static void station_ap_directed_roam(struct station *station,
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
@@ -3322,15 +3325,24 @@ static void station_ap_directed_roam(struct station *station,
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

