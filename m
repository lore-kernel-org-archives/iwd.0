Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95F83ED5CD
	for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069457; cv=none; b=bJ/2ahM1flhMikdRC9IBzzm4iwae+VnEvFQQNaDEg/sx72U3jXDBB5y+fc3YAPXxRQrv0TOJqAHWKosesnBiZpHzCbupOm+ExCbNK+e44S3XiHVvRBuiVK067NvL+XIdZm5uRbcaXkQq25mHzypWCbuWKs2kbIYJvUgmAb+nLQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069457; c=relaxed/simple;
	bh=5GgRM3f5N8qT/aFbjVMsGL4oJKN2b6nNVLyx6xpyUkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JT8kHW/0WjTlg6il+Z2PEaWYk8R/wwWVuR0myONkfyA5uvNGHueo+JAsOjd6yp9WgxBGReJHSMEJyDEXVHAJYbRag0JkhzCjKZvlHPGQFsC9YqdFrjPFr78CiPXYKjFPc4keW/gH1Li5kB08t3czPJqGOLjFmgXmzwjKgAGUt+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPm359HZ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPm359HZ"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b0117d49dcso4447893e87.3
        for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 15:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784069454; x=1784674254; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gKcidp5a3wW+Cp41a4K+Yr2nBPGxAXVApigpYqLv5n0=;
        b=fPm359HZg+1GG5MeMbBOSg+n0hzoalkfU3jAmgAbyPuBmiYL1vueZjsGM5ptSq6vmn
         OZIaRvJaJ6lFwFCX7Ip1YTk5fWAX60NkrClp5R5o2Nxo8+1aL8Sn3qANdhCuNUTUr6QJ
         iPXVnlbA4cFMzR1YePducCEXLmnWQTfjNHA/08fmpvSRwsZtvNIXQtvpfZwK6VQTcgXq
         QebLbWLtDuyNVUC3tBM4Xpbj58O0xDOM8d1hTKf0jmb9lWyRWfS4kYkAHlx/26mT4Yyv
         Z72HI55JjAsMOU5eS8pu2oJpauCdbcriGV/5E9fdQr666+3k1VXlofX5UcmHIeBmNGii
         G35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784069454; x=1784674254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gKcidp5a3wW+Cp41a4K+Yr2nBPGxAXVApigpYqLv5n0=;
        b=aC13+mI96LAsm5Wvi/UczzW3z5BhRMSES2ZjKr1Plnp02uE2kn4oJxtJbTWuZArk/3
         YV+daTRMGEEdFi0ITOUex0zSAQZq7ynUg1iBGf0ioMQZ09caGzWlJi9U4/GF7bRlP6d/
         6QLhiDyI6TU6y3YK84iZdCVrvPkUcQa+JpmSS2rPrOSy1kOBDFtnDFkc5s/LZPZBDGSa
         XuKbhaP9PuEwVeihYb2E5E86C8iqEU5jHwoVwWsSBPDGYchr4mr9c61y3Fbp4L3z7jnT
         RdBKqsYgH3gqMySZkbM486yenZWoWcgerCbZh0HQilA0JCcLOaHP0C/fbnFvo/Y9K5MX
         VTWw==
X-Gm-Message-State: AOJu0Yyjo4JLrv7Re3xob0SLyHaagnpY8IB09iUMDQi4k24aFveu9owp
	fFY/Te46vopYSZpJBqja3EnpbFqEXGTkVUxau4xUYa9lK3nwRKgSJc4XeIcDXgABJXI=
X-Gm-Gg: AfdE7cnSKHyLv3EXA74oKz2zVGIa5hSvIc0NO8Pmawvz9FlZHldX3iLAZFG0nNF7Mqs
	gWIjQB5QR/l1qkLV5pjMz6X6O0B72mOKgYozbUW6y1MNgEQTezJZbxYTDxuLfwwqm6XmW5BW0hr
	nctgL/oqG83q+X4gUqNpNlSYy23JYxJF0n4RD+U8BRv+rl1j/9pycYe5kl5xC0XwyHyoL6/icT7
	EbBgZ05UByIt0aVFVlVNiaMRHm55WaEhba1PlIitln/TMAUkO1qgqlNxnwZxVjpWVNqSzdcOMZf
	jXsQmcOzjL16rOq856CCF2Szo4UPhATl+uTlZlAPng8pY+ng9dRN94zMuch4QZzIgtUS6syImPJ
	ErHbiJkV+2dxCwtsEl0x20kpFPQ56+lOtJ6I6L+2s3uHzeDuz8i7W4s61zgtOjywrZvLjvKdgSC
	zBkL1EITWTSXWO9jOB3WI=
X-Received: by 2002:a05:6512:340a:b0:5b1:59ec:245f with SMTP id 2adb3069b0e04-5b159ec2606mr694240e87.8.1784069453696;
        Tue, 14 Jul 2026 15:50:53 -0700 (PDT)
Received: from ultra-pc (s3.2dsites.ru. [188.187.190.12])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca9ddf0sm3791060e87.50.2026.07.14.15.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:50:52 -0700 (PDT)
From: Aleksman4o <aleksman4o@gmail.com>
To: iwd@lists.linux.dev
Cc: Aleks Man <aleksman4o@gmail.com>,
	prestwoj@gmail.com
Subject: [PATCH v3 1/3] network: expose RSN capabilities on BSS
Date: Wed, 15 Jul 2026 01:48:47 +0300
Message-ID: <d4c06eabd6ee8b589b86b5ecb3729eb489e1f5ed.1784069194.git.aleksman4o@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784069194.git.aleksman4o@gmail.com>
References: <cover.1784062938.git.aleksman4o@gmail.com> <cover.1784069194.git.aleksman4o@gmail.com>
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

