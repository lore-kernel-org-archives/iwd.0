Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0532F2E
	for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 22:08:15 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id 78so10491737pgb.13
        for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 15:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=jGcqJ1aeluPEWtm41rf9y65MKWG/RtwIWujY9JdwMZM=;
        b=U8hoVSQO3Vb4fdpIYB2i9TEgUcQc0N+K53limzcTLN2C+o/9JTFnXSg2w5Y72EZbmy
         JSsB+1D0/EYgLsJ3RpEzlO1S+d2XkXEj3eQfFxZ0YDjJ85BDp6USOUesIamyPLk/MVlp
         FsePDLhpBpJpkuyrst3oV42Z9lKf6OQ2FsNI49JsjZUwjScPLhlveMMtmMfJJ5yyb/V0
         E6vnJ18TSKKNVAR/8JrU/Yc+l/ObxyxZfN/yz4w1nNXmJWhvwjQa+kY2GQ8LjdioGxfw
         /9wOS5VFKa3o7KAHZ13/J/0gxU815q9dHOlB/wDC6co2HJBl6SmAa8SgwpEjypQVXRMP
         vxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=jGcqJ1aeluPEWtm41rf9y65MKWG/RtwIWujY9JdwMZM=;
        b=S0iB8eVNlkDbTUv21SBLACG+U5q3n7tJd+kuZIlfYYYtFpb0+sGLvhfSZE+edrXcqD
         0gqPTIcHTSbEVB3HxUrpit+Qgt5KnD1fQ5AcvPSGph+vPyQfH38T/WNJxaLBchTP4War
         mkD+xlmd8bBORyO4DEQtGjvQHCF2fl7TAR4r34gDdo0DIzXdvy375KeYIQ2qHhbvHl7N
         S8JN/S+pLc8eoq6/QuSoW2JbZePRR3uxsDWZTEoXH1T5w4zIOeVxoClyZNzgFv0f8Fs8
         tFFMwv6C7P8wPnrixt06eapgf+Vyv+jDMnm9gx23WkmSYVcDUk9P/bJzs+1o9dIV93Gb
         YHiw==
X-Gm-Message-State: ACrzQf0nM0oFkYHmRdAEtctwqfPgZ88uCZ+6/5DW9zBpbNX/Zwy1W7Xs
	FC9i1/wgUDgCDy/Kti68JCT9Oijab7E=
X-Google-Smtp-Source: AMsMyM4QQyucUEVI1wqzSae2FHvwb7rrHAst1QyUHyHnOeFlkz6dZ9cPHJE4myn/ZzV0b6J++ikZJw==
X-Received: by 2002:a05:6a00:808:b0:54c:40da:74f3 with SMTP id m8-20020a056a00080800b0054c40da74f3mr5670615pfk.62.1663884495188;
        Thu, 22 Sep 2022 15:08:15 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7968f000000b005386162bc2asm4980448pfk.92.2022.09.22.15.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 15:08:14 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 06/11] ft: update action response parsing to include header
Date: Thu, 22 Sep 2022 15:08:04 -0700
Message-Id: <20220922220809.862022-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220922220809.862022-1-prestwoj@gmail.com>
References: <20220922220809.862022-1-prestwoj@gmail.com>
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
index 7234306c..4005e8b6 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -579,13 +579,18 @@ int ft_over_ds_parse_action_response(const uint8_t *frame, size_t frame_len,
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
@@ -597,6 +602,9 @@ int ft_over_ds_parse_action_response(const uint8_t *frame, size_t frame_len,
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

