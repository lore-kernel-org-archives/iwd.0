Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD53168E6
	for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 20:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061480; cv=pass; b=QK5KmOujEi3Y9A+lew1t3pJ/r0mFifGWHe1Vmc1ZblFL6wSlF9nkaFVWSJdUAXcEUw1SGqDYqL33bXZsAl8VzFIRNtFdXEE7MlnfzAFxVA0fjJMojndemD4TCi5+LBW1sSUzWJ/qKEwCGKyqsVoR8gk4SrmNFf8OanqFOu2/Lpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061480; c=relaxed/simple;
	bh=VhxUTiuOVOWdlhASrrVDYU3HqjTVAYOpIywZEFhC6z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujPNxu7FnYG7LHQ2SrcG+pHCp4v3zM50tj9LTyp8FIJbOPfFJM4j4NOkEVGaRJIoCHg9xNHPGqzTZCCoRzDiGudKCpiV2hm9wy6iTtW43EeGzC6OkvaEBLTx9l4Az9zrvu+MPxB7AFBijvkj7M79Ha9tE4M3nysU1ow3GLsmb48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sSGYzrRd; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSGYzrRd"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c2a76536bso45092821cf.1
        for <iwd@lists.linux.dev>; Tue, 14 Jul 2026 13:37:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784061477; cv=none;
        d=google.com; s=arc-20260327;
        b=fsMw5HKBOl7r7+/Y7omVOikKYMmqL/CJFmwLHIpqciKYDskStVL7WT7NaXE3JlXQw8
         csbkppSPbm+KU09dIHClbmA3pH0DQl6HQNAg9l1oKjQAJL2vsQSy286T3yurVzszHNO0
         xhLNm3PSvv6I2nEtUC+stmFo86O6AEExglSDRkee0cpWdo0GTMWV/tFLQwFF/7IkVOth
         EXAuIf1nVbhnr3tjMapVxdwpy0uOic/dUvUMMceyfirZUnm8WQ7CVq6gdAnrSo+IMbS/
         StXQPb/dGD0vthBBH5LXEZUCGF6G1JgMoSv6RouZyqCOvwAkwUiWvgL/UKFnVqqRxwha
         Pd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WeC0V00J/jjHgIIWC8jxQ7LyVi31xL8NyvpTovpjyE0=;
        fh=lOB+NE21i+DlK11xqGcqr6uTCV2U6X/qbNGHyNqUyZk=;
        b=rrmwCLtqTUoPe/335UVL8p1u7bFVF56iXHiuAETCt5XqwPo4rC+FLU1knIR/z88wIL
         7P1G6Lb1oIWoaOY2WvJ/dElDzI2PEiEjhxLRnEaVhhWtxrg1PF5o6PIbXDhuoEUlASgx
         RUcXoO6YfmJKXgs/K5n/Ik1FrHKoyXJU9LeghxP/AZmZYVT4mpDY6R5AK2pgJABEI13V
         sbUcC1hjZDBq3lMBhXwCKThy2b4scNW5rH/W/b5BqRENqNYlDASLdfZ06PzDdqB8p+Re
         ZtjK8MsB9KaDPesqMC5gfFvZx2YA5NGyLdnYM0AOV3nZrvdx/kzXt9gXsN9x0yP1xroM
         o4MQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784061477; x=1784666277; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WeC0V00J/jjHgIIWC8jxQ7LyVi31xL8NyvpTovpjyE0=;
        b=sSGYzrRdSLPeNWix+4+kALSGl0xTmXSS2VxwVeplRDmd/o5ZJeDVuR2l3SkJDY6oC3
         0ql8S4iyfojmbkYH0YMPoylTMp95yXVtmLnUyOr8JBoouCzmC7OP61CmKIVPLqBJttkA
         7kADbtEFG5jxKYgDA9SIhS+BXmKZlUfZm2N05iSdl83Lfo1E8kqmpuuCBRq9OGGTLRhU
         Gi5kd7tBaRDJcBdx4K3gs6dpp0zSKKu9oI9+S4OiYKRBdhRYqgPzvst4zpXkERXPyotn
         Wu1I7I+zQEyVhqRKSdMVgAKEVfWuvZi00XY/nQsTH7DEeIpXFKmGw2dNfGDSgDwyLwG/
         R81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784061477; x=1784666277;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WeC0V00J/jjHgIIWC8jxQ7LyVi31xL8NyvpTovpjyE0=;
        b=UldB6R7iyqBtRbPJW9HwAEYgOaY9HCN3FPIqFsGktuKlLfG265BdOKZkuGqUY2M2CI
         fLLVOK5Vr2SsVEL8YrBpN8IgFHaW4Ykx9cdMTy+BnMV/v/dXdXB0ymqVPjvE+yHm71sY
         8C91WBGKDocp84hISHlmqLiZHJQxvkT/7jl1ZzfrAIJRO90Al6h33dxGAhfidEkqCx7v
         RYJJU+ySJkub7xoDhBqdN3B630wL8BEdG8uRf62lS4gdWAcLAL5CQ2YubeAhVLZIVL95
         S+EFUmJeYe8HGPNwcOZs9+i61bpbELvOsACMNVjCvIkhkacu/sDJoIWnibfYHiXeq7gV
         QSMA==
