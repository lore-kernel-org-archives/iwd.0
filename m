Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A8910797
	for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 15:25:58 +0000 (UTC)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4717089ae5bso611640e0c.0
        for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 08:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687188357; x=1689780357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dYFuc1eLJaVedB2s2uOQNvpgH0wktSxCA9jTlNh/iUw=;
        b=auprsuI6yF5zZqZDx6mgZWwLrNEF9kqtxt/bUStZDelZOf+SUy0MSE7/55aRWqz2h2
         GWn0zP7qu4uH8CZqJU40hpK/atO0hZM0rrqf55FqpuvXs8rNbWAZ4K5KUBFTocnNwsWI
         /bgEmObtRMbx+9T1Wsxcvzs9T8iiwxdp7aVi78j6jC9Hum7oCHHLSI/HkbEF7OvInHK+
         eH8dqj3wxOwlZtrJc9CaGjbanJyOtuHLAHccOBt4qYofthPYY7nVJ96Wt0r+82Fl4mAP
         yn0muQArL0VOABvIrXYowjnzE3ljiDscOqOgE0nQdgS1EKUXrdttMn2vfojDjr+F6/XQ
         AIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687188357; x=1689780357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dYFuc1eLJaVedB2s2uOQNvpgH0wktSxCA9jTlNh/iUw=;
        b=GauwaAp34m/z35BjPKY70IB0FoWMcKMPOiA1IQfzXkkAKYzwEjX0SW6AFs0g1Ech4L
         LTihIaS2QKaT9DX5zy3fArcoWIFCxjPQdfIeSTk9qrroEogfQSzv82n7lTpUdJOdXy7F
         CrpjLo2DZe33ng8jrxtUnbgF+tlQblcx4HyD6Il28iO6i/o/iFCRFixBGxYk0XehdjHv
         KueIMM0L9/gAJQSg2lSSf8nxHQIfeHELHOfEerMM8YCqN/RSoNXc+LGqOZGewnHvqkBs
         /l4C31LP6MZdORE+ABnzlll9dQeTRDArjaGM9sEeSV6FpQKHMuJwsR/uFky1vcwTL3CR
         78gw==
X-Gm-Message-State: AC+VfDzeGKHVNp1LeBKfn5SoJw6hUFWUah9LnXIxaMTXk2adepUKynfX
	2WM3DUJy2kZsxu0oGCk9XBk0YzY7xgI=
X-Google-Smtp-Source: ACHHUZ49EHu9VfLTWf9+1tDAKrr/HwumWvEe1WFUubyjtm+g/YcsJ3AV+SFww09rxKW21VQV0lU+RQ==
X-Received: by 2002:a1f:5cd8:0:b0:470:5862:90c0 with SMTP id q207-20020a1f5cd8000000b00470586290c0mr2514618vkb.5.1687188357564;
        Mon, 19 Jun 2023 08:25:57 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id j16-20020a0cf310000000b006260c683bf2sm66544qvl.53.2023.06.19.08.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:25:57 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/3] netdev: move GETLINK into its own function, track command ID
Date: Mon, 19 Jun 2023 08:25:41 -0700
Message-Id: <20230619152543.197532-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move this logic into its own function and track the command ID
so it can be canceled in case of netdev going down.
---
 src/netdev.c | 49 +++++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 4ee17f3b..af4b4b98 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -131,6 +131,7 @@ struct netdev {
 	uint32_t qos_map_cmd_id;
 	uint32_t mac_change_cmd_id;
 	uint32_t get_oci_cmd_id;
+	uint32_t get_link_cmd_id;
 	enum netdev_result result;
 	uint16_t last_code; /* reason or status, depending on result */
 	struct l_timeout *neighbor_report_timeout;
@@ -940,6 +941,11 @@ static void netdev_free(void *data)
 	if (netdev->fw_roam_bss)
 		scan_bss_free(netdev->fw_roam_bss);
 
+	if (netdev->get_link_cmd_id) {
+		l_netlink_cancel(rtnl, netdev->get_link_cmd_id);
+		netdev->get_link_cmd_id = 0;
+	}
+
 	scan_wdev_remove(netdev->wdev_id);
 
 	watchlist_destroy(&netdev->station_watches);
@@ -6116,9 +6122,9 @@ static void netdev_initial_down_cb(int error, uint16_t type, const void *data,
 static void netdev_getlink_cb(int error, uint16_t type, const void *data,
 			uint32_t len, void *user_data)
 {
+	struct netdev *netdev = user_data;
 	const struct ifinfomsg *ifi = data;
 	unsigned int bytes;
-	struct netdev *netdev;
 	l_netlink_command_func_t cb;
 	bool powered;
 
@@ -6133,8 +6139,7 @@ static void netdev_getlink_cb(int error, uint16_t type, const void *data,
 		return;
 	}
 
-	netdev = netdev_find(ifi->ifi_index);
-	if (!netdev)
+	if (L_WARN_ON((uint32_t)ifi->ifi_index != netdev->index))
 		return;
 
 	bytes = len - NLMSG_ALIGN(sizeof(struct ifinfomsg));
@@ -6212,6 +6217,27 @@ error:
 	return NULL;
 }
 
+static void netdev_get_link(struct netdev *netdev)
+{
+	struct ifinfomsg *rtmmsg;
+	size_t bufsize;
+
+	/* Query interface flags */
+	bufsize = NLMSG_ALIGN(sizeof(struct ifinfomsg));
+	rtmmsg = l_malloc(bufsize);
+	memset(rtmmsg, 0, bufsize);
+
+	rtmmsg->ifi_family = AF_UNSPEC;
+	rtmmsg->ifi_index = netdev->index;
+
+	netdev->get_link_cmd_id = l_netlink_send(rtnl, RTM_GETLINK, 0, rtmmsg,
+						bufsize, netdev_getlink_cb,
+						netdev, NULL);
+	L_WARN_ON(netdev->get_link_cmd_id == 0);
+
+	l_free(rtmmsg);
+}
+
 struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
 					const uint8_t *set_mac)
 {
@@ -6223,8 +6249,6 @@ struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
 	uint32_t wiphy_id;
 	struct netdev *netdev;
 	struct wiphy *wiphy = NULL;
-	struct ifinfomsg *rtmmsg;
-	size_t bufsize;
 	struct l_io *pae_io = NULL;
 
 	if (nl80211_parse_attrs(msg, NL80211_ATTR_IFINDEX, &ifindex,
@@ -6283,21 +6307,10 @@ struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
 	l_debug("Created interface %s[%d %" PRIx64 "]", netdev->name,
 		netdev->index, netdev->wdev_id);
 
-	/* Query interface flags */
-	bufsize = NLMSG_ALIGN(sizeof(struct ifinfomsg));
-	rtmmsg = l_malloc(bufsize);
-	memset(rtmmsg, 0, bufsize);
-
-	rtmmsg->ifi_family = AF_UNSPEC;
-	rtmmsg->ifi_index = ifindex;
-
-	l_netlink_send(rtnl, RTM_GETLINK, 0, rtmmsg, bufsize,
-					netdev_getlink_cb, NULL, NULL);
-
-	l_free(rtmmsg);
-
 	netdev_setup_interface(netdev);
 
+	netdev_get_link(netdev);
+
 	return netdev;
 }
 
-- 
2.25.1

