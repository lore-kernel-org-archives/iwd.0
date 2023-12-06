Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D1C6F604
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJItDT/Z"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-58e256505f7so78835eaf.3
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 12:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701893888; x=1702498688; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rj82y449AvkdKesQQUHyj+VdUVbSc8ccNljz1Eh1eO4=;
        b=EJItDT/ZAAv1mXUMo3X3sDJt11XkQik4FhPQqRocUMIbses925z/rTod33jCGrG/Ho
         nFX9lYmrKDXeKQ2AkkGChX0+uBRgrdnKRsXwXCYN/AW9RmRmjDYZsfNfz8qumeO5/QVG
         JkmkLotq2DswO0BPMPSWuk9nSF0MV6j1XJhgMbsn4TWPplhkNNiirr8FqsViB4SNCik7
         2ycoHfNpqMTwOb/SYJNV51rksaPVtsVzfT3vhThO9a/ybkb/BP9kq5r8EHI3XjJN1d31
         oR48kqIUSjASclPGpyQFIduBH+17vN6OLxI9DgARSFuQmhz1bkRpzDnXUAxQJVefflGW
         fUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893888; x=1702498688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rj82y449AvkdKesQQUHyj+VdUVbSc8ccNljz1Eh1eO4=;
        b=sfvr3GlElrMrlZwk5d6zK/fzrOOlWNA4bL8lVzNhmBf9SRx4uoTHn16X2GDNnUkCDa
         pfqXeNd64S8x7UPrnQ5o9r13isFDyux9VDlj8UdL/Rkh/eGtgKkPXT+eyt8o2y0wrCyx
         1XWzDD2Kpegu9Cps+dmzVUL2tARYUzoIHW+xdWCKgG/uvjiHFU7byBgijQZFITnkYc7p
         QKujqAUCqu8QguwYMnIdX0OrvRBdk5xsoi7rE9dTX8/y60KWNSEPJMlYlf+XJUtwd6X3
         1FxdE5kkTtY6EuuY3+VpaVveR0+M+4fGKVE76UXNlJ0pXf3mXURx88Z4drNzcjefMl3g
         uCnA==
X-Gm-Message-State: AOJu0YzNGs39NgLLJnKIFL11IG+YL4PwW0eSoLQATbVJfGBM0zp/faS5
	+E2no9YvEjl3e+vv0rZ8NU5Fo0WPJn+aZQ==
X-Google-Smtp-Source: AGHT+IF9MaNEwfbTosqtadyhFekmmCbOuuprDHgipfvuZFnyBP32bJGAbdtHm2mB7EGcIYKcN4I5WQ==
X-Received: by 2002:a05:6358:60c3:b0:16e:33e:3a9c with SMTP id i3-20020a05635860c300b0016e033e3a9cmr1992298rwi.6.1701893888500;
        Wed, 06 Dec 2023 12:18:08 -0800 (PST)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id by40-20020a056a0205a800b005c2185be2basm243168pgb.54.2023.12.06.12.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:18:08 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 03/13] auto-t: only call set_value for changed values in default()
Date: Wed,  6 Dec 2023 12:17:52 -0800
Message-Id: <20231206201802.2139649-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206201802.2139649-1-prestwoj@gmail.com>
References: <20231206201802.2139649-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default() method was added for convenience but was extending the
test times significantly when the hostapd config was lengthy. This
was because it called set_value for every value regardless if it
had changed. Instead store the current configuration and in default()
only reset values that differ.
---
 autotests/util/hostapd.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 1b1bc399..cee08092 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -75,6 +75,8 @@ class HostapdCLI(object):
         if self._default_config.get('vendor_elements', None) == None:
             self._default_config['vendor_elements'] = ''
 
+        self._current_config = self._default_config.copy()
+
         if not self.interface:
             raise Exception('config %s not found' % config)
 
@@ -170,6 +172,8 @@ class HostapdCLI(object):
         if self._default_config.get(key, None) == None:
             raise Exception("Untracked setting '%s'! Please set default in hostapd config" % key)
 
+        self._current_config[key] = value
+
         cmd = self.cmdline + ['set', key, value]
         ctx.start_process(cmd).wait()
 
@@ -200,7 +204,10 @@ class HostapdCLI(object):
 
     def default(self):
         for k, v in self._default_config.items():
-            self.set_value(k, v)
+            # Only bother setting the value if it differs
+            if self._current_config[k] != v:
+                self.set_value(k, v)
+                self._current_config[k] = v
 
         self.reload()
 
-- 
2.34.1

