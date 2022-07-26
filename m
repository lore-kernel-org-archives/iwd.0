Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CE95385
	for <iwd@lists.linux.dev>; Tue, 26 Jul 2022 17:09:31 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id x1so12140889plb.3
        for <iwd@lists.linux.dev>; Tue, 26 Jul 2022 10:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qx5t2hlrsYHeDTvYA0mVSjP4DDPeAO9gWPy3uEfd8a0=;
        b=StXSQMJfHw38gr+Lo5znOMGCA0NuSE2kTO3wcS4Q42MBuJrCe7dIfDmxeRfsvU/2n+
         ABVc1RH+hCePf+Y7sEVB0Cqg2ACPfUfWGM/gbfudIeiSfzvxUXN/8wbIlFv5h7FgvV8T
         qFXmuMix47MBW2nJg0Yl+EGNm06xiH3cYDfg35RnPOPdKyHvKL9QHmu+EqgTTyC1Ytld
         MiVa9YaTLXn7oKi1RBpHyrHE4Z0/NLrZs6icS6+lJHNtNG74LOLeL7HIGIZP3fLVpWtA
         d/Gib3LxkdGBWn72OrHtFTK87Z7xxm1R/P5Jc3D2MFNuoaHn0dBY9YkPgpviqtnniwp6
         UP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qx5t2hlrsYHeDTvYA0mVSjP4DDPeAO9gWPy3uEfd8a0=;
        b=lEnG3muKy0FyjMyqC39REVFUeEhyfDG8RMbouT2/1oSZ7ShVdfZG6M0w/2UBRa/Kr9
         353n0VMHhvLTY4j6rU7WWxuPvT+Z46nIG5vBmU6xNI5WFIThe0+3hF7nHMWZIdOLSDVW
         LKU/0tXuMnMEfVoUtG6xYh+3YySyzo34poxHqJyilZw2CKVjz2CGoPWQG95CRenL3hcw
         Co9Uh2xYgzt0rx1n7S1W06lSQqYYI/ZsaRcnz6iLG/BWMN07im8zWpJdp11wp3ljaowN
         v4wqB2cxAFMZuYF23Dc8xLYx8HVksZFqNjrwRNmvv9e2y/pckHGyaXVEAyci0QiXwcr0
         tl4A==
X-Gm-Message-State: AJIora8z4xpBCO5koWnn5TXxjvb6SXon1s3dgaAoP8A1TQI1V3olqC2g
	IqVvicLw8WAvSltgBQx+Zsdq7O0Pywc=
X-Google-Smtp-Source: AGRyM1s5nV9+xJp+3akw/kU27XpYv0ZOz3gB/hL1wychULPmBWBr6cr4b2FFFnrVlqgACyt0bTCMDw==
X-Received: by 2002:a17:90b:1bcc:b0:1f2:e0d3:e23f with SMTP id oa12-20020a17090b1bcc00b001f2e0d3e23fmr205098pjb.116.1658855370348;
        Tue, 26 Jul 2022 10:09:30 -0700 (PDT)
Received: from jprestwo-xps.none (h208-100-169-68.bendor.broadband.dynamic.tds.net. [208.100.169.68])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b0016c09e23b18sm11778694pli.154.2022.07.26.10.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:09:30 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 07/10] util: add scan_freq_set_subtract
Date: Tue, 26 Jul 2022 10:09:17 -0700
Message-Id: <20220726170920.15929-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220726170920.15929-1-prestwoj@gmail.com>
References: <20220726170920.15929-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removes any frequencies from one set that are found in the other.
---
 src/util.c | 22 ++++++++++++++++++++++
 src/util.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/src/util.c b/src/util.c
index 3c6e2b1b..ebaff6a0 100644
--- a/src/util.c
+++ b/src/util.c
@@ -499,6 +499,28 @@ void scan_freq_set_constrain(struct scan_freq_set *set,
 	set->channels_2ghz &= constraint->channels_2ghz;
 }
 
+void scan_freq_set_subtract(struct scan_freq_set *set,
+					const struct scan_freq_set *subtract)
+{
+	struct l_uintset *sub;
+
+	sub = l_uintset_subtract(set->channels_6ghz, subtract->channels_6ghz);
+	if (L_WARN_ON(!sub))
+		return;
+
+	l_uintset_free(set->channels_6ghz);
+	set->channels_6ghz = sub;
+
+	sub = l_uintset_subtract(set->channels_5ghz, subtract->channels_5ghz);
+	if (L_WARN_ON(!sub))
+		return;
+
+	l_uintset_free(set->channels_5ghz);
+	set->channels_5ghz = sub;
+
+	set->channels_2ghz &= ~subtract->channels_2ghz;
+}
+
 static void add_foreach(uint32_t freq, void *user_data)
 {
 	uint32_t **list = user_data;
diff --git a/src/util.h b/src/util.h
index f61e3575..0b7832fb 100644
--- a/src/util.h
+++ b/src/util.h
@@ -118,6 +118,8 @@ void scan_freq_set_merge(struct scan_freq_set *to,
 					const struct scan_freq_set *from);
 void scan_freq_set_constrain(struct scan_freq_set *set,
 					const struct scan_freq_set *constraint);
+void scan_freq_set_subtract(struct scan_freq_set *set,
+					const struct scan_freq_set *subtract);
 bool scan_freq_set_isempty(const struct scan_freq_set *set);
 uint32_t *scan_freq_set_to_fixed_array(const struct scan_freq_set *set,
 					size_t *len_out);
-- 
2.34.3

