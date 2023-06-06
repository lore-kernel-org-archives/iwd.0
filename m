Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F3A37B97
	for <iwd@lists.linux.dev>; Tue,  6 Jun 2023 15:04:21 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1b02d0942caso29244565ad.1
        for <iwd@lists.linux.dev>; Tue, 06 Jun 2023 08:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686063861; x=1688655861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z8TC+CPgC4dPed1a/NhiXaPJZ23buV7TiH+dzb45uDM=;
        b=NHxjGtouFnIHjoTN4lOCP5meqfHJPnC0HSW/8nRxxEkO9nVsEumN8ef0w5F/+dr1Q8
         +SehXD+HOTKNxE1YT/DB3OZMDGB3PWMutjXzalhrqV1hnV7BtM0K1FAE2FC8is7i9FMt
         4hX5qw/tdZygUZf672XVfZfmLfCqa+f2E4X+9m6w9UI0cxK+hp+06Wyzslj0jiP6THsF
         FE55jEmbFAPJMbvuDGTkxTWaXOL6gQTTxSP5o7/x6xBNMBLDmoDI6v07ktJKATWfbqFr
         d4dlKopK7YMUPX8Fk+a1A3eH8ZM88LDI9aYK5iqlLrGJIPtugFaSjtOKprbAbR8SYV2H
         Rpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686063861; x=1688655861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z8TC+CPgC4dPed1a/NhiXaPJZ23buV7TiH+dzb45uDM=;
        b=k3Z+uIpUv/XiUqGtf6miUPBDMYyvsI5Lbh5SpsVoGERCeQvna0uqp9VTF908nVtSc+
         a3mQO7US+rx/ViG7jyHYz7BHOLUq/EQx3f+evFlMRQCxlKAt5WU3Qnrmb+7NOvUBD3BW
         PNk0vcjqG2LrhG3EJZgbJtxYdlv/hslmP5pbTEQge0xfb7AUHq4bRFj64LNztRrVDVWH
         vLNbngQl81xO/+dz4GbAIw9s+ezSaIWGSKOHJLicFEelTvpwxWAKH2X3fgZT2eS9VlKJ
         qJx23wujh8oYgv5G8W/Qa0jgpyhKxzc1/5n/QS1L0ooc2B3G8YSwLEzTLhamkcbQ+eTb
         +86A==
X-Gm-Message-State: AC+VfDy1xNJsttACMMYMVFKEuHEzkX0dOX5RPGZLA4o0ZDBVmbfCu4x6
	Z4KoNonqkPVwtuD/PVZIAafVbm8vodE=
X-Google-Smtp-Source: ACHHUZ4VMr2NS8rweUDwEXRqxDsZ1n2wvB95IKhkl8G9/PoGTded1MlEA2irH9QoQhskSYrPHOYITw==
X-Received: by 2002:a17:903:1208:b0:1b1:adb4:8fa8 with SMTP id l8-20020a170903120800b001b1adb48fa8mr1058517plh.39.1686063860919;
        Tue, 06 Jun 2023 08:04:20 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902860b00b001b045c9abd2sm8641754plo.143.2023.06.06.08.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 08:04:20 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] ft: add debugging in __ft_rx_authenticate
Date: Tue,  6 Jun 2023 08:04:16 -0700
Message-Id: <20230606150416.115864-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there was some problem during the FT authenticate stage
its nice to know more of what happened: whether the AP didn't
respond, rejected the attempt, or sent an invalid frame/IEs.
---
 src/ft.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index 62fb0ae5..e223484b 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -1000,14 +1000,21 @@ void __ft_rx_authenticate(uint32_t ifindex, const uint8_t *frame,
 
 	if (!ft_parse_authentication_resp_frame(frame, frame_len,
 					info->spa, info->aa, info->aa, 2,
-					&status, &ies, &ies_len))
+					&status, &ies, &ies_len)) {
+		l_debug("Could not parse auth response");
 		return;
+	}
 
-	if (status != 0)
+	if (status != 0) {
+		l_debug("BSS "MAC" rejected FT auth with status=%u",
+				MAC_STR(info->aa), status);
 		goto cancel;
+	}
 
-	if (!ft_parse_ies(info, hs, ies, ies_len))
+	if (!ft_parse_ies(info, hs, ies, ies_len)) {
+		l_debug("Could not parse auth response IEs");
 		goto cancel;
+	}
 
 	info->parsed = true;
 
-- 
2.25.1

