Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA862570
	for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 22:32:04 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id w13so7079913plp.1
        for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 15:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=A8Z7sgJmmJ6FbjPuzPb49qC9LqZvsFw6rcmPYmbFd6E=;
        b=Nrr/Yn4srQU0InqsCyeoHu86xzANJRXXOuWcf88R2iSjrHcPjUYhLJXjldNgxwfeZK
         lGVGG8ZCgAqmdeX7JUv7FVtE3czLXob+wgkUyBGoS4jGiJ/UH+cafnGdwKxnOeut3riH
         M4YxjTq7KQob3z7fW5yKmbSFIwe8lyV0lG0s1ZEfif2M2/QhEkGL/iOWCcPoqWi3NZA6
         jU6kDmaxjEEcyGpefFx2qLxwLeMsiOAcG1LlKlH0jLNwUc8Qh3kDPf9eQs5viy046Arz
         125OR3XBKb6fdDrdG+ubOQGrA6ZXy9FcQtQ94fqs+LDvNrGU3ZFMKIoHFXsrvkiS/jTa
         dgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=A8Z7sgJmmJ6FbjPuzPb49qC9LqZvsFw6rcmPYmbFd6E=;
        b=XMsqZRmI8I2j99eimh75ATkie+vf52bfpCPFEpKligYZR01IWGN4vMZEdOtkdiqlL1
         1Nv5zjn2AOOyEhCJY4viBbYbDe21MXGOqEouib4SaFNg80YuGOM4PKjdtNW4zAUSN2MI
         1OYU/iEHv1203YwqrNTqO+PXuN44bAzb97WQuOh77e4OH/DCgasfQ/rhNeQlFna31LFG
         7n/j+STwMQeMVMa2XT9poTTSuaApFYe0EOWettbG0mWWQhiXaotKNP/I0ibpak8/6Sbx
         67HY7UYkt8mSk431VBfq3ZJQL9xvRr0Xk7Qmg+3D4gKz2GddSjZJvry51A2qSklKA2TD
         ZKvA==
X-Gm-Message-State: ACrzQf0M5+JBYyd33xCxbDsdxAYNsSg61nBhF6uS1RxtKYRpySVS8fpK
	yw/1hriaG35mdllkygKx8LmEt9/VA8Y=
X-Google-Smtp-Source: AMsMyM7xj4nnpyPPZiOUQHU09prPDoXC5QhZb3pq0/pwBFOPtZwkfpahneP+wC21TZr/MsDDdiRXEQ==
X-Received: by 2002:a17:90b:388d:b0:202:be54:1691 with SMTP id mu13-20020a17090b388d00b00202be541691mr377038pjb.31.1663799523661;
        Wed, 21 Sep 2022 15:32:03 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id r10-20020a63e50a000000b00438c0571456sm2393135pgh.24.2022.09.21.15.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:32:03 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 06/15] netdev: add FT TX frame hook
Date: Wed, 21 Sep 2022 15:31:49 -0700
Message-Id: <20220921223158.704658-6-prestwoj@gmail.com>
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

A netdev hook for FT to send out frames. This will be used both for
FT-over-DS action frames and FT-over-Air authentication.
---
 src/netdev.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 3510c0a6..60d832d2 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4367,6 +4367,38 @@ static uint32_t netdev_send_action_frame(struct netdev *netdev,
 						user_data);
 }
 
+static void netdev_ft_frame_cb(struct l_genl_msg *msg, void *user_data)
+{
+	if (l_genl_msg_get_error(msg) < 0)
+		l_debug("Failed to send FT-Frame");
+}
+
+static int netdev_tx_ft_frame_frame(uint32_t ifindex, uint16_t frame_type,
+					uint32_t frequency, const uint8_t *dest,
+					struct iovec *iov, size_t iov_len)
+{
+	struct netdev *netdev = netdev_find(ifindex);
+	struct l_genl_msg *msg = nl80211_build_cmd_frame(netdev->index,
+							frame_type,
+							netdev->addr, dest,
+							frequency,
+							iov, iov_len);
+
+	/*
+	 * Even though the kernel is doing offchannel for Authentication this
+	 * flag is still required otherwise the kernel gives -EBUSY.
+	 */
+	l_genl_msg_append_attr(msg, NL80211_ATTR_OFFCHANNEL_TX_OK, 0, NULL);
+
+	if (!l_genl_family_send(nl80211, msg, netdev_ft_frame_cb,
+				netdev, NULL)) {
+		l_genl_msg_unref(msg);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static void netdev_cmd_authenticate_ft_cb(struct l_genl_msg *msg,
 						void *user_data)
 {
@@ -6639,6 +6671,7 @@ static int netdev_init(void)
 	__eapol_set_tx_packet_func(netdev_control_port_frame);
 	__eapol_set_install_pmk_func(netdev_set_pmk);
 
+	__ft_set_tx_frame_func(netdev_tx_ft_frame_frame);
 	__ft_set_tx_associate_func(netdev_ft_tx_associate);
 
 	unicast_watch = l_genl_add_unicast_watch(genl, NL80211_GENL_NAME,
-- 
2.34.3

