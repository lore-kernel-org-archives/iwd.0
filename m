Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BF213173A
	for <iwd@lists.linux.dev>; Thu, 15 Feb 2024 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005207; cv=none; b=YA2PhmVD3X0kNsV+9SERVZ2NQMsGG3bClBOBm8z8y9iOb1c0alTSnA04YW7eQRZs3WUA8mAvyDwjKgYVlbd4AWJhfH28F5EPr/Mm9ZxX3WJTm6Oq+gt12R3LCWDNafS7G6yt9LIg9OmOByGU+SB9DH/wu0rETTQHhyYx9Vd1tEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005207; c=relaxed/simple;
	bh=JyNsKP+I/qB+DgwNWT+XvdAENmrt3cBG7GNT1NzO0rM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bpTuMyy07kcPHS0yvyuoXNGG4qX5OWeOf/fFGUaFsnLHX98isLEwHRs3GF68v5yW7uroaSSGn9piNlERMM7c49Z30P28Pdm6VxFAsyGP70GaF701LuDwdV4PFO4aR5VNqxaWqWDCBV1qZp43PWf6V9cyIXoTnemE2RaFzg502Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsG1z2Sa; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsG1z2Sa"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d72f71f222so7073655ad.1
        for <iwd@lists.linux.dev>; Thu, 15 Feb 2024 05:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708005205; x=1708610005; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxoAzV9F1JlwiHJUV26mJsU1NDAasvYRAeNf4MhWL68=;
        b=jsG1z2Saeh8ePo8dyXwvxJ9f2U9qq5vjOIRnLirEtQrMQEDSNqRAsxRJzVAoEbTvIh
         nUtANJOd+O3ZFRCEWEEOm/KzBBtuL8SEJ5jcssqyTVik0ewmCs/EtBK7GoPHlbICOY0Y
         SylX/AZ4xssVzEuOsbeMLfI+Vc8YQrkadZIfB1GEY8C1azyTsYzvgtUigmSS+oYV7o2o
         QFu+rsOCLEoZugUjN33cocBEOBP5NLbTYDSQR/bg4QeXvPTW5L+5jdU+aqkvAf9mnGCP
         7zzY+EGgug1tDbjjRwyfAhMsSvhwZrwD8bOTkPjLsDv8apY39a7SYy32hZOk1EdKPlNZ
         MLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708005205; x=1708610005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxoAzV9F1JlwiHJUV26mJsU1NDAasvYRAeNf4MhWL68=;
        b=tujFz/8wYweQKd0NGOW+tTRra679dblpdGPtbuDkPUQzsmsTJmp7IQ/e0LF8J+PXO2
         ZOkTrt9ABZWGnjZqdmzdoIL4yZsu7qtIsKqv8jAoTCEqW5Ff95K8fDllC+SnHmtuut/B
         Wh627RQBsJhR6iMu7GFuqCUXkTWDW4dDXUogKYpiME+Z29U/1T3SS7uCraGzmc1gFLv0
         tG2j2K3SL2KSi0ClyRvjnagdNDd1Waaqyl3R3tOEsJhgkC+dc6ZCiHOGSg7tVFWAMcEA
         zO9F5NjX+Uy2IyWfoDBnAB5kNycG5NZDHomPhcJg9XeYfrAq+zQ29P/Ch3nSchsLJEsS
         D6vA==
X-Gm-Message-State: AOJu0YwuPxr42j5F7H6Qnfmx4cPqRWMX8Bog+OXhrL/fJ4c9rB1nDwqD
	C2bu08UacWMQQHhi4wnBf8aEWXKhVSXqSyklR3XcPcl8MGqwPJDG/4unQ++fj10=
X-Google-Smtp-Source: AGHT+IG8ITbMDpzX4IbmGJ3T1suOdCklyxwL7fMo0RNeaUrx2LdpiaBlpI0fk5+3awcHddM11INjAQ==
X-Received: by 2002:a17:902:ce01:b0:1db:8eb2:9a11 with SMTP id k1-20020a170902ce0100b001db8eb29a11mr1353355plg.53.1708005205416;
        Thu, 15 Feb 2024 05:53:25 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001db55d2e1e1sm1284787plq.63.2024.02.15.05.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:53:25 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFCv2 1/5] main: add runtime flag for setting the logger
Date: Thu, 15 Feb 2024 05:53:10 -0800
Message-Id: <20240215135314.1017081-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215135314.1017081-1-prestwoj@gmail.com>
References: <20240215135314.1017081-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The --logger,-l flag can now be used to specify the logger type.
Unset (default) will set log output to stderr as it is today. The
other valid options are "syslog" and "journal".
---
 src/main.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/src/main.c b/src/main.c
index 3ce8340f..acbfdc0c 100644
--- a/src/main.c
+++ b/src/main.c
@@ -63,6 +63,7 @@ static const char *nointerfaces;
 static const char *phys;
 static const char *nophys;
 static const char *debugopt;
+static const char *logger;
 static bool developeropt;
 static bool terminating;
 static bool nl80211_complete;
@@ -164,6 +165,7 @@ static const struct option main_options[] = {
 	{ "nointerfaces", required_argument, NULL, 'I' },
 	{ "phys",         required_argument, NULL, 'p' },
 	{ "nophys",       required_argument, NULL, 'P' },
+	{ "logger",       required_argument, NULL, 'l' },
 	{ "debug",        optional_argument, NULL, 'd' },
 	{ "help",         no_argument,       NULL, 'h' },
 	{ }
@@ -474,7 +476,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "Ei:I:p:P:d::vh",
+		opt = getopt_long(argc, argv, "Ei:I:p:P:d::vhl:",
 							main_options, NULL);
 		if (opt < 0)
 			break;
@@ -503,6 +505,9 @@ int main(int argc, char *argv[])
 			else
 				debugopt = "*";
 			break;
+		case 'l':
+			logger = optarg;
+			break;
 		case 'v':
 			printf("%s\n", VERSION);
 			return EXIT_SUCCESS;
@@ -519,7 +524,12 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
-	l_log_set_stderr();
+	if (logger && !strcmp(logger, "syslog"))
+		l_log_set_syslog();
+	else if (logger && !strcmp(logger, "journal"))
+		l_log_set_journal();
+	else
+		l_log_set_stderr();
 
 	if (check_crypto() < 0)
 		return EXIT_FAILURE;
-- 
2.34.1

