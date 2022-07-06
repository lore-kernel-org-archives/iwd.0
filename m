Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0B8666B
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 22:21:38 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id g126so1225228pfb.3
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 15:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nhQtO/Y2h9D6l5zhv4lQX1YLXzkVZFFQJbFi4F+4SY8=;
        b=HJi8gbUOysrULXTmBQA+nehDJvDR0f9/a9w0wTXw7Zde3MmfRjBHQOfy7uv6QqTUZB
         tu8M+VIVStttGWY6nBm394NtHNRVcIwho5OEgRf9+pp1+FBjMNn/D32ITa2Ld39P+e45
         aXvmg2+zOlkYvcJOhKzgpnP7HYNOKzO4e7SKSNJLy/sWhlCPyZFCe98kRnTQ7UJo9d/3
         RF5VyRwElI83RMRkgKpI0OC1GYPlEOAykkVksij1gPvJRSPZfaQw2i5vmN/FV/yw6KG0
         58GWlN4ta9GWKo1QCqF8hdAJiLHPoN7ItBhEmV8BtSANeVuFnCKMWEHo/GVc9DLRohtR
         RZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nhQtO/Y2h9D6l5zhv4lQX1YLXzkVZFFQJbFi4F+4SY8=;
        b=sdketImCBkSXjCtGGRfaibCjrG3JiqqyJZUzKnkv48AuHGGIMQ5HzhNtzrrFT9sER7
         byVNGREElQ5DFb90Yi4bi55rU1died0nOq5zixJgQZGhS2nUCvQi0WmgR6uBNX8QrD9C
         YdU/1pBk9nI3o3i1sKAawKnZJ3GwLTZqG3A4AH3pg/U1DA4FGEHFn77w3VrQh7S8T8GG
         agqudzhsp5FjftBcORKnsmxrOr4azzsaMxfe44P7qo4oG4CwE+qivMmunMUupnirNP8C
         pJahHR0gARkpB12gUfJK2zW7UB8VeG9DNrYv+OXCR1/Wu3Bg6B7UCEX2NUGU8jYTT9OA
         1v+Q==
X-Gm-Message-State: AJIora/rQK6XAdjUA5WPUaDWbEEDrblMguSSGmscliIB/y2B3th2fYvN
	rZwvraXNL4/mnM4+wt8i3qj8ndMpfGc=
X-Google-Smtp-Source: AGRyM1vO9Cvd/aOd12Xc1yaa2JANEuiBqz+3xPq2J6pekbDwqi4MXPn/OzObiwK5OAeS913d5Xzxfw==
X-Received: by 2002:a63:1f66:0:b0:412:2f72:ec19 with SMTP id q38-20020a631f66000000b004122f72ec19mr17354122pgm.282.1657146097529;
        Wed, 06 Jul 2022 15:21:37 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e80900b0016a163d1cd5sm26517696plg.253.2022.07.06.15.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:21:37 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 13/14] client: update adapter table header
Date: Wed,  6 Jul 2022 15:19:06 -0700
Message-Id: <20220706221907.126408-13-prestwoj@gmail.com>
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

