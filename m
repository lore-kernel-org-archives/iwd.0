Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24FBAD5A
	for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 21:53:54 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id io19so10587532plb.8
        for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 14:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1ztNbFNoHMpjhFpvF35LTZwx9NeuXQZR5skI48ZpWI=;
        b=BH7R10lclOQPE+aKepwKZVyeWRENvyuqG7dvlXNcFI14kowjat4NJD/h0oan32HqNh
         3Eq1V1cSaz5+rPLCa5sv9tWxzIYMNO9P2AZD5eTigGzOyNGwHG/F2g6WmxVO9noISvzT
         Nv8T40BkvxithMwUrrpOGKH5GF5Tq5+PH2VbeF2ftyd/rxqiMErf+pIZzVJQNUUn1Ot7
         62WPAiWYJ5x28V3GiFf2kcoDG5X2oi5ZCFLVlcL5L8294h90OCCcgKB1c+Hipqq7IPhZ
         DDqhbRfOb4yQEj33KIQVyprY14VpkIEvWd28DUGmxNOy1tsOiHNis10SaW3csfMT9p20
         nAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1ztNbFNoHMpjhFpvF35LTZwx9NeuXQZR5skI48ZpWI=;
        b=bbfY3VVgKDoChOykxkLcmLGtOHSVeLcObOBkDFYJGZaF4Z/q0VJ7rAYbyorWkKszuM
         X2+r62G71QZZLqp/EZ21ZDUzgo9EFViDDXFU8FDHhrApLAgh/QSKvocsX0x7GgCwXVOM
         ucTDq+WI5owMJC9r7hjajp0cGlDFQC22Ofc+2HhizqOjcVkhVrbChvDFpZqWph6XX8x1
         +UguuZHd2TS1vZlSN/NIGlOJNMo5pSkNYSFZqWO/5/Vn5rSWzn9BxovX4/dMAGQ4ixEy
         H2ud5H3FqAKJFVQ+AlmByvj4onh5mVfL95gsTUHMZj9lBnlgTdGbrz1hrXm8wYIUW9eB
         OqBw==
X-Gm-Message-State: ACrzQf3kYG9FAmVfQ0iVYDsw4zWLKsNPipRZOo4ag1t7V3TFEg8V8MEf
	5bHoPCkp6fK2DwTgfKlBexkHE6ykPVI=
X-Google-Smtp-Source: AMsMyM7ma11R3J+ez3b1ZmgU+oIZ85XyRJRUVhlEepgUaEUxZ99Dah+1GdHOOOip4saq3Tf2M8Pz6w==
X-Received: by 2002:a17:90b:954:b0:213:c01:b8ce with SMTP id dw20-20020a17090b095400b002130c01b8cemr6592639pjb.168.1666821234194;
        Wed, 26 Oct 2022 14:53:54 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id d20-20020a170902b71400b0017b264a2d4asm3372471pls.44.2022.10.26.14.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 14:53:53 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] hwsim: add additional ciphers to disable list
Date: Wed, 26 Oct 2022 14:53:49 -0700
Message-Id: <20221026215350.506918-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows these ciphers to be disabled when creating radios.
---
 tools/hwsim.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index 75f074ab..0ace4c0e 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -196,7 +196,13 @@ static const struct hwsim_support cipher_map[] = {
 	{ "wep104", CRYPTO_CIPHER_WEP104 },
 	{ "tkip", CRYPTO_CIPHER_TKIP },
 	{ "ccmp", CRYPTO_CIPHER_CCMP },
-	{ "bip", CRYPTO_CIPHER_BIP_CMAC },
+	{ "bip_cmac", CRYPTO_CIPHER_BIP_CMAC },
+	{ "gcmp", CRYPTO_CIPHER_GCMP },
+	{ "gcmp_256", CRYPTO_CIPHER_GCMP_256 },
+	{ "ccmp_256", CRYPTO_CIPHER_CCMP_256 },
+	{ "bip_gmac", CRYPTO_CIPHER_BIP_GMAC },
+	{ "bip_gmac_256", CRYPTO_CIPHER_BIP_GMAC_256 },
+	{ "bip_cmac_256", CRYPTO_CIPHER_BIP_CMAC_256 },
 	{ }
 };
 
-- 
2.34.3

