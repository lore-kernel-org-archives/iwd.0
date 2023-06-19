Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D04A12B80
	for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 15:26:00 +0000 (UTC)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-76300f4d7eeso94576285a.1
        for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 08:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687188359; x=1689780359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPa/QAJzfKlFaTD0y1s4NL+48olchgRuA/uiDlez6tI=;
        b=PDn1FfxBK3C7vOal0J1bRGV0OXfIN0EOBGqCNuvdex3lxiVf/iApxqcD8Q35tca2JB
         KQ8EV1IXuJqGTzF2Xeks2jjBVhqihmXgifskmvcjOkeh8eoLcHlbE9od1932ovv6/lnc
         mnp5CYsaTbFKtAYzlNYIlIG8tzIIsJ6yO2ClF0wi+s+oIsIlDjw+IUvqrDAxrWsoTorc
         mgyo+V0AROfaCxl2jiSqLr0EDGbUkQnK6dDs+xTH4vVscwSDkkfvkMlM6vMh4i9DGzns
         EtQV2uIrIFnGeImuW6BA7FtoeaJwIXWoRMKqIhsg8UXD+laEhRe/zJOiiPMNklEpcO9i
         jItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687188359; x=1689780359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPa/QAJzfKlFaTD0y1s4NL+48olchgRuA/uiDlez6tI=;
        b=ktomhEKzCLSQSrI0vVYUJGmgpAvPj/BRz1ju2iqlTaWa1BOR7y0DjWuYpnMf69f9PH
         2kBSzU6W7ihWMmExMX6KhfqhuS7nPO1QRs6ThKGARL+M3iXWaupuDNrJUkw1rTDMidVZ
         ClGIMq+TDm873Hi9mD2FHcMd51ueBStZj5OFsM7Xmz7M6hmUvJF2As3oKao3wiLApn7c
         hMUPCKZ8Rd8KFLZiWTFp0fIKXlXhAX9u1gIuyLPOhZNV8TJD0U8jEPaO26Cz4dxWXsXf
         2U0+u/UMvwFkY+KDZPWCcVSV6yX2+KWrddmJZ+L3+EZDPOfpVNnSqKSmUOD7d5hoI3Z9
         gLrg==
X-Gm-Message-State: AC+VfDz0Y+Wzf7BZ9/AOwviLi0+3CBMtWHBpf6tf5F2p2GCuSEof768v
	s4yJimz+mlekjjdMOyxNAVo6+/+j3Vg=
X-Google-Smtp-Source: ACHHUZ4/JNUifIUifksarsxfNufiK+/q+78N5bVNjUDEXw8d6E8ZsPKuA53vczamFG1nb5jc7bnrPw==
X-Received: by 2002:a05:6214:627:b0:623:a5d0:1daf with SMTP id a7-20020a056214062700b00623a5d01dafmr11332699qvx.48.1687188358777;
        Mon, 19 Jun 2023 08:25:58 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id j16-20020a0cf310000000b006260c683bf2sm66544qvl.53.2023.06.19.08.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:25:58 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/3] netdev: disable power save if required
Date: Mon, 19 Jun 2023 08:25:42 -0700
Message-Id: <20230619152543.197532-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619152543.197532-1-prestwoj@gmail.com>
References: <20230619152543.197532-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable power save if the wiphy indicates its needed. Do this
before issuing GET_LINK so the netdev doesn't signal its up until
power save is disabled.
---
 src/netdev.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index af4b4b98..42d96272 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -132,6 +132,7 @@ struct netdev {
 	uint32_t mac_change_cmd_id;
 	uint32_t get_oci_cmd_id;
 	uint32_t get_link_cmd_id;
+	uint32_t power_save_cmd_id;
 	enum netdev_result result;
 	uint16_t last_code; /* reason or status, depending on result */
 	struct l_timeout *neighbor_report_timeout;
@@ -6238,6 +6239,40 @@ static void netdev_get_link(struct netdev *netdev)
 	l_free(rtmmsg);
 }
 
+static void netdev_disable_ps_cb(struct l_genl_msg *msg, void *user_data)
+{
+	struct netdev *netdev = user_data;
+	int err = l_genl_msg_get_error(msg);
+
+	/* Can't do anything about it but inform the user */
+	if (err < 0)
+		l_error("Failed to disable power save for ifindex %u (%s: %d)",
+				netdev->index, strerror(-err), err);
+	else
+		l_debug("Disabled power save for ifindex %u", netdev->index);
+
+	netdev_get_link(netdev);
+}
+
+static bool netdev_disable_power_save(struct netdev *netdev)
+{
+	struct l_genl_msg *msg = l_genl_msg_new(NL80211_CMD_SET_POWER_SAVE);
+	uint32_t disabled = NL80211_PS_DISABLED;
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
+	l_genl_msg_append_attr(msg, NL80211_ATTR_PS_STATE, 4, &disabled);
+
+	netdev->power_save_cmd_id = l_genl_family_send(nl80211, msg,
+							netdev_disable_ps_cb,
+							netdev, NULL);
+	if (!netdev->power_save_cmd_id) {
+		l_error("Failed to send SET_POWER_SAVE (-EIO)");
+		return false;
+	}
+
+	return true;
+}
+
 struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
 					const uint8_t *set_mac)
 {
@@ -6309,6 +6344,12 @@ struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
 
 	netdev_setup_interface(netdev);
 
+	if (wiphy_power_save_disabled(wiphy)) {
+		/* Wait to issue GET_LINK until PS is disabled */
+		if (netdev_disable_power_save(netdev))
+			return netdev;
+	}
+
 	netdev_get_link(netdev);
 
 	return netdev;
-- 
2.25.1

