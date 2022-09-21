Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D28257A
	for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 22:32:07 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so286134pjm.1
        for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 15:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6v5bWgU3uVCAZEE3RuWrDgRmuP32YgwJtW8xNHZikIE=;
        b=SZX+WtAwVB1Jf2w8Rh6xlGtS7RzKWgkxkMJWlcA2hqtmVEJ3lT1XYBrfzeyqUpd1n8
         lxo7M2wydomVHNmD6dxr2ebUd/lEyRv5DVWhk6ox1On2ltxPE3CPxDRbgNVIr/DvxxLg
         /h2d87QrpmMwQmgcYXH3Xxw9OE0vi/OU3YaLmJPZIyFx/CqbtlAS6Bdj43HTovGPbkwM
         WVs/sDNKuECDeqirWGKSSYSz3t4CVqBfjW0QrPWId0qRjafwqDlAGns/gIpccDplurMz
         WyLXI2GnYsKBrrTS6U17HPJXGygfVtdRWV/6Wu1ZgxgMunxUFPGN26oetC/Pr0ya4f2U
         elRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6v5bWgU3uVCAZEE3RuWrDgRmuP32YgwJtW8xNHZikIE=;
        b=f1p503m1PUF5G+u9mIzGgsOciwqnKc5BHHuYEvp0jUyuHg5/rACOjzMfNUGgc3BMdx
         U5je3M7zG3CoJarqtm7s+eSIc6pmg+b/61WqZIAByzWiIuXqFsMe4Du32L5TYiNmLLDl
         P9fn3gVCDN2ml99pKNRCaWDUuEMlnqkrf+Tz5MliBnyVvhhj92P5ZkHAnh8Dt70KmqGN
         Fy0D09j6fHbrxDoPUg5DpCP2gRL2zNnoax8vternJz9Rvg5Cz7NK4oKFIgQCtuOC34dZ
         uO//Fo1l1XMZrLINXXSXoJNURtwL2ihI7zqhKv1UH89L0E2/2RAbGrr6COEnsR5ki8Fa
         6APQ==
X-Gm-Message-State: ACrzQf2bUlhXhrJ7CcGH4+WyhtSLaTQR0JmjUXbhnRxfECLaX2p9F8/8
	k0CvFVgVJ/00Ac400G4zEeoYWF/PKto=
X-Google-Smtp-Source: AMsMyM7dYtEzif9zmyl0hcVDP0i3NMJOIT6Y3BbDDT+SvGKwvGOmXDlMke17TBCORFjRc/jDaE+qEw==
X-Received: by 2002:a17:902:ebd2:b0:172:8eee:80f5 with SMTP id p18-20020a170902ebd200b001728eee80f5mr340507plg.9.1663799526406;
        Wed, 21 Sep 2022 15:32:06 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id r10-20020a63e50a000000b00438c0571456sm2393135pgh.24.2022.09.21.15.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:32:06 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 10/15] ft: update action response parsing to include header
Date: Wed, 21 Sep 2022 15:31:53 -0700
Message-Id: <20220921223158.704658-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220921223158.704658-1-prestwoj@gmail.com>
References: <20220921223158.704658-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now the full action frame including the header is provided to ft
which breaks the existing parser since it assumes the buffer starts
at the body of the message.
---
 src/ft.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/ft.c b/src/ft.c
index db060839..613c6477 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -580,13 +580,18 @@ int ft_over_ds_parse_action_response(const uint8_t *frame, size_t frame_len,
 					const uint8_t **ies_out,
 					size_t *ies_len)
 {
+	struct mmpdu_header *hdr = (struct mmpdu_header *)frame;
+	size_t hdr_len = mmpdu_header_len(hdr);
 	uint16_t status;
 	const uint8_t *aa;
 	const uint8_t *spa;
 
-	if (frame_len < 16)
+	if (frame_len < hdr_len + 16)
 		return -EINVAL;
 
+	frame += hdr_len;
+	frame_len -= hdr_len;
+
 	/* Category FT */
 	if (frame[0] != 6)
 		return -EINVAL;
@@ -598,6 +603,9 @@ int ft_over_ds_parse_action_response(const uint8_t *frame, size_t frame_len,
 	spa = frame + 2;
 	aa = frame + 8;
 
+	if (memcmp(spa, hdr->address_1, 6))
+		return -EINVAL;
+
 	status = l_get_le16(frame + 14);
 	if (status != 0)
 		return (int)status;
-- 
2.34.3

