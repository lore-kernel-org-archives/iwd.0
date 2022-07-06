Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AFE53BA
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 22:21:36 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id g126so1225107pfb.3
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 15:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rRdtgstkk3/2WInkCaBSCRTBij0JsCS6mhIC+ypjjWA=;
        b=XfLlNlAHR/XXarLS2hlkrKE+5pkd39gPQwiKpSge2nMbf2uIqrRl1HF7GjrTq2IIAm
         pfe0eqbfsaSoEfITb8IvobBMT659z4yE1TfY+K+KYSt36yj2phcb4dcYwKnvvW9AODo2
         Ka41I9TRbomyQ29jy0aQ7qDg/grxwbHDJQTlH3259bgVcw9MLKyqGN1Fm024ywx62cUd
         QJw7hFlKV1ZJnAwkvv+1taMIj9AmRDx4BXqiCDEMycTG89R1IintHZSe2IMmL8mijTXe
         P48I1tPLlhBWFYbQMr83kGcVlL3m9mQmUwo5JPb4nxYuhb0kkoRhUFK/fueob9Z0ud0s
         dZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rRdtgstkk3/2WInkCaBSCRTBij0JsCS6mhIC+ypjjWA=;
        b=JcqjDQ9G4OgpaC8zbi9p9q8WZftRZzZNTSevFGYD1i97GOg1DApToODtx9to4+lAJ2
         fcFdkTWl4eWhxMFJxGae4OwYJhgdhAYydwaG0oVIzi7ArPvYSEyqfToVr0rqln5m10/u
         IGofnFzsjQSGwSuR79ErHEj0UCbvM+o193/naKOdkT2b6KTwADJRzIJKJDgf4OwlnVh1
         mIP+h5IXPvcohNsudVgZRMurSC/rGicJ+iJOvqoJ8Xa8DytcOorM7WEYQs6Y2ubj1Vu+
         pPzk15yeKjBdad4olVuhHm6j6GbbpUQvGsB/BfqPbY4C68Ezycq8P6jCp/BkfTqttUIK
         bd3A==
X-Gm-Message-State: AJIora/2LlSDCQFqvZgaz6h8IA4GK56PXcusC2HGJ5CFyGgFldGXHXuE
	D/zwV6YcW9EJMqGXpuBBypkc4DeioXE=
X-Google-Smtp-Source: AGRyM1teE/75/hxh3hZ4K/Nvrvr/DMjNVVbY7xFqBLc5W4OEFOwBgCEZl0/oug5eezC2OcT2ue1bGg==
X-Received: by 2002:a17:90a:a884:b0:1ef:8eb8:7473 with SMTP id h4-20020a17090aa88400b001ef8eb87473mr1048877pjq.161.1657146095961;
        Wed, 06 Jul 2022 15:21:35 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e80900b0016a163d1cd5sm26517696plg.253.2022.07.06.15.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:21:35 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 11/14] client: update command table header
Date: Wed,  6 Jul 2022 15:19:04 -0700
Message-Id: <20220706221907.126408-11-prestwoj@gmail.com>
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

The table header needs to be adjusted to include spaces between
columns.
---
 client/command.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/client/command.c b/client/command.c
index 74f11c4a..c0576e97 100644
--- a/client/command.c
+++ b/client/command.c
@@ -509,16 +509,16 @@ static void list_commands(const char *command_family,
 
 static void list_cmd_options(void)
 {
-	display(MARGIN "--%-*s%s\n", 48, COMMAND_OPTION_USERNAME,
+	display(MARGIN "--%-*s  %s\n", 48, COMMAND_OPTION_USERNAME,
 					"Provide username");
-	display(MARGIN "--%-*s%s\n", 48, COMMAND_OPTION_PASSWORD,
+	display(MARGIN "--%-*s  %s\n", 48, COMMAND_OPTION_PASSWORD,
 					"Provide password");
-	display(MARGIN "--%-*s%s\n", 48, COMMAND_OPTION_PASSPHRASE,
+	display(MARGIN "--%-*s  %s\n", 48, COMMAND_OPTION_PASSPHRASE,
 					"Provide passphrase");
-	display(MARGIN "--%-*s%s\n", 48, COMMAND_OPTION_DONTASK,
+	display(MARGIN "--%-*s  %s\n", 48, COMMAND_OPTION_DONTASK,
 					"Don't ask for missing\n"
-					"\t\t\t\t\t\t    credentials");
-	display(MARGIN "--%-*s%s\n", 48, "help", "Display help");
+					"\t\t\t\t\t\t      credentials");
+	display(MARGIN "--%-*s  %s\n", 48, "help", "Display help");
 }
 
 static void list_cmd_families(void)
@@ -542,12 +542,12 @@ static void command_display_help(void)
 	display(MARGIN "iwctl [--options] [commands]\n");
 	display_table_footer();
 
-	display_table_header("Available options", MARGIN "%-*s%-*s",
+	display_table_header("Available options", MARGIN "%-*s  %-*s",
 					50, "Options", 28, "Description");
 	list_cmd_options();
 	display_table_footer();
 
-	display_table_header("Available commands", MARGIN "%-*s%-*s",
+	display_table_header("Available commands", MARGIN "%-*s  %-*s",
 					50, "Commands", 28, "Description");
 	list_cmd_families();
 	display_table_footer();
-- 
2.34.1

