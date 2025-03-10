Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302701E1C22
	for <iwd@lists.linux.dev>; Mon, 10 Mar 2025 21:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642883; cv=none; b=bWoNiRCCwnn92jshqMnxvrcl/yQ08plbJ37Ew16cJuVI2XL6/n5GCO484gNVaetsc1Fte6tpLmGdzP3UHLFAjrLuxgaUC4E/3SQ4oBpQ1iZJ69mHYNRR5hsXUHRlwGFt+1je9QG2/sv12cgkqQwB9HID47gWFDzZywIg1xMvR1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642883; c=relaxed/simple;
	bh=4TBFHLx0v9So0GhoPkfflUk012Gl9dxE7gC31FrKIxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a8ALeO2zflhUSqy5P018WUEd4nlNv4+ezSiNZBM5z0FuazpE2QQpZMuw6R9JucaIaFLiG9sPbajaWZTdBnSvaE5HcwHtSbaEYWK7SXmVogz3Asu/ckrNoEmpOhkWpGjI835APyz+hFiF9H+pZKZRMFROaQEubtsjRWbvNom+Lvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsGYtbz+; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsGYtbz+"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-476805acddaso18674161cf.1
        for <iwd@lists.linux.dev>; Mon, 10 Mar 2025 14:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741642881; x=1742247681; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Rs7qaDSYgYJxxnp510WgMdJS5hCD84nfpzE8QkJJCU=;
        b=OsGYtbz+d/amPxtwi01xo1QeIvJOrNx41JEb2aISJ7KYlUT5CCKPNlA17BWbTfj7Eq
         oriejvVkpo+fKVEWwlGfqm1d2X2JQOHDegXTVp2xugrMGaSTcfmhbi98djOeaRcNK1hE
         MathlGKDLviiXL5seMVneOMDdwXqNGQJ21VpXGJMjhsQ8uPBOi8DVi5xTtGPhZflyNu5
         H+2jicIpVeU9YSBN8FPFUvbLphtHGFZROl3yNG1myYqpC0RKfBG0qF7bNCKcZejVOkwa
         0EimH25dHuw6kYZjpolRPdEtGSOlVXaPLfSM1nfSoQuUuXVjhCS8HJ8NkH7n0axED47e
         Iv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741642881; x=1742247681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Rs7qaDSYgYJxxnp510WgMdJS5hCD84nfpzE8QkJJCU=;
        b=thFdNh1kcMdevi4/+neRhe3eDguibgbVONGifh8bOt/21zA8eF1CrF/Nx8Sc1hZunO
         kdkj0YHNPav/FbsjKuo8eX9WEzcMHZl/bLaAdO/fvV4uy7EeecVySZ/R3Bjzfol/aCxC
         m8xIeWL3ZhQeTKrvUezh55zYCVR2vgQ6FeAcDxxFx7WamY6j9+1vSmKw+54BYWzDTA5M
         pN3kTgTeUpak/JuAMDATHks48ilRJhbyfhHpzoKLpmY8GKvq6y30GqQwE3frEMazF/GY
         +xQsADBdDJUtr18ICOXWmLkW0XLrfZg4OLptOFnLZMyZ2p0dW9GR6wKAIoDlEB/l1hl0
         Y5EA==
X-Gm-Message-State: AOJu0YzY5SS71OwN84jnngmn+Gt24o+B124RhCiuS6aL7IpWWIqRrGlt
	2VEutKGpib5Wihjl444rEctyb8xoxcVzAtdkXZCUDOGGDDmFkDGfZ4wtmw==
X-Gm-Gg: ASbGnctMvkWH0ZygbQn6kxRC+NoVCND75yG9H7yjhufZdZNEI0zZ+j3dKxHnVeN7hsh
	7JZsgTMlzErXSU3F7lu/f2Fjc4j53t9yBwUb7x5SnCmSleje3exCPe/vA73cx4Ukt6vugfLKCa+
	kC8zXmHOZmWk8UNjCfaPBlyBjYi72EY4cO8ocXbihCP6XWZgjg0v5SB0OaB/jDNvsaBJWa4i+1u
	LDkYQ6V4Q7m1tklIKQz0ZgWviL+d+PPNmZNqBOZlbmYEl8kzrp80xmC9AWWXQ+VnEGvX5IOC5B7
	iobtI27Lg+ta1Put9fb3OIRktUtihJUw+bB27OrHiNmsusiZKD6mA26p7HdU/ea9CmYHRoaU0nF
	sosI=
X-Google-Smtp-Source: AGHT+IErWfCdyWJzznKNqyfiyo9BhMFI/d++hueh9xDLKCra6rAHpjGaNu82gOQ/K9EeMcUYj8D5CQ==
X-Received: by 2002:ac8:7f4f:0:b0:476:8f75:b885 with SMTP id d75a77b69052e-4768f75d1efmr70761181cf.44.1741642880816;
        Mon, 10 Mar 2025 14:41:20 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476772de5absm30487841cf.66.2025.03.10.14.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 14:41:20 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/8] station: roam blacklist BSS when a roam is requested
Date: Mon, 10 Mar 2025 14:40:58 -0700
Message-Id: <20250310214059.20809-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310214059.20809-1-prestwoj@gmail.com>
References: <20250310214059.20809-1-prestwoj@gmail.com>
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
index d16e82af..148f628d 100644
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

