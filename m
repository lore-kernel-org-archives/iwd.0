Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887B12595
	for <iwd@lists.linux.dev>; Thu,  7 Jul 2022 17:57:37 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id a15so20876542pfv.13
        for <iwd@lists.linux.dev>; Thu, 07 Jul 2022 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nhQtO/Y2h9D6l5zhv4lQX1YLXzkVZFFQJbFi4F+4SY8=;
        b=CJ3LZEAFJwOkOB+9ZHAhscmpEASrzdEaUlYb3CAg1vYB1YFILExLAYaC9Ut53qnAb9
         CI4adWDPOFOwzUtGKx/Cu6XuY9hm5oYU1LhFCGj88J8K6Be4iKRysGTEWgc6IZrlYs6d
         dI2gv2bC8wsMFpHzRPa3Y7eNNeQg85Uy3fyArnXb5VnzjfxpIDzDXmJ2xHlfSEp4M9iJ
         9m19z/R88qkSpHq6VaS5WdFF/k1bH/HfyX1K0VYqIImP8rV4JWEXPOOv5lnvQL2pYXmM
         F1CVxQOxuT6SJMQZmhee/zL22iN+xHF9ApyByfzYJkUOahT2onbNrytLT0klLk15SENq
         Y/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nhQtO/Y2h9D6l5zhv4lQX1YLXzkVZFFQJbFi4F+4SY8=;
        b=4diw7b70Pa/MYeptG0dLYkM/HdgnKuW0MmuxsZ+3ub6cqXm8ZVfeMCLrz9B0W2uOYl
         /kxVkfypJb5AAdzoZ8lP6/GPviHeOWj4eYmtlP8mnhY/aNNmNqyso+QDzKAI0clEqbsA
         YGcSQiKf3E17WRrCHMVKPHrORlOjZGOn0E66kcOSD8jDeTOXXI4fjz+lSCpYQgOzTPlD
         lAyct/SEFIeDh72JjkjIIcaDFQ9xN1MAOKcIxVFQkY8Ixb+iAPRp2ih0Q5Md7dXCMlIg
         tK/QS9rtPDr35ovBtC11x2WdkEVRYwUjT6ghzmKbePzxIJ19DbrmYzPh5S+QimQLTnnX
         IM+g==
X-Gm-Message-State: AJIora+Rqhz6plSp1RYPj6v3rtGM9QL3m7JCF1zI/T4gd+UYDg3KAy6I
	6lgt2cgTcJosm+RQLWKzQ48QnZurtG0=
X-Google-Smtp-Source: AGRyM1tGZcbtoiLZuviiqZJlDQYrwnFQr1xNtecNXSu2bm0g+KHWNboc7BgY9vCKC3Hde/fyD+5VCQ==
X-Received: by 2002:a17:90b:3811:b0:1ef:e647:ff34 with SMTP id mq17-20020a17090b381100b001efe647ff34mr1364726pjb.171.1657216657040;
        Thu, 07 Jul 2022 10:57:37 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b001618b70dcc9sm28855223plg.101.2022.07.07.10.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:57:36 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 13/14] client: update adapter table header
Date: Thu,  7 Jul 2022 10:55:10 -0700
Message-Id: <20220707175511.224597-13-prestwoj@gmail.com>
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

The 'adapter list' command was also updated to shorted a few
columns which were quite long for the data that is actually displayed.
---
 client/adapter.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/client/adapter.c b/client/adapter.c
index 6a0d3455..394eae0d 100644
--- a/client/adapter.c
+++ b/client/adapter.c
@@ -185,9 +185,10 @@ static void display_adapter_inline(const char *margin, const void *data)
 {
 	const struct adapter *adapter = data;
 
-	display("%s%-*s%-*s%-.*s%-.*s\n", margin,
-		19, adapter->name ? : "-", 10, get_powered_tostr(adapter),
-		20, adapter->vendor ? : "-", 20, adapter->model ? : "-");
+	display_table_row(margin, 4, 8, adapter->name ? : "-",
+				8, get_powered_tostr(adapter),
+				20, adapter->vendor ? : "-",
+				20, adapter->model ? : "-");
 }
 
 static void *adapter_create(void)
@@ -268,8 +269,9 @@ static const struct proxy_interface *get_adapter_proxy_by_name(
 static enum cmd_status cmd_list(const char *adapter_name,
 						char **argv, int argc)
 {
-	display_table_header("Adapters", MARGIN "%-*s%-*s%-*s%-*s", 19, "Name",
-				10, "Powered", 20, "Vendor", 20, "Model");
+	display_table_header("Adapters", MARGIN "%-*s  %-*s  %-*s  %-*s",
+				8, "Name", 8, "Powered",
+				20, "Vendor", 20, "Model");
 
 	proxy_interface_display_list(adapter_interface_type.interface);
 
-- 
2.34.1

