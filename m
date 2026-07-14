Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFC337E5DB
	for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 21:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784063594; cv=none; b=nm4V2CbjDlNdNnxzs6FvKzfSe/9vAWtmCDqTMgBM9NJXccPm3XqI9kT2gWKP4dMXJ4YG94uQNfxkYjTBxlIEVhsF1zzHq8M2e61q6ewRgfLB+MJCB3eJXw1tt6LJIbgHVpmy0Ip8cdCMVitaIVXm8qCtwyk1Q+yJELD9VdQwA+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784063594; c=relaxed/simple;
	bh=HYrM5caICRUX+2rNRet/5Kgts34ZKqBnFlZMkzVitbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ta5BgjQavouiz9whutJHN89BHKEDfGObuR+0ABg4vDw9sbBK1RIv7I8YE5Ojp4hzVth6p7KlORJGifF0VXGRJjAFMUomAjxUSl91VNaTuK4B/xCPrGKgKyG/rXXloJXZbkiohj4dzrGPSCmbWxkDc+EnQnSUFtg1yaKlwo9UxmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnOoTAc7; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnOoTAc7"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b013aa02b2so19870e87.0
        for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 14:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784063591; x=1784668391; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PGfxpV0Aew9w4hKnbRVNd3BNYl0tMtQ8gNMKY988Zw0=;
        b=MnOoTAc7pVh6/YPlBq5hQ9KLDggZK5Qfh3XKUZW7vIaE7v+jjAKXhf2FYY+hjHasjT
         EkkoXwAi28tazwEyowWpXTtd+JVopRoc1rrVMBwVGLCUrbSAhqZ0XlgzLoVv0T3nGee0
         gaTG6fgZPtRYLTCUeV5OVKA26ddOB26FmLSiak1jrep8TZg6IjMTXgfbYiWRigpE21Dg
         UsMroLILRKGUuiJVjEwBeufF8cdy9gWFCfeduA+IR/On3Dmi94HxuFRVcdsSIseJsSac
         xv/fgT2unBG3Q6u74xJbULD9z1S5Jbv/r9CBv/CpiqN+lo+JUps6khp9vH4C9JVCFhYf
         9PNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784063591; x=1784668391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PGfxpV0Aew9w4hKnbRVNd3BNYl0tMtQ8gNMKY988Zw0=;
        b=lc1vTDTNVdP0VnkHK1i28m8wtuwL9enCGDcKH3Wycnqn9k9TyTaT8C16MPJCSfFqcK
         31LVwlQ/Hj/LwFCeT5I/R9hWoeJhkRnQmXGIqCS3YanpWMDseVQqwG8TBBubPk87uOw3
         UyQR4ZRltsib6t9+C8lj9Mvp79+XMS0mbi36ELUPuBAVYTv4jYK7RA6/hh93GY/86N7g
         Olfp/gLxt3yyIGv9hNPTQExCAWj/SopmXrC0jp0DAbuYPvwI4pOice4ZIL8U5/j658Va
         wgSQMj0BQBSmigRl2C5raebenQaIfzKdWSjuiKomundmITAaXkAhDCVOu5IGYjftmS1p
         xSQA==
X-Gm-Message-State: AOJu0Ywgb3g48fv8WgTmBwyWF0nXuUNiI/pmlIuX6Qhmq5vb4mXAIv+A
	VydYYUJYJ2GDdOV4Nab2UOrXvpFX1Lps0T4aURzKj92uUvKdF7KcDfBtKWC1viMPdw4=
X-Gm-Gg: AfdE7clG7zrxara6lD9J77Kkx5Wmst9qY7u+iEjNWWI0SHUXvOHlwjzRVZUe0igPpvf
	x1t8RexwT9GZbrX368cYI6X4P233xEnDwclQlGlCIM953txZ3WYql3FoiRFsB5IJao62Dq50GDg
	jmcmra+BoXUhU1zNSP6teECflxlrQ4BgjOTiJMz5iQFtltVMGGKpvufibxAPW9HuHqMyHG4zbcZ
	yVnB1F8mgTC6uh0/cZ/8iWa7nMhOlI1s56y9gfn5Duo0WK5kD4Jljp+uf9lM+j9zbAhUssYJ3X/
	1rk+Sax2kcKlqLA1ZRzmYK5mDlp2ARk73f//TTGnHKAN/v6J3ZdmcXZC3JsnPHPVbMsAHe+rfGl
	oMoTyLHMFOSsRycQ79pdO2jHlcd4X82BBXZ6HNubnFBgUfnQ4N0TEYsolaYoWSU8d2gB7fjv0bg
	ThYzm5gke/Pm6wBPRm5g==
X-Received: by 2002:a05:6512:1081:b0:5ae:c3c6:245f with SMTP id 2adb3069b0e04-5b023d026famr3482272e87.7.1784063590958;
        Tue, 14 Jul 2026 14:13:10 -0700 (PDT)
Received: from ultra-pc (s3.2dsites.ru. [188.187.190.12])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca4f919sm3770435e87.20.2026.07.14.14.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 14:13:09 -0700 (PDT)
From: Aleksman4o <aleksman4o@gmail.com>
To: iwd@lists.linux.dev
Cc: Aleks Man <aleksman4o@gmail.com>,
	prestwoj@gmail.com
Subject: [PATCH v2 2/3] doc: document BasicServiceSet RSN property
Date: Wed, 15 Jul 2026 00:12:25 +0300
Message-ID: <c7a98e94a67f06fef12078249983aba962e5cc94.1784062939.git.aleksman4o@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784062938.git.aleksman4o@gmail.com>
References: <c684823d-4be1-48ba-94ac-f2c01551f832@gmail.com> <cover.1784062938.git.aleksman4o@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleks Man <aleksman4o@gmail.com>

Describe the optional RSN dictionary and its KeyMgmt, Pairwise, and
Group entries.
---
 doc/basic-service-set.txt | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/doc/basic-service-set.txt b/doc/basic-service-set.txt
index f827ca02..b4f2486f 100644
--- a/doc/basic-service-set.txt
+++ b/doc/basic-service-set.txt
@@ -8,3 +8,26 @@ Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}/Xxx
 Properties	string Address [readonly]
 
 			MAC address of BSS
+
+		dict RSN [readonly, optional]
+
+			Security capabilities advertised in the RSN information
+			element. The dictionary contains the following entries:
+
+			array(string) KeyMgmt
+
+				Key management suites. Values use the same names as
+				the wpa_supplicant D-Bus BSS.RSN property, such as
+				"wpa-psk", "wpa-ft-psk", "sae", "ft-sae",
+				"wpa-eap", and "owe".
+
+			array(string) Pairwise
+
+				Pairwise ciphers. Possible values are "tkip",
+				"ccmp", "gcmp", "ccmp-256", and "gcmp-256".
+
+			string Group
+
+				Group cipher. Possible values are "wep40", "wep104",
+				"tkip", "ccmp", "gcmp", "ccmp-256", and
+				"gcmp-256".
-- 
2.55.0

