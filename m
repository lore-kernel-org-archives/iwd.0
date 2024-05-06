Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4859A936
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 00:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956559; cv=none; b=D61fOmxzCsoOCzMS+3/H7OuHmJKhigfrHiEIb4MawrHxfR5lAs+yr4XXMzTdxjIiBVIf7DTLXIgpXqSuM3p0Q+xDpX9KHH5gUNFMOCHpwi4pL8GrRzoVwZmyb2P3PawHDHh0Nicy6b+o1/CeZwmbVI6yJoKbMzrxZtk7iHS9ODw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956559; c=relaxed/simple;
	bh=fVD87+qvQU2HsRwaGcnyMqcn/S+4DS4birRdDhUq2a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCMMNfjU0XVkowlqpYNbYCTDE5mSSeSQQk+QQ9Xe9Yzy2KsxeCeeEuk1B06XkEEMfjCb/mgTN6fjYrWPg49nSEHmroXWNdnYZNjxkzoQsrCNTWxsqxPoeZtNpuqrz7orOgELycAGInRl+7JJQsWljpDkrn/Immr3t4AZ1P7FRyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4V6QcfR; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4V6QcfR"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2b4952a1b51so1046372a91.0
        for <iwd@lists.linux.dev>; Sun, 05 May 2024 17:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714956557; x=1715561357; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7M+EmCbakxU9OFzT4Nayb2gd4JGR7jTTVLjzWXJUAl0=;
        b=l4V6QcfRTZuizoE/iXLC93PlLytqO2Us0ReY3P46V0IAW5aNTDkKR0XE3zNS1P9KbL
         9FCDbJvlv3Manwo1habdVuV9+9BZ3Yu84QB+hz3Hvz2SKaYp99TRHd5yMUpHbT0Lvxdb
         O+9uN7HWnkjZMTgtuIlUpccWQ2sg0haDwWl3Qt/3frsqsoJMowwX4H0G4yHPKYK3mRNd
         ABmqT+dyWk78xiss+UQDkj0cPklSGrRzQrHLDU4Avgzu+KkZDNbwvTHfdbSufnirp8QG
         zv5ALJxwQUjURWDDQ4qxhkrWmcletD9cKwQYIGoX1tifB8gxPzGo/KB794axIQGvrD0s
         VOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714956557; x=1715561357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7M+EmCbakxU9OFzT4Nayb2gd4JGR7jTTVLjzWXJUAl0=;
        b=cx80nqo0Yuba6Bp3dJsNAgI3gbaT8LLa4GtSvQ7N3wXNX6GlF2Q9NbR03JheLAVS9f
         k4vekXtBm/uUu7g+H6o2gaDdG2ivJ4yN4xVZyEWUd+ZAnfIZmJADrdXt40o2+GpibYqa
         zfQIaasU6EqBOGkJLvYzljEZTJrc3TUj3d2mOlHvTORdhj/duFk5jaRfu3qNJFPy8PQ7
         QVckfYKP2Ffb1KmRedZsWaaLMSHW7Ida2KBOklDJrFiVMIRCYQcT9OaimlykIr/pMQY6
         ENq9gEzrJwkcUazDRFSqBjMHy3kLNdyLcVhq5a3NlIsNagGskmUucEpeKNrfcFsbSDTv
         gMhg==
X-Gm-Message-State: AOJu0YyzPCYk9PMM9i4i2yArC4NB6bXu1CM0rztg5dHC7RtMSl6G8LOk
	874zIAGfDHtZVaIexg2PdWPE9XWtF3IA7edYRR8nd9TWXx9ceqWJ4oOSdw==
X-Google-Smtp-Source: AGHT+IEKRTuvzWPNeDz1fpYlvVFprd5kzXJnuuvzkSBYTryigZ0mEgLSRiiCDN3PVO4sXmMIWsw9hA==
X-Received: by 2002:a17:90a:bb81:b0:2b5:1f7d:7eae with SMTP id v1-20020a17090abb8100b002b51f7d7eaemr1132286pjr.24.1714956557026;
        Sun, 05 May 2024 17:49:17 -0700 (PDT)
Received: from localhost ([192.145.118.41])
        by smtp.gmail.com with ESMTPSA id q8-20020a17090a064800b002ae2579ffeesm7654469pje.19.2024.05.05.17.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 17:49:16 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH v2 09/18] ap: add support to handle SAE authentication
Date: Sun,  5 May 2024 17:30:32 -0700
Message-ID: <20240506003518.320176-10-brandtwjohn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506003518.320176-1-brandtwjohn@gmail.com>
References: <20240506003518.320176-1-brandtwjohn@gmail.com>
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
 src/ap.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index cd253ce3..ec27180e 100644
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
@@ -2595,6 +2598,38 @@ static void ap_auth_reply(struct ap_state *ap, const uint8_t *dest,
 				ap_auth_reply_cb, NULL);
 }
 
+static void sae_auth_reply(const uint8_t *data, size_t len, void *user_data)
+{
+	struct sta_state *sta = (struct sta_state *)user_data;
+	struct ap_state *ap = (struct ap_state *)sta->ap;
+	const uint8_t *addr = netdev_get_address(ap->netdev);
+	uint8_t sae_buf[512];
+	struct mmpdu_header *mpdu = (struct mmpdu_header *) sae_buf;
+	struct mmpdu_authentication *auth;
+
+	if (L_WARN_ON(26 + len > sizeof(sae_buf)))
+		return;
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
@@ -2665,7 +2700,7 @@ static void ap_auth_cb(const struct mmpdu_header *hdr, const void *body,
 	 * than State 1."
 	 */
 	if (sta)
-		goto done;
+		goto have_sta;
 
 	/*
 	 * Per 12.3.3.2.3 with Open System the state change is immediate,
@@ -2680,18 +2715,32 @@ static void ap_auth_cb(const struct mmpdu_header *hdr, const void *body,
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
2.45.0

