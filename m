Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16703664F
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 22:21:29 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id t3so2486247pfq.10
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 15:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DM19MrL0XT/0sC94EUTCmp8xPndF6ZhaP67EriDgwgI=;
        b=DOnGdPO1j9dx1UQZKn9AEpkVrv7bbGxGKoQOYg6iYL0TuKCPV1F6AATbO7k3XXnZw7
         zAO6epIjmPfavKOnyy0GzyBcm/ZzlkGSEfzcCWA+oKykd9QfDsCuHvhQBXsnGSUn/Wr/
         8awUoFXvCILwqxaIzMBpLH8U6rA+SHRMSiC7VyPUuhWsOU1MtFmn3K7nnBDtOvKG8WIv
         cy8uaWgQmHh5z/IOpmwPaQu5cgewTeRmy2CG5AyMD1yqMEal9Ka5SwjCzZEyUyOjDrHu
         i/ADLSN+cwOG0Ydqyr/5yyQw+/lRBq1QUuh7e8gN6/YgGDVex4ibPDmg9puDuILMt/nk
         j/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DM19MrL0XT/0sC94EUTCmp8xPndF6ZhaP67EriDgwgI=;
        b=C0yv3fCehU+aGw5ebAc08TXuVEOoZsFT27RXqN5zyMQvu597Wpv5ITcwvOEMU0kMxY
         DKxqbvh+fJm+quers/P6CY7cCgQw8obPjJEP5Xi1xbdzlUSGz6DwNZ1LMSEIqvvrRX0I
         MUG/qYJyRNL474cQFKnalTI7QJMuFNqtB5qP7TDiOL9r72CguGVLLrcsgEN4UtAWasWz
         VW6/pLvsyOTqIw/Lv9O6XV/S336pe7Low62PiBGqQBIpnMBjFKv/R4WvVuUgj2V8xx60
         6Jr/4diB3tT/q716Pn2GdEJSiY8Qxzn06q4XGCf4m7XdLS0INk1PwHxi4YAvdL5k1pK+
         Koiw==
X-Gm-Message-State: AJIora/of2msx5Wolcll86KTZFpfE2F74yGYyobw7GoER0NRHb0VAbRZ
	5a2PwlfPdymiVMEOKos4tYTqB3ODPUI=
X-Google-Smtp-Source: AGRyM1uF3Tb0NsMYmcpGZD6yvMupkT2fXFn3pMK4wYVt2BOpPPD38t3u77n46mBcfZ+bv/3742qjSw==
X-Received: by 2002:a17:90a:7c05:b0:1ee:e40c:589b with SMTP id v5-20020a17090a7c0500b001eee40c589bmr1122909pjf.78.1657146088221;
        Wed, 06 Jul 2022 15:21:28 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e80900b0016a163d1cd5sm26517696plg.253.2022.07.06.15.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:21:27 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 02/14] client: remove newline/tab encoding from help description
Date: Wed,  6 Jul 2022 15:18:55 -0700
Message-Id: <20220706221907.126408-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706221907.126408-1-prestwoj@gmail.com>
References: <20220706221907.126408-1-prestwoj@gmail.com>
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

