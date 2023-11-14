Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D19441754
	for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgefcPiC"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1f03d9ad89fso3401861fac.1
        for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 09:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699982150; x=1700586950; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ql2od1/8gLq3lw/BVJZLx8gEIWwhKh1F4Wk5I9HTr+g=;
        b=mgefcPiCPlLgSSnTt1rPNNrnO2pmdXsO5ixZ5CddhBHkUw4Gl+kE7lcqbXLCBBKmI3
         BVdvCNUHHQHx3S4sRMEgM/ZsgzpYMScrPnpU7JqgJ8ejkI3gVto25bAFwOFArQy55LN7
         nUZMav5+g9gVshS48EsTUO4ZlYLQHOo/66nExuI2cHjZqBbwK5gr4XEFwVTtm7rMF1wL
         aOpyfRaXbVSYHdhigf4NraQjh0aNWJ8djDxb2jDDePHGSBilU+R2GH+Ofw711B+jvCnz
         kPXU6EMwO8CggYOqPMR11E6cq1GIHWUlOqNfZv8PVRYxWMqAasXDJNAN7WuXrg7Tmz6k
         dgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699982150; x=1700586950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ql2od1/8gLq3lw/BVJZLx8gEIWwhKh1F4Wk5I9HTr+g=;
        b=LXqP3Jdvj9Y8ih8TzlHF1xgYhrmzr+wp/LPtJO59ezuy2vwru14QRMZqDdpD7Dl1xz
         EoewRBuCBUm6Gufy+kUm9AOq17ZHtuw7L/chgPklHLBfeqIHdpMRmarscfRPbekBrv5a
         th0iR2pQUn1g2MkgA2raVlo7RXlSEw8mbxoi0xwTQ0onc94di9NS4g7cMBZ329U4DGVp
         R7CqkfK1gfh/1uA07cNXJrSztAQbl7gsT2DtFUYtIomYJ7aYV7h98EjSlbFT9D0WwIkm
         32NfRVrzP/bmWjsssoJ9t5mDeYy6J8038Rin+qE9ghCUI3sOWLnj5ogTUgVCg+qagB31
         ZhgA==
X-Gm-Message-State: AOJu0Yyf9Ncn8RBH8D/GNGI8KTLDqoCjYCP3GgL+lL/ky//mQpm+13UK
	t63+PlEUkP/5x5OwTlZ6vIqw6M8QOnw=
X-Google-Smtp-Source: AGHT+IGpapyR+q03FeeB6wSaKoyvDzdm5KMZkT+LjM2tw6es4KlJezpr5veu1Fl83ZZnwlW2JYVOIg==
X-Received: by 2002:a05:6870:ec86:b0:1ea:fd4:58fb with SMTP id eo6-20020a056870ec8600b001ea0fd458fbmr12977623oab.52.1699982150566;
        Tue, 14 Nov 2023 09:15:50 -0800 (PST)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id o4-20020a05687072c400b001e9a253afa3sm1429647oak.49.2023.11.14.09.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 09:15:49 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 06/11] netdev: Move CMD_DEAUTHENTICATE builder to nl80211util
Date: Tue, 14 Nov 2023 11:14:29 -0600
Message-ID: <20231114171455.1108856-6-denkenz@gmail.com>
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
 src/netdev.c      | 20 ++++----------------
 src/nl80211util.c | 14 ++++++++++++++
 src/nl80211util.h |  3 +++
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 1f6920028a03..6c35cd1b75e7 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1298,20 +1298,6 @@ static void netdev_deauthenticate_event(struct l_genl_msg *msg,
 					MMPDU_STATUS_CODE_UNSPECIFIED);
 }
 
-static struct l_genl_msg *netdev_build_cmd_deauthenticate(struct netdev *netdev,
-							uint16_t reason_code)
-{
-	struct l_genl_msg *msg;
-
-	msg = l_genl_msg_new_sized(NL80211_CMD_DEAUTHENTICATE, 128);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_REASON_CODE, 2, &reason_code);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN,
-							netdev->handshake->aa);
-
-	return msg;
-}
-
 static struct l_genl_msg *netdev_build_cmd_del_station(struct netdev *netdev,
 							const uint8_t *sta,
 							uint16_t reason_code,
@@ -3028,7 +3014,8 @@ static void netdev_cmd_ft_reassociate_cb(struct l_genl_msg *msg,
 
 		netdev->result = NETDEV_RESULT_ASSOCIATION_FAILED;
 		netdev->last_code = MMPDU_STATUS_CODE_UNSPECIFIED;
-		cmd_deauth = netdev_build_cmd_deauthenticate(netdev,
+		cmd_deauth = nl80211_build_deauthenticate(netdev->index,
+						netdev->handshake->aa,
 						MMPDU_REASON_CODE_UNSPECIFIED);
 		netdev->disconnect_cmd_id = l_genl_family_send(nl80211,
 							cmd_deauth,
@@ -3163,7 +3150,8 @@ static void netdev_authenticate_event(struct l_genl_msg *msg,
 
 			netdev->result = NETDEV_RESULT_ASSOCIATION_FAILED;
 			netdev->last_code = MMPDU_STATUS_CODE_UNSPECIFIED;
-			cmd_deauth = netdev_build_cmd_deauthenticate(netdev,
+			cmd_deauth = nl80211_build_deauthenticate(netdev->index,
+						netdev->handshake->aa,
 						MMPDU_REASON_CODE_UNSPECIFIED);
 			netdev->disconnect_cmd_id = l_genl_family_send(nl80211,
 							cmd_deauth,
diff --git a/src/nl80211util.c b/src/nl80211util.c
index 44a8ebe50300..8ed260ad6f13 100644
--- a/src/nl80211util.c
+++ b/src/nl80211util.c
@@ -284,6 +284,20 @@ done:
 	return ret;
 }
 
+struct l_genl_msg *nl80211_build_deauthenticate(uint32_t ifindex,
+						const uint8_t addr[static 6],
+						uint16_t reason_code)
+{
+	struct l_genl_msg *msg;
+
+	msg = l_genl_msg_new_sized(NL80211_CMD_DEAUTHENTICATE, 128);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &ifindex);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_REASON_CODE, 2, &reason_code);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_MAC, ETH_ALEN, addr);
+
+	return msg;
+}
+
 struct l_genl_msg *nl80211_build_disconnect(uint32_t ifindex,
 							uint16_t reason_code)
 {
diff --git a/src/nl80211util.h b/src/nl80211util.h
index 9eb8681900b8..1553047d1b8a 100644
--- a/src/nl80211util.h
+++ b/src/nl80211util.h
@@ -28,6 +28,9 @@ struct band_freq_attrs;
 
 int nl80211_parse_attrs(struct l_genl_msg *msg, int tag, ...);
 
+struct l_genl_msg *nl80211_build_deauthenticate(uint32_t ifindex,
+						const uint8_t addr[static 6],
+						uint16_t reason_code);
 struct l_genl_msg *nl80211_build_disconnect(uint32_t ifindex,
 							uint16_t reason_code);
 
-- 
2.42.0

