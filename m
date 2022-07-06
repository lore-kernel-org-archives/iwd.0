Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21A53BA
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 22:21:31 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id e16so2874868pfm.11
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 15:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ld4GeYr+7Z4DNiCGJbPvu22aYTQs3MaFU1OF+dq/0TM=;
        b=gw5coCmQeN/0kIDomkn/LQ+2VnkyOt9kMkM3auFOS0U2Vg0IYpVVDgbFAJe6gZ/EYS
         19EPJS/xz1a2/jxGn113ZCpjI17kUutCF7wUK/NE3EYwNDnRPLn/c0aJYFJ27OCMXyti
         mgoVai6ILdmEgi3ysXsJLZxV3n/MQ0MPf0NOMzOTWMMfschIEN30ixH4YoLwzgN/SBO7
         wF2CmNud9FU8VMaXb/Paq5DFedriImf+EkxyJL3WTScewm+RbHUc++8A7CVt/49+YsdC
         I5goWRuBFcurO0kwqTsG/bnnaTCmnyqnjAiok82A5/nW53YMvLm4KwquO1E79/0Ssbr5
         gnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ld4GeYr+7Z4DNiCGJbPvu22aYTQs3MaFU1OF+dq/0TM=;
        b=xOFdJKeaMsCwcIrXuFYeZDWY8FQWUPXOA0ZD0xFEMIG+UiGvzqRcyEZdIYt4an1gcI
         OFR/ujZKBDpfp6Za1gnO7UGSIXY1Yw5nA7WRJcujkBajHARDEQQJm2sqcbiyNnBsn0d3
         55+jB2p/mvW7WU8L1ZzW53XvJSMGrlYNI7lDv6uwLMdMDaJXjCORvDH+qXFI/m3Xe1r6
         2pS52zA+4d5uLYnTX+aWRWvDPk29aJePtzr1nsGsnFesALyT28u+lUF00S0PnrzZ/vmu
         q4DVzJwd6EdVqvwaQAiSzQUJswK3xLVvY7X/zF241dtRnz51UDgUsdf1CcW1h4EYtZNb
         6xyg==
X-Gm-Message-State: AJIora9LMTMVy8cDJMuiv7QogjNgBLLylw+A9rvfjC+dPdVcyzBY/sUi
	yI3urYsPiS8hGv40lS03JbCpyGxEAWU=
X-Google-Smtp-Source: AGRyM1uX/kyAbJrAsVtoda47jCBWU4RyJogq+VWhj6EWsgO7ymXnKru2AGNPz1oMLh7vO05ovwQzvw==
X-Received: by 2002:a17:902:934c:b0:167:80c6:aedd with SMTP id g12-20020a170902934c00b0016780c6aeddmr50912259plp.97.1657146091024;
        Wed, 06 Jul 2022 15:21:31 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e80900b0016a163d1cd5sm26517696plg.253.2022.07.06.15.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:21:30 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 05/14] client: dpp: display table footer and set to auto update
Date: Wed,  6 Jul 2022 15:18:58 -0700
Message-Id: <20220706221907.126408-5-prestwoj@gmail.com>
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

