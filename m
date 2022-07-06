Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBB653BA
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 21:31:10 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id o31-20020a17090a0a2200b001ef7bd037bbso11635878pjo.0
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 14:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rRdtgstkk3/2WInkCaBSCRTBij0JsCS6mhIC+ypjjWA=;
        b=kCM38qZ8y0kNhnHaUHJ8jz79GrHgXjgeKoI3n35f2CQEJ9q7zW5rVXO0h3MUYP6q9A
         lfZ2uFl7vk/K7gCw2z9QA9T58NIIZauqStYbn8I1vf+VPEkCcdb8SSls50ykdpj1qES0
         eJzMy/X4RPoppFf9tNDHhdqBt+URfWwGTeKMtsYa4Aq2Ixl+1dAg2Z/h/IlGs5klnd/E
         ca+0SlU03VRWocsPHZ78+HlcItxQX7QcKdnc9gf+d90c36MOvGw1BlsjlRxx65HbtHXR
         ZsX04TnqZX6XhZ8gCuE+I/0GA5B22tdxdmYBQJBHYvUFP1EgsbvOYADX5XIL89/sbn1C
         xQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rRdtgstkk3/2WInkCaBSCRTBij0JsCS6mhIC+ypjjWA=;
        b=4WPt4C4288Zn0HipIn7IL89TyYrShyfTBKNTD53CMvSWgiuNKnlrs56nNVZuAJEYE9
         XPShTuSNy5gemgQMMgWC3yF2EyzP+w+Bn3P8xZABaEuI3XaUDbyAAYehy+gdVEaiHwGs
         dJNeyGSeR8LJ0GyN4vwUBhlU9qjTc44NDdcs/Y3RugXq/36OV3HYCk0MFTbxyi0UGF+i
         XdWTy1I7Rb/gE2s4zoHVpN+qMc/kcaGn9KVkk7KYXFLknKEqiX9mx/pyUnx8R4hcxe98
         mz/KUeYweWfpQl2OfxVnwuqcccF1PV8xQAhb3HTvlvfEimBroanedSAIoXYS7N8fQTVx
         hBXA==
X-Gm-Message-State: AJIora+7Rz/8AXmnikWtk9FNlaJQbAe4S7B2Lja0HLBa2lWcMI5Wd8gD
	r+A7Hs/0QYfp+tBk4rHUIBjUArjli6U=
X-Google-Smtp-Source: AGRyM1ur8KwEFWErTC9V1oInBJZH5K+3OusyDsybBckChMUqPH3geDfEsr4egMKlxZFbKtWCePt91A==
X-Received: by 2002:a17:90a:9a8e:b0:1ef:7c8f:4522 with SMTP id e14-20020a17090a9a8e00b001ef7c8f4522mr828392pjp.151.1657143069716;
        Wed, 06 Jul 2022 14:31:09 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id v6-20020aa799c6000000b00527f5aee1a4sm15347609pfi.33.2022.07.06.14.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:31:09 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 11/14] client: update command table header
Date: Wed,  6 Jul 2022 14:28:48 -0700
Message-Id: <20220706212851.92685-11-prestwoj@gmail.com>
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

