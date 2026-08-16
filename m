Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EF378F4A
	for <iwd@lists.linux.dev>; Sun, 16 Aug 2026 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786891540; cv=none; b=EVPWusXeySvoL3qvsdtxxsRgC6u4msKqtRaKNGDpswKA+fbs+anRalgAmpLXVm/oXGZOlfr4B0chmNO8eRG9z06gtubDGO6FsHLPf4B2gIjpd7N+b81Uf3o6G0KRnYCafQqtaUQ5PSiG5tJyXf3qHBvO3iDwmUgsoNiKAgCFL6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786891540; c=relaxed/simple;
	bh=DvuDKF7mFd1OYloMDFgLa4gHhyTqxUPD0nnaFAutsEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ruMh358vA/DrLT5hiKN94sU+EfEQ8El4536VTEmc2yeO+x76IfFa+6I9b4nKVKO7gVsdoGZTxc+aTKQ4iBYMkwmd05lAkZ6S9eIMPDeHqrUWzFVs+mKyrxVevfskpcfAD4pakjtlaxz2GEarquuPp9guS13MapI+Q7Ju9NigbII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvnRXT0M; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvnRXT0M"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1945543a91.3
        for <iwd@lists.linux.dev>; Sun, 16 Aug 2026 07:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786891538; x=1787496338; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3+JRTnCxsfH1XNNRpepF+cvrOcm9I4TyrVPOAF1gEYM=;
        b=AvnRXT0MAcMGu3a+qYim91sc6MFTSGmYYGA9mQ6f0pN1vTpm9v6Y1o3iuSxr1r5k4V
         WDXhUE6erOGKDrk09Q33DRcYLdtTmeoHPr/K8lgHISgiKRW2j5nNMI1gbBxl7ghVT7VW
         YxpMhq8paKN0UHyBupXVETHGGdDGHlSxvBNg7WoeHvTqOmQeVtgD05JzJD8QrCcaJykP
         BD/6EHTQxWSm/L4fmyYW7rz1/mGCmzBovxx0w62LThIkg2eS5ICnLy8AP7ENX8U9K9RS
         aIhGXe9zqbUrF5OfqQXLBVQjVDBQILkqJHEJX2ULdZubFlfSfWpZyn/VqXng15S+1raw
         /z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786891538; x=1787496338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3+JRTnCxsfH1XNNRpepF+cvrOcm9I4TyrVPOAF1gEYM=;
        b=PA+qbsSJkrp1LMJJvqI0JNNyh2AJPaLockK059CARo1006ryw6Cu9rWaXe/EmEDOKb
         nZHMC7VLMHlfCmm39vFf4ySQIotsd2e0lKXLR1OJp3Sap3XHObcM7i/DtYzdwR2tWK3a
         w9XkkfysODz7P+8uDiVaGXEZcRbKtYxOTJFs7K2Jar5gqP9TwoGnZ9EhQT+wLOomCqQU
         dXZUwSKtmF+V4LJKbGQEvnFgbdJPYUP4ZG1+JUKr2GJZmSPpOTFRoVbaRATH6d0M+aBz
         KEkIuqPRvuTx9B0U6fdOSzZcaU3T1+Cw8zIWJ7jVVqina1kPx9AO+9a0J1P8vy9nxy2z
         yuFA==
X-Gm-Message-State: AOJu0YxgkD3A7WAMzvIq3ll+vUTL00Vq8wapGSc8nRghZXL+020wStag
	CQiLZOy2EpOYarAZWi3eevoH8cDRMPQ+dAIia0vsoJ83p1Yx19ihcLtguliCYg==
