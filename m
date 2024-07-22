Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C62C16C6B0
	for <iwd@lists.linux.dev>; Mon, 22 Jul 2024 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721672978; cv=none; b=F4FEwhCxVYLtuNiOc4A63IQDJtq+AxkCW63MIgfyqYOf9wjzsI1LCwn9zZjlKkfrqd2/BtuF2RgjSGtX/E2ax10HulPL0lzY0BvEfDIh7QJ9zraCHayx/HxqXMIAwyqk0VlbWjDQGnUTfo4jMngNTBDIRPc+XXkyZrK69dPD8u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721672978; c=relaxed/simple;
	bh=tagP61yNJmsAJHKBfhm8LSjmJzcOwd3jJl1WkTP1lMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ND2/5i35Zun68xMlQ5kHToR81/q3ziIoHWrHaD7vb5tU9vjUM7NWY9uRx/pnoAoayP32UEbYXtVUTfNwznf7g2fH76ZTWFeyVmDvdddXjfxmiFAWlLdeZzNl2Y4qeQw8cWJo8QZCbEm8kfJb16lf+d+V18qcKaxeOiugiVje7/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYYcwPPV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYYcwPPV"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fb3b7d0d3aso26421455ad.2
        for <iwd@lists.linux.dev>; Mon, 22 Jul 2024 11:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721672975; x=1722277775; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vr4cagXRKHoGrtK5CjJX/9SHrVXecHUstDwjaCnMSGk=;
        b=WYYcwPPVsG82D1nwLl5E9rybmgEmmwb4UjB4/HXfiNhLD1o1yWVjZLiUC66Pa9Lhbn
         FlK8dpoRSNwOtliRCam+8gfdWfHCfN8RpoATS+/SNHDsqEZGQxuC/yKsiaWldHxHZOcB
         H96K+7NxSfvW3CQUgGMiVRzIl6/8RH6u3ejMKborg9MgZhHUV6G2GXVOYcZdkAw0PW/Z
         mAzTbKYEu2i3Shhd0aBO5DLxOmyVLCauEfKQlvNpPcQSwU3+CDNOHBBNt2/XwCcSfoBI
         Qb1OKl0krLXpA1z6Ne9nvvRLvB5HshcKKU+PEKY7auX35qABpsl4N0LQJsBMJWRjCJDT
         pbeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721672975; x=1722277775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vr4cagXRKHoGrtK5CjJX/9SHrVXecHUstDwjaCnMSGk=;
        b=s6KY/k9As2cVsQG9I2C7lyZgOLpqdHL+rzfGsaL3Y6utIW2NI16GImYeirJIqYdPoK
         hRHu0DtT02VhGDztx6cQJY/avPCFJNHsqZhadIhXsTWcDYLqnnTr5w+p8N5CPzkq0RwQ
         LbmlpyzPYZkIxwq1uPDbgimUXdkowaOqkPu7v4kVAUDRCL/68i8MWwpT/56GE92n/5pP
         mS/UpAXoLz/rhTSqPleNl31Hn7DmnSZhLF4zrIhRp8l/nv/8439ApLkaGAnWDXvtypl7
         dGG1Mo3vwzhX151gOT0dRq8UQlpLVQLL84nqf4IQkDxrMxKZSmzs05QcLKxqTMoLMypM
         Ea+Q==
X-Gm-Message-State: AOJu0YxA9pQmva7MFRnJm910m1JWlwOjVoOUz1Gne1kNgvN9+rON+f0E
	Sf10msM77yNa1KmM4nHorMLwcsQE/JCXmE+ZMQF2gKewWKIwHluYzgpNOQ==
X-Google-Smtp-Source: AGHT+IEUfNIw8aqPQt2qS8a/qfF81HzEaQ0+TzOY7KE+CZWS/uhTqLu4mnYbsB4bLr5P0+Ds3KBwCw==
X-Received: by 2002:a17:903:190:b0:1fd:93d2:fb76 with SMTP id d9443c01a7336-1fd93d30197mr33752215ad.31.1721672975269;
        Mon, 22 Jul 2024 11:29:35 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd8dff753bsm33622625ad.243.2024.07.22.11.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 11:29:34 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/5] dpp: factor out PKEX/DPP start prep into function
Date: Mon, 22 Jul 2024 11:29:28 -0700
Message-Id: <20240722182932.4091008-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to slightly rework the DPP state machine to handle
automatically disconnecting (for enrollees) functions need to be
created that isolate everything needed to start DPP/PKEX in case
a disconnect needs to be done first.
---
 src/dpp.c | 64 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 567fe8d2..6f05aae9 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -3927,12 +3927,34 @@ static void dpp_start_presence(struct dpp_sm *dpp, uint32_t *limit_freqs,
 	dpp_start_offchannel(dpp, dpp->current_freq);
 }
 
