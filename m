Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9E75385
	for <iwd@lists.linux.dev>; Tue, 26 Jul 2022 17:09:27 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id w7so13878702ply.12
        for <iwd@lists.linux.dev>; Tue, 26 Jul 2022 10:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nSDFxzgCBZiCgNlewWaW6PVPMdCZ0EHWwfb78WuBIDA=;
        b=SwCRIUd7L6FfRS6ptoWLEQU+9hGrTIyOB8x9luwNF13JtMysXzsnxIgOFd5Jjd1GkH
         7Do+NyoiEdTYvhigFlq9Knq+HJlJnU6fI53F3WH8N7GpKaMeLriPtZ1uzq+/w0pKSxm9
         3EaTgbBJQ/4V3XfPDsBGJXTnirW0m4nvuG8E9u+pu2tHUAGeH4WE6igi4bXst2q3wbGq
         llVeUFb8JWoJbQYDCBjcjmnQJh8ERUGxeU8wiQARSQzNu+0ZtsTmArd+H103Gs/SV+0S
         GsvfdGyJj4z6kykPCnl2OwhWw6lZngBMU2EnmHH19ZfHYAVr0ntS8go9WrV89u9sXdVW
         qGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nSDFxzgCBZiCgNlewWaW6PVPMdCZ0EHWwfb78WuBIDA=;
        b=zfbI6d51GOUiXGlwmEJl+od+iF2Z8AtRSFFE7kMvJBy/wyGjnf/Jl1rTlBaxOdqutQ
         tPnvZ+vaLHdjllEyg7l2r1PudEMPMLrc91SnPapKoyHi7bzhlvTvwum4sgEaL6o+44PI
         irwz1OcWwT0diAARSDGiyNCk6k9ohtx3WpgUWGan5Sm9yNgWdn0U0NGwkr0+bnSt7Tkv
         hmOFHEzhYK3VivdmsHkqzrfQodi9rg2hueSAZb1TEdgUBqHNrQVLyMrpgpQARE8YRToB
         eUNTnq7hq1B40+8fwiTqAsmrh3RocVZFHB+55qNlbBNzVB5Dn52Kgdq+ZTANA0errrZV
         Yp+g==
X-Gm-Message-State: AJIora9+45TbH7ZhkZp7HueRaAGlB7GbdLPWMgZYH1RLF2FMqseeReLg
	LQGAR0Dvg0APB/lIWhaN46iRkzXHo9Q=
X-Google-Smtp-Source: AGRyM1sSlDe0sKScQ8ANvTOOetCLRzy0Pluk3eDc6hRDXphf64TfdfcrhFsEheQQW9TiM9ZGat+KnQ==
X-Received: by 2002:a17:902:6ac5:b0:16d:1664:39c9 with SMTP id i5-20020a1709026ac500b0016d166439c9mr17527097plt.104.1658855366321;
        Tue, 26 Jul 2022 10:09:26 -0700 (PDT)
Received: from jprestwo-xps.none (h208-100-169-68.bendor.broadband.dynamic.tds.net. [208.100.169.68])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b0016c09e23b18sm11778694pli.154.2022.07.26.10.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:09:25 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 01/10] manager: unregister nl80211 config watch
Date: Tue, 26 Jul 2022 10:09:11 -0700
Message-Id: <20220726170920.15929-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For consistency unregister the config watch when manager exits
---
 src/manager.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index ca29e110..437841b3 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -49,6 +49,7 @@ static char **whitelist_filter;
 static char **blacklist_filter;
 static bool randomize;
 static bool use_default;
+static unsigned int config_watch;
 
 struct wiphy_setup_state {
 	uint32_t id;
@@ -820,8 +821,10 @@ static int manager_init(void)
 
 	pending_wiphys = l_queue_new();
 
-	if (!l_genl_family_register(nl80211, "config", manager_config_notify,
-					NULL, NULL)) {
+	config_watch = l_genl_family_register(nl80211, "config",
+						manager_config_notify,
+						NULL, NULL);
+	if (!config_watch) {
 		l_error("Registering for config notifications failed");
 		goto error;
 	}
@@ -880,6 +883,8 @@ static void manager_exit(void)
 	l_strfreev(whitelist_filter);
 	l_strfreev(blacklist_filter);
 
+	l_genl_family_unregister(nl80211, config_watch);
+
 	l_queue_destroy(pending_wiphys, wiphy_setup_state_free);
 	pending_wiphys = NULL;
 
-- 
2.34.3

