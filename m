Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA9C79EB
	for <iwd@lists.linux.dev>; Tue, 13 Dec 2022 20:36:31 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id s7so1086620plk.5
        for <iwd@lists.linux.dev>; Tue, 13 Dec 2022 12:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IheFy7kkqr82G29RncS4ibHyCnlRV3IDMlH09rsqM0g=;
        b=AzXYj6ugyzET8ayneTrA4uT8TCaE6Lw84A4D6PX+m/pbQyXRBI6m/C7pVQZ9yCe363
         KmpsUfO8bvGMmnTBkticGXBRTetjVl4QNF9FyAPR6mHCDPSQOOkwJB5FHm3ZuW/zj8Ju
         /N0vgVfsziw22ziTYy3XgBGYNXPWCd8/KV8VDyqMDuPZmzA0Teco+jMpIlB0/EPxqw3e
         F/H6sixL7BGMN0rk0bOCOnIOD0I6iL2qFnL+6vaqBAAxQ9pjE/cpK3FdzlEqtBE5h573
         C6SVENXL2KFeu4zVXzvlcdf/vUw3tRwlb6jkCeWZS1tnNk7vkYRjLTP0M5q1E7bRTbQc
         3Cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IheFy7kkqr82G29RncS4ibHyCnlRV3IDMlH09rsqM0g=;
        b=3zNT+3p8M2qGgBDic0JEUcNiXr+mfiMNaDb5fyE6Zv4hx96M1mcKylaotxOE50nsuE
         1Zg8Ujw/jU+dPSfwSt0/pBcqPi55z65+CGfi8/uakv9amlmmeNWJg6B06/A13NYY6JVC
         xU4Ih6kog3dLhAeVFQHqlry7Isw1nYiOH4Xc3XF4zIB3+MauL2CaaF+NzMtQjO2/kli0
         dPmdGR5+8xeb8aTz08Q9rB37hTjECAWO/1B9Hx4M2QvN2nISpmx6Atxm/jnUTajmv64g
         2iQtSFOip123KajibJXspfjWQus59MeiMF9Y270DnGvkLas8OzBgcdK4b7hdCYAiSFFY
         io1A==
X-Gm-Message-State: ANoB5pnSvYD2Ly8OoXOfKyoOZF0upXsTVgK8wJjPUbEZ/WJl27f8g3b9
	7l301v3OGZbjNqRcR7p9XuUgL97bsLc=
X-Google-Smtp-Source: AA0mqf4dzlajD6vHgt+tbkPRO2y2RQR6wD1ZthZtUMlGsCjMEe7IizU8e6jnDtSalDBqf+vD62nTmA==
X-Received: by 2002:a17:902:930a:b0:188:da5c:152b with SMTP id bc10-20020a170902930a00b00188da5c152bmr21407273plb.9.1670963791196;
        Tue, 13 Dec 2022 12:36:31 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709028d9700b00189f69c1aa0sm272113plo.270.2022.12.13.12.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 12:36:30 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/7] util: add scan_freq_set_remove
Date: Tue, 13 Dec 2022 12:36:19 -0800
Message-Id: <20221213203624.1423277-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221213203624.1423277-1-prestwoj@gmail.com>
References: <20221213203624.1423277-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes one frequency from a scan_freq_set object.
---
 src/util.c | 22 ++++++++++++++++++++++
 src/util.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/src/util.c b/src/util.c
index d564ebc0..69019dc8 100644
--- a/src/util.c
+++ b/src/util.c
@@ -360,6 +360,28 @@ bool scan_freq_set_add(struct scan_freq_set *freqs, uint32_t freq)
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
index cc45059f..dafa446d 100644
--- a/src/util.h
+++ b/src/util.h
@@ -111,6 +111,7 @@ typedef void (*scan_freq_set_func_t)(uint32_t freq, void *userdata);
 struct scan_freq_set *scan_freq_set_new(void);
 void scan_freq_set_free(struct scan_freq_set *freqs);
 bool scan_freq_set_add(struct scan_freq_set *freqs, uint32_t freq);
+bool scan_freq_set_remove(struct scan_freq_set *freqs, uint32_t freq);
 bool scan_freq_set_contains(const struct scan_freq_set *freqs, uint32_t freq);
 uint32_t scan_freq_set_get_bands(const struct scan_freq_set *freqs);
 void scan_freq_set_foreach(const struct scan_freq_set *freqs,
-- 
2.34.3

