Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD40D1CCEC2
	for <iwd@lists.linux.dev>; Tue, 19 Nov 2024 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026283; cv=none; b=F7lfwRcHAr0SbmYjrlT+SuHB40Rcd4o8WYoujrdnqahgOGQcd7tHUTISZZeiT+tdCV/P/beJ2c/HiYWoyVTIcPccPQf9brNjXQZPkIyovXLzwTF5P2/MuzfnEVch2NpOEIZImyFA1W0U8wGRuUbbt806Q2fj9XpJfFJOgSAW/1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026283; c=relaxed/simple;
	bh=RHCrU+j35IIEqBwc2UJ5N/nOvOWt5C1lVyx0FiXaEWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K1BZ+cBMGj2n6cB/5Q9FvBfKYpI3vk3nqNSH/rTfAtUUje8sf+cJhFxvWfQPO1lLxETO8AbZ6tkY+US7xqoLW6ofBPn3ZXlNn+3Qnui6QsATejqAoKrA/3MyI1ws/7nF89ZPOwGBQ8W3WpWk8kWyt+NTFR0VI2GJ5UJ1mjE6gWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdMr4dEJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdMr4dEJ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c803787abso43165365ad.0
        for <iwd@lists.linux.dev>; Tue, 19 Nov 2024 06:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732026281; x=1732631081; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHeBryzmHcHlGtI1q7sLAolrWPuwQMEO1uQI6pYkW8I=;
        b=kdMr4dEJ43Qd+uLzIZwESBIn1NkDshAOXR3yQ6DmaIJKaQBZhPp8kR++SkcFx0aj73
         YNQK/ZMtiLvIzRnf7zATG//M0eFktXL1eOifi9aS+9q9tVaR/i4dOaYPBM1jYJ4HmfJY
         n4n6gogviRTvhkHEOB25+YI3ErqZrjGWOwjtgUsBoFxo//rOu0YsIQ0uz/ZHvu1meTah
         TH24caI9/CLXOTrNkfKeFvZp3r5XRgnGEVbRRAqk0DmEhQYHwH+ZEZl/OowdIkapm0vG
         jyp2JhV73hhCWOm82+e4FXe/PnFpsQB5iFiAbBBeDCXONOsd/+h2mxcriWWAD8HOln3z
         ihmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732026281; x=1732631081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHeBryzmHcHlGtI1q7sLAolrWPuwQMEO1uQI6pYkW8I=;
        b=ctfh4CgWqD6ks7yHEz6sLSYlrY0TUZtK4ob2/zP2Hzlq+aj23hcVmPAVYvLlu0B6Tm
         m8ql4s5zFkEXK5HL2ssx1wI3tTK+RXGhJWfngqGRjKlFFw9/7+ljaHDNykxdImvi7Irw
         Tyqi2iFBVzylaoI/mhKXkIomkzAPh1Q++rjnR5VnVjorRNh74vljFtN4YllkMN23YyOL
         /VDxlonczmfbWlSBjnFk8vNtbxuVm896f8IPMHTHmommrLCYMsySEp4689wHqgC2pPMf
         Phl/xLgQCbBUy3GXpplzdTmLOVjJjZjG74HL7zQQ2h6XM23953g2gMmuZym267FVE904
         8IlQ==
X-Gm-Message-State: AOJu0YzyooyBLIYest6Adetj9mFntL2XsKO6mREk7bcwV5KlV4ZfpVZU
	wfQWWl88J1NkN+nhxIAy1teTXRN14PgY++IEPfPu8P58Na6hznUcW2vBGg==
X-Google-Smtp-Source: AGHT+IFQYMbw8W+4rUDqqVAcreN7nW05U5smZ+OsN9JEUuoNv/ymxR7c3E4EP2cFJIUCtspWByYPSA==
X-Received: by 2002:a17:902:f684:b0:20c:5ffe:3ef1 with SMTP id d9443c01a7336-2124d027ef7mr50566835ad.17.1732026280751;
        Tue, 19 Nov 2024 06:24:40 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212389529b6sm29219115ad.236.2024.11.19.06.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 06:24:40 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/8] util: add util_exponential_decay
Date: Tue, 19 Nov 2024 06:24:25 -0800
Message-Id: <20241119142430.323074-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119142430.323074-1-prestwoj@gmail.com>
References: <20241119142430.323074-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is copied from network.c that uses a static table to lookup
exponential decay values by index (generated from 1/pow(n, 0.3)).
network.c uses this for network ranking but it can be useful for
BSS ranking as well if you need to apply some exponential backoff
to a value.
---
 src/util.c | 28 ++++++++++++++++++++++++++++
 src/util.h |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/src/util.c b/src/util.c
index a6ab9d85..b673b002 100644
--- a/src/util.c
+++ b/src/util.c
@@ -636,3 +636,31 @@ struct scan_freq_set *scan_freq_set_clone(const struct scan_freq_set *set,
 
 	return new;
 }
+
+/* First 64 entries calculated by 1 / pow(n, 0.3) for n >= 1 */
+static const double rankmod_table[] = {
+	1.0000000000, 0.8122523964, 0.7192230933, 0.6597539554,
+	0.6170338627, 0.5841906811, 0.5577898253, 0.5358867313,
+	0.5172818580, 0.5011872336, 0.4870596972, 0.4745102806,
+	0.4632516708, 0.4530661223, 0.4437850034, 0.4352752816,
+	0.4274303178, 0.4201634287, 0.4134032816, 0.4070905315,
+	0.4011753236, 0.3956154062, 0.3903746872, 0.3854221125,
+	0.3807307877, 0.3762772797, 0.3720410580, 0.3680040435,
+	0.3641502401, 0.3604654325, 0.3569369365, 0.3535533906,
+	0.3503045821, 0.3471812999, 0.3441752105, 0.3412787518,
+	0.3384850430, 0.3357878061, 0.3331812996, 0.3306602598,
+	0.3282198502, 0.3258556179, 0.3235634544, 0.3213395618,
+	0.3191804229, 0.3170827751, 0.3150435863, 0.3130600345,
+	0.3111294892, 0.3092494947, 0.3074177553, 0.3056321221,
+	0.3038905808, 0.3021912409, 0.3005323264, 0.2989121662,
+	0.2973291870, 0.2957819051, 0.2942689208, 0.2927889114,
+	0.2913406263, 0.2899228820, 0.2885345572, 0.2871745887,
+};
+
+double util_exponential_decay(unsigned int n)
+{
+	if (n > L_ARRAY_SIZE(rankmod_table))
+		return rankmod_table[L_ARRAY_SIZE(rankmod_table) - 1];
+
+	return rankmod_table[n];
+}
diff --git a/src/util.h b/src/util.h
index 9f3f0a57..8aef2985 100644
--- a/src/util.h
+++ b/src/util.h
@@ -141,4 +141,6 @@ struct scan_freq_set *scan_freq_set_clone(const struct scan_freq_set *set,
 
 DEFINE_CLEANUP_FUNC(scan_freq_set_free);
 
+double util_exponential_decay(unsigned int n);
+
 #endif /* __UTIL_H */
-- 
2.34.1

