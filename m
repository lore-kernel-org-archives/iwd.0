Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8002E27702
	for <iwd@lists.linux.dev>; Wed,  2 Nov 2022 20:53:41 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id io19so17721785plb.8
        for <iwd@lists.linux.dev>; Wed, 02 Nov 2022 13:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/K6JZkLJtSnMW6gBVdZ02rslfrQETuyfaorVmLfvSg=;
        b=affo3uwfQH/+SnZci+By4cjc/5BH0P1ki5+8+je1XQMdGJ495A9N0pHGAE5KX1rPW2
         iVPU/y/YJFplRrbTc4AHwlDI4jC7W1b4UZze2ZEI9Xc5CIwlRj/qa+gEQGqGcFKJUI+5
         +33p7FTWCwKS5sOIR677h5S4o6f4o01fiHKnALR2ZjdeuV4E9Ef1xjEHXe4Ix4BpVnWJ
         A/O1x/FT5j0rz4T1XT68ZJoShbcIgCeSJzPvPFitbdsWUnD4zbGQZt/wFhMc9KqdJmqm
         zHCKgcscaYk77BCeH3DrmKqT6Ev6JuizkLD/XVszoCE2wR6n3ePV9GBBJKe0mDdivCoI
         sBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/K6JZkLJtSnMW6gBVdZ02rslfrQETuyfaorVmLfvSg=;
        b=vUzElAozRkIwhdsN8uRrIcYHDQBO5SK3fcl/jwscaMPXwt7BkOgJLR8soJyn1b1ElV
         FvTMPi9z7WO7Q3MsWVPwRf04+50ZIQ56Cx7ieqossy/S121qkZ5ramTiuz0gphV+I5Dr
         AFEQDdy6kyy8jOsjNI6/bNHamExWxp7sUEEvBaDSCtmAQ58RS1KyKZ9dTbdeGTQfBEg+
         Jc9Y1A+RVuA31zl4pBhrqoqRH/Dh0r92rzbT7opeKXR4J5etm1hTZN5b82z9A4OBoaLL
         gF4fZPTZhRi2n1ncW1cHkAC2IsHWdaWwQ4ExnRk0DvY3n4GZzV3Wr5PibvFdroWFbvfJ
         0Q4Q==
X-Gm-Message-State: ACrzQf2KJylv4bzC7ZNpRIk98Lms0Bt6r/NvWd8RHL6g28KJbDGY0TdS
	U3T7ChN2/XBBA2Lr+9R7CtpN2LuLD5k=
X-Google-Smtp-Source: AMsMyM4HiezX6Vh5XXSE14NIQdo3OLiXg1zqW3DZgWBO8QVuIkneQyA+YUhbeLjFzCah0Ui7DAY7nA==
X-Received: by 2002:a17:902:e803:b0:187:3a52:d262 with SMTP id u3-20020a170902e80300b001873a52d262mr9441912plg.85.1667422420803;
        Wed, 02 Nov 2022 13:53:40 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b00186c6d2e7e3sm8730755plb.26.2022.11.02.13.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:53:40 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 06/10] ap: add PairwiseCiphers/GroupCipher to dbus interface
Date: Wed,  2 Nov 2022 13:53:23 -0700
Message-Id: <20221102205327.268693-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221102205327.268693-1-prestwoj@gmail.com>
References: <20221102205327.268693-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose these values on the DBus interface so clients can view them.
---
 src/ap.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index 341a1662..bd78d2b5 100644
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
@@ -3690,6 +3709,15 @@ static void ap_if_event_func(enum ap_event_type type, const void *event_data,
 		l_dbus_property_changed(dbus_get_bus(),
 					netdev_get_path(ap_if->netdev),
 					IWD_AP_INTERFACE, "Name");
+		l_dbus_property_changed(dbus_get_bus(),
+					netdev_get_path(ap_if->netdev),
+					IWD_AP_INTERFACE, "Frequency");
+		l_dbus_property_changed(dbus_get_bus(),
+					netdev_get_path(ap_if->netdev),
+					IWD_AP_INTERFACE, "PairwiseCiphers");
+		l_dbus_property_changed(dbus_get_bus(),
+					netdev_get_path(ap_if->netdev),
+					IWD_AP_INTERFACE, "GroupCipher");
 
 		l_rtnl_set_linkmode_and_operstate(rtnl,
 					netdev_get_ifindex(ap_if->netdev),
@@ -4061,6 +4089,44 @@ static bool ap_dbus_property_get_freq(struct l_dbus *dbus,
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
@@ -4082,6 +4148,10 @@ static void ap_setup_interface(struct l_dbus_interface *interface)
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

