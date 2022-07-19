Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC6A4C77
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 18:57:58 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id t15so2220003pjo.1
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 11:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hldBili5cveEgXyUTuAGNzo2xkrzgi6C3TAzH0xEq1M=;
        b=UoXrsYpx0enJrYLVDRu9ax+H/NKsQNMzP06NI/HMSWxVg8Okdy094NX10XIKuzyCtO
         LwfXon8k1nVd1JLKlEnTK5hjg5AxJxkjNqehyvhe2aMMZHK+1oshnCiyqu4KUQJOIqqg
         DumKvE2zDyc3cvNPbn0tyyHqOA2FItBtMeH9VWEj8NWIeTQJVqMFwV9wtINBaGbBZYVB
         V/g4RDBp6WtKg/2EnhLTQw/ErkiC5RT81DxwmOQG+981xpzKVI520Nfu5REe8JqMhnvV
         sHIMgzB8997imL4KGqjU9/kWi9L/sEnq8BXPDyNWKAnAxsB2Nc1OjjN0ck5wg2zLtYOY
         w6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hldBili5cveEgXyUTuAGNzo2xkrzgi6C3TAzH0xEq1M=;
        b=N6Q+dp/W8pcYCnIBSIrfF8yfaCxgnk9bb1f11m3u4WDyhjX9WRNWMmRJAqG9IC3lTW
         tqwb0PtDcrB7YEmXx7anGaBLCjdP/956KCnzJwhXk5rAd9k0ZC9eE3utEslNxBwxKCXc
         hNYhUwhdWLRZblYqvEczMChcoPnQhw5y9KRWMV23atZtmg/Te98ZsxvpAtvjVMWwaIwp
         YzqZhZka7FZhwW72Psbq7PMmRvz4JWcYZyIl9f5tMf8LbcxvslSe6TM20xT0eerDKTNF
         wbSnNDUalxMfUrA30eZeu9DkxUz/GfqSjNIp2srvuZ9q7yptK4+YTWo0buWDrd98dB2K
         +qYw==
X-Gm-Message-State: AJIora8iOY5OD6Gwl7c/MqvbHj1WPV9n9xD1Y7w1KT/RisH98tY8x5/0
	md0S+Ef2ILBXN1ZHl3zrrSs7mSM0MgU=
X-Google-Smtp-Source: AGRyM1vCN2BGwxhhFT9qAgXP0U8tEYzZBmm1wOc/mzH3h39qGmrisbAwQSGvxsoWiJG9LQXFB0q3dA==
X-Received: by 2002:a17:90b:4f4e:b0:1ef:ab40:b345 with SMTP id pj14-20020a17090b4f4e00b001efab40b345mr873104pjb.226.1658257078185;
        Tue, 19 Jul 2022 11:57:58 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b0016c68b56be7sm11937785plg.158.2022.07.19.11.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:57:57 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 03/12] band: add band_freq
Date: Tue, 19 Jul 2022 11:55:35 -0700
Message-Id: <20220719185544.456727-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220719185544.456727-1-prestwoj@gmail.com>
References: <20220719185544.456727-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HE has different rules depending on the frequency, so the band
structure also needs to track the frequency for any rate information
to have context.
---
 src/band.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/band.h b/src/band.h
index 7b9e901f..ba887ee6 100644
--- a/src/band.h
+++ b/src/band.h
@@ -50,6 +50,7 @@ struct band_chandef {
 };
 
 struct band {
+	enum band_freq freq;
 	uint8_t vht_mcs_set[8];
 	uint8_t vht_capabilities[4];
 	bool vht_supported : 1;
-- 
2.34.1

