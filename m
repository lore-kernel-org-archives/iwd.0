Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E0E3D9559
	for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 21:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784063593; cv=none; b=YxYLdYZ+juCmrTcX8/AJqWqmiDS7YU80DY1YM0FqyQQMWBQ32l5sLdTXq1Sx+xX0yzlD1Bun6+fwHXlifquQdsq65eZ8sLmNmqb2aPoicH5+Er9gsC9QjVh7FCTEg0b2dMMt8BI/FXRnh7D4GdChujtoTORo/UQfesTea8NsD2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784063593; c=relaxed/simple;
	bh=5GgRM3f5N8qT/aFbjVMsGL4oJKN2b6nNVLyx6xpyUkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rbO6JADAfIyr9M5EfVSprMdgUvEmv+ODWy0d1EA44DiZU44DN5zKMfvy7jvEnypcVlBlO6eSH1Ux8vjSIF+z1EvxLr27SuoYzPsDrWUlM3Xmt5sj1H02CLzV6PYOv1lxN9Uc6PiR7W19wltxoVXPT26JJyPGIyldLCs0dQiAgvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuRKveRD; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuRKveRD"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b00ca000ceso5044275e87.0
        for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 14:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784063589; x=1784668389; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gKcidp5a3wW+Cp41a4K+Yr2nBPGxAXVApigpYqLv5n0=;
        b=KuRKveRD0MFBzBgjPEDdMzD9H4Gihhdzke7UeFn3og6CleOMZ+1MIfp+F24DR94J+2
         +pwyRqLlu939cexDXe9vhjGK4gzB83+crIJpEFKhu2zaLraErUapqYxv8LUpKgGauEnX
         estSrG7CmnFuldtf98I6zLZxbBe3tsI03/wjsSR7nNiWzS/Iy4H1l2614tGtrY/fWpkE
         Uj6/zd82NfdoSmLnKBeaUNUJsg2u+ZmXndpYVHW0WetOFNiLv/o+N/q7UZSh3LqmJH+J
         wAPqyYyrITFzaHb/kF6veVBvxHTyqPtEhQ1UhGwuFpGpqQs7VNI6cnjhkkfEqsy0LIFV
         i9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784063589; x=1784668389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gKcidp5a3wW+Cp41a4K+Yr2nBPGxAXVApigpYqLv5n0=;
        b=RKm0GLeLXEfK7AaNNRH5oYMiFx1v/Z19d/qwE6pMZVqh9lVPGn78kENWRCEhqVgfpy
         DvLo9MaJjMIrfWDTvrz8OXyt7VLjiy0xCa67EYvRgNsj/Pa2YPVrEbvUDgD8e0LKwDQn
         le9ECn1sz4T72Nt2IAU1bEgUplicQJGLOF29n+GvKCOWUhYYVbeiFpI9b+/xWYFnPk7y
         thDeT5eOUh6eZzpJqpD62kwRQPM/s1rAWEF8nRZr4H75DCjB15Ixa+perdex87892Kj2
         T/Oli5RQRJitfaivo+XSvMQ7heHEgQfMw9IeaA52LrxWX9mXkmNrsWYpK4KWgOtnqKYE
         9NOA==
X-Gm-Message-State: AOJu0Yx+QCWcQDPKdlfYKisfxfED3EzqbOP4VmfGSMBKmJs/LPhzwIhY
	yJ+XGck7w1T2inBr8fQoMiKqyRuMHFoSfc/NEM5aVhAGO+ml80fbXF5JMch8NgDIsH0=
