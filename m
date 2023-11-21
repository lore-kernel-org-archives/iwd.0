Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2C251003
	for <iwd@lists.linux.dev>; Tue, 21 Nov 2023 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPd2hhux"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-41cd97d7272so35685811cf.0
        for <iwd@lists.linux.dev>; Tue, 21 Nov 2023 10:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700591609; x=1701196409; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IPOiQI15jFm6lGCmWD6f6KI8HQwD9URZINuqK5iJBLA=;
        b=kPd2hhuxC8jgb3U2de3u4nW8hG0b4b6EiSAHWclLdP0/BCDRTzfDRaYcDDIoPAIxs0
         W80AaALuxQNloiYoJc0MI1Fzki4uOOY9vD23XDOYSEokZMbkiZ65bfnB361m/m6WdkW7
         VyAJfHJbKMPKA4NmN1ygeQl7chedwhZ1/R0GtJSXxHl42QmY7eyINwDtw1CQ63eQ7LTa
         RCW2YGEW98P9Aa+eDv/p5qouPUL+PvBWoqXJBC0rLapg46PbOGztAM47yNwdjqS+XZL8
         zEBuE0xKiFaKI6clMvpl1mxhTNAn51YexxSPNaJCe85dLBhJm1Rihi2uIBnzIUE+0R1Q
         n7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700591609; x=1701196409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPOiQI15jFm6lGCmWD6f6KI8HQwD9URZINuqK5iJBLA=;
        b=s/2JGW6R3Jy57euYhjUCnTYaPvc0ndmew7ov4f/AFcluwF88qZt53ohPDFagdgLH0C
         cneqmEI4FIzmFaV30Ox4gm/+tLczwNKxIm/a2n4cDOvZ0BOXVNm+hvn+6fxSS2ED/HkM
         W0PFHvdzCtky9rTewYxYvgHU+e0qOvttlv1mdg3h7zPBR3T8ktIKMRkb1YWPAdv5Chg3
         QiJyobiYhiktjBkTWCNqWInvk9jkI1dmwkfRIfktx9GNRE1+JrLKiOGOVp1Sdr2mGOK4
         r1NJwZp+mzEBm6YJo7M7zUIN9CWwo0D/BqX/NdgqshzUr1esTLPdZRZ/0xOmIqLdMlK8
         InBQ==
X-Gm-Message-State: AOJu0Yzf+4/kmoUETXgjmi8K216nskBQ6v2IHYrvbHrEidYJedQgGLo0
	/3e5/yg9ougoC7KrYpJ30ENpqW0FU98=
X-Google-Smtp-Source: AGHT+IELw5DOgOHc0X0fqoRs9SE3I1dL+34xnLYR2nw+m/G7mtWXzvgu7SWJBR9MALFgyYRe7i7ciA==
X-Received: by 2002:a05:622a:1ba4:b0:423:6e1f:e05c with SMTP id bp36-20020a05622a1ba400b004236e1fe05cmr8667qtb.16.1700591608929;
        Tue, 21 Nov 2023 10:33:28 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.131])
        by smtp.gmail.com with ESMTPSA id r7-20020ac85207000000b0041ea965dcd9sm3772940qtn.69.2023.11.21.10.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 10:33:28 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] netdev: move power save disabling until after interface is up
Date: Tue, 21 Nov 2023 10:33:21 -0800
Message-Id: <20231121183321.179230-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Very rarely on ath10k (potentially other ath cards), disabling
power save while the interface is down causes a timeout when
bringing the interface back up. This seems to be a race in the
driver or firmware but it causes IWD to never start up properly
since there is no retry logic on that path.

Retrying is an option, but a more straight forward approach is
to just reorder the logic to set power save off after the
interface is already up. If the power save setting fails we can
just log it, ignore the failure, and continue. From a users point
of view there is no real difference in doing it this way as
PS still gets disabled prior to IWD connecting/sending data.

Changing behavior based on a buggy driver isn't something we
should be doing, but in this instance the change shouldn't have
any downside and actually isn't any different than how it has
been done prior to the driver quirks change (i.e. use network
manager, iw, or iwconfig to set power save after IWD starts).

