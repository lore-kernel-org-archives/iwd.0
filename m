Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE962588
	for <iwd@lists.linux.dev>; Thu,  7 Jul 2022 17:57:22 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id 145so19846845pga.12
        for <iwd@lists.linux.dev>; Thu, 07 Jul 2022 10:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DM19MrL0XT/0sC94EUTCmp8xPndF6ZhaP67EriDgwgI=;
        b=Rv6Y3UikDfrFpd6c1f1A6LOPQBjGQF9nYOzC5Ij6K98bhv4LRsFr9I64C/Y0G4Ycjc
         qN2YYibmr9vxpe4JgzCVM8MH13fkw+v4HGWOgJG3K8yATzJFO2bUJYCPYtsdjQ2oUsgc
         GmfFE8K8uzH1Uob5QxNYjjCZVNnfVNZvdxHUpMLriSsCvnVEzFRI3GOI2ujBruFkrB6n
         IrFDPy8GiCm+oR+yMSE8JuNZHVA7he06j34LLqdyph8amUPjEvz7yWhm1Cz4pCcAlxUS
         CK8G06n94bGB+00Qy2D0Fmr08WO0BpIG8+Y72fysU/VY9oGnpY7iuauyUpVWwpsM5wS+
         Xi7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DM19MrL0XT/0sC94EUTCmp8xPndF6ZhaP67EriDgwgI=;
        b=0GtTe5nCxQPQbLWGMCIQME4eW6LjE/rWe3lG9GqGQszX9FkvWHe8oPl7Jo3xDsK6ec
         U3YqyNF0R4AiMnt22p6Z+YI7z4N/n/icZRm3ZXnrw6V9C13ZEkRUmhMmNlrVbqTc4YI+
         6YxcaRqjWar64Uda9S6ElzKPV0OtKRt8vnR85vl/fcrEliTcAnrIUz2gRmdwdc/aF9Wv
         IrgE0yHrfwXzKrU91zCVk5RJEmEqx87aAuPRhxxbKyPygT4twdvL41IPp3Wu5lbmKt3l
         6z1/XWXmd+h51DgBEoHNqFuIvrSbExyYttw0lUF3BgBB3mD64hECptrmZSPSl2cHlpD2
         Ac0Q==
X-Gm-Message-State: AJIora85HbZvwGehzzJUvyx6mp6Fw8Dv/djcRFCcXXz1r++AxqXJy441
	+ACO5pkF7LAtpfZ5y6aNAXYqG2bq6EU=
X-Google-Smtp-Source: AGRyM1vwzz+o+8MXlp5bbH9Kw9ouLUvhF8RO7dIDeyN95deLlRvtbofQqStO/80p5myxJ4M8ZiL90A==
X-Received: by 2002:a17:90b:4f8e:b0:1ef:9e43:790b with SMTP id qe14-20020a17090b4f8e00b001ef9e43790bmr6423935pjb.220.1657216642273;
        Thu, 07 Jul 2022 10:57:22 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b001618b70dcc9sm28855223plg.101.2022.07.07.10.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:57:21 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 02/14] client: remove newline/tab encoding from help description
Date: Thu,  7 Jul 2022 10:54:59 -0700
Message-Id: <20220707175511.224597-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220707175511.224597-1-prestwoj@gmail.com>
References: <20220707175511.224597-1-prestwoj@gmail.com>
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