X-Gm-Gg: AfdE7cmakqOxDvbuw7f3I1IF4wxINw6RkduYEXqCcIl67bq5dHZOXTIxu34WTU6PlFd
	dpJizTgksKhbxP/pdbacwkM9Pa7XPCugkrLQZ9biuJBEOGDuLnU78uJuiJnKO8jDOKOMMx9CTGq
	gkzDVknh7W6Usw3ublD86IlvNcGBnpVB+pgIXxk9tUTj9GS5M5CKPgDOYYMskrrzYwg9iF8WUdl
	93rzTOHNIJHd9IkP0sggMKlVNMcHjTYyh0Ld0Hcsv1BklkTAJ5amgFtdYvzVi6jDN9vIBIFLGnh
	rbvYrJV1R/qvtUnyG2kBDpGTlA5dJY53BMsHuOeel8+L3MCPgjWIucThSARJe2S+uFDLwxbmSt+
	ni5Q1bhqE3B/stsGNkpCulGu+ZiRx97r7pFpR0Zz+aXquSBwVhMRPHH3tcldPECr3xzAkBecPAp
	11lNqPFP4uPwF5e6OH/g==
X-Received: by 2002:a05:6512:230e:b0:5ae:bec7:8b73 with SMTP id 2adb3069b0e04-5b159b8bb13mr863156e87.57.1784063589308;
        Tue, 14 Jul 2026 14:13:09 -0700 (PDT)
Received: from ultra-pc (s3.2dsites.ru. [188.187.190.12])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca4f919sm3770435e87.20.2026.07.14.14.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 14:13:08 -0700 (PDT)
From: Aleksman4o <aleksman4o@gmail.com>
To: iwd@lists.linux.dev
Cc: Aleks Man <aleksman4o@gmail.com>,
	prestwoj@gmail.com
Subject: [PATCH v2 1/3] network: expose RSN capabilities on BSS
Date: Wed, 15 Jul 2026 00:12:24 +0300
Message-ID: <d4c06eabd6ee8b589b86b5ecb3729eb489e1f5ed.1784062938.git.aleksman4o@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784062938.git.aleksman4o@gmail.com>
References: <c684823d-4be1-48ba-94ac-f2c01551f832@gmail.com> <cover.1784062938.git.aleksman4o@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleks Man <aleksman4o@gmail.com>

Network.Type intentionally groups all personal networks as "psk".
Consumers therefore cannot distinguish PSK, SAE, and transition BSSes
even though scan results retain the RSN IE.

Add an optional RSN dictionary to BasicServiceSet with the advertised
key management suites and pairwise and group ciphers. Use the same field
and value names as wpa_supplicant's BSS.RSN property so consumers can
share parsing logic.

Parse bss->rsne directly so legacy WPA capabilities are not exposed as
RSN.
---
 src/network.c | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/src/network.c b/src/network.c
index a5a2375a..aa9e1281 100644
--- a/src/network.c
+++ b/src/network.c
@@ -2198,10 +2198,120 @@ static bool network_bss_property_get_address(struct l_dbus *dbus,
 	return true;
 }
 
