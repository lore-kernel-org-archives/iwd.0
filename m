Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66A24A28
	for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 19:47:44 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id bh13so10332401pgb.4
        for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 12:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ilk4YMDmWY1RbevWgy/q3R4YI0Z9hIOFWVX/NpHsg4s=;
        b=UGGKKlo2b7LHf/eyK0LfRSFfaL/FGEqwafpO7j6uXrKetnTBidhQfIFI/NenTKgyp3
         TWrPM+Wa/Lw5zspNSWqpXaKrK1TqpKgs6jOL4Eg8vuAbVNhPaLw+TrAFwZRlvYrcBh4I
         t/jbioda5DHTyNIF73XPL2njZSxtz3tSE2DjD4ak3Ab3wWQChCok79/qUOK10ALa1yBZ
         tMIXtijmfuf2W+OlSxD71TdpNWy/aJJn8S6BGRjLYdADs/8798ixLtlG26dkYjDmJy/Y
         pOkVF3OR+mUy4iKEGnDg3+oIdhGLqvnhy+q9bhtrgr8hQ3WvdZyky8XY5/l8eQOyjz11
         mNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ilk4YMDmWY1RbevWgy/q3R4YI0Z9hIOFWVX/NpHsg4s=;
        b=yaYyQwzduH+aghg+eomYpUFUeTCQKIP9iTyfG5Mz3EuGLp6tgXemzURWZE+JE21Pem
         qvwxBIO1IGgZ0ShjDUR04/J4Z6borWhoj0/oyhwQpiGExVRT9CkMVG+h6SvkkegyPOE4
         75NhLfogX1/sqSOzlOvBtNlowH+HjGAhFrg2OD2dAENp2o5wD/YpiC0OyHoGqPpissAh
         MpeHCrYrX1fKja8YfebBaqFyqr2iQcIazo7oeGfimPDdevA3GnmJwZ6rBgAUCsDz/mai
         u2qsG+PrNeoZytFRSHKPUjEruNykGMMOY3V5yrL1Sal827lclSxiE4oLhJV8+GQAXDqN
         yeiA==
X-Gm-Message-State: ACrzQf0oMHgCi2zCG6LsQNKKIW53fbR0n1yff8SAHFZTGw+1eepcZlWn
	17nKn6sSVnF2IZz8AU/XGxJa9hn0vLU=
X-Google-Smtp-Source: AMsMyM61GmVNP1MO079moDW9Vjqf+gX1/tfPTbkglaHUlKd/Rlm/LdcS7cQlFv4x/kk82HXD5osDDQ==
X-Received: by 2002:a05:6a00:16c4:b0:535:890:d4a with SMTP id l4-20020a056a0016c400b0053508900d4amr30990670pfc.0.1664308064156;
        Tue, 27 Sep 2022 12:47:44 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id b12-20020a1709027e0c00b00176a2d23d1asm2033145plm.56.2022.09.27.12.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:47:43 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v6 03/11] ft: implement offchannel authentication
Date: Tue, 27 Sep 2022 12:47:23 -0700
Message-Id: <20220927194731.269732-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220927194731.269732-1-prestwoj@gmail.com>
References: <20220927194731.269732-1-prestwoj@gmail.com>
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
 src/ft.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/ft.h |   3 ++
 2 files changed, 105 insertions(+)

diff --git a/src/ft.c b/src/ft.c
index 9d18f0a9..fc9111bc 100644
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
 
@@ -1169,6 +1172,101 @@ failed:
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
+	/* Verified to be expected target, offchannel can be canceled */
+	offchannel_cancel(netdev_get_wdev_id(netdev), info->offchannel_id);
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
+	info->offchannel_id = 0;
+}
+
+/*
+ * There is no callback here because its assumed that another work item will
+ * be inserted following this call which will check if authentication succeeded
+ * via ft_associate.
+ *
+ * If the netdev goes away while authentication is in-flight station will clear
+ * the authentications during cleanup, and in turn cancel the offchannel
+ * request.
+ */
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
@@ -1205,6 +1303,10 @@ static bool remove_ifindex(void *data, void *user_data)
 	if (info->ifindex != ifindex)
 		return false;
 
+	if (info->offchannel_id)
+		offchannel_cancel(netdev_get_wdev_id(netdev_find(ifindex)),
+					info->offchannel_id);
+
 	ft_info_destroy(info);
 	return true;
 }
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

