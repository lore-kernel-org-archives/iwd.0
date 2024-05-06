Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACABB5CB0
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 00:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956676; cv=none; b=S1+/s20mD/hieaUkHoRZmw8LB3YgHM+MZth0jJ8EwR39wZAbLyjyHVAAnvd0rhwBts6pII8c/HekdgHYZ+P0k9wNbGojK/NMpkJ/90b84jcM929DmpcFwe0vmoamjuo4wZJnEms6vnUl6x0EvDQHrJ+BTELnrXsQtoz4uQGTmxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956676; c=relaxed/simple;
	bh=g13A95xIBuvnuaDLoK6acafqHx9DsXHsiO9kPwfiOmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2Hl+16x20WCJIv8M4hJHv12jkEjPwY/4NmBDewS39QFEO5BFuFB7+qqAPFGHBuytUS/Ae8uvwCeNZnDRCPbMCALJgCVBYS/diOxTPuY5sgVvILEaOGUFspoqAw2mVP0EK0Xhbh5f+A8gNhnq4/aJKL2UtrOWKEugEz10f+Njs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFRZlf4z; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFRZlf4z"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f30f69a958so805759b3a.1
        for <iwd@lists.linux.dev>; Sun, 05 May 2024 17:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714956674; x=1715561474; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8p6aGW2BhpL/FR3VvsYOv36Uqn0LWX592NCfsKCEaCo=;
        b=ZFRZlf4zfzW7Kh2GUBBtm9u8E7dTkvABdGM7f53WbX+NeeHACZu3xVk+TVdrIKHdZk
         pBsCkQygt3lDtC1MZF6qZbA6rN1hQucsO4mS/236s3c/e4OAzvWU5RX2IaQUI6qSTxXp
         JxIelQomjhYSB2fyAiXuRiL9AcDrcPjOuEDZ03KziN/y7FI5L4p5xQKOyfJlQBBq2cUo
         Gis2wV/PDXIMW5Xalz1XQRP62asJlirGwSUsx0gU1Q324C4ugazxrCxUxG8+v6NTt8z9
         ETuOwh7f4iP6PXv8RqYTCyosOo3bWSizU6LKiL8iObA7YYgYKSib3BEkARpH/ZUXgZch
         4bJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714956674; x=1715561474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8p6aGW2BhpL/FR3VvsYOv36Uqn0LWX592NCfsKCEaCo=;
        b=E0fCx+ZLXt21EGckvnVM7bH4GA9DS3xOnUxl2oF40YrmcDoL0UtFqjS9MJBtXPc+9V
         kLhXApSxjzfqPny4pTTf1F9+3Lzr8aG2xi8r5lmfqzx15Za9U74PC+SSLTJaAYrlgJ14
         gDrDhLT818yCYpXkhDyxZD43phFYL7TL+xLOMqmR2Wf3RHgimI2880Z8RvJDbXS3lLSL
         Y2NEer70150VVKUOwFCYgYQbRA6lJclAxf1HJezfvje2AqLjF+PB2mvWwCoRu9vT7iaY
         ZGUJE+/XZ1LNCOJjgxwiYhSg+gr21bK7oA6+k4+3/7+73HVwcHaxHiDWrULrngs13Ass
         naEA==
X-Gm-Message-State: AOJu0YxrRD1bP23hGcjh0zpRlPGa/A30q89Pk/dcFaZQyCOastR1NBrh
	9UDzGYpF1Fu9DkfTWKmz/xPxRHMq/Q+nfhS2MkImEhxaomsevIjHYGT9yw==
X-Google-Smtp-Source: AGHT+IHshjHc9BqrdZtgCCyZiDCmncs62X86iidhuCdPMfuJPuPUWiqueYAgnyuhfYicL7EmSxvOkw==
X-Received: by 2002:a05:6a21:6d99:b0:1a7:a72c:6f4 with SMTP id wl25-20020a056a216d9900b001a7a72c06f4mr9685679pzb.41.1714956673706;
        Sun, 05 May 2024 17:51:13 -0700 (PDT)
Received: from localhost ([192.145.118.41])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902e5cf00b001e223b9eb25sm7024531plf.153.2024.05.05.17.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 17:51:13 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH v2 18/18] ap: propogate IGTK and RSC to handshake
Date: Sun,  5 May 2024 17:30:41 -0700
Message-ID: <20240506003518.320176-19-brandtwjohn@gmail.com>
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

