Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DD7257A
	for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 22:32:04 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id t3so7074926ply.2
        for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 15:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=QpdA+AYBTdXZ8ehmjosCHlcvBaNmPrkC+DD3j1kqP4E=;
        b=EljVwa2yetkC645zOi/FJcIVLFmloSXPG/6mkeWZMUt1giiSsRqus+2jiQStekucBQ
         2h49qhnFEhmbUOvhBnF8EWYH7M5C+H/shw+6SIjbtdSvzNMNxEa3uAgq6aV/4Q0+qlTd
         slCmP4+tfJ2m2zeehYIvbIDO0SakX5xja5gvGkQnXP3QkUT4X8D7rQjMyp4q57NsBCsC
         C3qz+WKV0zN35zjr0B+m0ZYeZj/lH3DOYcc8z2HRDEjSKilboUbytZWHqcbYtFsqBOn2
         bYHKNekc26wJt+NTwzYJAZVLSX/8TvJKtI0Sv408lxXQQ2ocOMLzm9UGYlp+4/Qn9u80
         lMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QpdA+AYBTdXZ8ehmjosCHlcvBaNmPrkC+DD3j1kqP4E=;
        b=D/Uc42gT8/SkOh8flO2uYOLfv4MVo9N6Kl4ahpdw7jfT++P27WXRcWLXJWlyH4t85i
         hvfWpcc9ymhR+m57MUP3lI2WoeVdjkIFL8f6GspNAFZnYfc5C1pVra2V0RZDo/ZXFpNj
         Rgn6Y24GI3d3zmoDdsWZ8MO+g3y5wGVQouVG8KNLRLRJDzNrHbJWiBTgubf6K5mBOXsH
         NukZlGdeXMPYfVeGv3CSfdxBxRCbFjUC6YgbhhIgPkY4Ob9Rjht7sWsp4/JCR4untFqr
         KyfWk1TroX9zSyTAgUZuuAwqRoTnDOvtxN6YgBfXGm84g9KriHhqHFZmJSzHmA+UBQ9F
         17Bw==
X-Gm-Message-State: ACrzQf06+0u8LkMqSEPkG2jAzCgpa2rjjiziXSq44hOIUwwxzWdEZpy+
	ZkHAWDIt2DJX61oTWzfx5UtKJCack4Q=
X-Google-Smtp-Source: AMsMyM6XCPloC/Po1fuSLTooMb2MU5S6v+4AE4m8Pw5ZdhLQNJpuVVMkekmjqu/tioepgcdQ4AWEwA==
X-Received: by 2002:a17:902:7fc8:b0:176:8bc0:3809 with SMTP id t8-20020a1709027fc800b001768bc03809mr253012plb.21.1663799524221;
        Wed, 21 Sep 2022 15:32:04 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id r10-20020a63e50a000000b00438c0571456sm2393135pgh.24.2022.09.21.15.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:32:03 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 07/15] ft: implement offchannel authentication
Date: Wed, 21 Sep 2022 15:31:50 -0700
Message-Id: <20220921223158.704658-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220921223158.704658-1-prestwoj@gmail.com>
References: <20220921223158.704658-1-prestwoj@gmail.com>
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
 src/ft.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/ft.h |  3 ++
 2 files changed, 92 insertions(+)

diff --git a/src/ft.c b/src/ft.c
index 5f37b29a..db060839 100644
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
 
@@ -1170,6 +1173,92 @@ failed:
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
+	if (error == 0)
+		return;
+
+	l_debug("Error in authentication offchannel (%d)", error);
+
+	l_queue_clear(info_list, ft_info_destroy);
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
+	l_queue_clear(info_list, ft_info_destroy);
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
index 2228c90b..89b70850 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -85,7 +85,10 @@ void __ft_set_tx_associate_func(ft_tx_associate_func_t func);
 int __ft_rx_associate(uint32_t ifindex, const uint8_t *frame,
 			size_t frame_len);
 void __ft_rx_action(uint32_t ifindex, const uint8_t *frame, size_t frame_len);
+void __ft_rx_authenticate(uint32_t ifindex, const uint8_t *frame,
+				size_t frame_len);
 
 void ft_reset(uint32_t ifindex);
 int ft_action(uint32_t ifindex, uint32_t freq, const struct scan_bss *target);
 int ft_associate(uint32_t ifindex, const uint8_t *addr);
+int ft_authenticate(uint32_t ifindex, const struct scan_bss *target);
-- 
2.34.3

