Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594506121
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:13:30 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id v40-20020a056830092800b00661e37421c2so2392332ott.3
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVC9tBnMvCp9s2xsTDifP6G9EbnosN/shOAAZgv8hdo=;
        b=DZFssaV+jOso+WdwmgTefWVNuyCs7IX+VzSxiy3YQtbLCZhe1yo7XjWHLUHlXJn1il
         QT/p75fh2u9JDMD4DFox39GQmxAMmeLXEdcJCDrtkFHajPLHFPLjRgpOjv8Y1s4XnFMD
         sHlX6HQZc9JhpwGJWCMUpEfO8MCD/uORuWXhbO0mamGycNZDXxT0V72iNonxYgvebnG8
         k2yQZfzVUVrnsGnp/7XZAr41EvKLWkGpqxXx9xGodg5qSY1wDESslMeHuOvLBrsyWe7g
         aOwxYOzRucbSjTJAILSNNLyBzcfvhmThFQip8tdCbL4+BvgFCB3DSw/TdHPwWyd0rUmh
         F5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVC9tBnMvCp9s2xsTDifP6G9EbnosN/shOAAZgv8hdo=;
        b=AAQbKMC7VgK93cMQkTRdVzFVzAd3S/s6bBi3MzO7gi9eqC2+U0l++QGTqULIcm48n/
         AF4ww0fms5dYrd0lgPbftNVUbziEqrMqHzYIyjNXX3TDXjmg2pIA9x/oQegwM4IEIQNP
         5XLqoPL+jzpZLtgWG3FAnW2EKT+0AfI5N3Eb9iV8Glvir1V0d89gkBZRCWU8b74DibLy
         +r6Ul9y0g7QLeZX/Uc1FD/Z02pA6mGAp9uuVM/CA9pzArcXHcQyDP81HnAGLPsb24LRW
         zHm6daOYkaIlo9SavIlInFvKfm9jqN6CnW1OUz4I6n9/0xvDCSk7qmOsntwPak2ElYEx
         E4Pw==
X-Gm-Message-State: ACrzQf0nk8k1FpKDUxFIPzmS+fOry7saJi9RuqQ3wbb7FWZzzyY6tf5x
	vEfaaH6egH1qzbZR17U8Rt2hTDlQBJs=
X-Google-Smtp-Source: AMsMyM6lVpMHGDldptWhb63Bu6b/Va2YnVvN/b9qroIIOVXtZRaq1c3L0rgIS50OHa1skG2MysgtVg==
X-Received: by 2002:a05:6830:43aa:b0:661:ae26:53eb with SMTP id s42-20020a05683043aa00b00661ae2653ebmr10661177otv.221.1666379608801;
        Fri, 21 Oct 2022 12:13:28 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:13:28 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 02/26] crypto: Rename BIP to BIP_CMAC
Date: Fri, 21 Oct 2022 14:12:43 -0500
Message-Id: <20221021191307.31492-2-denkenz@gmail.com>
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

To match the spec more closely.  Several additional BIP algorithms are
being introduced, including BIP_GMAC_128|256 and BIP_CMAC_256.
---
 src/crypto.c  | 2 +-
 src/crypto.h  | 2 +-
 src/ie.c      | 2 +-
 src/netdev.c  | 2 +-
 src/wiphy.c   | 2 +-
 tools/hwsim.c | 4 ++--
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/crypto.c b/src/crypto.c
index 19d55e70f5d0..89e315df6a36 100644
--- a/src/crypto.c
+++ b/src/crypto.c
@@ -501,7 +501,7 @@ int crypto_cipher_key_len(enum crypto_cipher cipher)
 		return 32;
 	case CRYPTO_CIPHER_CCMP:
 		return 16;
-	case CRYPTO_CIPHER_BIP:
+	case CRYPTO_CIPHER_BIP_CMAC:
 		return 16;
 	}
 
diff --git a/src/crypto.h b/src/crypto.h
index b6fa2ec3eccf..b2cd8839aa77 100644
--- a/src/crypto.h
+++ b/src/crypto.h
@@ -30,7 +30,7 @@ enum crypto_cipher {
 	CRYPTO_CIPHER_WEP104 = 0x000fac05,
 	CRYPTO_CIPHER_TKIP = 0x000fac02,
 	CRYPTO_CIPHER_CCMP = 0x000fac04,
-	CRYPTO_CIPHER_BIP = 0x000fac06,
+	CRYPTO_CIPHER_BIP_CMAC = 0x000fac06,
 };
 
 enum crypto_akm {
diff --git a/src/ie.c b/src/ie.c
index 070454ef4f8f..245b59c91ad3 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -429,7 +429,7 @@ uint32_t ie_rsn_cipher_suite_to_cipher(enum ie_rsn_cipher_suite suite)
 	case IE_RSN_CIPHER_SUITE_WEP104:
 		return CRYPTO_CIPHER_WEP104;
 	case IE_RSN_CIPHER_SUITE_BIP:
-		return CRYPTO_CIPHER_BIP;
+		return CRYPTO_CIPHER_BIP_CMAC;
 	default:
 		return 0;
 	}
diff --git a/src/netdev.c b/src/netdev.c
index 206907b896f8..cd8e70863d3a 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1684,7 +1684,7 @@ static void netdev_set_igtk(struct handshake_state *hs, uint16_t key_index,
 	}
 
 	switch (cipher) {
-	case CRYPTO_CIPHER_BIP:
+	case CRYPTO_CIPHER_BIP_CMAC:
 		memcpy(igtk_buf, igtk, 16);
 		break;
 	default:
diff --git a/src/wiphy.c b/src/wiphy.c
index 6fdd3df526cd..1283bede923e 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -1215,7 +1215,7 @@ static void parse_supported_ciphers(struct wiphy *wiphy, const void *data,
 		case CRYPTO_CIPHER_WEP104:
 			wiphy->supported_ciphers |= IE_RSN_CIPHER_SUITE_WEP104;
 			break;
-		case CRYPTO_CIPHER_BIP:
+		case CRYPTO_CIPHER_BIP_CMAC:
 			wiphy->supported_ciphers |= IE_RSN_CIPHER_SUITE_BIP;
 			break;
 		default:	/* TODO: Support other ciphers */
diff --git a/tools/hwsim.c b/tools/hwsim.c
index e55019045967..75f074abf0b0 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -175,7 +175,7 @@ static const uint32_t hwsim_supported_ciphers[] = {
 	CRYPTO_CIPHER_WEP104,
 	CRYPTO_CIPHER_TKIP,
 	CRYPTO_CIPHER_CCMP,
-	CRYPTO_CIPHER_BIP,
+	CRYPTO_CIPHER_BIP_CMAC,
 };
 static uint32_t hwsim_ciphers[L_ARRAY_SIZE(hwsim_supported_ciphers)];
 static int hwsim_num_ciphers = 0;
@@ -196,7 +196,7 @@ static const struct hwsim_support cipher_map[] = {
 	{ "wep104", CRYPTO_CIPHER_WEP104 },
 	{ "tkip", CRYPTO_CIPHER_TKIP },
 	{ "ccmp", CRYPTO_CIPHER_CCMP },
-	{ "bip", CRYPTO_CIPHER_BIP },
+	{ "bip", CRYPTO_CIPHER_BIP_CMAC },
 	{ }
 };
 
-- 
2.35.1

