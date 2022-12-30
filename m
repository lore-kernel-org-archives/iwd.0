Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90BC139E
	for <iwd@lists.linux.dev>; Fri, 30 Dec 2022 00:24:35 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id x26so7354218pfq.10
        for <iwd@lists.linux.dev>; Thu, 29 Dec 2022 16:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kLZs1qS8otXif0If0hQArbmVMMIUDChJTecK/llVWFs=;
        b=gzOCaNMO4wEftjJx1SrMYMYiE9IR+PKpc1cs8KIDI7/xqBOTZyQgbAM3YLdzEpCta8
         /M9i0mRi+D66g3XvR79rGSikf5KvkO+nP4Vz85iXUqyYEMFbgaomZYD4yzJwCx77hW8W
         iMeltC1NBZ+jOJ0WT/WGFx2DpINyO04aCEyroNAmvYOsMKpVfnfs+yzWEbVyDYMd5iCz
         cDhEbsAqLKGZNQqMb/+Z/e2mAtl5uWP2aTuEJsvDhNhAvhAe/IWwHmyzWrYurICFkGOj
         7IYlavm+pTEXCBzCEb8gK3yJ2YmLgG+5xSPZE0QUKC7qj8KbocZo1DTUVka5RfLo4u1g
         beKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLZs1qS8otXif0If0hQArbmVMMIUDChJTecK/llVWFs=;
        b=YRAry3xn20CnjvZDq4T2Rq26DjeI47D8CwPAJi0OkdOnV7IFLA5yP+0KQ3R0pcDW2u
         tCKVS6S7oemt0sOnfuRlItqPi8I2UWmkMBqihMtMa0zvJ/EHlfEc9x9PIzRw/7Fpvm90
         DbaK1jSMjU9fTqv7SIRO+oHmYead6QTs27ixciwhkEIN41nRWZcF+wqd+pAhpFEGJG9N
         8Tr9n0MfN+Hw3exIwOVLGcfhJWMOzgLVhh3rxxOut3C9hpiztM2vzrPul/M0ajff/vfx
         5p7iqvs+fKb4hw0/MyjIW83sanQmFlo8XQSrCsTVOoyBqkowkavIze29tIbe6GGrXkN1
         oKEA==
X-Gm-Message-State: AFqh2koGodfUzHrcU4Zs92t80bW0GmFygHkA2mOb6oEFJNT6/VXDk5VR
	EjqOkGVyLewPffXTkyZUSvLqD8povsU=
X-Google-Smtp-Source: AMrXdXsY4loCkVOSdoMyqEe2ehAiSbL3YbZaWjNG5MYlqKP/ivIEzCKXgcil4NqqJLaSUAw/1g+0sw==
X-Received: by 2002:a05:6a00:150c:b0:581:38df:f9f8 with SMTP id q12-20020a056a00150c00b0058138dff9f8mr17955314pfu.4.1672359874897;
        Thu, 29 Dec 2022 16:24:34 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id k6-20020aa79726000000b0057681626495sm13018325pfg.141.2022.12.29.16.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 16:24:34 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] unit: add invalid channels/freqs to test-band
Date: Thu, 29 Dec 2022 16:24:28 -0800
Message-Id: <20221230002428.2870506-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221230002428.2870506-1-prestwoj@gmail.com>
References: <20221230002428.2870506-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests some channels and frequencies that are not in E-4 and
would pass the conversion without validation.
---
 unit/test-band.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/unit/test-band.c b/unit/test-band.c
index c47069f7..caddbcdd 100644
--- a/unit/test-band.c
+++ b/unit/test-band.c
@@ -650,6 +650,26 @@ static void test_6ghz_freqs(const void *data)
 	}
 }
 
+static void test_conversions(const void *data)
+{
+	/*
+	 * Test a few invalid channels/frequencies that appear valid but are
+	 * not in the E-4 table. The checks in band.c seem to cover 2.4Ghz and
+	 * 6Ghz very well since there are no gaps, but the 5GHz band has some
+	 * segmentation.
+	 */
+
+	/* Gap in 5GHz channels between 68 and 96 */
+	assert(!band_channel_to_freq(72, BAND_FREQ_5_GHZ));
+	assert(!band_freq_to_channel(5360, NULL));
+
+	/* Invalid channel using 4000mhz starting frequency */
+	assert(!band_channel_to_freq(183, BAND_FREQ_5_GHZ));
+	assert(!band_freq_to_channel(4915, NULL));
+
+	assert(!band_channel_to_freq(192, BAND_FREQ_5_GHZ));
+}
+
 int main(int argc, char *argv[])
 {
 	l_test_init(&argc, &argv);
@@ -715,5 +735,7 @@ int main(int argc, char *argv[])
 	l_test_add("/band/6ghz/channels", test_6ghz_channels, NULL);
 	l_test_add("/band/6ghz/freq", test_6ghz_freqs, NULL);
 
+	l_test_add("/band/conversions", test_conversions, NULL);
+
 	return l_test_run();
 }
-- 
2.34.3

