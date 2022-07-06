Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DB62F21
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 21:31:04 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id g126so1034646pfb.3
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 14:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mYEunOFTFC/n9/8Um0rXVxJFt1Z1Q3f5kP2ThqZP93U=;
        b=GASr2I7+arOaNehQb6vH6lnXGNgAxWmUN0+6ym1VY1imG4eZrRjtnuUgk5grYIG4XU
         7vn2Kd6XtymwUljaIxwgYUU+VTtBdrGoLuwQkDaTerNvK72a2kfgMMqorjrVdqG7M8cO
         Uassp1QFrCDekY+1z9Tv7lUfldbTwBso1znobY65GUFzM+7Kjh25bbYOc13z9QQXqUx4
         5KXdYAV8VqSoUB8PV+St5afYcUKb3roboNY3eTye8gHGLrw/jFKP7oYUvDCU9SvYVD0x
         huoqThTvlklP49TtUi5zmWmv5c+5Bh0RGf9xW9eqvfBl4RA1eCmNC167nhNGXbA0wMeq
         +3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mYEunOFTFC/n9/8Um0rXVxJFt1Z1Q3f5kP2ThqZP93U=;
        b=AOGcqUNsgxhunS5clFTYBRT80AYysCXBcvUx966LOYO22r4bWF9gRLAa+FWP/l91OY
         GxYvmCnsqOQF0vZfkef4qtj+5zpK+MjRjASD8hDMsG1R5KYSRWKQmta4m95oBUtvf7OM
         vjq+ya7+lCtio9KarX6OMIOw7az9p7KGhKdCWsH2P6ONr4HX/ZLSeSYDJMgQ7xGc8ov3
         Dxd+GAys+wI9CwsCIjJTsEd3osI6+/N8JZIIX5UdTWPIKcL3DwSlOgKlyDFVrDswGV+e
         Y+7I3FhOKqOnzSxBIiwgY43ZoZqZPewxydMkXGsg7IS9VUq10a24S9nBFe3i2n6A+kzO
         F6WQ==
X-Gm-Message-State: AJIora9z2KJ49ZO40sRc4qdO6WXBrgB3vJSiQZ2rTKPfKcIcCQKPJgK3
	k3nllGPhsm6IpZVcs7EHZrXxuY3mI7E=
X-Google-Smtp-Source: AGRyM1sOkJaBl05H9wg8c+VdB+wBgmf7YT717ADAYQNg04+YTN9AmnsWwBmpfQlSxluh8J4amut42Q==
X-Received: by 2002:a63:8341:0:b0:412:a34a:b9d3 with SMTP id h62-20020a638341000000b00412a34ab9d3mr3504829pge.437.1657143064205;
        Wed, 06 Jul 2022 14:31:04 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id v6-20020aa799c6000000b00527f5aee1a4sm15347609pfi.33.2022.07.06.14.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:31:03 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 06/14] client: check NULL return for DPP cmd_show
Date: Wed,  6 Jul 2022 14:28:43 -0700
Message-Id: <20220706212851.92685-6-prestwoj@gmail.com>
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

If the DPP interface goes away this could return NULL which was
unchecked. Caught by static analysis.
---
 client/dpp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/client/dpp.c b/client/dpp.c
index cd05a33b..a659f545 100644
--- a/client/dpp.c
+++ b/client/dpp.c
@@ -284,6 +284,11 @@ static enum cmd_status cmd_show(const char *device_name,
 			device_proxy_find(device_name, IWD_DPP_INTERFACE);
 	char *caption = l_strdup_printf("%s: %s", "DPP", device_name);
 
+	if (!proxy) {
+		display("No DPP interface on device: '%s'\n", device_name);
+		return CMD_STATUS_INVALID_VALUE;
+	}
+
 	proxy_properties_display(proxy, caption, MARGIN, 20, 47);
 	l_free(caption);
 
-- 
2.34.1

