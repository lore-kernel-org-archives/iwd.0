Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE99A934
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 00:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956576; cv=none; b=Pw2kogJVzzWC1/v659J5Kk6IJKOFsr79n1kq6fH5Os0ROYUQlODwk1rh7QYcwvSXQkX+UHv1xfMRE0yeqp6tFepXDGTuIJYDhysBKfp2VWc/7fJPa3BzgM/X7lIHZ0LVAfb9BoTjVSmy9Bs4C6t/XpG9dAycAOSvhO0C/PR5wxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956576; c=relaxed/simple;
	bh=6fNUlTMf4D1XF5Cz7EsH/Fk1taGOayyBLPs9cr6k+eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psHbMaKYjgLEkHb/v6tAh/15pKbRDLAA+yHvhUKb4qCItq2HT2EjbEEmvFi5rqkO6ofTjfoI9Rp/mbsudDIpZ+ngbnU4V/ffUEIeCmiCO557bol5XU3AXjOHCJHxJXFgm6bK/1vPXhY2ADfWDJjr6MPc1ks3GODXIUei4TG0RiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj+6nW/6; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj+6nW/6"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5b206048ac2so428140eaf.3
        for <iwd@lists.linux.dev>; Sun, 05 May 2024 17:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714956574; x=1715561374; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LolnO6L7lvPzalyIjZImicREyy8Oz95WG7dGLXReUBY=;
        b=Yj+6nW/6sP7KSSK5ud3PQQJbLP9Qc+j9CSJEpsQGbseBaHbWH4GUJGek9XSVC96ZVB
         bDg6nxMyD8UrkQh2HOgqy4SydQALyknmjvVSRwxAwLqUOxerA7RMSgF3FBooBurxxMUD
         srVUJK/DhJXctoIc0F7aoL9aLGcunEJ5L5ojeuqWwYXt1iEV5/tUMJkeptaNqc7hxbfl
         lvDxMd1yWZrXKdlKLv46D/2GgIpGdCAeyDQfw1T1mOl14x7vim/ci3nRHBGmupev7MsQ
         ZGcFrS2bx8lX8ghoGy26ZrqMX3p4xK5VcHgCHOFT0wuks4TO155w0ZPxQm+az6vFcqVQ
         zugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714956574; x=1715561374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LolnO6L7lvPzalyIjZImicREyy8Oz95WG7dGLXReUBY=;
        b=wfp7QGksPZ8MrneImbRMLSTlXKpjAjTpeyXKkN4DK0DHyCa9DZjMnEvXxGkBaRPF6n
         ORXC84LdV9CjWUZ7UJzhb/bScyocp7GNm1hb/s3kU39IN8wEnpV8wsFa0jLIfxz7x3lY
         xymZ0E93NFfBHVlNinaMohcP8xySsiJhXBXrz9EIpaSVQSiYyknz9fZxAiMt3dn/7124
         xQL++Nj6P9jhGDf8NHU1+/+8PzZi9nVSlW9T2E5Zz0W3C9s667WuKTS4E8eWhsCwGNX4
         E5qswElXz4v4G0PJNfdDhyBmIafcXqDSbVNaODfNXSfh3ZkfgwJoaP0B75VNM1wgprwb
         2cig==
X-Gm-Message-State: AOJu0YzMQoNwwHe/Zb6gtAIcJLSkIM8F0QO/g11FvXVpVwjT1w4U1gqp
	hIpryV7KDSyzxYsOT4qLEK+ii4ut4vt9AbE7cuVxdLFkl/PMFbn+g0xbKA==
X-Google-Smtp-Source: AGHT+IHgSyg9zva1nYrv6IbSfnlwicYjWjc36HwSi06G4IAoCX/BD0OYGDP5BVg7pPyucflLqN+YfA==
X-Received: by 2002:a05:6358:598e:b0:18e:a0ce:a34f with SMTP id c14-20020a056358598e00b0018ea0cea34fmr11418342rwf.14.1714956573716;
        Sun, 05 May 2024 17:49:33 -0700 (PDT)
Received: from localhost ([192.145.118.41])
        by smtp.gmail.com with ESMTPSA id g1-20020a63dd41000000b00606dd49d3b8sm6836017pgj.57.2024.05.05.17.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 17:49:33 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH v2 10/18] ap: enable start of 4-way HS after SAE
Date: Sun,  5 May 2024 17:30:33 -0700
Message-ID: <20240506003518.320176-11-brandtwjohn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506003518.320176-1-brandtwjohn@gmail.com>
References: <20240506003518.320176-1-brandtwjohn@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accept association frames that request SAE if SAE is enabled by the AP.
When SAE is being used, get the PMK as negoticated by SAE.
---
 src/ap.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index ec27180e..ae406e16 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -1500,12 +1500,19 @@ static void ap_handshake_event(struct handshake_state *hs,
 
 static void ap_start_rsna(struct sta_state *sta, const uint8_t *gtk_rsc)
 {
-	/* this handshake setup assumes PSK network */
-	sta->hs = netdev_handshake_state_new(sta->ap->netdev);
-	handshake_state_set_authenticator(sta->hs, true);
+	/* this handshake setup assumes SAE or PSK network */
+	if (sta->hs && sta->akm_suite == IE_RSN_AKM_SUITE_SAE_SHA256) {
+		handshake_state_set_pmk(sta->hs, sta->hs->pmk, 32);
+		handshake_state_set_pmkid(sta->hs, sta->hs->pmkid);
+	} else {
+		sta->hs = netdev_handshake_state_new(sta->ap->netdev);
+		handshake_state_set_authenticator(sta->hs, true);
+		handshake_state_set_pmk(sta->hs, sta->ap->psk, 32);
+	}
+
 	handshake_state_set_event_func(sta->hs, ap_handshake_event, sta);
 	handshake_state_set_supplicant_ie(sta->hs, sta->assoc_rsne);
-	handshake_state_set_pmk(sta->hs, sta->ap->psk, 32);
+
 	ap_start_handshake(sta, false, gtk_rsc);
 }
 
@@ -2258,7 +2265,7 @@ static void ap_assoc_reassoc(struct sta_state *sta, bool reassoc,
 			goto unsupported;
 		}
 
-		if (rsn_info.akm_suites != IE_RSN_AKM_SUITE_PSK) {
+		if ((rsn_info.akm_suites & ap->akm_suites) == 0) {
 			err = MMPDU_REASON_CODE_INVALID_AKMP;
 			goto unsupported;
 		}
-- 
2.45.0

