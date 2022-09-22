Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C959F8B22
	for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 22:08:13 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id e68so10632829pfe.1
        for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 15:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=FRGEGYP5j/QAM0EQTtcDKOY1OpeB2GABU0OqiyH9Tbc=;
        b=Jh31h7kzH5DVLoKieU9+9XYhcrxe9e/0Heic2TcpCnQI9U1jctw5TJ8fE/5S0kCT1B
         G9irySekxpYw9sKOalO8KecnjrUvVTduSx0H5TgZAnwFJbRf3qzmZY9GnebYrW9znA3P
         JEJgV45p7GBd13Mawwdm6liiTDaaYPjTVrvgzwDgdxBKYXCELoPm+qniAEvTVfotQEDx
         tf9/6AInsR9eb6Ve03Vd8WZFaUvlYOJZubc6t+BNM6HxYgVvRuWdKjbY8EmHem59LO7G
         Jxfg3xaJQc4aShVt65cd2m8Rxz6jzuIEx3wzAfW9MImhnaZ1IxniVYFTLMuFg9VTSaz8
         E6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FRGEGYP5j/QAM0EQTtcDKOY1OpeB2GABU0OqiyH9Tbc=;
        b=Q/2wOfOMinSYRptAJnWhEvrJQMSKEdGkik/qWc0/wNltafnnrHM7/CqKGlRA8Rb/Ru
         iTYVsIDqa8M6Ahw5Q6IqRJGKN3X/LoKewsu3HYg3wTZfeUPe0FtfmAMAWXjdK/Nbiv3q
         hgS43JrI/3N48mfvTzQ3JE4NHSEi8s+bktvwDMznZmTUMBfXmZUUcAy88EJgalfshYhJ
         cen2yONxAJ5fDiuZyFw+YTFkLmeVHvVHlTu9HeomBRAlmaPte/5hBjgEvN7Byrg8889W
         H+1ka6wkIYcHdGg+P0Iapk04VBQIuSrg6gsVy32p7mPblakWPnIyaJ3ny6Pij5s0TmhQ
         TjZA==
X-Gm-Message-State: ACrzQf05wubv+ft3Chta5xf+9qhWFFSBGkBjF5NI2HsjwWCedCO4sUZi
	3Qim4oGDx1hGrFjZxdwsuhmo8oEY2V4=
X-Google-Smtp-Source: AMsMyM6ds9vja+9VPHeFdc3dF9MjHuwtCK9DG9Ewu1BZ6K9K9l2cu4E/c7mD5bTAKISrm/VRxeQ2FQ==
X-Received: by 2002:a62:e90d:0:b0:556:63e7:2579 with SMTP id j13-20020a62e90d000000b0055663e72579mr898093pfh.6.1663884493077;
        Thu, 22 Sep 2022 15:08:13 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7968f000000b005386162bc2asm4980448pfk.92.2022.09.22.15.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 15:08:12 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 03/11] ft: implement offchannel authentication
Date: Thu, 22 Sep 2022 15:08:01 -0700
Message-Id: <20220922220809.862022-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220922220809.862022-1-prestwoj@gmail.com>
References: <20220922220809.862022-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new API was added, ft_authenticate, which will send an
authentication frame offchannel via CMD_FRAME. This bypasses
the kernel's authentication state allowing multiple auth
attempts to take place without disconnecting.
---
 src/ft.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/ft.h |  3 ++
 2 files changed, 94 insertions(+)

diff --git a/src/ft.c b/src/ft.c
index 9d18f0a9..7234306c 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -37,6 +37,8 @@
 #include "src/util.h"
 #include "src/netdev.h"
 #include "src/module.h"
+#include "src/offchannel.h"
+#include "src/wiphy.h"
 
 static ft_tx_frame_func_t tx_frame = NULL;
 static ft_tx_associate_func_t tx_assoc = NULL;
@@ -52,6 +54,7 @@ struct ft_info {
 	uint8_t *authenticator_ie;
 	uint8_t prev_bssid[6];
 	uint32_t frequency;
+	uint32_t offchannel_id;
 
 	struct ie_ft_info ft_info;
 
@@ -1169,6 +1172,94 @@ failed:
 	return ret;
 }
 
