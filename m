Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE581B8F4
	for <iwd@lists.linux.dev>; Wed, 21 Jun 2023 19:36:40 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-3fde8e4d321so36273401cf.2
        for <iwd@lists.linux.dev>; Wed, 21 Jun 2023 12:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687376199; x=1689968199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wZxGHBIKVGSt7S+e70HXWyZEWy0Ck1RSr4qvxSrgcTg=;
        b=C3Or4XF1LojwaFUdQq1Cu3j9OhgV13pefLvIo4vu3ryxBlRQqaYqPy61MbG534tv53
         c2P5s4ZVTsxckCArglcxekr4vIyWzVLClXUdg82usAHD58RAzXXgl6xVF1QCw0oLMYJx
         hqHxCHF2jpee3yqDG6v1I8VS2EEIH0KHCtySAI91l1YqFEF/7NHjYsJKkPbEIJa7LdD9
         WbO0u4P5lxC/O6Aam7WiLgh+fSe3ptWbnvzWDWRA1F/+yKCJrBB5pIjX1hSJ996uPCp1
         9CKXExyxgOc6Gll0iO4V0xakSB09WP4WE1jPh+LZk/MBYwWlYba3Rv30r2h8rTt/nWgB
         PxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687376199; x=1689968199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZxGHBIKVGSt7S+e70HXWyZEWy0Ck1RSr4qvxSrgcTg=;
        b=Tapq2Ktt2z4O68yi+DR082OQCceV6aUGcOZdt2BHdHtfR9s7yI1peoCuGtMphdIxTv
         U3jCPQItUXTuuh+PuEnWiqUZ7Wxe9Q7EGDmfw8gfqRuIHzCoOcLNyGvReGqfZ2XLNdDK
         3I3BxROSdePIdehxs/kMPcaXvTEdykhL/cnhyC5s0mmguyQ1W7bKfiVIqu4svBAIBCPp
         W9lyjieba0UAumgGpgJcvYf5iP4359hY+A/dM8OgDDNzcWWKHAcmGqY2G3kRbkDcmlxI
         43D72lOcMEomDZnsTGRx5ccX7sfdVn3WMnu8YbF8vQ6G5ImC3u1eYLYRkTphRvJoapQU
         ol/g==
X-Gm-Message-State: AC+VfDxSiMVF8LJj/S7VU10ZL0jKwkGqH2GighQGcXCulVM/8J4xM/0B
	PqLpcAPjLUruFS4uVd8hvmQLHTk4JYfJBw==
X-Google-Smtp-Source: ACHHUZ5SwikFU/ybSb8bTYP9v2DAL0yUUOqc6YSFy/+RRBDvCXqxJE0XUger6a+JF2Vo2yih20SS4A==
X-Received: by 2002:ad4:5d62:0:b0:62f:f23e:14fe with SMTP id fn2-20020ad45d62000000b0062ff23e14femr164088qvb.20.1687376198926;
        Wed, 21 Jun 2023 12:36:38 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id c4-20020a0ca9c4000000b00631eb444e6esm2893689qvb.51.2023.06.21.12.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:36:38 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] ft: add debug prints for FT-over-DS
Date: Wed, 21 Jun 2023 12:36:33 -0700
Message-Id: <20230621193633.898045-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is consistent with the over-Air path, and makes it clear when
reading the logs if over-DS was used, if there was a response frame,
and if the frame failed to parse in some way.
---
 src/ft.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index e223484b..c51a1288 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -825,15 +825,21 @@ void __ft_rx_action(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
 
 	ret = ft_over_ds_parse_action_response(frame, frame_len, &spa, &aa,
 						&ies, &ies_len);
-	if (ret != 0)
+	if (ret != 0) {
+		l_debug("Could not parse action response");
 		return;
+	}
 
 	info = ft_info_find(ifindex, aa);
-	if (!info)
+	if (!info) {
+		l_debug("No FT info found for BSS "MAC, MAC_STR(aa));
 		return;
+	}
 
-	if (!ft_parse_ies(info, hs, ies, ies_len))
+	if (!ft_parse_ies(info, hs, ies, ies_len)) {
+		l_debug("Could not parse action response IEs");
 		goto ft_error;
+	}
 
 	info->parsed = true;
 
@@ -931,6 +937,8 @@ static bool ft_send_action(struct wiphy_radio_work_item *work)
 	memcpy(ft_req + 2, info->spa, 6);
 	memcpy(ft_req + 8, info->aa, 6);
 
+	l_debug("");
+
 	if (!ft_build_authenticate_ies(hs, hs->supplicant_ocvc, info->snonce,
 					ies, &len))
 		goto failed;
-- 
2.25.1

