Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB8B13FFC
	for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713704039; cv=none; b=GUVNRORUpbXIqZ0No/ctOCGg9p+mqMMjD4Mum6J5N1UA17FDtzdpyASrKfvls9lZZ8OvPxgaVPZwAj11ufCsfYvWitLYXNcmbK/XX9S4/qnq2ZXkN6eXcErbzFfAdwIaEfeAhMgnYoCNdYP63BKZJr6SHswA8vPWJSsHZC2WnYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713704039; c=relaxed/simple;
	bh=yCmx85wBVN/7EiI+ez6K2mx5NWXkfMYkMnIgjaEM2sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uemI7bv4ONVFpZMKYXrZ/RH5FmP48uPA0tF8rLp2Pu2P3vNgxfLEOfBwJx3t0DkvB+nPws+CAuIZ4kiPR3dAuJfaVC0S+mqSYuiqsTFMyYJanTCS9tYIQmcnSOHnnC/QNQ1NZ3d+ouTAYe3hoS4wA+L+wG7qi9FlNpmiPoWUU2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEHKPzhF; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEHKPzhF"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-222a9eae9a7so1884765fac.3
        for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 05:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713704037; x=1714308837; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndBxbfX4iSMh44sy1SZlErIMMSFuRVM7SNywOFhVQv4=;
        b=fEHKPzhFAoq1mzIfJEjGAISinS1Ir3MOl63+nfkQ7NYSCva31sU2D+m8vEQnttD+iV
         rw+UABJ1/vN6CQlscvaalX7CBkCxiBsfuxLhxJ9E4JNjegtEjBaNlanl80VsLYy+A1xw
         9Ks5iKoAOklly8IMpgZTv2+1kj1b7/sTNh/JYdrzdnAv6qOgwgTrdUO/Tc6DLTipXRen
         xejBhXe4mXai9E/xrgoGihmPunUIUSeoYSJpWWocZWbi66AVHoN5+LKxlF/m/19wt621
         ofTOEA1Lrg0sAhAkJ43xugrgLiDmt3Fn877p7KaxirYyzJcbKPq3htyDH1oNz8ccvvkq
         xZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713704037; x=1714308837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndBxbfX4iSMh44sy1SZlErIMMSFuRVM7SNywOFhVQv4=;
        b=fgFtnzBiIKLnLUxBWxWD0jbJ30xTA4vm/mLxIRbI3c6wd7di3/TXxfGEFFJtqC99Qy
         2RX1el3ditju2ESxmhCYxyOBZOwTBYY9dRmK2ELe0ll7YXVS2sugsSQR+qWKcjOtBQIt
         rRaDUk5McMW+2xVhHGkKzkafeeM3G2VEzGc2LvOQIVEh+N/LEr9Ixict5vr5+OppdgxQ
         00RMNNNXkzzfQQuIlT7UhEoCybfC8munniB3e75BZGbBc/0b9E3+tuMd76POz9RfC3q+
         pRhK05mhg2tX1OTM7M4g7iNsascvX4AmWu5MYBjt+ZUZ+DoBHTdZT1xeAgJIHCxf83vd
         RMDA==
X-Gm-Message-State: AOJu0YzYhUE4qsHhBgqXU+TJrinS8YRZtbG3+7A1w4uNp4xkOUnriPrm
	nIE9s0KSTtQu7wc8GMElbJ/0hHmy5TKGeDmqACaOPiMvh53rmiwsmRxO/NNr9fk=
X-Google-Smtp-Source: AGHT+IH0Fh/7ZKKOgDIt5mNir9tQSwbzR4uFX5s5YZQPZx6vwzu9LFRjFHwkPTiFYNTV0auDcJu9jw==
X-Received: by 2002:a05:6870:2252:b0:229:a47f:72cc with SMTP id j18-20020a056870225200b00229a47f72ccmr9559953oaf.38.1713704037380;
        Sun, 21 Apr 2024 05:53:57 -0700 (PDT)
Received: from localhost ([185.169.0.163])
        by smtp.gmail.com with ESMTPSA id d16-20020a056a0010d000b006ed36f2c0dcsm6312549pfu.90.2024.04.21.05.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 05:53:57 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH 08/11] ap: add support to handle SAE authentication
Date: Sun, 21 Apr 2024 05:50:38 -0700
Message-ID: <20240421125050.6649-9-brandtwjohn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240421125050.6649-1-brandtwjohn@gmail.com>
References: <20240421125050.6649-1-brandtwjohn@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the client requests SAE authentication, and it is enabled, allocate
an auth_proto instance to handle SAE authentication. This also adds a
new function to send SAE frames in AP mode that can be used by the
auth_proto instance.
---
 src/ap.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 9 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 14268551..ab0cbdcd 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -59,6 +59,8 @@
 #include "src/diagnostic.h"
 #include "src/band.h"
 #include "src/common.h"