+struct network_bss_suite_name {
+	uint32_t suite;
+	const char *name;
+};
+
+static const struct network_bss_suite_name network_bss_akm_names[] = {
+	{ IE_RSN_AKM_SUITE_PSK, "wpa-psk" },
+	{ IE_RSN_AKM_SUITE_FT_USING_PSK, "wpa-ft-psk" },
+	{ IE_RSN_AKM_SUITE_PSK_SHA256, "wpa-psk-sha256" },
+	{ IE_RSN_AKM_SUITE_8021X, "wpa-eap" },
+	{ IE_RSN_AKM_SUITE_FT_OVER_8021X, "wpa-ft-eap" },
+	{ IE_RSN_AKM_SUITE_8021X_SHA256, "wpa-eap-sha256" },
+	{ IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA256, "wpa-eap-suite-b" },
+	{ IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA384, "wpa-eap-suite-b-192" },
+	{ IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384, "wpa-ft-eap-sha384" },
+	{ IE_RSN_AKM_SUITE_FILS_SHA256, "wpa-fils-sha256" },
+	{ IE_RSN_AKM_SUITE_FILS_SHA384, "wpa-fils-sha384" },
+	{ IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256, "wpa-ft-fils-sha256" },
+	{ IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384, "wpa-ft-fils-sha384" },
+	{ IE_RSN_AKM_SUITE_SAE_SHA256, "sae" },
+	{ IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256, "ft-sae" },
+	{ IE_RSN_AKM_SUITE_OWE, "owe" },
+};
+
+static const struct network_bss_suite_name network_bss_pairwise_names[] = {
+	{ IE_RSN_CIPHER_SUITE_TKIP, "tkip" },
+	{ IE_RSN_CIPHER_SUITE_CCMP, "ccmp" },
+	{ IE_RSN_CIPHER_SUITE_GCMP, "gcmp" },
+	{ IE_RSN_CIPHER_SUITE_CCMP_256, "ccmp-256" },
+	{ IE_RSN_CIPHER_SUITE_GCMP_256, "gcmp-256" },
+};
+
+static const struct network_bss_suite_name network_bss_group_names[] = {
+	{ IE_RSN_CIPHER_SUITE_WEP40, "wep40" },
+	{ IE_RSN_CIPHER_SUITE_WEP104, "wep104" },
+	{ IE_RSN_CIPHER_SUITE_TKIP, "tkip" },
+	{ IE_RSN_CIPHER_SUITE_CCMP, "ccmp" },
+	{ IE_RSN_CIPHER_SUITE_GCMP, "gcmp" },
+	{ IE_RSN_CIPHER_SUITE_CCMP_256, "ccmp-256" },
+	{ IE_RSN_CIPHER_SUITE_GCMP_256, "gcmp-256" },
+};
+
+static void network_bss_append_suite_names(
+					struct l_dbus_message_builder *builder,
+					const char *name, uint32_t suites,
+					const struct network_bss_suite_name *names,
+					size_t names_len)
+{
+	size_t i;
+
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_append_basic(builder, 's', name);
+	l_dbus_message_builder_enter_variant(builder, "as");
+	l_dbus_message_builder_enter_array(builder, "s");
+
+	for (i = 0; i < names_len; i++)
+		if (suites & names[i].suite)
+			l_dbus_message_builder_append_basic(builder, 's',
+								names[i].name);
+
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_leave_variant(builder);
+	l_dbus_message_builder_leave_dict(builder);
+}
+
+static const char *network_bss_group_cipher_name(
+					enum ie_rsn_cipher_suite cipher)
+{
+	size_t i;
+
+	for (i = 0; i < L_ARRAY_SIZE(network_bss_group_names); i++)
+		if (network_bss_group_names[i].suite == cipher)
+			return network_bss_group_names[i].name;
+
+	return "";
+}
+
+static bool network_bss_property_get_rsn(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct scan_bss *bss = user_data;
+	struct ie_rsn_info info;
+	const char *group;
+
+	if (!bss->rsne || ie_parse_rsne_from_data(bss->rsne, bss->rsne[1] + 2,
+								&info) < 0)
+		return false;
+
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+
+	network_bss_append_suite_names(builder, "KeyMgmt", info.akm_suites,
+					network_bss_akm_names,
+					L_ARRAY_SIZE(network_bss_akm_names));
+	network_bss_append_suite_names(builder, "Pairwise",
+					info.pairwise_ciphers,
+					network_bss_pairwise_names,
+					L_ARRAY_SIZE(network_bss_pairwise_names));
+
+	group = network_bss_group_cipher_name(info.group_cipher);
+	dbus_append_dict_basic(builder, "Group", 's', group);
+
+	l_dbus_message_builder_leave_array(builder);
+
+	return true;
+}
+
 static void setup_bss_interface(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_property(interface, "Address", 0, "s",
 					network_bss_property_get_address, NULL);
+	l_dbus_interface_property(interface, "RSN", 0, "a{sv}",
+					network_bss_property_get_rsn, NULL);
 }
 
 static int network_init(void)
-- 
2.55.0

