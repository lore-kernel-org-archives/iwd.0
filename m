Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071B663AC
	for <iwd@lists.linux.dev>; Thu,  3 Nov 2022 17:31:00 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso5953228pjc.0
        for <iwd@lists.linux.dev>; Thu, 03 Nov 2022 10:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z382w+ejbLWQFYQvGWYorSnyaamyHyeaUeQ9Op6/71c=;
        b=ireXQ1+WwVWYXBW46DsYziwlYRYCIKRaY595XnhC8caW/qFlC8ZTD6tEC/7RlmRflG
         KIWvGZApxRhRf5iI5QuLSQV4BDR2toNg7Yx0RpZRwRlLG49Xv7KeOLVoUgMTy4wetKhl
         xCcmzdD7psOaqgvCCBRDRFj3Gy4enlmgU/ww4l7ggYioVhwAIIvlQNFVziFdP7ymM0vz
         7qZ4aXpmr4DPWnIusOWrlYsKaXg5F9MWwguV7AIp0V+9+uFO2q/l6cPh43MLgpPY/n7o
         PNf8IBxo2HdJu4mlsE9/7L8WXxnH/fXxgmQFo1RAu05LIxYYBm82gMLbgICTwn+pd6/K
         3oTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z382w+ejbLWQFYQvGWYorSnyaamyHyeaUeQ9Op6/71c=;
        b=ENWznHvl3zSM2Aat2cK/fG/NJfaYpRt0M++yXyjwl6cn4yub2tPTrVjI2nBU2LCxm4
         9nBg7RrEw7DVtOGRsqGvP/vO58qQ4WhS6dRJxQpA/XhQSYJMswU1X/S7QBfN2RXIes0H
         inS2E4q/Px1n2gWsv4y+aqjriWJHS5UX0GHrE0+vDk/mlyqvthkzGrgKcVQSvv0XXcay
         NUcJb02NbFLssjOkVtyqQ4KpD8/Sefh4yjTCa9nCVUzlfoxZFU8lf4FQTF6R1JSpCQE6
         sBYPhu6E6OJAdyRTgZrKYko3Bk06LPD2TZdp0DCPefVLuXapKkQG1a1GH7sFk7KnRyln
         C4IQ==
X-Gm-Message-State: ACrzQf1oOHX5gPqCEZ5kQmuFjjWOpL09uof75KTK4q/QbMDq/Hg9zvjf
	uGtpVo7t0kn6Zx7vBvEK2k1rJMRQPPI=
X-Google-Smtp-Source: AMsMyM5kz+i2twp7fiNovVech1OIDLGWULFpcqtzeIWmayX4SsmYTF1RR+qROuKW70VANFtJ5wZAyQ==
X-Received: by 2002:a17:90a:b8f:b0:213:c985:b5e5 with SMTP id 15-20020a17090a0b8f00b00213c985b5e5mr27486640pjr.57.1667496660262;
        Thu, 03 Nov 2022 10:31:00 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id k18-20020aa79d12000000b0056afd55722asm979721pfp.153.2022.11.03.10.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:30:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] ap: update Scanning property when AP starts
Date: Thu,  3 Nov 2022 10:30:55 -0700
Message-Id: <20221103173057.381232-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221103173057.381232-1-prestwoj@gmail.com>
References: <20221103173057.381232-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This wasn't being updated meaning the property is missing until a
scan is issued over DBus.

Rather than duplicate all the property changed calls they were all
factored out into a helper function.
---
 src/ap.c | 55 +++++++++++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

v2:
 * Fixed build problem that didn't make it into v1

diff --git a/src/ap.c b/src/ap.c
index 9c82a545..665c1857 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -3672,6 +3672,28 @@ struct ap_if_data {
 	struct l_dbus_message *pending;
 };
 
+static void ap_properties_changed(struct ap_if_data *ap_if)
+{
+	l_dbus_property_changed(dbus_get_bus(),
+				netdev_get_path(ap_if->netdev),
+				IWD_AP_INTERFACE, "Started");
+	l_dbus_property_changed(dbus_get_bus(),
+				netdev_get_path(ap_if->netdev),
+				IWD_AP_INTERFACE, "Name");
+	l_dbus_property_changed(dbus_get_bus(),
+				netdev_get_path(ap_if->netdev),
+				IWD_AP_INTERFACE, "Frequency");
+	l_dbus_property_changed(dbus_get_bus(),
+				netdev_get_path(ap_if->netdev),
+				IWD_AP_INTERFACE, "PairwiseCiphers");
+	l_dbus_property_changed(dbus_get_bus(),
+				netdev_get_path(ap_if->netdev),
+				IWD_AP_INTERFACE, "GroupCipher");
+	l_dbus_property_changed(dbus_get_bus(),
+				netdev_get_path(ap_if->netdev),
+				IWD_AP_INTERFACE, "Scanning");
+}
+
 static void ap_if_event_func(enum ap_event_type type, const void *event_data,
 				void *user_data)
 {
@@ -3703,21 +3725,8 @@ static void ap_if_event_func(enum ap_event_type type, const void *event_data,
 
 		reply = l_dbus_message_new_method_return(ap_if->pending);
 		dbus_pending_reply(&ap_if->pending, reply);
-		l_dbus_property_changed(dbus_get_bus(),
-					netdev_get_path(ap_if->netdev),
-					IWD_AP_INTERFACE, "Started");
-		l_dbus_property_changed(dbus_get_bus(),
-					netdev_get_path(ap_if->netdev),
-					IWD_AP_INTERFACE, "Name");
-		l_dbus_property_changed(dbus_get_bus(),
-					netdev_get_path(ap_if->netdev),
-					IWD_AP_INTERFACE, "Frequency");
-		l_dbus_property_changed(dbus_get_bus(),
-					netdev_get_path(ap_if->netdev),
-					IWD_AP_INTERFACE, "PairwiseCiphers");
-		l_dbus_property_changed(dbus_get_bus(),
-					netdev_get_path(ap_if->netdev),
-					IWD_AP_INTERFACE, "GroupCipher");
+
+		ap_properties_changed(ap_if);
 
 		l_rtnl_set_linkmode_and_operstate(rtnl,
 					netdev_get_ifindex(ap_if->netdev),
@@ -3730,21 +3739,7 @@ static void ap_if_event_func(enum ap_event_type type, const void *event_data,
 						netdev_get_path(ap_if->netdev),
 						IWD_AP_DIAGNOSTIC_INTERFACE);
 
-		l_dbus_property_changed(dbus_get_bus(),
-					netdev_get_path(ap_if->netdev),
-					IWD_AP_INTERFACE, "Started");
-		l_dbus_property_changed(dbus_get_bus(),
-					netdev_get_path(ap_if->netdev),
-					IWD_AP_INTERFACE, "Name");
-		l_dbus_property_changed(dbus_get_bus(),
-					netdev_get_path(ap_if->netdev),
-					IWD_AP_INTERFACE, "Frequency");
-		l_dbus_property_changed(dbus_get_bus(),
-					netdev_get_path(ap_if->netdev),
-					IWD_AP_INTERFACE, "PairwiseCiphers");
-		l_dbus_property_changed(dbus_get_bus(),
-					netdev_get_path(ap_if->netdev),
-					IWD_AP_INTERFACE, "GroupCipher");
+		ap_properties_changed(ap_if);
 
 		l_rtnl_set_linkmode_and_operstate(rtnl,
 					netdev_get_ifindex(ap_if->netdev),
-- 
2.34.3

