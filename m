Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E150741744
	for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KZYyIl7U"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1f060e059a3so3705656fac.1
        for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 09:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699982149; x=1700586949; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpZSHOxuc6hY09H9BC1e0xyMpal+TYiPGj637gUyjGo=;
        b=KZYyIl7UPwUAEi3BlwsqF6lR92olYRhkGB10NzxF2quUNLXE0/wqjLO5PSEVakRmOx
         ioFDrExq2zEEiO7gDWJxTPQMA103v2pACbN4i/yssQmer4jNb6l+SvxCIFCPXOe5+kGk
         cfo1nPECUJJ6sWk9ZO+iAdk9RkF0OG/QiW2hyOlocf1/907Az7Xxbk4UYBGkgTJCZ0GN
         qbvSF1Ih+6QS6ua7p92l9h9z5UbPqCzWtLplBovWs5sb2ouIce1dCBSS82LYo4xd8ksc
         MJDE0Xgsgdz4Y7ZvvH98Ru1+LV1dF8CiBUYw/srWFltR8FDKhYRTEVn3MSIMNr128TS9
         hOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699982149; x=1700586949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpZSHOxuc6hY09H9BC1e0xyMpal+TYiPGj637gUyjGo=;
        b=J7XuF6n2qlT7Jj+ef7oHutJ/CACal17AqGWSFQ6ROz3kDqPcToDAAtPmz/rf6Kxmpw
         WIN/2QxyHGtyher8ouztgm4c/1iAlKK5FGjj3n3Mtp3oXstBqq6eMJ+hBt2gefh+9a3V
         a8kheYJidFRbVa37NWpHD4eGSN9EGtE0kq7adNcB55kLiavCrNglyemtOvDoy7raT0Cd
         IYQRZVXkaWDgmCM+dEzREq5hXnbx02fVU1fTY6po8DE0WuuY+ABgC+ualtCqSsDdQCsN
         KxpQz+NPnqSrGZnKZGiLZoB1qdbs9C5C83F0MqSD3x20VBA2JouzbDR342eELWO/ajY9
         WkoA==
X-Gm-Message-State: AOJu0Yxd0XzeiG5w77rGh+3xV/aoyqdG/9VXyLmisZD0eLrIFo06V8aV
	cYpaJx5RcFaXe2H2TyrY0Uk8iwxiujE=
X-Google-Smtp-Source: AGHT+IFuJHLGgmiq5iVMCrwBu2INPV/5G9p4pZfeW8/H9H9+2PVx+9fcN7fz+8EhgLMceoZq+2SkbQ==
X-Received: by 2002:a05:6871:b1e:b0:1f4:b55c:46b4 with SMTP id fq30-20020a0568710b1e00b001f4b55c46b4mr13421511oab.43.1699982149364;
        Tue, 14 Nov 2023 09:15:49 -0800 (PST)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id o4-20020a05687072c400b001e9a253afa3sm1429647oak.49.2023.11.14.09.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 09:15:48 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 05/11] netdev: Move CMD_DISCONNECT builder to nl80211util
Date: Tue, 14 Nov 2023 11:14:28 -0600
Message-ID: <20231114171455.1108856-5-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114171455.1108856-1-denkenz@gmail.com>
References: <20231114171455.1108856-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/netdev.c      | 22 +++++-----------------
 src/nl80211util.c | 12 ++++++++++++
 src/nl80211util.h |  3 +++
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 6792bb5601e2..1f6920028a03 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1245,18 +1245,6 @@ static void netdev_cmd_disconnect_cb(struct l_genl_msg *msg, void *user_data)
 	disconnect_cb(netdev, r, disconnect_data);
 }
 
