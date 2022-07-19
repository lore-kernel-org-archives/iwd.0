Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7AB539F
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 18:58:05 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id y141so14431346pfb.7
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 11:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7rTgQX2BLtDwl0a6votul3jNEOBhBycdyWui9PbU/aQ=;
        b=qAtB/WzksmdCyUbGhjkHSk3Nv0AOFJ4Q5Bc3eFOCr84Tv8W2ZvMD3QrI7jo2TVSxF/
         HPkjvc6GC95lQBQtNTn4V1eG/b1juLoE5bzgI+K6Ilb6zwJph455mqwR6T4aOJRF3EBp
         gI6N8N4D7ixs9lYGqn8MFomVVuX/l7Awj23bWH0EebscxMovegC39okE0tv4S6CwXREc
         KIbjcKaSWSImx5ZJY2HfK+Zpd0zh3A6QN4F7JR35uTtZcbUX4xWtgngg2xYUm7uwW41v
         FpT3KgbtKlWRgZn2A7HEELDqt8/ppnuE7j5MncAtD5u63Z34q5si+PtRiqFznUeGIpt7
         pUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7rTgQX2BLtDwl0a6votul3jNEOBhBycdyWui9PbU/aQ=;
        b=E6b5mzgJ/EIDxyPuFoubf3H4XDKlAqYnS/Q+ABKmoluZJQ76lUXGuPRVxojYKAeu40
         k9BP4SvW8YBE+0/CIxZt0eWHXCKpY8CFGllxyv1TxCqK99j1yjfX5btqI6MRbqwI4fpl
         wT4MXV1aZbdjLai+FoRKQ9HFHRG6R/r4l5nA+FB7orZjQfL3xYvRdzfa1fMYwdy7dtC+
         4gDIYRwy2e7UGd2XCR20tuXcblVtjfibkKiNtzx9wHesCOTXVu9pnwXPcByEDEk6X5Qo
         eh5hrPcbiGgJhnJcS5sPPCC3hj8B72780UlpE8rHd/bxRbOzNQzC7sRkucHmHmXvzNhn
         RQMQ==
X-Gm-Message-State: AJIora+4IBxdyYdg3Yu1G+hnGIoLvJ03Ey+qzqbeCP7AwDTUZ64ZVvcY
	KKFFMUpcYAPqTB6Pg8FGybx1q2n7dQc=
X-Google-Smtp-Source: AGRyM1sQDxqJdJZcVLgn70FF7ENkU5ozoyk9QH0xJwY09CrOhzoJcCHQ9TUm3HxQLuti1ZjGQZW6+Q==
X-Received: by 2002:a05:6a00:893:b0:528:646f:528a with SMTP id q19-20020a056a00089300b00528646f528amr34460183pfj.21.1658257084634;
        Tue, 19 Jul 2022 11:58:04 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b0016c68b56be7sm11937785plg.158.2022.07.19.11.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:58:04 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 11/12] wiphy: use HE element for data rate estimation
Date: Tue, 19 Jul 2022 11:55:43 -0700
Message-Id: <20220719185544.456727-11-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220719185544.456727-1-prestwoj@gmail.com>
References: <20220719185544.456727-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an HE element is found, prefer using this for the rate estimation
since it will likely yield the fastest rate.
---
 src/wiphy.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index f83353ed..cb4be66c 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -788,6 +788,7 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 	const void *vht_operation = NULL;
 	const void *ht_capabilities = NULL;
 	const void *ht_operation = NULL;
+	const void *he_capabilities = NULL;
 	const struct band *bandp;
 	enum band_freq band;
 
@@ -847,11 +848,22 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 
 			vht_operation = iter.data - 2;
 			break;
+		case IE_TYPE_HE_CAPABILITIES:
+			if (iter.len < 21)
+				return -EBADMSG;
+
+			he_capabilities = iter.data - 2;
+			break;
 		default:
 			break;
 		}
 	}
 
+	if (!band_estimate_he_rx_rate(bandp, he_capabilities,
+					bss->signal_strength / 100,
+					out_data_rate))
+		return 0;
+
 	if (!band_estimate_vht_rx_rate(bandp, vht_capabilities, vht_operation,
 					ht_capabilities, ht_operation,
 					bss->signal_strength / 100,
-- 
2.34.1

