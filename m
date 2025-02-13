Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B38524BC19
	for <iwd@lists.linux.dev>; Thu, 13 Feb 2025 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739477912; cv=none; b=H/dsONw3nAeh0nxvVGFgg53Y+o83Vh/fv281FALa9berX+LHWBipYGoa9+enszFp4x4MAOkc62a/ENM/SRVNsjsFA7NQn6ay0gbS6B+NsvjsMau0UO9ts36UfW9YUO7FYTl6RmeJ8ER9d/1+xRqVAV19YQ2Lg0nctf3kCyt4+Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739477912; c=relaxed/simple;
	bh=MHyVcLru0wLATx4It81dJRw7HFMwwtDYzPQm0dgZmCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hHF0TUt9GRyJICkCdBTzx5NqXY8e4nNGe4Cu2ekXUTXFwdZ6PAznk1a0oJYizygs/M3slp9v4FbAn0QLc2SwufxLzFdYvYVhxm675kAF5M2tYa6gbWLSNu6ztHOYEwi8exTEsBJJOS5ltdQkAUBdqrKzd90uzlZJ5sPyHs13bIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=de+CAzRy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="de+CAzRy"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220c92c857aso20932335ad.0
        for <iwd@lists.linux.dev>; Thu, 13 Feb 2025 12:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739477910; x=1740082710; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+Q4DIOzacwA9E+GJsKZb37Ers+T1zM2CVh0x1uKiz8=;
        b=de+CAzRy3+nr2YKLkwqn90+yPc0tv7YDjc1zquFYbZnyW8W1+veY9LfrwW8ljbSyXe
         E/qZBdm3XKjD/kpvkyI4fNRtBtiZAi06OvRAur2zbfDNErEZIcuy/cADiIzA/wuoxT85
         FiOzOEsxd2a5TemPHi7MsB9ukIprvNFhWXcH+9D3cPpjx+k8LK0aiLdjnNtkVqWi1fDd
         whnhyIX7/rJgsXlDX5C/uF0Q1iX1L2CiYFFY0w6MtwQPvOFrfLAFdoXWmcPgTwYmNb8A
         HNHbmNS8sSdFLa+abASKCfhSTaZ9G6B7BrmtaSZoQZ92NtakuGuVFAJ5gxOkAJmg05xi
         CZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739477910; x=1740082710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+Q4DIOzacwA9E+GJsKZb37Ers+T1zM2CVh0x1uKiz8=;
        b=nzXCbZwMz/fEo+Ze111vk1WoagnxvLfkBkn1W30GMq85u0jf5pvqBaYVl+dLMcohWv
         WfxlVwdvub05TiYWsvDZJFH6wBVmdQHqzyxffMrwrK5FRVrkr91pnTV9mb4+9Y9VOVUS
         LWS9NfnhW7M7lVCMauIDVNnqRWMOVuEst1hpJkONeqJ23FXeB+TspAJpDF4byylDGswk
         6fAGXjTUSWZXwPjpu7cYdO9y2dUux25Szj9o6iGfRItJNN7hjJdyGz9mduv6rw1lssZn
         ZxRSuGCJgqDFL+A19dCOfH/E9RUujDfeNMRhbZf7Zmyyf+cqFZi1kzRGxNs/jc8DR6Mf
         K+1g==
X-Gm-Message-State: AOJu0YxL2xVd8Ri99eMAlJ9kCjGJcbrYYY3EOgr0fC3Z3JewgWO1fZTy
	YlMxqRFmX/PStk5I/j6gAPI1zo0HbAme+/P8cKWWdAnda3Hs8PJmuHepuQ==
X-Gm-Gg: ASbGncs9gxxYr9Hrys+sjYMrDsCCQoUBx1vIV/9deWTeQ4QbYvjVqr9iPspKlgOeijF
	7GLYmSgrfDVDiKlMsQEsk5WrxTnb5fCk0IPTPdORAJlGbxHbf71EQalb3KXI3MIS2VUtWOmYV23
	acrN6VJvwkjSC9pp46fpVpMmdmm0tp6b77Z/WFLdEa+Rvr7w2C/Uhw8oVyHRGYusLOo8E7WKG0h
	sliNPNnDkncXHU4+FBYeGKWFjBq4RiQy6sbFVMQa3RwrblawdsUBcGrT/mSDn4fTKtRMtzIy2m9
	d5/TAKIgpAr/VRsPzm3UV21Wtg==
X-Google-Smtp-Source: AGHT+IEfJkXxbK291wr0YRx3bjE+stdY6QNop+DUT4j2g0EDNVjbeE4OmRjbrSPvzH4+IWIDc8ey+Q==
X-Received: by 2002:a17:903:2f81:b0:215:3998:189f with SMTP id d9443c01a7336-220d36d2d10mr62519475ad.6.1739477910053;
        Thu, 13 Feb 2025 12:18:30 -0800 (PST)
