Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0967F40BFF
	for <iwd@lists.linux.dev>; Thu,  7 Dec 2023 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/una7Jx"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-77f3b4394fdso31872085a.0
        for <iwd@lists.linux.dev>; Thu, 07 Dec 2023 05:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701956911; x=1702561711; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXnYUofkCp1atA9uXGJyCH9I7mrbJ+/QubCgFZHo8jc=;
        b=g/una7JxTRbzrcDuaAy7jiuyTrUUM02es6gqcFiXFjBoPnPsIxZJzvvP/qn3JburwW
         PoseOEhNzNDLpERwNhZZkLjcC/41LVbzAYtmejmLqOlPKuHoLM77IKDeA29IKSVZe6y7
         eC6dl6+vitBs0AF4i1qwLKPw0q7lC414/Yw6jbp9oa8W8KBNII5i8+vF701FDeJxORvW
         EQA+hYHcGXbg1PewMKsY2TemCk7VcjuNLAf5f6PovGaiSl3lEjfrxcFSAaBZR8nj8Pit
         sCebMoeGTQ602USfiaIY+bVWBDxjCNsnR3VdMmfbnb9R74K7CDubfxJ4bACk74U6KPKY
         Bqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701956911; x=1702561711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXnYUofkCp1atA9uXGJyCH9I7mrbJ+/QubCgFZHo8jc=;
        b=MNuRHv8BVI6U7LhICS+MmfRFBznPaLc8LqHQqH8y05S2K7c6qw+VF1+pCYtSGs135a
         ukxhNtnzasOVt89D/a5CoRi+PrqdBIVKGIa5VDR9MhWuER73xIsqp7xWqcyX/6Vw6CRD
         7ep1iDtLqNwp3J2T+1w25g2CbnIBD8gtqOfK6I2+9+AkioPQejBMf/IpHDfrGYNzSMS6
         B122v12o5u9QutrWO5atKskHD15GYdf6hKqLM26Dpsbyd9E1eKczDRHpiPs6yJ9J+Ne2
         qdTMUXUtcsaPscJA2+eoZ76qX/YsHR2G8bjkt34E1ZznpeEa+qcebFs2eGbB+i8lXkqI
         zOlA==
X-Gm-Message-State: AOJu0Yy1f33z+hnVHCHTbZ04bf+becsk06EBcbl0C/7kw3U1JEUf6FnD
	MshygapwU505qvEnPPCJGoqH3qkDMGU=
X-Google-Smtp-Source: AGHT+IEFT+bOdrJ8LWJbGGseaU/Z8Qgq6pn6crDt7Ds5fMfYYqjc1NiMB2mvRH/fwhqappxnhxVnUg==
X-Received: by 2002:a05:6214:304:b0:67a:a721:82e9 with SMTP id i4-20020a056214030400b0067aa72182e9mr2188380qvu.67.1701956911596;
        Thu, 07 Dec 2023 05:48:31 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id w18-20020a0cef92000000b0067a27108513sm496494qvr.67.2023.12.07.05.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:48:31 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/4] auto-t: throw exception if executable is missing
Date: Thu,  7 Dec 2023 05:48:22 -0800
Message-Id: <20231207134822.2458827-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207134822.2458827-1-prestwoj@gmail.com>
References: <20231207134822.2458827-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain tests may require external processes to work
(e.g. testNetconfig) and if missing the test will just hang until
the maximum test timeout. Check in start_process if the exe
actually exists and if not throw an exception.
---
 tools/utils.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/utils.py b/tools/utils.py
index a07c3183..8219542e 100644
--- a/tools/utils.py
+++ b/tools/utils.py
@@ -34,6 +34,9 @@ class Process(subprocess.Popen):
 
 		logfile = args[0]
 
+		if not shutil.which(args[0]):
+			raise Exception("%s is not found on system" % args[0])
+
 		if Process.is_verbose(args[0], log=False):
 			self.verbose = True
 
-- 
2.34.1

