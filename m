Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D4640C03
	for <iwd@lists.linux.dev>; Thu,  7 Dec 2023 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNuE+FfV"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-77f3c84e0f6so37410785a.1
        for <iwd@lists.linux.dev>; Thu, 07 Dec 2023 06:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701957656; x=1702562456; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXnYUofkCp1atA9uXGJyCH9I7mrbJ+/QubCgFZHo8jc=;
        b=HNuE+FfViRwd8tQgyN1AmXYEAA4k3Rqueybw7gEsbxq2NOLOcSJn1rU8w4r+sV/QWH
         Wj8XXUyldGM0PMtGIJoj2dVSTS+5LKoqVCfMKNP3V2AOMihfbx3XyPN07Q3rgL0PrWNo
         Z1oNQ9bSGnxRlp4qApEBGrWjG7MS+NG6UdFst0kuQD3o17uHIHZZ+rjqv3CEBF8mAq/E
         fpJnVcGXUxpGR/tBnTXkm5Al0kKU4y7DCFYZOp91+45LnwngOnyKlXbWSqaICEjSeSd1
         W98U0U4YUDZ0Jfwxs7O1+87iM0gDQOEpZ5uYvyCEEUnioA97Ezl3dAzzvXgIucBCkoXG
         a01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957656; x=1702562456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXnYUofkCp1atA9uXGJyCH9I7mrbJ+/QubCgFZHo8jc=;
        b=KpfEuSD8AgCNNEPQUJxloQ2cDIGWdU6WdnyMmMwO3KhHAlueIdx5+d+3QFR/1OUTQC
         yphcdbGjiNUCxoaAV06P5p+KG1Bbtjiwp2IlcJyPP8uWI0+Q1tuDsN65+TIiiwarPvNc
         kcpLZsZJppRQjf8dXRuvofMvqQ29CHJuuXn8g2c5vQm84dh2O0j+zGrbIf6+/wVvsu4x
         VOMPpDzHQMEDhoBFQzOIZbnnVwvZHtI2njF7MLFHI7LBdI6uz6lH4xJZzOzOJ+aud/5m
         ApIXxqr87poPmUv7T9YmTaEZeQaWgBD90tfxZcvTQR/J2D3UiDTeL40mJIxYezWm3tDV
         Zi0Q==
X-Gm-Message-State: AOJu0YzTdeI++PH54FbzoXdpNirJ6+9Dv5nL9MhW/9yAXu5m+r+klwBq
	IFapQp8akUUNOr1xEAjZyM07PHHV/fw=
X-Google-Smtp-Source: AGHT+IEbBnvcaSCSEW3svTRRO24d1RzdCBSAn4wFRmQB6l17lpvt/7i+L9uQf6BMW10kkyTtm6QIvw==
X-Received: by 2002:a05:620a:ce4:b0:77e:fba3:a1fe with SMTP id c4-20020a05620a0ce400b0077efba3a1femr1192163qkj.88.1701957655708;
        Thu, 07 Dec 2023 06:00:55 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id px24-20020a05620a871800b0077dc1476413sm407699qkn.131.2023.12.07.06.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:00:55 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 4/4] auto-t: throw exception if executable is missing
Date: Thu,  7 Dec 2023 06:00:49 -0800
Message-Id: <20231207140049.2614514-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207140049.2614514-1-prestwoj@gmail.com>
References: <20231207140049.2614514-1-prestwoj@gmail.com>
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

