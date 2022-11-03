Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B682C1EA01
	for <iwd@lists.linux.dev>; Thu,  3 Nov 2022 17:00:54 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id s196so2199657pgs.3
        for <iwd@lists.linux.dev>; Thu, 03 Nov 2022 10:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZiCIpCzwC6A3fEe2n3sa2PA6ye9xqX0hJeX/Br0PaU=;
        b=epFDZHDuM9TKf4G5o+YUyQMYol+qx8p143rSvCvNuu2a2DnNJpFTDMbui73hxd+Yhm
         toS/FhAXbWZAmoRi/gwKaX8S4mITME2IovFLm2kSR+ci/4TF2uBTZB5/gsGlm6wFGSqt
         7CZv1t6jA/xCr4HHiY+fMz52sNL5gByLf+WRkpE5IlhiIt5lFKHLiF5fQ4GZAJPlwqG8
         6AUphyWoMfX4FqVyvjwkAhPIrF4C2YifA5TYQvVOruUgVG8OI5XkZSkAzbs2CVFffk1/
         rIZUzgpfMzXx974q5y7xWlBzVfq1tbo6Tpuwke+EJMFGs0w7uLRj+dOEGThrtzoUZgRk
         aiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZiCIpCzwC6A3fEe2n3sa2PA6ye9xqX0hJeX/Br0PaU=;
        b=Opm7tVZEEYR4TYa3totQUjoOA7IUQfnT3kaExhECrFGLCSfkKc6mV2dWajgCheiDEH
         lGiKF3rgheed9YFp89trc6RomJXMDePVJjMoO8xYWuYhBCVoSQidLbu7xNgXvgS8tWrz
         0HqxTsrhuGWwGy/CY/ZqtqQMa8d/VbTX9ehDGe/n544u4qod4mVmtVWIoi5SM77JUnuG
         4WJbGl9WC8sK07ZXsrYYCiUNxnoq75mn1DfKn+IrZlaE4WjX6xyrDN+U9VOx1Krb0Pt+
         B0I9YXoSCaaV/4jDvFu/VAQDCuigOcxUFz8PmNsCbPALc0qfXK2C0N+9y4IgzWY37Kmd
         m4TQ==
X-Gm-Message-State: ACrzQf36nBi0vuDNScDaso3uHmN395nHVvVzplqc73y5Zul8dqOeB/oR
	oTc2TjgfTy4t9ARGNtpvOxxZSXVGnTg=
X-Google-Smtp-Source: AMsMyM55pU4uWH6rkIRcANR/tLOKsdkvUZmDK0jTH4YIIUKdmFiCgXX2AbsqwxlLyo3u7X6/sX5M9w==
X-Received: by 2002:a63:ea08:0:b0:46e:9bac:6d9e with SMTP id c8-20020a63ea08000000b0046e9bac6d9emr26740045pgi.334.1667494853964;
        Thu, 03 Nov 2022 10:00:53 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z3-20020a623303000000b0056c349f5c70sm995465pfz.79.2022.11.03.10.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:00:53 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] ap: update Scanning property when AP starts
Date: Thu,  3 Nov 2022 10:00:48 -0700
Message-Id: <20221103170050.379587-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221103170050.379587-1-prestwoj@gmail.com>
References: <20221103170050.379587-1-prestwoj@gmail.com>
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
index 9c82a545..34a47f17 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -3666,6 +3666,28 @@ bool ap_push_button(struct ap_state *ap)
 	return true;
 }
 
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
 struct ap_if_data {
 	struct netdev *netdev;
 	struct ap_state *ap;
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

