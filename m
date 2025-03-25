Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4592641DB
	for <iwd@lists.linux.dev>; Tue, 25 Mar 2025 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742925664; cv=none; b=Hsbi2e/7FHIZFzJQyB/C7QbtPd+kyvA4ZjDyvisDaK9ku0JbECXkhGcw6rELWS9s3VVazZhZCucR++cgcNcFLZX7EULQTDCKFFWssTr0PLp3fP+mp2/14DZWmOp2OSMmitWEtWPegI1TsAl16FIphzY7qbnVku45afh2rWTMoTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742925664; c=relaxed/simple;
	bh=xJw8fzLY1QOp9k4C09DNl1nVXAxf2RpfpK3Wm+/TKvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CJxSzhzIpYqdwQDImk8BxN4MlSrnTj7X+f43PTmEGUBNr0I8x+PrwoDUCdh7m+KXMoo50fvufLZm3SHh2od+nmQBxfhIl9Jp65/Cp46De5CL1xP996+d+MlED5Li8jKOXfE0hY7W1sOIg9Z717ezImmpMSYmRydRC4TYebLGrJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j++fH1je; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j++fH1je"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22580c9ee0aso122622195ad.2
        for <iwd@lists.linux.dev>; Tue, 25 Mar 2025 11:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742925662; x=1743530462; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7afZSfqph7WYiyk1RsbI0lhF++mY2dDXwnL/R2D56yA=;
        b=j++fH1je0oAj2f3gADBsCvq1R6q/yRSGJSg3wyrQpJk/eax8LtStkrSPBkN6iOO33a
         lVXJTJY3lT4eakzjmCjKxZRd52wOsGyFCVBKN8IFD0kZ6AJjJIIdKAh0xc4CZgo1PNio
         FnLLPxH9uyXbR04jLdxeG17Pl9s54zpYuMg1tsuD4hX+vqs7BhhdVxjp4fPivrg+rR6t
         BENQunEJ2+Qm+a5LcCGnUjgClWfw/HitDxe+5DLMdlwX6K9k/waF565Nk9IlXMV6jYqt
         yBx/hBKsRqkvnpTD3U84nnrQZPiLSYSBDRymDhcGfR7b085EsHMmmbiHkJAMk0I00ofy
         nQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742925662; x=1743530462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7afZSfqph7WYiyk1RsbI0lhF++mY2dDXwnL/R2D56yA=;
        b=jx1wbjaAvFvjtETcweJsOQMhsQ7mgIXooD3UeGePSRPEyL6+osUOQyr8cE0KntWiS+
         GAgolF7Bl/egy/xnsd87jW+NtkjXU7Jh+4tT/6Foh0jEsCww8mBNrp00sXXyXGUJEZqJ
         xE1wPVxwZ5WMs7fE+7R3RgCpGqwht0gehm6lIiNEjceLmumYcQVP6uvF5S7cF5dfrPH7
         qNB45ndEGJsLpOhRNKT8OmiSBS1K+VNGTqvJY1fbe2sHarWswnWcOfnX+CZib5PdMd7S
         h1C8wx9erMlIv+LfSj6vnoQ67wGyfOSP4kzjuy/oPtj7tdVwan5NTTyK5ylTkCWrr8/U
         ul5w==
X-Gm-Message-State: AOJu0Ywxz+g7Vnniq8I/y6JOmjvftZ0j/l6deXyCzaiASMtUtrX693Os
	SFAAkLNePG2bc21/NKH8/FVJKPZvJ+XnXRozabfpfDFlGy4cpx3UiPa9lg==
X-Gm-Gg: ASbGncsgzEs/7v8ky14QsZ4vy3VFJ5su9amlN2y1x+Cfs3Yq2/V6u7rLAjHulurJ5au
	+q5mKIkuy8PvrUPPZXmeek7IDTgL57PrwZBgLWx2wXc+OsP6+YBSRjAl5qlMtwC/GXVOiQf1Pp2
	JPJmKBzisHwit7HIeEQbdaokuA1+4EaY82Cxt1vjxO1nkUGkecAWR3EWle7irK8TUSvEms25Dj2
	g8lpxPGWKeA41qmIX5jjcVmwCOfQQvu3KoT+RXKGM1eB5B2XycqYIwrVJ98I/ZhXMVK+ucynMhs
	qg4zAgKwuSuQWFfwFec/6NptSSOFhrPm0ocXLwSrCb44LKD9DqbRLKB4cU6h6H1WvUi8Bgg4br7
	qrOo=
X-Google-Smtp-Source: AGHT+IFzcdfUVX7yG8sQdtn0tAkRziPDdyaflB6NQmX7PLI+YrC3QvAmp0Z0Ulo/zZHVY18ELdZUUg==
X-Received: by 2002:a17:902:ce0f:b0:216:2bd7:1c2f with SMTP id d9443c01a7336-22780c7ba39mr218941445ad.18.1742925661789;
        Tue, 25 Mar 2025 11:01:01 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811bae9asm93770515ad.138.2025.03.25.11.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 11:01:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 06/10] netdev: add netdev_get_low_signal_thresholds
Date: Tue, 25 Mar 2025 11:00:37 -0700
Message-Id: <20250325180041.238676-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250325180041.238676-1-prestwoj@gmail.com>
References: <20250325180041.238676-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/netdev.c | 9 +++++++++
 src/netdev.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 2a6d94fc..31ccf9ab 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -463,6 +463,15 @@ uint8_t netdev_get_rssi_level_idx(struct netdev *netdev)
 	return netdev->cur_rssi_level_idx;
 }
 
+void netdev_get_low_signal_thresholds(int *threshold, int *threshold_5g)
+{
+	if (threshold)
+		*threshold = LOW_SIGNAL_THRESHOLD;
+
+	if (threshold_5g)
+		*threshold_5g = LOW_SIGNAL_THRESHOLD_5GHZ;
+}
+
 static void netdev_set_powered_result(int error, uint16_t type,
 					const void *data,
 					uint32_t len, void *user_data)
diff --git a/src/netdev.h b/src/netdev.h
index 6299934e..3962dc93 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -158,6 +158,7 @@ const char *netdev_get_name(struct netdev *netdev);
 bool netdev_get_is_up(struct netdev *netdev);
 const char *netdev_get_path(struct netdev *netdev);
 uint8_t netdev_get_rssi_level_idx(struct netdev *netdev);
+void netdev_get_low_signal_thresholds(int *threshold, int *threshold_5g);
 
 struct handshake_state *netdev_handshake_state_new(struct netdev *netdev);
 struct handshake_state *netdev_get_handshake(struct netdev *netdev);
-- 
2.34.1

