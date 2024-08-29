Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DED0158DB1
	for <iwd@lists.linux.dev>; Thu, 29 Aug 2024 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931668; cv=none; b=p0uXqOtOLdye2RUI1sEtDdkPidOmtpl74sp+w6XOFiZotmrZRX1/vHSwxmAka0IwUswRTVBogBxGgDZmyBXzXbgbioBJmh3nBHRR8wFzllUjEQYWNj5KFzFVlLgZ3S7f4EqBRDDmqJTjGkuWRMP8b867iwEJF0OQhZDcQywq4Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931668; c=relaxed/simple;
	bh=Gp1IAKVY7rrkac/tCaYKnWKQnH3vQrMI2KZTwfwKicE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PrS/0XSTF8mTaa9lvH1HZJYATKt66gIBR2uwPq4+54SVpz35lRdpgYIvm+wEShL6/x8ZX+ZY2g04j042uUh6y1ujO/8aJwj5Urb+znjYZWjs58kzb8F6vGNDF4TZVKEcz4kTmb+Em2tlFxykO2+8XZZ1a/WNbGJqTegMwfGRfcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnAt3kWN; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnAt3kWN"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-714287e4083so509488b3a.2
        for <iwd@lists.linux.dev>; Thu, 29 Aug 2024 04:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724931666; x=1725536466; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkhYR/btK9h5NdKiQMAcxkX+jV8fpC/zK7q59e7K3wg=;
        b=fnAt3kWNVyUH5q/PhvaZM2BLm2llJQBjPbihFliU8O/1IgqhylEFK0D4ck+25tj6lV
         O5QXK3fxOhBEEsfA13j0ICnD/msmqrF7thNrInWIRbVQN2a0Ne+zUDCS0BPio25rmF7/
         QsAM0hw5BxaNIJLD2YTUFog/CeGj10iuCTj4kk9CCC+OW0UjfkmCCYrn2K7MfET1my2W
         ZAPAHpUQc/s2+7fW8boP1xUAZgbirGXCaa6XFpm5VT0iXKVuGUz1yrojiQOj3gP5ojyN
         Ggk8Cg86RBv4VMcUvC/krceM12xmiQIwzZ+VlZMH1/g2XxxJcMvIv7/tUbsLNotcKtkY
         HQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724931666; x=1725536466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkhYR/btK9h5NdKiQMAcxkX+jV8fpC/zK7q59e7K3wg=;
        b=M+lnX+NQo5PEeg+/SpDzORPsMuO4uQFQtgHjBtZZiYsP8F3vKAtRjMo29I3/nHn2le
         zEjOdUCtSPQcbrrUD/LVKKMrcA4V+xvqX9gmeyr39YCMaWsSaApfFustWNDyQolSFG0t
         HkeWRLnb64nnvZF+qqcKYtuwx49WNZBpJciAb5h89b4JnAtgROVtuR/WsRRU1BBWMOgr
         d+ijpibyBzLsAmLKrslCzOaNkrcsGh+jqo+hNU7w55kJ5e517/9lcgXdx1dxiet15tOg
         32kEZWtQIjKOnJtDJQ7I8+HOP7jwiD7DYeLUjqdazdukA7Y/gD52vPRYCZW9pmJGJZ5H
         QWlg==
X-Gm-Message-State: AOJu0YxZTHI7orkWqKZzfUeX4bZYJ264onf1wzJCdcohpGv7By2suFlS
	f55vBrVwv1EqPU74CFtoFtDC4dnByuPvN6n79mi0QPfGjZIeMOqPY6vvUQ==
X-Google-Smtp-Source: AGHT+IGIGoLWa8mrIZfpmKuskcsQeSz/YpZplu27fAlOehWGXXRwqFFo+Cab4fAexy1H4bLiZTQDug==
X-Received: by 2002:a17:902:e54a:b0:202:3735:6239 with SMTP id d9443c01a7336-2050c37233fmr26960325ad.34.1724931666326;
        Thu, 29 Aug 2024 04:41:06 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b37d5sm9699315ad.25.2024.08.29.04.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 04:41:05 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/3] station: don't allow FT-over-Air without offchannel support
Date: Thu, 29 Aug 2024 04:41:01 -0700
Message-Id: <20240829114102.56284-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829114102.56284-1-prestwoj@gmail.com>
References: <20240829114102.56284-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If CMD_REMAIN_ON_CHANNEL isn't supported, don't allow FT-over-Air
---
 src/station.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index 30a1232a..5f174a70 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2105,7 +2105,8 @@ static void station_early_neighbor_report_cb(struct netdev *netdev, int err,
 				&station->roam_freqs);
 }
 
-static bool station_can_fast_transition(struct handshake_state *hs,
+static bool station_can_fast_transition(struct station *station,
+					struct handshake_state *hs,
 					struct scan_bss *bss)
 {
 	uint16_t mdid;
@@ -2133,6 +2134,16 @@ static bool station_can_fast_transition(struct handshake_state *hs,
 			return false;
 	}
 
+	/*
+	 * FT-over-Air in its current form relies on CMD_REMAIN_ON_CHANNEL. Some
+	 * drivers do not support this so only allow over-DS if this is the case
+	 */
+	if (!(hs->mde[4] & 1) &&
+			!wiphy_supports_cmd_offchannel(station->wiphy)) {
+		l_debug("FT-over-Air needs offchannel, using reassociation");
+		return false;
+	}
+
 	return true;
 }
 
@@ -2596,7 +2607,7 @@ static bool station_try_next_transition(struct station *station,
 	station->ap_directed_roaming = false;
 
 	/* Can we use Fast Transition? */
-	if (station_can_fast_transition(hs, bss) && !no_ft)
+	if (station_can_fast_transition(station, hs, bss) && !no_ft)
 		return station_fast_transition(station, bss);
 
 	/* Non-FT transition */
-- 
2.34.1

