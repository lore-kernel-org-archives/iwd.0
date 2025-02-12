Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F78F1E766F
	for <iwd@lists.linux.dev>; Wed, 12 Feb 2025 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739377451; cv=none; b=nME0eoodJUJxmWGMzq6wBWjhSvvG6B6Jv/FImuyf8beT57OIvOmjd+vcKDr1uSOtUIVCsTo0T8pKFF7C1ky4FUYbWPLpTT4Q77EYb08NKeBOqP+5BB7dNtsCTZTM7v9an2lKz1sRdFnRhtce2k6FMsaMKZzTEYUf6UygOPMZoA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739377451; c=relaxed/simple;
	bh=+DCMZ2LM0nVjfgckaV+YUbb48NqnCI8TCVbzN+JMA1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kA29lPo/Rle6qwORxoZ+Z5NE4g2T9uDy6fZuT6XrcpT5eMtrAF6ih76gwx5axC7/27Eue+unSKjdV/naxagruOJmpbffqriJBpGS27ccTIpNDylnJYAlH6sBmr7eZ4+9ETGhJpJWM9YI9N1y9d6oI0NvxE49RON3WJuNFvuEGtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYBHBx9I; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYBHBx9I"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c068097157so94267285a.1
        for <iwd@lists.linux.dev>; Wed, 12 Feb 2025 08:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739377449; x=1739982249; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqvdKB6mCNP7VvwkXgDUr9M/uGoOEvyDJ8tVke4NyxU=;
        b=OYBHBx9InJTVW/Z4woVa5ZwOTdga6QP/PeenI6jELQuZl3X4uZvmmXqZHTFRfPmdp3
         SYySav2txyQfR4Lr6Jl1DhsExCg3+nh06TTuRcj3w6dqm/WM89PfOUDsZYyEtwsr5xyz
         39DQTs7fxO2vErlygVqDnvFHeO0B64bCPpL1zu/a6/HC4rDhEoAKtLBpAxVQXuX5wend
         UNKAANfe4vcQs1cCIkMnQgq9FtYFfarJl2RETIq0dRdbiyra4NWrsfkorbIrBseTZzOH
         qNXvFfqR9YFpiV47b7+hZmOsTxkZL4uipTyG252Q5MA9bYEvxsluwwdnEvBnGNRKJFCk
         aeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739377449; x=1739982249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqvdKB6mCNP7VvwkXgDUr9M/uGoOEvyDJ8tVke4NyxU=;
        b=U1E4zxO7PES6CUbkUEDBCeZK+6Zs36DGixT8pa/iSoyAlEXFLRZBpxhVSp/218CSww
         HEvWHOL/F/6QnlBXs478ibpewpm+xa4Xzgss1kBJdhT+Vwz5KeXG7TjBRbdj4ftGgSFw
         EMWBN8EIHPNtHzorN6v774kclvQgUl0wiBT54RjKfN7DpRWqOrXjOR4BiVzhoNSmCMEj
         yiyVjvo6nm0xUIiL7MyO3z3xoJGoKPS4sQbC31u9X+Qmk2A4EdWJiOVVqtDnAQnB7ykE
         j3djgTNqpFJCz6QwpKMWLf0qk1ho+R4KIB7IqoyRHeFVvwyi2JN4TFq+QPtOm01sj2kG
         RWJQ==
X-Gm-Message-State: AOJu0YzoTWm7CcUUupLxV2Wtc5heW9f9GuoJo5P3igLEFRh3BU4tAYZ4
	TsK37t2tyRNI/q8p6Kd1bWC4E2NM6aDsH2njvjGNFeoezbsq9Cv0IGwg7w==
X-Gm-Gg: ASbGncth7FMEZaQnZa8ENyersyQxgz4ne3eu7LcX6Ld8Nckf11IlSV/6KtAvK2MZ9XC
	WXmQEMd0qBjgejiaoDLluzC8sqAS5BkwMnSqFxgSh3Mr29fNO8o2cJDXUf5PhBH1j0X49Dr3LE0
	hUf0HEFOex1Dyush6eOa1ljWKxuy1cdnVLO8vNwso/4vpEjQ6g5pbRs76YwoixDQYBqx/XWCqv2
	QYlTi+VuSAcMCwMPbyHkJlPVEOfqfIEbW2x+R7/2TNJ4mMRD2LJMpxNgKLGsJxgKXmrYiH1vLar
	jsk7DjUNvvP1dReLH5MHBUdeE3h6f5gsDTBrnViEEkdd1bcz8A==
X-Google-Smtp-Source: AGHT+IGuuMtxN7atsEjU9S2sUjlPggLOl8moJ7VtVNs+wJkcaCf6wrJJA+xxEecREwpFLBeJ8un+iw==
X-Received: by 2002:a05:620a:244f:b0:7b6:dd11:5e5f with SMTP id af79cd13be357-7c068fbda12mr1242734985a.13.1739377448773;
        Wed, 12 Feb 2025 08:24:08 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0768e23casm73272685a.44.2025.02.12.08.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 08:24:08 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] netdev: implement PMKSA for fullmac drivers
