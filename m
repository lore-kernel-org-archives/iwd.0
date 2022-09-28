Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7DF4C7A
	for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 19:48:56 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id f23so12601863plr.6
        for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 12:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=JbG9UxU2wnEFR5KYEDBqdVuPwah2mXGiakAEKTVeM/w=;
        b=DOjdVfeSoj5jBMR1llMOQNMQmb0jqnmnT96gwJOcVTtiTPw38uwqYFCR6FgMGCqcf7
         Nqfzl9S/XHXMNOmrAlC4TxEE2qwsR9fEb40uhaO8iMGP2obmBHrL106I6HjYAUPtfq8q
         hRuUNx0C6oePe3F7LTbm9cVYIFWEc2zNO3T1ctgkmISwCZqZgqhXiehuRQe1UPty/87R
         ftKYjirKaEkEjo/hXd1gsBPGGaB7KP4sEvoH02+u/nVR0OD+MeoSfiNTegIQ6+vi78RA
         p3m83t4nKNTCSfAJOTVXYk+HVq17rJV9qq3cKHbP+YwwyBZse2EKr9O2sYSTKOGD7Qah
         mdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JbG9UxU2wnEFR5KYEDBqdVuPwah2mXGiakAEKTVeM/w=;
        b=BmUhNSdYFdZ3r3+VdrM33tETsqZ83bE0t78KnSSEk5eIv4ykN7XX22vlbwJIf70Cs3
         axS/7iG1NtC0VeBVE9te3PAKfYy5rEYwl1mzwgAY0sJ06uRITzzjzmgVZdXHUVxVgC+o
         tOh/cI3F3NufnsTjCwBGzZOwOF86551sSnGSRPLODg2oG625ZifMjpwnKqk9OpwWPSn5
         sCdGlxXomI9QB6ufmpN0WvQTsFdh24aW71/vA7lrHhvkMLsiselaFClXS/HXCDuHFcv9
         i2B6ouiPxqySWHIIxFChGSm0hGYHHcdIWB4QOtxNGu/b9zoXfzeQxPmULiI4zqT2i1gZ
         xKZw==
X-Gm-Message-State: ACrzQf2wGIloFeUd9A7YcNYqQQw3CPwvtwr0IA/E1ID9IoWqQN3ROMUo
	7W0HftRTWvlQVJPIYb+AmN/jg/HTUV0=
X-Google-Smtp-Source: AMsMyM46QjT8W8qHUUNIevVPkB/EUFAwzCcVM2yI9w8xMqBD74k+ndTPGewYqiWk8N6YYi5N5nYRUw==
X-Received: by 2002:a17:90a:9281:b0:203:19a9:e57e with SMTP id n1-20020a17090a928100b0020319a9e57emr12272461pjo.97.1664394535405;
        Wed, 28 Sep 2022 12:48:55 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id r17-20020aa79ed1000000b00550724f8ea0sm4363308pfq.128.2022.09.28.12.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 12:48:55 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] ap: include PROBE_RESP attribute if required by driver
Date: Wed, 28 Sep 2022 12:48:52 -0700
Message-Id: <20220928194852.375786-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220928194852.375786-1-prestwoj@gmail.com>
References: <20220928194852.375786-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain drivers support/require probe response offloading which
IWD did not check for or properly handle. If probe response
offloading is required the probe response frame watch will not
be added and instead the ATTR_PROBE_RESP will be included with
START_AP.

The head/tail builders were reused but slightly modified to check
if the probe request frame is NULL, since it will be for use with
START_AP.
---
 src/ap.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 8681189b..7140e823 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -699,7 +699,7 @@ static size_t ap_write_wsc_ie(struct ap_state *ap,
 	size_t len = 0;
 
 	/* WSC IE */
-	if (type == MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE) {
+	if (type == MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE && client_frame) {
 		const uint8_t *from = client_frame->address_2;
 		struct wsc_probe_response wsc_pr = {};
 		const struct mmpdu_probe_request *req =
@@ -2416,6 +2416,8 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struct ap_state *ap)
 		0xff, 0xff, 0xff, 0xff, 0xff, 0xff
 	};
 
+	static const uint8_t zero_addr[6] = { 0 };
+
 	for (i = 0, nl_ciphers_cnt = 0; i < 8; i++)
 		if (ap->ciphers & (1 << i))
 			nl_ciphers[nl_ciphers_cnt++] =
@@ -2458,6 +2460,21 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struct ap_state *ap)
 	l_genl_msg_append_attr(cmd, NL80211_ATTR_WIPHY_FREQ, 4, &ch_freq);
 	l_genl_msg_append_attr(cmd, NL80211_ATTR_CHANNEL_WIDTH, 4, &ch_width);
 
+	if (wiphy_supports_probe_resp_offload(wiphy)) {
+		uint8_t probe_resp[head_len + tail_len];
+		uint8_t *ptr = probe_resp;
+
+		ptr += ap_build_beacon_pr_head(ap,
+					MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE,
+					zero_addr, ptr, sizeof(probe_resp));
+		ptr += ap_build_beacon_pr_tail(ap,
+					MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE,
+					NULL, 0, ptr);
+
+		l_genl_msg_append_attr(cmd, NL80211_ATTR_PROBE_RESP,
+					ptr - probe_resp, probe_resp);
+	}
+
 	if (wiphy_has_ext_feature(wiphy,
 			NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211)) {
 		l_genl_msg_append_attr(cmd, NL80211_ATTR_SOCKET_OWNER, 0, NULL);
@@ -3321,10 +3338,12 @@ struct ap_state *ap_start(struct netdev *netdev, struct l_settings *config,
 			NULL, 0, ap_reassoc_req_cb, ap, NULL))
 		goto error;
 
-	if (!frame_watch_add(wdev_id, 0, 0x0000 |
+	if (!wiphy_supports_probe_resp_offload(wiphy)) {
+		if (!frame_watch_add(wdev_id, 0, 0x0000 |
 				(MPDU_MANAGEMENT_SUBTYPE_PROBE_REQUEST << 4),
 				NULL, 0, ap_probe_req_cb, ap, NULL))
-		goto error;
+			goto error;
+	}
 
 	if (!frame_watch_add(wdev_id, 0, 0x0000 |
 				(MPDU_MANAGEMENT_SUBTYPE_DISASSOCIATION << 4),
-- 
2.34.3

