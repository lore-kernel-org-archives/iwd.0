Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C571246AE
	for <iwd@lists.linux.dev>; Wed, 10 Aug 2022 23:16:25 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id o3so15557123ple.5
        for <iwd@lists.linux.dev>; Wed, 10 Aug 2022 16:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=JNi+R0Ux3MrRht4PnoVVb8YFjtCK0mjLNj/3g3NIMQc=;
        b=Pg+D36b8Oz48Yzn3dT7MjEypcawvY6vwzsiB/X77cx8F+HSMaBeb5HG8Ny2FoZ+VxE
         qhWhuex5cOw+mwl2lw7xUuoScy8AOYaoRnvWIjvh4w/XWu4bllW1PEs8j3u7MnOlqLWy
         l39EFSZSI1i0ILojkkATAaQBIlx1X3HMWOLkcgvr6+YoHh9J1/fPzka3q3FwDED3/Fz3
         GnJWho++T6lEUJbY69IB2KGMkTNoZm131/kk93isgGF4O/dTjBKtDt/gRzv3SoHkGfnJ
         pX09yr5xjIU/P9ZvF8ba31ba9giYN5MaixhBqYMM4ukRFnhWdIeNl02ESBvxlQS6ZWB8
         TnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=JNi+R0Ux3MrRht4PnoVVb8YFjtCK0mjLNj/3g3NIMQc=;
        b=gY2dEHuvaA3BdMhVtYeKKVTXvZzKkuLDaNJl61PPWf//BWxJE5eF8JPjN2RlvCmvAE
         ZE4yGBXza7kHEqAO9XFOTQHT/ErPoPeUnpBWvbIL7Ubkcl1Y7sOKkKcLejlyHdvC4KHF
         K/D1gRzbVNEkcFk1qUzMvoT/3HQY3V0UVOwVH8e49ZELfZ+SbLBSQdXRwK3aCKq8gcFc
         izt4EmFsSChUhV+27Wks0L+sw1G+xv4fqKiullKaqdvGWqNuLJQZxGUtgzTVkhFpt4/a
         HlzKQf88/h4vBqnhCwZn6sOc2oYEs94Nc/TXlHf/hDRyAetpB+U4ffYkQ2M/o3Rfzs2t
         CDtw==
X-Gm-Message-State: ACgBeo2oPHmG+8eRKqR7aL/B5gUbg3pDI3jKdfSJiZu/w4QmQP2dq6MQ
	E5FSVAmlVEUkLN+YcBSjCVBamQFKMh8=
X-Google-Smtp-Source: AA6agR49e+vVzjVoWCJH02DIdUIJERrF0tclClP4FnLgegzOF24bUq+PMiHM356yGbmLrLrz506S/g==
X-Received: by 2002:a17:902:a416:b0:16d:4cff:269c with SMTP id p22-20020a170902a41600b0016d4cff269cmr29763623plq.5.1660173385157;
        Wed, 10 Aug 2022 16:16:25 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902e84700b0016d62ba5665sm13540246plg.254.2022.08.10.16.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 16:16:24 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/8] client: add developer mode option (-E)
Date: Wed, 10 Aug 2022 16:16:17 -0700
Message-Id: <20220810231621.372514-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220810231621.372514-1-prestwoj@gmail.com>
References: <20220810231621.372514-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This puts iwctl into developer mode which allows IWD debug interfaces
to be used.
---
 client/command.c | 26 ++++++++++++++++++--------
 client/command.h |  1 +
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/client/command.c b/client/command.c
index c0576e97..80599620 100644
--- a/client/command.c
+++ b/client/command.c
@@ -38,6 +38,7 @@ static struct l_queue *command_families;
 static struct l_queue *command_options;
 static int exit_status;
 static bool interactive_mode;
+static bool developer_mode;
 static struct command_noninteractive {
 	char **argv;
 	int argc;
@@ -616,6 +617,11 @@ bool command_is_interactive_mode(void)
 	return interactive_mode;
 }
 
+bool command_is_developer_mode(void)
+{
+	return developer_mode;
+}
+
 void command_set_exit_status(int status)
 {
 	exit_status = status;
@@ -657,6 +663,7 @@ static const struct option command_opts[] = {
 	{ COMMAND_OPTION_PASSPHRASE,	required_argument, NULL, 'P' },
 	{ COMMAND_OPTION_DONTASK,	no_argument,	   NULL, 'd' },
 	{ "help",			no_argument,	   NULL, 'h' },
+	{ "developer",			no_argument,	   NULL, 'E' },
 	{ }
 };
 
@@ -671,17 +678,10 @@ bool command_init(char **argv, int argc)
 	command_families = l_queue_new();
 	command_options = l_queue_new();
 
-	for (desc = __start___command; desc < __stop___command; desc++) {
-		if (!desc->init)
-			continue;
-
-		desc->init();
-	}
-
 	for (;;) {
 		struct command_option *option;
 
-		opt = getopt_long(argc, argv, "u:p:P:dh", command_opts, NULL);
+		opt = getopt_long(argc, argv, "u:p:P:dhE", command_opts, NULL);
 
 		switch (opt) {
 		case 'u':
@@ -714,6 +714,9 @@ bool command_init(char **argv, int argc)
 
 			l_queue_push_tail(command_options, option);
 
+			break;
+		case 'E':
+			developer_mode = true;
 			break;
 		case 'h':
 			command_display_help();
@@ -731,6 +734,13 @@ bool command_init(char **argv, int argc)
 	}
 
 options_parsed:
+	for (desc = __start___command; desc < __stop___command; desc++) {
+		if (!desc->init)
+			continue;
+
+		desc->init();
+	}
+
 	argv += optind;
 	argc -= optind;
 
diff --git a/client/command.h b/client/command.h
index 23f23dc9..bdfc7e99 100644
--- a/client/command.h
+++ b/client/command.h
@@ -69,6 +69,7 @@ void command_process_prompt(char **argv, int argc);
 
 void command_noninteractive_trigger(void);
 bool command_is_interactive_mode(void);
+bool command_is_developer_mode(void);
 int command_get_exit_status(void);
 void command_set_exit_status(int status);
 void command_reset_default_entities(void);
-- 
2.34.3

