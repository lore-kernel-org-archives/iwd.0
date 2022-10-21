Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58673D60
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:13:34 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-12c8312131fso4748148fac.4
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdhOA1IZN3STU6OVhP5pOMCm8qIM//dPS4X9+VoHzGA=;
        b=ntjGofR4OoyVw4A4RNiWkDuuy09He8t+3103hOuooeNsOqozp6y+94LhCKurglVFkj
         jrjREQlTTtnG31ijot5Il5mTBSfPlKUQYWiA+yVyCj53+yM0s3zcovkXjMEBzSasf35x
         82oreCrXIU48EISgWMVbrZLtOvzeXOChgJfF5lKb7gjqELAzabJs7zps+Xn60ApDi0aK
         zV8tiuzM9hKoZu3rEvoSJj2YGH0mdly9praeHNy6913O30FcfTlJIYN/d9/Q3iPQ7mIt
         y4ggIjs95a/jBKU9raBbn/C36Il2xOZyCKNykGFSjkXqDQSo3frM+UkGZmbrTngICzXX
         0DKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vdhOA1IZN3STU6OVhP5pOMCm8qIM//dPS4X9+VoHzGA=;
        b=4INp8sQpp97fMC9nNllwaR1R5UK0fkCrBTh9/E2z9X+gikLHDj6XFMuXrvlW3RHN5r
         7SJwdfOWjT7P7qtzet+AtcStcmp3rI0MESX/9gfvNn6pJeQlqr7UtcS7Smwz3mUcovi+
         aq7BBZ7kffTdtjXAVxuJpQNjXw0biZbvJfK3tiH2yDTCNKSkibdOxWR4tduTKbKyGXLu
         B254YRt0jjvrIkT+D/QXRaLKmGfXRtD481zQCJdYgpFUYPyzNgBIjzrWfNyDLX4DdGT/
         +AvMqiGHWgyxppshsPpC2Mx1x6oYV3escDPnflu3FBv0Hh9VKt5FEUwZVXogrtoLE3yg
         0m8Q==
X-Gm-Message-State: ACrzQf1tt9V7pDwnzpovplK1LW6yo7nwPnLXoYTEUeZHKAnUmNV6IrM8
	5cCQ9+pFvSRkTAlGLBPKHgi7/ANolNo=
X-Google-Smtp-Source: AMsMyM4wfCMjnm/6nhXLZEB1HngSRuOhH617W7lqAJei6QvaZNur1EPlxmCxpuYiEAyb5Y7Nsid3JA==
X-Received: by 2002:a05:6870:609c:b0:131:c972:818f with SMTP id t28-20020a056870609c00b00131c972818fmr13106072oae.2.1666379613490;
        Fri, 21 Oct 2022 12:13:33 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:13:32 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 05/26] crypto: Add new cipher definitions
Date: Fri, 21 Oct 2022 14:12:46 -0500
Message-Id: <20221021191307.31492-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021191307.31492-1-denkenz@gmail.com>
References: <20221021191307.31492-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/crypto.c | 8 ++++++++
 src/crypto.h | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/src/crypto.c b/src/crypto.c
index 89e315df6a36..840d9ee4dd5b 100644
--- a/src/crypto.c
+++ b/src/crypto.c
@@ -500,9 +500,17 @@ int crypto_cipher_key_len(enum crypto_cipher cipher)
 	case CRYPTO_CIPHER_TKIP:
 		return 32;
 	case CRYPTO_CIPHER_CCMP:
+	case CRYPTO_CIPHER_GCMP:
 		return 16;
+	case CRYPTO_CIPHER_CCMP_256:
+	case CRYPTO_CIPHER_GCMP_256:
+		return 32;
 	case CRYPTO_CIPHER_BIP_CMAC:
+	case CRYPTO_CIPHER_BIP_GMAC:
 		return 16;
+	case CRYPTO_CIPHER_BIP_CMAC_256:
+	case CRYPTO_CIPHER_BIP_GMAC_256:
+		return 32;
 	}
 
 	return 0;
diff --git a/src/crypto.h b/src/crypto.h
index b2cd8839aa77..ed430abb00d8 100644
--- a/src/crypto.h
+++ b/src/crypto.h
@@ -31,6 +31,12 @@ enum crypto_cipher {
 	CRYPTO_CIPHER_TKIP = 0x000fac02,
 	CRYPTO_CIPHER_CCMP = 0x000fac04,
 	CRYPTO_CIPHER_BIP_CMAC = 0x000fac06,
+	CRYPTO_CIPHER_GCMP = 0x000fac08,
+	CRYPTO_CIPHER_GCMP_256 = 0x000fac09,
+	CRYPTO_CIPHER_CCMP_256 = 0x000fac0a,
+	CRYPTO_CIPHER_BIP_GMAC = 0x000fac0b,
+	CRYPTO_CIPHER_BIP_GMAC_256 = 0x000fac0c,
+	CRYPTO_CIPHER_BIP_CMAC_256 = 0x000fac0d,
 };
 
 enum crypto_akm {
-- 
2.35.1

