Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70AE2588
	for <iwd@lists.linux.dev>; Thu,  7 Jul 2022 17:57:24 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id e16so8135114pfm.11
        for <iwd@lists.linux.dev>; Thu, 07 Jul 2022 10:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gKdUJO5ZwHb4qiMXCCu0nn9rfz7x5XKmG9AsGRamOfY=;
        b=fOcFVK0PS27Va0XJN9RAE7EyDyIgTw0fd6lKu8d5n4XuLT2SSbOLfD48hESd/WuOkk
         Pz+QO/znzojBm+sF8DabSjQ5FiRzh0pK8m218xGmFjDAKO++Q3sxcp7ONfxodxDbh9Dx
         D4iIOuoyFjfWnmXTbyi7YK2VzMLzxA77E0pzLOe+6wa1aRYmey54OHUP84Rh5HnWahD3
         6KIof5JToaLDkoqKCWiAq53UezkK6v6i0XJWjaNQXq0k1WV2zdjf8K1e8KvG4Dje/CSW
         CsCq6D2KxKMWQpTLiUScn+MSuOp0y1QVnkMXkAfLKhjXX94vVezHbULeQebA7xl7QU64
         4LHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gKdUJO5ZwHb4qiMXCCu0nn9rfz7x5XKmG9AsGRamOfY=;
        b=V5nBMDMSg1m8QfRvJXczi6sbqcdtytJbB6BkWKJsZXJc8RlEl6a2g4Exufdgjlqayw
         xg0LuGkxJ+8IfRfPat4AuCEJRR2eMhWYZ2b3qbVsYBWsvmEA2z08/62DT4w1HNftPhxf
         siBzNWQCnIOFPb9ccHa3ZYjvVwhKoRuuZFtxEInXxoyVDs5NvhwWDGmwTdHoobuBayrO
         PHFUiY+oh2e3i1VD2xqmttfwG3PBRV+Tov2s6LZCY6HWifCYlVs3jIWjivbVI70lSiT/
         SZU8L3RWzfAHdiBG1nF8/72f+FPzCYvLdShaHZEeoR4OBnMRk662/8633BBoS6ZkkPBR
         EVTQ==
X-Gm-Message-State: AJIora/yPuJANT0xnIrU8P4ETKvmhmXEUj7wx+AvUFvp70iDJq7L+Ft5
	dZhR5ejiLQxuNObkbAKiunomTlNM0U0=
X-Google-Smtp-Source: AGRyM1tnLYhzkI0Que6hSFbzPA6HMzXpVa5Uz8pcu1K7RoNiPfqsTwFT3axXy9dp23m4WJSqp8++hA==
X-Received: by 2002:a17:903:2310:b0:16b:fbc4:bfb1 with SMTP id d16-20020a170903231000b0016bfbc4bfb1mr12689450plh.100.1657216644130;
        Thu, 07 Jul 2022 10:57:24 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b001618b70dcc9sm28855223plg.101.2022.07.07.10.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:57:23 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 04/14] client: update station to use display_table_row
Date: Thu,  7 Jul 2022 10:55:01 -0700
Message-Id: <20220707175511.224597-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220707175511.224597-1-prestwoj@gmail.com>
References: <20220707175511.224597-1-prestwoj@gmail.com>
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

