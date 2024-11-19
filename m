Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79831CCB23
	for <iwd@lists.linux.dev>; Tue, 19 Nov 2024 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026280; cv=none; b=ct2N4UiOXH74keLQLroADYJ0rOe6bUpQykd1/XKqS9P2eDZoj1gy4IY/pjGGeDrMnHxvEVhOJ13xdoxscI9SBUWcugSzVchSVGtiM0Phot0yD7QV9DopzSArG8dMIwNYQrfQZfwYRu9n7aQTR74oRXitcdg1HxfKBXYvkTRRUa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026280; c=relaxed/simple;
	bh=DPsUR7Ke79ERngHeudwrMNddstg6r92/IGyrMQLvQKw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ANcZabPsdFgjKGQmGRheQLWc8P6gRnwPdrkIlZCOV7A8fNNhKJy56HVKD8iSJxnN6erJA0ecY5NVva/mBVZ903lSnlPD6NJ0qb59sIqY2BMfTeobl6daSoXCLtSE6OInqOF0spYkdZNqTmj7pBWOMVJP7VCjsYvKQHOBKY57g+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ets5bz+y; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ets5bz+y"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20e576dbc42so46749555ad.0
        for <iwd@lists.linux.dev>; Tue, 19 Nov 2024 06:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732026278; x=1732631078; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=02MzuxPnd0BClg5tYNWXewgemsxNIJtMddWTyP/ekhM=;
        b=Ets5bz+yq2LPPYwmCabruYsmxRQdVBFZEN9nGiZwYPnT9bspL8/+PRhPbuTwv0IuLG
         igo3cYxpVZ77ezQNLW4IYNAvSNGnjrqnh/ifnGDbhy52iHqtWYuBy67djarmXp6xJjWU
         hyEjzW5xMupHd700652jA/2rco+UVbTm/vhex3M3LtNwp2YkdzpVDw+gTthbm2dzG4MU
         wMkuSToSaBitJGdxjAGdm2DXy0v4L959XIyDxTS8LH+K/8HQE7M/+xLeozyZAcw7qHnT
         wHv/7nr/9QtxYs0oPbhM1K+yBD9dKvHl5NhItBVr11dmaSnD+DDZNpAk3NoexZzW+t/G
         rHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732026278; x=1732631078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02MzuxPnd0BClg5tYNWXewgemsxNIJtMddWTyP/ekhM=;
        b=FzF5dmgRlBytrD5L/PgSay8H9ptLza/PfArNQ9g8kX74hS8R2zMjt4VmYoMVO1ntDP
         i1/fagqf5LOnpXtNhqLGYBB6CfPP6JqHfuKRgpeNypCjYDCZnoKpGd0VCFucoaPwq/CO
         tX7aTH0lqpgj7Byzse24rpoAizvX3dS0wcX0WW1MaOqGC14Rz5PB/C7zHNxcQeS6k3oW
         GsO89Tgc3pDvmGWGmoHq0SMbwYWlAs1Q7bd3DSInJbLs4QgI0IiTRw+LfTVc/aPdPP35
         +ZHa9oDxbsiicvqPPtNPC2MQYPml11fBrdnMnyXFBGcut541A8/kFaejuBZ12H4UFLer
         wW4w==
X-Gm-Message-State: AOJu0YxWECm3UImI8XlGU4e60UmNhh5qavktyl7rTUHRdPfpobMNahsh
	5Q8jWLTzxpLmCgAnXRMslV9nNs1nM5jquhIhkOgqNjyDBFtOX5mIEW+2Ug==
X-Google-Smtp-Source: AGHT+IEkKcGmwzieRXR5WlwCOhxShF1Xd3ojINgxrU6J/9POyJZ/cwkioPGo6rdlEnuWa8td7/sknQ==
X-Received: by 2002:a17:903:244b:b0:20c:e169:eb75 with SMTP id d9443c01a7336-211d0d5ec0amr216538865ad.2.1732026277532;
        Tue, 19 Nov 2024 06:24:37 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212389529b6sm29219115ad.236.2024.11.19.06.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 06:24:37 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/8] util: add util_linear_map
Date: Tue, 19 Nov 2024 06:24:23 -0800
Message-Id: <20241119142430.323074-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This has been needed elsewhere but generally shortcuts could be
taken mapping with ranges starting/ending with zero. This is a
more general linear mapping utility to map values between any
two ranges.
---
 src/util.c | 30 ++++++++++++++++++++++++++++++
 src/util.h | 11 +++++++++++
 2 files changed, 41 insertions(+)

diff --git a/src/util.c b/src/util.c
index a4a78fb6..a6ab9d85 100644
--- a/src/util.c
+++ b/src/util.c
@@ -312,6 +312,36 @@ bool util_ip_prefix_tohl(const char *ip, uint8_t *prefix_out,
 	return true;
 }
 
+/*
+ * Linearly maps @value (expected to be within range @a_start and @a_end) to
+ * a new value between @b_start and @b_end.
+ *
+ * Returns: false if
+ *   @value is not between @a_start and @a_end
+ *   @a_start/@a_end or @b_start/@b_end are equal.
+ */
+bool util_linear_map(double value, double a_start, double a_end,
+			double b_start, double b_end, double *mapped_value)
+{
+	/* Check value is within a's range */
+	if (a_start < a_end) {
+		if (value < a_start || value > a_end)
+			return false;
+	} else if (a_start > a_end) {
+		if (value > a_start || value < a_end)
+			return false;
+	} else
+		return false;
+
+	if (b_start == b_end)
+		return false;
+
+	*mapped_value = b_start + (((b_end - b_start) / (a_end - a_start)) *
+					(value - a_start));
+
+	return true;
+}
+
 struct scan_freq_set {
 	uint16_t channels_2ghz;
 	struct l_uintset *channels_5ghz;
diff --git a/src/util.h b/src/util.h
index dafa446d..9f3f0a57 100644
--- a/src/util.h
+++ b/src/util.h
@@ -106,6 +106,17 @@ static inline bool util_ip_subnet_match(uint8_t prefix_len,
 		  ~((1u << (8 - (prefix_len % 8))) - 1));
 }
 
+/*
+ * Linearly maps (interpolates) 'value' from range 'a' to range 'b'
+ *
+ * Fails if:
+ *    - value is not between a and b
+ *    - a_start == a_end
+ *    - b_start == b_end
+ */
+bool util_linear_map(double value, double a_start, double a_end,
+			double b_start, double b_end, double *mapped_value);
+
 typedef void (*scan_freq_set_func_t)(uint32_t freq, void *userdata);
 
 struct scan_freq_set *scan_freq_set_new(void);
-- 
2.34.1