X-Gm-Gg: AR+sD130HMrgx0NirJ6EFJGRKUMyZxyrlhO3+BPjYr9m7ceN3HOwSwiePTorTlNyfnz
	KrXZq1C5AQnDEcX/OHTnKi0knJ7JhwrbAn3odxxbIkqADfi4kRpmtK4Tz9V/w6VKZzoRWAPcWSJ
	HwW4ZxXLq0V89lSHOrWLwUPmtiingHmQrUDzHP1X3S/9bd7wWQ65JYP2ZIiowPa2awEouiAC0ZQ
	NSw3BrI86h/SfHYzYpQcLU7evp1fA8HkL4OCvefDWyPUos9+0YSPTq6lSjz6Q4WOprTiMCq6gDy
	JjzrC75JLd+CxOyFBbHgtxPrqHEKP/zBHhW7h4dRUP787MYoAShThZGFA4i8lIrpLFu7g/wKKyf
	eNL2KJFM/PKy8W4frPv2mj1PlxjdP85lcfYD3SVQsmdCOENRn4hxNYc7t1YXdTd2OS+pHwGNIoc
	3zp0cUW0AbQEiDW38FzYAisBKQKjEWs1pJAGIwp9WDxtFPuz7H6eY=
X-Received: by 2002:a17:90b:3d48:b0:381:528a:808c with SMTP id 98e67ed59e1d1-3933b8939dfmr20671051a91.12.1786891537823;
        Sun, 16 Aug 2026 07:45:37 -0700 (PDT)
Received: from toolbx ([2401:dc20:2817:0:bd7a:2eef:1251:5659])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d66e52d2sm27523029eec.13.2026.08.16.07.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 07:45:37 -0700 (PDT)
From: Christopher Fraser <cfraz89@gmail.com>
To: iwd@lists.linux.dev
Cc: Christopher Fraser <cfraz89@gmail.com>
Subject: [PATCH] network: add DisableHT/VHT/HE/EHT settings
Date: Mon, 17 Aug 2026 00:45:24 +1000
Message-ID: <20260816144524.1594795-1-cfraz89@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add per-network [Settings] options (DisableHT, DisableVHT, DisableHE,
DisableEHT) that let a network's config force a specific PHY
generation off when associating with that network, by setting the
matching NL80211_ATTR_DISABLE_* flag on the connect/associate
netlink command, similar to flags that exist in wpa_supplicant.

This is useful for APs where negotiating a particular mode causes
instability.
---
 src/handshake.h     |  4 ++++
 src/iwd.network.rst | 16 ++++++++++++++++
 src/knownnetworks.c | 20 ++++++++++++++++++++
 src/knownnetworks.h |  8 ++++++++
 src/netdev.c        | 24 ++++++++++++++++++++++++
 src/network.c       |  4 ++++
 6 files changed, 76 insertions(+)

