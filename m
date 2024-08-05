Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4904412D20D
	for <iwd@lists.linux.dev>; Mon,  5 Aug 2024 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866850; cv=none; b=F0uNRVh1RJMEsrfP/RD/1iKOB4AvkMPg9nDMDDtmy10tgsyGhSQNEl9fBTrOZBNr7YnpCjRG1j62Rp0oK6spwONmVOyvCrPS3TRKhDm7P4k5wvF/BSZMNDbIrwwiHupQNc2OlDvbiO2h4yE7zbn72kDVmitnQdX22ybsiay+sAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866850; c=relaxed/simple;
	bh=1s8rYlEXH7Np0CAvoKA/K/5YN+Flt9sbRiNHuQx66yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsmyoqwNG0v4YDevZ3G/mi5lVKvpIOczHZkTJinSdCIymoObVVfDeKAcZE/fKyf3iw20HRFXbNrOU1RWYhcF9fWxuKmmo3+MFcFr7I9CUqjQC4+Z25yj7knbEU+UdyeORYD6hx3jGn2lfbhc8Y6oZwQLDANGl03A2HPpffZoCOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jszCUR+V; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jszCUR+V"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db23a608eeso7209026b6e.1
        for <iwd@lists.linux.dev>; Mon, 05 Aug 2024 07:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722866848; x=1723471648; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9nYFSEGZUkVCf0LfV3Xahsx5Cwrr7qB8L4Ir/oargY=;
        b=jszCUR+VlcDbuMw1O5079z0KmzZdTrWC0z7a1fABLGcbO/Rve5KAGImIe7cViI70MQ
         E5RV3FS6vHf59wlJeslI14ZDo65S6M1TcJ7czw52sjbhiqfHrapqwChs+RQUueo7ptRX
         KdGanC0981v5Tu9HyisBalfOZdVsT6L+jDt+ea1qqty8LPcTOL6OASux7gWqQPWkRo3T
         p0d2Dglf6X/wlMOTanLQzY7w2xzLvpqEyZNpp+itLVxDhYMRbvbake3YK6pxpj5y/vEk
         kKfbkVjS/pUm/m6kNWUOFbnXqsOErPPxAQe2gBvioo2qv/cFvySDpbP/s6IMD+APkw1O
         UrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722866848; x=1723471648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9nYFSEGZUkVCf0LfV3Xahsx5Cwrr7qB8L4Ir/oargY=;
        b=aqAoxwUlaA2H0SDxLeSV6vwHU+LekQDzhSYhnIiQWQJSypqTdtDIvMVzk34dvJR3sO
         0SEOJmTBsDnGjal9LApuE8IKNJod7N8VcKb6C3ZuQQoKzb5VpCGRHz5qnRk57FgG+mq8
         6wXPXjYlRVkKEkPrE5x9rzpJz8Rkqn9aHpPd2OyoSV44KeDOg+NNbt+Pp/62cN4PsaI+
         9VfKFCJc2S8n/U5hSuQkNbTLu2e65RcGwtVhoMqIBCF5/q/0WDCy+tjBtep03jEDLo2I
         RsYR7/2PDZrJ3Yh1CCZp8544YLZOEmqkTKod6odunN914zxlp22c4dRuh71EjHHrJk7R
         YaAg==
X-Gm-Message-State: AOJu0Yx5ejWQCIZb8kK7uSD+a7SaLUJaoCBU1VAo9bo//Ps5l04P04o7
	a3Zzh4OSIutX3s5k2n7d7s4wGw/Fnc17D0DTzLQe46m0QUxFM6z9cehPDQ==
X-Google-Smtp-Source: AGHT+IHGfExD1upbeNjBsjnKe2aZYZgN1MZU9wCqDL/amk0GE4DXewOtEfnIXnu/QOt32fvFT+lIkg==
X-Received: by 2002:a05:6808:1919:b0:3db:27e6:8be5 with SMTP id 5614622812f47-3db55847b72mr16749973b6e.42.1722866848249;
        Mon, 05 Aug 2024 07:07:28 -0700 (PDT)
Received: from archdev.attlocal.net (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db56361a88sm2654172b6e.4.2024.08.05.07.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 07:07:27 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 6/7] fils: Ensure capability checks are consistent
Date: Mon,  5 Aug 2024 09:07:13 -0500
Message-ID: <20240805140721.57518-6-denkenz@gmail.com>
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

iwd supports FILS only on softmac drivers.  Ensure the capability check
is consistent between wiphy and netdev, both the softmac and the
relevant EXT_FEATURE bit must be checked.

CMD_EXTERNAL_AUTH could potentially be used for FILS for FullMAC cards,
but no hardware supporting this has been identified yet.
---
 src/netdev.c | 3 ++-
 src/wiphy.c  | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index 50e60c5d0c98..fb095fdca561 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3776,7 +3776,8 @@ static int netdev_handshake_state_setup_connection_type(
 	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256:
 	case IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384:
 		/* FILS has no offload in any upstream driver */
-		if (softmac)
+		if (softmac && wiphy_has_ext_feature(wiphy,
+						NL80211_EXT_FEATURE_FILS_STA))
 			goto softmac;
 
 		return -ENOTSUP;
diff --git a/src/wiphy.c b/src/wiphy.c
index 6b755ff8201d..13d498a5cd0c 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -277,6 +277,7 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *wiphy,
 	 */
 	if (security == SECURITY_8021X) {
 		if (wiphy_has_ext_feature(wiphy, NL80211_EXT_FEATURE_FILS_STA) &&
+				wiphy->support_cmds_auth_assoc &&
 				fils_capable_hint) {
 			if ((info->akm_suites &
 					IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384) &&
-- 
2.45.2

