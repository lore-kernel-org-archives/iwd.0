Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC987EAE2
	for <iwd@lists.linux.dev>; Thu, 15 Jun 2023 19:24:31 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f8ca80e889so22041595e9.3
        for <iwd@lists.linux.dev>; Thu, 15 Jun 2023 12:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686857070; x=1689449070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hi7fZU1eo33yQQz8F7uBWjlhP+8IboaQ9u+SI9ZiYTI=;
        b=s0BLRgAFSD0hXEiLCLTyBR8ipvE8/j5Eqo0EBIClWwPj0ryHcb9MeywuIFiPGRNGM2
         FlIcYJlNmAe7nB8TcbdD9mWEl3aphKTTn5fXOeorNkaiFBn+NPAL+4OJj5vR6s24Tb9H
         FLiUfOJjEj3lLrSJurfiqR6CjdteVA13jOyH46E6F3Z63X6i2ZvndmatIj5hTWcz+q2t
         dDNRg4erlo4R640c0ahyuScsxWZSqNmqsI4ZpTwwXcvvVEcQT1GQLeKA8k3b+LNA50B1
         S/aAq9BP8P6Vj7eRZgxDVJJKY8jnvP/vuZb4t4YiQSubVCNbBEBJCOKALTTxFLNcWEkg
         53BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686857070; x=1689449070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hi7fZU1eo33yQQz8F7uBWjlhP+8IboaQ9u+SI9ZiYTI=;
        b=ZHBC3S/ybhAoJi+UiFah/arhqB8Xx5lI6bTqfY8Sgr3RMN4uQ4z2AJY9FQKL469o5+
         5MdKoX00EMZ1xWuqp1Ny6/OrMqB1R9uWr9IV5zFrCfRC7cVvtOipiuXyai/pSNMFVb6h
         6Je5wb5Rg9vQeMbhriiJMpkIS3wHRQAYiCAR5EvkrR5aZ+1jX1xQ1NHIpzT7Qaoj+fjg
         ii28SGQC0wFjlJVw6DU8W+yrvbv4sezgX3wklHuDJAv2ChU6bC7wGVpmZozU15WXhpg5
         XCr8kBGOUaDjGk3bWHXgjBOF5ZjentL295nAsdyJpQZizUBT1izMegAfGRySpCAc/S9R
         x4Pw==
X-Gm-Message-State: AC+VfDwodJ7jyUm5baQOF83/hFwt+m/Ny7xNUg08ENsSqgmUiEojpBCO
	VPXJ58cK9tmGSkxsM3KbAu4cv7j2Bd3Keg==
X-Google-Smtp-Source: ACHHUZ6Gpg+vdmB3jP2BHRl6K8x2gHot5YlERL4xCntzT0QGaZIxRs74OEAct7zpJqptj7eTf2u25Q==
X-Received: by 2002:a05:600c:22c1:b0:3f8:afe:5c44 with SMTP id 1-20020a05600c22c100b003f80afe5c44mr165102wmg.12.1686857069563;
        Thu, 15 Jun 2023 12:24:29 -0700 (PDT)
Received: from LOCLAP699.dhl-toledo.locus ([195.55.200.178])
        by smtp.gmail.com with ESMTPSA id 5-20020a05600c020500b003f6028a4c85sm28241wmi.16.2023.06.15.12.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 12:24:29 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/7] netdev: disable power save if required
Date: Thu, 15 Jun 2023 12:24:13 -0700
Message-Id: <20230615192415.1718516-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230615192415.1718516-1-prestwoj@gmail.com>
References: <20230615192415.1718516-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable power save if the wiphy indicates its needed. Do this
before issuing GET_LINK so the netdev doesn't signal its up until
power save is disabled.
---
 src/netdev.c | 80 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 66 insertions(+), 14 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 4ee17f3b..1b44944e 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -6212,6 +6212,65 @@ error:
 	return NULL;
 }
 
+static void netdev_get_link(uint32_t ifindex)
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
+	rtmmsg->ifi_index = ifindex;
+
+	l_netlink_send(rtnl, RTM_GETLINK, 0, rtmmsg, bufsize,
+					netdev_getlink_cb, NULL, NULL);
+
+	l_free(rtmmsg);
+}
+
+static void netdev_disable_ps_cb(struct l_genl_msg *msg, void *user_data)
+{
+	int err = l_genl_msg_get_error(msg);
+	uint32_t ifindex = L_PTR_TO_UINT(user_data);
+
+	/* Can't do anything about it but inform the user */
+	if (err < 0) {
+		l_error("Failed to disable power save for ifindex %u (%s: %d)",
+				ifindex, strerror(-err), err);
+		return;
+	}
+
+	l_debug("Disabled power save for ifindex %u", ifindex);
+}
+
+static void netdev_disable_ps_destroy(void *user_data)
+{
+	uint32_t ifindex = L_PTR_TO_UINT(user_data);
+
+	netdev_get_link(ifindex);
+}
+
+static bool netdev_disable_power_save(uint32_t ifindex)
+{
+	struct l_genl_msg *msg = l_genl_msg_new(NL80211_CMD_SET_POWER_SAVE);
+	uint32_t disabled = NL80211_PS_DISABLED;
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &ifindex);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_PS_STATE, 4, &disabled);
+
+	if (!l_genl_family_send(nl80211, msg, netdev_disable_ps_cb,
+				L_UINT_TO_PTR(ifindex),
+				netdev_disable_ps_destroy)) {
+		l_error("Failed to send SET_POWER_SAVE (-EIO)");
+		return false;
+	}
+
+	return true;
+}
+
 struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
 					const uint8_t *set_mac)
 {
@@ -6223,8 +6282,6 @@ struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
 	uint32_t wiphy_id;
 	struct netdev *netdev;
 	struct wiphy *wiphy = NULL;
-	struct ifinfomsg *rtmmsg;
-	size_t bufsize;
 	struct l_io *pae_io = NULL;
 
 	if (nl80211_parse_attrs(msg, NL80211_ATTR_IFINDEX, &ifindex,
@@ -6283,20 +6340,15 @@ struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
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
+	netdev_setup_interface(netdev);
 
-	l_free(rtmmsg);
+	if (wiphy_disable_power_save(wiphy)) {
+		/* Wait to issue GET_LINK until PS is disabled */
+		if (netdev_disable_power_save(ifindex))
+			return netdev;
+	}
 
-	netdev_setup_interface(netdev);
+	netdev_get_link(ifindex);
 
 	return netdev;
 }
-- 
2.25.1

