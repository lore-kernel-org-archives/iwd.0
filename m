Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA4E6126
	for <iwd@lists.linux.dev>; Thu,  8 Sep 2022 23:06:43 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id 78so18096445pgb.13
        for <iwd@lists.linux.dev>; Thu, 08 Sep 2022 16:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=HRM9r0ZioIwiQ9Piud31JPPeoY4WKxSwrzJ+encRaek=;
        b=VoKWef3BEXIKOPdUjuggtY1C0Njcnbb5KdW3SHtkS17YAjF56d8bKGNPfD2mehkOuQ
         K+zEQLHcqDPentscCDfAwE8CvKzw92z/1Gj8MPW9k8BfLn/YLdd97FpvWKKMNJKEF0oi
         8XeZyKO/fIxtCCS4J6+aV9SUfRooXg8oiUl6XEqlWxaG3Y51LDGlKkg3g4efqJYOZFjq
         Y/jbpZIhh66IgYude9iZ7758Jcw3wo+oKV6pYpim58+XGZgrgQUw+Nwba49R5fTOx9O3
         D89mh1c4WUsYY+mEZtsJUPsYSXQr48wLCMjRF4BE7nei+qumip4YUghLvJb+HAxZQECU
         EuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HRM9r0ZioIwiQ9Piud31JPPeoY4WKxSwrzJ+encRaek=;
        b=V4QofZ/2RCOBjFw8NdJAWZ088I5Mhou+7qAC88Ka9Y576PQzVehqwlqSIb0UUp0ZMc
         tYqUNDd4vB4hU6MDgmkT11X/ZEO8oFApK05bW0qlztCPODjAeShKWAQP+R/CCk4PI/De
         etkK/0xbthG2CMCYhV7k2/7xBPkxzUXxgOSf1wpS0VzpdaRnXSO/roPFHoBU0HwDh+M2
         BecHVjK8Aq5O2ZIcS6ymcV3jSa9NVmEtQ1zZVHsGd7UQ+8zeSDKf+giSPpcy/w1k8FI4
         /dq82jebEDsHgucWOO6bYPvQViylgxIcAA2rFfjLskfdrYRzxVb/W4V1VmpcoaTI+MED
         vuiw==
X-Gm-Message-State: ACgBeo2FMFajU3qHntAlhtJseGsRrrlK5snRyHgYvviSkDSOUi3L8QWP
	mDf72lXREiecOhb3T0c3ToUhSzyfOTo=
X-Google-Smtp-Source: AA6agR52zR7jXSDli6B1dGY8eWXYPRuZ7tBmzzl3aRoa0/2j4ewQuSLCwC+MfqdfJ73II6lCBIrrWw==
X-Received: by 2002:a63:1a23:0:b0:434:4395:8b5a with SMTP id a35-20020a631a23000000b0043443958b5amr9430086pga.428.1662678402643;
        Thu, 08 Sep 2022 16:06:42 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090a3cc500b001facb7bc1adsm2329261pjd.26.2022.09.08.16.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 16:06:42 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/2] manager: add support for [General].Country
Date: Thu,  8 Sep 2022 16:06:39 -0700
Message-Id: <20220908230639.440880-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220908230639.440880-1-prestwoj@gmail.com>
References: <20220908230639.440880-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This lets the user set a country as the global regulatory
domain if the kernel/driver isn't doing it on its own.
---
 src/manager.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/src/manager.c b/src/manager.c
index 6ff642f1..fed02777 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -800,6 +800,14 @@ static void manager_config_notify(struct l_genl_msg *msg, void *user_data)
 	}
 }
 
+static void manager_set_reg_cb(struct l_genl_msg *msg, void *user_data)
+{
+	int err = l_genl_msg_get_error(msg);
+
+	if (err < 0)
+		l_error("Failed to set country (%d)", err);
+}
+
 static int manager_init(void)
 {
 	struct l_genl *genl = iwd_get_genl();
@@ -810,6 +818,7 @@ static int manager_init(void)
 	const char *randomize_str;
 	const char *if_whitelist = iwd_get_iface_whitelist();
 	const char *if_blacklist = iwd_get_iface_blacklist();
+	const char *cc;
 
 	nl80211 = l_genl_family_new(genl, NL80211_GENL_NAME);
 
@@ -853,6 +862,23 @@ static int manager_init(void)
 		goto error;
 	}
 
+	cc = l_settings_get_value(config, "General", "Country");
+	if (cc) {
+		if (strlen(cc) != 2 || !l_ascii_isalpha(cc[0]) ||
+					!l_ascii_isalpha(cc[1])) {
+			l_warn("[General].Country=%s is invalid. Country will "
+				"not be set", cc);
+		} else {
+			msg = l_genl_msg_new(NL80211_CMD_REQ_SET_REG);
+			l_genl_msg_append_attr(msg, NL80211_ATTR_REG_ALPHA2,
+						2, cc);
+			if (!l_genl_family_send(nl80211, msg,
+						manager_set_reg_cb,
+						NULL, NULL))
+				l_warn("Failed to set country");
+		}
+	}
+
 	randomize_str = l_settings_get_value(config, "General",
 							"AddressRandomization");
 	if (randomize_str) {
-- 
2.34.3

