Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5354210F2
	for <iwd@lists.linux.dev>; Fri, 30 Dec 2022 00:24:34 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id k137so8799632pfd.8
        for <iwd@lists.linux.dev>; Thu, 29 Dec 2022 16:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRfuj6HbMU/6tjrfpOxI4OAKoTEu6BQQUVsRKDfQ+no=;
        b=HULl9+1FOmVkwyb0nl/Y82dBa77DXz/P6PMz/s7VUzDh4VQpX4dgOjZbyBzOyh95Kk
         c/j0j6xI6jIDgkXGPE4DzI6eA5Z8N7CNEYx9GRaYCYcMV39tUWK5V0WRNpNz9cL5RiCF
         D+v89GzQbGwXONem9ftRax0t3juERQ72SYYFKgQ549cltop8Cu1rnfY1ZNUM4k2Jh1Kd
         JLKnB60jVUv8479ZLER+sUHpWezuK+XJUan3QiuLNzuNg2FvO+wpi3KhGxQ11do5Ym71
         bIuTj95kM/CiPBoTcFB1Q2PkamKLjTcCy+xqcwn02gZ6jHLQzf2mW/0E0bkwYejfAF/p
         /xrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pRfuj6HbMU/6tjrfpOxI4OAKoTEu6BQQUVsRKDfQ+no=;
        b=nco8xls2hAeaZ/bj39+XQCCtSUtt8owkLy8EMq0SIkGXqPU1HjcKHxx/K+at0TAcE5
         HD4zyKt+hnOylrECJ/dpfMwg6VkZhoEp/QP0dpzqkYY51xPr5Y+tsSNggxZuwe+D8I0m
         llb3mFUHQbhko6Mhi0l7CDLwpDZYjKiYRXm9lNY7IEPP8/aQNKpVRoITOKBwosktRuD6
         pKsz7Hd/bWgaUY3jfQMdJCy8IB4OEv7+xD9wFfrm5PRuRubpnnnZU9aboMYXyLBItpdG
         uf2Jlu8/A/GOSXNhxl6eNhUTP/yoYgPwwdnSW85wpFZtBvbfoUj3vVUqSFKRyFtuqtoW
         /KkQ==
X-Gm-Message-State: AFqh2kosk1db066EEW84mNo3C9wtdgP8xgzg+AKTebVVEYWch/RYuWPz
	uwrG2/mP6gAWGONdjn51axg8q4kWQtY=
X-Google-Smtp-Source: AMrXdXtalD/nIVmjC9bFcm4ZrkOqICsIoH6uBg8WL/3jqDZnccts7jUOQgkQDyg3VfdiH/35emFCag==
X-Received: by 2002:a62:30c2:0:b0:580:ccae:291c with SMTP id w185-20020a6230c2000000b00580ccae291cmr19582781pfw.24.1672359873539;
        Thu, 29 Dec 2022 16:24:33 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id k6-20020aa79726000000b0057681626495sm13018325pfg.141.2022.12.29.16.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 16:24:33 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] unit: fix test-band for 6ghz frequencies
Date: Thu, 29 Dec 2022 16:24:26 -0800
Message-Id: <20221230002428.2870506-2-prestwoj@gmail.com>
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

The 6GHz test was not incrementing the frequencies properly which
was resulting in invalid frequencies, but since the conversion
API was never linked to E-4 the test was still passing.
---
 unit/test-band.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/unit/test-band.c b/unit/test-band.c
index 90b48f9f..c47069f7 100644
--- a/unit/test-band.c
+++ b/unit/test-band.c
@@ -644,7 +644,7 @@ static void test_6ghz_freqs(const void *data)
 	uint32_t i;
 	enum band_freq band;
 
-	for (i = 5955; i < 7115; i += 5) {
+	for (i = 5955; i < 7115; i += 20) {
 		assert(band_freq_to_channel(i, &band) != 0);
 		assert(band == BAND_FREQ_6_GHZ);
 	}
-- 
2.34.3

