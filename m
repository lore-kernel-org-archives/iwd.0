Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE882E64B
	for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 18:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058873; cv=none; b=BFaK4jn+C08IHVm2lnAkZj4jxmFEPYqU/V2SJT/D5UhsrSFvwtTblsiIGvk5oPhRrp23ABlzvtPGt3TabIFpYlw7FrET23RvXdEriprFfHC9ozrMYNkZ/D+D3z5eiHsKKpL842qGqVSCkknX19T+ANyuetjP6MMXLQ68J40fdC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058873; c=relaxed/simple;
	bh=FgAUUyV1MDvZkTz7JnnyYFwbSqhWi5NqZwiEXYYaS7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s3Jqcv+rX0Y2szbzQZ3Stn9/btgAzNIF6IACDm/JQuK1CBZNHK8s7qjflgd7OjaItjaaM+PznEdv3oeRSWpxnVwt1scCy8bK56N4o6+8xYIBmt0IDk/DUrsdnDY/t04d53gh0APrgo40ScRJ6PsyFNDsoid3sAcPrRoX3VlgXEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eB2s1MlK; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eB2s1MlK"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-365ab9e9e31so3141815ab.1
        for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 10:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709058870; x=1709663670; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umW6ITmvhnDwygddF7KsD8tUJ2f4ZMQky8Xm+flAW6A=;
        b=eB2s1MlKcS+in/cmGubX9vWQANcCX6ZXhglpO1kkcFENL9SUz76Uw1PJ1YS6r26EMu
         q2lEJENg5Or4qFENM24Y0h6E5jxnx6d6dOOqzHNdciEMrtcRvVbbhrvTvEXyXp4bER6a
         Mr8meLl0Bo7DU3QQxY1NQD1r7IH2IHqXcYpGrJZH8vk8TYPZ7LcfHYsNLCsE92CKr5IH
         ZsLRFC1lGywjQNbils3yA9mmBNoZZipmylOx6gFl34QMpdC4/5IH8Z00gTKNqBrQVnq4
         MIET9XgM7+OFdwOoep3UzaWjut5YM3LNWaxBI3NWH2rlXGSSLrsZsD6S5AuA/4Kg8SZS
         awMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709058870; x=1709663670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umW6ITmvhnDwygddF7KsD8tUJ2f4ZMQky8Xm+flAW6A=;
        b=fsX2zu/K37OL+L66QV1R057CYvNStnGG9qsXvH2PmeO4TY2aQ7vTnV10gHtjGtLuG6
         aQyKGYFEWuh7OeNEnjGZ4rivo5J5MaeezqQui8GvWUZcvqPT4fBXPEUnVWxhLUxgWVU2
         k2Fo8cwW3tZAQ4nn3uvFXvhfCTfBUrqCz8phZPRzLqst2xlOVj1HWrplAe9y9jK2UhiX
         ix+XAnzcfOo9+QoCGDpdf7WqGm3hELuFhvqn+LxqHJqWlCgo1xMX8fGSqO3j0yO+mq39
         fs+jujX20Lke5U2yM92WbALW+zXYrhvUczEUnI/88kLyBNCffCsZyBjTKWgR/EHainqp
         SP1A==
X-Gm-Message-State: AOJu0Yx9cTTPpqkO2ITGyTtwZuxghrj8J4xwXFzCjf0vg+4ztu6gAcxW
	W1AjYB0riCBg0i5YZawiqTrc4U7R145/C0IAd23ENu7/q7ogvcevlHVEd26S
X-Google-Smtp-Source: AGHT+IHBL33Q/hMV2wBSI+E2uPBN7l8lEIetcruMlBg0f0g62tbWjfDjbH+WN3yiV5cPmfS3P5qSfg==
X-Received: by 2002:a05:6e02:13e3:b0:363:d8dc:2a31 with SMTP id w3-20020a056e0213e300b00363d8dc2a31mr10766508ilj.14.1709058870706;
        Tue, 27 Feb 2024 10:34:30 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id jy2-20020a05622a818200b0042e3468a98csm3819617qtb.4.2024.02.27.10.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:34:30 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 08/11] auto-t: add HostapdCLI.sta_status
Date: Tue, 27 Feb 2024 10:34:02 -0800
Message-Id: <20240227183405.257206-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227183405.257206-1-prestwoj@gmail.com>
References: <20240227183405.257206-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gets information about a specific STA hostapd is tracking. This
object will contain detailed information such as the SAE group
number used.
---
 autotests/util/hostapd.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index cee08092..2f92e330 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -306,6 +306,22 @@ class HostapdCLI(object):
 
         return ret
 
+    def sta_status(self, address):
+        ret = {}
+
+        cmd = self.cmdline + ['sta', address]
+        proc = ctx.start_process(cmd)
+        proc.wait()
+        status = proc.out.strip().split('\n')
+
+        # Pop address
+        status.pop(0)
+        for kv in status:
+            k, v = kv.split('=', 1)
+            ret[k] = v
+
+        return ret
+
     @property
     def bssid(self):
         return self._get_status()['bssid[0]']
-- 
2.34.1

