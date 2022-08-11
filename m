Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A544A4690
	for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 17:59:06 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id r22so15339881pgm.5
        for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=JmingVSDa6aIkhua9EWpczKHECzAoIMQ6GHEYWePYuA=;
        b=YxTv9vc0wNwpMurG8ZgwqPO6Vu3TJTZfw7kMecTOMKdppRiM3P8UaKC856W3vdFlm8
         RJZ1w80N6lh22wbWyr5tdL7tHLoQzqOuIsBY5WJdUqdh3idNAPMui/JfElpu7S6ddDvx
         uM8IWuellbKTDmXc2OXeZtXNGkWRu9joPNKFnbH3m2AnzxQ/jKHWxAXvrmUEsci2wz9S
         6513miJ9Fp9RWVFr/DdSE9+UOvvEy6ThIT/2JRsRC6e0ccyeM8yFhwFuLeKwS5iRw6Yt
         aR87N25p/EUBs4Dmgjh9IfNzLP7qxhK+lvjNqdOm/PAuYaDvD6JRqC/wvG8Vz6UKECpF
         gcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=JmingVSDa6aIkhua9EWpczKHECzAoIMQ6GHEYWePYuA=;
        b=S6Ks6nTgIclWYBJtsxoycpz9qRGa7Oxea1fMLaH9CpnDLydI3UeWjVBO7FBTlKPIo1
         SfUYnp2cRlzxYNwoafUxhH9EHZoWVGkTo1cAaZcQLRjhsWz7zSs8gTMmW7oLN8Wa2kFS
         0oyKPYAM3gAOzXzUCC2f6YwD9zWx/aTO/N7UH1oBIGuFsAkRCdnMygHaTWLPyceANglP
         CIPss5ZphxV5PyuvUqAIiZYayd2dXoouTbuGcBacdyzedi89iE4+WmmJMed1NQmAshf6
         NYkIOPs2gxlsJuieNmGWy35/ExMCgJEbnGAzatwzUNIleDw2f8O6KXEKT3aO0J7rtcDQ
         D4Ag==
X-Gm-Message-State: ACgBeo0hnhsq4OveyE7uH2YQ1wTjdYoE/7zJZL+CMC/2XPqp27oiLnd5
	qwiVs1JT+WLTCMln4t6y51+IwKeBVKY=
X-Google-Smtp-Source: AA6agR5S6062xokMvIhTggGUQIFEKp3uCx2hIINAHVHoXnKKdgbzCw9Z1UWPafI/CtBSkZSGhdCcQA==
X-Received: by 2002:a05:6a00:4147:b0:52d:fe84:2614 with SMTP id bv7-20020a056a00414700b0052dfe842614mr318695pfb.10.1660240745933;
        Thu, 11 Aug 2022 10:59:05 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w125-20020a626283000000b0052ab602a7d0sm4292685pfb.100.2022.08.11.10.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 10:59:05 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 5/6] client: fix station autocomplete with multiple phys
Date: Thu, 11 Aug 2022 10:58:59 -0700
Message-Id: <20220811175900.443310-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220811175900.443310-1-prestwoj@gmail.com>
References: <20220811175900.443310-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The limitations of readline required that the autocompletion choose
a 'default' device. With multiple phys this doesn't work. Now the
readline limitation has been worked around and station can look up
the device for the command completion.
---
 client/station.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/client/station.c b/client/station.c
index 90291c88..b070807b 100644
--- a/client/station.c
+++ b/client/station.c
@@ -280,7 +280,8 @@ static enum cmd_status cmd_list(const char *device_name, char **argv, int argc)
 static char *connect_cmd_arg_completion(const char *text, int state,
 					const char *device_name)
 {
-	const struct proxy_interface *device = device_get_default();
+	const struct proxy_interface *device = device_proxy_find(device_name,
+							IWD_STATION_INTERFACE);
 
 	if (!device)
 		return NULL;
-- 
2.34.3

