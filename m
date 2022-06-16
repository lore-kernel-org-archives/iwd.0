Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AC429A0
	for <iwd@lists.linux.dev>; Thu, 16 Jun 2022 00:02:41 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id h19so14087557wrc.12
        for <iwd@lists.linux.dev>; Wed, 15 Jun 2022 17:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mhi2SEFsuruUlqjs9YbwvTp6i79tBx2IFd/EfMwbNxo=;
        b=3lNqrcyOW35c8RGlhYNmnDmB9jsottW15S6+V8hTqwCz6tiMKyLfOtN5TsXcVEygEj
         XgM7rLoZ1gOwkDhFA6hQZOLOIieokmPjnELnXWQGzmb7ZxjcEwhddetT7yrhja7yMfN6
         njlnIu3VIzvftCI7hUFvePX5VoTL8bok6Xn3GKfLPlfiJ5qKFOFmZLB5fRdj2D2FntNg
         64dKboAydwXoW3qUkDb7GykdV3Yjoqy1tLjCPIWh/dDwLkqVpyhcmNkf7rUL4eAyBOQr
         VAT+Kb0QHaHnLQ9l0Vf2Ux963lV7UYV0Ne8tcbdVScZTbGOQKWzbsKBZzU/wUvU6DBdD
         xdTQ==
X-Gm-Message-State: AJIora9p8xi/1fImJgw4jJYuWuneL6B8pXftOpjKh5mMp388NpsTPF9M
	0zPTDt/xMdbEP0WuVnTKcMbrymki+6Y=
X-Google-Smtp-Source: AGRyM1t/P+bcerePEzuD1zdKy/z7HAPFoAynBW/AmDpx7nblTTy2CY7+GyvBav37oi59C7sNLVXteA==
X-Received: by 2002:a05:6000:242:b0:210:354e:c89a with SMTP id m2-20020a056000024200b00210354ec89amr2118629wrz.136.1655337759522;
        Wed, 15 Jun 2022 17:02:39 -0700 (PDT)
Received: from iss.Home ([82.213.231.20])
        by smtp.gmail.com with ESMTPSA id az10-20020adfe18a000000b00210396b2eaesm337452wrb.45.2022.06.15.17.02.38
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 17:02:39 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: iwd@lists.linux.dev
Subject: [PATCH 02/15] storage: Log a message on network file parse errors
Date: Thu, 16 Jun 2022 02:02:18 +0200
Message-Id: <20220616000231.1966008-2-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
References: <20220616000231.1966008-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most users of storage_network_open don't log errors when the function
returns a NULL and fall back to defaults (empty l_settings).
storage_network_open() itself only logs errors if the flie is encrypted.
Now also log an error when l_settings_load_from_file() fails to help track
down potential syntax errors.
---
 src/storage.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/storage.c b/src/storage.c
index 2100d08d..77be36c8 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -597,8 +597,10 @@ struct l_settings *storage_network_open(enum security type, const char *ssid)
 
 	settings = l_settings_new();
 
-	if (!l_settings_load_from_file(settings, path))
+	if (!l_settings_load_from_file(settings, path)) {
+		l_error("Error loading %s", path);
 		goto error;
+	}
 
 	if (type != SECURITY_NONE && !storage_decrypt(settings, path, ssid))
 		goto error;
-- 
2.34.1

