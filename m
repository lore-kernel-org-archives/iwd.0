Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC3453BA
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 21:31:03 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id n10so14732578plp.0
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 14:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ld4GeYr+7Z4DNiCGJbPvu22aYTQs3MaFU1OF+dq/0TM=;
        b=QWqcP/5pkcVmFhqZpGKQiEMk3MJvzSGb5WC05VOZfh/NUv58kEo4X8OuDGyd45iG6u
         1OWSl74ep/gumpUzb8wxcGU59XItXEAvJpDfl7WooKTLdxas2RjlhdC4TKwtgNqaL7d8
         Od0w+hoL5q39vBFoYnnZBPCafrcyykrmcJh+F3B3R9qnSMGzlz+1xhqwMJVmQlxHtXCB
         nMK93azQHv82HZOw4J7M6qEIg3bhaU9Mwh7eWp3m4IXVUChDIzcp/GvmDW6aihhklfaB
         dmWlFibU5F3D1nXQnOBonLvBpdwb7F6+88Y/wl6mRUdj7/Zlq9obt2hWgX4hyxJG1Rp1
         4o4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ld4GeYr+7Z4DNiCGJbPvu22aYTQs3MaFU1OF+dq/0TM=;
        b=4fwzzG3DZsdkw2AzWWJpU9hpFMAEO7PaNjUC5p1Ipmq+qr8e7Arr73AAlrS34VcCvE
         ZwFbiiXG9W0QOCB+WSrv2YqroRfKo6aPOWX/YaicE5vfMQhf9odC5I2T5xi7BsTggF7g
         0jpm+JBob/g6ywVjvdaEu+t8jJuhq4hl7yHo/ssoosXW/uY703JVnI/XoiHr2CTZYGtZ
         tw0AX8UuKWfMzSQ8bhrXDFnlOk5Bc/BGNN3qSIs8y+BmbrpN/n0WgWtw6Vw9uBbMxO7o
         Fns8mmeYrvi8IUkAbD0BaBghHsgKtJ0kBa2U9oLY0zZa0I3eKKw83JiS9CbtnPUFowNW
         OWXw==
X-Gm-Message-State: AJIora8LHkPCkZ+5buXANsYpW71KwZ9O+9ZCLuRy1jv8yJbjTGI6m3un
	sqWS0NOGDjQuHCu+VVTFzwoB2gCyUy8=
X-Google-Smtp-Source: AGRyM1uudDvDrNEeKATIVUoh9rjjfaZURFXKFTrqQQ+rkZYA2bZkV0UpYbLZVZL6LCDxnmU1TBcX7g==
X-Received: by 2002:a17:90a:8916:b0:1ef:79be:c9a9 with SMTP id u22-20020a17090a891600b001ef79bec9a9mr913445pjn.28.1657143062786;
        Wed, 06 Jul 2022 14:31:02 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id v6-20020aa799c6000000b00527f5aee1a4sm15347609pfi.33.2022.07.06.14.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:31:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 05/14] client: dpp: display table footer and set to auto update
Date: Wed,  6 Jul 2022 14:28:42 -0700
Message-Id: <20220706212851.92685-5-prestwoj@gmail.com>
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

The table footer never got added when the properties did. In addition
set the 'show' command to update since these properties could change.
---
 client/dpp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/client/dpp.c b/client/dpp.c
index af69d2c0..cd05a33b 100644
--- a/client/dpp.c
+++ b/client/dpp.c
@@ -287,6 +287,8 @@ static enum cmd_status cmd_show(const char *device_name,
 	proxy_properties_display(proxy, caption, MARGIN, 20, 47);
 	l_free(caption);
 
+	display_table_footer();
+
 	return CMD_STATUS_DONE;
 }
 
@@ -297,7 +299,7 @@ static const struct command dpp_commands[] = {
 	{ "<wlan>", "start-configurator", NULL, cmd_start_configurator,
 							"Starts a DPP Configurator" },
 	{ "<wlan>", "stop", NULL, cmd_stop, "Aborts DPP operations" },
-	{ "<wlan>", "show", NULL, cmd_show, "Shows the DPP state" },
+	{ "<wlan>", "show", NULL, cmd_show, "Shows the DPP state", true },
 	{ }
 };
 
-- 
2.34.1

