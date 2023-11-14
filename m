Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BA541754
	for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhVurZ4J"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1ef370c2e12so3495592fac.1
        for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 09:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699982154; x=1700586954; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIXEicCogvcXHU6ju71ZFzMYtzrH/C5SFk01ftzMR7M=;
        b=VhVurZ4J+ki1vAM66s44yG5sHFLtN9HL91b4SYsv7UG3ZJA8M6Lp2rAw6JDZbS+LZU
         CXKSE3rBdJBwfSPZiDeiVYtB7IxhBljfVh78vEGr4PCaLpsUHH94dYXyNNGf3J1XAOBA
         4OBWzgvbADBn6WKnoxKiL2mHrxbwiimCD7XViDJjPttYEsQCUztkIpa5QhVuEt+9eclh
         3fMrqrvtzlwo4eBqfWyabuhareZhEQoOcuS3A5mmZ9hwQ5CjAxj9KLCNBMVfUBmYoN1x
         CQLggTSREIWhubTF+07qcB/0fiBYf4Vxk08zo4hfdCTh8KGObwygdeMlh+qlGFALt2bj
         3fWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699982154; x=1700586954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIXEicCogvcXHU6ju71ZFzMYtzrH/C5SFk01ftzMR7M=;
        b=EIihdoopWekvtNZONbQ+f5K32MVqsQvpHBDD7xN94sYndR6+892pgAbwLMrn/yGTOZ
         JJ1jNhVRYJ9oUg+9lhKrIzKtlpoFYrAELU7cK0nfHw6gGGY/bURGTIzy1OPfI8mmXfzK
         KLRZ3x4L1Si9+ZsOU+NiJ2Fbvhq8XaBkjLQubWheE7uwCJT+yvaf8Opffz/LCny0MEVE
         UOTiWoT8m4nGPgH+DKbcc+co9lDpolyKfjmNq+BI5OeB8gTLeXHEbORI+eoqiPdmQFhV
         yV9ArLOnn2bkbMsv0RiQSbkeImlj5hqrrDN4EIQNggG9oDQm71r/QtaOHUCDxiZUFgsU
         GGuw==
X-Gm-Message-State: AOJu0YwWKvr2+uSCPajaU4K2HkbjpEMY8iWCKyfDc1q248RtLeJMAHRp
	BB2HYYL9/Z/Ig2mSAGbiP+LVuYjMP1E=
X-Google-Smtp-Source: AGHT+IE2Zidmg0Zwtpjuv+RIn3Kqg01vW9xUR+30z3hGH3Bqnm9OlNJ4UJ3diBa9+uReCxgJnoQEpg==
X-Received: by 2002:a05:6870:c90d:b0:1f0:8706:4c4a with SMTP id hj13-20020a056870c90d00b001f087064c4amr13225012oab.29.1699982152073;
        Tue, 14 Nov 2023 09:15:52 -0800 (PST)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id o4-20020a05687072c400b001e9a253afa3sm1429647oak.49.2023.11.14.09.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 09:15:51 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 07/11] netdev: Move CMD_DEL_STATION builder to nl80211util
Date: Tue, 14 Nov 2023 11:14:30 -0600
Message-ID: <20231114171455.1108856-7-denkenz@gmail.com>
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

