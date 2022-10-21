Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139A06134
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:13:59 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id p24-20020a9d6958000000b00661c528849eso2369771oto.9
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZeyfgP692EXnD9OkF5MVt/X3WIkq8K8+w1Boi566YQ=;
        b=gkbyrfctK3h4eG5ryS6igc6JiIOeidUSD5mDdgOe+Dw+pPNsUsWKJ2gkcCHNi3QZz6
         XUJu9skcTKDbye9rPrKc7foaADLIcCoZ365ZFEX0PycLp1IWSrWLXLtUdkzfElg0rRKt
         5vjewC4c5yveGs8G1qjQ+6BZChSLxM9kztkV4jqcQwoUZBN68RFKBheCs0jktzRNDYex
         T//MfsMsgLCIeQTqXSr0UPzDjWD7hACAG+KdJUSDvGTFYZCvYDxAElD6OQizo2ltd/24
         Aqga6dYiUesigBxtrjJ0d76WJ8Kxk/tXGs8S6Q6EpbKQhTicjwCzEvbPqs+ByR9FNMLS
         bL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZeyfgP692EXnD9OkF5MVt/X3WIkq8K8+w1Boi566YQ=;
        b=sHk3rWl7tiRWHWcsQXqM5wMGfv+2IzRZ96X7wyBagDWNREkyVBSRm7AfcZ9bqxzbyg
         wfu1uGX3zbuBboMSP1bskNLjOh4N4ehJon5C/pKvziD4hDDO9sgn5LYkfytz7Wdh0u+4
         n8ENJOcTGCr0Ff7KEHpUQ68cfywYi8yD/kqspc/3y7Q0kgax3JomREy65BCQfp4N2/gS
         aVpljlNbDsxw0D+X+xbyfw7VKYyv0AZf7kSF65oWHgbVra8Hl/L7D1jzzMMphwjcTaCE
         IWz+hKqFi052PSyH95lw+flrB2/6Jzy0u/xgqLRYydtJ6zWlpc9Z7FY1LcdKiW+nJeJQ
         6bFA==
X-Gm-Message-State: ACrzQf2n1Gbnzd47jjmNYNSC5oVy5B72KlO3UyzJHzbBbbLJXjU+jQZv
	HoCrVr3nORA98ZlJHjSt3HOJz7DF8bA=
X-Google-Smtp-Source: AMsMyM5MXZ+G8zmOQx7JfI9nkvchc1ecGL22DyCku2sw+pktlBOzPRg+7o98IaX5Crs7OukT/OscWw==
X-Received: by 2002:a9d:ee4:0:b0:660:bd64:a3f0 with SMTP id 91-20020a9d0ee4000000b00660bd64a3f0mr10547903otj.234.1666379637693;
        Fri, 21 Oct 2022 12:13:57 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:13:56 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 19/26] station: Use IE_CIPHER_IS_GCMP_CCMP
Date: Fri, 21 Oct 2022 14:13:00 -0500
Message-Id: <20221021191307.31492-19-denkenz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021191307.31492-1-denkenz@gmail.com>
References: <20221021191307.31492-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/station.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index 11e86d1f06c2..eab16eff5afa 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1167,8 +1167,7 @@ build_ie:
 	 * also indicates support.
 	 */
 	if (wiphy_supports_ext_key_id(wiphy) && bss_info.extended_key_id &&
-			(info.pairwise_ciphers & (IE_RSN_CIPHER_SUITE_CCMP |
-						  IE_RSN_CIPHER_SUITE_GCMP)))
+			IE_CIPHER_IS_GCMP_CCMP(info.pairwise_ciphers))
 		info.extended_key_id = true;
 
 	/* RSN takes priority */
-- 
2.35.1

