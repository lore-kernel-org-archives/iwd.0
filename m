Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C67AD47
	for <iwd@lists.linux.dev>; Wed, 14 Dec 2022 21:27:02 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id x2so3429192plb.13
        for <iwd@lists.linux.dev>; Wed, 14 Dec 2022 13:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I/BMrGP3NoFdHZAzuzUyFgb+VWjFVHVjtNat++47X9A=;
        b=lY/k41T3kXGTeP18Ubh48ctGBcSCc/EfwWKpM/f7s3O2zP/ggPMPkUTj7hY5LBxh1a
         1+tfdAdyaYcqLSfdcEECzMI9jgChP48Vi1fuabwpsEZcALsTST780CgM8dpnXX+Lr6Sc
         plDCXDYFS3kRhyTKWWwdv4899wCoG+gWr91AL7EOgXhOHdnQ8af0E9KlvxFS2WPhkRCl
         ZB0yUgyagtPT8jHUHUe4KxtHRSaHnox5E5wy71VhgyLyx4ysV51qvj80Ijj1RgT56up1
         fXDHcdn4EY0VcKnV4+VevO56g+52FYk7KabVn5MYJ+NWosOWf9HmhVh0kOYRLGcFmIau
         2ucg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/BMrGP3NoFdHZAzuzUyFgb+VWjFVHVjtNat++47X9A=;
        b=g3A0em4kOcPrAAMxMVsLxsrFW8yMcKx+Qa0bsU0QNHjCi+ifxWv0X5FhuTwaxNHFZ6
         Jg9MXEePGsOwmrsecYm7dxTv01Y8ByzGq56u6rAS/HQNrI4B2adW8qzDrbtI6cVbAKL/
         bh8TJGYrtSP7b9k7ThIzh2wWDdvwkLRvQ0VsutBJSTzmB1agnUikU1Bv7/ZIvli/nNnv
         DeTH3lpktGu1q0gezMmWmSAVrMiVH5BIKFiWc1UPUtz+e9eutNOvzidtCvByREoevloP
         946a11o7GHBIPX0+0wyz/1pNEvO9GoiOxlSZpaGKC2DqZVLkBfEPrpIZdUlFmrjQi9uL
         vEyw==
X-Gm-Message-State: ANoB5pmgPtcKuP3IO+m91xzzi+jKTL6U2px6aOf5tN3JsVx4rcp09UFF
	a8JdAwS8pIZxrVgw7I+UPI3HL8e8NFo=
X-Google-Smtp-Source: AA0mqf6zxk7xHd0o7hNRWvckc/ZjXMxHqGSI6/bCvy7AGVf+wD9ZAoueTYlSpYLuS7wPo2NWEY8a1w==
X-Received: by 2002:a05:6a20:4294:b0:a6:6d23:9fff with SMTP id o20-20020a056a20429400b000a66d239fffmr36809093pzj.14.1671053221324;
        Wed, 14 Dec 2022 13:27:01 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id a8-20020a656408000000b0047063eb4098sm287653pgv.37.2022.12.14.13.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 13:27:00 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] ft: gate FT-over-DS with a wiphy work item
Date: Wed, 14 Dec 2022 13:26:56 -0800
Message-Id: <20221214212658.1578576-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queue the FT action just like we do with FT Authenticate which makes
it able to be used the same way, i.e. call ft_action() then queue
the ft_associate work right away.

A timer was added to end the work item in case the target never
responds.
---
 src/ft.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 9 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index c2607a1b..f173099d 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -54,8 +54,12 @@ struct ft_info {
 	uint8_t *authenticator_ie;
 	uint8_t prev_bssid[6];
 	uint32_t frequency;
+	uint32_t ds_frequency;
 	uint32_t offchannel_id;
 
+	struct l_timeout *timeout;
+	struct wiphy_radio_work_item work;
+
 	struct ie_ft_info ft_info;
 
 	bool parsed : 1;
@@ -830,6 +834,11 @@ void __ft_rx_action(uint32_t ifindex, const uint8_t *frame, size_t frame_len)
 
 	info->parsed = true;
 
+	l_timeout_remove(info->timeout);
+	info->timeout = NULL;
+
+	wiphy_radio_work_done(netdev_get_wiphy(netdev), info->work.id);
+
 	return;
 
 ft_error:
@@ -868,6 +877,9 @@ static void ft_info_destroy(void *data)
 	if (info->authenticator_ie)
 		l_free(info->authenticator_ie);
 
+	if (info->timeout)
+		l_timeout_remove(info->timeout);
+
 	l_free(info);
 }
 
@@ -900,19 +912,17 @@ static void ft_prepare_handshake(struct ft_info *info,
 	handshake_state_derive_ptk(hs);
 }
 
-int ft_action(uint32_t ifindex, uint32_t freq, const struct scan_bss *target)
+static bool ft_send_action(struct wiphy_radio_work_item *work)
 {
-	struct netdev *netdev = netdev_find(ifindex);
+	struct ft_info *info = l_container_of(work, struct ft_info, work);
+	struct netdev *netdev = netdev_find(info->ifindex);
 	struct handshake_state *hs = netdev_get_handshake(netdev);
-	struct ft_info *info;
 	uint8_t ft_req[14];
 	struct iovec iov[5];
 	uint8_t ies[512];
 	size_t len;
 	int ret = -EINVAL;
 
-	info = ft_info_new(hs, target);
-
 	ft_req[0] = 6; /* FT category */
 	ft_req[1] = 1; /* FT Request action */
 	memcpy(ft_req + 2, info->spa, 6);
@@ -928,17 +938,47 @@ int ft_action(uint32_t ifindex, uint32_t freq, const struct scan_bss *target)
 	iov[1].iov_base = ies;
 	iov[1].iov_len = len;
 
-	ret = tx_frame(hs->ifindex, 0x00d0, freq, hs->aa, iov, 2);
+	ret = tx_frame(hs->ifindex, 0x00d0, info->ds_frequency, hs->aa, iov, 2);
 	if (ret < 0)
 		goto failed;
 
 	l_queue_push_tail(info_list, info);
 
-	return 0;
+	return false;
 
 failed:
-	l_free(info);
-	return ret;
+	l_debug("FT-over-DS action failed to "MAC, MAC_STR(hs->aa));
+
+	ft_info_destroy(info);
+	return true;
+}
+
+struct wiphy_radio_work_item_ops ft_ops = {
+	.do_work = ft_send_action,
+};
+
+static void ft_ds_timeout(struct l_timeout *timeout, void *user_data)
+{
+	struct ft_info *info = user_data;
+	struct netdev *netdev = netdev_find(info->ifindex);
+
+	wiphy_radio_work_done(netdev_get_wiphy(netdev), info->work.id);
+}
+
+int ft_action(uint32_t ifindex, uint32_t freq, const struct scan_bss *target)
+{
+	struct netdev *netdev = netdev_find(ifindex);
+	struct handshake_state *hs = netdev_get_handshake(netdev);
+	struct ft_info *info;
+
+	info = ft_info_new(hs, target);
+	info->ds_frequency = freq;
+	info->timeout = l_timeout_create_ms(200, ft_ds_timeout, info, NULL);
+
+	wiphy_radio_work_insert(netdev_get_wiphy(netdev), &info->work,
+				WIPHY_WORK_PRIORITY_FT, &ft_ops);
+
+	return 0;
 }
 
 void __ft_rx_authenticate(uint32_t ifindex, const uint8_t *frame,
-- 
2.34.3