Date: Wed, 12 Feb 2025 08:24:00 -0800
Message-Id: <20250212162401.130792-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212162401.130792-1-prestwoj@gmail.com>
References: <20250212162401.130792-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supporting PMKSA on fullmac drivers requires that we set the PMKSA
into the kernel as well as remove it. Since station has a removal
path netdev_remove_pmksa needed to be added which station will
call. This will handle both removing IWD's PMKSA cache as well as
in the kernels.

On addition its similar, we add to both IWDs cache and the kernels.
---
 src/netdev.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/netdev.h |  2 ++
 2 files changed, 70 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 06282c2a..42fb6a4b 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1498,6 +1498,52 @@ static void netdev_setting_keys_failed(struct netdev_handshake_state *nhs,
 	handshake_event(&nhs->super, HANDSHAKE_EVENT_SETTING_KEYS_FAILED, &err);
 }
 
+static void netdev_set_pmksa(struct handshake_state *hs)
+{
+	struct l_genl_msg *msg;
+	uint32_t expiration = (uint32_t)hs->expiration;
+
+	if (!hs->have_pmkid)
+		return;
+
+	msg = l_genl_msg_new(NL80211_CMD_SET_PMKSA);
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &hs->ifindex);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_PMKID, 16, hs->pmkid);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, hs->aa);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_SSID, hs->ssid_len, hs->ssid);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_PMK_LIFETIME, 4, &expiration);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_PMK, hs->pmk_len, hs->pmk);
+
+	if (!l_genl_family_send(nl80211, msg, NULL, NULL, NULL))
+		l_error("error sending SET_PMKSA");
+}
+
+void netdev_remove_pmksa(struct netdev *netdev)
+{
+	struct l_genl_msg *msg;
+	struct handshake_state *hs = netdev->handshake;
+	struct netdev_handshake_state *nhs = l_container_of(hs,
+					struct netdev_handshake_state, super);
+
+	handshake_state_remove_pmksa(netdev->handshake);
+
+	if (nhs->type != CONNECTION_TYPE_FULLMAC)
+		return;
+
+	/* Fullmac cards need to set/remove the PMKSA within the kernel */
+
+	msg = l_genl_msg_new(NL80211_CMD_DEL_PMKSA);
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_PMKID, 16, hs->pmkid);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, hs->aa);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_SSID, hs->ssid_len, hs->ssid);
+
+	if (!l_genl_family_send(nl80211, msg, NULL, NULL, NULL))
+		l_error("error sending DEL_PMKSA");
+}
+
 static void try_handshake_complete(struct netdev_handshake_state *nhs)
 {
 	l_debug("ptk_installed: %u, gtk_installed: %u, igtk_installed: %u",
@@ -1518,6 +1564,9 @@ static void try_handshake_complete(struct netdev_handshake_state *nhs)
 
 		l_debug("Invoking handshake_event()");
 
+		if (nhs->type == CONNECTION_TYPE_FULLMAC)
+			netdev_set_pmksa(&nhs->super);
+
 		handshake_state_cache_pmksa(&nhs->super);
 
 		if (handshake_event(&nhs->super, HANDSHAKE_EVENT_COMPLETE))
@@ -6469,6 +6518,23 @@ static void netdev_get_link(struct netdev *netdev)
 	L_WARN_ON(netdev->get_link_cmd_id == 0);
 }
 
+static void netdev_flush_pmksa(struct netdev *netdev)
+{
+	struct l_genl_msg *msg = l_genl_msg_new(NL80211_CMD_FLUSH_PMKSA);
+
+	/*
+	 * We only utilize the kernel's PMKSA cache for fullmac cards, so no
+	 * need to flush if this is a softmac
+	 */
+	if (wiphy_supports_cmds_auth_assoc(netdev->wiphy))
+		return;
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
+
+	if (!l_genl_family_send(nl80211, msg, NULL, NULL, NULL))
+		l_error("Failed to flush PMKSA");
+}
+
 struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
 					const uint8_t *set_mac)
 {
@@ -6544,6 +6610,8 @@ struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
 
 	netdev_get_link(netdev);
 
+	netdev_flush_pmksa(netdev);
+
 	return netdev;
 }
 
diff --git a/src/netdev.h b/src/netdev.h
index 6299934e..0c7d7550 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -218,6 +218,8 @@ int netdev_get_all_stations(struct netdev *netdev, netdev_get_station_cb_t cb,
 
 void netdev_handshake_failed(struct handshake_state *hs, uint16_t reason_code);
 
+void netdev_remove_pmksa(struct netdev *netdev);
+
 struct netdev *netdev_find(int ifindex);
 
 uint32_t netdev_watch_add(netdev_watch_func_t func,
-- 
2.34.1