X-Gm-Message-State: AOJu0Yz7iA83dV/jmlE1tqK6v9wtB5BdqZCTyZoNoOfXaixl82Gdx8FR
	hYpTLIvGky35/LKlcCP3qfL9M4BDQ8ihR8z70437MCnV7rTdtmZ93X9BoEZiPVXwetzkhsWkC/Y
	A1OdRHdHCM+IgMBQ28g0vf+y5GtrN5/lbMBHmQ+GfGQ==
X-Gm-Gg: AfdE7ckC+WGZFuIngqvo2F7HtEoiWo8xPf2C1tXVVOZtcLNPlbCI0+y4fq9XBnhpPT9
	g/uWWa4ip1SYVgXxzEPRSZTM2v7a8gatcD1j1cOBilWe+15AT8JVfQhcAn7k9AZdVoJ8dECnUMt
	L3T7uwoRQ5/YRcSTfBv+adhM/nehahPOfYLoOwBrpYefDYnT/Y2O6B+hgKxgv0geg5cmjAaR2Cb
	2ZAdnTlLZxOBHmHlNywqqsT5YQlvgzpGXDt7kcwJWzSYS+TnvRxpXIZohN/jxXTlqnUyuAGrg==
X-Received: by 2002:a05:622a:4d2:b0:50f:c1d4:d9e1 with SMTP id
 d75a77b69052e-51e4f0309b9mr2467041cf.38.1784061477651; Tue, 14 Jul 2026
 13:37:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAMq8zouhDMRW4Q7qSpMCFftp21wCzuC+RaJKsKz0sUivGAQHXA@mail.gmail.com>
 <c684823d-4be1-48ba-94ac-f2c01551f832@gmail.com> <CAMq8zou2PAgGRp4xZsEQ0TBz7ScANnVxUJ8t-qrJ4pMe86zyQw@mail.gmail.com>
In-Reply-To: <CAMq8zou2PAgGRp4xZsEQ0TBz7ScANnVxUJ8t-qrJ4pMe86zyQw@mail.gmail.com>
From: =?UTF-8?B?0JDQu9C10LrRgdC10Lk=?= <aleksman4o@gmail.com>
Date: Tue, 14 Jul 2026 23:37:46 +0300
X-Gm-Features: AUfX_mzeITOnObHsUYf1VJqbXEIgDqJ8pBJ2iT2Ac2VYP8wnowdWKTur9R7eoxE
Message-ID: <CAMq8zovfoSwdEz97eRb4A+bohHtt_XCYO72uAuUiecJZquc01g@mail.gmail.com>
Subject: [PATCH 1/3] network: expose RSN capabilities on BSS
To: James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

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
@@ -2198,10 +2198,120 @@ static bool
network_bss_property_get_address(struct l_dbus *dbus,
  return true;
 }

