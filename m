Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1AE6648
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 21:31:07 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id n10so14732702plp.0
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 14:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LjUbAX5exqphHX/0ekLoQPosN77EU5bMuXY8UfgraCQ=;
        b=hJLQuEF3DVoIzYjOGeBKkYnuVyszwHiXzsA7DBahNIULDCAEEN0mLpZUNVks2vWSAu
         li0cCoHdcEkQx8VaLMRCzrt6TuJKmL6q2E9ayYrAyfAJNWpKgLS3/xsKockSYfOG1y4C
         GEjqk4tPiBeBdGNszV6dTUMcl0Lr7Oaz0/baTjAQl6hXSS1d1xWsZAfX3ZbeUoY8nddz
         WJeId2H8rT/GFVWa7lPHBFEe/qn07w2UUwwIEhs6NGmxuNjNpKbB94qfAZN3pTTrDeuu
         1johSFfsmUQZGEnfFmmNr9+dPxtWGFcLjvFUcbl/pBBdnuQzL8p1YIvuX3I4Ue52tfIG
         AlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LjUbAX5exqphHX/0ekLoQPosN77EU5bMuXY8UfgraCQ=;
        b=cwkNAtXZH+rxL+kjWTxXsqU8xHVHD85XxeAMnzRijeT/ObaAclWN+hXjRYZ85gxj3Q
         M/UMCaK2+KggY2cC7SdBEBODdq0zgg9Z6o2aLB1shmigTXXgQ2/egvZrZJTa+kj6GsBZ
         Ion3ai+NyNhR7oE58n+jbbMPm/1m4xEqWiH4pZWndrf89stpLN+LNiO9ZjW0cPlQQYXc
         GRdu8mHeMDf8L3H8Jc141IYuvCOBSgAFbhOAH+bjh2Sqa8tnTOpf2XXz79n5kidxMf6b
         KoofKyEnbfEayjFPpown/19cJ+d7kC5dSg3yIrw8y2pmXjoP84mkRENKFb47uRiye6pJ
         KnNA==
X-Gm-Message-State: AJIora8TqxM3i6xR1dbKoc1J/D6I/4AYrv4lUdDIRzQ31aJWyIrVIVvh
	pF2gcH50mVl2OEOrvcr3UdHDz/4eq20=
X-Google-Smtp-Source: AGRyM1tw0Ox/wfs6mIfjwaa4FirhUzM35lgZS7MaAiAGJMXLE7qoEK7S4YkgQkQHCCsEs/GnfdEhjA==
X-Received: by 2002:a17:902:b598:b0:168:b0b2:f05a with SMTP id a24-20020a170902b59800b00168b0b2f05amr49416170pls.0.1657143066527;
        Wed, 06 Jul 2022 14:31:06 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id v6-20020aa799c6000000b00527f5aee1a4sm15347609pfi.33.2022.07.06.14.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:31:06 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 08/14] client: make COLOR_* macros take a string input
Date: Wed,  6 Jul 2022 14:28:45 -0700
Message-Id: <20220706212851.92685-8-prestwoj@gmail.com>
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
index 7ca3a767..772f523b 100644
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
@@ -767,7 +767,7 @@ void display_agent_prompt(const char *label, bool mask_input)
 	if (mask_input)
 		reset_masked_input();
 
-	prompt = l_strdup_printf(COLOR_BLUE "%s " COLOR_OFF, label);
+	prompt = l_strdup_printf(COLOR_BLUE("%s "), label);
 
 	if (command_is_interactive_mode()) {
 		if (agent_saved_input) {
@@ -813,8 +813,8 @@ void display_agent_prompt_release(const char *label)
 
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

