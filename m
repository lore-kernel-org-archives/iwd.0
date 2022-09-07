Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB5E539B
	for <iwd@lists.linux.dev>; Wed,  7 Sep 2022 23:32:07 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id 145so16157815pfw.4
        for <iwd@lists.linux.dev>; Wed, 07 Sep 2022 16:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=GWa0yLj79HNbCIGQlvsU65AS9u79rObDUUZOp4frGwE=;
        b=VGFG6NAc4zT5bwFlGJyAmtTvhZ+I26maI2KZ6gNmIoYkD7r0rO53DFptkSOxn74SrZ
         1FNdjCvoAvN7D6QPOXUOhf8ivlIeOS4M4ijEutgZjoGYQ1lnPIIi9XvNOusntfKOybGW
         n1DEwH0CKcrEmKJ4cfCfT0aQTM8VD5nycqpRgQbSHVHUcwqtscmQx88Fygn0sdtPOXka
         XENMKxGAimfWQTdL9QS9nU1SaNPN1gmm/49LFqU3Y6PLPOwtmvcoo+T4eDM97BUzb1gj
         8M3fQEc81nwwfBteisG9oiswC/Wyr/StiekOeLbHS1z7Vrv3LYQgYYAQ+63K/tbZ141G
         OB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GWa0yLj79HNbCIGQlvsU65AS9u79rObDUUZOp4frGwE=;
        b=uLKAFnaD+0cZJzksx2ttqM4nqiZWgANv9Um40tzZyCMTOJgdnoiNF5KshWh5V0aGpn
         7KFD7W3Xi7XRC6iBwph1cAsC1ea3fZ1XWDQbRmxGJcD9QlFtIjFDVCsUJk680Bal+SU2
         9eHHTRc3i+DuXWv5tjOCiL3D2RVem5rtjhaQXrkX/e3LQbjwlLm7JQ1Hua8FcyPqoba/
         lcmMHwLLyiubgNZZjJ4EOw23HjVbiFWK4W1Ei0YYdPLF0OZnj0rxRjThfMtkqNNm6doW
         AXZE/8B67vGK8zpU3VdpqDyLD4FvB15vRKaclKFq6/xQd5ZHJhkq/jbdGR8HGNA110X3
         F1kw==
X-Gm-Message-State: ACgBeo1CELS63czwu7+WLRXAruSsybr/NQyWOodV+qEAWgDuYOo4Q48x
	Yuo7OUlGLNOcPUwThd1Gy/qhb8joDdc=
X-Google-Smtp-Source: AA6agR6gANwsAoie+Opq5Yab78f3iFV92adv+xDvjHPK5Josj9LdkjMzvCnQsJac8UHu16pw9/Jz6g==
X-Received: by 2002:a63:5a44:0:b0:431:fa3a:f92c with SMTP id k4-20020a635a44000000b00431fa3af92cmr5558465pgm.471.1662593526651;
        Wed, 07 Sep 2022 16:32:06 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id q24-20020a63f958000000b004348bd693a8sm4918192pgk.31.2022.09.07.16.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 16:32:06 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] wiphy: support country code override
Date: Wed,  7 Sep 2022 16:32:01 -0700
Message-Id: <20220907233201.227577-4-prestwoj@gmail.com>
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

Depending on the device the regulatory domain may never get
set on its own. This is worked around in wpa_supplicant by
allowing the user to supply a country code. The kernel
_should_ set this on its own based on the docs, but ultimately
will fall back to user defined if the driver doesn't set it.

IWD now needs to work around this problem by allowing users
to supply the country code in main.conf.

A few notes here:
 - Setting the country may not effect the actual regulatory
   domain. This is because the kernel still remains in control.
   Any request is merely a hint to the kernel.
 - This only applies to devices under the global regulatory
   domain. Self-managed devices will not allow setting the
   regdom.
---
 src/wiphy.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index af675694..b87cfefd 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -65,7 +65,9 @@ static char **whitelist_filter;
 static char **blacklist_filter;
 static int mac_randomize_bytes = 6;
 static unsigned int get_reg_id;
+static unsigned int set_reg_id;
 static char regdom_country[2];
