Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FB979F1
	for <iwd@lists.linux.dev>; Fri,  4 Nov 2022 16:38:06 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id c2so5363977plz.11
        for <iwd@lists.linux.dev>; Fri, 04 Nov 2022 09:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hMBkXGxqxAEP5TxsN1MnS0D2OblAGH7zCOQvv0ird10=;
        b=GGMly5GTsHbrCNO9Pqgt0U1boDAeNj70XjIhR+8iGISrEgcPYbsMFXVyVnsQvjW3Lp
         h76RuTNw4aBrd0/I9XIOtQ2uu1ajaJd0rc0V72i4hXdIvnG0b/x+KBEo2Dy2ylpZJ676
         jOZEzjuFvdSa+BTETaRR9a1Kw4cHonlDtsLS5b7QSl9rbhjK7KIpLYpwLFs30tFrCKbe
         ff/GTc0V4obMrNHBKGU54MEwF9bqKCGqSu6CNECLhl5dawV5LpBhfc0A6HM046adzSlL
         P5c7qMDlvDuTEGdmToY4BycDxoTmtscHqSThMtF/JgF6gP1WpNBAjTdAMMKTgf5VbvGp
         pCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMBkXGxqxAEP5TxsN1MnS0D2OblAGH7zCOQvv0ird10=;
        b=QIrbIfLc998ewC5edN4hRshk++zjBZ03+PHbm6IUC7EJ54x17vZKuF7uI07a7V1S8O
         rBUA7mVedjxOG2iM7R9pP6uiaK74l68ezITgkNunz3XKgFdCpDgzFodAUs9W01B5sXVF
         BeUAQfqyi6nWpAIivgDHO4TaUZz0NBhJK9lQTTJD3ajqR/wCqOps5TFo4BX2wFIqTAKT
         /2RbwAvnFclIg7eGkuQPiyH455icaMqbGCV9ZIm9LBRg1wSsGIympaIo5VupAX6SNqEK
         WjP9QzQYWo2na+DCM6be1o3tmvSJJbWPhsB3sdOWivQ7U81FXBgQRc9j7h3SIBcAdolS
         QGFg==
X-Gm-Message-State: ACrzQf3hEHTfFVGfRo1NQS/0OiRdblozMOFQ1lUkijOx1x2yYZ/4vFPQ
	ycGdrqEKQVLsE+gnTLieWXnmMjzjEFM=
X-Google-Smtp-Source: AMsMyM6dy0LM4m1Fa/jQWIsomVstDzgHw/lQRcd2ksCO8yPg/NE05D+Y1rF83LAer9hsEVzbFUKghA==
X-Received: by 2002:a17:902:f78c:b0:185:3d6a:7576 with SMTP id q12-20020a170902f78c00b001853d6a7576mr36230580pln.86.1667579885868;
        Fri, 04 Nov 2022 09:38:05 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id 65-20020a620544000000b0056e15b7138esm2904741pff.157.2022.11.04.09.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 09:38:05 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/6] ap: update Scanning property when AP starts
Date: Fri,  4 Nov 2022 09:37:55 -0700
Message-Id: <20221104163800.451867-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
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

