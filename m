Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A294D612D
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:14:06 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-13b23e29e36so4011293fac.8
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WO6O2qBsqi+7phB5hT93+ISZeY3elaHD4eYUVyWGL/k=;
        b=c6xx9KK2aR/7fpUroBd+wq1JFxK4B0J9wyD3W4Fh1YdVip2UJCD6yim7MLbZh8wC3c
         8Dl9vgO7nmt8rKewy/snbRLOfXZKqkx4juj1xmC/Ry1ZtcgaQXMhSLmFcbiivWrCTT9G
         7QCTyIKQe4Ffex8/uKkAa4nJQyy5ts8Z5v5j5VtT+NCgRstVKxJCsjS2JhZWQ4carbti
         w9XQoXc92JfS6iQr3VFd38Fb68i1hbtc0hdBZZIQ3Mfmk50hoeEuxr3GwWzMYM953mby
         6ztmzrQoAnxPfq3S5PIF8wV/kpp/ppBpWSPhc6xBl2M67ujYD5zdnwSOW7sCX2QVrNrE
         bFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WO6O2qBsqi+7phB5hT93+ISZeY3elaHD4eYUVyWGL/k=;
        b=oLk4sAyjtpC+KPIbzSWOIZrs5Cgszq5WgeeJ8ci1gPYmJLaeZL2iUIdeTBv4gdAr0n
         PYxV0lqr7N029HVnR3XhnhFg2GjfOgpIxhL6y4GAtKgC8gU5pjKbTddO9s0az6AosKX4
         Co6OuxlsXQWnIH2Zk70bYhJfBNATQwVuV2N67PcGDHMoMvbHHxmJQo1iPsDQQpVyYLgB
         fqnH9ym+i4boqVs2snRBdx5+JIOZm689X9nPi2QcynhbRc7miWsU5RQj623MYLWetBmN
         T5+BLnCxgr3nI4sSh/ffhMNe1oEAk+n0QfKZY0V46uLb4pTdXyYXFNpsc3u04yJcf4pW
         6vQw==
X-Gm-Message-State: ACrzQf1CB5d5mZl754+L7REDMVwh1a9zXWreIqA2X4dYjmdfyxrsoLwO
	Gtvcr4Qi7t0Qr1zvgLPRy/bbBVJ58Z4=
X-Google-Smtp-Source: AMsMyM5f4CIbWZN5AFBPUNYlCokvbn/bnDlHOH4KFIHUg8Bhu6iJLK6SE/4StTB5P/vQcXqURf2AhQ==
X-Received: by 2002:a05:6870:58a:b0:136:3535:c7a8 with SMTP id m10-20020a056870058a00b001363535c7a8mr13260023oap.156.1666379645187;
        Fri, 21 Oct 2022 12:14:05 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:14:04 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 24/26] netdev: Support more IGTK cipher suites
Date: Fri, 21 Oct 2022 14:13:05 -0500
Message-Id: <20221021191307.31492-24-denkenz@gmail.com>
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
 src/netdev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 7b8948604347..636c02dea51a 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1674,7 +1674,7 @@ static void netdev_set_igtk(struct handshake_state *hs, uint16_t key_index,
 {
 	struct netdev_handshake_state *nhs =
 		l_container_of(hs, struct netdev_handshake_state, super);
-	uint8_t igtk_buf[16];
+	uint8_t igtk_buf[32];
 	struct netdev *netdev = nhs->netdev;
 	struct l_genl_msg *msg;
 
@@ -1690,7 +1690,10 @@ static void netdev_set_igtk(struct handshake_state *hs, uint16_t key_index,
 
 	switch (cipher) {
 	case CRYPTO_CIPHER_BIP_CMAC:
-		memcpy(igtk_buf, igtk, 16);
+	case CRYPTO_CIPHER_BIP_GMAC:
+	case CRYPTO_CIPHER_BIP_GMAC_256:
+	case CRYPTO_CIPHER_BIP_CMAC_256:
+		memcpy(igtk_buf, igtk, igtk_len);
 		break;
 	default:
 		l_error("Unexpected cipher: %x", cipher);
-- 
2.35.1