-static struct l_genl_msg *netdev_build_cmd_disconnect(struct netdev *netdev,
-							uint16_t reason_code)
-{
-	struct l_genl_msg *msg;
-
-	msg = l_genl_msg_new_sized(NL80211_CMD_DISCONNECT, 64);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_REASON_CODE, 2, &reason_code);
-
-	return msg;
-}
-
 static void netdev_deauthenticate_event(struct l_genl_msg *msg,
 							struct netdev *netdev)
 {
@@ -1460,7 +1448,7 @@ static void netdev_setting_keys_failed(struct netdev_handshake_state *nhs,
 			return;
 		}
 
-		msg = netdev_build_cmd_disconnect(netdev,
+		msg = nl80211_build_disconnect(netdev->index,
 						MMPDU_REASON_CODE_UNSPECIFIED);
 		netdev->disconnect_cmd_id = l_genl_family_send(nl80211, msg,
 							netdev_disconnect_cb,
@@ -2246,7 +2234,7 @@ void netdev_handshake_failed(struct handshake_state *hs, uint16_t reason_code)
 	switch (netdev->type) {
 	case NL80211_IFTYPE_STATION:
 	case NL80211_IFTYPE_P2P_CLIENT:
-		msg = netdev_build_cmd_disconnect(netdev, reason_code);
+		msg = nl80211_build_disconnect(netdev->index, reason_code);
 		netdev->disconnect_cmd_id = l_genl_family_send(nl80211, msg,
 							netdev_disconnect_cb,
 							netdev, NULL);
@@ -2989,7 +2977,7 @@ error:
 deauth:
 	netdev->result = NETDEV_RESULT_ASSOCIATION_FAILED;
 	netdev->last_code = MMPDU_STATUS_CODE_UNSPECIFIED;
-	msg = netdev_build_cmd_disconnect(netdev,
+	msg = nl80211_build_disconnect(netdev->index,
 						MMPDU_REASON_CODE_UNSPECIFIED);
 	netdev->disconnect_cmd_id = l_genl_family_send(nl80211,
 							msg,
@@ -4159,7 +4147,7 @@ int netdev_disconnect(struct netdev *netdev,
 	}
 
 	if (send_disconnect) {
-		disconnect = netdev_build_cmd_disconnect(netdev,
+		disconnect = nl80211_build_disconnect(netdev->index,
 					MMPDU_REASON_CODE_DEAUTH_LEAVING);
 		netdev->disconnect_cmd_id = l_genl_family_send(nl80211,
 					disconnect, netdev_cmd_disconnect_cb,
@@ -4695,7 +4683,7 @@ static void netdev_sa_query_timeout(struct l_timeout *timeout,
 	l_timeout_remove(netdev->sa_query_timeout);
 	netdev->sa_query_timeout = NULL;
 
-	msg = netdev_build_cmd_disconnect(netdev,
+	msg = nl80211_build_disconnect(netdev->index,
 			MMPDU_REASON_CODE_PREV_AUTH_NOT_VALID);
 	netdev->disconnect_cmd_id = l_genl_family_send(nl80211, msg,
 			netdev_disconnect_cb, netdev, NULL);
diff --git a/src/nl80211util.c b/src/nl80211util.c
index 8cc3ea39c4d3..44a8ebe50300 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -284,6 +284,18 @@ done:
 	return ret;
 }
 
+struct l_genl_msg *nl80211_build_disconnect(uint32_t ifindex,
+							uint16_t reason_code)
+{
+	struct l_genl_msg *msg;
+
+	msg = l_genl_msg_new_sized(NL80211_CMD_DISCONNECT, 64);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &ifindex);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_REASON_CODE, 2, &reason_code);
+
+	return msg;
+}
+
 struct l_genl_msg *nl80211_build_new_key_group(uint32_t ifindex, uint32_t cipher,
 					uint8_t key_id, const uint8_t *key,
 					size_t key_len, const uint8_t *ctr,
diff --git a/src/nl80211util.h b/src/nl80211util.h
index d26d286f95a7..9eb8681900b8 100644
--- a/src/nl80211util.h
+++ b/src/nl80211util.h
@@ -28,6 +28,9 @@ struct band_freq_attrs;
 
 int nl80211_parse_attrs(struct l_genl_msg *msg, int tag, ...);
 
+struct l_genl_msg *nl80211_build_disconnect(uint32_t ifindex,
+							uint16_t reason_code);
+
 struct l_genl_msg *nl80211_build_new_key_group(uint32_t ifindex,
 					uint32_t cipher, uint8_t key_id,
 					const uint8_t *key, size_t key_len,
-- 
2.42.0

