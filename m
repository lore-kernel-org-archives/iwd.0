Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9CF20B7E4
	for <iwd@lists.linux.dev>; Mon,  2 Dec 2024 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151291; cv=none; b=OBv5nWdJKw8iiGh9BNrSJziNKLGc04F+B3EvXB8VzNVDy6vauCRAqVVA1nSOKsPGBnfV2mWeUj+fkg2Jrkewy+xBjgQj80DsoS21USY/l7OUvPTJ1N3Fix3AngbzmOmXdJsS4iaGA4l1/Jlfwv9SaWaySOm907HMEwi83dIg0bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151291; c=relaxed/simple;
	bh=G63noPF0CmFLEGQEvGhXroPWXXsDVAPupvvbH1Aslh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M13tcbrkWPdYgzt6m0b7Uc3MeA0IOxGWnsYsToyoV1KVCnfrRWYUXGOAl2Dny3BITdhU1HIDNsWCzksFO+olcWqEOxKQqQLqR7ZLyYv1HliYuL1tXLhbmX+G2HQCO2tiQzp1kWJt3KMuYR4sxJCYcq9pH/GqKd1iKWruR8/Kd14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqed2TmY; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqed2TmY"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7251331e756so4136456b3a.3
        for <iwd@lists.linux.dev>; Mon, 02 Dec 2024 06:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733151289; x=1733756089; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqQbg3z767lkylc4fof21EsyCBDqgw3MsPqrXDPxyBU=;
        b=eqed2TmYdeBjXgM0BL3d+GBHvmWhV0MFidck8gn+fPAC7H2q7wYeC7Rh2m+YANLLbk
         ypPzEeKAR/qFb1LhGYov2aeA7InquYtNeA862R6UKkcz0O4/F8Hq4xGujrWlSRTzcljF
         2LgepkkLas+95JVRvSNpUGNEjLRSGCCkn97/1e0uuKCMIcJRcav5KUZgdVjf2ekzvrdu
         A/gnVu+1JxWZgqcMN9+albfsyvDU9kQHqr8+Nb339iHZa/hfbtrtD5syg2LivugjufqF
         48EJf/0TTlzhF6+GzAeKN7A5PasC/NBN4lteDufFZ0dF23AGx9bbbxOWKy8KKNkdZHhf
         rYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733151289; x=1733756089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqQbg3z767lkylc4fof21EsyCBDqgw3MsPqrXDPxyBU=;
        b=OX1aCP6Uxft3SRSguzp7E4MYI4Fl0SXGH3VPG+bkokd6+6oJddSYP3uRMddW8TdPxE
         bNqcSoo6s7oFOxWJkU1NKUkMt/eGUDEWYuz0SelKD0oZe4LKytK8URrqRkN7Y0NhGiVW
         V7yDyOBeG8bxWx/DnVK03q6dGgsk1YWDIMg1oj+efTIm+He1Ujs1KajELf4U+A9ydLkc
         pQLgrqC5IAHhFYWtRbO07UU1CTtBjU508f/2Gt38PY6Q/k8xavvtQ0hmKDwYfeMUc657
         vsa5DnNhwi4018KlIqrsjNuqRQhXJUARTe3OrEYe1SkXGGdCBui1Myfzsch/quRYsqgh
         RAWQ==
X-Gm-Message-State: AOJu0YwOKXTkNKuBwATMt7jmNfK9Q++mSIQWjI+WKxMVnveVmbE57h1R
	ERzNeptjAObOvNOAe6R3PzXLvz2MX+H6uE6cdX111o1tkWD+3lw3SEtM7g==
X-Gm-Gg: ASbGnctiehPcuK2UNGAfiefJa1PmyjEBvGGSJE8Tw5ilUcdY/GYKIXqcsO+DQ1yve/j
	4DqjcpyTdm6TpXsJs6Ks93+nsNFiIAkCR4WO8KLX/NN4d+Q/Kk2wY2BtFhKxQ6LnTcpdS14dfj4
	b6J5DSKqMAOKnQe1Xf6h5ClDAMh0N9xTKV78/oDkC5eCmbCjugigNc+HGfFdR3RUmGbp3FCslGF
	pcMh7789GInnHe34GtJPuW/kRXaoe84Si000mi11P4bgcfDxK7Wmpe1d2cn8M7KB7i7f/glqas8
	isD6SQJJ
X-Google-Smtp-Source: AGHT+IFOuGrzM5vTaSSSuufEgyK3XJFeXkuq3jdFTLrbdVqtQJESSh7SOMKDU9ebLQmTMza/XZ+g+g==
X-Received: by 2002:a17:90b:35d0:b0:2ee:c059:7de3 with SMTP id 98e67ed59e1d1-2eec0598100mr6408553a91.18.1733151288638;
        Mon, 02 Dec 2024 06:54:48 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee6cec695csm5592474a91.2.2024.12.02.06.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:54:48 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/4] monitor: add --pcap-size,--pcap-count
Date: Mon,  2 Dec 2024 06:54:38 -0800
Message-Id: <20241202145438.282998-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241202145438.282998-1-prestwoj@gmail.com>
References: <20241202145438.282998-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The user can now limit the size and count of PCAP files iwmon will
create. This allows iwmon to run for long periods of time without
filling up disk space.
---
 monitor/main.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/monitor/main.c b/monitor/main.c
index fe40e301..11077cee 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -728,6 +728,8 @@ static void usage(void)
 		"\t-e, --noies                Don't show IEs except SSID\n"
 		"\t-t, --time-format <format> Time format to display. Either\n"
 						"\t\t\t\t   'delta' or 'utc'.\n"
+		"\t-W,--pcap-count            Maximum number of PCAP files\n"
+		"\t-C,--pcap-size             Maximum size (MB) of PCAP files\n"
 		"\t-h, --help                 Show help options\n");
 }
 
@@ -742,6 +744,8 @@ static const struct option main_options[] = {
 	{ "noscan",      no_argument,       NULL, 's' },
 	{ "noies",       no_argument,       NULL, 'e' },
 	{ "time-format", required_argument, NULL, 't' },
+	{ "pcap-count",  required_argument, NULL, 'W' },
+	{ "pcap-size",   required_argument, NULL, 'C' },
 	{ "version",     no_argument,       NULL, 'v' },
 	{ "help",        no_argument,       NULL, 'h' },
 	{ }
@@ -757,7 +761,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "r:w:a:i:t:nvhyse",
+		opt = getopt_long(argc, argv, "r:w:a:i:t:W:C:nvhyse",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -798,6 +802,24 @@ int main(int argc, char *argv[])
 				return EXIT_FAILURE;
 			}
 
+			break;
+		case 'W':
+			if (l_safe_atou32(optarg,
+					&config.pcap_file_count) < 0 ||
+					config.pcap_file_count == 0) {
+				printf("Invalid file count '%s'\n", optarg);
+				return EXIT_FAILURE;
+			}
+
+			break;
+		case 'C':
+			if (l_safe_atou32(optarg,
+					&config.pcap_file_size) < 0 ||
+					config.pcap_file_size == 0) {
+				printf("Invalid file size '%s'\n", optarg);
+				return EXIT_FAILURE;
+			}
+
 			break;
 		case 'v':
 			printf("%s\n", VERSION);
-- 
2.34.1

