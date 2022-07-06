Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF3453B8
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 21:31:00 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso11635484pjo.0
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 14:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DM19MrL0XT/0sC94EUTCmp8xPndF6ZhaP67EriDgwgI=;
        b=J3KgOvycmaErIALRO7UT52728btq7OpS7z7yn1nuCUomL1qFYWNryWMpG5VfIEr5pJ
         PdXAkyMPyRWHNIWRFswIKXj+W4/hIeX5Njta2XarD2EQszkMY+6nNed2F7WdTEOof3zd
         Qw3CRuNqPbQ3GV/vmzNKGrcBd4wyRrhYJB6F+81lEuy1uMAooyBOab4/5at3IqG1YETB
         IBZvwScuALdhpP9KLV1PtY6f5kTHKaW5Mh3+ZXoSIPiOntZvbuW+flBIunpOMnG1RU00
         4AJ3fT3LsNhPgrTvPmT39FVv8isNj9zOKKCQhXfa3QuF/lMu2z4GOaAYlHRbEmjycZ6I
         0/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DM19MrL0XT/0sC94EUTCmp8xPndF6ZhaP67EriDgwgI=;
        b=5hliy74yzKJvpyKTc+jr7DE9LGr0scWVn29NRpcBvs5dYkfHvBvJJsA+CJlTB5cLmn
         elU6vWBxtOeUoNUb/WYo4zR6Au/Yk1Kv90xFsNYp2VqXyfbNc3KJmleimw+2ZzRtgDrW
         nXCE2n3UaqItWNgDde2uMe3r06KYjw1Ju+qWfFlngIRqQ+eh+x1pWg6X5glruVODWUg8
         /mWlCfhiQ+ZAMbsOeEj6dZjVBGEp5GnEyx6q4F83wvMEqjtjhN/EwhW46ikRdpTWSmzu
         QoMuFnuH5FBaZUG6lHuuv6HipTNZyr1I2Q8lUzP27FiB0uWx/kK5VSzSd55HjCAraBg1
         4lKQ==
X-Gm-Message-State: AJIora/vGp4lNMNd01XKHkEpLBrTSdG/wO3Jnbe5M/X1jVEOVSgaUycP
	JmIDS/opRJUr4lz8QogMHvxixfeBpwA=
X-Google-Smtp-Source: AGRyM1sn/H6gyGUecBUyyRP5oy4OaQRQP1/Eyoi3zDbLyj+izudyhFzBMcNRGMTH4Rpr3RZpRBUVTw==
X-Received: by 2002:a17:90b:1a8c:b0:1ef:c1b2:b2cd with SMTP id ng12-20020a17090b1a8c00b001efc1b2b2cdmr855112pjb.190.1657143059485;
        Wed, 06 Jul 2022 14:30:59 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id v6-20020aa799c6000000b00527f5aee1a4sm15347609pfi.33.2022.07.06.14.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:30:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 02/14] client: remove newline/tab encoding from help description
Date: Wed,  6 Jul 2022 14:28:39 -0700
Message-Id: <20220706212851.92685-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706212851.92685-1-prestwoj@gmail.com>
References: <20220706212851.92685-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ad-hoc, ap, and wsc all had descriptions longer than the max width but
this is now taken care of automatically. Remove the tab and newline's
from the description.

The WSC pin command description was also changed to be more accurate
since the pin does not need to be 8 digits.
---
 client/ad-hoc.c | 11 ++++-------
 client/ap.c     |  7 +++----
 client/wsc.c    |  4 ++--
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/client/ad-hoc.c b/client/ad-hoc.c
index c90f9dd6..33bff9ca 100644
--- a/client/ad-hoc.c
+++ b/client/ad-hoc.c
@@ -215,14 +215,11 @@ static enum cmd_status cmd_stop(const char *device_name, char **argv, int argc)
 static const struct command ad_hoc_commands[] = {
 	{ NULL, "list", NULL, cmd_list, "List devices in Ad-hoc mode", true },
 	{ "<wlan>", "start", "<\"network name\"> <passphrase>", cmd_start,
-		"Start or join an existing\n"
-		"\t\t\t\t\t\t    Ad-Hoc network called\n"
-		"\t\t\t\t\t\t    \"network name\" with a\n"
-		"\t\t\t\t\t\t    passphrase" },
+		"Start or join an existing Ad-Hoc network called "
+		"\"network name\" with a passphrase" },
 	{ "<wlan>", "start_open", "<\"network name\">", cmd_start_open,
-		"Start or join an existing\n"
-		"\t\t\t\t\t\t    open Ad-Hoc network called\n"
-		"\t\t\t\t\t\t    \"network name\"" },
+		"Start or join an existing open Ad-Hoc network called"
+		" \"network name\"" },
 	{ "<wlan>", "stop", NULL,   cmd_stop, "Leave an Ad-Hoc network" },
 	{ }
 };
diff --git a/client/ap.c b/client/ap.c
index bb583397..b992c792 100644
--- a/client/ap.c
+++ b/client/ap.c
@@ -416,12 +416,11 @@ static enum cmd_status cmd_get_networks(const char *device_name, char **argv,
 static const struct command ap_commands[] = {
 	{ NULL, "list", NULL, cmd_list, "List devices in AP mode", true },
 	{ "<wlan>", "start", "<\"network name\"> <passphrase>", cmd_start,
-		"Start an access point\n\t\t\t\t\t\t    called \"network "
-		"name\" with\n\t\t\t\t\t\t    a passphrase" },
+		"Start an access point called \"network "
+		"name\" with a passphrase" },
 	{ "<wlan>", "start-profile", "<\"network name\">", cmd_start_profile,
 		"Start an access point based on a disk profile" },
-	{ "<wlan>", "stop", NULL,   cmd_stop, "Stop a started access\n"
-		"\t\t\t\t\t\t    point" },
+	{ "<wlan>", "stop", NULL,   cmd_stop, "Stop a started access point" },
 	{ "<wlan>", "show", NULL, cmd_show, "Show AP info", false },
 	{ "<wlan>", "scan", NULL, cmd_scan, "Start an AP scan", false },
 	{ "<wlan>", "get-networks", NULL, cmd_get_networks,
diff --git a/client/wsc.c b/client/wsc.c
index 39950453..1e5912ce 100644
--- a/client/wsc.c
+++ b/client/wsc.c
@@ -182,10 +182,10 @@ static enum cmd_status cmd_cancel(const char *device_name,
 static const struct command wsc_commands[] = {
 	{ NULL, "list", NULL, cmd_list, "List WSC-capable devices", true },
 	{ "<wlan>", "push-button", NULL, cmd_push_button, "PushButton mode" },
-	{ "<wlan>", "start-user-pin", "<8 digit PIN>", cmd_start_user_pin,
+	{ "<wlan>", "start-user-pin", "<PIN>", cmd_start_user_pin,
 							"PIN mode" },
 	{ "<wlan>", "start-pin", NULL, cmd_start_pin,
-		"PIN mode with generated\n\t\t\t\t\t\t    8 digit PIN" },
+		"PIN mode with generated 8 digit PIN" },
 	{ "<wlan>", "cancel", NULL,   cmd_cancel, "Aborts WSC operations" },
 	{ }
 };
-- 
2.34.1

