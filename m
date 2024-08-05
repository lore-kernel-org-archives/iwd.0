Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8D717C64
	for <iwd@lists.linux.dev>; Mon,  5 Aug 2024 14:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866847; cv=none; b=DS9FFh/BrhjNpRMu7ix5QjoUvInX/jknDlPvxR2B/azrbX/CW38OGdKnGkFY/NXDteG9Xv7wIW2BOkEcB4dLXmTsCel0Ty3xnY3bQQ/T2W2wZMawcAtgmFCGdZQW0QE3yBdGxyN756cyE9n5L69JeKZ5QMgPmT8Y60CGbJHrYYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866847; c=relaxed/simple;
	bh=+yMGTPCSkOLc2FFzZmsCUHxyrmiaeuco4Ghi72cG+s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCDL3YZ9yEd1nlaQ+3W5nBp7D7EtOfT14OnFUJXzAQaxQPysemA/R4j9dhF0JE7TGyTuU+EojnHfvm2db/GR30d7TzO5PI+lhOYwZQjgy5H80KGaNaz1sLHsh9rfA+F9OoVv1QQBToC8HLoDetOeBmRliUvrMI2heCrGwGoc8dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIecTKZp; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIecTKZp"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3db504ab5f3so2922859b6e.0
        for <iwd@lists.linux.dev>; Mon, 05 Aug 2024 07:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722866845; x=1723471645; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idHjvPbdJCUT1qRDAOnY/1uva9G15W/NbgoaUGRZRng=;
        b=GIecTKZpKgYSBsZ4crgvi0F/cx4Y8VXyUA+b9x1f4B4oG4jUXEDMFngRabizleQxyv
         Fht0eagnNS8iLa0qlnUp5bEfAvDd5G4QwXMy+fv2UOEz8o9ng5JBEYV95LQBnghXzjnB
         h/1Jzw6ymvSgidhm2Rri8XnwFMaCAQWZ+cqPDzEaWhpDh+R+ddCKvqoHV83nqIOLEEGy
         6E7zrcWj/RFhrrd2Ujfw+/D6PWo1mtdK3H0lsc9vT/8E6BTgNnSRyOoZCUdUYFWkwBTE
         /fjjZXdD9FeRsTYbV8iho/SHxAKmXQ02IntgQvJCi1nDvXRZFU2Hn6sertFgOM7r/h/l
         m9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722866845; x=1723471645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idHjvPbdJCUT1qRDAOnY/1uva9G15W/NbgoaUGRZRng=;
        b=qGOTcFAavBa+g7hSMz6jfZmeyVESamXVONDI0+20U2dvdolRPuogU08oQMqyVhRtBo
         XPwCqmb9AX8dveETuMpmInZaHglqRjtG5oSpQISsyy+NsfWAv53kdZsNEqylnL8gMHJC
         l658tWpFymJg6cqjWEnPeXP0KoL9jkCsAJXhpGcpp4UMDSnlCHqH8aAZ6/4BV2ZhWtOl
         Qqppbmjuprbz8tgtznkL9zu8Tp5uW3tuwPyCGsKgKDibR39AH5QdDC+B+vr/iNrVLLZm
         WY4PyIiSn/B344NsKlpqapwOAiLbeZ7P4cE2mtkSiGn/Y2XSGj6/g82QRJroXYcMvGxm
         nWvw==
X-Gm-Message-State: AOJu0YxZWR8zC2N0PsliygoQ+4gMgzR5W1pmb2C/ctyWpDryAsnR0M4H
	WCq0R4Gt3JVQf1qQVPyTyEo2+oCQs0a98ncX76of9gevpcVrXJ7zrjVVRQ==
X-Google-Smtp-Source: AGHT+IFwo330Y19anfNnLhk1qEZH+BJalgb3Youd630qMmHXytF4OCrEZ6EXj3zn96y8afKY2IOYnQ==
X-Received: by 2002:a05:6808:2387:b0:3d9:e1d1:155c with SMTP id 5614622812f47-3db55832f34mr10165314b6e.35.1722866845585;
        Mon, 05 Aug 2024 07:07:25 -0700 (PDT)
Received: from archdev.attlocal.net (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db56361a88sm2654172b6e.4.2024.08.05.07.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 07:07:25 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/7] wiphy: Fix use of wiphy_has_feature
Date: Mon,  5 Aug 2024 09:07:10 -0500
Message-ID: <20240805140721.57518-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805140721.57518-1-denkenz@gmail.com>
References: <20240805140721.57518-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Features with the _EXT_ in the name must be queried using the
wiphy_has_ext_feature method.

Fixes: bc7b12d1a4a7 ("wiphy: handle FILS AKMs")
---
 src/wiphy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index fb36ebb2b3c6..6b755ff8201d 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -276,7 +276,7 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *wiphy,
 	 * for fast transitions.  Otherwise use SHA256 version if present.
 	 */
 	if (security == SECURITY_8021X) {
-		if (wiphy_has_feature(wiphy, NL80211_EXT_FEATURE_FILS_STA) &&
+		if (wiphy_has_ext_feature(wiphy, NL80211_EXT_FEATURE_FILS_STA) &&
 				fils_capable_hint) {
 			if ((info->akm_suites &
 					IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384) &&
-- 
2.45.2

