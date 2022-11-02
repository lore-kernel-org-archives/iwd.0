Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88B82C9C
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 22:51:44 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so3505802pjc.3
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 15:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5BVp7TOrkkbkapuyuqyANloReXrKYsVuuTSBHRDunE=;
        b=TD60O1P2jfb8n6zc1KZZSym92GwuCLpb2ZeVV7Inlo61C2ZL5eQKNtv7ALvjfjfsKM
         KSSA1IS0gm2P8I6qKlbSE8AgvrhypkvjLKanJsbCBo7z1zosN6FbHCH/n4y7zHI96t4w
         2Pt8F1MAe2iMAT4950aOuxWuVVv2gEZtZRKp0Tai/khciXwIEp+gfatJP5owLtym7/8V
         lr0T8zFKRNkl+tdEM7KTcy/cgjuhUokS7M2cYma11RtfHMf26IHRabOXpfd5D+U2zQke
         Cn0aJGBMiCNsHuW2LW8fYG4xDj7hl1CdvkgKfXto7lk/wEMafQKV3xnJY70bi4bTCqKY
         CaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5BVp7TOrkkbkapuyuqyANloReXrKYsVuuTSBHRDunE=;
        b=WSWX6H0rQurKFlI747uqUnen5E4LJ5/8qvugRHpYh/vLx5Y8olEIOgyx6lQ3LoHmB5
         Ss+2AMIGBzK2q4t5ojdt08qR0zXWxXxA01H1sXCCL62ybu61AyyWTyAky0NwevBV7mb1
         fWkZstOlhWScVqq50SzH6Z6bRT0bD6WXNkxad1fDTBJzWliZaB/YGK0kF6IzKJkhPB9k
         sm9Vs8GoRI7PoyBUGbMOuOYLvvEbi4UB1gOC3HFnmdsgLl8dRuTD4I8ZN0yFpSm7XB8P
         9RyoOT+kvgZnt7qILCSleOTAr379zAg/zfAcedhl7G+HfTkgc8JmOxH8cynjTGVOb4vA
         naWA==
X-Gm-Message-State: ACrzQf37YJRKyenog/uaVn6Yegh25318ViCyff3Q53ayTwfd08eOZrzw
	qHLANAqV/hTxVEs0R4Lpo8SNwhNAY8o=
X-Google-Smtp-Source: AMsMyM4sTFbQ2SY4P1eQihBcfAefHlgW1S8+3NFGpfjJZjsa60JRlYbCjZlKGiq1xKxAgw98wEJa8g==
X-Received: by 2002:a17:902:720a:b0:181:150c:fcc4 with SMTP id ba10-20020a170902720a00b00181150cfcc4mr27651105plb.109.1667429503594;
        Wed, 02 Nov 2022 15:51:43 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b00186b945c0d1sm8920377plh.2.2022.11.02.15.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:51:42 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 08/11] client: add ap support for PairwiseCiphers/GroupCipher
Date: Wed,  2 Nov 2022 15:51:13 -0700
Message-Id: <20221102225116.297129-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221102225116.297129-1-prestwoj@gmail.com>
References: <20221102225116.297129-1-prestwoj@gmail.com>
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

