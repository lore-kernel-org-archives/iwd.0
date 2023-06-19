Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E88A14272
	for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 18:09:28 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-3f9e1ebbf31so30036291cf.2
        for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 11:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687198167; x=1689790167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6y61ZgznrffdU9vfulnF+wu/INoVgVxOIMiS0Hvg3E=;
        b=RCnl8P6J7U2vJYv88RGvekwHAWx1vx0pTakdU7eiCPVGoA+yhq9IkxIYGz8dlca9YK
         +Wf8Ny7ULeEggUz+jygMXlyJeCh1Ol6OuI1jF+6oNJLQ/sIA2LZTVWZHjQ7z2FMRhqp3
         GgGV5QE8/gI2BV40vaLdpAK7mtnILsN8wBlb9fLmkV91vz+/zzitoy7D2grCY4LrZiOb
         KDEQhS5ndAy2SfeGjic6KqT1OF0zxDG4MsREZV+PY/AyP/+VPC2XmX8Bq1+ZypTdyqi1
         8Fe89YduzQQ74wZ4apqnRLAJYB5mIFi6ZT2PjMeRIQyFXwY4Mt0EFwc59vodEHSYw0O7
         oRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687198167; x=1689790167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6y61ZgznrffdU9vfulnF+wu/INoVgVxOIMiS0Hvg3E=;
        b=ScfKWi1DElk2B3DvJX9wu81XK7Jq8Z5lctOCxQftCVkOotgnSfGCuiDX0sK9Sp/1gb
         AuXePiiik9q2qijaka7merY++YJhmURcPnqJCFdnUK8We19jiu0YzR5MI3//KHkzbPay
         OJFBO/fuArzz4Clah8AX/jsu/tYC6XSdJmgxYCPzJolTMeVmewa+LyRCseOsMPc7gWIy
         /ocAjgaYDmOAZ371yLVvH+E7JHPRFNPf3a/D1pjrKrEwf/tLj4lRIrwp3OCVwkZUaOZq
         ZTJWg94D/j9OMJOk0e9vxGKMhQPpozwR44if45QYu66Kk6ru+/KO6lSd2lr3smLij1lx
         xGDw==
X-Gm-Message-State: AC+VfDyXeldD7nNfS0VpMXb0AwOGVXWcpue/3xVvkNPnc6UZHR82pAVB
	jmjDr/yAQmYWYhnYEQq3+U9AJzsa6aw=
X-Google-Smtp-Source: ACHHUZ5EfF1m2idd97mMcjL2kBCJ6VtFlrsd+FiDUcMVNkM6NIoZmOZMC/UJN4SozFIkakkDkTrVHA==
X-Received: by 2002:a05:622a:4e:b0:3f6:914f:5934 with SMTP id y14-20020a05622a004e00b003f6914f5934mr12884833qtw.58.1687198167120;
        Mon, 19 Jun 2023 11:09:27 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id i21-20020ac84f55000000b003ff0d00a71esm148930qtw.13.2023.06.19.11.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 11:09:26 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/3] netdev: disable power save if required
Date: Mon, 19 Jun 2023 11:09:21 -0700
Message-Id: <20230619180922.231506-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619180922.231506-1-prestwoj@gmail.com>
References: <20230619180922.231506-1-prestwoj@gmail.com>
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
 src/netdev.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

v3:
 * Zero power_save_cmd_id in callback

diff --git a/src/netdev.c b/src/netdev.c
index a72745b0..f5c5fc51 100644
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
@@ -6240,6 +6241,42 @@ static void netdev_get_link(struct netdev *netdev)
 	l_free(rtmmsg);
 }
 
+static void netdev_disable_ps_cb(struct l_genl_msg *msg, void *user_data)
+{
+	struct netdev *netdev = user_data;
+	int err = l_genl_msg_get_error(msg);
+
+	netdev->power_save_cmd_id = 0;
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
@@ -6311,6 +6348,12 @@ struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
 
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

