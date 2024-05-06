Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C9AB673
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 00:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956664; cv=none; b=OeJ7J62Y6EhPQKfJQhZHj7ybgaOkGvV/PBeEbySvxeYzTeolM/k4a/dD1Nyd7GgD79m6MVoZPHJhl2rkkRq0jYfbejpBNMna68oJMkFZ0Hc2h97vRg5f4VkZ+ktykFNnS4zq8h3t05JbqIkEbCkO8aHb0pA4V9R4AgINkkb1QHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956664; c=relaxed/simple;
	bh=Cebp0fVhXT2hUFnsgvSfuPuKbiUe93Vxldhl7y0ucQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gh6I+4FTh1gkwBahSX5JQKXqp0kihQQNHNa9+YBppqeR0HmxCDxFYUOG/JxvnZD0ZQb2DZsP0SgPCNkFhAtKUZQAUDWvdH39Nga3xh/9jomst9XsRnOYdjL+Q5Lz3wqU9cJq3QBFbFOQa9558tqFci2yPPuyUocR1lINbkec5Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OULRQf0O; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OULRQf0O"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c70e46f3caso988368b6e.2
        for <iwd@lists.linux.dev>; Sun, 05 May 2024 17:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714956661; x=1715561461; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVuH3pK8qDTZgciFOQadd7MMfhSfydB8OIb+gsEQG6o=;
        b=OULRQf0O1WQmRKX0NKiurXr7NZ94Qr/rYzr0Q5NsUoDFTbA012r3K+IOCp2cKnJLMa
         CmAx+zsQ8Qiml2aUvSvcWts7AqSvTC57Nei4jbnxx0xv2BbF5OESH14EoU/mZzDjk74b
         U8MKTZ+YwaJxfYVAx7eJBabnAgY8kT7SzM9U8wB1svQRCqGjhaG3OpsuLQ63GHe/Avyw
         F7Ak2R4ktwsM9zhj3qlIPrzi42TtmLQpyAnb1n/PwKPTCyXhddjXPiJK83aWgxkljief
         Y9F9+mbkmSRybtwdXVpfBdziqpyQAVb2IEh4EiftvcUhd+7AfQuRvsC8ln2fN04JJ8ee
         SbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714956661; x=1715561461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVuH3pK8qDTZgciFOQadd7MMfhSfydB8OIb+gsEQG6o=;
        b=lXGuAVUlPoEKnP25hEmilHctp3wZ72QAW/ITNMHAOZb4TEbnX0TpbhCzvRLL88qidd
         4Qj3ev3rUtNxHDrXyp2Arm50TZnfwuLGKTFF0PkhVvAS577/R42e1sQhMeFIi9h+sWrE
         Hv99sV8EL2Imoy5lkKt9W3N+ozwQcBRiIx4B8eUV7xAa+IV1+tOzE7GnG6NDAG+2zlQe
         kHQC4sKE2ur9Zoxo7BhO6vBRJNyls85GxmLo7YQuwDad6hh2j1ZGkUek6oAGfbWkAHG0
         iXDxkb+zmjQPHzEEhI8AH93+rXRz757/qXWoOVySkdmUs71d8TgAuhKJqOK92aM6/3so
         fi+g==
X-Gm-Message-State: AOJu0YwJeuWCtgiI75cZ23m/s7rPXHBvBrQKuoR9GUdzXUpjFXa/vzHz
	EcO+5lJA2UxInfeM3NEDM+4ef7S/7NQIwTE1hTJSgWZ33mstPfudIuHkrg==
X-Google-Smtp-Source: AGHT+IHUvs9mP9gncL8hTt6J8JMAyFu/reZscrzKG8mc+32KY+AszORKjmiUZ/IjFCWsvDw2kHjkMg==
X-Received: by 2002:a05:6808:4383:b0:3c5:f7fc:bb90 with SMTP id dz3-20020a056808438300b003c5f7fcbb90mr9850076oib.39.1714956661580;
        Sun, 05 May 2024 17:51:01 -0700 (PDT)
Received: from localhost ([192.145.118.41])
        by smtp.gmail.com with ESMTPSA id o16-20020a056a001b5000b006f473177c80sm1492756pfv.181.2024.05.05.17.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 17:51:01 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH v2 17/18] ap: generate IGTK on startup if MFP is enabled