When a client is connecting, remember whether it supports MFP, and if
so, propogate the IGTK to the handshake. Also get the current Receive
Sequence Counter (RSC) of the IGTK and propogate it to the handshake.
---
 src/ap.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index f598c173..c7ca49e8 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -144,6 +144,7 @@ struct sta_state {
 	struct eapol_sm *sm;
 	struct handshake_state *hs;
 	uint32_t gtk_query_cmd_id;
+	uint8_t prev_igtk_rsc[6];
 	struct l_idle *stop_handshake_work;
 	struct l_settings *wsc_settings;
 	uint8_t wsc_uuid_e[16];
@@ -154,6 +155,7 @@ struct sta_state {
 
 	bool ht_support : 1;
 	bool ht_greenfield : 1;
+	bool mfp : 1;
 };
 
 struct ap_wsc_pbc_probe_record {
@@ -1379,7 +1381,7 @@ static uint32_t ap_send_mgmt_frame(struct ap_state *ap,
 	}))
 
 static void ap_start_handshake(struct sta_state *sta, bool use_eapol_start,
-				const uint8_t *gtk_rsc)
+				const uint8_t *gtk_rsc, const uint8_t *igtk_rsc)
 {
 	struct ap_state *ap = sta->ap;
 	const uint8_t *own_addr = netdev_get_address(ap->netdev);
@@ -1401,6 +1403,9 @@ static void ap_start_handshake(struct sta_state *sta, bool use_eapol_start,
 	if (gtk_rsc)
 		handshake_state_set_gtk(sta->hs, sta->ap->gtk,
 					sta->ap->gtk_index, gtk_rsc);
+	if (sta->mfp && igtk_rsc)
+		handshake_state_set_igtk(sta->hs, sta->ap->igtk,
+					 sta->ap->igtk_index, igtk_rsc);
 
 	if (ap->netconfig_dhcp)
 		sta->hs->support_ip_allocation = true;
@@ -1506,7 +1511,8 @@ static void ap_handshake_event(struct handshake_state *hs,
 	va_end(args);
 }
 
-static void ap_start_rsna(struct sta_state *sta, const uint8_t *gtk_rsc)
+static void ap_start_rsna(struct sta_state *sta, const uint8_t *gtk_rsc,
+			  const uint8_t *igtk_rsc)
 {
 	/* this handshake setup assumes SAE or PSK network */
 	if (sta->hs && sta->akm_suite == IE_RSN_AKM_SUITE_SAE_SHA256) {
@@ -1521,7 +1527,7 @@ static void ap_start_rsna(struct sta_state *sta, const uint8_t *gtk_rsc)
 	handshake_state_set_event_func(sta->hs, ap_handshake_event, sta);
 	handshake_state_set_supplicant_ie(sta->hs, sta->assoc_rsne);
 
-	ap_start_handshake(sta, false, gtk_rsc);
+	ap_start_handshake(sta, false, gtk_rsc, igtk_rsc);
 }
 
 static void ap_gtk_query_cb(struct l_genl_msg *msg, void *user_data)
@@ -1546,13 +1552,48 @@ zero_rsc:
 		gtk_rsc = zero_gtk_rsc;
 	}
 
-	ap_start_rsna(sta, gtk_rsc);
+	ap_start_rsna(sta, gtk_rsc, sta->prev_igtk_rsc);
 	return;
 
 error:
 	ap_del_station(sta, MMPDU_REASON_CODE_UNSPECIFIED, true);
 }
 
+static void ap_igtk_query_cb(struct l_genl_msg *msg, void *user_data)
+{
+	struct sta_state *sta = user_data;
+	struct ap_state *ap = sta->ap;
+
+	const void *igtk_rsc;
+	uint8_t zero_igtk_rsc[6];
+	int err;
+
+	sta->gtk_query_cmd_id = 0;
+
+	err = l_genl_msg_get_error(msg);
+	if (err == -ENOTSUP)
+		goto zero_rsc;
+	else if (err < 0)
+		return;
+
+	igtk_rsc = nl80211_parse_get_key_seq(msg);
+	if (!igtk_rsc) {
+zero_rsc:
+		memset(zero_igtk_rsc, 0, 6);
+		igtk_rsc = zero_igtk_rsc;
+	}
+
+	memcpy(sta->prev_igtk_rsc, igtk_rsc, 6);
+
+	msg = nl80211_build_get_key(netdev_get_ifindex(ap->netdev),
+				    ap->gtk_index);
+	sta->gtk_query_cmd_id = l_genl_family_send(ap->nl80211, msg, ap_gtk_query_cb, sta, NULL);
+	if (!sta->gtk_query_cmd_id) {
+		l_genl_msg_unref(msg);
+		l_error("Issuing GET_KEY failed");
+	}
+}
+
 static void ap_stop_handshake_schedule(struct sta_state *sta)
 {
 	if (sta->stop_handshake_work)
@@ -1656,7 +1697,7 @@ static void ap_start_eap_wsc(struct sta_state *sta)
 	handshake_state_set_event_func(sta->hs, ap_wsc_handshake_event, sta);
 	handshake_state_set_8021x_config(sta->hs, sta->wsc_settings);
 
-	ap_start_handshake(sta, wait_for_eapol_start, NULL);
+	ap_start_handshake(sta, wait_for_eapol_start, NULL, NULL);
 }
 
 static struct l_genl_msg *ap_build_cmd_del_key(struct ap_state *ap, uint8_t index)
@@ -1834,13 +1875,13 @@ static void ap_associate_sta_cb(struct l_genl_msg *msg, void *user_data)
 	}
 
 	if (ap->group_cipher == IE_RSN_CIPHER_SUITE_NO_GROUP_TRAFFIC)
-		ap_start_rsna(sta, NULL);
+		ap_start_rsna(sta, NULL, NULL);
 	else {
 		msg = nl80211_build_get_key(netdev_get_ifindex(ap->netdev),
-					ap->gtk_index);
+					    sta->mfp ? ap->igtk_index : ap->gtk_index);
 		sta->gtk_query_cmd_id = l_genl_family_send(ap->nl80211, msg,
-								ap_gtk_query_cb,
-								sta, NULL);
+							   sta->mfp ? ap_igtk_query_cb : ap_gtk_query_cb,
+							   sta, NULL);
 		if (!sta->gtk_query_cmd_id) {
 			l_genl_msg_unref(msg);
 			l_error("Issuing GET_KEY failed");
@@ -2315,6 +2356,8 @@ static void ap_assoc_reassoc(struct sta_state *sta, bool reassoc,
 			err = MMPDU_REASON_CODE_INVALID_GROUP_CIPHER;
 			goto unsupported;
 		}
+
+		sta->mfp = rsn_info.mfpc && ap->mfpc;
 	}
 
 	/* 802.11-2016 11.3.5.3 j) */
-- 
2.45.0

