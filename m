Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126D14A02
	for <iwd@lists.linux.dev>; Wed, 10 Aug 2022 23:16:24 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso3664301pjq.4
        for <iwd@lists.linux.dev>; Wed, 10 Aug 2022 16:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=o3Rjy5NwMKxNjMOHHbJXvC5jL9zULP6bFt4opPJz0LE=;
        b=hGBd7lJ0Fw5zwwtw8/XSwpj19stALC+RKF70sYaKBzXV5VAH+ttP54KPLyoTWatSNG
         T4BAtaTyLDUrpvGfwPkzVvQtiT0WiYt4C98jGjez99/bwd1liNSb4IdZkK8+wO5gWYHv
         DtRXlWEHwXRnE05IFlLcPxLvj4k1/syCVwh94aq6Eh8f+O767M5EzcWWMwJtUmJa7Hwv
         x+M3k1Iuk0N6pVOmNquqwVShCWsr5ILIuxuWiEvlBJnWmf6Lc6Dj0QpMKUjiUx0zjhwK
         ZndfFk9TP5Rh/fVVA+gv/cE67UdolDgEBchxWq6g1X1DV1ticOjy1jw4hu+SgLNhLJoI
         wfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=o3Rjy5NwMKxNjMOHHbJXvC5jL9zULP6bFt4opPJz0LE=;
        b=v/ybiIS5RpAjBCpqLgcXJk26G0WJw/kP+aCG1ZcM6utQKE1RXH5oo6yRc13+V6mAHO
         b2ARVeseXiJGwrOWm7SaV/GcxLi1sXVjp9tsY/9t5O709/6lUpyQ5fCzxyO0C4ZIk/xP
         xmobGBmn3aqZtpsmU7mOZeOV2Zc5sMh6QqO9aTEPvBDw3j1GciRhjY++TmdCbJ1XFP5L
         7hD3jS0n+2+dYVlH0TXtey1GpFNSuPgGhFDhTnBQhnZWEAFytQacl7h8fiqGO5oLmJMI
         XM1KRMeUxOWInCEUSMuMLshLsJtkS/6oSIaHrfWyhVZkmmYIOn85Hl+0v7bMt1kM48OV
         RDlA==
X-Gm-Message-State: ACgBeo3qVZViXxx2Ar0kxraKd1iXo2itnawfGqwInmarUMY05wexLAxs
	+VXsQW9adtHRPS4D2bbmHhJUU/TEwjU=
X-Google-Smtp-Source: AA6agR5EjBgnFyY7OoJ/eo5GHKAEh6Am7t1TPpaDf1ZxQM2VyOj0Wk97LPtw5mNGxVcC+34/Z0ESmQ==
X-Received: by 2002:a17:902:e890:b0:170:c2f:cb4d with SMTP id w16-20020a170902e89000b001700c2fcb4dmr24417835plg.114.1660173384360;
        Wed, 10 Aug 2022 16:16:24 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902e84700b0016d62ba5665sm13540246plg.254.2022.08.10.16.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 16:16:23 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/8] station: add debug method GetNetworks
Date: Wed, 10 Aug 2022 16:16:16 -0700
Message-Id: <20220810231621.372514-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220810231621.372514-1-prestwoj@gmail.com>
References: <20220810231621.372514-1-prestwoj@gmail.com>
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
 src/station.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/src/station.c b/src/station.c
index 57dbd0d5..4f0f2afc 100644
--- a/src/station.c
+++ b/src/station.c
@@ -4600,6 +4600,97 @@ static struct l_dbus_message *station_property_set_autoconnect(
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
+		dbus_append_dict_basic(builder, "Rank", 'i', &bss->rank);
+
+		station_append_byte_array(builder, "Address", bss->addr, 6);
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
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+
+	for (entry = l_queue_get_entries(station->networks_sorted); entry;
+							entry = entry->next) {
+		const struct network *network = entry->data;
+
+		l_dbus_message_builder_enter_dict(builder, "sv");
+		l_dbus_message_builder_append_basic(builder, 's',
+						network_get_ssid(network));
+		l_dbus_message_builder_enter_variant(builder, "aa{sv}");
+		l_dbus_message_builder_enter_array(builder, "a{sv}");
+
+		station_append_bss_list(builder,
+					network_bss_list_get_entries(network));
+
+		l_dbus_message_builder_leave_array(builder);
+		l_dbus_message_builder_leave_variant(builder);
+		l_dbus_message_builder_leave_dict(builder);
+	}
+
+	/* Hidden Networks. Use an empty string for the SSID */
+	l_dbus_message_builder_enter_dict(builder, "sv");
+	l_dbus_message_builder_append_basic(builder, 's', "");
+	l_dbus_message_builder_enter_variant(builder, "aa{sv}");
+	l_dbus_message_builder_enter_array(builder, "a{sv}");
+	station_append_bss_list(builder,
+			l_queue_get_entries(station->hidden_bss_list_sorted));
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_leave_variant(builder);
+	l_dbus_message_builder_leave_dict(builder);
+
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
@@ -4612,6 +4703,9 @@ static void station_setup_debug_interface(
 	l_dbus_interface_method(interface, "Scan", 0,
 					station_debug_scan, "", "aq",
 					"frequencies");
+	l_dbus_interface_method(interface, "GetNetworks", 0,
+				station_debug_get_networks, "a{sv}", "",
+				"networks");
 
 	l_dbus_interface_signal(interface, "Event", 0, "sav", "name", "data");
 
-- 
2.34.3

