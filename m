Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2921C3A
	for <iwd@lists.linux.dev>; Wed, 24 Aug 2022 22:55:25 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id 202so16280374pgc.8
        for <iwd@lists.linux.dev>; Wed, 24 Aug 2022 15:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=8sFP2wUffrdzvdYya0knROp5q2bk9q9P+Z4NTzglWLQ=;
        b=CMTGUaZKLcv9E0mSCn3uCgMK3UUHFDR8R8k0nYWdx2zqYxmoIPox+29uJy7b/DbmH5
         Suzojcz1fb35b3mCRnuiRTWd+4H8BlVpdvLR2cgQypK5lRWxn7EX8//m9WWgl8U7Rwyt
         mk7jlMGxElwFfPZ7O+LCbCvJFZF+0ZQVlSikhCkwegfMtRVwnqcPPrU+bWS5cY90IbGe
         kcDTMa4QTb00S3v0qSvgLN6lP7njxUsQkhSFBYCx+BIEQRxnXIW+E8o19rLPVOWJlErp
         XDIJrLdULEwisjj7WEvV+pUmNIU+ZR6YhNZM8Y5YQvb5ZDbluYmqBp8fKdbjj2zkO177
         OXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=8sFP2wUffrdzvdYya0knROp5q2bk9q9P+Z4NTzglWLQ=;
        b=ejkHjhSb9R+6DRUU4uFUXXtl0rHct/hijyAbkWaVTSBVjmJvXwfu5K0tKFTN8J5yyK
         jf/YzCdhcRDixHaQXJzIWbd9oFsN0HF8Ex3FGfbq6Bd9wqJABfO9Bz1EnZk1GeXldvtn
         naQJBDVnt9laHIzaOXC8IjMbK8JUuWAjWn2hg1jVlTHGE4rxkxMh/mpDfDkX5YPvy4ju
         bVqGjdvaugN0iuPdozEbPpscWXPpvTc7Wafj1HPquW5YzVVBTJPDBYTN1qAidB87aCtC
         w04LhPnCa1UGZvOTTno5b3pRxx43r8OgEHv23AmQ0IY7OzAg3nYlvFo1tAKoQP13mFFO
         eXMA==
X-Gm-Message-State: ACgBeo3vrEbI2XW9/bMQW8me0ekihRy2U6meJy2iQs+jwLUrzk3RLzzw
	/KLgDdLgQSmvU/UPnGQ0xC7KadZnCFs=
X-Google-Smtp-Source: AA6agR6pdO4Hc7fxjkS4TqogqwKpgERO5aNzASMf52WlgrSNwlaqEA/LuuIMqafwUwX4CaN9g8TCbQ==
X-Received: by 2002:a63:1e48:0:b0:429:e6ee:780d with SMTP id p8-20020a631e48000000b00429e6ee780dmr835483pgm.383.1661381724808;
        Wed, 24 Aug 2022 15:55:24 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id jn22-20020a170903051600b0016bcc35000asm6228682plb.302.2022.08.24.15.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 15:55:24 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/9] frame-xchg: add type to frame_xchg_prefix
Date: Wed, 24 Aug 2022 15:55:10 -0700
Message-Id: <20220824225518.2558698-1-prestwoj@gmail.com>
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

