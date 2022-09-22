Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214E38B21
	for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 22:08:12 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id b5so2360519pgb.6
        for <iwd@lists.linux.dev>; Thu, 22 Sep 2022 15:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=aWgSsAMsEryEhhY2g+r3DfcL0ztmqDPtcT1XdsRBzAk=;
        b=DJLpatjSuv+xVQSBqwBBpXoVx3a7Q/h4yAzp/S68BNpIct+AUwYq3sBtiWOOW5mYWN
         Iy7VFxXkJUy59wdXdJqcrBlHh9vssMAn4dDP0nUvZDtHhBuVHJ4EiNlGI753wp9Ck4Pn
         RxQp0mCckjxyFN4k8xCTmQSn299s10GeRtfCGlLq3ATwhxviGxpUZv7kyIiIqta6Bqy3
         s9JwVpRFbp6CEYnft48Y/QjblQ8Ol9wAq7/nvqT8j0fiHhhnSBaD0dwqE3X0Gwnw3Ef8
         fuP1Ez5CuEamNCJ2+DfmkrtF8svVTUxZJbdAJVJUcAU+wZoiyy7rYJ3wbKvfsOz4cuy3
         OFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=aWgSsAMsEryEhhY2g+r3DfcL0ztmqDPtcT1XdsRBzAk=;
        b=Gzr1SYz8RpmsclpQvsiCbG5K84FwOd3rP4yGxLwqOCY+oDSbL0f86YFPZ0sOpSbIBC
         9T5Qs9iXD1p6IPvrg1u65P/bICD/CphlQaEZQBQx8X4Oe7mNlX303jazHjgPkNXMvWjT
         rpi4zdnOnjLv2trX49qQcHfyQ5M31mGkWZlcUzN1STPqL2hCZ5CuNg7Vsq4OJsLMxXu/
         cmLJPgwVu7DBmzHyIyUZWa6yCxwzAzIsmP/w5zOkNkvQCYdWN8vnmuSnqgfHPT0i/xP9
         JY6haONwsWrc7ATzKWoPQxzR5kKeF0rHzkgyIC7S6ybO0cQg0HM/NblsOwiwNzGPs6E5
         AtUw==
X-Gm-Message-State: ACrzQf0hhfHpExzCa8Yty43BcOH80rl/lAVotRsaj0eVdBsEsyOvVt9X
	+8JRyu3j7QqtLaBuFtbQgoPPEyS/+Gw=
X-Google-Smtp-Source: AMsMyM6gvVQBPuKregr/Cwfsx7tnZ8+hgiU8cqpUBYVven89//9ol/s4IOM5H/F/70fLZdFcxuObNQ==
X-Received: by 2002:aa7:87d6:0:b0:53e:79bb:feb2 with SMTP id i22-20020aa787d6000000b0053e79bbfeb2mr5762885pfo.13.1663884492366;
        Thu, 22 Sep 2022 15:08:12 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7968f000000b005386162bc2asm4980448pfk.92.2022.09.22.15.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 15:08:12 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 02/11] netdev: add FT TX frame hook
Date: Thu, 22 Sep 2022 15:08:00 -0700
Message-Id: <20220922220809.862022-2-prestwoj@gmail.com>
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

A netdev hook for FT to send out frames. This will be used both for
FT-over-DS action frames and FT-over-Air authentication.
---
 src/netdev.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 5828b4ea..22e07145 100644
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

