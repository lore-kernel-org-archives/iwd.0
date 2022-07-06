Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DE82F21
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 21:31:09 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id j12so7899349plj.8
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 14:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PXAcukMtKn4tMNurUHsF0W8rW62Jn9j4ZVGFC/z9eDg=;
        b=d03MitxuaeItEvsZvX2wo4NYid4MonT7X1zFXpAa/4Q3RqsChaFe+P50qcPAkTOM1z
         ke3sCp9CP7KQE/IeYCO0iitIM5oQOxQOCb3YC1I4ygW/I1/04qsE3NPSaoFgEG4th2Ii
         Wx6V1rYP2WEbpWpmODHJYwwxm+bbmnZr6HCsB0lYVc1IVnihYIhRe2/jBztVNzckGIYb
         SRq3fGlSGoqANIB+y/LmZEFfa0e8UpaomAL+zGvU/7rHL6EN5ywWmKF7OusnLTbwiSZm
         7rzzCXYXIHbXAJ+UlB452gnO++jyu0Hwcaow4rAoNspu0N0K+wR2WJsynMCdL64EN9s0
         cVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PXAcukMtKn4tMNurUHsF0W8rW62Jn9j4ZVGFC/z9eDg=;
        b=FwtfEvTTUNCysEy9psZqty07RlJReTpEokSPMLqIsNX7W2S+fOXWHRjh/i5jE3JX8V
         BSbyFOYtsO2RgCEG6nvZFyuN2X/6Q/CGLDvaAj80+2EJWB9BoPsY75wY8Md5+An1als8
         IJydJaq9iKHMe9Txg1tkDgBrfVSfWCrA4ohcgS27fgxsKwgPzOxDc5oOWyUuduFjHB6J
         wr6hwl8UXg/ltJ3MuOfvJ1JaiN1FilRZsnDniRzVyq3w3st5YV1dksh4FbTfs3FGyo8f
         Ro96ah1dZDB4LTE2cLlRclz/g+3mIWlySU7fLrl3gUlATBGtauV2ZzDSVmEmyi+eXMfA
         p8fw==
X-Gm-Message-State: AJIora8N6m6iezlzasSpHEFA6k3JpNg3cgWEfSJCmQAvjKC44a3l3XKY
	iHu9x/f19R14TZLD3iiZL7n7LzUCgrk=
X-Google-Smtp-Source: AGRyM1tJLUqm7icLWinVxyHoo6SjJOQpfah3mmRJs0bdRJwCrXAnGTskQ2M2X0IJAFYrp766mzKWHw==
X-Received: by 2002:a17:90b:1b10:b0:1ed:44:d00d with SMTP id nu16-20020a17090b1b1000b001ed0044d00dmr863126pjb.234.1657143068785;
        Wed, 06 Jul 2022 14:31:08 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id v6-20020aa799c6000000b00527f5aee1a4sm15347609pfi.33.2022.07.06.14.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:31:08 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 10/14] client: update known-networks to use display_table_row
Date: Wed,  6 Jul 2022 14:28:47 -0700
Message-Id: <20220706212851.92685-10-prestwoj@gmail.com>
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

