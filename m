Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E053CCFA
	for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 20:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rts+yW+Q"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1c8a1541232so12412145ad.0
        for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 13:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140929; x=1697745729; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1mQNPSPsVlJe67kyZKXg3OtbokCYP4GCa9A0hj1t2U=;
        b=Rts+yW+Q6lcQXeFRCuTxUkEd4cPzjeN5rty7b8tV2ni12+nSLPDKpo0Kk/Pm/wGRTe
         hq26OXBv6Z7rhJW4WDiIBWeRTrgYqqaI27uymIahMD0K54v9FMWbHZuS81FT6Hvmcpap
         UoJm+tS/R0adpC20uN5apDrAKf6eqkLQ7j3go/szXt7hUnA59Wn4yQwB6Any1xlJbDlQ
         ZQ0DrYwm6yha8lXf3lGka6VWcTbZAOQvMylIZsvJebzseCO64zp6s4eLxLoB/buwoBol
         LdQQUedTVksNghwXD3pCqbv89Ou8nU3TQ3yfXF34cmKgR2N9TZWNa2doibYmVeOSneU1
         wQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140929; x=1697745729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1mQNPSPsVlJe67kyZKXg3OtbokCYP4GCa9A0hj1t2U=;
        b=hRhfPm2aUbLfhOKutnYtvdFyQblCH13ZThP/iIrzX16C0sh17r6IY9l8li6MrUh3BE
         aVhrTX9dBUSDSvs5SXYE+yf9ywkyAJd5cZAtH38vtEhTG7r9nzDJQXJPYkrwcs82FAZz
         BoC7dAPnP9M6BR9qz9Lzi0EZ2xxzk3NbYObRfrKMLLmrAP0U9MJyhcauQcUkZ07DrNNo
         q2KRllmRHDFT702aCCVnMnP+WHgPaBceZvsn20YurP9ge7hDlywa4cd41gaC7341z+9v
         a80hMf1RzLqiK3dPo+ZXqHkEWmxbw3z3T7pBZYtdk3ybCjT5muYvZOcmcj5bhXdXcsAg
         cZ9w==
X-Gm-Message-State: AOJu0YwqzNwt989bpd6+wIWTV6wRsEXDgieP1Eu8x9hv+SqFXBMESODV
	LK9hieln4BL/0CGpigKHdSeJDmXzDX8=
X-Google-Smtp-Source: AGHT+IFbAobkMwiCu+AMjJw/ulbLO58hqTG7ciYHe66P2ZUzUTKDXXIqkmNXi3zmQQB9Gp26KIi2/Q==
X-Received: by 2002:a17:903:228f:b0:1c7:1fbc:b9e7 with SMTP id b15-20020a170903228f00b001c71fbcb9e7mr29819218plh.43.1697140929160;
        Thu, 12 Oct 2023 13:02:09 -0700 (PDT)
Received: from localhost.localdomain (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001c727d3ea6bsm2388057plg.74.2023.10.12.13.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:02:08 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 15/21] dpp: allow enrollee to be authentication initiator
Date: Thu, 12 Oct 2023 13:01:44 -0700
Message-Id: <20231012200150.338401-16-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012200150.338401-1-prestwoj@gmail.com>
References: <20231012200150.338401-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Until now IWD only supported enrollees as responders (configurators
could do both). For PKEX it makes sense for the enrollee to be the
initiator because configurators in the area are already on their
operating channel and going off is inefficient. For PKEX, whoever
initiates also initiates authentication so for this reason the
authentication path is being opened up to allow enrollees to
initiate.
---
 src/dpp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index adfebff3..fb025ac3 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1451,7 +1451,7 @@ static bool dpp_send_authenticate_request(struct dpp_sm *dpp)
 	struct scan_bss *bss = station_get_connected_bss(station);
 
 	/* Got disconnected by the time the peer was discovered */
-	if (!bss) {
+	if (dpp->role == DPP_CAPABILITY_CONFIGURATOR && !bss) {
 		dpp_reset(dpp);
 		return false;
 	}
@@ -1472,7 +1472,8 @@ static bool dpp_send_authenticate_request(struct dpp_sm *dpp)
 				i_proto_key, dpp->key_len * 2);
 	ptr += dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION, &version, 1);
 
-	if (dpp->current_freq != bss->frequency) {
+	if (dpp->role == DPP_CAPABILITY_CONFIGURATOR &&
+					dpp->current_freq != bss->frequency) {
 		uint8_t pair[2] = { 81,
 				band_freq_to_channel(bss->frequency, NULL) };
 
@@ -1910,9 +1911,6 @@ static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
 	if (dpp->state != DPP_STATE_AUTHENTICATING)
 		return;
 
-	if (dpp->role != DPP_CAPABILITY_CONFIGURATOR)
-		return;
-
 	if (!dpp->freqs)
 		return;
 
@@ -2066,6 +2064,10 @@ static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
 	dpp->current_freq = dpp->new_freq;
 
 	dpp_send_authenticate_confirm(dpp);
+
+	if (dpp->role == DPP_CAPABILITY_ENROLLEE)
+		dpp_configuration_start(dpp, from);
+
 }
 
 static void dpp_handle_presence_announcement(struct dpp_sm *dpp,
-- 
2.25.1

