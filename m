Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0660528F2
	for <iwd@lists.linux.dev>; Thu,  7 Jul 2022 17:57:29 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id q82so12698384pgq.6
        for <iwd@lists.linux.dev>; Thu, 07 Jul 2022 10:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ELqGjbsMcYDjGvtKz7OxIarL+9ukO7rrB/sK/SQ9ato=;
        b=oaFd7hcWfowkrHZAXj91K2X/PwXLl67k8FBjlrJUy3DfQws8G1Ch50hb9+3hkvcxEo
         NpoNktKZEXMyAky+lmJ86OWOmnhU5V48tOD39Pdqdl0R4dwC+j3xb5fPz8H9X4GgjkGq
         QkL6hpp3g6L8KpZ6knto+4IsBSS+ZeaphRpx6bdQ5EC4ll+khbx5OQwMNRUeaeL5MYD/
         JbBmltLsgMrVToLk/I3iQ9ygwmEFYSIfROM48+uTNfucm/loX8NzRxcr0YBinHaP5k3p
         mk237EAEgeIFy+33d4bZz5GZd/iGXDoOY/H059afaix+tIrTxSHv3CMv6wuNy5eJCW4d
         P/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ELqGjbsMcYDjGvtKz7OxIarL+9ukO7rrB/sK/SQ9ato=;
        b=IpMBtwCpWvjUq7xI698qPQalLUiY9alPSSq4sVq/ouq6mnZ0iLVwiP3pHtFWEew4Ln
         z4nLA1QC2OF7q2Ox5eXzNwmWYHM5PHbeFQFEtNDJP9RXDU260TATBwCG7u2zdC4NqHvk
         E9kXjNY8lR5DQRkorDGrf8MDcqihKWELrWclnHGUtfXAQkDGA2uToh5zMExkohWOMjKL
         ngbNUdyQldc8B4erAfVaAKZxm/BlQs5HqN3UJafnUHhA9CsgIW5GeD7BCVFAankqhif7
         T/9P3pQ0sxWNcQB8qlxcpmSUMk5y4Z1HSI+4RT3UUyikC/xE6xN2o2vJFNgfF3WCVH8B
         bcBg==
X-Gm-Message-State: AJIora/NypPjU36sx28vBphlhDXuJp0jfGP9F0t8KBp1h4s9sq08JYTH
	uaYhyIiLofzBufsHw6R4bqMsd/VLSZQ=
X-Google-Smtp-Source: AGRyM1u0rcmg4Zl1PYOxJcFIQiNXr+V8tNIe8clPrj9kQZYujbNl4qM++2nV22FQPMgXDIzQlwkjog==
X-Received: by 2002:a17:902:bd01:b0:16a:65a5:9761 with SMTP id p1-20020a170902bd0100b0016a65a59761mr54608403pls.3.1657216649194;
        Thu, 07 Jul 2022 10:57:29 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b001618b70dcc9sm28855223plg.101.2022.07.07.10.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:57:28 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 09/14] client: update ap to use display_table_row
Date: Thu,  7 Jul 2022 10:55:06 -0700
Message-Id: <20220707175511.224597-9-prestwoj@gmail.com>
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

---
 client/ap.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/client/ap.c b/client/ap.c
index b992c792..b8849a1b 100644
--- a/client/ap.c
+++ b/client/ap.c
@@ -161,9 +161,7 @@ static void display_ap_inline(const char *margin, const void *data)
 	if (!identity)
 		return;
 
-	display("%s%-*s%-*s\n", margin,
-			20, identity,
-			8, get_started_tostr(ap));
+	display_table_row(margin, 2, 20, identity, 8, get_started_tostr(ap));
 }
 
 static enum cmd_status cmd_list(const char *device_name, char **argv, int argc)
@@ -173,9 +171,8 @@ static enum cmd_status cmd_list(const char *device_name, char **argv, int argc)
 		proxy_interface_find_all(IWD_ACCESS_POINT_INTERFACE,
 						NULL, NULL);
 
-	display_table_header("Devices in Access Point Mode", MARGIN "%-*s%-*s",
-				20, "Name",
-				8, "Started");
+	display_table_header("Devices in Access Point Mode",
+				MARGIN "%-*s  %-*s", 20, "Name", 8, "Started");
 
 	if (!match) {
 		display("No devices in access point mode available.\n");
@@ -265,10 +262,10 @@ static void ap_get_diagnostics_callback(struct l_dbus_message *message,
 	}
 
 	while (l_dbus_message_iter_next_entry(&array, &iter)) {
-		sprintf(client_num, "Client %u", idx++);
-		display_table_header(client_num, "            %-*s%-*s",
+		sprintf(client_num, "STA %u", idx++);
+		display_table_header("", MARGIN "%-*s  %-*s  %-*s", 8, client_num,
 					20, "Property", 20, "Value");
-		diagnostic_display(&iter, "            ", 20, 20);
+		diagnostic_display(&iter, MARGIN, 20, 20);
 		display_table_footer();
 	}
 }
@@ -286,10 +283,11 @@ static enum cmd_status cmd_show(const char *device_name, char **argv, int argc)
 	}
 
 	proxy_properties_display(ap_i, "Access Point Interface", MARGIN, 20, 20);
-	display_table_footer();
 
-	if (!ap_diagnostic)
+	if (!ap_diagnostic) {
+		display_table_footer();
 		return CMD_STATUS_DONE;
+	}
 
 	proxy_interface_method_call(ap_diagnostic, "GetDiagnostics", "",
 					ap_get_diagnostics_callback);
@@ -355,14 +353,18 @@ static void ap_display_network(struct l_dbus_message_iter *iter,
 			if (!l_dbus_message_iter_get_variant(&variant, "s", &s))
 				goto parse_error;
 
-			display("%s%-*s%-*s\n", margin, name_width, key,
+			display_table_row(margin, 2, name_width, key,
 						value_width, s);
 		} else if (!strcmp(key, "SignalStrength")) {
+			char signal[7];
+
 			if (!l_dbus_message_iter_get_variant(&variant, "n", &n))
 				goto parse_error;
 
-			display("%s%-*s%-*i\n", margin, name_width, key,
-						value_width, n);
+			snprintf(signal, sizeof(signal), "%i", n);
+
+			display_table_row(margin, 2, name_width, key,
+						value_width, signal);
 		}
 	}
 
@@ -386,7 +388,7 @@ static void ap_get_networks_callback(struct l_dbus_message *message,
 		return;
 	}
 
-	display_table_header("Networks", "            %-*s%-*s",
+	display_table_header("Networks", "            %-*s  %-*s",
 					20, "Property", 20, "Value");
 	while (l_dbus_message_iter_next_entry(&array, &iter)) {
 		ap_display_network(&iter, "            ", 20, 20);
-- 
2.34.1

