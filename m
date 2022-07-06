Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B4B2F21
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 21:31:02 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id a15so15429772pfv.13
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 14:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gKdUJO5ZwHb4qiMXCCu0nn9rfz7x5XKmG9AsGRamOfY=;
        b=LR34VQCkeob/a4YUJDGVF0r88T+Fo3qS7DVLba4OHpnralfblRSXY7uC1Lp8VGa3ml
         ztyvvKU3Fsp5ob4A9pe8x05HtIb8GkXaPvXLiFMseJ/H8ohiF6DTq0TnevqUbcQjobEM
         UNpjTUjs+qwC8ir7fjVHzN4UlmYzMPqG6nFzW5L90ZBZiznSfg65ZbI2JLlwjIErAOIy
         rLsWh9ey3+AerjmN/N26zyS2GoJprG7jcxEclYbZ+scEA8RLLshE8wdg2yeMxfEMnEys
         fvnkbj/4iEBehTexCWsBIsvsVFYZ66VTH83qZJBgZ1gqHJTl0iDDoELKqaoot+jx2Ard
         fHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gKdUJO5ZwHb4qiMXCCu0nn9rfz7x5XKmG9AsGRamOfY=;
        b=muqivwPzXOWQPujakIs1jW27dDwCW0oVTX1UsYVt0UvRboNUMzEu2XoQwJ3+J/2kRz
         U4GNeA2AAJdmrrJCJrOtR2d8XJeB2/ofhCYsQguyU2HrtAWGYRw/rYYsR8+GnLkUuZxf
         tcfzumvyd9nEXDh/nPk9YFeGctd1tmSHLrpWjOboDafyUGOEw3wLCEvpy8v2+NRmm23S
         13HU39cOUoYueA+WSPlfvs6UU30UgCpyXNU7gDai9suuZJ04gtv13jOUROGY5CLiu6o8
         0dX/8mLNOM/SEk25LIn11MgXnkIiPbU2hSUMBMTMAFXewL5gZkK/BwJLZwkc+UoQaTu+
         Em3Q==
X-Gm-Message-State: AJIora/b8I++LxScyNgErWE+/3gWMs+jkeEkj9foRXOBmkLpsO+Tg581
	pnlT3qSAJw1M1781Pc/kZZbQiHCpWrA=
X-Google-Smtp-Source: AGRyM1t2puIZBGq98YTFrGUJswsZTVU/sfYqOMZHjmqP0ZF3MAclmcw1XjEhEMOYvaefY4qeFkRXPg==
X-Received: by 2002:a05:6a00:2387:b0:525:7314:7cf with SMTP id f7-20020a056a00238700b00525731407cfmr49907514pfc.84.1657143061830;
        Wed, 06 Jul 2022 14:31:01 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id v6-20020aa799c6000000b00527f5aee1a4sm15347609pfi.33.2022.07.06.14.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:31:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 04/14] client: update station to use display_table_row
Date: Wed,  6 Jul 2022 14:28:41 -0700
Message-Id: <20220706212851.92685-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706212851.92685-1-prestwoj@gmail.com>
References: <20220706212851.92685-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This includes updating diagnostics too, otherwise the output becomes
really nasty.
---
 client/diagnostic.c | 32 +++++++++++++-------------------
 client/station.c    | 42 +++++++++++++++++++-----------------------
 2 files changed, 32 insertions(+), 42 deletions(-)

diff --git a/client/diagnostic.c b/client/diagnostic.c
index 9e255918..6360b7e2 100644
--- a/client/diagnostic.c
+++ b/client/diagnostic.c
@@ -69,12 +69,13 @@ static bool display_bitrate_100kbps(struct l_dbus_message_iter *variant,
 				int name_column_width, int value_column_width)
 {
 	uint32_t rate;
+	char str[50];
 
 	if (!l_dbus_message_iter_get_variant(variant, "u", &rate))
 		return false;
 
-	display("%s%-*s%-*u Kbit/s\n", margin, name_column_width, key,
-			value_column_width, rate * 100);
+	sprintf(str, "%u Kbit/s", rate * 100);
+	display_table_row(margin, 3, 8, "", name_column_width, key, value_column_width, str);
 
 	return true;
 }
