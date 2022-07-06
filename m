Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5F62F21
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 21:31:01 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id fz10so10248324pjb.2
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 14:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e9ieV3CILIiKWCqTQ7cPR9lgx3GxdbKLHByre30dKcA=;
        b=bVkDZpGz6VkpEBpG+5b3SHNCmpdu6bD0MtotbmZgslhYAmmS/5WSwjqgquHSjVXBAe
         qmFYjpNMiPvMVRIEWSLsiwtr9JfRYxBcPIajVj3agZv7Z+PlKRmPM/CeUeWdGecdodz5
         6CEUtTtxp1q8vnaghL9KhAqqi95J+tCv1EGVpap06+qbNXf9FnGGa437SJzCyWGbmADq
         wU+vy5ZWDCVT+ZYbT0vNU8ZdelUV2ijGO1jkLJWnMbL4BeiYcPQMpDDJANpEnQrydyNw
         0JtY1+S0e/byI/L2NtzzBusfAiVAJ+8LFGJXVLmjUVJ74aMKyVqWF1c7la0nSl2Wff7J
         kYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e9ieV3CILIiKWCqTQ7cPR9lgx3GxdbKLHByre30dKcA=;
        b=ZK7QZyvLWkFcUyhlirlQMIa4iFNrcquBVrxGp3haYtOYjuMukQPLL0JBxdpkQUhYUd
         fTAAyNee949wzpP6NPGcdeBs5XoyEawL1kSNEBIoZ4gXo0scdp8XzzF8DY3naRl6SFO3
         +DO7GVL4yOcIC3KLdZFLW9mKwgCdB8Ro5p5tJ9gzoYigSIzrzbHGBJTExqOYRKQs8kUV
         aiC20laAlYKC9PPhlGILAeOMrnm1ymJL6r4LRl3OxGE4aHcix2qJjj002wToIVzi6k4q
         S6W9+JZ+r+OGe5/FwZD85JwAyMosha6+E9uhtTOFnTWh+5Lyy62MHFvXBqt2RKxlTbNN
         RZRw==
X-Gm-Message-State: AJIora+zpWQdtSlfnEJmuBdoS/tcRa5WVswID/hpDrHFHPzePYtNN1W+
	YQiBjWejv9yBlYrOwchlYDLQksbsOd8=
X-Google-Smtp-Source: AGRyM1tqV462/M0ZXAzhvlfuWrk+cnm7yZ3Mc7b41fboqMJ6BOJYwEXONZmMDD8TULcg6RVQLkn9rA==
X-Received: by 2002:a17:903:11c9:b0:16b:8293:c599 with SMTP id q9-20020a17090311c900b0016b8293c599mr48434097plh.136.1657143060408;
        Wed, 06 Jul 2022 14:31:00 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id v6-20020aa799c6000000b00527f5aee1a4sm15347609pfi.33.2022.07.06.14.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:30:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 03/14] client: update dbus-proxy to use display_table_row
Date: Wed,  6 Jul 2022 14:28:40 -0700
Message-Id: <20220706212851.92685-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706212851.92685-1-prestwoj@gmail.com>
References: <20220706212851.92685-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 client/dbus-proxy.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
index 9f05c0e7..bbb97eb5 100644
--- a/client/dbus-proxy.c
+++ b/client/dbus-proxy.c
@@ -59,7 +59,7 @@ void proxy_properties_display(const struct proxy_interface *proxy,
 	if (!proxy->type->properties)
 		return;
 
-	display_table_header(caption, "%s%-*s  %-*s%-*s", margin,
+	display_table_header(caption, "%s%-*s  %-*s  %-*s", margin,
 				8, "Settable",
 				name_column_width, "Property",
 				value_column_width, "Value");
@@ -69,29 +69,16 @@ void proxy_properties_display(const struct proxy_interface *proxy,
 
 	for (i = 0; properties[i].name; i++) {
 		const char *str;
-		size_t len;
-		size_t j;
 
 		if (!properties[i].tostr)
 			continue;
 
 		str = properties[i].tostr(data);
-		len = str ? strlen(str) : 0;
 
-		display("%s%*s  %-*s%-.*s\n", margin,
-			8, properties[i].is_read_write ?
+		display_table_row(MARGIN, 3, 8, properties[i].is_read_write ?
 				COLOR_BOLDGRAY "       *" COLOR_OFF : "",
-			name_column_width, properties[i].name,
-			value_column_width, str ? : "");
-
-		if (len <= value_column_width)
-			continue;
-
-		/* Display remaining data */
-		for (j = value_column_width; j < len; j += value_column_width)
-			display("%s%*s  %-*s%-.*s\n", margin, 8, "",
-				name_column_width, "", value_column_width,
-				str + j);
+				name_column_width, properties[i].name,
+				value_column_width, str ? : "");
 	}
 }
 
-- 
2.34.1