For reference, this problem is quite rare and difficult to say
exactly how often but certainly <1% of the time:

iwd[1286641]: src/netdev.c:netdev_disable_ps_cb() Disabled power save for ifindex 54
kernel: ath10k_pci 0000:02:00.0: wmi service ready event not received
iwd[1286641]: Error bringing interface 54 up: Connection timed out
kernel: ath10k_pci 0000:02:00.0: Could not init core: -110

After this IWD just sits idle as it has no interface to start using.

This is even reproducable outside of IWD if you loop and run:

ip link set <wlan> down
iw dev <wlan> set power_save off
ip link set <wlan> up

Eventually the 'up' command will fail with a timeout.

I've brought this to the linux-wireless/ath10k mailing list but
even if its fixed in future kernels we'd still need to support
older kernels, so a workaround/change in IWD is still required.
---
 src/netdev.c | 86 +++++++++++++++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 42 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index e31a5161..f23ca59e 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -5935,6 +5935,44 @@ static void netdev_dellink_notify(const struct ifinfomsg *ifi, int bytes)
 	netdev_free(netdev);
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
+	WATCHLIST_NOTIFY(&netdev_watches, netdev_watch_func_t,
+				netdev, NETDEV_WATCH_EVENT_NEW);
+	netdev->events_ready = true;
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
 static void netdev_initial_up_cb(int error, uint16_t type, const void *data,
 					uint32_t len, void *user_data)
 {
@@ -5967,6 +6005,12 @@ static void netdev_initial_up_cb(int error, uint16_t type, const void *data,
 
 	scan_wdev_add(netdev->wdev_id);
 
+	if (wiphy_power_save_disabled(netdev->wiphy)) {
+		/* Wait to issue EVENT_NEW until power save is disabled */
+		if (netdev_disable_power_save(netdev))
+			return;
+	}
+
 	WATCHLIST_NOTIFY(&netdev_watches, netdev_watch_func_t,
 				netdev, NETDEV_WATCH_EVENT_NEW);
 	netdev->events_ready = true;
@@ -6130,42 +6174,6 @@ static void netdev_get_link(struct netdev *netdev)
 	l_free(rtmmsg);
 }
 
-static void netdev_disable_ps_cb(struct l_genl_msg *msg, void *user_data)
-{
-	struct netdev *netdev = user_data;
-	int err = l_genl_msg_get_error(msg);
-
-	netdev->power_save_cmd_id = 0;
-
-	/* Can't do anything about it but inform the user */
-	if (err < 0)
-		l_error("Failed to disable power save for ifindex %u (%s: %d)",
-				netdev->index, strerror(-err), err);
-	else
-		l_debug("Disabled power save for ifindex %u", netdev->index);
-
-	netdev_get_link(netdev);
-}
-
-static bool netdev_disable_power_save(struct netdev *netdev)
-{
-	struct l_genl_msg *msg = l_genl_msg_new(NL80211_CMD_SET_POWER_SAVE);
-	uint32_t disabled = NL80211_PS_DISABLED;
-
-	l_genl_msg_append_attr(msg, NL80211_ATTR_IFINDEX, 4, &netdev->index);
-	l_genl_msg_append_attr(msg, NL80211_ATTR_PS_STATE, 4, &disabled);
-
-	netdev->power_save_cmd_id = l_genl_family_send(nl80211, msg,
-							netdev_disable_ps_cb,
-							netdev, NULL);
-	if (!netdev->power_save_cmd_id) {
-		l_error("Failed to send SET_POWER_SAVE (-EIO)");
-		return false;
-	}
-
-	return true;
-}
-
 struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
 					const uint8_t *set_mac)
 {
@@ -6237,12 +6245,6 @@ struct netdev *netdev_create_from_genl(struct l_genl_msg *msg,
 
 	netdev_setup_interface(netdev);
 
-	if (wiphy_power_save_disabled(wiphy)) {
-		/* Wait to issue GET_LINK until PS is disabled */
-		if (netdev_disable_power_save(netdev))
-			return netdev;
-	}
-
 	netdev_get_link(netdev);
 
 	return netdev;
-- 
2.34.1

