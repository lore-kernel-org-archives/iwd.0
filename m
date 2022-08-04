Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1DE28F9
	for <iwd@lists.linux.dev>; Thu,  4 Aug 2022 18:51:16 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id 73so649652pgb.9
        for <iwd@lists.linux.dev>; Thu, 04 Aug 2022 11:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Zk4Gb2yzPjGHSmFkTzbrJdoEFExhA3Rvdlbad4oek8A=;
        b=JAFvsqdPrQNyt4ClUPIb2vxb0k61Tkl5SPCSpJZ7vFslvzSoyVrJC8VSUYHitzMo90
         7isTbsb76JGZWKgPxYmAsbcN2e+KRRFgVU02gpnA4mMamYO+efGTc0p2PjGLugE5xoFe
         Lovt24fp34CF6rohNYCpJ6jD02BvujB+W7xVQaN9+0+YT8lQGapr00lkhUy/1G+D/8Mk
         g8RQw7l53K/PiFGDQpznjIk3E20ppB1wXkrAUuYVxy61EefntXLyDUtemmY3Uc275KMo
         zVwCaAMzk3vjqfLcC7MGqGywa+f7+sLBRSphkJ7knpPyNMXYSEpoSe5aVXOhRDyIXzhD
         DZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Zk4Gb2yzPjGHSmFkTzbrJdoEFExhA3Rvdlbad4oek8A=;
        b=0Vn02Luq+SYt4IRRzk3ud0X+GeQKQR63dNF5hDD5Q2jQ59hDy2PKi3g1HzNZ0vX2H+
         yhp8KM9tfYRLo8jDkNrx+Q0xYLv3SmsxEj9GU5f4GSm8Th3iGUE0v94yFObE+ichmGZN
         NAsAZ7HmYyzE0G4LuPEyJ6SH096S5lG4M2SV/YmqzfdgHr3Iiw2L5ElaKZI+oZ0XKxj+
         XEZ4UT/9zyXMZsmFpzJWlHlg4B0jZDI7szAgmN5Ta8QfMxMdN5Jvie8l2vXK1oGtmOs1
         yRgVNqY0Da0A4HFid5jPHf19ieMu0pbuyXvoTvOXuKvDVgF0vp5e9F4HFEV6/a4t9PgE
         H9Zg==
X-Gm-Message-State: ACgBeo3wUEIEWJIqYtDFaqh7uBVwQZKen87/fipY/3kDg+pz4t5OBjjp
	k1hbW3b0vuhETqbee9/SXOBpDLUlYXY=
X-Google-Smtp-Source: AA6agR7P49edvbF+wGIk8nm4AviG7+JHE6nHAl87ekX+oo9X7yGWYM3RCHxVfCu8hnnySh9giXBwCA==
X-Received: by 2002:aa7:8e91:0:b0:52d:8ebf:29a4 with SMTP id a17-20020aa78e91000000b0052d8ebf29a4mr3204355pfr.1.1659639075439;
        Thu, 04 Aug 2022 11:51:15 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id c7-20020a634e07000000b0041b3c112b1esm219954pgb.29.2022.08.04.11.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:51:15 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/7] wiphy: track GET_REG ID
Date: Thu,  4 Aug 2022 11:51:06 -0700
Message-Id: <20220804185112.457670-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep track of the GET_REG call so it can be canceled if the wiphy
goes down.
---
 src/wiphy.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

v3:
 * Moved this out into its own patch

diff --git a/src/wiphy.c b/src/wiphy.c
index 8cb9eb39..30b860da 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -121,6 +121,7 @@ struct wiphy {
 	/* Work queue for this radio */
 	struct l_queue *work;
 	bool work_in_callback;
+	unsigned int get_reg_id;
 
 	bool support_scheduled_scan:1;
 	bool support_rekey_offload:1;
@@ -341,6 +342,9 @@ static void wiphy_free(void *data)
 
 	l_debug("Freeing wiphy %s[%u]", wiphy->name, wiphy->id);
 
+	if (wiphy->get_reg_id)
+		l_genl_family_cancel(nl80211, wiphy->get_reg_id);
+
 	for (i = 0; i < NUM_NL80211_IFTYPES; i++)
 		l_free(wiphy->iftype_extended_capabilities[i]);
 
@@ -1875,6 +1879,8 @@ static void wiphy_get_reg_cb(struct l_genl_msg *msg, void *user_data)
 	uint32_t tmp;
 	bool global;
 
+	wiphy->get_reg_id = 0;
+
 	/*
 	 * NL80211_CMD_GET_REG contains an NL80211_ATTR_WIPHY iff the wiphy
 	 * uses a self-managed regulatory domain.
@@ -1892,8 +1898,9 @@ static void wiphy_get_reg_domain(struct wiphy *wiphy)
 	msg = l_genl_msg_new(NL80211_CMD_GET_REG);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY, 4, &wiphy->id);
 
-	if (!l_genl_family_send(wiphy->nl80211, msg, wiphy_get_reg_cb, wiphy,
-				NULL)) {
+	wiphy->get_reg_id = l_genl_family_send(wiphy->nl80211, msg,
+						wiphy_get_reg_cb, wiphy, NULL);
+	if (!wiphy->get_reg_id) {
 		l_error("Error sending NL80211_CMD_GET_REG for %s", wiphy->name);
 		l_genl_msg_unref(msg);
 	}
-- 
2.34.3

