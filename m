Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4636B747C
	for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 18:57:01 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id f193so15847966pgc.0
        for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 11:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9192CCHTa3BDgusxcyQw8/mHroaBps98U/2M7mmcIc=;
        b=p1DYZEhWCg+ataySO+1AiOVS9EHtaTF+7NrR4H2yRsOubXg6UFwKMSYKCfWcDWneaU
         Rk6sRgz3eAT9YPa+AAmLTMVUM37gE+fzWe5Ftvju/OToP52DIqG+Q29ppW2w9g7GniD+
         pV4JjMGiN5bFTJDOpJG2fMooBEJ+nk/vNoFA5DhDIzcZ/qCTJ7pzQ0DZHhmTcbdtWtNI
         vVeueLnLKW9I+qdoOsICnb/u6tcPJ2XByqCPEw+qDDkVjaczl2JPk1OyGMd9zDMemSXm
         1nTWnQRuIWQ20A6vI+Curu3v8hlX99XtxcO+njX7qWCioHOR4ZZozxKvZMViM8xyqItL
         a7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9192CCHTa3BDgusxcyQw8/mHroaBps98U/2M7mmcIc=;
        b=HX8hYr+IpKaGi4s5WL46EBow4cE3EQNfCg2YouIUgdBNYtqBgewBJvrqytPsJsVMDg
         Dcem+DYhurEv4ClOxYKt4QkXY3g+JEhy1V9l+ck8/kJFOmjI//dM+luD4frfffZF7vB8
         CsJ/apQBhWenCs4KiM34Qserc7hkAiHY7WFypSRWKfqyFUDhyjNBvnkMkc3bsjQkPlNH
         3NQIJeJ04bV7POfinIasMx+flj4yD40QavALqnLk4NJEylFtw7m3CB6fOSqoR+3CuEJd
         uBSsEh4uKrNE2C4EODXp1dnLSK5yIx4rSATZELkA+QeKG+OgWipYNJ6sDsWluwjbOPbi
         42hA==
X-Gm-Message-State: ACrzQf3rhs9FIiPWLKIBHCY+OIpx+JaYFR7t+6U8mWVV+xvPt2fG1Lsm
	DJXbYfm4iOGmUdtRRf0IECvXfRLtCfA=
X-Google-Smtp-Source: AMsMyM7AKfzQlEw1i81M3bJ/AvFrvhvKKV7yop1gr5z4xYfcvK59yPGfMMg7DiRijz+nG5aitmQdog==
X-Received: by 2002:a05:6a00:181b:b0:56b:fcbe:2e7f with SMTP id y27-20020a056a00181b00b0056bfcbe2e7fmr13957813pfa.3.1666810620385;
        Wed, 26 Oct 2022 11:57:00 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id h19-20020a170902f7d300b001869efb722csm3209420plw.215.2022.10.26.11.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 11:56:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/5] auto-t: fix get_ordered_network if hostapd isn't running
Date: Wed, 26 Oct 2022 11:56:53 -0700
Message-Id: <20221026185656.489888-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221026185656.489888-1-prestwoj@gmail.com>
References: <20221026185656.489888-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This API optimizes scanning to run tests quickly by only scanning
the frequencies which hostapd is using. But if a test doesn't use
hostapd this API raises an uncaught exception.

Check if hostapd is being used, and if not just do a full scan.
---
 autotests/util/iwd.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index a9df0dca..a9e2f2f5 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -519,7 +519,8 @@ class Device(IWDDBusAbstract):
         IWD._wait_for_object_condition(self, condition)
 
         try:
-            if full_scan:
+            # Do a full scan if instructed or if hostapd isn't being used
+            if full_scan or not ctx.hostapd:
                 self.scan()
             else:
                 self.debug_scan(ctx.get_frequencies())
-- 
2.34.3

