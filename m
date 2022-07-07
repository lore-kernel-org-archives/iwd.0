Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001EF2599
	for <iwd@lists.linux.dev>; Thu,  7 Jul 2022 17:57:35 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id 70so5807920pfx.1
        for <iwd@lists.linux.dev>; Thu, 07 Jul 2022 10:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rRdtgstkk3/2WInkCaBSCRTBij0JsCS6mhIC+ypjjWA=;
        b=aOMdTn5TNwGCoAVni+Yp6aZcHAAfr0nVpwDBW7E8VZUelj6kMPslO2Ps0/tuZruNRA
         VuA3/NCKX9Jbif8xe7bJJ9GtoEqLBIF7axPkymQmTCbNRtZv4iu5qSiwr3jr/7mWJzDH
         E3eyAt/ArcU7x2XdKvTA71XNMqYpfufmJxcJbbve0XfjELr2eERAX93BdonRsk1du+qk
         IBsaPjFW50nS350cH0547TwimiZHTGjS17cInhEPFbyBSPLmyH7e+NyqsbZvLDZLWFRn
         Fgilly9lh+PWYgUa6ieNzp9tUT7VQ9ocgLlvNygD+IlFrGQzRfXBkWrb/rvHtaJZGkyK
         Ut8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rRdtgstkk3/2WInkCaBSCRTBij0JsCS6mhIC+ypjjWA=;
        b=6tiVLnhJH439g7bm1+dI1lhokW9MdW/uWEVx1aAeZ7p7ghH8VTWNfA6SDuyzX1IX6I
         1sXxWzO/YgxLfgd2Yr/rfxMdYtLwt9o4L3XsRzCdX7tNLRO85u9Ksk9igVX4duYdZw0D
         qRfjUymAxNNPqtqGV8qcHjwb9/kd6kfgr2pRCkZvp/ahKKC3FYu0ct3vDAMenOwor6Nu
         D5hgbaFKXVMom4qUtlMUf9R4P5tg7iXkXqjjyy057H2tMiRxWSsrvXD70Q366KLCEeZG
         73GRB9ShdoHiO9QZT+7y2XJfBQ/ImZdhBZnhvqgVxe/gtAUoOGDXFf7Ojf3Kar+Pg6n2
         5/tQ==
X-Gm-Message-State: AJIora8RoTvh27/buUeRArJ8oO90W7dexsHSocx0vMBCbvWAbS0wV0PC
	td1z6FtgX0quS6Gg4nG92S+gCvWg6Jk=
X-Google-Smtp-Source: AGRyM1ucxqDwKHx5o+GgPAhoxZoB13V8M5XhHun1XW16IiZ1aaF0xvebICGtZ9p7UhCs4dgp/RjjQA==
X-Received: by 2002:a17:902:ec8b:b0:16c:1cc2:6794 with SMTP id x11-20020a170902ec8b00b0016c1cc26794mr1582688plg.17.1657216655098;
        Thu, 07 Jul 2022 10:57:35 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b001618b70dcc9sm28855223plg.101.2022.07.07.10.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:57:33 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 11/14] client: update command table header
Date: Thu,  7 Jul 2022 10:55:08 -0700
Message-Id: <20220707175511.224597-11-prestwoj@gmail.com>
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

