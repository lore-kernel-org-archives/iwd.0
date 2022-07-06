Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCC72F21
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 22:21:34 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id y9so1417097pff.12
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 15:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LjUbAX5exqphHX/0ekLoQPosN77EU5bMuXY8UfgraCQ=;
        b=Lzk2opgfdK40mvuPzpTdemDviAufrxJVnBGAqxehxFYPxPZkA1nzvQJact0bHfWJA8
         mOu4+ki2v+3U8UsdrIBuvzZztsl760Nvs8nmGs3x3qA+GRoGTAxzbp1RH7pJfiLW/pUI
         HZakig47tFb+Tk3ApsI7+kFVGl7uyeGmLz0/easYkJfjA9Wn7oaSzWuBq+LedKmmnQpt
         NizcpYklTDtVhz/DNRc5u3dfShTEL0+ngjo+eNbh6J4z5uDLP7ukoogr9HyLT8DXbKcn
         qiVoZfMdsqbog9xkraCZmw+VSvSmAR4JHxOw/7Kuq3QLLmfzBN4PbTtTzg9g1Rz17Ktg
         AGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LjUbAX5exqphHX/0ekLoQPosN77EU5bMuXY8UfgraCQ=;
        b=2MLxkz8MtQ/0mE32U+fYrEQ8mdlnxuZHc5mHmYMwNG8hkhdsIlYna+4ksdmZ225D2l
         GwEm3YkD2d5S9sW4zUjiumVYf71apkNzOXWVcsiNiarmX3cwZBDCKF+x08huC/Ngz9UB
         HqbWkmKtklsQH0P1aimRkTSPRugiVp3xfIKwqsgTy/ZYchwuedMmZ1VTnuyOSmLFdhZv
         cE9NR+e0zkzy3Ay/Wn71NMtRjn4v+8263BVBK0QavuF0VE/bSvHMyurHavQmpxFR12JJ
         /AjkYNaLwoPKar05d50fkcNpzoV4p/apcT1d2eTn7Vf6mX5HzIG8mdUzHB8xoITvlttY
         PNXQ==
X-Gm-Message-State: AJIora9s/1frm80AZGxbGHyt6JkP5b+77NHqFh9ujc2oI4BHh+XUsFUg
	DNXO80r8b9MB2Z/jia4EysvBLGxEDKk=
X-Google-Smtp-Source: AGRyM1tCAJZx48kq3yZzNAB94TV4vTt5ZjHt+QQqHMTNW3XbjKM4g/IwEcLA6A1PYopc/D0Wl/T5Mg==
X-Received: by 2002:a63:9c4:0:b0:401:a7b6:ad18 with SMTP id 187-20020a6309c4000000b00401a7b6ad18mr36518272pgj.523.1657146093486;
        Wed, 06 Jul 2022 15:21:33 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e80900b0016a163d1cd5sm26517696plg.253.2022.07.06.15.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:21:33 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 08/14] client: make COLOR_* macros take a string input
Date: Wed,  6 Jul 2022 15:19:01 -0700
Message-Id: <20220706221907.126408-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706221907.126408-1-prestwoj@gmail.com>
References: <20220706221907.126408-1-prestwoj@gmail.com>
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