+static char regdom_override[2];
 static uint32_t work_ids;
 static unsigned int wiphy_dump_id;
 
@@ -2090,6 +2092,14 @@ static void wiphy_get_reg_cb(struct l_genl_msg *msg, void *user_data)
 				NL80211_ATTR_UNSPEC) < 0;
 
 	wiphy_update_reg_domain(wiphy, global, msg);
+
+	if (global && regdom_override[0] && regdom_override[1]) {
+		if (regdom_override[0] != regdom_country[0] ||
+				regdom_override[1] != regdom_country[1])
+			l_warn("Regdom %c%c does not match override %c%c",
+				regdom_country[0], regdom_country[1],
+				regdom_override[0], regdom_override[1]);
+	}
 }
 
 static void wiphy_get_reg_domain(struct wiphy *wiphy)
@@ -2119,6 +2129,69 @@ static void wiphy_get_reg_domain(struct wiphy *wiphy)
 		get_reg_id = id;
 }
 
+static void wiphy_set_reg_cb(struct l_genl_msg *msg, void *user_data)
+{
+	int err = l_genl_msg_get_error(msg);
+
+	set_reg_id = 0;
+
+	/* Just warn if the CC was invalid, can't do much else here... */
+	if (err < 0)
+		l_warn("Error setting regulatory domain (%d)", err);
+
+	/*
+	 * Always get the regdom to see if the override actually worked. The
+	 * kernel may choose to ignore REQ_SET_REG requests. If so this will be
+	 * logged. Since this only applies to the global regdom do a global
+	 * GET_REG with wiphy set to NULL
+	 */
+	wiphy_get_reg_domain(NULL);
+}
+
+static void wiphy_set_reg_domain(const char *cc)
+{
+	struct l_genl_msg *msg;
+
+	regdom_override[0] = cc[0];
+	regdom_override[1] = cc[1];
+
+	msg = l_genl_msg_new(NL80211_CMD_REQ_SET_REG);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_REG_ALPHA2, 2, cc);
+
+	set_reg_id = l_genl_family_send(nl80211, msg, wiphy_set_reg_cb,
+					NULL, NULL);
+	/* Could try getting the regdom, but that likely wouldn't work either */
+	if (L_WARN_ON(!set_reg_id))
+		return;
+
+	l_debug("Trying to set country to %s", cc);
+}
+
+static void wiphy_setup_reg_domain(struct wiphy *wiphy)
+{
+	const struct l_settings *config = iwd_get_config();
+	const char *cc = l_settings_get_value(config, "General", "Country");
+
+	/*
+	 * At least do basic validation. If this fails force a GET_REG but do
+	 * not try setting the domain.
+	 */
+	if (cc) {
+		if (strlen(cc) != 2 || !l_ascii_isalpha(cc[0]) ||
+					!l_ascii_isalpha(cc[1])) {
+			l_error("Invalid setting [General].Country=%s", cc);
+			cc = NULL;
+		}
+	}
+
+	if (!cc || wiphy->self_managed) {
+		wiphy_get_reg_domain(wiphy->self_managed ? wiphy : NULL);
+		return;
+	}
+
+	wiphy_set_reg_domain(cc);
+}
+
 void wiphy_create_complete(struct wiphy *wiphy)
 {
 	wiphy_register(wiphy);
@@ -2133,7 +2206,7 @@ void wiphy_create_complete(struct wiphy *wiphy)
 
 	wiphy_set_station_capability_bits(wiphy);
 	wiphy_setup_rm_enabled_capabilities(wiphy);
-	wiphy_get_reg_domain(wiphy->self_managed ? wiphy : NULL);
+	wiphy_setup_reg_domain(wiphy);
 
 	wiphy_print_basic_info(wiphy);
 }
@@ -2540,6 +2613,11 @@ static void wiphy_exit(void)
 		get_reg_id = 0;
 	}
 
+	if (set_reg_id) {
+		l_genl_family_cancel(nl80211, set_reg_id);
+		set_reg_id = 0;
+	}
+
 	l_queue_destroy(wiphy_list, wiphy_free);
 	wiphy_list = NULL;
 
-- 
2.34.3

