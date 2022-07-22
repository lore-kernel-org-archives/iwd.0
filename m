Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDD04A1C
	for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 16:37:14 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id pc13so4825600pjb.4
        for <iwd@lists.linux.dev>; Fri, 22 Jul 2022 09:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CICC3Nf5vdpG6NJQqXxcqaOgIhBZf5Ux4gTr6OIhLh4=;
        b=JnJ3YRoGi7xztuWKbfhZoDHh3PfywlCc/vy+hUfxpOJOpwAyHZL9FIdh/PgJK177jj
         lk95D3LcC9jh3MushFWWecPM8Smo9hKnG38ys8Wn2NlS6pWjxugPIEtfHS7M0szElnND
         GQeLlbPPCbdYTlDbBSI6vkDaXORLkEOoXggBobs4/97iWiYUVMqPMSW+H7MTglW4H256
         ip22yQlHD9w0MFX4Bwe5MGBVrXyIAMyHgCRYbKE9n0WNtOW/6OQSUhCoMvIC6cCZ318p
         tWxtr+Jac8xyXJNASgjA9qjeQWW/LTOatf2sYLbpEAA00D4z9EOEcvrMWgf09X+WYt/k
         66PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CICC3Nf5vdpG6NJQqXxcqaOgIhBZf5Ux4gTr6OIhLh4=;
        b=qk+OBZpmoxl88ULfKYwYGfk2giaV26veo5UvPkQhW9kFUjM+kpLvZ85po//Yqdul4Q
         dHHrgL57N9U2580Vax95w2ARt/f8dQn4GHf4pfgceLaDLg4ngo/4w1UYifpSt6RDeQpA
         TYjqyVgjI00lym/cpXxnvDgqtHm9Enli+WgD5dIUufwt4K6X+STCHx9/971yNSV9DD7a
         ZCJ7XKnIKN2cir9jK+61/nPwILUvkXEVWC1ESlmfPC3kXIhAgpygJJ8rF0s6Jw+ow6XF
         kWNcNDTqqlh95YscuiaSwpXZ1vcSc5NKthvddVgWfAG/pH08jzyo6ragr2qlHVdTshho
         81Vw==
X-Gm-Message-State: AJIora+76tYLpOedbp7P+6HBzmzm34IfVg1gz1I15gogJMp5VmNC5amV
	Brf8G/9gyd0fQZYc7EIwsUfRxV0WAkA=
X-Google-Smtp-Source: AGRyM1tvTbMXbaDBsn7r3eii08QaQXRMC9pg91vTvMLl6KntlpZcSMlk8O90y0x2HS37Eiiu8Hwuig==
X-Received: by 2002:a17:90b:3ec4:b0:1f0:5aab:48db with SMTP id rm4-20020a17090b3ec400b001f05aab48dbmr18490368pjb.117.1658507834063;
        Fri, 22 Jul 2022 09:37:14 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902e75200b0016a109c7606sm4013887plf.259.2022.07.22.09.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 09:37:13 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/7] manager: re-dump wiphy on regulatory change
Date: Fri, 22 Jul 2022 09:34:15 -0700
Message-Id: <20220722163417.1119334-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220722163417.1119334-1-prestwoj@gmail.com>
References: <20220722163417.1119334-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is required due to the kernel not waiting for regulatory updates before
sending the wiphy dump. The initial dump usually contains all supported
frequencies, none of which are disabled. Later, the regulatory subsystem
populates the frequency list which can significantly limit allowed frequencies.

Even disregarding this problem, any regulatory update will modify the allowed
frequencies so re-dumping wiphy should still be done on a regulatory change.
---
 src/manager.c | 58 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index ca29e110..c8d56a99 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -666,6 +666,29 @@ static int manager_wiphy_filtered_dump(uint32_t wiphy_id,
 	return 0;
 }
 
+static unsigned int manager_dump_wiphy(uint32_t wiphy_id)
+{
+	struct l_genl_msg *msg;
+	unsigned int wiphy_dump;
+
+	msg = l_genl_msg_new_sized(NL80211_CMD_GET_WIPHY, 128);
+
+	if (wiphy_id)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY, 4, &wiphy_id);
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_SPLIT_WIPHY_DUMP, 0, NULL);
+	wiphy_dump = l_genl_family_dump(nl80211, msg,
+						manager_wiphy_dump_callback,
+						NULL,
+						manager_wiphy_dump_done);
+	if (!wiphy_dump) {
+		l_error("Wiphy information dump failed");
+		l_genl_msg_unref(msg);
+	}
+
+	return wiphy_dump;
+}
+
 static void manager_config_notify(struct l_genl_msg *msg, void *user_data)
 {
 	uint8_t cmd;
@@ -799,6 +822,25 @@ static void manager_config_notify(struct l_genl_msg *msg, void *user_data)
 	}
 }
 
+static void manager_reg_notify(struct l_genl_msg *msg, void *user_data)
+{
+	uint32_t wiphy_id;
+	uint8_t cmd = l_genl_msg_get_command(msg);
+
+	switch (cmd) {
+	case NL80211_CMD_REG_CHANGE:
+		manager_dump_wiphy(0);
+		break;
+	case NL80211_CMD_WIPHY_REG_CHANGE:
+		if (nl80211_parse_attrs(msg, NL80211_ATTR_WIPHY, &wiphy_id,
+					NL80211_ATTR_UNSPEC) < 0)
+			break;
+
+		manager_dump_wiphy(wiphy_id);
+		break;
+	}
+}
+
 static int manager_init(void)
 {
 	struct l_genl *genl = iwd_get_genl();
@@ -826,17 +868,13 @@ static int manager_init(void)
 		goto error;
 	}
 
-	msg = l_genl_msg_new_sized(NL80211_CMD_GET_WIPHY, 128);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_SPLIT_WIPHY_DUMP, 0, NULL);
-	wiphy_dump = l_genl_family_dump(nl80211, msg,
-						manager_wiphy_dump_callback,
-						NULL,
-						manager_wiphy_dump_done);
-	if (!wiphy_dump) {
-		l_error("Initial wiphy information dump failed");
-		l_genl_msg_unref(msg);
+	if (!l_genl_family_register(nl80211, NL80211_MULTICAST_GROUP_REG,
+					manager_reg_notify, NULL, NULL))
+		l_error("Registering for regulatory notifications failed");
+
+	wiphy_dump = manager_dump_wiphy(0);
+	if (!wiphy_dump)
 		goto error;
-	}
 
 	msg = l_genl_msg_new(NL80211_CMD_GET_INTERFACE);
 	interface_dump = l_genl_family_dump(nl80211, msg,
-- 
2.34.1