Date: Sun,  5 May 2024 17:30:40 -0700
Message-ID: <20240506003518.320176-18-brandtwjohn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506003518.320176-1-brandtwjohn@gmail.com>
References: <20240506003518.320176-1-brandtwjohn@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using MFP, generate the IGTK group key on startup, and install it
for use. When installing the IGTK, which has either key index 4 or 5,
use the appropriate NL80211 flags so it is installed properly.
---
 src/ap.c          | 61 +++++++++++++++++++++++++++++++++++++++++++----
 src/nl80211util.c |  7 +++++-
 2 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 8cebef42..f598c173 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -90,6 +90,8 @@ struct ap_state {
 	uint32_t mlme_watch;
 	uint8_t gtk[CRYPTO_MAX_GTK_LEN];
 	uint8_t gtk_index;
+	uint8_t igtk[CRYPTO_MAX_GTK_LEN];
+	uint8_t igtk_index;
 	struct l_queue *wsc_pbc_probes;
 	struct l_timeout *wsc_pbc_timeout;
 	uint16_t wsc_dpid;
@@ -116,6 +118,7 @@ struct ap_state {
 
 	bool started : 1;
 	bool gtk_set : 1;
+	bool igtk_set : 1;
 	bool netconfig_set_addr4 : 1;
 	bool in_event : 1;
 	bool free_pending : 1;
@@ -1656,7 +1659,7 @@ static void ap_start_eap_wsc(struct sta_state *sta)
 	ap_start_handshake(sta, wait_for_eapol_start, NULL);
 }
 
-static struct l_genl_msg *ap_build_cmd_del_key(struct ap_state *ap)
+static struct l_genl_msg *ap_build_cmd_del_key(struct ap_state *ap, uint8_t index)
 {
 	uint32_t ifindex = netdev_get_ifindex(ap->netdev);
 	struct l_genl_msg *msg;
@@ -1665,7 +1668,7 @@ static struct l_genl_msg *ap_build_cmd_del_key(struct ap_state *ap)
 
 	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &ifindex);
 	l_genl_msg_enter_nested(msg, NL80211_ATTR_KEY);
-	l_genl_msg_append_attr(msg, NL80211_KEY_IDX, 1, &ap->gtk_index);
+	l_genl_msg_append_attr(msg, NL80211_KEY_IDX, 1, &index);
 	l_genl_msg_leave_nested(msg);
 
 	return msg;
@@ -1709,7 +1712,7 @@ static void ap_gtk_op_cb(struct l_genl_msg *msg, void *user_data)
 			cmd == NL80211_CMD_SET_KEY ? "SET_KEY" :
 			"DEL_KEY";
 
-		l_error("%s failed for the GTK: %i",
+		l_error("%s failed for the (I)GTK: %i",
 			cmd_name, l_genl_msg_get_error(msg));
 	}
 }
@@ -1797,6 +1800,39 @@ static void ap_associate_sta_cb(struct l_genl_msg *msg, void *user_data)
 		ap->gtk_set = true;
 	}
 
+	if (ap->mfpc && !ap->igtk_set) {
+		enum crypto_cipher group_management_cipher =
+			ie_rsn_cipher_suite_to_cipher(ap->group_management_cipher);
+		int igtk_len = crypto_cipher_key_len(group_management_cipher);
+
+		l_getrandom(ap->igtk, igtk_len);
+		ap->igtk_index = 4;
+
+		msg = nl80211_build_new_key_group(
+						netdev_get_ifindex(ap->netdev),
+						group_management_cipher, ap->igtk_index,
+						ap->igtk, igtk_len, NULL,
+						0, NULL);
+
+		if (!l_genl_family_send(ap->nl80211, msg, ap_gtk_op_cb, NULL,
+					NULL)) {
+			l_genl_msg_unref(msg);
+			l_error("Issuing NEW_KEY failed");
+			goto error;
+		}
+
+		msg = nl80211_build_set_key(netdev_get_ifindex(ap->netdev),
+						ap->igtk_index);
+		if (!l_genl_family_send(ap->nl80211, msg, ap_gtk_op_cb, NULL,
+					NULL)) {
+			l_genl_msg_unref(msg);
+			l_error("Issuing SET_KEY failed");
+			goto error;
+		}
+
+		ap->igtk_set = true;
+	}
+
 	if (ap->group_cipher == IE_RSN_CIPHER_SUITE_NO_GROUP_TRAFFIC)
 		ap_start_rsna(sta, NULL);
 	else {
@@ -4137,10 +4173,27 @@ void ap_shutdown(struct ap_state *ap, ap_stopped_func_t stopped_func,
 
 	ap_reset(ap);
 
+	if (ap->igtk_set) {
+		ap->igtk_set = false;
+
+		cmd = ap_build_cmd_del_key(ap, ap->igtk_index);
+		if (!cmd) {
+			l_error("ap_build_cmd_del_key failed");
+			goto free_ap;
+		}
+
+		if (!l_genl_family_send(ap->nl80211, cmd, ap_gtk_op_cb, NULL,
+					NULL)) {
+			l_genl_msg_unref(cmd);
+			l_error("Issuing DEL_KEY failed");
+			goto free_ap;
+		}
+	}
+
 	if (ap->gtk_set) {
 		ap->gtk_set = false;
 
-		cmd = ap_build_cmd_del_key(ap);
+		cmd = ap_build_cmd_del_key(ap, ap->gtk_index);
 		if (!cmd) {
 			l_error("ap_build_cmd_del_key failed");
 			goto free_ap;
diff --git a/src/nl80211util.c b/src/nl80211util.c
index 3f9a43ac..289a73f6 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -486,14 +486,19 @@ struct l_genl_msg *nl80211_build_set_station_unauthorized(uint32_t ifindex,
 struct l_genl_msg *nl80211_build_set_key(uint32_t ifindex, uint8_t key_index)
 {
 	struct l_genl_msg *msg;
+	int key_type;
 
 	msg = l_genl_msg_new_sized(NL80211_CMD_SET_KEY, 128);
 
 	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &ifindex);
 
+	key_type = NL80211_KEY_DEFAULT;
+	if (key_index == 4 || key_index == 5)
+		key_type = NL80211_KEY_DEFAULT_MGMT;
+
 	l_genl_msg_enter_nested(msg, NL80211_ATTR_KEY);
 	l_genl_msg_append_attr(msg, NL80211_KEY_IDX, 1, &key_index);
-	l_genl_msg_append_attr(msg, NL80211_KEY_DEFAULT, 0, NULL);
+	l_genl_msg_append_attr(msg, key_type, 0, NULL);
 	l_genl_msg_enter_nested(msg, NL80211_KEY_DEFAULT_TYPES);
 	l_genl_msg_append_attr(msg, NL80211_KEY_DEFAULT_TYPE_MULTICAST,
 				0, NULL);
-- 
2.45.0

