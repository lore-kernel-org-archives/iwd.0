Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9101C4620
	for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768511; cv=none; b=WCVp2d8JF0oosUbxwvOazl5ZGujkm+Of9ByvpPZEdwy1b+4HvnkYfREG/aqE/kq+xXHWzJyFQLRzA9BQCcHIuRZGcQx/xhGEKf7Banbpt5Tc7AUAvpmlDJSyKueaYD+50vzjG8mK+GfPkbMM37rtHFfji0t1FEVtCedODlhETS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768511; c=relaxed/simple;
	bh=6Gi2Q3bkShDwYTKg4eYJhAqdUhSoU19ScMOBerJ/CDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gw4ygMovsX7VSQ1xyRRiaXIbAaMME4ae/OD+YJoi/zvRoQH+CTaLPNR4//2Ew7l2HnlAPJR0IDNgBZN5pEMqXQTqj4H52AALasrl7ZmkSXZjbzCG87bMl81JFgVgYGjW4uEuwM+6qLbIfLpKjeX9VGxmtjtUT+ye6G7OdW3na/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpr3Kk/h; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpr3Kk/h"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-201df0b2df4so45299225ad.0
        for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724768509; x=1725373309; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66ad9m81ugj7vnhFE5irO8ME7Z5n8qGvT1ofOD7cFM4=;
        b=kpr3Kk/hjyGrn/7OZQLJcyB9sCjrt/urUU0719DSy1eecANhElAQ8zAaIFGZkWnggf
         MBbsFW9KllwtCU/EKHOv5N1Spf6Ou0QYeGnc1dtHbla9W0b5Tv+tdnrpEKH9fAio71J/
         9N6zRYJ7E5bWpLfxLDNvZJhp2C6HGo4llVD5+bDxUc/MuNS/Vi0ewvA4svzaJXh4Ih+F
         j6EhCBHGuEfcLhjamWORGwcztaGWa5T6bVUU4K5tUQHirmaoE+XKlgkm2xct/EsfjqAh
         ArJZ18ongM3h5087oDcG3MVhWvOMpCxYo+3vQvWqDEBjqMfZgqiho7IkZg5gioxZtzks
         8MCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724768509; x=1725373309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66ad9m81ugj7vnhFE5irO8ME7Z5n8qGvT1ofOD7cFM4=;
        b=K0XhIH+aqEM/N9R5E4aZRDbDWEYP2mKHyLN+Ve9HIMopqqkI0No9l+FVZh3LrgGuhk
         l+pbH2crfDllI/jLG3fH+gkjSbg/IZoRzWu4IKN6QZtX+K8suqs0Uj+vllI/vnfkSNIt
         tg4SZTv7HYxZ7Gdy+TJiFSXxTfTFm2OpEGOoUo89UsHHXkaES1vQRE8k4JkyeAnTRWNm
         BvP3tJWSjN+0URrCi9OMhFRG+VkhN6ySqnkFsTAPJ1WnFM+1YCxWQHUVdopI939wI73F
         LEsNGnq/uPbkKkiix7/1FihgWwvv6kaIxrKz6QWMhtdF0W7rLq6w7nd8eTHWmZbOAmo7
         xZxg==
X-Gm-Message-State: AOJu0Ywmdpah2l/c/8gTtp+IL65f5vAXCqfZXHVAd2ayx6cA4HRltEEq
	/EWJqXIG+UMxTFvNxUgLSlW+9ENo1JESX+tWKMCDqv0g5F96mzZmf0ebXQ==
X-Google-Smtp-Source: AGHT+IFyZ7yKDZM5Ytmdb0zluQnZWp+eHsJDhBdgUjmH9tDLV5luI9nNWJT0DzFdXi/qCHGo6dNKfw==
X-Received: by 2002:a17:903:1d2:b0:200:aa78:cfc7 with SMTP id d9443c01a7336-2039e44f09dmr194249765ad.2.1724768509221;
        Tue, 27 Aug 2024 07:21:49 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385609099sm83635695ad.192.2024.08.27.07.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:21:48 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] dpp: add Address/Frequency as parameters to PKEX enrollees
