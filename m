Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443B814AD33
	for <iwd@lists.linux.dev>; Thu, 22 Feb 2024 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615505; cv=none; b=rn27RbjT68A88sIs4KZfrYISs8aSl21XmKcaERTeiWexT2+/DKZ9dbe1ZohniS9jCaP/e9NJJMJ2SMx3cEtD6wzSYKZQdrutrt0+fnfbZdCH1qg2okma6gfdFNcVZM4MLTXEiU3P4tvooXoDz3pD1txWThCLCgIP/NCDauOKvqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615505; c=relaxed/simple;
	bh=JyNsKP+I/qB+DgwNWT+XvdAENmrt3cBG7GNT1NzO0rM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oLDfowkRFFFRPGbA5hqph3llaglYYFPbAqZj92pcnTRKxmEI6n3OO5RePyvXAt7EZeLs03CVgl2UuSVPLrcluIiqmOA1kKQz+udEf8YBD/ebuPH6ZwlnfwWX3Zshu3p6c66d9lZgTHBITpofGCNhLB+pPG9TQXgxuavllXRxNBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbnP5kGE; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbnP5kGE"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d932f6ccfaso67460765ad.1
        for <iwd@lists.linux.dev>; Thu, 22 Feb 2024 07:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708615503; x=1709220303; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxoAzV9F1JlwiHJUV26mJsU1NDAasvYRAeNf4MhWL68=;
        b=YbnP5kGEuKEgGFpx22iEv80kKev10cLZgmbpbc8gMO26wfrAy5C8fJraCTdUKRkHc3
         R5MNsYJPzRxEgHUPaxrSASk7EQiIVdNQeCkym+oKBIFzS7mESHqfSw8pFreRz8Dn8T+U
         pqsCNIMqBZ5aNVt6dmGAr2LbLqiubH5uOUIRpx9mz2hb/nLoNakd5D5MeTbg01Wu0CK/
         w65p5TIFmUNwK0p5OFumE8zObaSlR/9SECQxfeL4AGrLaa15L5osKlFVZp1sDxL+JUux
         b8m2xkHIWgVNC9g4yg1QqVoAgQMWiJxGefV6+T6fV8gTO0/aCLAHxCLqpWHdqafLtjs3
         YAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708615503; x=1709220303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxoAzV9F1JlwiHJUV26mJsU1NDAasvYRAeNf4MhWL68=;
        b=Z49H5a5MgwWOHzxuUJPeEFZu6f+5aVRuAp6Gml4AGtlnIdizuJ/q2hS5YisDvB7Mmt
         EQTyjHxdlwylCC2xm4DjSqT8DgzIh00F94sF+T1MckiwQ+R/Pklr4CYxeDXnAd4ecEtu
         3BJoWwJSeqHZmIy89AELeiFqJ8lqaetZBDrYz23DiEOafirWK2c4GDm39k7z5T2+8BK5
         Oi1RP0FhthAVzlYCh4X+xUoTyK8dTLjLcWOn21JUPwy4Hc8Xj7VKx3WwZqlDiyuSdLup
         z9gzsaSDnaXtv7zodzVQA1QZdDs0ZPavzDV+8yL+2ZBI1kvytykAKK8+r8sjwUUfL16p
         sh/g==
X-Gm-Message-State: AOJu0Yz+eSq9b0dmvSTmLY0WwAZ8LY+JSlX2zoMAifsLIgaBjJjv2srT
	HLqidtZnfrzJrEU8d5PV4faVU3uCehRVZI6qGdTTXhA8jIP+de943JuYQCKc
X-Google-Smtp-Source: AGHT+IHx/HZLeWtBp82jlNYXn7l2FbEOxMx4Nnx2y2mmBErqyvpaGvtvoQrXSQ126QUvJN31iE7qaQ==
X-Received: by 2002:a17:902:eccf:b0:1db:f513:28cf with SMTP id a15-20020a170902eccf00b001dbf51328cfmr14951285plh.23.1708615503195;
        Thu, 22 Feb 2024 07:25:03 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id jd20-20020a170903261400b001d94a3f3987sm10044873plb.184.2024.02.22.07.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:25:02 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/7] main: add runtime flag for setting the logger
Date: Thu, 22 Feb 2024 07:24:47 -0800
Message-Id: <20240222152451.1541682-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222152451.1541682-1-prestwoj@gmail.com>
References: <20240222152451.1541682-1-prestwoj@gmail.com>
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