+void __ft_rx_authenticate(uint32_t ifindex, const uint8_t *frame,
+				size_t frame_len)
+{
+	struct netdev *netdev = netdev_find(ifindex);
+	struct handshake_state *hs = netdev_get_handshake(netdev);
+	struct ft_info *info;
+	uint16_t status;
+	const uint8_t *ies;
+	size_t ies_len;
+
+	info = ft_info_find(ifindex, NULL);
+	if (!info)
+		return;
+
+	if (!ft_parse_authentication_resp_frame(frame, frame_len,
+					info->spa, info->aa, info->aa, 2,
+					&status, &ies, &ies_len))
+		return;
+
+	if (status != 0)
+		return;
+
+	if (!ft_parse_ies(info, hs, ies, ies_len))
+		return;
+
+	info->parsed = true;
+
+	return;
+}
+
+static void ft_send_authenticate(void *user_data)
+{
+	struct ft_info *info = user_data;
+	struct netdev *netdev = netdev_find(info->ifindex);
+	struct handshake_state *hs = netdev_get_handshake(netdev);
+	uint8_t ies[256];
+	size_t len;
+	struct iovec iov[2];
+	struct mmpdu_authentication auth;
+
+	/* Authentication body */
+	auth.algorithm = L_CPU_TO_LE16(MMPDU_AUTH_ALGO_FT);
+	auth.transaction_sequence = L_CPU_TO_LE16(1);
+	auth.status = L_CPU_TO_LE16(0);
+
+	iov[0].iov_base = &auth;
+	iov[0].iov_len = sizeof(struct mmpdu_authentication);
+
+	if (!ft_build_authenticate_ies(hs, hs->supplicant_ocvc, info->snonce,
+					ies, &len))
+		return;
+
+	iov[1].iov_base = ies;
+	iov[1].iov_len = len;
+
+	tx_frame(info->ifindex, 0x00b0, info->frequency, info->aa, iov, 2);
+}
+
+static void ft_authenticate_destroy(int error, void *user_data)
+{
+	struct ft_info *info = user_data;
+
+	if (error == 0)
+		return;
+
+	l_debug("Error in authentication offchannel (%d)", error);
+
+	ft_clear_authentications(info->ifindex);
+}
+
+int ft_authenticate(uint32_t ifindex, const struct scan_bss *target)
+{
+	struct netdev *netdev = netdev_find(ifindex);
+	struct handshake_state *hs = netdev_get_handshake(netdev);
+	struct ft_info *info = ft_info_new(hs, target);
+
+	info->offchannel_id = offchannel_start(netdev_get_wdev_id(netdev),
+						WIPHY_WORK_PRIORITY_FT,
+						target->frequency,
+						200, ft_send_authenticate, info,
+						ft_authenticate_destroy);
+	ft_clear_authentications(ifindex);
+
+	l_queue_push_tail(info_list, info);
+
+	return 0;
+}
+
 int ft_associate(uint32_t ifindex, const uint8_t *addr)
 {
 	struct netdev *netdev = netdev_find(ifindex);
diff --git a/src/ft.h b/src/ft.h
index fd6dfdae..0e8c3a90 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -85,7 +85,10 @@ void __ft_set_tx_associate_func(ft_tx_associate_func_t func);
 int __ft_rx_associate(uint32_t ifindex, const uint8_t *frame,
 			size_t frame_len);
 void __ft_rx_action(uint32_t ifindex, const uint8_t *frame, size_t frame_len);
+void __ft_rx_authenticate(uint32_t ifindex, const uint8_t *frame,
+				size_t frame_len);
 
 void ft_clear_authentications(uint32_t ifindex);
 int ft_action(uint32_t ifindex, uint32_t freq, const struct scan_bss *target);
 int ft_associate(uint32_t ifindex, const uint8_t *addr);
+int ft_authenticate(uint32_t ifindex, const struct scan_bss *target);
-- 
2.34.3

