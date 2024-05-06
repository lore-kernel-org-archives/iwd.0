Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F846182DA
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956612; cv=none; b=UbSx78bNIRMhkzuC5zVK6Nt6rxXmhoxChVIxjhf6IbSPFU+MhT7gyNazEpLAizfiDU+v+syzLhOZNh6V1fTRlqyrf27+tFxuJ69xmwa7ezfEnyNealEduE2F/A1sXO8HVQT+AwQtGvQkfYeMhi2LqthdvOwIqeD1bFKugVt6P8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956612; c=relaxed/simple;
	bh=wLZ20aAvwxqooNqKINzsGpjS+1yMxQi6jW3Bx/oZZL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+QuoI3IdOkVhexKMA/6goWKs5aS00t4W1J/J/cKgxztfO3H+Gysdz9oRpvDNIbClW+RaBB2gArA7JMRpnSw1nJhprUQ6U1zHObXvf9o/j86KhoW/OSnuxmlZJIa1IbbR1Es7JU4ElCavLG5s9TtQNiQhL5scE+amz4D8/Ss/9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQsSJCIV; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQsSJCIV"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f30f69a958so805273b3a.1
        for <iwd@lists.linux.dev>; Sun, 05 May 2024 17:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714956610; x=1715561410; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nNm6WDmFWUrK7tEKHQFGw9/TWYHnwuyyFKXj5Lrdkg=;
        b=lQsSJCIVzKDvp/D8u+r6tEual1NRnx/v820bg1eSEamqiLwn100/+Y8msGU021kvz4
         /lXGZ8OKXZBKu9y9y5n5IoP6BHXDIShqwTpdzM75MVBUhijBeWpaOWTFADREIp7pMkpE
         nVClle5qY39WYeyokx0Ficr+11OR9hjV6QEQRO3Hm83owS7niOLtGUJYMfCRvv5eZrUU
         r42SDZ8Z86lN2uW7o/sPbEqM+v+gYKc5lE5horW1f+N2kduLynveCFh+X5kguSX1rgLC
         054AzTDgfx5s0HkePMmQlHK7ntekUZyhbjap6oYUW+gGCpCGvM9QKMNGFKE/8gFnrZi1
         uRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714956610; x=1715561410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nNm6WDmFWUrK7tEKHQFGw9/TWYHnwuyyFKXj5Lrdkg=;
        b=hmUMGmnzBEmYo3PWli70gmN4qTvDDJhOxLeZFB0y/j/LcEfLWy8O9msj4yf8ZlOtJT
         9BoDTSdnXRn0mIFs33qnZwvmL7nLFcnf8UUvkg8saRr4gWcO/WHbjToUQqVAf0vS9e7W
         7DweRn92Y4l/ZEgNiZQ0tJ8I7NheM0EJqYZdCp3u5kW/hOgbD9Z/wL150n22BYRyl8oe
         FL9SNv/jxemAHwq0gce6pHyktU/VHS3uiu+EqypsZiOxtS+wLHHgvcbfk+99UUy6yl6X
         im2upN2fObiWaAr4vFmQbIawwaisVWZ+Xm80WM6emShNe7tkK4viNLpdVLsZxj0znAiS
         MA4A==
X-Gm-Message-State: AOJu0YxqeAUQ6jlTE28OFjNfWGUiGf0JqwEWQIH/tc+4a0gCJWQno58U
	VZnkXj8rLPm2CuXCIY2EDWp/VrrwDwrAMgbHLzQAdY+BCC9AqUd23+r8ow==
X-Google-Smtp-Source: AGHT+IHXiGymzWPLdPahFpAncra7OxwKeL4nCLcw+5Yzjr9C4ACztG4VQey0cPEY0+01cAqM2PcOEA==
X-Received: by 2002:a05:6a00:2185:b0:6ed:4f2e:ef22 with SMTP id h5-20020a056a00218500b006ed4f2eef22mr9868759pfi.31.1714956610498;
        Sun, 05 May 2024 17:50:10 -0700 (PDT)
Received: from localhost ([192.145.118.41])
        by smtp.gmail.com with ESMTPSA id w11-20020aa7858b000000b006efd89cea71sm6586879pfn.84.2024.05.05.17.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 17:50:10 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH v2 13/18] unit: add unit test for SAE AP mode
Date: Sun,  5 May 2024 17:30:36 -0700
Message-ID: <20240506003518.320176-14-brandtwjohn@gmail.com>
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

Add unit test that simulates client and AP in SAE handshake. Test that
both the client and AP complete the SAE handshake.
---
 unit/test-sae.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/unit/test-sae.c b/unit/test-sae.c
index 04783d18..87e3554d 100644
--- a/unit/test-sae.c
+++ b/unit/test-sae.c
@@ -631,6 +631,116 @@ static void test_end_to_end(const void *arg)
 	l_free(td2);
 }
 
