Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A1C21D51
	for <iwd@lists.linux.dev>; Tue,  1 Nov 2022 20:18:04 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id 130so14496484pfu.8
        for <iwd@lists.linux.dev>; Tue, 01 Nov 2022 13:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkYcLD3Uu8NA8QkrLyCBQllIjYcPzer+iB69Jx3h3fc=;
        b=mGiLLomIJryn1V4wUWBIBmgJ2XIGCukFM5dbzvtEUUSotYQ0Fj0XbROpHqW4LudH44
         uO4qLDi41QC6wZWl4ADU9Nkj2IUo+wQsZbYh4uZ8Si5RYC6ZXbm9Mhs15SFXNA3YeSYA
         eAfa8pDbwyRz+iQ0f8PyvwVjyE8t+TSa/zF6yOK+qWVLQccvkzwnb5pD/NV67Ras0wPN
         SNLnmwUuywTPqWHlmRe5SjJOEQFYoC4yFo0Zgpg6Lz1Ss+dvsyBKZBs+sQKZqxOa8tAt
         Hn/iKqtPrntJjGuv7tNLGF5wQhgFSTUjWuakKgKXc3MgyGCYaVW8oBjirdsgudbIcVEG
         lPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xkYcLD3Uu8NA8QkrLyCBQllIjYcPzer+iB69Jx3h3fc=;
        b=ZaAOlOLvFfMZao1aDrdsiLd6y+HsItDIuodL2kGJYIfRQ2PEvUVeWTTCFL2QXZwAsg
         MXfFna8CBp3p1zfRi0xqBf40ojY4KAK3BDYduzZPbU+iuIfdyDV3ur64rVGmqSdDhuGB
         6QD4CQULdwLQAJn6sSPQ5BspmW2HiTQasxM9m2rtBgbWw+2Fio4Seltrpvk/oot4VGoK
         DOQCddya2Ci3sNTMZpACdmfj+nq1Sd00XIqUqpLiei6TEt8MwrsjpNsavv7nJbT5YNto
         z3Q+NULTzdwEvzsqF0V8jrViLKjQEvK3iLfNmPz5jCGPIsvRYhci1/IHbzq4CRGYvqu1
         1QwQ==
X-Gm-Message-State: ACrzQf0CyPJZs3qmHIxxmsePHwHajBEAGNBrXgE5xXspFpxgQvt8duzL
	KYL33qltcfnx/fbNqhl4QOzsGyfbUCQ=
X-Google-Smtp-Source: AMsMyM6Q+pxv6rpQ+OsLm5MbHCnC+qfj4EWPRSptAHoIxIDvG+PDAr28Ma781Fd5abDqFekGH36/sA==
X-Received: by 2002:a63:c14:0:b0:456:d887:c83 with SMTP id b20-20020a630c14000000b00456d8870c83mr19109318pgl.53.1667333879354;
        Tue, 01 Nov 2022 13:17:59 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00180a7ff78ccsm6781681plg.126.2022.11.01.13.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:17:58 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 08/17] ap: add PairwiseCiphers/GroupCipher to dbus interface
Date: Tue,  1 Nov 2022 13:17:38 -0700
Message-Id: <20221101201747.143379-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221101201747.143379-1-prestwoj@gmail.com>
References: <20221101201747.143379-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose these values on the DBus interface so clients can view them.
---
 src/ap.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index baf90c1b..a6618c23 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -3154,6 +3154,25 @@ static enum ie_rsn_cipher_suite ap_string_to_cipher(const char *str)
 		return 0;
 }
 
+static char *ap_ciphers_to_string(uint16_t ciphers)
+{
+	uint16_t i;
+	char **list = l_strv_new();
+	char *ret;
+
+	for (i = 0; i < 16; i++) {
+		if (!(ciphers & (1 << i)))
+			continue;
+
+		list = l_strv_append(list,
+					ie_rsn_cipher_suite_to_string(1 << i));
+	}
+
+	ret = l_strjoinv(list, ',');
+	l_strv_free(list);
+	return ret;
+}
+
 static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
 				bool *out_cck_rates)
 {
@@ -3679,6 +3698,12 @@ static void ap_if_event_func(enum ap_event_type type, const void *event_data,
 		l_dbus_property_changed(dbus_get_bus(),
 					netdev_get_path(ap_if->netdev),
 					IWD_AP_INTERFACE, "Frequency");
+		l_dbus_property_changed(dbus_get_bus(),
+					netdev_get_path(ap_if->netdev),
+					IWD_AP_INTERFACE, "PairwiseCiphers");
+		l_dbus_property_changed(dbus_get_bus(),
+					netdev_get_path(ap_if->netdev),
+					IWD_AP_INTERFACE, "GroupCipher");
 
 		l_rtnl_set_linkmode_and_operstate(rtnl,
 					netdev_get_ifindex(ap_if->netdev),
@@ -4047,6 +4072,44 @@ static bool ap_dbus_property_get_freq(struct l_dbus *dbus,
 	return true;
 }
 
+static bool ap_dbus_property_get_pairwise(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct ap_if_data *ap_if = user_data;
+	char *list;
+
+	if (!ap_if->ap || !ap_if->ap->started)
+		return false;
+
+	list = ap_ciphers_to_string(ap_if->ap->ciphers);
+
+	l_dbus_message_builder_append_basic(builder, 's', list);
+	l_free(list);
+
+	return true;
+}
+
+static bool ap_dbus_property_get_group(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct ap_if_data *ap_if = user_data;
+	char *cipher;
+
+	if (!ap_if->ap || !ap_if->ap->started)
+		return false;
+
+	cipher = ap_ciphers_to_string(ap_if->ap->group_cipher);
+
+	l_dbus_message_builder_append_basic(builder, 's', cipher);
+	l_free(cipher);
+
+	return true;
+}
+
 static void ap_setup_interface(struct l_dbus_interface *interface)
 {
 	l_dbus_interface_method(interface, "Start", 0, ap_dbus_start, "",
@@ -4068,6 +4131,10 @@ static void ap_setup_interface(struct l_dbus_interface *interface)
 					ap_dbus_property_get_scanning, NULL);
 	l_dbus_interface_property(interface, "Frequency", 0, "u",
 					ap_dbus_property_get_freq, NULL);
+	l_dbus_interface_property(interface, "PairwiseCiphers", 0, "s",
+					ap_dbus_property_get_pairwise, NULL);
+	l_dbus_interface_property(interface, "GroupCipher", 0, "s",
+					ap_dbus_property_get_group, NULL);
 }
 
 static void ap_destroy_interface(void *user_data)
-- 
2.34.3

