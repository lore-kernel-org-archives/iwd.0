Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199F04A02
	for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 18:25:33 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id v23so5399004plo.9
        for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 11:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=8sFP2wUffrdzvdYya0knROp5q2bk9q9P+Z4NTzglWLQ=;
        b=bX22hujOyc4AdM8DBqX1OJDXdWxDl2fCYxmEGszvaiDc4dQXAft/Cmwl1jOpybQr3L
         pB3cumFN8UJOEF2r+hsK4tr5WmmFiT7rRLKgJzoJ6DkknDdEEAcrJ0v2bD/1IbEYQvoI
         RvqCatr0yWOjE3KBodqbTxWSXULk4KsxAZ674nwfokjYruxahcP8njcj4WbLCP4MLHdh
         W7tkXF+oIri9VhDM7uTA2BlekPCkdttbRXITvcYsPEDgsR4nA+eDn/wWEg+NV21PV8be
         FYTlw8b5ZXl1MIbMKDr25MmN0YfEJs1HLAC0wgJVHF9rxGafcfbbnt05KmFeetknKYhh
         DpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=8sFP2wUffrdzvdYya0knROp5q2bk9q9P+Z4NTzglWLQ=;
        b=7f70OHXhG2Zb4nI2eNWnCE3QAxdqgwf95W2jm+UxIfEj3WR/rsOvk8WrtNebRJQMmU
         LRIr5w7OJCtTgrCXv6zBk1mThtF2VwMFw3VI3oKkBrMPpBBMtvesaEYUG8cXqp8CzWud
         SJzaQiFdBIk28DhR/7ooTY1itJVffCh9E2mH6KoNV1cKY6G4VI9I2pNRWW6qbjIH4AuX
         k9E9ivorMH+3zg/tTP7BRMpkhPZk2aLOgNjzL91s3mbR3gnYl1w7zLdLKV59ml1pVxII
         l6FHJiYbD87bjTwYpd8JSnDNeRzGY4Jdy9vTsGrv3Z1AAwyH1jI+u/vQK6hxk+AJc4Y+
         H8pg==
X-Gm-Message-State: ACgBeo0bCHH6Qi2l4zBcymlrvaGBZ+S5FjXYzCNiROOg29sYZboQkXrU
	KDTcGZ56hlPb8/gX7nHqUOypNCwr1jg=
X-Google-Smtp-Source: AA6agR7cEiLw/iFy+mwzvU9oOl7XHt5rdGyblWGawW/iwAUcnu2QRwaZP+DhCmc/CptERwQymye2Zw==
X-Received: by 2002:a17:902:8b87:b0:16f:1bb7:984a with SMTP id ay7-20020a1709028b8700b0016f1bb7984amr20956407plb.113.1661192732355;
        Mon, 22 Aug 2022 11:25:32 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709026f0100b00172bd4c12b2sm1612024plk.224.2022.08.22.11.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:25:32 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/9] frame-xchg: add type to frame_xchg_prefix
Date: Mon, 22 Aug 2022 11:25:17 -0700
Message-Id: <20220822182525.2078312-1-prestwoj@gmail.com>
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

