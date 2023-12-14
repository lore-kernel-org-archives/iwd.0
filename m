Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7373399F
	for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chH9oibh"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-77f58040770so445803085a.2
        for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 11:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702580626; x=1703185426; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Up4+A7HOGrevr/+iLe+qZbY1NAfzmhmZmrcwUP48K2Q=;
        b=chH9oibhSVGswoBt4LSLy00qFuKjyOus2tDEdEGnyhQ554ns6MmunK3622o1QS08+E
         /dxx7oWHj9tOTx5G6wiLQFnnrAJxXpHq4RUUSfgBvcfrdFxpXH20Sn2nA8Q1ENXLdQU4
         vBxoAkk1e1CIryhahx6GM9NcvwO2v3gNi0CTEmJWss5YejvGBs9JTc/dcWt+7EoTMl+q
         NQ5HB2Cv7kI67Rb20k4eibm0L8y6Bo9UP+LQ+bQRFa2fbptFt0AhUGb3j/TOZv4/P8Gw
         S7Xgos5ZyvJGyZUKSsIYmiBxvdDi0FzQPaE+etXW3aYc/qPQjwBbPmqKOhxUkWh93Qh5
         juEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702580626; x=1703185426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Up4+A7HOGrevr/+iLe+qZbY1NAfzmhmZmrcwUP48K2Q=;
        b=XdngNit/6b8lg8QaiSRi31jtNuGUBi2n/9wi4rcsPi/5wloegeWf/+Td6+ouqx5Him
         DIhLoWvHInDNyL5lqEKYe1glJ1TgY8ozeCC0aEH5guXE3ZubW8aJOGrDCBJB/r1VWGVi
         80M0srjkOEqH2rn25szU1z5Y3wGBgJWsDviPKp1O6yGhVQ4zYnVS0zMbXjK07RUn80SX
         H0EaRUQZ/kQPIq4o2aW2bNJLnSFMAchXvCHHrlnJAn8E3N4+E7bFGTR6werD/9dUrOMq
         R1MrLbYYuL7+pDxKMLfgjC7kcI0uwybdfvb8cb7NarYAcCQFe2VE02kp8+rD8lng+mSS
         s63A==
X-Gm-Message-State: AOJu0YymhY2TPPhLRmD6sRkhdnDnYKLKwMfc8BICItavGL0v5ELJexN6
	Xmgd/L6efvYNvsoGCrxWI+TwB4bu3qQ=
X-Google-Smtp-Source: AGHT+IEZfr0q3RXtDdrizjPalqo+UDt0bgM1apksp8KZVw2/825xxqVhcT/L6/CpXcKCA5Z+wBhhdg==
X-Received: by 2002:a05:620a:36f6:b0:77f:7031:f59e with SMTP id cz54-20020a05620a36f600b0077f7031f59emr8421882qkb.82.1702580626282;
        Thu, 14 Dec 2023 11:03:46 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id re22-20020a05620a8e1600b0077891d2d12dsm5496591qkn.43.2023.12.14.11.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 11:03:46 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/1] netdev: retry on failed ifup
Date: Thu, 14 Dec 2023 11:03:40 -0800
Message-Id: <20231214190340.133011-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214190340.133011-1-prestwoj@gmail.com>
References: <20231214190340.133011-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the interface fails to be brought up (except for RFKILL) continue
to retry. Certain wireless hardware isn't very reliable when it
comes to this code path and its been seen (on ath10k) that rarely
this call fails. It was originally thought to be tied to power save
but recently it was happening without the disable power save setting.

For headless devices its very important IWD starts up and connects
so to guard against buggy hardware continue to retry bringing the
interface up.
---
 src/netdev.c | 41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 522baf7a..6f666178 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -139,6 +139,7 @@ struct netdev {
 	struct l_timeout *sa_query_timeout;
 	struct l_timeout *sa_query_delay;
 	struct l_timeout *group_handshake_timeout;
+	struct l_timeout *ifup_retry_timeout;
 	uint16_t sa_query_id;
 	int8_t rssi_levels[16];
 	uint8_t rssi_levels_num;
@@ -1027,6 +1028,11 @@ static void netdev_free(void *data)
 		netdev->get_link_cmd_id = 0;
 	}
 
+	if (netdev->ifup_retry_timeout) {
+		l_timeout_remove(netdev->ifup_retry_timeout);
+		netdev->ifup_retry_timeout = NULL;
+	}
+
 	scan_wdev_remove(netdev->wdev_id);
 
 	watchlist_destroy(&netdev->station_watches);
@@ -5884,6 +5890,21 @@ static bool netdev_disable_power_save(struct netdev *netdev)
 	return true;
 }
 
+static void netdev_initial_up_cb(int error, uint16_t type, const void *data,
+					uint32_t len, void *user_data);
+
+static void netdev_initial_up_retry(struct l_timeout *timeout, void *user_data)
+{
+	struct netdev *netdev = user_data;
+
+	l_timeout_remove(timeout);
+	netdev->ifup_retry_timeout = NULL;
+
+	netdev->set_powered_cmd_id =
+		l_rtnl_set_powered(rtnl, netdev->index, true,
+					netdev_initial_up_cb, netdev, NULL);
+}
+
 static void netdev_initial_up_cb(int error, uint16_t type, const void *data,
 					uint32_t len, void *user_data)
 {
@@ -5891,14 +5912,20 @@ static void netdev_initial_up_cb(int error, uint16_t type, const void *data,
 
 	netdev->set_powered_cmd_id = 0;
 
-	if (!error)
+	switch (error) {
+	case 0:
 		netdev->ifi_flags |= IFF_UP;
-	else {
-		l_error("Error bringing interface %i up: %s", netdev->index,
-			strerror(-error));
-
-		if (error != -ERFKILL)
-			return;
+		break;
+	case -ERFKILL:
+		l_error("Error bringing interface %i up due to RFKILL",
+					netdev->index);
+		break;
+	default:
+		l_error("Error bringing interface %i up: %s, retrying in 1s",
+					netdev->index, strerror(-error));
+		netdev->ifup_retry_timeout = l_timeout_create(1,
+				netdev_initial_up_retry, netdev, NULL);
+		return;
 	}
 
 	l_rtnl_set_linkmode_and_operstate(rtnl, netdev->index,
-- 
2.34.1