diff --git a/src/handshake.h b/src/handshake.h
index 9ddeecd6..de86ee86 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -145,6 +145,10 @@ struct handshake_state {
 	bool supplicant_ocvc : 1;
 	bool ext_key_id_capable : 1;
 	bool force_default_ecc_group : 1;
+	bool disable_ht : 1;
+	bool disable_vht : 1;
+	bool disable_he : 1;
+	bool disable_eht : 1;
 	bool have_pmksa : 1;
 	union {
 		struct pmksa *pmksa;
diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index 892c6eb8..a031d50b 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -181,6 +181,22 @@ The group ``[Settings]`` contains general settings.
        (WPA3 and OWE) if set true. If unset IWD will learn the capabilities of
        the network based on its initial association and retain that setting for
        the duration of its process lifetime.
+   * - DisableHT
+     - Values: true, **false**
+
+       If enabled, forces HT (802.11n) off when associating with this network.
+   * - DisableVHT
+     - Values: true, **false**
+
+       If enabled, forces VHT (802.11ac) off when associating with this network.
+   * - DisableHE
+     - Values: true, **false**
+
+       If enabled, forces HE (802.11ax) off when associating with this network.
+   * - DisableEHT
+     - Values: true, **false**
+
+       If enabled, forces EHT (802.11be) off when associating with this network.
 
 Network Authentication Settings
 -------------------------------
diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index 886f8145..edec565c 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -135,6 +135,26 @@ void __network_config_parse(const struct l_settings *settings,
 					NET_USE_DEFAULT_ECC_GROUP);
 	} else
 		config->ecc_group = KNOWN_NETWORK_ECC_GROUP_AUTO;
+
+	if (!l_settings_get_bool(settings, NET_DISABLE_HT, &b))
+		b = false;
+
+	config->disable_ht = b;
+
+	if (!l_settings_get_bool(settings, NET_DISABLE_VHT, &b))
+		b = false;
+
+	config->disable_vht = b;
+
+	if (!l_settings_get_bool(settings, NET_DISABLE_HE, &b))
+		b = false;
+
+	config->disable_he = b;
+
+	if (!l_settings_get_bool(settings, NET_DISABLE_EHT, &b))
+		b = false;
+
+	config->disable_eht = b;
 }
 
 void __network_info_init(struct network_info *info,
diff --git a/src/knownnetworks.h b/src/knownnetworks.h
index a117ded5..4fcba97e 100644
--- a/src/knownnetworks.h
+++ b/src/knownnetworks.h
@@ -30,6 +30,10 @@
 #define NET_TRANSITION_DISABLE SETTINGS, "TransitionDisable"
 #define NET_TRANSITION_DISABLE_MODES SETTINGS, "DisabledTransitionModes"
 #define NET_USE_DEFAULT_ECC_GROUP SETTINGS, "UseDefaultEccGroup"
+#define NET_DISABLE_HT SETTINGS, "DisableHT"
+#define NET_DISABLE_VHT SETTINGS, "DisableVHT"
+#define NET_DISABLE_HE SETTINGS, "DisableHE"
+#define NET_DISABLE_EHT SETTINGS, "DisableEHT"
 
 enum security;
 struct scan_freq_set;
@@ -82,6 +86,10 @@ struct network_config {
 	bool have_transition_disable : 1;
 	uint8_t transition_disable;
 	enum known_network_ecc_group ecc_group;
+	bool disable_ht:1;
+	bool disable_vht:1;
+	bool disable_he:1;
+	bool disable_eht:1;
 };
 
 struct network_info {
diff --git a/src/netdev.c b/src/netdev.c
index e639a1f8..ff6e896f 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2647,6 +2647,18 @@ static struct l_genl_msg *netdev_build_cmd_connect(struct netdev *netdev,
 
 	l_genl_msg_append_attr(msg, NL80211_ATTR_SOCKET_OWNER, 0, NULL);
 
+	if (hs->disable_ht)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_DISABLE_HT, 0, NULL);
+
+	if (hs->disable_vht)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_DISABLE_VHT, 0, NULL);
+
+	if (hs->disable_he)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_DISABLE_HE, 0, NULL);
+
+	if (hs->disable_eht)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_DISABLE_EHT, 0, NULL);
+
 	if (is_rsn) {
 		nl80211_append_rsn_attributes(msg, hs);
 		c_iov = iov_ie_append(iov, n_iov, c_iov, hs->supplicant_ie,
@@ -2989,6 +3001,18 @@ static struct l_genl_msg *netdev_build_cmd_associate_common(
 	l_genl_msg_append_attr(msg, NL80211_ATTR_SSID, hs->ssid_len, hs->ssid);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_SOCKET_OWNER, 0, NULL);
 
+	if (hs->disable_ht)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_DISABLE_HT, 0, NULL);
+
+	if (hs->disable_vht)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_DISABLE_VHT, 0, NULL);
+
+	if (hs->disable_he)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_DISABLE_HE, 0, NULL);
+
+	if (hs->disable_eht)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_DISABLE_EHT, 0, NULL);
+
 	if (is_rsn)
 		nl80211_append_rsn_attributes(msg, hs);
 
diff --git a/src/network.c b/src/network.c
index a5a2375a..b2735fb6 100644
--- a/src/network.c
+++ b/src/network.c
@@ -536,6 +536,10 @@ int network_handshake_setup(struct network *network, struct scan_bss *bss,
 	}
 
 	hs->force_default_ecc_group = network->force_default_ecc_group;
+	hs->disable_ht = info && info->config.disable_ht;
+	hs->disable_vht = info && info->config.disable_vht;
+	hs->disable_he = info && info->config.disable_he;
+	hs->disable_eht = info && info->config.disable_eht;
 
 	/*
 	 * The randomization options in the provisioning file are dependent on
-- 
2.55.0