Received: from localhost.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c814sm16419455ad.148.2025.02.13.12.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 12:18:29 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 5/5] netdev: implement PMKSA for fullmac drivers
Date: Thu, 13 Feb 2025 12:18:16 -0800
Message-Id: <20250213201816.230112-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250213201816.230112-1-prestwoj@gmail.com>
References: <20250213201816.230112-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supporting PMKSA on fullmac drivers requires that we set the PMKSA
into the kernel as well as remove it. This can now be triggered
via the new PMKSA driver callbacks which are implemented and set
with this patch.
---
 src/netdev.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 06282c2a..ddd05621 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1498,6 +1498,105 @@ static void netdev_setting_keys_failed(struct netdev_handshake_state *nhs,
 	handshake_event(&nhs->super, HANDSHAKE_EVENT_SETTING_KEYS_FAILED, &err);
 }
 
+static bool netdev_match_addr(const void *a, const void *b)
+{
+	const struct netdev *netdev = a;
+	const uint8_t *addr = b;
+
+	return memcmp(netdev->addr, addr, ETH_ALEN) == 0;
+}
+
+static struct netdev *netdev_find_by_address(const uint8_t *addr)
+{
+	return l_queue_find(netdev_list, netdev_match_addr, addr);
+}
+
+static void netdev_pmksa_driver_add(const struct pmksa *pmksa)
+{
+	struct l_genl_msg *msg;
+	struct netdev *netdev = netdev_find_by_address(pmksa->spa);
+	uint32_t expiration = (uint32_t)pmksa->expiration;
+
+	if (!netdev)
+		return;
+
+	/* Only need to set the PMKSA into the kernel for fullmac drivers */
+	if (wiphy_supports_cmds_auth_assoc(netdev->wiphy))
+		return;
+
+	l_debug("Adding PMKSA to kernel");
+
+	msg = l_genl_msg_new(NL80211_CMD_SET_PMKSA);
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_PMKID, 16, pmksa->pmkid);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, pmksa->aa);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_SSID,
+				pmksa->ssid_len, pmksa->ssid);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_PMK_LIFETIME, 4, &expiration);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_PMK,
+				pmksa->pmk_len, pmksa->pmk);
+
+	if (!l_genl_family_send(nl80211, msg, NULL, NULL, NULL))
+		l_error("error sending SET_PMKSA");
+}
+
+static void netdev_pmksa_driver_remove(const struct pmksa *pmksa)
+{
+	struct l_genl_msg *msg;
+	struct netdev *netdev = netdev_find_by_address(pmksa->spa);
+
+	if (!netdev)
+		return;
+
+	/* Only need to set the PMKSA into the kernel for fullmac drivers */
+	if (wiphy_supports_cmds_auth_assoc(netdev->wiphy))
+		return;
+
+	l_debug("Removing PMKSA from kernel");
+
+	msg = l_genl_msg_new(NL80211_CMD_DEL_PMKSA);
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_PMKID, 16, pmksa->pmkid);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, pmksa->aa);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_SSID,
+				pmksa->ssid_len, pmksa->ssid);
+
+	if (!l_genl_family_send(nl80211, msg, NULL, NULL, NULL))
+		l_error("error sending DEL_PMKSA");
+}
+
+static void netdev_flush_pmksa(struct netdev *netdev)
+{
+	struct l_genl_msg *msg;
+
+	/*
+	* We only utilize the kernel's PMKSA cache for fullmac cards,
+	* so no need to flush if this is a softmac.
+	*/
+	if (wiphy_supports_cmds_auth_assoc(netdev->wiphy))
+		return;
+
+	msg = l_genl_msg_new(NL80211_CMD_FLUSH_PMKSA);
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
+
+	if (!l_genl_family_send(nl80211, msg, NULL, NULL, NULL))
+		l_error("Failed to flush PMKSA for %u", netdev->index);
+}
+
+static void netdev_pmksa_driver_flush(void)
+{
+	const struct l_queue_entry *e;
+
+	for (e = l_queue_get_entries(netdev_list); e; e = e->next) {
+		struct netdev *netdev = e->data;
+
+		netdev_flush_pmksa(netdev);
+	}
+}
+
 static void try_handshake_complete(struct netdev_handshake_state *nhs)
 {
 	l_debug("ptk_installed: %u, gtk_installed: %u, igtk_installed: %u",
@@ -6544,6 +6643,16 @@ struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
 
 	netdev_get_link(netdev);
 
+	/*
+	 * Call the netdev-specific variant to flush only this devices PMKSA
+	 * cache in the kernel. This will make IWD's cache and the kernel's
+	 * cache consistent, i.e. no entries
+	 *
+	 * TODO: If we ever are storing PMKSA's on disk we would first need to
+	 *       flush, then add all the PMKSA entries at this time.
+	 */
+	netdev_flush_pmksa(netdev);
+
 	return netdev;
 }
 
@@ -6659,6 +6768,10 @@ static int netdev_init(void)
 
 	__ft_set_tx_frame_func(netdev_tx_ft_frame);
 
+	__pmksa_set_driver_callbacks(netdev_pmksa_driver_add,
+					netdev_pmksa_driver_remove,
+					netdev_pmksa_driver_flush);
+
 	unicast_watch = l_genl_add_unicast_watch(genl, NL80211_GENL_NAME,
 						netdev_unicast_notify,
 						NULL, NULL);
-- 
2.34.1

