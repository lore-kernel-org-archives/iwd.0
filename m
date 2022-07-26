Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BFA6007
	for <iwd@lists.linux.dev>; Tue, 26 Jul 2022 17:09:30 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id jw17so1629809pjb.0
        for <iwd@lists.linux.dev>; Tue, 26 Jul 2022 10:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=adpzszcIJo5fgzf+4/NigB/PHBM8z/cUyC9+GI+qO5E=;
        b=SXYLdOcUUhb3TW6v4Mf+YGA6buFyLqNupBsTaJDdLF+5SSX0VVdA0sP8U+LAJyrdni
         EOmmGZ/SY1R8yIWn5G1PXBY7SLa9S7pLaf7wWsCHjjBrmCpsH1KOe2za6THHADPJNykH
         878WaBpcDOXtAaQP8dToAz55Eg6yFG2wPsMAPNdUTj2tWXvxCOpWmc3NVJR/c3jx201J
         JJIN8MsLItYaejvI3CjjEAXa82URFsApL8/0R5A1SJY4Ud71R3nBjrHDGD3DgNFPsYSQ
         P+e3hnnWpS64w2t8+O3cJ+chuqpMsnm62Uya+clzuj9mmVhShDvidIvlqrflsnLRKtrr
         J4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=adpzszcIJo5fgzf+4/NigB/PHBM8z/cUyC9+GI+qO5E=;
        b=cw3po77SrBhqictR8F/jXUxvZijHA4/iiOlrYLfarF0FISA4b6yFP7TcUJPhAaa2PI
         M3jKhcm4WbpBC9NV4cmqz9nx2PFMq7JRh6uGEcgTNZwxmSjRBIgqcdEX9jzq9vCSh5xN
         YLxV0KZ8/tl5Jqw4xz0PbmIHNj9uIOC47OofGLED8mRz/UFjYBLOpWeMcZNoCmjJT792
         GCJRS47xmWPXfJy3JpFW558MEouqydYugq2b20zuOoIKhps50Yhzh6Y5GU/Pwzxn6yU1
         i9cf8ln8kWFtL4Uysqbwa318NslSrkGJmCTBr3fnvvwJBE0iz810frbkMgRp9sRvNqyS
         +VqA==
X-Gm-Message-State: AJIora84DFs05dc1hCTZ1PHbc9BZOKc0NAr5t3eM9PZYavmgKiZSSxrX
	5qtLN1i6Z219N7qoGVw7gyVUZ7ryrDo=
X-Google-Smtp-Source: AGRyM1ux3HyvMLnbtIhmikh/pI4xiYST6GkmmNycc8CPt4raOiae16XzQtLXkzuR7EMEXcz+v1ZRHA==
X-Received: by 2002:a17:90b:3d85:b0:1f2:74f9:1742 with SMTP id pq5-20020a17090b3d8500b001f274f91742mr181549pjb.41.1658855369616;
        Tue, 26 Jul 2022 10:09:29 -0700 (PDT)
Received: from jprestwo-xps.none (h208-100-169-68.bendor.broadband.dynamic.tds.net. [208.100.169.68])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b0016c09e23b18sm11778694pli.154.2022.07.26.10.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:09:29 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 06/10] util: make scan_freq_set_get_bands const
Date: Tue, 26 Jul 2022 10:09:16 -0700
Message-Id: <20220726170920.15929-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220726170920.15929-1-prestwoj@gmail.com>
References: <20220726170920.15929-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/util.c | 2 +-
 src/util.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/util.c b/src/util.c
index 2832486d..3c6e2b1b 100644
--- a/src/util.c
+++ b/src/util.c
@@ -378,7 +378,7 @@ bool scan_freq_set_contains(const struct scan_freq_set *freqs, uint32_t freq)
 	return false;
 }
 
-uint32_t scan_freq_set_get_bands(struct scan_freq_set *freqs)
+uint32_t scan_freq_set_get_bands(const struct scan_freq_set *freqs)
 {
 	uint32_t bands = 0;
 	uint32_t max;
diff --git a/src/util.h b/src/util.h
index 75c29039..f61e3575 100644
--- a/src/util.h
+++ b/src/util.h
@@ -111,7 +111,7 @@ struct scan_freq_set *scan_freq_set_new(void);
 void scan_freq_set_free(struct scan_freq_set *freqs);
 bool scan_freq_set_add(struct scan_freq_set *freqs, uint32_t freq);
 bool scan_freq_set_contains(const struct scan_freq_set *freqs, uint32_t freq);
-uint32_t scan_freq_set_get_bands(struct scan_freq_set *freqs);
+uint32_t scan_freq_set_get_bands(const struct scan_freq_set *freqs);
 void scan_freq_set_foreach(const struct scan_freq_set *freqs,
 				scan_freq_set_func_t func, void *user_data);
 void scan_freq_set_merge(struct scan_freq_set *to,
-- 
2.34.3

