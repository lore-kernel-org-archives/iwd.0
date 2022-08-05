Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165522563
	for <iwd@lists.linux.dev>; Fri,  5 Aug 2022 18:20:34 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id d20so2925428pfq.5
        for <iwd@lists.linux.dev>; Fri, 05 Aug 2022 11:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=JWJb/B4EsF03cljTvEkQi+mOQhCXXWOMELMxdZxYJhQ=;
        b=NMEqoE0LqD1HNT86AM9jpK/TS+LnKl2c2wBsplXggW/b2yRS2ShdbaQBoA2n8yrH76
         gu7i2tqG9/D7ksQ3DBK/mU0fRQiQd0v+G29B6OHhOCm9a6n8k6Vtr+3sH09YSr0fr89C
         Q3qJFTCaMxfadSoIRvcSgiNGtiVAYqdgpm8chzzO+CHFJ21DRhxK2dwkhT8+vEJqQZUW
         8/ALu3J4sVj+Tp70QET6xE8HoFNAR0yQi8RHU65Ge1miMrRvpoqzvmc6XCa4M3SSyVv/
         1MZL15/lqEUXWDSNy81TxvzFh/60X4GbvsAT77YqGFwfS3xhy3E0fygjxmurDJKKLA0t
         HKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=JWJb/B4EsF03cljTvEkQi+mOQhCXXWOMELMxdZxYJhQ=;
        b=3YYRInTPFP+D6rRv8pxBXC8lIs/0IBnJonKpsYI4+APc/0gXeU8UwECtkptfcSdohs
         tWccnJA8HTzRseFyhCTPsGNotY8ZflBc1S75jJWuUOEpDY+j2JsPYuoRM6+7VBkkDMYy
         wm/ngVXL8FFWm1NWLt+RKGeST//9Co5/W1NqGL5IhHjcl6jBpqxVOi9PLx0IeDmLuaha
         4KFGX3C2Qiv/q9hGzE51cQ3VsGbrBFVZNKhhSrtAGOVf/TsJqG47dOsO5uhndFzOlvoV
         +v7LNLP+X8az+73YlCo2vdzBzinnXzppVWcm8CJkYSs5w5eRP08DHyIQa2LQHPrhjFds
         GMBQ==
X-Gm-Message-State: ACgBeo2zuOrxb41u+Nc9wh/+j2RmvpXmIZjNR1KxK5zm7xMj0nN2FbQ7
	CK2STdKNL1mXQiLFmc5c5NIPvBpN2q4=
X-Google-Smtp-Source: AA6agR7eznI0ha2/SLcvikQfBLLUX6KGSDGTPuT5on4zH2jLXh/jZgw1G/FQ707j+JG0MpuSXoEvVg==
X-Received: by 2002:a05:6a00:1ac9:b0:52e:7093:fce6 with SMTP id f9-20020a056a001ac900b0052e7093fce6mr8008679pfv.50.1659723634248;
        Fri, 05 Aug 2022 11:20:34 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id i11-20020a17090332cb00b0016d1b708729sm3409871plr.132.2022.08.05.11.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 11:20:33 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] handshake: add support to work around buggy OWE APs
Date: Fri,  5 Aug 2022 11:20:30 -0700
Message-Id: <20220805182031.651456-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The early OWE implementation for hostapd always used SHA256 to calculate
the PTK, which violates the spec for group 20 and 21. This bug was in
there long enough for the bug to make it into products and now it must
be worked around here.

If the workaround flag is set, always use SHA256 to calculate the PTK.
---
 src/handshake.c | 3 ++-
 src/handshake.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/handshake.c b/src/handshake.c
index 734e997c..91b20bab 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -515,7 +515,8 @@ bool handshake_state_derive_ptk(struct handshake_state *s)
 	s->ptk_complete = false;
 
 	if (s->akm_suite & IE_RSN_AKM_SUITE_OWE) {
-		if (s->pmk_len == 32)
+		/* Work around buggy APs which always use SHA256 for the PTK */
+		if (s->pmk_len == 32 || s->retry_owe_workaround)
 			type = L_CHECKSUM_SHA256;
 		else if (s->pmk_len == 48)
 			type = L_CHECKSUM_SHA384;
diff --git a/src/handshake.h b/src/handshake.h
index 7f597b06..6f48fa34 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -137,6 +137,7 @@ struct handshake_state {
 	bool authenticator_ocvc : 1;
 	bool supplicant_ocvc : 1;
 	bool ext_key_id_capable : 1;
+	bool retry_owe_workaround : 1;
 	uint8_t ssid[32];
 	size_t ssid_len;
 	char *passphrase;
-- 
2.34.3

