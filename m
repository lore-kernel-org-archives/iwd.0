Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3602906
	for <iwd@lists.linux.dev>; Thu,  7 Jul 2022 17:57:30 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id z14so19928262pgh.0
        for <iwd@lists.linux.dev>; Thu, 07 Jul 2022 10:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PXAcukMtKn4tMNurUHsF0W8rW62Jn9j4ZVGFC/z9eDg=;
        b=I1evBFyvCjW2a/qiWOybh7p29Smy/bEEXD5+ibR1lMNZxGE2CDujpedoLyzXNH08t7
         tw8REg6eJ2n9iJ7JjsSVJGnO7Wldsa3eIhKCkSVLrWeQsvUhNt2MwM9LwzL7XtsXw/3T
         wlobCIKaSajfUxECCK1h9CFoKR1/mKhiefT1wKS3e7FeRi2SreF7o+f9RaD3WEKXARkM
         a5g1zdnlupFxCaccP3uYsiMX032H4XpZYf796djh6LgyR8LWgtjQowKXIXHemqOkGSQB
         msLHZhGr1NOb9a5Jv4nQsmZgVtllcuKJoq1ulqT7ytd0Z5uyvgINF2cNzwMZ/H4uYSQd
         /ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PXAcukMtKn4tMNurUHsF0W8rW62Jn9j4ZVGFC/z9eDg=;
        b=kvL65UlJlpubtGGewi1fdFFHNFeMT5pptgT93q7SCvfuLPOOWWKc8qdM1TFshRA8iG
         5Wahp+D0m3KgQGqjcFg2ZJnMOBgUJQcmb5MUO+oM2OjJT4bcfk8EZpylKd/cGRS4g8Ny
         4oMBHfacR3fUSOvvIVvVqfMPipnJCaJRUpFGCgg13tSIvHIEyiKNfcazDpNlzbey3hFq
         2Bt+j2261ddsy3j205KwCiw74JKPSAoP1riLhVFDuvmGOERWn/9WxjuyS/ot6R8RE1mo
         LtsezVX5iiTOGhVb+un/WERp6aKc4qG/AHtKckVt2ieeAvPu0/pUOECr/6yNgLW/Bia3
         J/sw==
X-Gm-Message-State: AJIora+2FbvunYPYw50cGNLtmSpVT0ZqFEafdB+oeTdkrATzPDFR/hII
	uBH/JapZ/QgoHaKvV20kJzb1/OaY9LE=
X-Google-Smtp-Source: AGRyM1s9J9vAYfyXQjnkfhFf0aYW+mGIs/RSv7vZPbWARNNaEnXHmnpGLCFfGFaxU+YSevhkrCpfqg==
X-Received: by 2002:a17:90a:8914:b0:1dc:20c0:40f4 with SMTP id u20-20020a17090a891400b001dc20c040f4mr6497871pjn.11.1657216650113;
        Thu, 07 Jul 2022 10:57:30 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b001618b70dcc9sm28855223plg.101.2022.07.07.10.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:57:29 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 10/14] client: update known-networks to use display_table_row
Date: Thu,  7 Jul 2022 10:55:07 -0700
Message-Id: <20220707175511.224597-10-prestwoj@gmail.com>
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

---
 client/known-networks.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/client/known-networks.c b/client/known-networks.c
index 49e69ddd..56c34a2e 100644
--- a/client/known-networks.c
+++ b/client/known-networks.c
@@ -210,9 +210,9 @@ static void known_network_display_inline(const char *margin, const void *data)
 		l_strdup(format_iso8601(network->last_connected,
 						"%b %e, %l:%M %p"));
 
-	display("%s%-*s%-*s%-*s%-*s\n",
-		margin, 32, network->name, 11, network->type,
-		9, get_hidden_tostr(network), 19, last_connected ? : "-");
+	display_table_row(margin, 4, 32, network->name, 11, network->type,
+			9, get_hidden_tostr(network),
+			19, last_connected ? : "-");
 
 	l_free(last_connected);
 }
@@ -263,7 +263,7 @@ static void check_errors_method_callback(struct l_dbus_message *message,
 
 static enum cmd_status cmd_list(const char *entity, char **args, int argc)
 {
-	display_table_header("Known Networks", MARGIN "%-*s%-*s%-*s%-*s",
+	display_table_header("Known Networks", MARGIN "%-*s  %-*s  %-*s  %-*s",
 					32, "Name", 11, "Security", 9, "Hidden",
 					19, "Last connected");
 
-- 
2.34.1

