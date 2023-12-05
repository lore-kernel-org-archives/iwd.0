Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E185F1FA
	for <iwd@lists.linux.dev>; Tue,  5 Dec 2023 15:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcqQ5kWO"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-67ad032559fso9920096d6.2
        for <iwd@lists.linux.dev>; Tue, 05 Dec 2023 07:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701791227; x=1702396027; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXnYUofkCp1atA9uXGJyCH9I7mrbJ+/QubCgFZHo8jc=;
        b=IcqQ5kWOUBeuyY/5wP743CvQRdZubD7A3VSHLBnhb9C6u+scMPlW7C8KX5IbqgpCB6
         OXCiBx+6MyPptfWB3S1qqpIJ8MxbMNf0Nu9StkVjm8uNYSlzPw/fdUV8/27Cafll059e
         tLh9O4ywsNB+MOsJ98rB5PZbdXFA58UMZuCqDIpiRNRoI3dHRtT+nRR1+1elJ/kBlZLo
         jIX1hXzQqSWQ8e0KjktNDHVTuY3M8Ziw9nuHHCzbpJ7my8fNzThDC3sD1mzgTnBXMXkC
         oEYwBqAARd2pM7wDWpvhzvHzTOOqx0zDb3LWJBdgd1lct7v4xu5D3qVmq6MmxkBb9x7j
         H8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701791227; x=1702396027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXnYUofkCp1atA9uXGJyCH9I7mrbJ+/QubCgFZHo8jc=;
        b=Z9921lh7TGy+n6+ou/x6a5KyAaThOnrSpYhc2UdbzX+/gMjClz85KQYbsvHqwP5rNW
         yRVa/+PnT2bXRsTpa6Pd/2dn1NvKkp29AT6r33wZjcTf1ea+MvqvC8j1bWnCWJReQFD9
         PiB3/3vjf3t5RbMpUpPteKaTN9aI2dDAjb8v7SbEKHc4kMNuh2A4/+8OLjZ8BnpmklPH
         6DD05E47zqCUO41J+bQrB60D9nldkZf0LgjmHPnJc6yWzlvsrGZmKmqB2bgcyWsc8Gpn
         GynUI/ewWHeYMGrRqzw1TgnaM9IzNhRsMO5iarnd5M3lceymwZkENocvV0gSOUrUR9ay
         28Gg==
X-Gm-Message-State: AOJu0Yw/xvULqmukZTkqqte8KZ0OkkFiyQrENzZHLYxniu3oS5OKtE4b
	8vRdbqxQ17ghra7NZ40pdgZD8TpwYEA=
X-Google-Smtp-Source: AGHT+IGkkIyFwuC/5jNfnEZXyXCt6T+1dalkxR7630hivi8mOrv/MJ3IQpj+3/S3scLMIQM5o2V3kg==
X-Received: by 2002:a05:6214:5ed4:b0:67a:8f8c:885c with SMTP id mn20-20020a0562145ed400b0067a8f8c885cmr1334791qvb.56.1701791227027;
        Tue, 05 Dec 2023 07:47:07 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id kr3-20020a0562142b8300b0067aad395037sm3177567qvb.60.2023.12.05.07.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:47:06 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 10/10] auto-t: throw exception if executable is missing
Date: Tue,  5 Dec 2023 07:46:47 -0800
Message-Id: <20231205154647.1778389-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205154647.1778389-1-prestwoj@gmail.com>
References: <20231205154647.1778389-1-prestwoj@gmail.com>
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

