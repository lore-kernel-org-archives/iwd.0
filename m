Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6ED8F76
	for <iwd@lists.linux.dev>; Tue, 20 Dec 2022 21:43:25 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so128204pjj.2
        for <iwd@lists.linux.dev>; Tue, 20 Dec 2022 13:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=00KWylBOnhMgUVU8WSuUTOt45h+P4F1QEAlCiWoOQmY=;
        b=cXlpG/w9rrAZ+1DTS5AT9lD/FXBFxbOzhnXwsqEwsAtGmr9lbr5oC9IejRFejCRyAy
         7ClgcB1ZT07n7W/zpwRMgzVgQOZ1+N+seSHZMTwjTaOtbMndH6nbSGi2ZdA3ttoQ09J/
         Qz5tVRJqzhZpK+D3eHQD9MIhKzOhdRQ6JIpiONiIcsaO7ckMF3QtA9AZoriAsz3MUwM1
         NYfcHMZYeGmR0BOcrVKjW0oCejtRh7H6jjHjUPUfmrALHC8uCqMP1RYY0Z2JlMDLxuA0
         mc1DOBYxhrxR9/qzlE/6VW4SPohhHiCpSRn/4Qo/UVN24tI3zv2M3bM6QrBPjAvNEbvl
         FLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00KWylBOnhMgUVU8WSuUTOt45h+P4F1QEAlCiWoOQmY=;
        b=vHDYwwx3kvfGPVIQLYmvdIqdctuPWS0L1jZvtkbcJRrZKhVFrI2e4YQLCJNl0S3Qcy
         j4pINfLYCGwCGZN1tY/1B/nKiJ3DjN/013+fHa2EothYszZZ71LqjyewWnjHwmgoO8R+
         n4/AJ7CAFVAwp2p+BhELE+0bRy9MBDZmu9vNSdNWaWNX76r4MJB7H+Ub1uUhYD4/gL8U
         tNGl+1kXuzm+HSEqnwZsjzO59mK1e3aSzE19Siq4iE/B+qyzaGPRbUVsEw0/X5qzDoyz
         SGo/3E9TNgJmqD2oUMjrYQHDp7ttzLuPrn3IH5d/5RKKvSFiAwenFvryV4+RGUUwWcz6
         SBcg==
X-Gm-Message-State: ANoB5plGB0IzYID1rBi24Y5Rtw7WtJliz6rUo5yk3T+rMZQlbnOVorMn
	I+OVuLhZPQVd+M6ztsuiVn6MCHj4VXQ=
X-Google-Smtp-Source: AA0mqf4o679rwgtt4/UwuIjGRKIYJNnNQUPzlcl8chv/p3g/jOSzgqLddaeupEfLHUCYzv21WX9oaA==
X-Received: by 2002:a17:90a:4f4b:b0:219:15b0:3da3 with SMTP id w11-20020a17090a4f4b00b0021915b03da3mr48281182pjl.37.1671572604801;
        Tue, 20 Dec 2022 13:43:24 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id e88-20020a17090a6fe100b00219cf5c3829sm8153301pjk.57.2022.12.20.13.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 13:43:24 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 03/10] band: add ampdu_params value
Date: Tue, 20 Dec 2022 13:43:11 -0800
Message-Id: <20221220214318.2041986-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221220214318.2041986-1-prestwoj@gmail.com>
References: <20221220214318.2041986-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the last bit of information the kernel exposes about the
hardware's HT capabilities.
---
 src/band.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/band.h b/src/band.h
index e196a416..a4652fd8 100644
--- a/src/band.h
+++ b/src/band.h
@@ -77,6 +77,7 @@ struct band {
 	bool vht_supported : 1;
 	uint8_t ht_mcs_set[16];
 	uint8_t ht_capabilities[2];
+	uint8_t ht_ampdu_params;
 	bool ht_supported : 1;
 	uint16_t supported_rates_len;
 	uint8_t supported_rates[];
-- 
2.34.3

