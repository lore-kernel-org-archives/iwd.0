Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D658B3CD1B
	for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 20:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpdiWzTF"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7789577b53fso96163285a.3
        for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 13:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698352044; x=1698956844; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EHcA8egXzvk8ZgJPeKkf/wFDqE3BxfTJtKxSVXfzvY=;
        b=GpdiWzTFQLcdlbyBb9EqU/OdqWgO1tGN0ww1qQgRwcRfZhGNAvJ5mwsTU7Vfaun6i1
         K9eKcJ9Rt1GZLRr2CTr+unoKCPEVsZQkmSWI4ePB/SACCWuLtTW0rwlBL2c6jV/dGdkL
         HHulYAQEP4RoagZHoeRjk0xAVBVgPeT80UKlQmBoKx2sqt2oIL1dQOG1VYqEJANqWkBp
         Xi5GxGs/DtaMX0nJsQg1Co5cdnGpqyb7Lq6yZ1vOmZSo00mFNYzW8f8x/P0zFk6eqOIn
         dxGAmubd18BunMXbMFYQmHjO6vWSX3Ba2j2rl1p+iUoj+7P18fx9mRNpU5o5V+52xXCo
         X7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698352044; x=1698956844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EHcA8egXzvk8ZgJPeKkf/wFDqE3BxfTJtKxSVXfzvY=;
        b=LWDruCYo1HZXDLy4h7qZ13jYxVcBRTrbMTxuyYeMPEkP0I1sjPYubYN1fMrvKv2KcV
         VPmAOHHoSod22mbxo5m04O4oKfbx8lWeJSGOrk467JIrpA1ARvVGI79Wx3/F/WwEZoS5
         45/qKTRvkHfMRBR06dozNpfC9fpfXYnrIbouFTkmXGUYuIc2Qy2kp2hJgAXYXrR9/F1s
         SFvtW5OuJgyO/ZrCYfdIgzCA7AANdrsbCG8M1mSRp0S8KiMTN9qpX20OjDGSA2EFtlae
         LY8gcYpd0toQn92JCW62GtSLLVE6plF4Xpd+O/dOiupnrmJz4fT5Wj1LOv3tVK9En4m1
         2Ptw==
X-Gm-Message-State: AOJu0YwjHTaO53XsRMw/WDgLocGSO5ZX7MSoJyAGYOnucgOKmqwTR733
	V1VK/qIAGbwsbOg5XJqciHBxlnUVAzc=
X-Google-Smtp-Source: AGHT+IFGzJBu3B+uH7BTocRonlJNlD9stTF7uC8FHrIQKPHIpiiu4aO4HfZj5bPj7sipVD6pWiBeHg==
X-Received: by 2002:a05:620a:40c2:b0:775:c5bb:1df9 with SMTP id g2-20020a05620a40c200b00775c5bb1df9mr499964qko.60.1698352044550;
        Thu, 26 Oct 2023 13:27:24 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id r4-20020a05620a298400b007742c2ad7dfsm7303qkp.73.2023.10.26.13.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 13:27:24 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 11/15] dpp: allow enrollee to be authentication initiator
Date: Thu, 26 Oct 2023 13:26:53 -0700
Message-Id: <20231026202657.183591-12-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026202657.183591-1-prestwoj@gmail.com>
References: <20231026202657.183591-1-prestwoj@gmail.com>
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
index 77af5669..80167cac 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -1436,7 +1436,7 @@ static bool dpp_send_authenticate_request(struct dpp_sm *dpp)
 	struct scan_bss *bss = station_get_connected_bss(station);
 
 	/* Got disconnected by the time the peer was discovered */
-	if (!bss) {
+	if (dpp->role == DPP_CAPABILITY_CONFIGURATOR && !bss) {
 		dpp_reset(dpp);
 		return false;
 	}
@@ -1457,7 +1457,8 @@ static bool dpp_send_authenticate_request(struct dpp_sm *dpp)
 				i_proto_key, dpp->key_len * 2);
 	ptr += dpp_append_attr(ptr, DPP_ATTR_PROTOCOL_VERSION, &version, 1);
 
-	if (dpp->current_freq != bss->frequency) {
+	if (dpp->role == DPP_CAPABILITY_CONFIGURATOR &&
+					dpp->current_freq != bss->frequency) {
 		uint8_t pair[2] = { 81,
 				band_freq_to_channel(bss->frequency, NULL) };
 
@@ -1895,9 +1896,6 @@ static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
 	if (dpp->state != DPP_STATE_AUTHENTICATING)
 		return;
 
-	if (dpp->role != DPP_CAPABILITY_CONFIGURATOR)
-		return;
-
 	if (!dpp->freqs)
 		return;
 
@@ -2051,6 +2049,10 @@ static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
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