Date: Tue, 27 Aug 2024 07:21:23 -0700
Message-Id: <20240827142125.751023-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827142125.751023-1-prestwoj@gmail.com>
References: <20240827142125.751023-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DPP spec allows for obtaining frequency and MAC addresses up
to the implementation. IWD already takes advantage of this by
first scanning for nearby APs and using only those frequencies.
For further optimization an enrollee may be able to determine the
configurators frequency and MAC ahead of time which would make
finding the configurator much faster.
---
 src/dpp.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index c1047ca3..39b66154 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -4345,6 +4345,12 @@ static bool dpp_start_pkex_enrollee(struct dpp_sm *dpp)
 {
 	dpp_property_changed_notify(dpp);
 
+	/* Already have a set (or single) frequency */
+	if (dpp->freqs) {
+		__dpp_pkex_start_enrollee(dpp);
+		return true;
+	}
+
 	/*
 	 * The 'dpp_default_freqs' function returns the default frequencies
 	 * outlined in section 5.6.1. For 2.4/5GHz this is only 3 frequencies
@@ -4374,13 +4380,17 @@ failed:
 
 static bool dpp_parse_pkex_args(struct l_dbus_message *message,
 					const char **key_out,
-					const char **id_out)
+					const char **id_out,
+					const char **mac_out,
+					uint32_t *freq_out)
 {
 	struct l_dbus_message_iter iter;
 	struct l_dbus_message_iter variant;
 	const char *dict_key;
 	const char *key = NULL;
 	const char *id = NULL;
+	const char *mac = NULL;
+	uint32_t freq = 0;
 
 	if (!l_dbus_message_get_arguments(message, "a{sv}", &iter))
 		return false;
@@ -4394,6 +4404,14 @@ static bool dpp_parse_pkex_args(struct l_dbus_message *message,
 			if (!l_dbus_message_iter_get_variant(&variant, "s",
 								&id))
 				return false;
+		} else if (!strcmp(dict_key, "Address")) {
+			if (!l_dbus_message_iter_get_variant(&variant, "s",
+								&mac))
+				return false;
+		} else if (!strcmp(dict_key, "Frequency")) {
+			if (!l_dbus_message_iter_get_variant(&variant, "u",
+								&freq))
+				return false;
 		}
 	}
 
@@ -4406,6 +4424,12 @@ static bool dpp_parse_pkex_args(struct l_dbus_message *message,
 	*key_out = key;
 	*id_out = id;
 
+	if (mac_out)
+		*mac_out = mac;
+
+	if (freq_out)
+		*freq_out = freq;
+
 	return true;
 }
 
@@ -4450,6 +4474,8 @@ static struct l_dbus_message *dpp_dbus_pkex_start_enrollee(struct l_dbus *dbus,
 	struct dpp_sm *dpp = user_data;
 	const char *key;
 	const char *id;
+	const char *mac_str;
+	uint32_t freq;
 	bool wait_for_disconnect;
 	int ret;
 
@@ -4459,8 +4485,19 @@ static struct l_dbus_message *dpp_dbus_pkex_start_enrollee(struct l_dbus *dbus,
 				dpp->interface != DPP_INTERFACE_UNBOUND)
 		return dbus_error_busy(message);
 
-	if (!dpp_parse_pkex_args(message, &key, &id))
+	if (!dpp_parse_pkex_args(message, &key, &id, &mac_str, &freq))
+		goto invalid_args;
+
+	if (mac_str && !util_string_to_address(mac_str, dpp->peer_addr))
 		goto invalid_args;
+	else if (!mac_str)
+		memcpy(dpp->peer_addr, broadcast, 6);
+
+	if (freq) {
+		dpp->freqs = l_new(uint32_t, 1);
+		dpp->freqs[0] = freq;
+		dpp->freqs_len = 1;
+	}
 
 	dpp->pkex_key = l_strdup(key);
 
@@ -4595,7 +4632,7 @@ static struct l_dbus_message *dpp_dbus_pkex_configure_enrollee(
 
 	l_debug("");
 
-	if (!dpp_parse_pkex_args(message, &key, &id))
+	if (!dpp_parse_pkex_args(message, &key, &id, NULL, NULL))
 		return dbus_error_invalid_args(message);
 
 	return dpp_start_pkex_configurator(dpp, key, id, NULL, message);
-- 
2.34.1

