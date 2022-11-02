Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C2F27731
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 22:51:41 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id 130so26548pfu.8
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 15:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbNujlfu+J3HoK4F5AleR1ZUeb6GBrDq4xd4MmX7zBY=;
        b=pRhJrGBSUDllABT2YoCd0unrWo+neSEIGolmKSH1V8S4xpaqfrVUSwhXlk2bAnTBpq
         JOB4Pmz/2ZH4j8f8tZGyQWy9SxV1DExPG2f9852mcKPoG/GKwoFV34jjpVtS6oYKQsCB
         LkOupr+T/BOLzyLnMY0I3sCc0mOC7lpNgwiEVDxftHs2z+FRKRwg7NmyCXPrNc1xVIP4
         4XH790Lqg0mXDQzTr3Ula0oh9RKhDjqwDAUsu+a+MneWXOAnZXdqKzBAEiyvBu6n8SDJ
         rg7UR/EZCLC4uRcDR5D8MzHleYptTvYvN2KKiQAuZ8yKdIKFOnPxTZygbnCV8jZ6r5t+
         1F5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbNujlfu+J3HoK4F5AleR1ZUeb6GBrDq4xd4MmX7zBY=;
        b=4p2SYUbW5u1TBYfNMgxmVwIDHowgD/ZVRKLL0lhq8U5F9qrwRomC7fIEkqoVDhrk8y
         RbVpp9IWkXqC0Fkyz+1d4epntVHcDOJS8gpff0PWZKRIOx9Rk/LucVX7JSzCoEra1tTm
         B2DA9M/J0ZfOf9goPI7NvbzMrGyxJ4jKSPRVBSQfLQSV+KcMZqlccsVSS4QwayIGZN/W
         UHopMghkhJUAZlENqs6AnUM7tMDSxbPRqggB/MdYv2gz5rCIFTi5GIFuFuYWjYVzxXFw
         f4X6UkUe5yyoIi1Zs79NK3DczJyf+QQkq+N/AMRrXt64CM7NSF0vCUp5zAzIJSwfv8KA
         J07w==
X-Gm-Message-State: ACrzQf3Zr7Bal9bNJuLS329T7ZzhfyCpR6c8YxnHDxItP0YWgFKD7Rez
	5bKSfitHZCu+L4vD8LN5nrPJmK29n5s=
X-Google-Smtp-Source: AMsMyM7UxcS72ObtBJHEe3Q2ggfNtu9T3nn/Q+0QbWDSmxGafwIdZZVGSDKblRkBFwIp0LU5aGIyvg==
X-Received: by 2002:a63:c146:0:b0:46f:c9e8:777d with SMTP id p6-20020a63c146000000b0046fc9e8777dmr14872964pgi.459.1667429500781;
        Wed, 02 Nov 2022 15:51:40 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090301d200b00186b945c0d1sm8920377plh.2.2022.11.02.15.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:51:39 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 06/11] ap: add PairwiseCiphers/GroupCipher to dbus interface
Date: Wed,  2 Nov 2022 15:51:11 -0700
Message-Id: <20221102225116.297129-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221102225116.297129-1-prestwoj@gmail.com>
References: <20221102225116.297129-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose these values on the DBus interface so clients can view them.
---
 src/ap.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index 44440191..33f2d1e4 100644
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
@@ -3690,6 +3709,12 @@ static void ap_if_event_func(enum ap_event_type type, const void *event_data,
 		l_dbus_property_changed(dbus_get_bus(),
 					netdev_get_path(ap_if->netdev),
 					IWD_AP_INTERFACE, "Name");
+		l_dbus_property_changed(dbus_get_bus(),
+					netdev_get_path(ap_if->netdev),
+					IWD_AP_INTERFACE, "PairwiseCiphers");
+		l_dbus_property_changed(dbus_get_bus(),
+					netdev_get_path(ap_if->netdev),
+					IWD_AP_INTERFACE, "GroupCipher");
 
 		l_rtnl_set_linkmode_and_operstate(rtnl,
 					netdev_get_ifindex(ap_if->netdev),
@@ -3711,6 +3736,12 @@ static void ap_if_event_func(enum ap_event_type type, const void *event_data,
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
@@ -4061,6 +4092,44 @@ static bool ap_dbus_property_get_freq(struct l_dbus *dbus,
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
@@ -4082,6 +4151,10 @@ static void ap_setup_interface(struct l_dbus_interface *interface)
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

