Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D942F36
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 20:23:55 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so3197033pjk.2
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 13:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D0Xu1j3/v1iVnHJHhvjA02lmslu221Pog/v2zCTo7rE=;
        b=XRsG8Rer6uiH/I+C+w14YTme8P6hQndhU1jJj2stmKyZlK8u4yO6ffPodKHzOh2Nkn
         4CSF1NTLuUj0PSxL3g2K54DKKP5edViul9do2gIZDdY2Plg0RKvGh8hAKugpnJpqC+Xg
         mfcfbNXpQvK1vV8qLtF/Y3rN5uoGfB4ISD5mm6VLhRu/sFZjPWvxmQxmWffjDP0bW/or
         iRuw3rArSBTedd3NBk8dBSjLHsvfv4aiTy/u01Jl/OmKYohPr7ZsVCqSIzdJZ4CbFd6b
         WHCNlrMXPOtaubzC5nDH0R/tCImNJQBO5twTFqdCTn7zMFeqcgNScGy9RmnGxEmbA1Cb
         cnoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D0Xu1j3/v1iVnHJHhvjA02lmslu221Pog/v2zCTo7rE=;
        b=MS5TK4cZsn0tqtwZmBSlF28e9GI4Re+A5F6DAj0dGWZH1nQNpTlUi9r1nlY5uIL+bZ
         YHyD5Pn+JMWHAjEWbpWLm2UM2Md7JU4jwTsJqUBDTF4Lr3bff2EjEM51CtvCrY/SEmkK
         Hjg5q2d4ISGzHfkv0DN9p1Gp/HPIUNUctBE8MQ5IxmCC/NWA+9jSQwDruj9kUE8/XBfY
         Z/MixI0cp/OTkAzTnnWGc8NqjAyYSk+XGZf+yw6RSYM0WFfqkY9hbcv+x9JgMJyBLWI2
         Gkacsz+HiBxhsDehRWVDDVRjFeLu8qeNtZHxhOXMD6nj2sngRg7vOrNGLawU0K5d0D73
         enwQ==
X-Gm-Message-State: ACrzQf1PtXBCP1O1JyNve5VTcXbfu9dG+XZi7gvoEyJT349HEuFkaBPZ
	HsywgbBj9OhMZO6ko9dt0dwpC/Y7xXzekQ==
X-Google-Smtp-Source: AMsMyM69mZOq+Bl51KrukCM3nidOkNVyZ007aIyUQQfhyRqf5kzWOHzPtxzVO9926+CjkCLFCiootw==
X-Received: by 2002:a17:902:e74f:b0:186:a981:2334 with SMTP id p15-20020a170902e74f00b00186a9812334mr26096417plf.88.1667420634664;
        Wed, 02 Nov 2022 13:23:54 -0700 (PDT)
Received: from pvlnv.. ([2a09:bac1:36a0:80::242:2a])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902d50900b00174c235e1fdsm8752720plg.199.2022.11.02.13.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:23:54 -0700 (PDT)
From: Neehar Vijay <env252525@gmail.com>
To: iwd@lists.linux.dev
Cc: Neehar Vijay <env252525@gmail.com>
Subject: [PATCH v2 1/2] client: fix extra newlines in station show
Date: Thu,  3 Nov 2022 01:52:57 +0530
Message-Id: <20221102202258.289396-1-env252525@gmail.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change removes duplicate calls to display_table_footer(), in
station show.

Before this change, the bug caused an extra newline to be output every
time the table updated. This only occurred when the network was
disconnected.

    $ iwctl
    [iwd]# station wlan0 show
---
 client/station.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/client/station.c b/client/station.c
index b070807b..1d958ef2 100644
--- a/client/station.c
+++ b/client/station.c
@@ -217,15 +217,9 @@ static void display_station(const char *device_name,
 			47, network_get_name(station->connected_network));
 
 		display_addresses(device_name);
-
-		/*
-		 * If connected the diagnostic interface is presumably up so
-		 * don't add the table footer just yet.
-		 */
-		return;
 	}
 
-	display_table_footer();
+	/* The table footer is handled by cmd_show. */
 }
 
 static void display_station_inline(const char *margin, const void *data)
-- 
2.38.1

