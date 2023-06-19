Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FAE1426F
	for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 18:09:27 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-3fde0f72f61so11356191cf.1
        for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 11:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687198166; x=1689790166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4TnC3oB+fAzquovUT30Y/jTLMjzhcam4zbWrgZDJn9s=;
        b=er2f7aQZca/jWnDM6m0BSkuyO+cnUbpbbDcLxr+E4oj1L0pgQGCaoFwOmmRhv5552Q
         tE9JU7YlIuDPqFrKuw37PpFzl2l5vkjub5LQau8xD1/dLs9HOcchd+BB5bOzCbOM/6AU
         aNgyuMQBBd71czoGzGi5hFEItWthpZ+zMsY5ZEePHOTrpRNE1XKCYPDCMUrcH+mt+z+z
         spV8jTnzfnhK0UyYC4iW/LG/zeyjCXimvrR1Att9I+lIDGAIYmNniEEtxn6JZ6AjWHcT
         S29yTv8VZ9PXhaNSVu7oMjfwIE8Kq/WAk3aAmgsXqBH89uTTkSGmG2T6+aM9qzf8MZcS
         I4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687198166; x=1689790166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TnC3oB+fAzquovUT30Y/jTLMjzhcam4zbWrgZDJn9s=;
        b=HI/j3ck4lhPKWxL2NpZ8Elj5WhRi6UKUlZGInsD+9XUjqUl4EcVfe2gpZKfzp3MAjp
         fkX93PLSL8zS7fU/1EP4APCAofgq7U0ezkt+MTQsRr9Qq/qq2PJnxkQa3CiYDn5AKosw
         LCQ/b3T0f53ktJXplemwdAA4mIvcdv7d336PS621dhSvMdwhZ1u1Dyy4K0R8x1uR1zuV
         5fkO6cNqui8e6T+0hCfyIQSm9wY/fSRRNTGKBKyP40BTPyyQv99Wih9boYMTE9OCu7Gn
         7uLnH6YL0jgjeKwJXOBE+5jdX5mIAyOVU7mrS6F3QGbtM1N9vxiNrXWv7IwQRM1xgckv
         FhZw==
X-Gm-Message-State: AC+VfDxbNw2QJR6a24c842acemcgZEtP0yTVtwsQ0MpRNhann2mqfw0M
	PGIR4CFisyUDwN2bGpk33Jc07S1yvpU=
X-Google-Smtp-Source: ACHHUZ4WDQhwJf8uB6AkH5jzUUeDnFWwXKP4sO0YZG1FBrEgtjFhism8Y5eor9fUUpoePLdcSSjx5g==
X-Received: by 2002:ac8:5895:0:b0:3f5:16af:17db with SMTP id t21-20020ac85895000000b003f516af17dbmr11093514qta.0.1687198165908;
        Mon, 19 Jun 2023 11:09:25 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id i21-20020ac84f55000000b003ff0d00a71esm148930qtw.13.2023.06.19.11.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 11:09:25 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/3] netdev: move GETLINK into its own function, track command ID
Date: Mon, 19 Jun 2023 11:09:20 -0700
Message-Id: <20230619180922.231506-1-prestwoj@gmail.com>
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
 src/netdev.c | 51 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 18 deletions(-)

v3:
 * Zero get_link_cmd_id in callback

diff --git a/src/netdev.c b/src/netdev.c
index 4ee17f3b..a72745b0 100644
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
@@ -6116,12 +6122,14 @@ static void netdev_initial_down_cb(int error, uint16_t type, const void *data,
 static void netdev_getlink_cb(int error, uint16_t type, const void *data,
 			uint32_t len, void *user_data)
 {
+	struct netdev *netdev = user_data;
 	const struct ifinfomsg *ifi = data;
 	unsigned int bytes;
-	struct netdev *netdev;
 	l_netlink_command_func_t cb;
 	bool powered;
 
+	netdev->get_link_cmd_id = 0;
+
 	if (error != 0) {
 		l_error("RTM_GETLINK error %i: %s", error, strerror(-error));
 		return;
@@ -6133,8 +6141,7 @@ static void netdev_getlink_cb(int error, uint16_t type, const void *data,
 		return;
 	}
 
-	netdev = netdev_find(ifi->ifi_index);
-	if (!netdev)
+	if (L_WARN_ON((uint32_t)ifi->ifi_index != netdev->index))
 		return;
 
 	bytes = len - NLMSG_ALIGN(sizeof(struct ifinfomsg));
@@ -6212,6 +6219,27 @@ error:
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
@@ -6223,8 +6251,6 @@ struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
 	uint32_t wiphy_id;
 	struct netdev *netdev;
 	struct wiphy *wiphy = NULL;
-	struct ifinfomsg *rtmmsg;
-	size_t bufsize;
 	struct l_io *pae_io = NULL;
 
 	if (nl80211_parse_attrs(msg, NL80211_ATTR_IFINDEX, &ifindex,
@@ -6283,21 +6309,10 @@ struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
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

