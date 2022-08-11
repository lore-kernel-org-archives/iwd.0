Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EBA4A0F
	for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 18:47:39 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id o3so17666861ple.5
        for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 11:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=A7LOA1OwzhRcAntRdWxP2AFiw4AilpcarcHxoDbK+MY=;
        b=LrJcCAH6rWGjJTxaqD746PyeYwDhJCKSmVpFb1MjCt7HGQIbbfLbjjKvj0pl+Wbio3
         mJv7oNjbwAATiAejDxk77lPsnHDD7DOeAYM0Jl2aGryz0cdiIeJgNlG4LPmXnn0Zcidi
         POISd5LZqVh2id8in/xxnRFbdLv2CC5CZnvqx8Fmglu9xtkoTuZYmF7y4vUmfKOqzZt6
         hOvYhTBYt5EAzQvH7ngc4oeT2oNHfK0umHdZS8p8oFHdyTvRq0nu4reA/j8vorY+J22I
         RxrV39GZdUaLiB448sdoi2KolW+1otkeUvXJV0UDHDqv0nP0TdqQ+pH3J56GjFvaffp0
         IrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=A7LOA1OwzhRcAntRdWxP2AFiw4AilpcarcHxoDbK+MY=;
        b=hSEOp3kEyepszDl7/oxNsk/Q2DOtiFqMh5Tkvkg8dHpix2S9PqGOk38yukkux6cEev
         +Hpz8FhAKd4A25dQSyf2ctAEVvlzWGL0oUjyc2dytfBwAJKj17om4WaembEl4jP9P13t
         NSCNPyj10ElmNG+DqB/ULlcug0+nLd3g7PCXgelBDTlxJPgk05MCkCF7pS7FIrB8BDnZ
         Vfei4/21lPPjUfyvjC4vQvyhXNF9gOK1mCOw8aGOz/l2ZW+w8GqzrUhnPpq4//v2d5jd
         +HA13fz83AUTVGb3CgG0uIiCVeFMKEuiG0QzIAi/BykQ/IaktZBJ/IvmSW6CTPv7dO6l
         UPXA==
X-Gm-Message-State: ACgBeo1pGiA9dtITWKUMCiwRBCa3H7kJkNH2BbYNuJDmvVW24axebu9l
	lYR0ihVvkMu16Hu9ehrK3AZBMKl7p8U=
X-Google-Smtp-Source: AA6agR4Tjx7lDP/rweLTJ6vRAq61YH+Vi2sA0j2+IQA//qnavrXQN3JUdA5h3bDlHDBM+xr3AxbU8A==
X-Received: by 2002:a17:90b:33c4:b0:1f5:8428:beb9 with SMTP id lk4-20020a17090b33c400b001f58428beb9mr9978751pjb.95.1660243658334;
        Thu, 11 Aug 2022 11:47:38 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79983000000b0052b84ca900csm24986pfh.62.2022.08.11.11.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 11:47:38 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/6] station: add debug method GetNetworks
Date: Thu, 11 Aug 2022 11:47:31 -0700
Message-Id: <20220811184735.465951-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220811184735.465951-1-prestwoj@gmail.com>
References: <20220811184735.465951-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This gets all networks but includes individual entries for each
BSS.
---
 src/station.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

v3:
 * Removed hidden networks from the list. GetHiddenAccessPoints could
   be used instead.

diff --git a/src/station.c b/src/station.c
index 57dbd0d5..66b296b8 100644
--- a/src/station.c
+++ b/src/station.c
@@ -4600,6 +4600,90 @@ static struct l_dbus_message *station_property_set_autoconnect(
 	return l_dbus_message_new_method_return(message);
 }
 
+static void station_append_byte_array(struct l_dbus_message_builder *builder,
+					const char *name,
+					const uint8_t *bytes, size_t len)
+{
+	size_t i;
+
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_append_basic(builder, 's', name);
+	l_dbus_message_builder_enter_variant(builder, "ay");
+	l_dbus_message_builder_enter_array(builder, "y");
+
+	for (i = 0; i < len; i++)
+		l_dbus_message_builder_append_basic(builder, 'y', &bytes[i]);
+
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_leave_variant(builder);
+	l_dbus_message_builder_leave_dict(builder);
+}
+
+static void station_append_bss_list(struct l_dbus_message_builder *builder,
+					const struct l_queue_entry *entry)
+{
+	for (; entry; entry = entry->next) {
+		struct scan_bss *bss = entry->data;
+		int32_t rssi = bss->signal_strength / 100;
+
+		l_dbus_message_builder_enter_array(builder, "{sv}");
+
+		dbus_append_dict_basic(builder, "Frequency", 'u',
+						&bss->frequency);
+		dbus_append_dict_basic(builder, "RSSI", 'i',
+						&rssi);
+		dbus_append_dict_basic(builder, "Rank", 'q', &bss->rank);
+
+		dbus_append_dict_basic(builder, "Address", 's',
+					util_address_to_string(bss->addr));
+
+		station_append_byte_array(builder, "MDE", bss->mde, 3);
+
+		l_dbus_message_builder_leave_array(builder);
+	}
+}
+
+static struct l_dbus_message *station_debug_get_networks(struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct station *station = user_data;
+	struct l_dbus_message *reply =
+				l_dbus_message_new_method_return(message);
+	struct l_dbus_message_builder *builder =
+				l_dbus_message_builder_new(reply);
+	const struct l_queue_entry *entry;
+
+	l_dbus_message_builder_enter_array(builder, "{oaa{sv}}");
+
+	if (l_queue_isempty(station->networks_sorted))
+		goto done;
+
+	for (entry = l_queue_get_entries(station->networks_sorted); entry;
+							entry = entry->next) {
+		const struct network *network = entry->data;
+
+		l_dbus_message_builder_enter_dict(builder, "oaa{sv}");
+		l_dbus_message_builder_append_basic(builder, 'o',
+						network_get_path(network));
+		l_dbus_message_builder_enter_array(builder, "a{sv}");
+
+		station_append_bss_list(builder,
+					network_bss_list_get_entries(network));
+
+		l_dbus_message_builder_leave_array(builder);
+		l_dbus_message_builder_leave_dict(builder);
+	}
+
+done:
+	l_dbus_message_builder_leave_array(builder);
+
+	l_dbus_message_builder_finalize(builder);
+	l_dbus_message_builder_destroy(builder);
+
+	return reply;
+}
+
 static void station_setup_debug_interface(
 					struct l_dbus_interface *interface)
 {
@@ -4612,6 +4696,9 @@ static void station_setup_debug_interface(
 	l_dbus_interface_method(interface, "Scan", 0,
 					station_debug_scan, "", "aq",
 					"frequencies");
+	l_dbus_interface_method(interface, "GetNetworks", 0,
+				station_debug_get_networks, "a{oaa{sv}}", "",
+				"networks");
 
 	l_dbus_interface_signal(interface, "Event", 0, "sav", "name", "data");
 
-- 
2.34.3

