Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E888D138488
	for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 19:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939535; cv=none; b=f+FwlXbFneG6mxsz3v0WxsLK9E1oIwa0k3j5YdUCpl193xQPIwrWR9uaHfBksIMyI2zEr5m4+7nni3APECvtb6JHyNFBk/u/vlXFYQYaR9bt+2e6IBWGxLaez4d9Lx4maOtXF8BL2k+ICOIMnhEpc2zCfs2itVHWv9aftqM+98U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939535; c=relaxed/simple;
	bh=JyNsKP+I/qB+DgwNWT+XvdAENmrt3cBG7GNT1NzO0rM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lXNeW5hoNtBj5hIVQ0wQGpJgSK7uUbPtFmuTZYBFYmXKJih0qgEU7rDVZ3GnvsqNb1QsvsEoWiujL9VA0XEawQlM2iLS+ClLi6fidEI4M8qu5mTyxkFWdXqSfRw7z9aZU5O480VlV/RyDNGJciy47h3topyqun5K2EoZZ3A6fAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgewilgA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgewilgA"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d934c8f8f7so775345ad.2
        for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 11:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707939533; x=1708544333; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxoAzV9F1JlwiHJUV26mJsU1NDAasvYRAeNf4MhWL68=;
        b=lgewilgAY9blI9ukfUk831VdgoNolAkEsWOYrCprNLPVzJx5Q/Q0BMegIu2qzOJwvn
         xXdChqTMzhSAUi/Jle/gLi2/xrdcN8aWZXTr/rVHfPGgOx4jlySVHyAUr26d5EDMgnms
         k3PN3lfAyulnlwZh7hf4oN+xhD3Lo7fHOEpNV+E9IMhO7DAFCAPh1vCQY2zLujmk/INs
         T4XNvj9M8+Q7vQskTaj4RXC7gPEbzimuH4UOC8PJ44WbC2Y8tpGs3ZNUP9H3Za0d85a3
         aNbKhbvTGs70Vhr/gOiFxK7+Jtz8UVCs/P7li72IZXGabwsNvqEVZgs2h4M7n/VZVtjB
         mKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707939533; x=1708544333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxoAzV9F1JlwiHJUV26mJsU1NDAasvYRAeNf4MhWL68=;
        b=nSkn1WoVlbOM0VHPrlDdDbLoHXpdhX+6OTKrGtOdbn6SlWn71/6/O7IxjnNJkKIAT9
         E/S358m54ajbrbMegQaRQq6NaWM27oKxQV97c3XCO7j3tmNkPf8a8sIzuUegdV6WH5lZ
         07I78WbwB8nsXTCDMXQ4PDMjKBYDrWB9vjl0J4NV79kwllXxSi/DlTHFSd4RN0gHyUJO
         IVvGjjD0tlLgb50mb5ImxM2VoekqRalQM1u3wWlwx7kfYewkSr3rsIU3hgmvTmhrwPWn
         cAM6UCz5jX/gDykzS9zKOju05DelKGpTptH2KDevGDdTOF9L7LqX5Z2kn2uEwAVLm/IR
         4Y8A==
X-Gm-Message-State: AOJu0YyB0ESvU1jmSQBdYG48EUbHuwCcBvCvOK80b9C7RbFKjM34YpQq
	mq2kXnT/gMMYCJgrpcp/n2gLUR0lXVVQgKc9dSeIMelCkPhhVhfwB/JVRbb4eWc=
X-Google-Smtp-Source: AGHT+IGer4IvMC/+iq3EyfC+KvFUzLoztPvINSksn227uIgiY64eXF58WrntLcW3gO+9ClV4rlcpDw==
X-Received: by 2002:a17:902:db06:b0:1d9:ca7e:f0a8 with SMTP id m6-20020a170902db0600b001d9ca7ef0a8mr4822627plx.1.1707939532957;
        Wed, 14 Feb 2024 11:38:52 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id v2-20020a170902d08200b001db53ccb856sm1761606plv.108.2024.02.14.11.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:38:52 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 1/5] main: add runtime flag for setting the logger
Date: Wed, 14 Feb 2024 11:37:39 -0800
Message-Id: <20240214193743.963349-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240214193743.963349-1-prestwoj@gmail.com>
References: <20240214193743.963349-1-prestwoj@gmail.com>
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

