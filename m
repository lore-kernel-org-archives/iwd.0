Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB694690
	for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 17:59:04 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id 12so17752643pga.1
        for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 10:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=wXDriboPA7Pt5wyY/fwcamBHlraw9IFgUdWuZHaA6b4=;
        b=Jas64FxWcERorrjhjOkOOcHpWMQHLVyDgXzbCzWykgQBH3kbDWOy3ra7So0i45fwjB
         fnYeBFIdgvWTN3C3rhLEGLiJQvuy2HUyvMCoSWFf+iuYZYIHRzonappgmAwNI1nDRLo8
         A2Con4C3qMjbIqtyl8NrWY01tbuFj59GC0RxSy6/d6++TDdc1Gkxg+RFN8FoJaccy/g+
         mn3DkEbOgSgJ+5JPS5f+skce3Pt+LvqXSwkpysp2YKDxw49VN78KO1D3A93KGfNRgCFn
         LNBcDiPqmlfHPqyhFOrkFkX5Ld06RkPTy6UM6LfoPL6thQHHuPVwP6Sa+9hxxmRtFnsm
         PvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=wXDriboPA7Pt5wyY/fwcamBHlraw9IFgUdWuZHaA6b4=;
        b=y/n5KDJEIzxzwKklW6GZ/JwR0/9/qmgKK/NMp+QbX6ryWs14eBONn1B4u5SkDzXOM3
         WouQ2fqmYHp5yVhT2/cds6aITH6qYduO5/qZf3met0JTHJOEd3U35PQr4piHYgMOB8Qi
         51GYsf33BrPLtx+v3ZE01h8FXGAUBXXg0FypXNAk26f6mGhWY3Ac/TnPgdrAfTkP0JSh
         MzbVkCd3wrnNPLdH9arT4My8ydZEHdji+cKES97A/VqcdLt1kJMV2bdPyBhfq4ntQOV6
         H65pQw19bESTwB2VxAJi6+pG4ulQ4SwlzyYcz+gXU5C8B56Y+bMi32c1bizi5QXdeWEi
         ekiQ==
X-Gm-Message-State: ACgBeo0282x96jf7qlsQd4jsN+TChBygocV6vGxe8geJhu8e0tCFfLd/
	J+OdiEsUe6RPputUbGh1hOC7lfFGi/4=
X-Google-Smtp-Source: AA6agR7fGl6yplpS8fofOFqFe7n7FfHNBacGpG3yb94JGDDR6cRgiQJB+89fSN0zsV0AtfxntNMUeQ==
X-Received: by 2002:a05:6a00:1a14:b0:52d:5fee:d46b with SMTP id g20-20020a056a001a1400b0052d5feed46bmr367405pfv.82.1660240744001;
        Thu, 11 Aug 2022 10:59:04 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w125-20020a626283000000b0052ab602a7d0sm4292685pfb.100.2022.08.11.10.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 10:59:03 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/6] station: add debug method GetNetworks
Date: Thu, 11 Aug 2022 10:58:56 -0700
Message-Id: <20220811175900.443310-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220811175900.443310-1-prestwoj@gmail.com>
References: <20220811175900.443310-1-prestwoj@gmail.com>
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
 src/station.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

v2:
 * Made Rank a uint16
 * Made Address a string, this makes parsing on the iwctl side
   a bit easier.
 * Use path as dictionary keys to avoid possible duplication. This
   also makes the hidden array cleaner since we can use /hidden
   instead of an empty string.

diff --git a/src/station.c b/src/station.c
index 57dbd0d5..0d2b0990 100644
--- a/src/station.c
+++ b/src/station.c
@@ -4600,6 +4600,106 @@ static struct l_dbus_message *station_property_set_autoconnect(
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
+		goto try_hidden;
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
+try_hidden:
+	if (l_queue_isempty(station->hidden_bss_list_sorted))
+		goto done;
+
+	/*
+	 * Hidden Networks. Use a special /hidden path for these which should
+	 * never conflict with a real network path
+	 */
+	l_dbus_message_builder_enter_dict(builder, "oaa{sv}");
+	l_dbus_message_builder_append_basic(builder, 'o', "/hidden");
+	l_dbus_message_builder_enter_array(builder, "a{sv}");
+	station_append_bss_list(builder,
+			l_queue_get_entries(station->hidden_bss_list_sorted));
+	l_dbus_message_builder_leave_array(builder);
+	l_dbus_message_builder_leave_dict(builder);
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
@@ -4612,6 +4712,9 @@ static void station_setup_debug_interface(
 	l_dbus_interface_method(interface, "Scan", 0,
 					station_debug_scan, "", "aq",
 					"frequencies");
+	l_dbus_interface_method(interface, "GetNetworks", 0,
+				station_debug_get_networks, "a{oaa{sv}}", "",
+				"networks");
 
 	l_dbus_interface_signal(interface, "Event", 0, "sav", "name", "data");
 
-- 
2.34.3

