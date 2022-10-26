Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770EF28F7
	for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 20:46:03 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id g129so14493419pgc.7
        for <iwd@lists.linux.dev>; Wed, 26 Oct 2022 13:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoFUhreknnRKQKZmdhhSy2y1cLlsFXZERk4ePe3/CJc=;
        b=qh82/WhHSbljeUJK1ajSFsPe1WJAiYN5VakKlNEtjwwwtaDX3AgWA7RsGPMOefhKaV
         8zRVQYQ39R83ffjZtptZ3BCdNHsfqhmFH0y3VLMItr7THA/xTFY3O+nFlWHpiIf9Moye
         phN5wtBhKAMEjxs+8sxSUsC6Koh9w/aAON2chjh1Og/eLHaBPwjWpRz0Z4VrqjvjWGJa
         4GRa0C5j9fbNMxyqhTzvHgE1hh/M9R2WZwVpTEVCfsKdTce7H2CAV6dJfSkFpkmWwFTl
         VA/3oPIsZkcqrjqxzo2jLn4JxQ10J5tnbw+KCPFD1L9r8ZfKiut2n1ajCrwGnF1VXqz2
         Gx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoFUhreknnRKQKZmdhhSy2y1cLlsFXZERk4ePe3/CJc=;
        b=0rUGiHZLdRstv6eZDyziavk67bcgJZbK+7s5TqubCg4GUJEdBBKBgu6ek/Xo0I6GN/
         ZaB8/vFEluDdaOTmKXjWWPWlk0kPy8i5clwDYhC+8uLZO/Lh1Yrha3/Yc4ytUYi1UphN
         rwLapj35noxHnIqxkWBnGBpH6OWlIr+UtekhA+WZYypSFX4byryM7imKrxlZw5AeaUg9
         ZH5wHWenCIe4P3JUlyqGrMW2xFtujRopCKEhYmkCaRD0Dmv52tM09eb9bL2xnX3KZO2W
         yJ34PZJeQXCdFkbN/mRJ+n+nHp9oSW1dEX8jdGcN7TP+k/hn7KnDwKS2P1JxxHwq2SXN
         gs3g==
X-Gm-Message-State: ACrzQf3tZM30Kn/0qlbdS5xV4eKa5uwsJtzmZ1m0m7h52DI/rkUhKYex
	VnWcycjDE4tWfCXXb8+PoP3uNiKdtlo=
X-Google-Smtp-Source: AMsMyM5ETaV9TfXtIYEFC4yXJ5g0Xnw1ZzLuD6ut1uDfA3O2JcZntIe6ygZ6JS9D/gxgxj3i4qWx7Q==
X-Received: by 2002:a63:5950:0:b0:459:35df:3014 with SMTP id j16-20020a635950000000b0045935df3014mr38651536pgm.325.1666817162610;
        Wed, 26 Oct 2022 13:46:02 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id i27-20020a056a00005b00b0056203db46ffsm3510588pfk.172.2022.10.26.13.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:46:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/3] monitor: remove -F option
Date: Wed, 26 Oct 2022 13:45:59 -0700
Message-Id: <20221026204559.502432-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221026204559.502432-1-prestwoj@gmail.com>
References: <20221026204559.502432-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is now handled automatically by setting read_only which
bypasses the family ID check.
---
 monitor/main.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/monitor/main.c b/monitor/main.c
index 0cbab179..0c5f0670 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -569,8 +569,7 @@ done:
 	return exit_status;
 }
 
-static int process_pcap(struct pcap *pcap, uint16_t id,
-			const struct nlmon_config *config)
+static int process_pcap(struct pcap *pcap, const struct nlmon_config *config)
 {
 	struct nlmon *nlmon = NULL;
 	struct timeval tv;
@@ -587,7 +586,7 @@ static int process_pcap(struct pcap *pcap, uint16_t id,
 		return EXIT_FAILURE;
 	}
 
-	nlmon = nlmon_create(id, config);
+	nlmon = nlmon_create(0, config);
 
 	while (pcap_read(pcap, &tv, buf, snaplen, &len, &real_len)) {
 		uint16_t arphrd_type;
@@ -696,13 +695,12 @@ int main(int argc, char *argv[])
 	const char *reader_path = NULL;
 	const char *analyze_path = NULL;
 	const char *ifname = NULL;
-	uint16_t nl80211_family = 0;
 	int exit_status;
 
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "r:w:a:F:i:nvhyse",
+		opt = getopt_long(argc, argv, "r:w:a:i:nvhyse",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -718,26 +716,6 @@ int main(int argc, char *argv[])
 		case 'a':
 			analyze_path = optarg;
 			break;
-		case 'F':
-			if (strlen(optarg) > 3) {
-				if (!strncasecmp(optarg, "0x", 2) &&
-							!isxdigit(optarg[2])) {
-					usage();
-					return EXIT_FAILURE;
-				}
-				nl80211_family = strtoul(optarg + 2, NULL, 16);
-			} else {
-				if (!isdigit(optarg[0])) {
-					usage();
-					return EXIT_FAILURE;
-				}
-				nl80211_family = strtoul(optarg, NULL, 10);
-			}
-			if (nl80211_family == 0) {
-				usage();
-				return EXIT_FAILURE;
-			}
-			break;
 		case 'i':
 			ifname = optarg;
 			break;
@@ -799,8 +777,7 @@ int main(int argc, char *argv[])
 			fprintf(stderr, "Invalid packet format\n");
 			exit_status = EXIT_FAILURE;
 		} else
-			exit_status = process_pcap(pcap, nl80211_family,
-							&config);
+			exit_status = process_pcap(pcap, &config);
 
 		pcap_close(pcap);
 
-- 
2.34.3

