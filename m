Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDC32563
	for <iwd@lists.linux.dev>; Thu,  7 Jul 2022 17:57:29 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id e132so19870161pgc.5
        for <iwd@lists.linux.dev>; Thu, 07 Jul 2022 10:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xRFSUNUSmipN05MnQpN5w2QZdhIlRQ5RwsiNiJvslkc=;
        b=M1oYB74VKZUkSB2PyUBnZdrbv+kTUwL7PiMZS4ipKKojsdoGH3Y2ThwIl9MY8wCBe8
         pWAlDnAepXyuCAe75aK7qrxmdUHBV97y9T5vyIy014tCFMVKMOAYQe7MRPwnH0yiz2xM
         370Yt/ijuKMqA3y5fyNdGsFlooT4HUFfEGoijcbL6N854zHRjd+Xh0KOtVuJzXsM0fwJ
         6EYOQ6ixmAXsLFqYfa+vBcGRRdAJ0gV1DW/QtKID9E32BcDvABd2TKJMj01Bidbd3v+4
         qSXQiaqwCfVVdWYaTSh8tQxjpRSuHV02MfcBgcRr5PGpOb8N2RuSwwCTEaiYYaw5Y45s
         i9Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xRFSUNUSmipN05MnQpN5w2QZdhIlRQ5RwsiNiJvslkc=;
        b=lPG10i+hRiJtAZ2sMfjEpkGVitNFqXCTAGJXBK1Zn8aYXUdNgGcTghxXj3irCdtDIk
         dN3i/Cvym4lwcHVcRKIBLubXtl9tqrm/VjOCZ90KXY8WAzVkn6Ov2DIbvBsPKIB149Yn
         SMESLIMhyPyBHtEdrw9J+f2xmjIEj4HD8pkyXbvJ7PeB5aovsc+tKxnYtLfCkUBZ//p7
         bPvdPs5NZRXkksYOxCyBo+OvkuLycAV59EtKWgxIda+0u0ElqY8TEPZ1I2j465zjXDwn
         nH8oqi+TpbdD1guA33CmAUX66p3Cfq/0MbXyJAAGLZpLXXIeYxlxab9ntTTt78aSJ5kG
         AGAA==
X-Gm-Message-State: AJIora84NKamW5DbQiGsK5VlT7Bsa1Q6Nn2xBJlUX+uaa7cjh8lNFKHh
	7d3tVkXL8u5SgSJbqrUAUi0ZkcxFGyQ=
X-Google-Smtp-Source: AGRyM1smMWYsvdOjp9/zC4iXtibPaKdaX0hrsy7n/dMIPWI18J1+9uSVna6apsYRWlRiux8G4lN1XA==
X-Received: by 2002:a17:902:7e85:b0:16c:593:d91a with SMTP id z5-20020a1709027e8500b0016c0593d91amr8317429pla.155.1657216648306;
        Thu, 07 Jul 2022 10:57:28 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b001618b70dcc9sm28855223plg.101.2022.07.07.10.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:57:27 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 08/14] client: make COLOR_* macros take a string input
Date: Thu,  7 Jul 2022 10:55:05 -0700
Message-Id: <20220707175511.224597-8-prestwoj@gmail.com>
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

The existing color code escape sequences required the user to set the
color, write the string, then unset with COLOR_OFF. Instead the macros
can be made to take the string itself and automatically terminate the
color with COLOR_OFF. This makes for much more concise strings.
---
 client/agent.c          |  4 ++--
 client/dbus-proxy.c     |  2 +-
 client/display.c        | 22 +++++++++++-----------
 client/display.h        | 19 +++++++++----------
 client/known-networks.c |  4 ++--
 client/station.c        |  8 ++++----
 6 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/client/agent.c b/client/agent.c