+struct network_bss_suite_name {
+ uint32_t suite;
+ const char *name;
+};
+
+static const struct network_bss_suite_name network_bss_akm_names[] = {
+ { IE_RSN_AKM_SUITE_PSK, "wpa-psk" },
+ { IE_RSN_AKM_SUITE_FT_USING_PSK, "wpa-ft-psk" },
+ { IE_RSN_AKM_SUITE_PSK_SHA256, "wpa-psk-sha256" },
+ { IE_RSN_AKM_SUITE_8021X, "wpa-eap" },
+ { IE_RSN_AKM_SUITE_FT_OVER_8021X, "wpa-ft-eap" },
+ { IE_RSN_AKM_SUITE_8021X_SHA256, "wpa-eap-sha256" },
+ { IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA256, "wpa-eap-suite-b" },
+ { IE_RSN_AKM_SUITE_8021X_SUITE_B_SHA384, "wpa-eap-suite-b-192" },
+ { IE_RSN_AKM_SUITE_FT_OVER_8021X_SHA384, "wpa-ft-eap-sha384" },
+ { IE_RSN_AKM_SUITE_FILS_SHA256, "wpa-fils-sha256" },
+ { IE_RSN_AKM_SUITE_FILS_SHA384, "wpa-fils-sha384" },
+ { IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256, "wpa-ft-fils-sha256" },
+ { IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384, "wpa-ft-fils-sha384" },
+ { IE_RSN_AKM_SUITE_SAE_SHA256, "sae" },
+ { IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256, "ft-sae" },
+ { IE_RSN_AKM_SUITE_OWE, "owe" },
+};
+
+static const struct network_bss_suite_name network_bss_pairwise_names[] = {
+ { IE_RSN_CIPHER_SUITE_TKIP, "tkip" },
+ { IE_RSN_CIPHER_SUITE_CCMP, "ccmp" },
+ { IE_RSN_CIPHER_SUITE_GCMP, "gcmp" },
+ { IE_RSN_CIPHER_SUITE_CCMP_256, "ccmp-256" },
+ { IE_RSN_CIPHER_SUITE_GCMP_256, "gcmp-256" },
+};
+
+static const struct network_bss_suite_name network_bss_group_names[] = {
+ { IE_RSN_CIPHER_SUITE_WEP40, "wep40" },
+ { IE_RSN_CIPHER_SUITE_WEP104, "wep104" },
+ { IE_RSN_CIPHER_SUITE_TKIP, "tkip" },
+ { IE_RSN_CIPHER_SUITE_CCMP, "ccmp" },
+ { IE_RSN_CIPHER_SUITE_GCMP, "gcmp" },
+ { IE_RSN_CIPHER_SUITE_CCMP_256, "ccmp-256" },
+ { IE_RSN_CIPHER_SUITE_GCMP_256, "gcmp-256" },
+};
+
+static void network_bss_append_suite_names(
+ struct l_dbus_message_builder *builder,
+ const char *name, uint32_t suites,
+ const struct network_bss_suite_name *names,
+ size_t names_len)
+{
+ size_t i;
+
+ l_dbus_message_builder_enter_dict(builder, "sv");
+ l_dbus_message_builder_append_basic(builder, 's', name);
+ l_dbus_message_builder_enter_variant(builder, "as");
+ l_dbus_message_builder_enter_array(builder, "s");
+
+ for (i = 0; i < names_len; i++)
+ if (suites & names[i].suite)
+ l_dbus_message_builder_append_basic(builder, 's',
+ names[i].name);
+
+ l_dbus_message_builder_leave_array(builder);
+ l_dbus_message_builder_leave_variant(builder);
+ l_dbus_message_builder_leave_dict(builder);
+}
+
+static const char *network_bss_group_cipher_name(
+ enum ie_rsn_cipher_suite cipher)
+{
+ size_t i;
+
+ for (i = 0; i < L_ARRAY_SIZE(network_bss_group_names); i++)
+ if (network_bss_group_names[i].suite == cipher)
+ return network_bss_group_names[i].name;
+
+ return "";
+}
+
+static bool network_bss_property_get_rsn(struct l_dbus *dbus,
+ struct l_dbus_message *message,
+ struct l_dbus_message_builder *builder,
+ void *user_data)
+{
+ struct scan_bss *bss = user_data;
+ struct ie_rsn_info info;
+ const char *group;
+
+ if (!bss->rsne || ie_parse_rsne_from_data(bss->rsne, bss->rsne[1] + 2,
+ &info) < 0)
+ return false;
+
+ l_dbus_message_builder_enter_array(builder, "{sv}");
+
+ network_bss_append_suite_names(builder, "KeyMgmt", info.akm_suites,
+ network_bss_akm_names,
+ L_ARRAY_SIZE(network_bss_akm_names));
+ network_bss_append_suite_names(builder, "Pairwise",
+ info.pairwise_ciphers,
+ network_bss_pairwise_names,
+ L_ARRAY_SIZE(network_bss_pairwise_names));
+
+ group = network_bss_group_cipher_name(info.group_cipher);
+ dbus_append_dict_basic(builder, "Group", 's', group);
+
+ l_dbus_message_builder_leave_array(builder);
+
+ return true;
+}
+
 static void setup_bss_interface(struct l_dbus_interface *interface)
 {
  l_dbus_interface_property(interface, "Address", 0, "s",
  network_bss_property_get_address, NULL);
+ l_dbus_interface_property(interface, "RSN", 0, "a{sv}",
+ network_bss_property_get_rsn, NULL);
 }

 static int network_init(void)
-- 
2.55.0
