Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDF14A27
	for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 19:47:44 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so10996339pjh.3
        for <iwd@lists.linux.dev>; Tue, 27 Sep 2022 12:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=P1ffaHH+6O28fifOj2m/uuTy23VZ+vKI7VxWHRMuYes=;
        b=AnDixitCm+fQQwP3aQJfwLeLK9L3fE6QQHWXqksWhMuMPL4sWMOP9/gAuX910A2Zve
         sCPI2MUAkk+3vZvZfl0boBuxeO5NWyE9IUHEVAxQzqu6YU6BmVOqbm6Tf4tetc9KfUPw
         WveYNQZtEkVB5rjT66clw+yg0POV4PZ+h2tU0rSFVY7o5nwUC3TDDp6LrH68ddMh5raa
         InV+P2/GkIKLmgDr3GOD/T+CQx/5UslBlj4gH/HORkU61yMbFXvjPBaoAFUmRTL9NPhd
         4+mT+GNLaqVHodF9Vflc46Nv+66SIrT2aOOhz9QaMBhLfOERl0PbJlu5xRN9JVh72f8r
         OmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=P1ffaHH+6O28fifOj2m/uuTy23VZ+vKI7VxWHRMuYes=;
        b=Y3y2B3Wu8uOtrdvVsq9X1gtGTezrwJ4LYhqDzTtj/6nh64f+SZ2X4gxSjgASgqTGRo
         RrdGL+MkbpqgmjEnMI6usJC09vXfbi+RWyFQ/LypqOqhxPsuN59plc299HWke7KLZf8v
         j+uZ52edpvF+RtKZfGv3hZH2ktfsB8fqyAIoFhO3zD3RqE5mMPXsKuElwoKbK5MeWnXv
         +rpcy9WdhYFnJBQ2yR6or9gnC18N2F4yinTHYqsI+AOGLDHPZ+g4NgxrTti34qQYDI2q
         zZaOXbGCN8Ay4sXJnFsqLRppay1Is18szoCsjVHCQcBcFllGslDivi6bYEku0m5CAeGf
         PVKw==
X-Gm-Message-State: ACrzQf3lVouO+l7SmBtnjCjg9ITVBPCfW2DYDYZ7E6ws+bj+kMk3nAaC
	4LR1tvpe5OVKHVLLjRB8vVx221s6ENs=
X-Google-Smtp-Source: AMsMyM6wp2v3BoGjWwr+bW5OmKKYmC0MDG+cuR79TyDGX3WInWAGGCIVFpbOzsNwzIJDzIF/aAJ2FQ==
X-Received: by 2002:a17:902:6b8b:b0:178:7cf5:ad62 with SMTP id p11-20020a1709026b8b00b001787cf5ad62mr28185082plk.13.1664308063449;
        Tue, 27 Sep 2022 12:47:43 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id b12-20020a1709027e0c00b00176a2d23d1asm2033145plm.56.2022.09.27.12.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:47:43 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v6 02/11] netdev: add FT TX frame hook
Date: Tue, 27 Sep 2022 12:47:22 -0700
Message-Id: <20220927194731.269732-2-prestwoj@gmail.com>
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

A netdev hook for FT to send out frames. This will be used both for
FT-over-DS action frames and FT-over-Air authentication.
---
 src/netdev.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index e4ec2ff6..dbf51882 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4380,6 +4380,38 @@ static uint32_t netdev_send_action_frame(struct netdev *netdev,
 						user_data);
 }
 
+static void netdev_ft_frame_cb(struct l_genl_msg *msg, void *user_data)
+{
+	if (l_genl_msg_get_error(msg) < 0)
+		l_debug("Failed to send FT-Frame");
+}
+
+static int netdev_tx_ft_frame(uint32_t ifindex, uint16_t frame_type,
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
@@ -6652,6 +6684,7 @@ static int netdev_init(void)
 	__eapol_set_tx_packet_func(netdev_control_port_frame);
 	__eapol_set_install_pmk_func(netdev_set_pmk);
 
+	__ft_set_tx_frame_func(netdev_tx_ft_frame);
 	__ft_set_tx_associate_func(netdev_ft_tx_associate);
 
 	unicast_watch = l_genl_add_unicast_watch(genl, NL80211_GENL_NAME,
-- 
2.34.3

