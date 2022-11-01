Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04FB1EA10
	for <iwd@lists.linux.dev>; Tue,  1 Nov 2022 20:17:55 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id m6so14528139pfb.0
        for <iwd@lists.linux.dev>; Tue, 01 Nov 2022 13:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SgPJKR2WAcaoWEQeb3b2tErOAn7cQvPlu0P7SL7rgc=;
        b=GTr9Mtn0ia7zj6DRLqwexLLCJCOyQDAEFxTAwVnk7svGIDmyB7kwTXbSjxITiEJGMw
         +M8jMTPuP9NcRnXxQ8RIGApYz37UeJ1Ayk9PSJXy9E4m8jtsY2pa7yDvynzn3ekqeeNK
         GJrN5E8ProiWqNkCLYC/Pclwqr3iJprne6/KeDOzAuXy8+cbWpfrcb/oLvJUJkUtNACE
         eX6o7TOTMmYleUmiv1bc7l09uDJdtPiU4tqj9Kznu6M01jiVpvFZZWEyYUXiy8z5H7a6
         mfdA/u2MtlQSpEI3Fnt015yxyCBj+Yk3MyUzKJDNDKb71Y9jWS+Udl7k3BxHWM2esH44
         mmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SgPJKR2WAcaoWEQeb3b2tErOAn7cQvPlu0P7SL7rgc=;
        b=S+9XtRxXkkH3qdO34ZHKEASp3O/RKQjsgLF4mnL67VVcNEzAw/bgjVV/k/9bGSiQtZ
         JVUFfsuSqxidfiq3BZhzhd/Nr+LLWlo/xm9vUl/vCMI77eVb7QYDb6WT3+xFztRAw8yJ
         ws5Ui8J3fopEOTc4YrBMnv15D9Aftfoql5l8OxCjTUHpLxgDMQMLTYd2K+YHqDEPwn9G
         7BUMTnr9zx/M25py5cUwz6L99uNQWRkn23k+SIip6hwixHFIwn6ubMfYTQaTpqs5y/LR
         65k2H3XNLod8Mo3iM/1YFgO/Gqkb5iUDzZqmBMSoZ3rJBN9+Gmf4FCQSP9e/dpSPc6ix
         bN7A==
X-Gm-Message-State: ACrzQf0hBdaOSfR+FfdVZnN5iuxoQSSWBp0xZzCgy8H7qGTYiAHIAKVE
	190BxQieCOC/uhTOORWfi2FhSPT0Xg4=
X-Google-Smtp-Source: AMsMyM68S0EVZaifQJO3EJ3wmFHH4uDjTJ1nkd0ppXmwHs2qKB/x4SmAgeRdR22aXwsXgvSYD06K2Q==
X-Received: by 2002:a63:f20a:0:b0:464:8c6:f27e with SMTP id v10-20020a63f20a000000b0046408c6f27emr18553087pgh.411.1667333875115;
        Tue, 01 Nov 2022 13:17:55 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00180a7ff78ccsm6781681plg.126.2022.11.01.13.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:17:54 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 02/17] ie: add group/pairwise lists of supported ciphers
Date: Tue,  1 Nov 2022 13:17:32 -0700
Message-Id: <20221101201747.143379-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221101201747.143379-1-prestwoj@gmail.com>
References: <20221101201747.143379-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The validation of these ciphers for station is done when parsing
the BSS RSNE but for AP mode there is no such validation and
potentially any supported cipher could be chosen, even if its
incompatible for the type of key.
---
 src/ie.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/src/ie.h b/src/ie.h
index 53311854..c9a6c783 100644
--- a/src/ie.h
+++ b/src/ie.h
@@ -401,6 +401,25 @@ static inline bool IE_CIPHER_IS_GCMP_CCMP(uint32_t cipher_suite)
 				IE_RSN_CIPHER_SUITE_GCMP_256);
 }
 
+#define IE_GROUP_CIPHERS		\
+(					\
+	IE_RSN_CIPHER_SUITE_TKIP |	\
+	IE_RSN_CIPHER_SUITE_CCMP |	\
+	IE_RSN_CIPHER_SUITE_GCMP |	\
+	IE_RSN_CIPHER_SUITE_GCMP_256 |	\
+	IE_RSN_CIPHER_SUITE_CCMP_256	\
+)
+
+/*
+ * Since WEP is unsupported we can just use the group cipher list with
+ * "Use group cipher" appended
+ */
+#define IE_PAIRWISE_CIPHERS			\
+(						\
+	IE_GROUP_CIPHERS |			\
+	IE_RSN_CIPHER_SUITE_USE_GROUP_CIPHER	\
+)
+
 #define IE_LEN(ie) \
 	((ie) ? (ie)[1] + 2 : 0)
 
-- 
2.34.3

