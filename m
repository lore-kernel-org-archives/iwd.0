Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7059201019
	for <iwd@lists.linux.dev>; Wed, 27 Nov 2024 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732728820; cv=none; b=djJgjmArJjKU1AwpeX+mJhaOZoucYUWx8xehvbFOEnAsTN77UmS/pkI7O2UAF5RfQ8Vy67H0MGezu5bwPQqrDTUUQcH3eaWO6P0sss98XJr+H3GFidbKnWNwk0XEZv0xF7ku8af6XiZUSZHxsl+F3jXxFdex9ycONnR7DWwb7Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732728820; c=relaxed/simple;
	bh=G63noPF0CmFLEGQEvGhXroPWXXsDVAPupvvbH1Aslh0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pb3dSvx4mEIHINDeSuhMbctPfhZfiOuAr6qONN1roj+LAScA8sgn7Jb2OSg5kk6CO8W4/dEyFVC9was7Tlj8BjWTJOF5v2wtDozNZxNZSPXmDSv8g+CKNzqr2AGURbgD85KcSXG9p5uLwlkThC8oKF3VZynLJGWxD++5nwtjz9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b33QHgUc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b33QHgUc"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-214f6ed9f17so16578375ad.1
        for <iwd@lists.linux.dev>; Wed, 27 Nov 2024 09:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732728818; x=1733333618; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqQbg3z767lkylc4fof21EsyCBDqgw3MsPqrXDPxyBU=;
        b=b33QHgUcfCFODAOaxUoZJja+FRvBccmyn5+3y7sakbt+7DCAI8Xa1zDn7y3aD0rj7I
         ySs75s19X/0d9iqLjt8HWVFjs4ZZ8i1SC/XVHdX7wPKZsvq3kXxEsPYd0IuznWXF2G11
         w1uzlvNB2XpI40zQ+7jBem0MGD6MsAoHTDcAHl0NHPstR/Q0hKLOt6quexgW1Y3dV5FB
         6u14zHACg0r709Pkhc1KG5Q6mOT4HDd/MAo1qR0FGZfjyPljCFMQPucRNlTY2J+gtWz8
         LUIrQXFEW3aljuSgr6bB4bduABcZsEJYP1eoqvI79lKX+7gkEKOuEsnnMcTI/pSXstfB
         23pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732728818; x=1733333618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqQbg3z767lkylc4fof21EsyCBDqgw3MsPqrXDPxyBU=;
        b=fRglIIpBuOIe+7zA0SdHbHfmfTSihJikUGdu3Wwv/uwrGvYs/t1AnmlTBqGC6VqNMh
         qAdiLR0FbyY3uzCSmhmm2tVrG6TR4uaCpwOQlBb3Ud9ItBa/3BLe6+XmIJLlifXv7M2D
         ybP5VlOrQQSIWj8rv3srH95+DjB7XFXtKWL3FQ6BsIlhriQabo9UbGvrwMd07KjyMZha
         5UN79kZ92pdaIcgwASLeZpLrF7Wme1K/5fqpBzsYunuIvsFaAUVWuyw+7/wzD8Ytz9gH
         soHcuXCp05r4D7sVDWletKL5tLo4Fdw5KGIG4LMsi5mLJToTtW7rQ3HbEcIH8yHZZob7
         6ClA==
X-Gm-Message-State: AOJu0YxFpFXqwYqCRvoWB8gJd3nePNGpZELDP94ScYo5OLU+nsj+f8c0
	kI84cbHEZfPeEtN2r2bzmIJk/j1A4QU2FchqXGBPhbFEE4NYUj36ryrbEQ==
X-Gm-Gg: ASbGncstsj7z8AhevprskrllkJzxwHDsHJLvrhlLYouHvVho0oeAPpYFEnj5uK+n/Zg
	SMXaZF+AoKYcy7+zj8msM6kh1wgj9ZrTN/q+GHI/OEiYF2kgz2VZ9jTR2D2x2fknmOep/mo/MZg
	pDLU4ztSfZy7EA8bK8vOXp/QSDGQJh7r3Yz8XxXmnqx1S+AU5cwU/wFo+7MM1qt15RrPh/fSInY
	KOgdO15CTPHUakBxsA9J8FJiLzuETEjPVZTvPvbtTBzSpEa0i5h/3IdRjtF
X-Google-Smtp-Source: AGHT+IFCTlLlh/svRIy4b3zGnNhjz49LjtOiKGmYiE7IbBqxC8xp1jAw7AUNN/hAdjXwMYSO7iVx8w==
X-Received: by 2002:a17:902:e801:b0:212:67a5:ab2d with SMTP id d9443c01a7336-21501d5df9amr53723545ad.44.1732728817608;
        Wed, 27 Nov 2024 09:33:37 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba3022sm105487305ad.65.2024.11.27.09.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 09:33:37 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] monitor: add --pcap-size,--pcap-count
Date: Wed, 27 Nov 2024 09:33:28 -0800
Message-Id: <20241127173328.158354-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241127173328.158354-1-prestwoj@gmail.com>
References: <20241127173328.158354-1-prestwoj@gmail.com>
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

