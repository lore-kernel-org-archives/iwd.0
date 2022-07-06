Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3732F21
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 22:21:32 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id g4so15183544pgc.1
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 15:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mYEunOFTFC/n9/8Um0rXVxJFt1Z1Q3f5kP2ThqZP93U=;
        b=hFSmBbai6lDfofr+YHMBOvpbWBcUZdgUgQ8cJecTAqQY6QmHfv8CAnRLfiZUg0ZOmv
         nKEVVUTLDhnZXBuBl7xebni4gll3KVM/dAC3Mgch8S9iV8FQPqLXKa+EVwwejQCZErIB
         Q3lMXeZLRfrxFHlkpO6cOKXFAfiYC9v3jz3ncwkWlfobhbt014Q2wnfRkB6GgwAwVd/q
         1+/Dz8SbOVtF87HGmi9UCfky5x3TBql10eRay60w8tq20rtx42oAyxw9eh8AMByhIuuu
         ikNUXy1GWWswVyBgXJr0wEsEOwufK9I+3FHHJQqlY6kjN5CVuwSNWb8usxcbAzkOmxSj
         oThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mYEunOFTFC/n9/8Um0rXVxJFt1Z1Q3f5kP2ThqZP93U=;
        b=yhnplOM5FdXQ+v5YkdEAawn6n4KANWOmQTrYsLTDXt6fLdfY5JwDWNSkIsng6zwsEI
         LyMifHRtUXGYl6F8RLocPhp58YB3NZYPZmSyfFOaZEsYGV+xA+R33X+XHM016SBCZkuk
         L3kbxtIJSDS6Jleg2xjFQAhzXWo+RA0W6KIWsKN/RGTz1g+M3IYNUUe8GOWNdr5gQLoI
         Pm61ut4vWi2+3hMPhey2+40h7wE94CjEdYGHfMhnk9BOZbjmeFJdok2fpnkkJp4KXCd8
         S7yveO5uD3Ob4X86qPcTiHIVpknYCNPxrh2S/H64izqLnMTDGz0UFa1zzFm4AFSk0d5s
         rexw==
X-Gm-Message-State: AJIora8Nhn5UoC7Dn9f6EOe1z+1Aacpb9+uCFu1f1AY1JBJIus8P5S5o
	VJaUdmAeAzyJaphXLKLKvzqEy6xkjkE=
X-Google-Smtp-Source: AGRyM1sp6vWcLMlzjE8rG0rHdaPaWtB0cVUCQ3e0qSWnpfQ8k5sZf0ssBceNaK+/fFom7GC2tARaRg==
X-Received: by 2002:a17:90a:4e05:b0:1ec:8de4:1dd5 with SMTP id n5-20020a17090a4e0500b001ec8de41dd5mr1071738pjh.242.1657146091909;
        Wed, 06 Jul 2022 15:21:31 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e80900b0016a163d1cd5sm26517696plg.253.2022.07.06.15.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:21:31 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 06/14] client: check NULL return for DPP cmd_show
Date: Wed,  6 Jul 2022 15:18:59 -0700
Message-Id: <20220706221907.126408-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706221907.126408-1-prestwoj@gmail.com>
References: <20220706221907.126408-1-prestwoj@gmail.com>
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

