Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664527702
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 20:53:38 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so3001451pjl.3
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 13:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SgPJKR2WAcaoWEQeb3b2tErOAn7cQvPlu0P7SL7rgc=;
        b=HzVXMLhMBqgP4hhB6WZLhxtVk9jv0wvjnkEB6pDoNhW/FxhJa0nuEA2U7ssF+yZ2wI
         xgERgxcm0Mii5jY0MPqMQ01U9gZOSvBnrcffigefQfzVPzXbrOTeG4/OVjHo+tgl5myz
         e/dPYMrB3J7HwNtZb0EXwqlCoNRv0tMVf0xKgXF8GOW2CKiwGwAo3lm5Ow4zeMAMJ5YX
         HtH4yIuSdZr9Y8tWR3l2ey39/uOGg3sE9TgVaUU5FOllk0AsPFE4JFBt9IcAaJQnNJDd
         bcG1elMTmFtbeTrkTyIIo1eSi/ncw6ankM+MGS+iUWn1ybUVaLP5VNvYiLB+zNusJjxG
         O15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+SgPJKR2WAcaoWEQeb3b2tErOAn7cQvPlu0P7SL7rgc=;
        b=o4w456h30fY3iVKmYqEh8yMrk8xL5IrD5oJomAlWhNZ2ZR9RqrVSreo6FzWNwWfFs1
         IJeWSN3i6QrlsAjloXj9enZvBNXGZoaMi8opOB3TRiCXE2zG4cTmORkIB/FHggMklsTV
         2Qw4BBHfw+C0CcK/gaG/CIHblDWvuBGieg3JCtUVuBq0jj6j8NTabHwK9CGpPdv+p1Il
         2JPsownTlPnhgprnb+ynEyNUFCAs/ysxRCnaWZUcFOKF+QLbXUtdmrU1FQrnp85kshXs
         Uc2Z57bjPxVJ/Dfd3gBqLUwhcImO4ad9bTwdvny2otlu0F33vYJtr2YoW3j7YXgoNPjc
         Xx2g==
X-Gm-Message-State: ACrzQf1uGh6hict41MajlquOrkPP8tKgUPU7mt5KQGONWss4T+IOoDxU
	1E3U/epCicA6jkENLFGfVL4e2T8mwXY=
X-Google-Smtp-Source: AMsMyM5Uh3onUc0FVJJK6AM5cxKSw7wpfTF6LRg5BBKjBnBkErWT5hYwHZ4dPHdwUIToQt/r5I6j8g==
X-Received: by 2002:a17:902:e791:b0:186:eea2:49e2 with SMTP id cp17-20020a170902e79100b00186eea249e2mr26175210plb.10.1667422417655;
        Wed, 02 Nov 2022 13:53:37 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b00186c6d2e7e3sm8730755plb.26.2022.11.02.13.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:53:37 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 02/10] ie: add group/pairwise lists of supported ciphers
Date: Wed,  2 Nov 2022 13:53:19 -0700
Message-Id: <20221102205327.268693-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221102205327.268693-1-prestwoj@gmail.com>
References: <20221102205327.268693-1-prestwoj@gmail.com>
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

