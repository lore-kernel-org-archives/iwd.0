Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B6228F9
	for <iwd@lists.linux.dev>; Thu,  4 Aug 2022 18:51:20 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so660275pjf.2
        for <iwd@lists.linux.dev>; Thu, 04 Aug 2022 11:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=wsQ59p4psmTzZ/XOUqXYraFK9AD2nSA95AN9KOpoD2g=;
        b=MjorjsfaF5/25DptJy8qt3PWMwGlT7fC7yTwrH+qilOJgRgc4vRbX+74NvFBtDf2te
         bIXtFitUcjbH/xix+E+hGlifd2N3Jqn3lhGzYDd3sBW3XuvGXcNezNwbPEEBjc8HP8LI
         v2fUdDF6IVZU7Ol4kfs4KLqRRkerPgBCKvgiGBpW5PouKjNV89wQFpBQztiHCluzYqIC
         tWXaBEfvaYJrwLZVWSzPcDbyRMnYGDR0ygVdgDprq7QEF/3TpUXVBmmi42iDMEjLlSP9
         CVNpU1zFMg3RKUS030/Nujf1wvCcd9AvesAdpyXEFduqXbB2CUV3Kn0sn5bePE52vKHL
         fAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=wsQ59p4psmTzZ/XOUqXYraFK9AD2nSA95AN9KOpoD2g=;
        b=YNI9f3IFWXCUmvmb4nawbQ1INSmV4Tk7nutRtpI3RlUuu7/ndhpXYgy+lLg7WTIGoS
         3TbY2Uru6dewqE1ESJmGJlPTehbjSjBWXxtzqnDDcUZpSkyW58uvk/zlT4Mb8zEl2Tyw
         FaZDK2lLSpTsGN6wla8+dv053aNnhBAjtF3imwwEr+3HS9oYlFcQqUbvbRPRvwbUDMNU
         xteOXn+3MhYX9O7+/yIeWyCZL7i5bLZ6B4RVVsmZXucmUiVUJl1cVvIXW1LVblZbSAXP
         i3m4JzxqGwkszPMUtnBw4xwszZ5bMCwYWl//otBQdNWkkZcg4Z2Bmpmgs969ECax1yCf
         6kHw==
X-Gm-Message-State: ACgBeo2rrYD5j02ecbkOIsRdZARpHSwa7LbzhTUWUxdlWbV8vKoVpWWS
	GMDTNL4g/2Q0R9aMHxc64Yv3+e7G8eE=
X-Google-Smtp-Source: AA6agR5AuEdxfij2QfBW89h50cVGP9iRH5oy48u1FFKBcqZ1lRLxIhx8iKyVfDA5jHDxaIxr9oRAZA==
X-Received: by 2002:a17:90a:f490:b0:1f3:139e:a487 with SMTP id bx16-20020a17090af49000b001f3139ea487mr11989641pjb.91.1659639079444;
        Thu, 04 Aug 2022 11:51:19 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id c7-20020a634e07000000b0041b3c112b1esm219954pgb.29.2022.08.04.11.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:51:19 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 7/7] wiphy: don't re-dump wiphy if the regdom didn't change
Date: Thu,  4 Aug 2022 11:51:12 -0700
Message-Id: <20220804185112.457670-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220804185112.457670-1-prestwoj@gmail.com>
References: <20220804185112.457670-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For whatever reason the kernel will send regdom updates even if
the regdom didn't change. This ends up causing wiphy to dump
which isn't needed since there should be no changes in disabled
frequencies.

Now the previous country is checked against the new one, and if
they match the wiphy is not dumped again.
---
 src/wiphy.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 3beb351c..28d4b66e 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -2026,10 +2026,19 @@ static void wiphy_dump_after_regdom(struct wiphy *wiphy)
 	}
 }
 
-static void wiphy_update_reg_domain(struct wiphy *wiphy, bool global,
+static bool wiphy_update_reg_domain(struct wiphy *wiphy, bool global,
 					struct l_genl_msg *msg)
 {
-	char *out_country;
+	char out_country[2];
+	char *orig;
+
+	/*
+	 * Write the new country code or XX if the reg domain is not a
+	 * country domain.
+	 */
+	if (nl80211_parse_attrs(msg, NL80211_ATTR_REG_ALPHA2, out_country,
+				NL80211_ATTR_UNSPEC) < 0)
+		out_country[0] = out_country[1] = 'X';
 
 	if (global)
 		/*
@@ -2043,21 +2052,26 @@ static void wiphy_update_reg_domain(struct wiphy *wiphy, bool global,
 		 * wiphy created (that is not self-managed anyway) and we
 		 * haven't received any REG_CHANGE events yet.
 		 */
-		out_country = regdom_country;
+		orig = regdom_country;
+
 	else
-		out_country = wiphy->regdom_country;
+		orig = wiphy->regdom_country;
 
 	/*
-	 * Write the new country code or XX if the reg domain is not a
-	 * country domain.
+	 * The kernel seems to send regdom updates even if the country didn't
+	 * change. Skip these as there is no reason to re-dump.
 	 */
-	if (nl80211_parse_attrs(msg, NL80211_ATTR_REG_ALPHA2, out_country,
-				NL80211_ATTR_UNSPEC) < 0)
-		out_country[0] = out_country[1] = 'X';
+	if (orig[0] == out_country[0] && orig[1] == out_country[1])
+		return false;
 
 	l_debug("New reg domain country code for %s is %c%c",
 		global ? "(global)" : wiphy->name,
 		out_country[0], out_country[1]);
+
+	orig[0] = out_country[0];
+	orig[1] = out_country[1];
+
+	return true;
 }
 
 static void wiphy_get_reg_cb(struct l_genl_msg *msg, void *user_data)
@@ -2305,7 +2319,8 @@ static void wiphy_reg_notify(struct l_genl_msg *msg, void *user_data)
 
 	switch (cmd) {
 	case NL80211_CMD_REG_CHANGE:
-		wiphy_update_reg_domain(NULL, true, msg);
+		if (!wiphy_update_reg_domain(NULL, true, msg))
+			return;
 		break;
 	case NL80211_CMD_WIPHY_REG_CHANGE:
 		if (nl80211_parse_attrs(msg, NL80211_ATTR_WIPHY, &wiphy_id,
@@ -2316,7 +2331,9 @@ static void wiphy_reg_notify(struct l_genl_msg *msg, void *user_data)
 		if (!wiphy)
 			return;
 
-		wiphy_update_reg_domain(wiphy, false, msg);
+		if (!wiphy_update_reg_domain(wiphy, false, msg))
+			return;
+
 		break;
 	default:
 		return;
-- 
2.34.3

