Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8FE2F2F
	for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 18:57:02 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id m6so16379125pfb.0
        for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 11:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/If4m1GxJTjgCioRpfOOS4Ke1Jj27FV+xWMcQP9x3c=;
        b=dzOpyGRiJGJD6WIJ/FUQgqqLcaqolYWGueSMwcWno6SMEePgBY0BvxPOx3QU+ow/E3
         076KvhxV7Yx0o6ic4Jf24w+3tsTfat50kcP2vTdeBJO35HURT1i6lE5fofHnWEBj0NOc
         afkM9bzQPQvv9UtDbYjBLdlH5xGATaXM2jSVgJbT5KAP0IIn/LBjCZmbqmFR+MbcV6nD
         y5IQB7SLixABetHDPcR41YOBxIwGqJ2RTnanLHgB/aorgn4goLvA0huCoh4uvBrWBD5z
         7mmF5axt3PlB9lUP+jKOtPh4t9TnlacIjprKf22FGVObCPMnLCMDN19ENgD4CektxJ4Q
         Ah3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/If4m1GxJTjgCioRpfOOS4Ke1Jj27FV+xWMcQP9x3c=;
        b=eyF6bF4EPmTtrz1PXfNir2H28sYA4R+dcBDgHLmXUclsK7Qxv4YqS8pnSrJCA7JhqX
         i5f+MJT4za+eTx3HBqomYQHyLwi53L1IMxoYSsBn3ul+L5jc6dfLo62ZU6e9HgUZgfGi
         A0mtsBO3SthdabwNvhEvr9b2nqUv4BK+KeURXC/krtY7X3X3EbsfEWme0RsPw0ScW/ZH
         2F5RUksToobCwU6wy2FlUlf7JxHdSr1eDFsbBZYgcuQGybVfn9V1IQgWXJYy5QP3gJFX
         WkezfYbFWdTIQ0C0BuCOFgMtFyb6PMBLtNNtPGN45PiNZ+gsejUb7l9bN76B1xogL75a
         3WYg==
X-Gm-Message-State: ACrzQf2tssQx7SRSK8chspaXgdI15VfuhRQooNU7qjo41AUVGzzcGYGP
	JuGsB6dYDrzwvWQ6n7Ht31OmoE7DdOU=
X-Google-Smtp-Source: AMsMyM5uzKzDhOq2e0024LDUQvzWRwGITgyXVsuxjmbF2Gu3/VkCVTixADdCNTdd0QkGtLqUXyxl8w==
X-Received: by 2002:a05:6a00:1304:b0:555:6d3f:1223 with SMTP id j4-20020a056a00130400b005556d3f1223mr46175903pfu.60.1666810622234;
        Wed, 26 Oct 2022 11:57:02 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id h19-20020a170902f7d300b001869efb722csm3209420plw.215.2022.10.26.11.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 11:57:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/5] unit: test-arc4: test RC4 both directions
Date: Wed, 26 Oct 2022 11:56:55 -0700
Message-Id: <20221026185656.489888-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221026185656.489888-1-prestwoj@gmail.com>
References: <20221026185656.489888-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests that the data both encrypts and decrypts.
---
 unit/test-arc4.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/unit/test-arc4.c b/unit/test-arc4.c
index bfc5009c..a9e0ef1d 100644
--- a/unit/test-arc4.c
+++ b/unit/test-arc4.c
@@ -92,6 +92,8 @@ static void arc4_skip_test(const void *data)
 
 	assert(arc4_skip(test->key, 16, test->offset, buf, sizeof(buf), buf));
 	assert(!memcmp(buf, test->result, sizeof(buf)));
+	assert(arc4_skip(test->key, 16, test->offset, buf, sizeof(buf), buf));
+	assert(l_memeqzero(buf, 16));
 }
 
 int main(int argc, char *argv[])
-- 
2.34.3

