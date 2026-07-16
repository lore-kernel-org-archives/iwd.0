Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36E32D63E5
	for <iwd@lists.linux.dev>; Thu, 16 Jul 2026 02:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784169387; cv=none; b=Lt+WOHRtJHeBgbTr9ww8eec36Fz9SMtTNB1PowZHEoLlGPMqezDUglR7LT8N9CyYr1+miKInHNojvKc2r+HlhzZaLVcgn/KUZ0AT0xgSOLtnvtT9MKWVxAYRAzP/KqMelMYVPIuYRp67iSBnOqR5EnEXIrKyQbVjoz1jxbcHkzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784169387; c=relaxed/simple;
	bh=WwQa8aDgtWFCgmE2TeXqH+lNiekZKa9PwBzBMqPqWhM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iB8+0vfkvcbuj9+S7WJ/yIVJNl8aLe7j+dxR+nsA/nP1WpmmKIb2dfT6fkanoUvZPa0o+pjA8XcddPsCvKCX7we5272abxaN1igms4hh3j4NFBEeO2mUNYIKXrFm4AVqBuzAIJWANrAmFzKmx37wd/DGf0zQp5wjxMZIyOlmNBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtjLDT5q; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtjLDT5q"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca965de53baso1606658a12.0
        for <iwd@lists.linux.dev>; Wed, 15 Jul 2026 19:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784169386; x=1784774186; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YBS6EQoynlZzpDfc+IrAfz3jUXRnQAz3dlw8jkkg38k=;
        b=HtjLDT5q8Yx6pW96hKmqCs1G7MKJsNoR2kVzzCSZOX8MgOJplxJ/S0JQI6snd6C3uK
         VyVYUW8wYYcm0ArllZUjUpHNA3/CIHpbMxJayKGYTN2bxznbc672/8dqgWF666pfaJZC
         INQpZqe4/kFZeLCjb0TDTwN6xVQgD6MC9Z7lQ9SS44PNmBQo7qAlyi8V1t1sL5jcqkp9
         PZRMGNFK9+gUNR2sqo2TptJPE6P4K+0mgZ7D1yb+kBA0Y0PxjGl7uFCUMjDXk5n/oi1u
         pwVM2PHiG48hrDjvuApuBbL/P+4UqLqhzQVtBXt0feYhA4xmkS7hgchVTNo+HD5LicWN
         9ShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784169386; x=1784774186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YBS6EQoynlZzpDfc+IrAfz3jUXRnQAz3dlw8jkkg38k=;
        b=BYTPzh9xeKgKQStmPt/ZPfHJopKm+xVW0MMvziA28wU4PC2FZ4pXTzx6FjDUvpzOLV
         k9OHNgMG+WoLbvRS8dZ5gttVK5WvRs9LCXwIkWOWEgDUVxp3Sf/ofCmftrSEEXmnvsWN
         FXd+kAaG6j/9QkuoF5cCwii5WC11av1M5kBagiXx5W22yT0A2lCaELc0W02yQW2ao29X
         N+h2ptciZS7Nt2PMxo5abQEE6ztXYTEHWC7OM6s/7c+cal+F5wXZejFoxLa41fmSL936
         AjbbetY5acDXLvoLA1u0iwhNzhFccTz014k7WIv38KyJgN3rYOjgzFbf78FxPvO1pr1F
         Wubw==
X-Gm-Message-State: AOJu0Yy8EGiO9f3yxvRNNsGOH6QSbrPXVILMgpIoQwQP5X5+nN2xJ/fg
	ke1Xj/Xu0Bf9rgTni4RXvMxCH7oBPdguCEfLzoSzmxC6+GU4Tn6IDijkqcUXTVc=
X-Gm-Gg: AfdE7cls2tRXgZ2gvwxU2u63sYkkacT75clzjdGn2HbkHtwsSlwre/wb4FWXVqmMU35
	nzdDcniyqyuuXgJLV+YS3+GZ8kx9EReeUtY1bIFra+rxXa67QDPpFQNUqGxm2/uh+S0staK47oy
	yfpg6tmbOVJR1HG0Hss5dBJyb95ReSWo07Ja7EoX0r3X2J4ZZSgA5R+MEsrGjabP3UDGBiBIqsn
	XnklDRbDpPLH56OCGkO2btmyswVzVXH2pO1A1pm4JrjJNm0KssQxtpgBjX3S09/hrfckn7m1fU3
	EdVrEPZPFbCycI7Zv1HRUpE0WAjtl4xI9/4Jq4wfHVweRxMYtfsi+MQ/oXQCpDz1HpdahLS5w0z
	Yo1pAru9GH82+EuUrrSpeoPYPv4PY+TVM6IyPW9pSFQgUFoNQzUztFj0xAmWUieCc8YcAcxlTyG
	CWgqiqN6o4oaJ4Pg1F6YuvwY7NKnGWQA/yObN71g==
X-Received: by 2002:a05:6a21:9216:b0:3bf:bde7:d66f with SMTP id adf61e73a8af0-3c11076c6ecmr22617403637.2.1784169386082;
        Wed, 15 Jul 2026 19:36:26 -0700 (PDT)
Received: from matic1.1020marsh.offices.matician.com ([2600:1700:471:807f:aff0:107f:e34:fd6e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e5306afsm6060595eec.9.2026.07.15.19.36.25
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 19:36:25 -0700 (PDT)
From: Suchir Kavi <suchirkavi@gmail.com>
To: iwd@lists.linux.dev
Subject: [PATCH 3/3] station: fix NULL deref in ap_directed_roam
Date: Wed, 15 Jul 2026 19:34:44 -0700
Message-ID: <20260716023444.3512595-4-suchirkavi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716023444.3512595-1-suchirkavi@gmail.com>
References: <20260716023444.3512595-1-suchirkavi@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

station_ap_directed_roam() initialized ignore_candidates from
station->connected_bss->vendor_quirks before the state != CONNECTED
guard. station_disconnect() clears connected_bss before entering
DISCONNECTING and the WNM frame watch outlives the connection, so a BSS
Transition Management frame arriving in that window crashes on the
dereference the guard was meant to prevent.

Assign it after the state check, which guarantees connected_bss is set
(the frame-sanitize memcmp below already relies on the same invariant).

Assisted-by: Claude:claude-fable-5
---
 src/station.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index 0b2d7dc6..e3aeb3fd 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3273,8 +3273,7 @@ static void station_ap_directed_roam(struct station *station,
 	uint16_t dtimer;
 	uint8_t valid_interval;
 	bool can_roam = !station_cannot_roam(station);
-	bool ignore_candidates =
-		station->connected_bss->vendor_quirks.ignore_bss_tm_candidates;
+	bool ignore_candidates;
 
 	l_debug("ifindex: %u", netdev_get_ifindex(station->netdev));
 
@@ -3283,6 +3282,9 @@ static void station_ap_directed_roam(struct station *station,
 		return;
 	}
 
+	ignore_candidates =
+		station->connected_bss->vendor_quirks.ignore_bss_tm_candidates;
+
 	/*
 	 * Sanitize the frame to check that it is from our current AP.
 	 *
-- 
2.54.0

