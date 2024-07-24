Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426D626287
	for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 15:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836010; cv=none; b=L4L6CzD5lPcaWuXsCNfSKCm8cOAKG2hMjtcLljROFQ7ljlFhO//9F3ytasVJXiPyPw/bd8/sR614D4ZGTQeMrf5fP5zZvr/WlshAiM6v5fVnhXI/5QqAGDeSXDXhcjYe0rUZyCeMUpDFHOJgUpmGjTo+xM2eT9Qhn0eUU6kkMsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836010; c=relaxed/simple;
	bh=tagP61yNJmsAJHKBfhm8LSjmJzcOwd3jJl1WkTP1lMI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fpSzOMG1cMK3IlMbSQJXospHsKqaPOkRyuqrBZLMTZ9mjybkuGaW3zxiAK43ZCdwxrXM7ppIT1Z2uNrDcIp7dZfqWxlyNDuny829S8ZWmtlRE+klGBYN2aaKFwOzP4CCgd72R0dKlkvFV9mqavw0tBN8mIcqKXCAG39P+PnTvX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmlxLxfM; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmlxLxfM"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-703631c4930so3557091a34.1
        for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 08:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721836008; x=1722440808; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vr4cagXRKHoGrtK5CjJX/9SHrVXecHUstDwjaCnMSGk=;
        b=XmlxLxfMbATWdMOwieAzA/rrvBTvVoHKRO6Co/jmmm6xZI1je0sY5e1bQfcaAIJ4HO
         XmFvRN/1e/xjtQeM8/AsZkImJtlcBERqFC6zIAaVGobXf0fj0I4W3Nf3fDDuixdwRSjW
         Ehoetq6S/S8c9rwGfUNBKwr7RpNndCeCdIhQGHWY8i9GLjYCwHTZcQyH3m8yQbxyHILb
         LcF710GlCEnuH0qr7fh/fWMEfivQ413aZAtFK7u0u4PM1INfwKU3bH7nw7/2+H9rE53I
         lAEnAF+sUn2LQExZqgR6xcagQ/BY59AhMJU4XfmDJJ5/elMrU0YpYU1qw56RsEODlU4H
         j62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721836008; x=1722440808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vr4cagXRKHoGrtK5CjJX/9SHrVXecHUstDwjaCnMSGk=;
        b=pqhZzuOhYQTMBIcE+V7bPi0c0A9I2Rte/JRVP2Q7vxY9WWGtl8GaH5EGQ46ImGgtg7
         Ovs9Jj3sjSCbz5aKO1gLD0Mz3pdu9wUPYIU+eXg4qTORbuJgG+DX3USiHA/tpNEOJrSy
         mYEzWZa8lTFbiBTEHxxZzmuyE7zb4g3WpozqQqu9vvH9PD3MKM6DdPtVNVFNbfEmbD3K
         O48V+QaNPIIyRgXVU7rsf9ktWnnLFeS+ocVaFlWfrFnYrUzYNFET0j+rVN3ZLUptkE7A
         HBQmHstT/jj9xy7DOQ+OYr046PCwu1CPC8E49d+i8t2GtSUyhUK0FcHiIa+yWszb8WGT
         GZ7g==
X-Gm-Message-State: AOJu0YzUKpMX2MY8IJama/60NqQcaQZUVQhuE55LcrTvOlx6AlDUpUzn
	pUL+I+0bcn2Q4BImgoZN1HZW+a3A1CeP2PiRfMigE9nlUgMEzW+z6zHcKQ==
X-Google-Smtp-Source: AGHT+IFMB7GeTSegAyHpd8DAegjjw69MqBMyhyt+r2NsZaw7iWEY8WKDwoiDpC5AqgMUNgSWsJe9Ag==
X-Received: by 2002:a05:6830:3883:b0:703:5b40:1925 with SMTP id 46e09a7af769-7092e76183bmr104610a34.28.1721836007886;
        Wed, 24 Jul 2024 08:46:47 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a199013905sm589001485a.67.2024.07.24.08.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 08:46:47 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/5] dpp: factor out PKEX/DPP start prep into function
Date: Wed, 24 Jul 2024 08:46:37 -0700
Message-Id: <20240724154641.1461593-1-prestwoj@gmail.com>
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

