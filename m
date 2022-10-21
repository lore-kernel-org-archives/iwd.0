Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F18A3D60
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:13:40 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-132fb4fd495so4700999fac.12
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkmhcFzxlwRMcnB1rIwSKb4zvn9eT8l0k3JrrN7xZPM=;
        b=T6hA8ZaYdB9I6XODLF+4MQGYTVj7k+iItW/g6yMVCpZs6Exp1w2cm8ev41c4JmYWg1
         KcRh/efM+RN2yffqg0j9DOAQxKpCv0hc3y6kUdmRnlWfrbITVvs7MVlxGsITdECxGg1T
         xFrPzWr/V4ZFycqr7Rx2mh8b6LNnXvqCQFPkzOKu5ygl6wHdjCXc1txyAgFJDVF64bEK
         jTaDUMq/66FoHgxf6udGWi8kRFTMd6wfH3gG0VDJbPjiCUYz4gyKZKJkbFJbS/wqGLCq
         SN3S/IKZZdyPXiBnHDLtJ0+SEyMHyop0s9bh+KCOduOor4ZwQC9/W9YleU7NhulXJQC5
         HPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkmhcFzxlwRMcnB1rIwSKb4zvn9eT8l0k3JrrN7xZPM=;
        b=Ei0sAH6lRn8vPFJ4ztZpLYCEThKWoDM1go4qNw6f0L+lbVKZ1nfymPA2vA59MLBwEY
         92PbybxSx/y9h330CS7cxGkxYNfypQAamrCo3f77/1AYxeXRFgy/SeE+MRJXjMquT1Ge
         Dfzd/51hyRXZEWaA6CPPxsVBD4224okjKJDNgVzA7VOvB4Kp+yol5mWrFFDFprEs4UWk
         fhutI/sbVyvTikidXnXtwjrfD3foKa6SJDJrWGlmArLFvMxUpV91/6af9ktp5z5xvMUa
         cqu31ZzO8Ru49lHl0Tq4ggu1N3YpC4u74ub9Lk9wOIbn5GDC2R60lc4Td+uqDE72eNgE
         Kodw==
X-Gm-Message-State: ACrzQf2QRDPW9+zLHvj4mwkhjp6Wr4DG28qhdUXT6JpcT1JUM4g2wRJX
	dqmKV6i130aP+an2QBE21DpfkHJAF8s=
X-Google-Smtp-Source: AMsMyM6ww83quGGdomuZ/mEQgxcfa4wnyjYqRf8WsbMAWmDoyRuw5DhncsisMQv3C4rHCg9h0OHCIw==
X-Received: by 2002:a05:6870:c185:b0:137:5188:d2d7 with SMTP id h5-20020a056870c18500b001375188d2d7mr23057789oad.296.1666379618534;
        Fri, 21 Oct 2022 12:13:38 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:13:37 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 08/26] netdev: Add support for setting GCMP keys
Date: Fri, 21 Oct 2022 14:12:49 -0500
Message-Id: <20221021191307.31492-8-denkenz@gmail.com>
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
 src/netdev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 231ed9862cc5..4ca230e42b1f 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1564,12 +1564,15 @@ static bool netdev_copy_tk(uint8_t *tk_buf, const uint8_t *tk,
 {
 	switch (cipher) {
 	case CRYPTO_CIPHER_CCMP:
+	case CRYPTO_CIPHER_GCMP:
 		/*
-		 * 802.11-2016 12.8.3 Mapping PTK to CCMP keys:
+		 * 802.11-2020 12.8.3 Mapping PTK to CCMP keys:
 		 * "A STA shall use the temporal key as the CCMP key
 		 * for MPDUs between the two communicating STAs."
+		 *
+		 * Similar verbiage in 12.8.8
 		 */
-		memcpy(tk_buf, tk, 16);
+		memcpy(tk_buf, tk, crypto_cipher_key_len(cipher));
 		break;
 	case CRYPTO_CIPHER_TKIP:
 		/*
-- 
2.35.1

