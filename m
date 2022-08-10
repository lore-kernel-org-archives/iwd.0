Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68574A02
	for <iwd@lists.linux.dev>; Wed, 10 Aug 2022 23:16:28 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id pm17so16178409pjb.3
        for <iwd@lists.linux.dev>; Wed, 10 Aug 2022 16:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=JmingVSDa6aIkhua9EWpczKHECzAoIMQ6GHEYWePYuA=;
        b=GBbsQl3w7btnER6s1nc/mPn/qzQCSciBCw2ff5xPJsiOKWwZQik7vTms48fFjoUEQ1
         JkKM0uoy5dxS+NyFWt1A7gmjIwg6tmQAKBxZuLku0+sgxDW0ve1eaW7b23wo9SVIE6+3
         JE9srU1uXK1zJdUjEKzmGpRER3LTQKgxbQwjlwjgN/efPF7mn2thVE6J/bty4mdKuKzV
         or7k6NwD8w2k8nwkfC+N9oN4wQ0NQOIgMSHf2BNbjcXBwB4Xbs2T1C2OuSDKx98MH137
         kuzwdktFGJQ4OyrwZg70KvxLgA/uZ55ARvi0N8ommLz3dwRHp+FzxMw9jsRSjGBcrZn8
         rFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=JmingVSDa6aIkhua9EWpczKHECzAoIMQ6GHEYWePYuA=;
        b=pYcDcyRlOVA2yZIbIGBAgDXHzY0ZFXQteL3UmMCsVrDoqpl/RpNvONbr78D6ePNkMf
         fA9fSxUtvhHd0VISh3KzGPPtWzYYpthvdfG3gWHPqwojotoOVWrWy7NjHgFMrAs8qOfX
         v3+rbLsdygToLb8LQweDl9fq9qs6Mfo/Xyqphwn58Fq24Mxavbf4f0V1nGrBpOOWHUit
         4Xf+2NwQX1FbYVjeqPqpWZbSIlXo9Zwx0WababQEll3MMofqAKiJs3cd5GVzlFltlDnt
         Gf0m6LmU0UkVjZ8KSvXoRJQJaQ/ns/1X4dEn6N4C69mVb8Ge6eiWm2J/WLZxvW8BaNDl
         0EDg==
X-Gm-Message-State: ACgBeo3YvW7Z9N4lsgFW/FPq1bHMBOv2D596gI+qGKYamhtj1+zuL6og
	WGKUzibG0qSqBL4iw+H5OeNtfjiLNMs=
X-Google-Smtp-Source: AA6agR7AKMsfudEWXk+skqTgBbvzdmidnwVh3JMPKwLH6iiuXJ/N2sXTJS7nIu8B5mibO6kJqEne4w==
X-Received: by 2002:a17:90b:1d02:b0:1f5:8526:303 with SMTP id on2-20020a17090b1d0200b001f585260303mr5961917pjb.79.1660173388059;
        Wed, 10 Aug 2022 16:16:28 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902e84700b0016d62ba5665sm13540246plg.254.2022.08.10.16.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 16:16:27 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 8/8] client: fix station autocomplete with multiple phys
Date: Wed, 10 Aug 2022 16:16:21 -0700
Message-Id: <20220810231621.372514-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220810231621.372514-1-prestwoj@gmail.com>
References: <20220810231621.372514-1-prestwoj@gmail.com>
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

