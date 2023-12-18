Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34B53D564
	for <iwd@lists.linux.dev>; Mon, 18 Dec 2023 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTAtxhLD"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-590711b416fso2145117eaf.2
        for <iwd@lists.linux.dev>; Mon, 18 Dec 2023 06:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702908776; x=1703513576; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17kjngjl4clw+g5Gdna9lJMGodPIyyvLG/4MzZRUlT8=;
        b=nTAtxhLD6FwVdtIGKCR96d8HxD5XHxuyLEp+d5ZoUNUenbss/efHVFESYAo43chh/l
         AkKDiYlZbYkNaq4wTD8BbIs90grPNY5RcPQQ9NZhoJPRgXTny9mUWeaf0HABLUXqKNE0
         e2C63BdGqvbgnlRgcvkCDrp3d2tkdYUxwQEUJEeh2o6hk+y+k4U7nZghA2zl21Y/EuN5
         2CaeS/88zz8keODUlMYHbVHs9UDLjPZ390wsTLotsJriHST5NS0MfwCmAus2q3gPRu4j
         9ksv2o0DGlkCgEIFpYuP6r8WUQyC+iHLKscTMnLS1x4zC35zsQm+wyzyBE13gTGN9XAt
         tWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702908776; x=1703513576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=17kjngjl4clw+g5Gdna9lJMGodPIyyvLG/4MzZRUlT8=;
        b=Eyx93WllSzSphpg9Jt2iUwrF3gJC4vOMdF6CrgJmuGw578vgK5tu2kbGMS/cuLmDja
         JxaT0YLrKqf0RUPRuRmFW9/3WQvo6Y7hVvrfi0pQBToVnkY+w4Hv2l5lfNQwckqPM0mg
         wxgOmv5tZrZUNuZLp0kN0J6ElSoshD4mYQfCy50XzAyRHstKxZ55wFqOrtGPy8rLP0J7
         QatDHAQMuvr4VJisaga3SAmgqUpzbFYIa5DUozSUwOdakhQm4/rJU+KCjUPFnq8Ap93+
         ZmCNg4rKjtux+M25auhqDa9DyyRT8aHOVixrqcCwf90N6O7k2dBfFr0ze/YHDlD3erp0
         A1eg==
X-Gm-Message-State: AOJu0YzfZBKhk04opeTvh7sjLrqZeLLZJZkK1b5k/EYVxA+QTEWAjG8T
	YOaAGP54akbD/4JI6PndIIvqDAtTsLU=
X-Google-Smtp-Source: AGHT+IFycYAr2mS5OeIW+/XrpCitQjf5HGKcxJt4gOgtZJWVN7eOJbX6r4UC2C97ojyUGBPr+aeTtQ==
X-Received: by 2002:a05:6358:9199:b0:170:da5a:d24e with SMTP id j25-20020a056358919900b00170da5ad24emr16006386rwa.51.1702908776567;
        Mon, 18 Dec 2023 06:12:56 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id b2-20020a0cbf42000000b0067ec8702d1dsm7816355qvj.137.2023.12.18.06.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 06:12:56 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/4] auto-t: increase RAM when running with valgrind (UML)
Date: Mon, 18 Dec 2023 06:12:50 -0800
Message-Id: <20231218141250.202157-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218141250.202157-1-prestwoj@gmail.com>
References: <20231218141250.202157-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was done for QEMU but not for UML. Running more than a few
tests with --valgrind will generally thrown an OOM error pretty
quick.
---
 tools/runner.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/runner.py b/tools/runner.py
index 03f44611..e50ba9c0 100644
--- a/tools/runner.py
+++ b/tools/runner.py
@@ -552,7 +552,12 @@ class UmlRunner(RunnerAbstract):
 
 		kern_log = "ignore_loglevel" if "kernel" in args.verbose else "quiet"
 
-		cmd = [args.kernel, 'rootfstype=hostfs', 'ro', 'mem=256M', 'mac80211_hwsim.radios=0',
+		if self.args.valgrind:
+			ram = 512
+		else:
+			ram = 256
+
+		cmd = [args.kernel, 'rootfstype=hostfs', 'ro', f'mem={ram}M', 'mac80211_hwsim.radios=0',
 				'time-travel=inf-cpu', 'eth0=mcast', 'eth1=mcast',
 				'%s' % kern_log, 'init=%s' % self.init]
 		cmd.extend(args.to_cmd().split(' '))
-- 
2.34.1