@@ -110,6 +111,7 @@ void diagnostic_display(struct l_dbus_message_iter *dict,
 		uint32_t u_value;
 		int16_t n_value;
 		uint8_t y_value;
+		int bytes;
 
 		map = find_mapping(key, diagnostic_mapping);
 		if (!map)
@@ -132,9 +134,7 @@ void diagnostic_display(struct l_dbus_message_iter *dict,
 							&s_value))
 				goto parse_error;
 
-			sprintf(display_text, "%s%-*s%-*s", margin,
-					name_column_width, key,
-					value_column_width, s_value);
+			bytes = sprintf(display_text, "%s", s_value);
 			break;
 
 		case 'u':
@@ -142,9 +142,7 @@ void diagnostic_display(struct l_dbus_message_iter *dict,
 							&u_value))
 				goto parse_error;
 
-			sprintf(display_text, "%s%-*s%-*u", margin,
-						name_column_width, key,
-						value_column_width, u_value);
+			bytes = sprintf(display_text, "%u", u_value);
 			break;
 
 		case 'n':
@@ -152,9 +150,7 @@ void diagnostic_display(struct l_dbus_message_iter *dict,
 							&n_value))
 				goto parse_error;
 
-			sprintf(display_text, "%s%-*s%-*i", margin,
-						name_column_width, key,
-						value_column_width, n_value);
+			bytes = sprintf(display_text, "%i", n_value);
 			break;
 
 		case 'y':
@@ -162,21 +158,19 @@ void diagnostic_display(struct l_dbus_message_iter *dict,
 							&y_value))
 				goto parse_error;
 
-			sprintf(display_text, "%s%-*s%-*u", margin,
-						name_column_width, key,
-						value_column_width, y_value);
+			bytes = sprintf(display_text, "%u", y_value);
 			break;
 
 		default:
-			display("type %c not handled", map->type);
+			display("type %c not handled\n", map->type);
 			continue;
 		}
 
 		if (map->units)
-			display("%s %s\n", display_text,
-					(const char *)map->units);
-		else
-			display("%s\n", display_text);
+			sprintf(display_text + bytes, " %s", map->units);
+
+		display_table_row(margin, 3, 8, "", name_column_width,
+					key, value_column_width, display_text);
 	}
 
 	return;
diff --git a/client/station.c b/client/station.c
index 68d7ee8c..1a573674 100644
--- a/client/station.c
+++ b/client/station.c
@@ -186,8 +186,7 @@ static void display_addresses(const char *device_name)
 				continue;
 
 			have_address = true;
-			display("%s%*s  %-*s%-*s\n", MARGIN, 8, "", 20,
-				"IPv4 address", 47, addrstr);
+			display_table_row(MARGIN, 3, 8, "", 20, "IPv4 address", 47, addrstr);
 		}
 	}
 
@@ -200,8 +199,7 @@ static void display_addresses(const char *device_name)
 	if (r < 0 || r == 1)
 		return;
 
-	display("%s%*s  %-*s%-*s\n", MARGIN, 8, "", 20,
-			"No IP addresses", 47, "Is DHCP client configured?");
+	display_table_row(MARGIN, 3, 8, "", 20, "No IP addresses", 47, "Is DHCP client configured?");
 }
 
 
