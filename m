Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454F12770A
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 20:53:42 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id c2so17710262plz.11
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 13:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5BVp7TOrkkbkapuyuqyANloReXrKYsVuuTSBHRDunE=;
        b=Hr+Iql8xucMo1I/4zRn+5gWAxtcyfG6mcE8lMslKGppbtxC+HtkEtNOA9WlM+k4riH
         6cdGPYJzaFrofzrThbU8keWqUIwV753f51W+vk+Iq3ETjrIuTktO6Z8P+EwqtDIsX47A
         DpAuxBO512Q1MCuZ43rjIWpsWFY1zEZpV7rTgz73sr+8GTU9Hr0VsDtS3WtXCPwamfc7
         0SAz1MVRLtL6S6VcW111KclqdtjGyVlH1M5qak9JL4cei+lC+yJV7vAg2yq+m53U9Tdg
         WvVgbNGunAjQuK76hPo6w6eTXBm740fYeXOp5njUMb8n5yVlTfZDR2kWYp234MtcjFOf
         2qGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5BVp7TOrkkbkapuyuqyANloReXrKYsVuuTSBHRDunE=;
        b=t1iZF63H0HLkxWoji3VNKXaU5WDqFkQpioqv9SEcPHJYES4g/vqQq1CPh9sBOCJ6fw
         Mcpvrq+gcjP7dWALkqPCA5m25r/mu1QqpJKG5GgOpDieP0Bl9kMq/pB07nlaGENu1erG
         D8VGYIg/gRHCpsD8bJyA0vsJ2ADgLthe5v69NKExADD0WZlOLbxaaSoGsf9VV8DWZtaR
         B+lydcZjrai1Zo8VoDwKyavZZ9s31QFnl1bITifuWaZGd7EwCmhEA9G0tSoZwQ7kAATQ
         DglIdeNR5yv9U1Ucn+yc7YRXuLBb13NpUGqJzYM60nR46kn+C6uxCy9bu6KoJytV8rCH
         3N+A==
X-Gm-Message-State: ACrzQf0mNgWwGPnHxJwhh74/TU2qdf3sCD6DX6JGH82yCc8j0YRHP0kj
	526xCzhwCZ2vDBluPRFO0uWLWUfHRT0=
X-Google-Smtp-Source: AMsMyM6Cigj/udWUChYvTt4zgOqAt6tvpWjPxg0ZwZnWBGjRtUiOghDuYBxiwb1J1xn68waFLmXo1w==
X-Received: by 2002:a17:902:f691:b0:187:466a:8975 with SMTP id l17-20020a170902f69100b00187466a8975mr5556768plg.59.1667422421571;
        Wed, 02 Nov 2022 13:53:41 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b00186c6d2e7e3sm8730755plb.26.2022.11.02.13.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:53:41 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 07/10] client: add ap support for PairwiseCiphers/GroupCipher
Date: Wed,  2 Nov 2022 13:53:24 -0700
Message-Id: <20221102205327.268693-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221102205327.268693-1-prestwoj@gmail.com>
References: <20221102205327.268693-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 client/ap.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/client/ap.c b/client/ap.c
index 4ce727de..f444a12c 100644
--- a/client/ap.c
+++ b/client/ap.c
@@ -37,6 +37,8 @@ struct ap {
 	char *name;
 	bool scanning;
 	uint32_t freq;
+	char *pairwise;
+	char *group;
 };
 
 static void *ap_create(void)
@@ -51,6 +53,12 @@ static void ap_destroy(void *data)
 	if (ap->name)
 		l_free(ap->name);
 
+	if (ap->pairwise)
+		l_free(ap->pairwise);
+
+	if (ap->group)
+		l_free(ap->group);
+
 	l_free(ap);
 }
 
@@ -151,11 +159,67 @@ static const char *get_freq_tostr(const void *data)
 	return str;
 }
 
+static void update_pairwise(void *data, struct l_dbus_message_iter *variant)
+{
+	struct ap *ap = data;
+	char *value;
+
+	if (ap->pairwise)
+		l_free(ap->pairwise);
+
+	if (!l_dbus_message_iter_get_variant(variant, "s", &value)) {
+		ap->pairwise = NULL;
+
+		return;
+	}
+
+	ap->pairwise = l_strdup(value);
+}
+
+static const char *get_pairwise_tostr(const void *data)
+{
+	const struct ap *ap = data;
+
+	if (!ap->pairwise)
+		return "";
+
+	return ap->pairwise;
+}
+
+static void update_group(void *data, struct l_dbus_message_iter *variant)
+{
+	struct ap *ap = data;
+	char *value;
+
+	if (ap->group)
+		l_free(ap->group);
+
+	if (!l_dbus_message_iter_get_variant(variant, "s", &value)) {
+		ap->group = NULL;
+
+		return;
+	}
+
+	ap->group = l_strdup(value);
+}
+
+static const char *get_group_tostr(const void *data)
+{
+	const struct ap *ap = data;
+
+	if (!ap->group)
+		return "";
+
+	return ap->group;
+}
+
 static const struct proxy_interface_property ap_properties[] = {
 	{ "Started",  "b", update_started,  get_started_tostr },
 	{ "Name",     "s", update_name, get_name_tostr },
 	{ "Scanning", "b", update_scanning, get_scanning_tostr },
 	{ "Frequency", "u", update_freq, get_freq_tostr },
+	{ "PairwiseCiphers", "s", update_pairwise, get_pairwise_tostr },
+	{ "GroupCipher", "s", update_group, get_group_tostr },
 	{ }
 };
 
-- 
2.34.3

