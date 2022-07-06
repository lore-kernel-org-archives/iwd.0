Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACA76667
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 22:21:35 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id i190so2555806pge.7
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 15:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PXAcukMtKn4tMNurUHsF0W8rW62Jn9j4ZVGFC/z9eDg=;
        b=eKAGHaOY3cPcIRbzTYqcIbZVrcwr+T7ZRZFxyZvjwQzWOjP4hLmbX+7yknxSepudat
         iuitNMIHCVA6mV6SRmGLx82ECNtecqi2D+SzgvgXdssioeDlKP9uuACTvD2vEi7Z0GD3
         1hnq8A8EWLhGAOtiwl0QNqLr3Edd+o8H3GJpb/XCwklygT3hjyodMi4rR6xuTrLEAtfn
         1PrEAw+oMQDqT2me7fbpgkYuktLlI2zixx74Y6asFqnIE4jF8VCjRAHx9hgfkHIKFcNg
         k3iwf1pKUqhOX2y74NzutGkr5EDrg8aRA0k3qztzD2227/5L9BXL7nVRfLFv7z/XaVyB
         9LLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PXAcukMtKn4tMNurUHsF0W8rW62Jn9j4ZVGFC/z9eDg=;
        b=AnTHJtDobtGIcl4SkTHlcqaWEqD6w3jFtE/HbsExjzuTpuqNJLAUi2n4YeqOcWmIuB
         bBSMm3zMtQnoFXpmE4e8PCfCo0bOMSzpOolKzZ3Gyzokq7KBYifL2BQ5RbBIvF4EhkiH
         eWagMTYezwWWmSGtJkWiZp835ODtgUbu3p1OdwK6dWIst87Y7TTeHwklqwiPc7EOx3B3
         q2Jbb6KNIemjWhnDdBxzBTKGiohtXRn0WN3nCZLCVQ8HShqH25DOLSngG13wVsZb5G4L
         QTqmpFlN+XqyI1IHHBGkTys1+UcosojMU/enspMkerlCfyCKPxTNURvglkRI7/DYrF0W
         MIwg==
X-Gm-Message-State: AJIora+35Im2begoLqJhy60LpXB2Tx0NlwTVXFC+Fxk1pF5aN5zzoqI5
	MIYIxM6yNcKv7j7qh08yuRaNscu2xXw=
X-Google-Smtp-Source: AGRyM1sgYEwKwY449jAUHoaW7iiqefVlFpg8TtYetmdTUXgvWb7VDfZjBgN+SSmTJFV2bq8dpv5gOA==
X-Received: by 2002:a65:6a50:0:b0:3f6:4566:581d with SMTP id o16-20020a656a50000000b003f64566581dmr35493530pgu.122.1657146095155;
        Wed, 06 Jul 2022 15:21:35 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e80900b0016a163d1cd5sm26517696plg.253.2022.07.06.15.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:21:34 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 10/14] client: update known-networks to use display_table_row
Date: Wed,  6 Jul 2022 15:19:03 -0700
Message-Id: <20220706221907.126408-10-prestwoj@gmail.com>
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