+static void dpp_start_enrollee(struct dpp_sm *dpp)
+{
+	uint32_t freq = band_channel_to_freq(6, BAND_FREQ_2_4_GHZ);
+
+	dpp->uri = dpp_generate_uri(dpp->own_asn1, dpp->own_asn1_len, 2,
+					netdev_get_address(dpp->netdev), &freq,
+					1, NULL, NULL);
+
+	l_ecdh_generate_key_pair(dpp->curve, &dpp->proto_private,
+					&dpp->own_proto_public);
+
+	l_debug("DPP Start Enrollee: %s", dpp->uri);
+
+	/*
+	 * Going off spec here. Select a single channel to send presence
+	 * announcements on. This will be advertised in the URI. The full
+	 * presence procedure can be implemented if it is ever needed.
+	 */
+	dpp_start_presence(dpp, &freq, 1);
+
+	dpp_property_changed_notify(dpp);
+}
+
 static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
 {
 	struct dpp_sm *dpp = user_data;
-	uint32_t freq = band_channel_to_freq(6, BAND_FREQ_2_4_GHZ);
 	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
 
 	if (dpp->state != DPP_STATE_NOTHING ||
@@ -3949,30 +3971,14 @@ static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
 	} else if (!station)
 		l_debug("No station device, continuing anyways...");
 
-	dpp->uri = dpp_generate_uri(dpp->own_asn1, dpp->own_asn1_len, 2,
-					netdev_get_address(dpp->netdev), &freq,
-					1, NULL, NULL);
-
 	dpp->state = DPP_STATE_PRESENCE;
 	dpp->role = DPP_CAPABILITY_ENROLLEE;
 	dpp->interface = DPP_INTERFACE_DPP;
 
-	l_ecdh_generate_key_pair(dpp->curve, &dpp->proto_private,
-					&dpp->own_proto_public);
-
-	l_debug("DPP Start Enrollee: %s", dpp->uri);
+	dpp_start_enrollee(dpp);
 
 	dpp->pending = l_dbus_message_ref(message);
 
-	/*
-	 * Going off spec here. Select a single channel to send presence
-	 * announcements on. This will be advertised in the URI. The full
-	 * presence procedure can be implemented if it is ever needed.
-	 */
-	dpp_start_presence(dpp, &freq, 1);
-
-	dpp_property_changed_notify(dpp);
-
 	return NULL;
 }
 
@@ -4246,19 +4252,12 @@ static void dpp_pkex_scan_destroy(void *user_data)
 	dpp->pkex_scan_id = 0;
 }
 
-static bool dpp_start_pkex_enrollee(struct dpp_sm *dpp, const char *key,
-				const char *identifier)
+static bool dpp_start_pkex_enrollee(struct dpp_sm *dpp)
 {
 	_auto_(l_ecc_point_free) struct l_ecc_point *qi = NULL;
 
-	if (identifier)
-		dpp->pkex_id = l_strdup(identifier);
-
-	dpp->pkex_key = l_strdup(key);
 	memcpy(dpp->peer_addr, broadcast, 6);
-	dpp->role = DPP_CAPABILITY_ENROLLEE;
-	dpp->state = DPP_STATE_PKEX_EXCHANGE;
-	dpp->interface = DPP_INTERFACE_PKEX;
+
 	/*
 	 * In theory a driver could support a lesser duration than 200ms. This
 	 * complicates things since we would need to tack on additional
@@ -4376,7 +4375,16 @@ static struct l_dbus_message *dpp_dbus_pkex_start_enrollee(struct l_dbus *dbus,
 	if (!dpp_parse_pkex_args(message, &key, &id))
 		goto invalid_args;
 
-	if (!dpp_start_pkex_enrollee(dpp, key, id))
+	dpp->pkex_key = l_strdup(key);
+
+	if (id)
+		dpp->pkex_id = l_strdup(id);
+
+	dpp->role = DPP_CAPABILITY_ENROLLEE;
+	dpp->state = DPP_STATE_PKEX_EXCHANGE;
+	dpp->interface = DPP_INTERFACE_PKEX;
+
+	if (!dpp_start_pkex_enrollee(dpp))
 		goto invalid_args;
 
 	return l_dbus_message_new_method_return(message);
-- 
2.34.1

