Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D8533E5
	for <iwd@lists.linux.dev>; Tue, 25 Apr 2023 20:57:07 +0000 (UTC)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-74e3de79bf2so460715385a.2
        for <iwd@lists.linux.dev>; Tue, 25 Apr 2023 13:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682456226; x=1685048226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMd/TsWDWwz5sIh6CNeuw7jaEIAGpTxpYBcrbo4kZb4=;
        b=O6r8d8/MR4HO4/fchAD8GgEjgaULHG60jMGR9I0yAc4AdDQxRdJpdVOD2b6dGfadtC
         WKEu5QGDOLmnCN5z99IKT7s45otYCCGsLL/CzYdsGBV1NFw8XNBtN3MF9v7xADPvKeRw
         aWtRlGo35heEYwLCsrj6toQBKVq5ag6nr8tB+WfIY8deTeHaVmwsGtuOEfSrH0LikQ2A
         2vPE0rrK9wT5AfYP4vt3Vrr5In9kZw3RZA5RoDC/8pdddKbodQ8nYG2Y5keZXq6141oh
         /b03pdfrsn+B0R7hT/wsKEkrXkhA13y4gcUu8N3JjmN8ikVRPyV9g6p/qOD40ygva26Q
         cd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682456226; x=1685048226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMd/TsWDWwz5sIh6CNeuw7jaEIAGpTxpYBcrbo4kZb4=;
        b=D9hGGLXf2OvQiyNi8pJsfKti1z6wi2NuYFpDZlM+Qe7sJtxQuBCA1MzU76fV5QSWTp
         rf7VHugB0hvX8nnVNtboJuZeVJcFHpTW1NSw95XlT49p+QvBGZh9UsfycKuSx1jRCTAj
         4RadPE+Koq892xMd9PRkZUYjD3AWxbdMIZ6pFxtrq2vAmY2NJCpl9ZYAosCdO883Q79R
         U5ONPA51mMa0IY9TFZa7GdBvcnyBIaA/c/OlY5U03uPO6rUnOYpesVwWa7PhwydvU8Pt
         wlUYrPxWpGVu2SyDABE0tX1qEGlC2/XfZPrzj5jMpabKEgOU1kJq9suATt8o6kYIMBIu
         AMSA==
X-Gm-Message-State: AC+VfDzuB6Zfv5kwK9k1mu1Iy1qlItAo2OPU75qK0VTPR+TGWbrPs7Yz
	kC6l2pWD6DeKfd3Rfg64S412r3E9yfU=
X-Google-Smtp-Source: ACHHUZ6I6tHCD2jadaWKwt4hPc/dfJDO1GWKJCd8Hk5S6Z2VXf8aposDjrF2bka0hHrEe+/HvzknnQ==
X-Received: by 2002:a05:6214:29e3:b0:616:5c8b:582 with SMTP id jv3-20020a05621429e300b006165c8b0582mr103334qvb.37.1682456226424;
        Tue, 25 Apr 2023 13:57:06 -0700 (PDT)
Received: from LOCLAP699.geodis-coppell.locus ([208.216.218.212])
        by smtp.gmail.com with ESMTPSA id y17-20020a0ce051000000b005dd8b9345b9sm4347799qvk.81.2023.04.25.13.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 13:57:06 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] dpp: fix incorrect offchannel usage as configurator
Date: Tue, 25 Apr 2023 13:57:00 -0700
Message-Id: <20230425205700.36822-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When acting as a configurator the enrollee can start on a different
channel than IWD is connected to. IWD will begin the auth process
on this channel but tell the enrollee to transition to the current
channel after the auth request. Since a configurator must be
connected (a requirement IWD enforces) we can assume a channel
transition will always be to the currently connected channel. This
allows us to simply cancel the offchannel request and wait for a
response (rather than start another offchannel).

Doing this improves the DPP performance and reduces the potential
for a lost frame during the channel transition.

This patch also addresses the comment that we should wait for the
auth request ACK before canceling the offchannel. Now a flag is
set and IWD will cancel the offchannel once the ACK is received.
---
 src/dpp.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 6abf539a..b1f4893e 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -147,6 +147,7 @@ struct dpp_sm {
 
 	bool mcast_support : 1;
 	bool roc_started : 1;
+	bool channel_switch : 1;
 };
 
 static bool dpp_get_started(struct l_dbus *dbus,
@@ -2032,6 +2033,7 @@ static void authenticate_response(struct dpp_sm *dpp, const uint8_t *from,
 		return;
 	}
 
+	dpp->channel_switch = false;
 	dpp->current_freq = dpp->new_freq;
 
 	dpp_send_authenticate_confirm(dpp);
@@ -2112,10 +2114,14 @@ static void dpp_handle_presence_announcement(struct dpp_sm *dpp,
 		return;
 
 	/*
-	 * Should we wait for an ACK then go offchannel?
+	 * Requested the peer to move to another channel for the remainder of
+	 * the protocol. IWD's current logic prohibits a configurator from
+	 * running while not connected, so we can assume here that the new
+	 * frequency is the same of the connected BSS. Wait until an ACK is
+	 * received for the auth request then cancel the offchannel request.
 	 */
 	if (dpp->current_freq != dpp->new_freq)
-		dpp_start_offchannel(dpp, dpp->new_freq);
+		dpp->channel_switch = true;
 }
 
 static void dpp_handle_frame(struct dpp_sm *dpp,
@@ -2211,12 +2217,32 @@ static void dpp_mlme_notify(struct l_genl_msg *msg, void *user_data)
 	if (dpp->state <= DPP_STATE_PRESENCE)
 		return;
 
+
+	if (dpp->frame_cookie != cookie)
+		return;
+
 	/*
-	 * Only want to handle the no-ACK case. Re-transmitting an ACKed
-	 * frame likely wont do any good, at least in the case of DPP.
+	 * Special handling for a channel transition when acting as a
+	 * configurator. The auth request was sent offchannel so we need to
+	 * wait for the ACK before going back to the connected channel.
 	 */
-	if (dpp->frame_cookie != cookie || ack)
+	if (dpp->channel_switch && ack) {
+		if (dpp->offchannel_id) {
+			offchannel_cancel(dpp->wdev_id, dpp->offchannel_id);
+			dpp->offchannel_id = 0;
+		}
+
+		dpp->channel_switch = false;
+
 		return;
+	} else if (ack)
+		/*
+		 * Only want to handle the no-ACK case. Re-transmitting an ACKed
+		 * frame likely wont do any good, at least in the case of DPP.
+		 */
+		return;
+
+
 
 	if (dpp->frame_retry > DPP_FRAME_MAX_RETRIES) {
 		dpp_reset(dpp);
-- 
2.25.1

