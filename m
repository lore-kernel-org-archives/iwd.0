Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCA42563
	for <iwd@lists.linux.dev>; Thu,  7 Jul 2022 17:57:25 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id w185so17188596pfb.4
        for <iwd@lists.linux.dev>; Thu, 07 Jul 2022 10:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ld4GeYr+7Z4DNiCGJbPvu22aYTQs3MaFU1OF+dq/0TM=;
        b=ffbOG9mhL99EfnHxSJEuvCR2pSgXJUotYAtUWv+Z4w+h+dL8h2hK1oHvEADlLkfFDZ
         Ras4JIynv1vBMVfv63jku4kE2grn1UlmuxJ3ujhhzYUJb8eXiHB7wa1pnNscTAuXic7G
         uHSvCD/6fskoGyt7fda8UolxB1PWxMiLHfcY/7eKS5tzkeSw/yWSubbgJWxk8Qy9ETla
         oUrd5V/Gyhu3Kjpfva/kwZaECia2k56qYq5ZxArFp5gbnNDE1MsAiuLG4wjFD4kbyhFD
         SN+IkLHwiGGpXsRttxPzUxLjib/WcL4S/yTOByFsEKvTjUyWmBnIKNXGMiQZACUVPhtG
         SJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ld4GeYr+7Z4DNiCGJbPvu22aYTQs3MaFU1OF+dq/0TM=;
        b=1UiLd64HQHOTDC8JQ8D3wRCJ94xKvJQ19g21yLB9BnDNjF80KTXPV1uJk27ZucReag
         kJ7vBgtx49srx3t20UCbatEnE2LSg3fKCkqNCqXjYoxSxyZQwSA3xoOTdynBvq64ouqN
         YOTqcfL2XdacIIThbVTxLWaRp0Bx0OE62ZrNdy/Dxlc9ujoKln4WmnnvV6Jdl9NfnCGd
         Q17QzYUtZqnKpE2V+tSPvVSwpiwV9ucJ2/1VJnPuDD+dStstCPCawSG0CXOjlQ1W2uSs
         LcTIrlteG56YzCarR9jLJRBY/RvCcp/P4aMvgagWLKGbRaRBo2c8cAC7jM8w9nVfcx2Z
         qkjw==
X-Gm-Message-State: AJIora+jWKQhHXEU61QeUzMKTSgj0yNBZiw4Jhh+IUZp7TNakr45Njk4
	nG08vQ4dhNmIRMIqdLMzapAAQU+tOaM=
X-Google-Smtp-Source: AGRyM1ssx5OGQt77vOfWWbR6o4x7+MWbMIn7PI3HHG+ni8Vo1kz0SZay9kmdya92H006YD8P8O5YKw==
X-Received: by 2002:a17:902:dad1:b0:16c:1c97:27fb with SMTP id q17-20020a170902dad100b0016c1c9727fbmr1693923plx.11.1657216645373;
        Thu, 07 Jul 2022 10:57:25 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b001618b70dcc9sm28855223plg.101.2022.07.07.10.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:57:24 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 05/14] client: dpp: display table footer and set to auto update
Date: Thu,  7 Jul 2022 10:55:02 -0700
Message-Id: <20220707175511.224597-5-prestwoj@gmail.com>
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