+static void ap_to_client_tx_func(const uint8_t *frame, size_t len, void *user_data)
+{
+	struct test_data *td = user_data;
+	uint16_t trans;
+
+	memcpy(td->tx_packet, frame, len);
+	td->tx_packet_len = len;
+
+	if (len <= 6 && l_get_le16(frame + 2) != 0) {
+		td->tx_reject_occurred = true;
+		return;
+	}
+
+	trans = l_get_le16(frame);	/* transaction */
+
+	switch (trans) {
+	case 1:
+		assert(l_get_le16(frame + 2) == 0);	/* status */
+		assert(l_get_le16(frame + 4) == 19);	/* group */
+
+		td->commit_success = true;
+
+		return;
+	case 2:
+		assert(l_get_le16(frame + 2) == 0);
+		assert(len == 38);
+
+		td->confirm_success = true;
+
+		return;
+	}
+
+	assert(false);
+}
+
+static void test_client_to_ap(const void *arg)
+{
+	struct auth_proto *ap_sta;
+	struct auth_proto *ap_ap;
+	struct test_data *td_sta = l_new(struct test_data, 1);
+	struct test_data *td_ap = l_new(struct test_data, 1);
+	struct handshake_state *hs_sta = test_handshake_state_new(1);
+	struct handshake_state *hs_ap = test_handshake_state_new(2);
+	struct authenticate_frame *frame = alloca(
+				sizeof(struct authenticate_frame) + 512);
+	struct associate_frame *assoc = alloca(sizeof(struct associate_frame));
+	size_t frame_len;
+
+	td_sta->status = 0xffff;
+	td_ap->status = 0xffff;
+
+	handshake_state_set_supplicant_address(hs_sta, spa);
+	handshake_state_set_authenticator_address(hs_sta, aa);
+	handshake_state_set_passphrase(hs_sta, passphrase);
+
+	handshake_state_set_supplicant_address(hs_ap, aa);
+	handshake_state_set_authenticator_address(hs_ap, spa);
+	handshake_state_set_passphrase(hs_ap, passphrase);
+	handshake_state_set_authenticator(hs_ap, true);
+
+	ap_sta = sae_sm_new(hs_sta, end_to_end_tx_func, test_tx_assoc_func, td_sta);
+	ap_ap = sae_sm_new(hs_ap, ap_to_client_tx_func, test_tx_assoc_func, td_ap);
+
+	/* let client send a commit */
+	auth_proto_start(ap_sta);
+
+	/* forward commit from client to the AP */
+	frame_len = setup_auth_frame(frame, aa, 1, 0, td_sta->tx_packet + 4,
+					td_sta->tx_packet_len - 4);
+	assert(auth_proto_rx_authenticate(ap_ap, (uint8_t *)frame,
+						frame_len) == 0);
+
+	/* forward commit from AP to the client */
+	frame_len = setup_auth_frame(frame, spa, 1, 0, td_ap->tx_packet + 4,
+					td_ap->tx_packet_len - 4);
+	assert(auth_proto_rx_authenticate(ap_sta, (uint8_t *)frame,
+						frame_len) == 0);
+
+	/* forward confirm from client to the AP */
+	frame_len = setup_auth_frame(frame, aa, 2, 0, td_sta->tx_packet + 4,
+					td_sta->tx_packet_len - 4);
+	assert(auth_proto_rx_authenticate(ap_ap, (uint8_t *)frame,
+						frame_len) == 0);
+
+	/* forward confirm from AP to the client */
+	frame_len = setup_auth_frame(frame, spa, 2, 0, td_ap->tx_packet + 4,
+					td_ap->tx_packet_len - 4);
+	assert(auth_proto_rx_authenticate(ap_sta, (uint8_t *)frame,
+						frame_len) == 0);
+
+	/* client should by now have sent association request to AP */
+	assert(td_sta->tx_assoc_called);
+	/* AP should have sent a confirm frame to complete handshake */
+	assert(td_ap->confirm_success);
+
+	/* confirm association frame doesn't return an error */
+	frame_len = setup_assoc_frame(assoc, 0);
+	assert(auth_proto_rx_associate(ap_sta, (uint8_t *)assoc, frame_len) == 0);
+	assert(auth_proto_rx_associate(ap_ap, (uint8_t *)assoc, frame_len) == 0);
+
+	handshake_state_free(hs_sta);
+	handshake_state_free(hs_ap);
+
+	auth_proto_free(ap_sta);
+	auth_proto_free(ap_ap);
+
+	l_free(td_sta);
+	l_free(td_ap);
+}
+
 static void test_pt_pwe(const void *data)
 {
 	static const char *ssid = "byteme";
@@ -893,6 +1003,7 @@ int main(int argc, char *argv[])
 	l_test_add("SAE bad confirm", test_bad_confirm, NULL);
 	l_test_add("SAE confirm after accept", test_confirm_after_accept, NULL);
 	l_test_add("SAE end-to-end", test_end_to_end, NULL);
+	l_test_add("SAE client-to-ap", test_client_to_ap, NULL);
 
 	l_test_add("SAE pt-pwe", test_pt_pwe, NULL);
 
-- 
2.45.0

