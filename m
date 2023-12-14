Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB0A405D7
	for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llQAofHs"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4258026a9fdso49623421cf.0
        for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 04:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702557246; x=1703162046; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXnYUofkCp1atA9uXGJyCH9I7mrbJ+/QubCgFZHo8jc=;
        b=llQAofHsyk0s3V0C0EPq1uRgkcqLAaR2BcX+aWqbwGMINkEJQLnZBhwiGdLQzlINku
         xy1jwBnoTEVshGcqhlYy45hxW33M6kYljDGNrUKRaJySWgfghuX/t6WDSFngxxochFHf
         pkyhavUAnDOFLEjirYBa++P1GBDjJdNmIeKeoj9RMH0lsnnhVPsRfWehBYUUlPpfNmjE
         RopTXf2h/IDMqe+oHQyejMZOgKI4bfSIqTdNVETpKGMSFv5D/pao6bwHTp4r38Agu3rW
         KcSzFrU18U8EhsnMg3cjz/rtc/FAVpRyAWFtburJE6JPRTwS3pmcJGqquPbG8xTW+Rnu
         Pl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702557246; x=1703162046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXnYUofkCp1atA9uXGJyCH9I7mrbJ+/QubCgFZHo8jc=;
        b=r+oykjHc3bHIDmlOW72lBQWFZYb7pNq2ksLkCLgBoEV2FQQofeDKABO57mw/nh0KU6
         E/KCMlrgqljoc2Di7SQxW2JHTzaR2rNm5jIZEEKR+7frpqcq8Cj1JInGzz5Rxeowqcmn
         x9txp7tlaXg1KferVu54soqqBIhJwa4T4UQoFwBRk6LqpcaXxZ3kjkbS61vncECdogXD
         Ta4cQGi5Y9DdrIOV+VNubct9SKoJpTNxRRgOVA8Z6PEl5hxoozbP0JZ34qZP5wh3FFxF
         h5KLgAOXLoH7J3Iie591ck3M603v3FyTCkFSgkGCEmq92Nyri7V+r52uym02ug/pI93i
         6WYQ==
X-Gm-Message-State: AOJu0YwMYuhoZdK0kiZvJgdCmZvYvTr/5ohFypsurZK53idpCWgIAIbE
	/owTgqttishCIXorIaxd2Vwk7YCl50g=
X-Google-Smtp-Source: AGHT+IHsVPnVe+4roP7Yt9FpM2GlY/ckjFL8wOaE74xF0BuTZ2cxXcuuil+TkNgRSdEclEA1jWINCg==
X-Received: by 2002:a05:622a:1b8b:b0:425:4043:29f4 with SMTP id bp11-20020a05622a1b8b00b00425404329f4mr11896958qtb.111.1702557246606;
        Thu, 14 Dec 2023 04:34:06 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id x3-20020ac87303000000b0042551dce749sm5745883qto.46.2023.12.14.04.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:34:06 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 4/4] auto-t: throw exception if executable is missing
Date: Thu, 14 Dec 2023 04:34:00 -0800
Message-Id: <20231214123400.12924-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214123400.12924-1-prestwoj@gmail.com>
References: <20231214123400.12924-1-prestwoj@gmail.com>
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

