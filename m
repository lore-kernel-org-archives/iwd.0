Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137EB1115
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 22:31:59 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id v21so13273234plo.0
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 15:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FAOXs5sPYpAd3JYZJAak7nteBqKxRy/XZF3cYtGQDZ0=;
        b=hW+aNv7IJ3Dtkq+0Ez0SLKn4M0OHlAPuGRb9qxfFvYhkfh0l+Pwqfij754sWqDMppo
         vhIgg+QghxJzODAdnLchSPp7mP0EsJjCaMa2yd63lXY9gmYygW5HpElE+bkgEas69NxR
         iwzdd1XtXSzxPCuFGwQTs6JFB59j9Pynsh3kOTetMeH5zYgpqVQVYacHy5LyAcaQaPc1
         0JZmbDiq6rIXSj7YbXsWDhXvOH2UNDtux8TgX13YV8VyZE1VNW9pIf2Cz161HgcqNTPj
         cLotb7Jm1wpm7axsJiqIruBKrLWPf52W4Z0FHc+pODv9eee/XWBV85sMA1wdv1X0UDbl
         5O2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FAOXs5sPYpAd3JYZJAak7nteBqKxRy/XZF3cYtGQDZ0=;
        b=6CaCAPgoU1aWrNQxbViUAKqZaPICP63sOkC9D9D5YJyrDPDo7dqPGdZ+1U3A0kwhni
         82DvFnRzgH7hCnoK/NTGy8g63PNevLFABEhJDGjwU67rJlW3DH3Thm48q3gX/DxkVF5C
         YOrtlLacvqBoQoTXFrsQ000PPzviUK9mpT1o4EHK++IcIeJYRlAHtsGKA/5NtwbbDoEQ
         JpfQ4yPaEPbpXoMEJ6aEx4xjs/RKdk48Kf2svRV0mF4kTLj2pRlQ5L33wNCCOc5QGbTL
         S5NL5TK+4Sgz8Wt8pZnGQ0HUAKaZqEo/jiJpy4kRUQlOWfwTDE+au05wcGuvXEgq3fIy
         88mA==
X-Gm-Message-State: AJIora+3TiPyFWal9fI9DuOE3vPFn+XM9CRkta70CXaIJUFFHO4Qle1Z
	9dQ+8olWvTIRHGrZVfVhL7csPuC86OM=
X-Google-Smtp-Source: AGRyM1uwqbjvUw2A2WZp8X66hrg8YFBT554mkA782pSFKXFsEf2x8Fa+HdIO90CTbq+jsh6mmXOXkQ==
X-Received: by 2002:a17:90a:404f:b0:1f2:126b:ba29 with SMTP id k15-20020a17090a404f00b001f2126bba29mr1822777pjg.74.1658269919135;
        Tue, 19 Jul 2022 15:31:59 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id g3-20020a170902e38300b0015e8d4eb1c8sm12067154ple.18.2022.07.19.15.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 15:31:58 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] unit: memset band to zero after alloc
Date: Tue, 19 Jul 2022 15:29:49 -0700
Message-Id: <20220719222950.540619-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In test-band the band object was allocated using l_malloc, but not
memset to zero. This will cause problems if allocated pointers are
included in struct band once band is freed.
---
 unit/test-band.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/unit/test-band.c b/unit/test-band.c
index 757db377..0dd9b67b 100644
--- a/unit/test-band.c
+++ b/unit/test-band.c
@@ -52,6 +52,8 @@ static struct band *new_band()
 	/* band + 8 basic rates */
 	struct band *band = l_malloc(sizeof(struct band) + 8);
 
+	memset(band, 0, sizeof(struct band) + 8);
+
 	band->supported_rates_len = 8;
 	band->supported_rates[0] = 12;
 	band->supported_rates[1] = 18;
-- 
2.34.1