@@ -215,9 +213,9 @@ static void display_station(const char *device_name,
 	l_free(caption);
 
 	if (station->connected_network) {
-		display("%s%*s  %-*s%-*s\n", MARGIN, 8, "", 20,
-				"Connected network", 47,
-				network_get_name(station->connected_network));
+		display_table_row(MARGIN, 3, 8, "", 20, "Connected network",
+			47, network_get_name(station->connected_network));
+
 		display_addresses(device_name);
 
 		/*
@@ -246,10 +244,8 @@ static void display_station_inline(const char *margin, const void *data)
 	if (!identity)
 		return;
 
-	display("%s%-*s%-*s%-*s\n", margin,
-			20, identity,
-			15, station->state ? : "",
-			8, station->scanning ? "scanning" : "");
+	display_table_row(margin, 3, 20, identity, 15, station->state ? : "",
+				8, station->scanning ? "scanning" : "");
 }
 
 static enum cmd_status cmd_list(const char *device_name, char **argv, int argc)
@@ -258,7 +254,8 @@ static enum cmd_status cmd_list(const char *device_name, char **argv, int argc)
 	struct l_queue *match =
 		proxy_interface_find_all(IWD_STATION_INTERFACE, NULL, NULL);
 
-	display_table_header("Devices in Station Mode", MARGIN "%-*s%-*s%-*s",
+	display_table_header("Devices in Station Mode",
+				MARGIN "%-*s  %-*s  %-*s",
 				20, "Name", 15, "State", 8, "Scanning");
 
 	if (!match) {
@@ -416,7 +413,7 @@ static void ordered_networks_display(struct l_queue *ordered_networks)
 	char *dbms = NULL;
 	const struct l_queue_entry *entry;
 
-	display_table_header("Available networks", "%s%-*s%-*s%-*s%*s",
+	display_table_header("Available networks", "%s%-*s  %-*s  %-*s  %*s",
 					MARGIN, 2, "", 32, "Network name",
 					18, "Security", 6, "Signal");
 
@@ -441,11 +438,11 @@ static void ordered_networks_display(struct l_queue *ordered_networks)
 		if (display_signal_as_dbms)
 			dbms = l_strdup_printf("%d", network->signal_strength);
 
-		display("%s%-*s%-*s%-*s%-*s\n", MARGIN, 2,
-			network_is_connected(network_i) ?
-				COLOR_BOLDGRAY "> " COLOR_OFF : "",
-			32, network_name, 18, network_type,
-			6, display_signal_as_dbms ? dbms :
+		display_table_row(MARGIN, 4, 2,
+				network_is_connected(network_i) ?
+				COLOR_BOLDGRAY "> " COLOR_OFF: "",
+				32, network_name, 18, network_type, 6,
+				display_signal_as_dbms ? dbms :
 				dbms_tostars(network->signal_strength));
 
 		if (display_signal_as_dbms) {
@@ -556,7 +553,7 @@ static void hidden_access_points_display(struct l_queue *access_points)
 {
 	const struct l_queue_entry *entry;
 
-	display_table_header("Available hidden APs", MARGIN "%-*s%-*s%*s",
+	display_table_header("Available hidden APs", MARGIN "%-*s  %-*s  %*s",
 				20, "Address", 10, "Security", 6, "Signal");
 
 	if (l_queue_isempty(access_points)) {
@@ -574,9 +571,8 @@ static void hidden_access_points_display(struct l_queue *access_points)
 		if (display_signal_as_dbms)
 			dbms = l_strdup_printf("%d", ap->signal_strength);
 
-		display(MARGIN "%-*s%-*s%-*s\n",
-			20, ap->address, 10, ap->type,
-			6, dbms ? : dbms_tostars(ap->signal_strength));
+		display_table_row(MARGIN, 3, 20, ap->address, 10, ap->type, 6,
+				dbms ? : dbms_tostars(ap->signal_strength));
 	}
 
 	display_table_footer();
@@ -676,7 +672,7 @@ static void get_diagnostics_callback(struct l_dbus_message *message,
 		goto done;
 	}
 
-	diagnostic_display(&iter, "            ", 20, 20);
+	diagnostic_display(&iter, MARGIN, 20, 47);
 
 done:
 	/* Finish the table started by cmd_show */
-- 
2.34.1

