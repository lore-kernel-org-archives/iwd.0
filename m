Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CFA6135
	for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 19:13:59 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1322fa1cf6fso4735936fac.6
        for <iwd@lists.linux.dev>; Fri, 21 Oct 2022 12:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrQAuSsfMGPAVlC+f2WrYfMePuNzuqG0WjHc1g3SYHA=;
        b=bs2P3FOYB+8vK6XeQyFtVx8rkU+bQxlXedU9WC8QBYhoGMzYr3v1jd99QnFrhX3Pc/
         B13MVjYfWOKwZqzLk3KDI6teHjZbbjEhLDNx8ZgsBJ6IJb8R1P6xfDb6VwxMGtpCq14p
         /tjrviPeHr55d4xwN+WDSdWT+8NqGan6hyyU0d8Ae54mp6rthD3p2kJbHDiAcNm6NOG5
         9sY/WKAUuAnE0MR4Kjv3GsmSxY7uPuIGw0483a7K2CEMUG6qSInWSO+tH+ixw2XBsr4l
         sQ9D4Q7Sg2L4MZzZwlumQgpj61kgJn0RpYelY51XB7q71VldWWMmadOs03T8UlCaang+
         0NWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrQAuSsfMGPAVlC+f2WrYfMePuNzuqG0WjHc1g3SYHA=;
        b=o6B1eKV/DG/tIwfR6VNtFNlLeYhjMSpKX41v+qn42ZTMEPBB5yeQ7QGkLaRLDFLE5i
         5daidevIZ/x96W8TBKlXM9VZ/oGUi81T8pvTcxAhykyzu87V43mQx5vs2Ly3wVvG3rbj
         +G2wHnvdOvdU9bZNpJpL7MDu98btfb46wGN77npWspd8iiteDXxWWfmnxXLp/85OB+UQ
         0XQDkJ5aInBvm2jODG3S5mJPTLyb5t2XLDNAz9LtRbnO8Df0fJj8VAWvVK4oW5bGZFz8
         TjJFJAhBeOnRRpDVsN4/5Rc5avjXZjpcPNxGfmdOTa0DxkNAmQunanycFkj+cAJJ7ViW
         EcEg==
X-Gm-Message-State: ACrzQf22hRS3Zr0lCzT0V0+uOXgqgICjhee1FogprEjbqCzzD9D6pAZD
	S0uzdzHCY2YqNmHDMSXIAb6VHik5S9Q=
X-Google-Smtp-Source: AMsMyM4PXYmyZ+3Zi5YIx2clb3UXlOQyg5T9juvPEfXXIkJSkgEpuTylDYvJlgPOBSKLe1pq8Yzx8w==
X-Received: by 2002:a05:6871:453:b0:132:259a:b125 with SMTP id e19-20020a056871045300b00132259ab125mr13490289oag.248.1666379639127;
        Fri, 21 Oct 2022 12:13:59 -0700 (PDT)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id e6-20020a056870d10600b0010d7242b623sm10675546oac.21.2022.10.21.12.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 12:13:58 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 20/26] wiphy: Support GCMP|CCMP-256 cipher suites
Date: Fri, 21 Oct 2022 14:13:01 -0500
Message-Id: <20221021191307.31492-20-denkenz@gmail.com>
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
 src/wiphy.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index f0451b60416e..76f1ba7cfc04 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -150,6 +150,12 @@ enum ie_rsn_cipher_suite wiphy_select_cipher(struct wiphy *wiphy, uint16_t mask)
 
 	mask &= wiphy->supported_ciphers;
 
+	if (mask & IE_RSN_CIPHER_SUITE_GCMP_256)
+		return IE_RSN_CIPHER_SUITE_GCMP_256;
+
+	if (mask & IE_RSN_CIPHER_SUITE_CCMP_256)
+		return IE_RSN_CIPHER_SUITE_CCMP_256;
+
 	if (mask & IE_RSN_CIPHER_SUITE_GCMP)
 		return IE_RSN_CIPHER_SUITE_GCMP;
 
@@ -1239,6 +1245,14 @@ static void parse_supported_ciphers(struct wiphy *wiphy, const void *data,
 		case CRYPTO_CIPHER_GCMP:
 			wiphy->supported_ciphers |= IE_RSN_CIPHER_SUITE_GCMP;
 			break;
+		case CRYPTO_CIPHER_GCMP_256:
+			wiphy->supported_ciphers |=
+				IE_RSN_CIPHER_SUITE_GCMP_256;
+			break;
+		case CRYPTO_CIPHER_CCMP_256:
+			wiphy->supported_ciphers |=
+				IE_RSN_CIPHER_SUITE_CCMP_256;
+			break;
 		default:	/* TODO: Support other ciphers */
 			break;
 		}
-- 
2.35.1

