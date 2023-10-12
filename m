Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171FC3CCE3
	for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQC9fC1t"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1c735473d1aso11141005ad.1
        for <iwd@lists.linux.dev>; Thu, 12 Oct 2023 13:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697140922; x=1697745722; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hg3COW67bfoCSeE7EVjUbr6xaWf+rQMP4P98pwXkI0M=;
        b=iQC9fC1t7NqrMjxmth3AmJrzFmSk0/cszy8RyPsI9p5bMtQynlyHTYIkJkfN/LfOxz
         CUn5wKW36e14iD+3N9sAjSslkwqKF0vt9+Ht3VryvVhEET3FLRLb7ZT0FnvDWsAB+x0I
         86o81O/mypBakDv+3lDk4aNb2r/GYDRYWle3+TStn/LGqstPoVA99L7M35HSVZXlTLhe
         MDZP1YSvcHMT/GQvI2LiPJcy7k7DXTwkho4/bB8mQiUItzaYmwFN3wAMtpnfoQ31UQln
         dJvLNdNVQRLvDa+CGQaOaKPYoir/7PVt8UPzWiBm0FO/ybKb2d5I3SCoZRxJSqi8xvrw
         5vJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697140922; x=1697745722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hg3COW67bfoCSeE7EVjUbr6xaWf+rQMP4P98pwXkI0M=;
        b=XCLS6WNVah7kepwOYGl+iHKFl28ZQ2wE2VkjhKkb6E14riBIxGXjAu4JabmNVD5tCZ
         r9rkFK9d7wPGslYWRxG6DfFi37VN2VKFrHP/jUW7FrQSVRxL2Gv+34UTJe6qh7keh85a
         s33iYy8/U+tQh4TItfr9gnI052SrdgxelWHxiKQLpMXhbxIvschUkD3e4RojJPC2fdbw
         t2OTEbH7GJjctBj2jB2qwQ9Y1YZODAPFNOBK7UJZQSdSUc/0kAAL3ScQ66UDBNwTzqdj
         7EKF23AwMZjIxTbMjotzUPOZ+RFXkBHXZQoMcIcjzSm6iLd/j9QhGwdBLWDl+f9GRjCL
         CZig==
X-Gm-Message-State: AOJu0YxMLfkgpONOugs4TLYDD3AZgFE3ILEky0zgswRPIfUGKKScryH0
	cIcU3KgPMR6xj4PaEZIC98fM6d7EWBE=
X-Google-Smtp-Source: AGHT+IEkamgEAaXSmrYrKEMEEXmeYozbpAjN5RHxzecg72Q3U/0nzhRE0McZYrH4645lAe4gwfiYqg==
X-Received: by 2002:a17:902:c1c4:b0:1c9:c3a7:f96d with SMTP id c4-20020a170902c1c400b001c9c3a7f96dmr7787473plc.62.1697140922243;
        Thu, 12 Oct 2023 13:02:02 -0700 (PDT)
Received: from localhost.localdomain (h67-204-152-76.bendor.broadband.dynamic.tds.net. [67.204.152.76])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902f68400b001c727d3ea6bsm2388057plg.74.2023.10.12.13.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 13:02:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 06/21] dpp: fix retransmits if on operating channel
Date: Thu, 12 Oct 2023 13:01:35 -0700
Message-Id: <20231012200150.338401-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012200150.338401-1-prestwoj@gmail.com>
References: <20231012200150.338401-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DPP configurators are running the majority of the protocol on the
current operating channel, meaning no ROC work. The retry logic
was bailing out if !dpp->roc_started with the assumption that DPP
was in between requesting offchannel work and it actually starting.
For configurators, this may not be the case. The offchannel ID also
needs to be checked, and if no work is scheduled we can send the
frame.
---
 src/dpp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/dpp.c b/src/dpp.c
index a5bc2e0a..52adda9a 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -2186,7 +2186,7 @@ static void dpp_frame_timeout(struct l_timeout *timeout, void *user_data)
 	 * send. Just bail out now and the roc_started callback will take care
 	 * of sending this out.
 	 */
-	if (!dpp->roc_started)
+	if (dpp->offchannel_id && !dpp->roc_started)
 		return;
 
 	dpp_frame_retry(dpp);
-- 
2.25.1

