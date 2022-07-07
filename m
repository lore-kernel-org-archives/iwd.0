Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC022563
	for <iwd@lists.linux.dev>; Thu,  7 Jul 2022 17:57:27 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id a15so20875657pfv.13
        for <iwd@lists.linux.dev>; Thu, 07 Jul 2022 10:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mYEunOFTFC/n9/8Um0rXVxJFt1Z1Q3f5kP2ThqZP93U=;
        b=q3zOTw+FN+14ilAPxtuzoBQzUeQHOqTyQEmSba93kzMXRlMbBqDZs10favaqY+SDVR
         VE0Rhu48tRDtNnmK69m5ImjVUVjCxkucQnI/CAZNe6ECGLCopKP5JPuoO20UCBVW086M
         Jm96ldhM5ztFB0bvKy8IVLp1/uUxgO6jT2e6kyUyDsYwUu9a2xPtRjhVFeNSit8sowYJ
         Mdg6QOVKeONNFItBfER5fdjXGX21YWY97VWlRVbFtgUFCzXiq+wuTxXxx1JLOcPg7MOU
         HUZ01o2Hj/t/NgEkzV7xoooS3DMoV+cPKdrsbnDWiJMI8b2o1TVw28bCmHpOUaR6Bejn
         03uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mYEunOFTFC/n9/8Um0rXVxJFt1Z1Q3f5kP2ThqZP93U=;
        b=X2uBT22NNw79Av0EMR9TwQE8gbmF5OCSLnYz1tdwJlxo35jHFDy5mdF8CYIQYTO0JD
         B/o1o3hTP01hSYpqH3jbsK8MWpwkAj/E0To9C1SfZ0XmwCJtfV7Qj3Z1vCL012xyvgGH
         fuxPyse1dQhnZGPV/8oCMMJCgCTvCYWapZwqE1XKoyrZjLgqv05WkT43BfBwXuvwbMpf
         0vdcEVG8sE743fV0Y0VXmSDxXkBzpHn4hxIqq7Gk+mEaBKw+yLbq3TIf2DRw8p9F9LJG
         pf1zZrrYFgb78dCiBO8HY5aNR0nguZLWqxxWn+cnEorLhB+WP29RlDi/WHYoFomwNtQa
         UoKA==
X-Gm-Message-State: AJIora9pc7duF6ygLAV7e0IshYqDx3RXCieM0o71DUBHpAM6ooa4LsZt
	L19UqEqdnLwtBQBegFNWBlFEzhtSFFI=
X-Google-Smtp-Source: AGRyM1tqJqqHXzRS6kbJzv2q2Fele/3oM3HKHWC9dFKLMRCfM/OtzJ0w7keX3beXHFAogToY6OfxAA==
X-Received: by 2002:a17:90b:17cb:b0:1ec:9d52:46f7 with SMTP id me11-20020a17090b17cb00b001ec9d5246f7mr6493869pjb.221.1657216646663;
        Thu, 07 Jul 2022 10:57:26 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b001618b70dcc9sm28855223plg.101.2022.07.07.10.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:57:25 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 06/14] client: check NULL return for DPP cmd_show
Date: Thu,  7 Jul 2022 10:55:03 -0700
Message-Id: <20220707175511.224597-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220707175511.224597-1-prestwoj@gmail.com>
References: <20220707175511.224597-1-prestwoj@gmail.com>
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

