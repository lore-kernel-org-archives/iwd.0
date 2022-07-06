Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8586646
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 22:21:37 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id s206so15174567pgs.3
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 15:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bK+1hhQOyVtvJnFigsHxDF6e/MUMdEEF7UQ1BjC5dVE=;
        b=p5mZOSg+H85CQWNnamGEy1gAAyXVfknXDgQMmXrD++fFMqWg59a+XfOrviUGkMgEN2
         bQq8zHfR61lUZRielt2VVPhuLGGxrhndxCQ1tRneTb0DPkTcYZc9QmXkVjLYkJhL81Qi
         NCUxXJViVU5GHeiJDdydL0vAOC8RkACzB6rb8efrwe0IEOxmDlvcCQ5l0+K40C9t7HjF
         vGOfPWZt8rei+6m3n12d6hiDxgeD2J++tpwIxtqbU+RtQ1WmmF0Liuwm3HNWFhpiqOvJ
         BooNuT1R/90qgjrGcP9A67x2Plp5CQjr5DFEPqhnKoKqJNMt5XAzBi/FJ1IKOwS8roYT
         6K9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bK+1hhQOyVtvJnFigsHxDF6e/MUMdEEF7UQ1BjC5dVE=;
        b=4mL/7Ng0CYsLYOsJbabdIyqHf0qIZxPaq8tPCsj9mxnWjL9VKrkPQLuUS5ohV+5waZ
         USCCowwdYuHKuBbOI7eop0eTU6ZgyjUnlfvZ81YRjSLJ1BhuT0919OQ1Jcg9poOiCqh/
         x2mQDvpZD0UHV7qJPIZoxUOGqrX2c3ErPKyDl41MzCMR9Uqs90cJ5MCyEnhVRNooMPKl
         Mq0Q80p19Wwg7hg57m9q4P0i9rct62RoYBrzw/88cxWFJ3uiSgPw7yo1Nu9UFu8bng9g
         2Px6y5b/IQa5MOmRcD4rNEHtjx/35N3/FTZHzBKpZ3FGsMrkLJZ6ots+HxG9vJYdp/S4
         m68A==
X-Gm-Message-State: AJIora/2ZAp4MoD3pGsj9zrULUT8dnq9n2WF8BU7yeFdnGIiRaqwrsNU
	mkVjv/EWWMK6YhfbvBCIygzx2DHDxRg=
X-Google-Smtp-Source: AGRyM1vwpuRzw4CssGyGLauudfEPjfqAXljQervpnFAp2qHi4+TS3r9kH4V8QkC96xdkHKDbvCJvgQ==
X-Received: by 2002:a63:2a82:0:b0:412:82d9:f015 with SMTP id q124-20020a632a82000000b0041282d9f015mr7814288pgq.447.1657146096729;
        Wed, 06 Jul 2022 15:21:36 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e80900b0016a163d1cd5sm26517696plg.253.2022.07.06.15.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:21:36 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 12/14] client: update device to use display_table_row
Date: Wed,  6 Jul 2022 15:19:05 -0700
Message-Id: <20220706221907.126408-12-prestwoj@gmail.com>
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

---
 client/device.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/client/device.c b/client/device.c
index 5b971883..9f8d731c 100644
--- a/client/device.c
+++ b/client/device.c
@@ -54,9 +54,10 @@ static void display_device(const struct proxy_interface *proxy)
 	l_free(caption);
 
 	if (device->adapter) {
-		display("%s%*s  %-*s%-*s\n", MARGIN, 8, "", 20, "Adapter", 47,
-			proxy_interface_get_identity_str(
+		display_table_row(MARGIN, 3, 8, "", 20, "Adapter", 47,
+				proxy_interface_get_identity_str(
 						device->adapter) ? : "");
+
 	}
 
 	display_table_footer();
@@ -216,12 +217,11 @@ static void display_device_inline(const char *margin, const void *data)
 	else
 		adapter_str = "-";
 
-	display("%s%-*s%-*s%-*s%-*s%-*s\n", margin,
-		20, device->name ? : "",
-		20, device->address ? : "",
-		10, get_powered_tostr(device),
-		10, adapter_str,
-		10, device->mode);
+	display_table_row(margin, 5, 20, device->name ? : "",
+				20, device->address ? : "",
+				10, get_powered_tostr(device),
+				10, adapter_str,
+				10, device->mode);
 }
 
 static const char *device_identity(void *data)
@@ -368,7 +368,7 @@ static void check_errors_method_callback(struct l_dbus_message *message,
 static enum cmd_status cmd_list(const char *device_name,
 						char **argv, int argc)
 {
-	display_table_header("Devices", MARGIN "%-*s%-*s%-*s%-*s%-*s",
+	display_table_header("Devices", MARGIN "%-*s  %-*s  %-*s  %-*s  %-*s",
 				20, "Name", 20, "Address", 10, "Powered",
 				10, "Adapter", 10, "Mode");
 
-- 
2.34.1