index 037ae785..6f2c9874 100644
--- a/client/agent.c
+++ b/client/agent.c
@@ -301,8 +301,8 @@ static struct l_dbus_message *request_user_password_method_call(
 	display("Type the network password for %s.\n",
 				proxy_interface_get_identity_str(proxy));
 
-	username_prompt = l_strdup_printf(COLOR_BLUE PROMPT_USERNAME " "
-						COLOR_OFF "%s\n", username);
+	username_prompt = l_strdup_printf(COLOR_BLUE(PROMPT_USERNAME " ")
+						"%s\n", username);
 	display("%s", username_prompt);
 	l_free(username_prompt);
 
diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
index bbb97eb5..1534488e 100644
--- a/client/dbus-proxy.c
+++ b/client/dbus-proxy.c
@@ -76,7 +76,7 @@ void proxy_properties_display(const struct proxy_interface *proxy,
 		str = properties[i].tostr(data);
 
 		display_table_row(MARGIN, 3, 8, properties[i].is_read_write ?
-				COLOR_BOLDGRAY "       *" COLOR_OFF : "",
+				COLOR_BOLDGRAY("       *") : "",
 				name_column_width, properties[i].name,
 				value_column_width, str ? : "");
 	}
diff --git a/client/display.c b/client/display.c
index 8ebbb656..004b0dea 100644
--- a/client/display.c
+++ b/client/display.c
@@ -40,7 +40,7 @@
 #include "client/display.h"
 
 #define IWD_PROMPT \
-	"\001" COLOR_GREEN "\002" "[iwd]" "\001" COLOR_OFF "\002" "# "
+	"\001" COLOR_GREEN("\002" "[iwd]" "\001") "\002" "# "
 #define LINE_LEN 81
 
 static struct l_signal *window_change_signal;
@@ -234,9 +234,9 @@ static void display_refresh_check_feasibility(void)
 	if (ws.ws_col < LINE_LEN - 1) {
 		if (display_refresh.enabled) {
 			display_refresh.recording = false;
-			display(COLOR_YELLOW "Auto-refresh is disabled. "
+			display(COLOR_YELLOW("Auto-refresh is disabled. "
 				"Enlarge window width to at least %u to enable."
-				"\n" COLOR_OFF, LINE_LEN - 1);
+				"\n"), LINE_LEN - 1);
 			display_refresh.recording = true;
 		}
 
@@ -317,7 +317,7 @@ void display(const char *fmt, ...)
 
 void display_error(const char *error)
 {
-	char *text = l_strdup_printf(COLOR_RED "%s" COLOR_OFF "\n", error);
+	char *text = l_strdup_printf(COLOR_RED("%s\n"), error);
 
 	display_text(text);
 
@@ -344,14 +344,14 @@ void display_table_header(const char *caption, const char *fmt, ...)
 	int caption_pos =
 		(int) ((sizeof(dashed_line) - 1) / 2 + strlen(caption) / 2);
 
-	text = l_strdup_printf("%*s" COLOR_BOLDGRAY "%*c" COLOR_OFF "\n",
+	text = l_strdup_printf("%*s" COLOR_BOLDGRAY("%*c") "\n",
 				caption_pos, caption,
 				LINE_LEN - 2 - caption_pos,
 				display_refresh.cmd ? get_flasher() : ' ');
 	display_text(text);
 	l_free(text);
 
-	text = l_strdup_printf("%s%s%s\n", COLOR_GRAY, dashed_line, COLOR_OFF);
+	text = l_strdup_printf(COLOR_GRAY("%s\n"), dashed_line);
 	display_text(text);
 	l_free(text);
 
@@ -359,12 +359,12 @@ void display_table_header(const char *caption, const char *fmt, ...)
 	text = l_strdup_vprintf(fmt, args);
 	va_end(args);
 
-	body = l_strdup_printf("%s%s%s\n", COLOR_BOLDGRAY, text, COLOR_OFF);
+	body = l_strdup_printf(COLOR_BOLDGRAY("%s\n"), text);
 	display_text(body);
 	l_free(body);
 	l_free(text);
 
-	text = l_strdup_printf("%s%s%s\n", COLOR_GRAY, dashed_line, COLOR_OFF);
+	text = l_strdup_printf(COLOR_GRAY("%s\n"), dashed_line);
 	display_text(text);
 	l_free(text);
 }
@@ -774,7 +774,7 @@ void display_agent_prompt(const char *label, bool mask_input)
 	if (mask_input)
 		reset_masked_input();
 
-	prompt = l_strdup_printf(COLOR_BLUE "%s " COLOR_OFF, label);
+	prompt = l_strdup_printf(COLOR_BLUE("%s "), label);
 
 	if (command_is_interactive_mode()) {
 		if (agent_saved_input) {
@@ -820,8 +820,8 @@ void display_agent_prompt_release(const char *label)
 
 	if (display_refresh.cmd) {
 		char *text = rl_copy_text(0, rl_end);
-		char *prompt = l_strdup_printf(COLOR_BLUE "%s " COLOR_OFF
-							"%s\n", label, text);
+		char *prompt = l_strdup_printf(COLOR_BLUE("%s ")
+						"%s\n", label, text);
 		l_free(text);
 
 		l_queue_push_tail(display_refresh.redo_entries, prompt);
diff --git a/client/display.h b/client/display.h
index 8e597bb5..c1a3cb75 100644
--- a/client/display.h
+++ b/client/display.h
@@ -22,16 +22,15 @@
 
 struct command;
 struct command_family;
-
-#define COLOR_BOLDGRAY	"\x1B[1;90m"
-#define COLOR_GRAY	"\x1b[90m"
-#define COLOR_GREEN	"\x1b[32m"
-#define COLOR_RED	"\x1B[0;91m"
-#define COLOR_BLUE	"\x1B[94m"
-#define COLOR_YELLOW	"\x1b[33m"
-#define COLOR_OFF	"\x1B[0m"
-#define CLEAR_SCREEN	"\x1b[2J"
-#define MARGIN		"  "
+#define COLOR_OFF		"\x1B[0m"
+#define COLOR_BOLDGRAY(s)	"\x1B[1;90m" s COLOR_OFF
+#define COLOR_GRAY(s)		"\x1b[90m" s COLOR_OFF
+#define COLOR_GREEN(s)		"\x1b[32m" s COLOR_OFF
+#define COLOR_RED(s)		"\x1B[0;91m" s COLOR_OFF
+#define COLOR_BLUE(s)		"\x1B[94m" s COLOR_OFF
+#define COLOR_YELLOW(s)		"\x1b[33m" s COLOR_OFF
+#define CLEAR_SCREEN		"\x1b[2J"
+#define MARGIN			"  "
 
 void display(const char *format, ...)
 		__attribute__((format(printf, 1, 2)));
diff --git a/client/known-networks.c b/client/known-networks.c
index 45f60af2..49e69ddd 100644
--- a/client/known-networks.c
+++ b/client/known-networks.c
@@ -318,8 +318,8 @@ static const struct proxy_interface *known_network_proxy_find_by_name(
 		if (!network_args.type) {
 			display("Provided network name is ambiguous. "
 				"Specify network security type as follows:\n");
-			display("<\"network name" COLOR_BOLDGRAY ".security"
-							COLOR_OFF "\">\n");
+			display("<\"network name" COLOR_BOLDGRAY(".security")
+							"\">\n");
 			display("\twhere '.security' is [.psk | .8021x | "
 								".open]\n");
 		}
diff --git a/client/station.c b/client/station.c
index 1a573674..64becdbd 100644
--- a/client/station.c
+++ b/client/station.c
@@ -387,12 +387,12 @@ static const char *dbms_tostars(int16_t dbms)
 		return "****";
 
 	if (dbms >= -6700)
-		return "***" COLOR_BOLDGRAY "*" COLOR_OFF;
+		return "***" COLOR_BOLDGRAY("*");
 
 	if (dbms >= -7500)
-		return "**" COLOR_BOLDGRAY "**" COLOR_OFF;
+		return "**" COLOR_BOLDGRAY("**");
 
-	return "*" COLOR_BOLDGRAY "***" COLOR_OFF;
+	return "*" COLOR_BOLDGRAY("***");
 }
 
 #define RSSI_DBMS "rssi-dbms"
@@ -440,7 +440,7 @@ static void ordered_networks_display(struct l_queue *ordered_networks)
 
 		display_table_row(MARGIN, 4, 2,
 				network_is_connected(network_i) ?
-				COLOR_BOLDGRAY "> " COLOR_OFF: "",
+				COLOR_BOLDGRAY("> ") : "",
 				32, network_name, 18, network_type, 6,
 				display_signal_as_dbms ? dbms :
 				dbms_tostars(network->signal_strength));
-- 
2.34.1

