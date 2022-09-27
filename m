Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351C34A28
	for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 19:47:47 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id d10so9473262pfh.6
        for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 12:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=wOORjAZ9TlhOqcxQhnHkMWVhnhNntebBGs31ZyNus2w=;
        b=ITTukxXRPSqHHnIWL2UqWeI8BRYL+5umyENoOgNYPVOQBkHl0pEmx5V3MSFQTrho+u
         k2EkxPSPc5bhG4dAAV/aVJE2wnPjr38EAqmHJLCUIA3kR4DOBeix4l2OoO/xIUbMLwW+
         E7HyWVJ3RvmEER+62vkOL+jHv68YU6dP2Z1p0vRZ53eaB1dGlWE5lwULE733B0MYkLf2
         StEoWLwXCg/Wd/w6ScFVfRCvzQZD3tU3HjvNKXYM+PsWqlrWWBXlU/5Ig1XdS0wuCP2p
         uQHgyb+k/KqcsRjeoc4suXni71z6iyJMESy9z4qW5Zt5cJJt1p4Mxm3cJkHypr8IbOux
         fFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wOORjAZ9TlhOqcxQhnHkMWVhnhNntebBGs31ZyNus2w=;
        b=lagoiZXiapMwtHg2vlMsofHZ7M6c+tceXk5DRjoR43yerhgzrQoq/R50J6d08BPDQ7
         JUGsOdHXk7DvWG5lbLzC5UqdA89hquPkxYq2NNa2ECzQqWdwMnJMKUOQboZbvyqSvUdN
         Hga6RW54vN3mTUFp5+BvUdLe+vSIweU/kbYXz7AGQOUEnoCvGEoUzc8pJ3Rsr1bMaJjJ
         DYKhbkHU8lqvgoEbFADboQX/haDwf/JmoS9uZRdWUhGashmcDZ9tHXSv+5uGkJWWx+or
         xJ0wc6n8A+ChioycQpaaAyouwRHZF3shR51A+5KRq06r8o5VCEuGzAy9DdPBNgGRHUrq
         6Txw==
X-Gm-Message-State: ACrzQf0FKfGIkNqICngGI4ko9NOS92xhLzdcTP0VClORw/oP7HFi7GDx
	RqpvVU3U6Ro5bEqMkkoZllU1kJhfX1g=
X-Google-Smtp-Source: AMsMyM6YVBW4z0T3sI+VCH4xvfEv9uhBr3gj0taSoUlrM9NSoUWclFOPH6CZCKOP2DHDNKuNpqvjNA==
X-Received: by 2002:a05:6a00:854:b0:542:4254:17f6 with SMTP id q20-20020a056a00085400b00542425417f6mr30623261pfk.47.1664308066418;
        Tue, 27 Sep 2022 12:47:46 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id b12-20020a1709027e0c00b00176a2d23d1asm2033145plm.56.2022.09.27.12.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:47:46 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v6 06/11] ft: update action response parsing to include header
Date: Tue, 27 Sep 2022 12:47:26 -0700
Message-Id: <20220927194731.269732-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220927194731.269732-1-prestwoj@gmail.com>
References: <20220927194731.269732-1-prestwoj@gmail.com>
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
index fc9111bc..de628941 100644
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

