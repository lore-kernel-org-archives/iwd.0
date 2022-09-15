Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDEA4C91
	for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 22:07:52 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id a80so10827006pfa.4
        for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 15:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=8sFP2wUffrdzvdYya0knROp5q2bk9q9P+Z4NTzglWLQ=;
        b=gQJMYC7WSVU1Hc61UhuGfgmg8hT2fEfzNbe63YycxK+7lYJNJzbEbuuYo2rHrSHlGT
         Raw456aTtmcm77/xAaRVji/7I2YgRictrEWJiKnw6v+Qo0bNt/lMPjxXrJt4YBf2Y1Da
         DIqN4xf5laBACieZUCmngandCdrG2F+k3wC3INDFIWGzl196QOZIGli2GxFNyIzzQiWG
         TXgCo81KK69bJTuBenReVNzzQ+tRDeb06LUYzrueUiB7I51YnOVmcsdH5Kzfbqteu8Hl
         0VICnBWSAwefROpMnAgdaJ8s41ce9tiEKNhDVG3DprHkaQKYqXNbePhglysjSRm7wUxi
         ENtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=8sFP2wUffrdzvdYya0knROp5q2bk9q9P+Z4NTzglWLQ=;
        b=XzcZdBZZckI8ofrFdGZxcVMVD46ieymXYjWotTfVI13tYSiswJNyQ+tywiIjS54TGi
         /nGZRs571rXfzYVPcM/acKRQ2QWo9ZcAkyUQEo18JzFIa2imtf9LwIYmwrWEmaKH3iW7
         SO3PZEQBruZg0Y4fFJkO0u3kFV92DhOyYDM536ry969z9iUYlBFAxRH29B+MQqS3fcED
         mJtkspcSc88NCp4nxExBwbjl01pUXVWupFgSTxZwW5xWx6axN2nICtccwiRxx7m/WNMf
         Vyhv60Kcbo6ECi4IYQfy8dENRdkIJ5cqlpRQ4BW13fRbs5Rz3yPAnTkTqrmo5TxyPJED
         Yw7w==
X-Gm-Message-State: ACrzQf2b2nhHN+P0tj2nNS9XemdlPW+VwUDXuhPRsEFA8KarPo5pUL+V
	r8thkMSACrPWcXMx6NR/so3sM2aiijU=
X-Google-Smtp-Source: AMsMyM4i7Qt8vGwdC12YcH6hWbizVLwqlGaIxDh1/PM/CjDq+lUtKIhXEBkRmpvdzd6ASAvgn43FwQ==
X-Received: by 2002:a63:20e:0:b0:439:34d7:5e16 with SMTP id 14-20020a63020e000000b0043934d75e16mr1713756pgc.373.1663279672200;
        Thu, 15 Sep 2022 15:07:52 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id k2-20020a6555c2000000b0041c0c9c0072sm12147165pgs.64.2022.09.15.15.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 15:07:51 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 01/14] frame-xchg: add type to frame_xchg_prefix
Date: Thu, 15 Sep 2022 15:07:28 -0700
Message-Id: <20220915220741.1128728-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All uses of frame-xchg were for action frames, and the frame type
was hard coded. Soon other frame types will be needed so the type
must now be specified in the frame_xchg_prefix structure.
---
 src/anqp.c       | 1 +
 src/frame-xchg.c | 2 +-
 src/frame-xchg.h | 1 +
 src/p2p.c        | 4 ++++
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/anqp.c b/src/anqp.c
index 8febdf91..a3c3d7ed 100644
--- a/src/anqp.c
+++ b/src/anqp.c
@@ -156,6 +156,7 @@ static bool anqp_response_frame_event(const struct mmpdu_header *hdr,
 }
 
 static const struct frame_xchg_prefix anqp_frame_prefix = {
+	.frame_type = 0x00d0,
 	.data = (uint8_t []) {
 		0x04, 0x0b,
 	},
diff --git a/src/frame-xchg.c b/src/frame-xchg.c
index 5ba36081..158befd0 100644
--- a/src/frame-xchg.c
+++ b/src/frame-xchg.c
@@ -1193,7 +1193,7 @@ uint32_t frame_xchg_startv(uint64_t wdev_id, struct iovec *frame, uint32_t freq,
 		watch = l_new(struct frame_xchg_watch_data, 1);
 		watch->prefix = prefix;
 		watch->cb = va_arg(resp_args, void *);
-		frame_watch_add(wdev_id, group_id, 0x00d0,
+		frame_watch_add(wdev_id, group_id, prefix->frame_type,
 				prefix->data, prefix->len,
 				frame_xchg_resp_cb, fx, NULL);
 
diff --git a/src/frame-xchg.h b/src/frame-xchg.h
index e3748538..360bb4d4 100644
--- a/src/frame-xchg.h
+++ b/src/frame-xchg.h
@@ -32,6 +32,7 @@ typedef void (*frame_xchg_cb_t)(int err, void *user_data);
 typedef void (*frame_xchg_destroy_func_t)(void *user_data);
 
 struct frame_xchg_prefix {
+	uint16_t frame_type;
 	const uint8_t *data;
 	size_t len;
 };
diff --git a/src/p2p.c b/src/p2p.c
index ff3b8e45..45a1b70b 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -820,6 +820,7 @@ static void p2p_peer_frame_xchg(struct p2p_peer *peer, struct iovec *tx_body,
 
 static const struct frame_xchg_prefix p2p_frame_go_neg_req = {
 	/* Management -> Public Action -> P2P -> GO Negotiation Request */
+	.frame_type = 0x00d0,
 	.data = (uint8_t []) {
 		0x04, 0x09, 0x50, 0x6f, 0x9a, 0x09,
 		P2P_ACTION_GO_NEGOTIATION_REQ
@@ -829,6 +830,7 @@ static const struct frame_xchg_prefix p2p_frame_go_neg_req = {
 
 static const struct frame_xchg_prefix p2p_frame_go_neg_resp = {
 	/* Management -> Public Action -> P2P -> GO Negotiation Response */
+	.frame_type = 0x00d0,
 	.data = (uint8_t []) {
 		0x04, 0x09, 0x50, 0x6f, 0x9a, 0x09,
 		P2P_ACTION_GO_NEGOTIATION_RESP
@@ -838,6 +840,7 @@ static const struct frame_xchg_prefix p2p_frame_go_neg_resp = {
 
 static const struct frame_xchg_prefix p2p_frame_go_neg_confirm = {
 	/* Management -> Public Action -> P2P -> GO Negotiation Confirm */
+	.frame_type = 0x00d0,
 	.data = (uint8_t []) {
 		0x04, 0x09, 0x50, 0x6f, 0x9a, 0x09,
 		P2P_ACTION_GO_NEGOTIATION_CONFIRM
@@ -847,6 +850,7 @@ static const struct frame_xchg_prefix p2p_frame_go_neg_confirm = {
 
 static const struct frame_xchg_prefix p2p_frame_pd_resp = {
 	/* Management -> Public Action -> P2P -> Provision Discovery Response */
+	.frame_type = 0x00d0,
 	.data = (uint8_t []) {
 		0x04, 0x09, 0x50, 0x6f, 0x9a, 0x09,
 		P2P_ACTION_PROVISION_DISCOVERY_RESP
-- 
2.34.3

