Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF6689DD
	for <iwd@lists.linux.dev>; Wed,  7 Sep 2022 23:32:06 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id fv3so9919084pjb.0
        for <iwd@lists.linux.dev>; Wed, 07 Sep 2022 16:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vYQwrQl5sojdsnudr7L9/Y5gIk/q0qAGIl5pIAzjBpY=;
        b=YtJtX97WYmc8kTeDNoTgY2k6ytaFuo8VDFj8D/ZxMpYu8dbumTSN4tHmptz+8EBh3g
         qx2+2RXPq2NbU7Ay1EZfnYaPB3aIr8/FTRgjxxQtpY3dBlmMbwx5N1IBiL5pq6MwqYj8
         uvTK3CTVfe1PTwWPM7zY7mkCjaerM0xYpPHp4+6xcvZLlvnVKZLLzR8Y4fzwuJo2fq4b
         2DyC/pmmN80gHEVj1GueebF4ztc3yazzPVn29NsO/4lJLTwDpTU5lpwcmaWEjCZa16Wq
         XS+L+0g0iK6jQrpYPf2emY3IlYNnevV4JBvRa8sDC6Y3APQVfBAy0PgRoHlJBcRDTk4J
         IXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vYQwrQl5sojdsnudr7L9/Y5gIk/q0qAGIl5pIAzjBpY=;
        b=MgoX1UT96T9B4+HOlExgTYPwrBj2Vr3/8VOJtp+3Tvgfnjf29lSkEQ+0NKrtyw5Lb0
         TTueDobrq/ZrPuB9YCc//hf0sApEIgj+1/smETij2Q/qg4HDmNk9suTs+Lcj++XmvEBK
         ajLymUuipRwiR5UNCipEeEwjHRLOPeLXNgSsiBEA0QgkoyQHcEKAO61XLQxh4khTHz83
         zIjt4hSWeH7Bv2QqSyR87vD9yP2c3BpvndWW9pUF1003zPcMGhtxccLOKveinpY+HaPf
         kDZj8qOG6DhXC9dMGkJSeHVkS4pfpUc5kLwRA6G1mmrIxzb3Nnga80EER26wG6LCx+GU
         ixKQ==
X-Gm-Message-State: ACgBeo0v66Y698zVd5ZU1iT3bNFu3VHq8QMF7nWM/FxPQC77u9tqGVRY
	64BNmEOlyz95PZNZjgKXMXl5GhprU3w=
X-Google-Smtp-Source: AA6agR73M4R7fr2OfX2Iu2inO5nDH2kMVBb+xHHLkkGlOwL9V+vOfq/mzTUVD9CI7IOZ+IJ5wcqnJg==
X-Received: by 2002:a17:90a:e7c2:b0:1f4:feeb:20ee with SMTP id kb2-20020a17090ae7c200b001f4feeb20eemr994812pjb.114.1662593526137;
        Wed, 07 Sep 2022 16:32:06 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id q24-20020a63f958000000b004348bd693a8sm4918192pgk.31.2022.09.07.16.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:32:05 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] wiphy: only do global GET_REG once
Date: Wed,  7 Sep 2022 16:32:00 -0700
Message-Id: <20220907233201.227577-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220907233201.227577-1-prestwoj@gmail.com>
References: <20220907233201.227577-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Getting the regulatory domain for self-managed wiphys requires
providing the wiphy ID, but this is not the case for any device
under the global regulatory domain. This is not tied to any
specific wiphy so there is no need to supply a wiphy ID or do
a dump for each wiphy.

Now GET_REG will be tracked globally if its a global call and
will only be called once.
---
 src/wiphy.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index f295d87d..af675694 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -64,6 +64,7 @@ static struct l_hwdb *hwdb;
 static char **whitelist_filter;
 static char **blacklist_filter;
 static int mac_randomize_bytes = 6;
+static unsigned int get_reg_id;
 static char regdom_country[2];
 static uint32_t work_ids;
 static unsigned int wiphy_dump_id;
@@ -2076,7 +2077,10 @@ static void wiphy_get_reg_cb(struct l_genl_msg *msg, void *user_data)
 	uint32_t tmp;
 	bool global;
 
-	wiphy->get_reg_id = 0;
+	if (wiphy)
+		wiphy->get_reg_id = 0;
+	else
+		get_reg_id = 0;
 
 	/*
 	 * NL80211_CMD_GET_REG contains an NL80211_ATTR_WIPHY iff the wiphy
@@ -2091,16 +2095,28 @@ static void wiphy_get_reg_cb(struct l_genl_msg *msg, void *user_data)
 static void wiphy_get_reg_domain(struct wiphy *wiphy)
 {
 	struct l_genl_msg *msg;
+	unsigned int id;
+
+	/* Already doing a global dump */
+	if (!wiphy && get_reg_id)
+		return;
 
 	msg = l_genl_msg_new(NL80211_CMD_GET_REG);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY, 4, &wiphy->id);
 
-	wiphy->get_reg_id = l_genl_family_send(nl80211, msg, wiphy_get_reg_cb,
-						wiphy, NULL);
-	if (!wiphy->get_reg_id) {
-		l_error("Error sending NL80211_CMD_GET_REG for %s", wiphy->name);
+	if (wiphy)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY, 4, &wiphy->id);
+
+	id = l_genl_family_send(nl80211, msg, wiphy_get_reg_cb, wiphy, NULL);
+	if (!id) {
+		l_error("Error sending NL80211_CMD_GET_REG for %s",
+				wiphy ? wiphy->name : "(global)");
 		l_genl_msg_unref(msg);
 	}
+
+	if (wiphy)
+		wiphy->get_reg_id = id;
+	else
+		get_reg_id = id;
 }
 
 void wiphy_create_complete(struct wiphy *wiphy)
@@ -2117,7 +2133,7 @@ void wiphy_create_complete(struct wiphy *wiphy)
 
 	wiphy_set_station_capability_bits(wiphy);
 	wiphy_setup_rm_enabled_capabilities(wiphy);
-	wiphy_get_reg_domain(wiphy);
+	wiphy_get_reg_domain(wiphy->self_managed ? wiphy : NULL);
 
 	wiphy_print_basic_info(wiphy);
 }
@@ -2519,6 +2535,11 @@ static void wiphy_exit(void)
 		wiphy_dump_id = 0;
 	}
 
+	if (get_reg_id) {
+		l_genl_family_cancel(nl80211, get_reg_id);
+		get_reg_id = 0;
+	}
+
 	l_queue_destroy(wiphy_list, wiphy_free);
 	wiphy_list = NULL;
 
-- 
2.34.3

