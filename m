Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD6932D42B
	for <iwd@lists.linux.dev>; Tue, 28 Jul 2026 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253703; cv=none; b=GoSWSiVpVEVVJYsJVAmtTFGxaFAz/P1956jDbWbORn2GGVUTKmcjLz389OBa0Q0yQJdOoTsj2cBsFfcAZOb74N0RFaepYKcGcw8sCvgg/Owvi3/OXgKTNY04yQBie1ppWYLPKHzq1Ft3nXuWOGHczwMaXYE4Zrfg9vKPwzkcZSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253703; c=relaxed/simple;
	bh=5GgRM3f5N8qT/aFbjVMsGL4oJKN2b6nNVLyx6xpyUkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQ3oFW6e1PaofbbWb6QLh/Tu8phRZLjTXRoa4P+h40y6EkhOO+H9hTzNqKHWyXE9lT/E6dx0Q8+6fUKPs/AbajWy3M4gYPf2iXRAAbBtOvl/on7qyN9Lye78NyfmGkr+GF74UAET51q5ZENMUWPLUivG/FsSi7xGrfptTdLwtKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=riAMyH+t; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riAMyH+t"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b0117d49dcso3599128e87.3
        for <iwd@lists.linux.dev>; Tue, 28 Jul 2026 08:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785253700; x=1785858500; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gKcidp5a3wW+Cp41a4K+Yr2nBPGxAXVApigpYqLv5n0=;
        b=riAMyH+t0zOvl2VOTwjX4JBC/z5DvQhH39AweG2Nn5PywNpFhZFb4zaABlnXiyvUAo
         SPNFwY4W8L9uJ/PWg06JbMtFTXMD3KZWSkDOEzMSGfTvvGRmlCtgDUTfxYxvimb8ElGx
         A1KwFQNmDVWMGpQOWoO0Nfz4G8OcEz5kWji6E51BLchlhyrGC+yi+T7B9SdFib7h606T
         5d3t2AK/kUuqop7+UoVE5jY5lsDEtJqtU0k0UA8Tmh/3YOEyzNijnyqdd9rnJb/VVhPf
         gBSWbIy42H3tgsvNNlf3X0hWyuSJ4x7UUr3RlKiG9tt+YRX6BS9N93Sl0/Hxw0XlTGh4
         klYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785253700; x=1785858500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gKcidp5a3wW+Cp41a4K+Yr2nBPGxAXVApigpYqLv5n0=;
        b=fUKcKqF1H0oqEZspcDN2zEFtxMgohqs/FBaV2lyp24IJlN5tFsXs5czQv8ODeLRuFX
         7sff15KfYmQjkqj//1YjdjT5FmD3zAfc+GWjUSs8m+i58NS9cywmvPNjyVorxZtYA8ei
         45r8BGobBx2So9V+/sSbhM+5HoAc71Rkfej/YClNtKpwC7aFqpE8I7LoIx4Yt4WV4KA4
         ZgSe0VhP0sU3lEDNL87uata85bHuR/Emusmx3cOLcZg37OyQG3aT9p2994k3Vy9ugmKU
         tjSEWVsarHvpPCZnF7LY3pDsV6VQgersSea30yzud8xFc6y2E7U69kw7o566Oy2RG6gJ
         ZUiQ==
X-Gm-Message-State: AOJu0Yz6kimONeGgHvYbHy1AG6BzK/pSrfoX+zKZrnjxY6ml3SRThkHS
	SUXU1KR0r37WU6EEW4l+xefTt2ViPyxjU4ynHzYXVZjUhBvXQpe7JO8u/WRPHKolmqQ4vA==
X-Gm-Gg: AR+sD11eZkCQF8gkcaThCC2MIvB7aXW0VANRy/CQ6aQmmqwS/bw9kLAOJEqNstb7bSn
	Qho6eXPgxDwmSN4ecsrPJtpPMBkiOZeehyvpjLhUlUXDfRjAbsqkMfVqwcvUj8wyFeKlY85W4zR
	aI8C8sTQdfVJoR3vRXahi+xd81FKWtG/bOzx0vj6ThLyedgKHFawCbzHn7j1hJkeaCNEjR9v4jB
	RJiKsqvJbnwjws4pU1x1ofaaB59IAIjF11XDV1SKNiUiPDfQ8CmxTQ7eg10EzvmyGDLscQ7ogud
	sijJcoAyCxpmw6+0Q+uEo9GD8Ip0IZwVvkWU5HJe9d0pwbr1ZwV/8Rej2atyXgfsqwNMsxgPoRv
	3R+wWsWA8RjxyByJh+Y1Ns262bsz3vaNayyPUteCUO8UAbs8yfpPI5RLbHx92PVVNbhYQLONgVv
	SBKTINYwTldlI0jdab/g==
X-Received: by 2002:a05:6512:138b:b0:5b1:5b11:8eab with SMTP id 2adb3069b0e04-5b2d022d81fmr654393e87.15.1785253700072;
        Tue, 28 Jul 2026 08:48:20 -0700 (PDT)
Received: from ultra-pc (s3.2dsites.ru. [188.187.190.12])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f22187e5csm19807431fa.16.2026.07.28.08.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 08:48:18 -0700 (PDT)
From: Aleksman4o <aleksman4o@gmail.com>
To: iwd@lists.linux.dev
Cc: Aleks Man <aleksman4o@gmail.com>,
	prestwoj@gmail.com,
	denkenz@gmail.com
Subject: [PATCH v4 1/5] network: expose RSN capabilities on BSS
Date: Tue, 28 Jul 2026 18:46:40 +0300
Message-ID: <20260728154729.3485557-2-aleksman4o@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728154729.3485557-1-aleksman4o@gmail.com>
References: <cover.1784069194.git.aleksman4o@gmail.com> <f9cb0ba9-da64-48b1-a8a9-3fe5c463b568@gmail.com>
 <20260728154729.3485557-1-aleksman4o@gmail.com>
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

