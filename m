Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9BB4A1C
	for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 16:37:13 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id b7-20020a17090a12c700b001f20eb82a08so8627188pjg.3
        for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yj+1eaEHRmtoibFMSIJoeabrx2THZ9kZemIQ0R1cgDk=;
        b=E9V34BJsFbaYFrvXx+H1+9liNiEbPWnLdh4445dprelsBas4UgLYOO5fqgWA6hZowL
         3gBG0KMxW4lS2sK6F8gBkbU3NznCHreu/FXJyZLppyJMJESGXTX+QswUVA2QRBsoGRwt
         ezqlVqhdnW6iYploVi1mDZzbZnVPVgNrjQ7IY7nBDI2SZlULMxezz1Cklp1rsMbCU8l/
         tZuVlPj/DofFIKh4NquDhW+hkNPN3DMXngTjoaTy/CMtgtCpxXqpRCdVW2LGhs6ShSQV
         x+imFrU5MQLgiRc9YArdxcYCenjgG5QqWyRWKH98W8gQXdQqyMJll9jzsTSOHEFcHgO1
         JM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yj+1eaEHRmtoibFMSIJoeabrx2THZ9kZemIQ0R1cgDk=;
        b=AWM6AR0O6VJysJfPqak/89TMEcnbRj8QCejgweVBZvm1FhxqDD3U3stlc7PlWtWDIW
         Sl1lgrn9NjQU0tijLisja9c5etamaRmeyYRvy+uWLvJYUzM6Ea1SntvZSbJikwFoLCAR
         k1QiLg+nx0wIyGPraZWUgN5InQDyEGq/422BXvMK5I27CQc+J/+QYtWQVruYTtrz+Bdm
         3adBf8k1sP9YOXsdmh04qn2nPqMaLCmOaWSz9BHUOWGuS0wxRhCH0QJp1Z/N3wO1mwAC
         n3++nokmtn0p1XI9zJqgJRlkj3yig4xwuOWJNiIMweQIp/up70e6PhQ4f/Q762wm2cLz
         gRcA==
X-Gm-Message-State: AJIora8O8SpIgSoEOW4d8pJQ5VSuzWI/9xSGbBAqJ+3T11wrlKW2l80K
	tKPk1KfayKJjEDqLIf8x5ujbmPjAqvc=
X-Google-Smtp-Source: AGRyM1towwAUHbVvWdwsfyfRvKH1nUJfnq6WK29oqHgM7LqV7WAeQ1rK43ZfpZqqdZN4YYd9vmUgBw==
X-Received: by 2002:a17:902:bcc3:b0:16d:b62:bc6f with SMTP id o3-20020a170902bcc300b0016d0b62bc6fmr678681pls.25.1658507832612;
        Fri, 22 Jul 2022 09:37:12 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902e75200b0016a109c7606sm4013887plf.259.2022.07.22.09.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 09:37:12 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/7] util: add scan_freq_set_remove
Date: Fri, 22 Jul 2022 09:34:13 -0700
Message-Id: <20220722163417.1119334-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220722163417.1119334-1-prestwoj@gmail.com>
References: <20220722163417.1119334-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/util.c | 22 ++++++++++++++++++++++
 src/util.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/src/util.c b/src/util.c
index 2832486d..8fdb7f17 100644
--- a/src/util.c
+++ b/src/util.c
@@ -357,6 +357,28 @@ bool scan_freq_set_add(struct scan_freq_set *freqs, uint32_t freq)
 	return false;
 }
 
+bool scan_freq_set_remove(struct scan_freq_set *freqs, uint32_t freq)
+{
+	enum band_freq band;
+	uint8_t channel;
+
+	channel = band_freq_to_channel(freq, &band);
+	if (!channel)
+		return false;
+
+	switch (band) {
+	case BAND_FREQ_2_4_GHZ:
+		freqs->channels_2ghz &= ~(1 << (channel - 1));
+		return true;
+	case BAND_FREQ_5_GHZ:
+		return l_uintset_take(freqs->channels_5ghz, channel);
+	case BAND_FREQ_6_GHZ:
+		return l_uintset_take(freqs->channels_6ghz, channel);
+	}
+
+	return false;
+}
+
 bool scan_freq_set_contains(const struct scan_freq_set *freqs, uint32_t freq)
 {
 	enum band_freq band;
diff --git a/src/util.h b/src/util.h
index 75c29039..ff5211ed 100644
--- a/src/util.h
+++ b/src/util.h
@@ -110,6 +110,7 @@ typedef void (*scan_freq_set_func_t)(uint32_t freq, void *userdata);
 struct scan_freq_set *scan_freq_set_new(void);
 void scan_freq_set_free(struct scan_freq_set *freqs);
 bool scan_freq_set_add(struct scan_freq_set *freqs, uint32_t freq);
+bool scan_freq_set_remove(struct scan_freq_set *freqs, uint32_t freq);
 bool scan_freq_set_contains(const struct scan_freq_set *freqs, uint32_t freq);
 uint32_t scan_freq_set_get_bands(struct scan_freq_set *freqs);
 void scan_freq_set_foreach(const struct scan_freq_set *freqs,
-- 
2.34.1

