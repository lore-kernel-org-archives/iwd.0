Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DCF212D83
	for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299316; cv=none; b=EaQ5PkXLSx/fiiqSnyeod0xIHqFTatfQYUjElzw/hYxHZr8CrnHFhGqP552WRqQ8Qtkcf+k62eCQ9ASIjdWqHND2qBQ3x8n7sjRPTdme+p20MkaPOaUZFVeP0divjvX7gQZ7cHL7nCy2vkemWyQWbQyOpAc9Wp6TmBmtcNr+cNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299316; c=relaxed/simple;
	bh=/Ii71dp9W26U/2Z1C/k0Mo1FA4fV7Jc/qxhVqyBEG68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IY623qTbOvt1YQ3q7of6dyCrh2KtIm2o0M+FhmPgRHzhQi03Kw1+nSGJhCPUPt1DTVbwVSzAwi6qoY4QqaCZ47ls3B4kSxZaiOto8mFBsEtvAzSKF0S5BlANd0hjIHZD3pknpia5kvXZ21Kyzdbi5GDnPH2q2+jZPDFaglEY3p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Khs0RnWj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Khs0RnWj"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2445824dc27so65082475ad.3
        for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 05:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756299314; x=1756904114; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEFD9LlVakBZXSLnQaoINeCkiUc6jA/ggVSQgyTZHWQ=;
        b=Khs0RnWjbABQS5BS9HcM9z9IpLevUM/CjfNM49wQ8Ul+T8N8ixXXCeBKwU5fdosX4Q
         DiTVMElT1ICU5LnpGV37Yru8DLgSXIDobBCILV2ZyZEQPZZY8LUvgHVoRsXh0RRL/NlN
         HkVZBJ3elqVR+JTqFVQLo8oXoTmmeaGRoxXQCqKNVujq6jpLJFv9xCoUmS1vxtkq/ymr
         VCS+W1i8W1Y5Q2y0RMaIBcLq99TlTI2eZT+uogW3wO4MehXl+tFGPFlcf1+C+oaNGtDK
         5GKTZldXBbXD8Yaax+4bEbAnObNa/Fp34p8bd4YPddLK/j+8jwnghGaNHO9zWN4Caamu
         ahHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299314; x=1756904114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEFD9LlVakBZXSLnQaoINeCkiUc6jA/ggVSQgyTZHWQ=;
        b=T9LtPVd+A6VKQS50hBtR/7++DRqkHu/YHBdPoglnUcqjt8RHGDztcsQU1m6ktPjkUx
         T3nlWqgKR/vmel6fgTEFT8KFwNDZvI8+JOaVuHHMTJCr2aH/HK52/ACWDpJLJ1CqqzZD
         zAJoUHz7GkFTg0TEqBpaNQ7oTJoROCu5/Ta1Io6GUrLaI9RCohJu0K6EoBZea9w2sREt
         GGPW6IOMn/XAb/BNmaKqzwm+BWCYCSqwslr3r0gqc8YU+pX0FIBVTcwz17maouWdwFik
         TkU6LY5pEYJlW6GU+Y0b6mkSehuwFzPyBezQ6kZ72gm0lzSFWoTcXNME+UJqMU1ASbQz
         FD6Q==
X-Gm-Message-State: AOJu0Yx4DyS49V3BQP5GLN2LwRnZsQTvr0/hAe8KFR7mM/NY8ru/5uEe
	mqFeV1uRHChk3QNJgjSp4BcN7LJ4Js23ypm3qa9KhOLchA0DFgh22UOhWc5R+A==
X-Gm-Gg: ASbGncs5HdD6eX+v/oh2xELijz//boTtl0+bM/XPA5z9B+MwPHKZZ2O51MWHT2/cGDq
	28qY+qYmnCt2dWtgty/EPB8nJeWypirhAEsgMr2Hmui2ra+cA0RCM/6+mmHeM7ezM6sYfvym3+r
	/QWg/bIQrBhAF2e769p97Ub+iwUcw526JjR6MqTcoJ51vpQqUiyn0R6wsgMzGP1NybcqxIJbpVo
	KTjnwlu9mXX/Md23rCW1mu/zRFPk0NQjFVxGwxY1awnf8bMpFwClnGMIcuOUIXZE6YqBWSFG/Du
	grE1F1PtOiCU481nF12dCf9oSLUEtVHBp15UsJGiSA2T/qjhNcb7qRdnV3kBNlXG+pjnCpi8fdY
	7wFnb/ulCwlwSqh78XVlA+uHFLvbOQbiKD3BYtDWhK0xQGjAsnmm4GYAk6i3xtFuXLrg/cKKWCc
	Py9Hohp5tw
X-Google-Smtp-Source: AGHT+IGsmf4HBxb1vaT/v60CP81c9yN8QJbIGWM2TOHJ5IyEM8hGtDdjuCiPekngSLJtG8X8BsAM1Q==
X-Received: by 2002:a17:903:298d:b0:248:9429:3638 with SMTP id d9443c01a7336-248942939bamr38606165ad.7.1756299314132;
        Wed, 27 Aug 2025 05:55:14 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687c75b5sm121650955ad.66.2025.08.27.05.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:55:13 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 11/11] station: print vendor quirks (if any) when connecting/roaming
Date: Wed, 27 Aug 2025 05:55:01 -0700
Message-Id: <20250827125501.477908-11-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827125501.477908-1-prestwoj@gmail.com>
References: <20250827125501.477908-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes it clear the BSS being selected for a connection/roam has
any quirks associated with its OUI(s) and that IWD may behave
differently based on these.
---
 src/station.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/station.c b/src/station.c
index 4a29c9c1..f8069d89 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2750,11 +2750,15 @@ static bool station_try_next_transition(struct station *station,
 	enum security security = network_get_security(connected);
 	struct handshake_state *new_hs;
 	struct ie_rsn_info cur_rsne, target_rsne;
+	const char *vendor_quirks = vendor_quirks_to_string(bss->vendor_quirks);
 
 	iwd_notice(IWD_NOTICE_ROAM_INFO, "bss: "MAC", signal: %d, load: %d/255",
 					MAC_STR(bss->addr),
 					bss->signal_strength / 100,
 					bss->utilization);
+	if (vendor_quirks)
+		l_debug("vendor quirks for "MAC": %s",
+				MAC_STR(bss->addr), vendor_quirks);
 
 	/* Reset AP roam flag, at this point the roaming behaves the same */
 	station->ap_directed_roaming = false;
@@ -3913,6 +3917,7 @@ int __station_connect_network(struct station *station, struct network *network,
 {
 	struct handshake_state *hs;
 	int r;
+	const char *vendor_quirks = vendor_quirks_to_string(bss->vendor_quirks);
 
 	/*
 	 * If we already have a handshake_state ref this is due to a retry,
@@ -3947,6 +3952,10 @@ int __station_connect_network(struct station *station, struct network *network,
 					bss->signal_strength / 100,
 					bss->utilization);
 
+	if (vendor_quirks)
+		l_debug("vendor quirks for "MAC": %s",
+				MAC_STR(bss->addr), vendor_quirks);
+
 	station->connected_bss = bss;
 	station->connected_network = network;
 	station->hs = handshake_state_ref(hs);
-- 
2.34.1

