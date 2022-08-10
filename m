Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A967146AA
	for <iwd@lists.linux.dev>; Wed, 10 Aug 2022 23:16:23 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id g12so15061352pfb.3
        for <iwd@lists.linux.dev>; Wed, 10 Aug 2022 16:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=G4q47j3huIT85zBjDyk4T5pfIXgxJTCTADRl/zkiJhY=;
        b=eNY2R9e/vwMqACmHSabqZ6l2Zove48GaXb1g7m2OfbgyKoG1QldKcfLA3bGWcuI01f
         AoAt5NeuukGEG/MaPqE636u8WW7AefxQdnWXzu8h+CNOC2uefqwVfNv79XgcP6K8t/nJ
         Q9qLVEyvVtaJmoZCjKlSyDXbIMKX1ei2m4gG9JweMG1A4Hi2cK9ZA7Xzi9vjD1UcDZDy
         NEKWtCCNqxbZSf2LTJHzxLQS82k8bDM7jLeo5rIDwLKOdI7V+/9tN/6DoFXUIWphL5EO
         P35i9XUMlFJlkRqqGG7b6DNs+taC9qPq58/SmVCUf7f2y/Zdv+RCIX0j6S/+ihwzW9z6
         TGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=G4q47j3huIT85zBjDyk4T5pfIXgxJTCTADRl/zkiJhY=;
        b=g/s1jtxau9Bckxp5Axj1vKVGhuve6bUAuJDrJNzlWGg/DcyDaF4pZHAd6kh8iQvnOJ
         X17ibyqQusNuV0LTUEX0FZXNx1LDwW79d5+lJToJv3PeZB2Xg4EAi90mAV3k7N3O0K5h
         sCzFHo59eyVAuyfAuEIH7Qxms4pHenx4AXxFMG442yHzHWjCk5lwGZK5KSRZbx6hXdCy
         EbuE3v4u5sSP+17bjBRrXZewZC+csfnLc3xtdlApj4IyatbeNKq5VYSaT+OaSvD2+q9u
         59rwtM+tsjpUZEcKR5D+JCn9zmKzFERBwlndFwvNY4G9t6OYsM3CxrolKu6tU31w3gEc
         vfRQ==
X-Gm-Message-State: ACgBeo0f3Qa0k9Y0aTAP54rUHRDFK/APuViCqbuDAnWS9wsQg1Fef86e
	fyzM5k7OC88inpTg35LGL8p0xuD6wjI=
X-Google-Smtp-Source: AA6agR4TYoHRbtbpSCQDnHhyaFfUql9qbKk0pTU2382Yk7pElAuHPndQ9DSlTtn0sohMJY8WS8zgAQ==
X-Received: by 2002:a63:8bc8:0:b0:41c:6800:d4e9 with SMTP id j191-20020a638bc8000000b0041c6800d4e9mr23947915pge.45.1660173382946;
        Wed, 10 Aug 2022 16:16:22 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902e84700b0016d62ba5665sm13540246plg.254.2022.08.10.16.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 16:16:22 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/8] network: make network const in network_bss_list_get_entries
Date: Wed, 10 Aug 2022 16:16:14 -0700
Message-Id: <20220810231621.372514-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No reason for this to not be const.
---
 src/network.c | 2 +-
 src/network.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/network.c b/src/network.c
index c0befa42..3099d102 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1168,7 +1168,7 @@ struct erp_cache_entry *network_get_erp_cache(struct network *network)
 }
 
 const struct l_queue_entry *network_bss_list_get_entries(
-						struct network *network)
+						const struct network *network)
 {
 	return l_queue_get_entries(network->bss_list);
 }
diff --git a/src/network.h b/src/network.h
index c6b99f6c..f29649f7 100644
--- a/src/network.h
+++ b/src/network.h
@@ -91,7 +91,7 @@ void network_blacklist_add(struct network *network, struct scan_bss *bss);
 struct erp_cache_entry *network_get_erp_cache(struct network *network);
 
 const struct l_queue_entry *network_bss_list_get_entries(
-						struct network *network);
+						const struct network *network);
 
 struct l_dbus_message *__network_connect(struct network *network,
 						struct scan_bss *bss,
-- 
2.34.3