While here, also get rid of netdev_del_station.  The only user of this
function was in ap.c and it could easily be replaced by invoking the new
nl80211_build_del_station function.  The callback used by
netdev_build_del_station only printed an error and didn't do anything
useful.  Get rid of it for now.
---
 src/ap.c          |  9 +++++++-
 src/netdev.c      | 56 +++++------------------------------------------
 src/nl80211util.c | 16 ++++++++++++++
 src/nl80211util.h |  5 +++++
 4 files changed, 35 insertions(+), 51 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 577f25a71def..bce389d39c9c 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -392,10 +392,17 @@ static void ap_del_station(struct sta_state *sta, uint16_t reason,
 				bool disassociate)
 {
 	struct ap_state *ap = sta->ap;
+	uint32_t ifindex = netdev_get_ifindex(ap->netdev);
 	struct ap_event_station_removed_data event_data;
 	bool send_event = false;
+	struct l_genl_msg *msg;
+	uint8_t subtype = disassociate ?
+			MPDU_MANAGEMENT_SUBTYPE_DISASSOCIATION :
+			MPDU_MANAGEMENT_SUBTYPE_DEAUTHENTICATION;
+
+	msg = nl80211_build_del_station(ifindex, sta->addr, reason, subtype);
+	l_genl_family_send(ap->nl80211, msg, NULL, NULL, NULL);
 
-	netdev_del_station(ap->netdev, sta->addr, reason, disassociate);
 	sta->associated = false;
 
 	if (sta->rsna) {
diff --git a/src/netdev.c b/src/netdev.c
index 6c35cd1b75e7..38fb759058c3 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1298,52 +1298,6 @@ static void netdev_deauthenticate_event(struct l_genl_msg *msg,
 					MMPDU_STATUS_CODE_UNSPECIFIED);
 }
 
-static struct l_genl_msg *netdev_build_cmd_del_station(struct netdev *netdev,
-							const uint8_t *sta,
-							uint16_t reason_code,
-							bool disassociate)
-{
-	struct l_genl_msg *msg;
-	uint8_t subtype = disassociate ?
-			MPDU_MANAGEMENT_SUBTYPE_DISASSOCIATION :
-			MPDU_MANAGEMENT_SUBTYPE_DEAUTHENTICATION;
-
-	msg = l_genl_msg_new_sized(NL80211_CMD_DEL_STATION, 64);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, 6, sta);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_MGMT_SUBTYPE, 1, &subtype);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_REASON_CODE, 2, &reason_code);
-
-	return msg;
-}
-
-static void netdev_del_sta_cb(struct l_genl_msg *msg, void *user_data)
-{
-	int err = l_genl_msg_get_error(msg);
-	const char *ext_error;
-
-	if (err >= 0)
-		return;
-
-	ext_error = l_genl_msg_get_extended_error(msg);
-	l_error("DEL_STATION failed: %s",
-			ext_error ? ext_error : strerror(-err));
-}
-
-int netdev_del_station(struct netdev *netdev, const uint8_t *sta,
-			uint16_t reason_code, bool disassociate)
-{
-	struct l_genl_msg *msg;
-
-	msg = netdev_build_cmd_del_station(netdev, sta, reason_code,
-						disassociate);
-
-	if (!l_genl_family_send(nl80211, msg, netdev_del_sta_cb, NULL, NULL))
-		return -EIO;
-
-	return 0;
-}
-
 static void netdev_operstate_cb(int error, uint16_t type,
 					const void *data,
 					uint32_t len, void *user_data)
@@ -1444,8 +1398,9 @@ static void netdev_setting_keys_failed(struct netdev_handshake_state *nhs,
 		if (err == -ENETDOWN)
 			return;
 
-		msg = netdev_build_cmd_del_station(netdev, nhs->super.spa,
-				MMPDU_REASON_CODE_UNSPECIFIED, false);
+		msg = nl80211_build_del_station(netdev->index,
+				nhs->super.spa, MMPDU_REASON_CODE_UNSPECIFIED,
+				MPDU_MANAGEMENT_SUBTYPE_DEAUTHENTICATION);
 		if (!l_genl_family_send(nl80211, msg, NULL, NULL, NULL))
 			l_error("error sending DEL_STATION");
 
@@ -2227,8 +2182,9 @@ void netdev_handshake_failed(struct handshake_state *hs, uint16_t reason_code)
 		break;
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_P2P_GO:
-		msg = netdev_build_cmd_del_station(netdev, nhs->super.spa,
-				reason_code, false);
+		msg = nl80211_build_del_station(netdev->index, nhs->super.spa,
+				reason_code,
+				MPDU_MANAGEMENT_SUBTYPE_DEAUTHENTICATION);
 		if (!l_genl_family_send(nl80211, msg, NULL, NULL, NULL))
 			l_error("error sending DEL_STATION");
 	}
diff --git a/src/nl80211util.c b/src/nl80211util.c
index 8ed260ad6f13..1d1d7099e575 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -310,6 +310,22 @@ struct l_genl_msg *nl80211_build_disconnect(uint32_t ifindex,
 	return msg;
 }
 
+struct l_genl_msg *nl80211_build_del_station(uint32_t ifindex,
+						const uint8_t addr[static 6],
+						uint16_t reason_code,
+						uint8_t subtype)
+{
+	struct l_genl_msg *msg;
+
+	msg = l_genl_msg_new_sized(NL80211_CMD_DEL_STATION, 64);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &ifindex);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, 6, addr);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_MGMT_SUBTYPE, 1, &subtype);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_REASON_CODE, 2, &reason_code);
+
+	return msg;
+}
+
 struct l_genl_msg *nl80211_build_new_key_group(uint32_t ifindex, uint32_t cipher,
 					uint8_t key_id, const uint8_t *key,
 					size_t key_len, const uint8_t *ctr,
diff --git a/src/nl80211util.h b/src/nl80211util.h
index 1553047d1b8a..755133a37bb7 100644
--- a/src/nl80211util.h
+++ b/src/nl80211util.h
@@ -34,6 +34,11 @@ struct l_genl_msg *nl80211_build_deauthenticate(uint32_t ifindex,
 struct l_genl_msg *nl80211_build_disconnect(uint32_t ifindex,
 							uint16_t reason_code);
 
+struct l_genl_msg *nl80211_build_del_station(uint32_t ifindex,
+						const uint8_t addr[static 6],
+						uint16_t reason_code,
+						uint8_t subtype);
+
 struct l_genl_msg *nl80211_build_new_key_group(uint32_t ifindex,
 					uint32_t cipher, uint8_t key_id,
 					const uint8_t *key, size_t key_len,
-- 
2.42.0

