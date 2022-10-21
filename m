Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370366127
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:13:43 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id r13-20020a056830418d00b0065601df69c0so2378671otu.7
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgJEqu9v4fqz9i9aQw9tx+M3Z7JSNc/H/29K0sl2tjg=;
        b=WRzAKDvOFNZTJYVltjGX3XFwi//boNo1ABkXU+bfUGtogzKpg/8v+gbv7Pc3bo1Bnp
         bKCYrehj8kCB2A4U7Eqn8bXDS4+ujtrOLOMG8aWtXM7WjYsCx+9Dej9NJbNr4kc+SOld
         yHqYWvglyGSEaDFxZyRfzFm0sgl8G4janZQEPvC8eFksNq/0MzJywqU8CJSvzXyehasg
         YTL23Aefbeqj+hACtqWuR8xjfP6awJjU5Ugbde80fwIdYSbAFPGLdWDZzjt26wFaWDjz
         sGT03YZjbc+LGMqbThwjlqeiAQIDSyitS1xbCWfh5Imh7eXCFtQ1MJrLeXiltkpwYGv4
         dkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgJEqu9v4fqz9i9aQw9tx+M3Z7JSNc/H/29K0sl2tjg=;
        b=gTWMf/fs9qi3A3TaajgqHX8BxQNy/ANRrdjvi0Nztk7xCCnLbgTxnFjAP6cia/WGS2
         dGn2nnY75ennhZDWNNn2FbW/Fd12QNV2V2cLUnWfotVB8TnmdZY4B+HGjeqiUiWywFAo
         tMed9DrJVU/iLNr9KXiHHaHij7Q/91skBOcNJtSGRgXQ7IzIfnK1XdNa2WNnplmgNM3g
         5aX++RoDVg7iLWi41PrK4NXU30C0IIKBWhlpg7u4B9Y5vrkontmOsZIVcBxM5XtubzTG
         zg4diC48ifZZcCkbQMnibas2A4ZmLJHprmJI9sxLvZfykeJEuBRiD7HMdvSGxB+UTOly
         nPbw==
X-Gm-Message-State: ACrzQf06iFYb4PI6nMFrrvZVG2+q8BZrmpDzXke5Kp74yShso9q6DF9x
	WSG50zc9cUOKPIBIhah6CJ5MUNvtfxc=
X-Google-Smtp-Source: AMsMyM5SmO0q8Fx03XTScqTh1H1kwZjHFZyz72e5xY5r3vq55UCAQCPAUR6NfafZZ/BDqLaQw/5t1Q==
X-Received: by 2002:a05:6830:310a:b0:661:e955:a7a1 with SMTP id b10-20020a056830310a00b00661e955a7a1mr10350554ots.57.1666379621764;
        Fri, 21 Oct 2022 12:13:41 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:13:41 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 10/26] ie: add ie_rsn_cipher_suite_to_string
Date: Fri, 21 Oct 2022 14:12:51 -0500
Message-Id: <20221021191307.31492-10-denkenz@gmail.com>
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
 src/ie.c | 24 ++++++++++++++++++++++++
 src/ie.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/src/ie.c b/src/ie.c
index 89f19b11a0fb..a424af275634 100644
--- a/src/ie.c
+++ b/src/ie.c
@@ -437,6 +437,30 @@ uint32_t ie_rsn_cipher_suite_to_cipher(enum ie_rsn_cipher_suite suite)
 	}
 }
 
+const char *ie_rsn_cipher_suite_to_string(enum ie_rsn_cipher_suite suite)
+{
+	switch (suite) {
+	case IE_RSN_CIPHER_SUITE_CCMP:
+		return "CCMP-128";
+	case IE_RSN_CIPHER_SUITE_TKIP:
+		return "TKIP";
+	case IE_RSN_CIPHER_SUITE_WEP40:
+		return "WEP-40";
+	case IE_RSN_CIPHER_SUITE_WEP104:
+		return "WEP-104";
+	case IE_RSN_CIPHER_SUITE_BIP_CMAC:
+		return "BIP-CMAC-128";
+	case IE_RSN_CIPHER_SUITE_GCMP:
+		return "GCMP-128";
+	case IE_RSN_CIPHER_SUITE_NO_GROUP_TRAFFIC:
+		return "NO-TRAFFIC";
+	case IE_RSN_CIPHER_SUITE_USE_GROUP_CIPHER:
+		break;
+	}
+
+	return NULL;
+}
+
 /* 802.11, Section 8.4.2.27.2 */
 static bool ie_parse_cipher_suite(const uint8_t *data,
 					enum ie_rsn_cipher_suite *out)
diff --git a/src/ie.h b/src/ie.h
index 2cbe35f2bdcc..1dadcb6be718 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -587,6 +587,7 @@ unsigned char *ie_tlv_builder_finalize(struct ie_tlv_builder *builder,
 					size_t *out_len);
 
 uint32_t ie_rsn_cipher_suite_to_cipher(enum ie_rsn_cipher_suite suite);
+const char *ie_rsn_cipher_suite_to_string(enum ie_rsn_cipher_suite suite);
 
 int ie_parse_rsne(struct ie_tlv_iter *iter, struct ie_rsn_info *info);
 int ie_parse_rsne_from_data(const uint8_t *data, size_t len,
-- 
2.35.1