+#include "src/sae.h"
+#include "src/auth-proto.h"
 
 struct ap_state {
 	struct netdev *netdev;
@@ -132,6 +134,7 @@ struct sta_state {
 	uint8_t *assoc_ies;
 	size_t assoc_ies_len;
 	uint8_t *assoc_rsne;
+	struct auth_proto *auth_proto;
 	enum ie_rsn_akm_suite akm_suite;
 	struct eapol_sm *sm;
 	struct handshake_state *hs;
@@ -2595,6 +2598,35 @@ static void ap_auth_reply(struct ap_state *ap, const uint8_t *dest,
 				ap_auth_reply_cb, NULL);
 }
 
+static void sae_auth_reply(const uint8_t *data, size_t len, void *user_data)
+{
+	struct sta_state *sta = (struct sta_state *)user_data;
+	struct ap_state *ap = (struct ap_state *)sta->ap;
+	const uint8_t *addr = netdev_get_address(ap->netdev);
+	uint8_t sae_buf[2048];
+	struct mmpdu_header *mpdu = (struct mmpdu_header *) sae_buf;
+	struct mmpdu_authentication *auth;
+
+	memset(mpdu, 0, sizeof(*mpdu));
+
+	/* Header */
+	mpdu->fc.protocol_version = 0;
+	mpdu->fc.type = MPDU_TYPE_MANAGEMENT;
+	mpdu->fc.subtype = MPDU_MANAGEMENT_SUBTYPE_AUTHENTICATION;
+	memcpy(mpdu->address_1, sta->addr, 6);	/* DA */
+	memcpy(mpdu->address_2, addr, 6);	/* SA */
+	memcpy(mpdu->address_3, addr, 6);	/* BSSID */
+
+	/* Authentication body */
+	auth = (void *) mmpdu_body(mpdu);
+	auth->algorithm = L_CPU_TO_LE16(MMPDU_AUTH_ALGO_SAE);
+
+	/* SAE elements */
+	memcpy(sae_buf + 26, data, len);
+	ap_send_mgmt_frame(ap, mpdu, 26 + len,
+				ap_auth_reply_cb, NULL);
+}
+
 /*
  * 802.11-2016 9.3.3.12 (frame format), 802.11-2016 11.3.4.3 and
  * 802.11-2016 12.3.3.2 (MLME/SME)
@@ -2664,7 +2696,7 @@ static void ap_auth_cb(const struct mmpdu_header *hdr, const void *body,
 	 * than State 1."
 	 */
 	if (sta)
-		goto done;
+		goto have_sta;
 
 	/*
 	 * Per 12.3.3.2.3 with Open System the state change is immediate,
@@ -2679,18 +2711,32 @@ static void ap_auth_cb(const struct mmpdu_header *hdr, const void *body,
 		ap->sta_states = l_queue_new();
 
 	sta->akm_suite = akm_suite;
+	if (sta->akm_suite == IE_RSN_AKM_SUITE_SAE_SHA256) {
+		sta->hs = netdev_handshake_state_new(sta->ap->netdev);
+		handshake_state_set_authenticator(sta->hs, true);
+		handshake_state_set_passphrase(sta->hs, ap->passphrase);
+		handshake_state_set_supplicant_address(sta->hs, sta->addr);
+		handshake_state_set_authenticator_address(sta->hs, bssid);
+
+		sta->auth_proto = sae_sm_new(sta->hs, sae_auth_reply, NULL, sta);
+	}
 
 	l_queue_push_tail(ap->sta_states, sta);
 
-	/*
-	 * Nothing to do here netlink-wise as we can't receive any data
-	 * frames until after association anyway.  We do need to add a
-	 * timeout for the authentication and possibly the kernel could
-	 * handle that if we registered the STA with NEW_STATION now (TODO)
-	 */
 
-done:
-	ap_auth_reply(ap, from, 0);
+have_sta:
+	if (sta->akm_suite == IE_RSN_AKM_SUITE_SAE_SHA256) {
+		auth_proto_rx_authenticate(sta->auth_proto, (const uint8_t *)hdr,
+					   body + body_len - (void *) hdr);
+	} else {
+		/*
+		 * Nothing to do here netlink-wise as we can't receive any data
+		 * frames until after association anyway.  We do need to add a
+		 * timeout for the authentication and possibly the kernel could
+		 * handle that if we registered the STA with NEW_STATION now (TODO)
+		 */
+		ap_auth_reply(ap, from, 0);
+	}
 }
 
 /* 802.11-2016 9.3.3.13 (frame format), 802.11-2016 11.3.4.5 (MLME/SME) */
-- 
2.44.0

