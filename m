Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A6F665F
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 22:21:34 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id j3so3001355pfb.6
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 15:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QmMGTTah4w5osCjPVCppx1ln9vzAKse2Sad/xzeQxgs=;
        b=GTva6RzzfQm1vxlLASRdt/7yss045dCVLLyK8dhLyBKO6AxD7Flepn22+6Mj46+WaT
         yoblyjb1BJvctF0FHLbNL86+x2pj2mijJu/sctqa8YAlMPlIlK1X4E50Qf3MMJv/C4+7
         wuwObgMhuWcjYZktOdXZKPHFIToDpCw/Ju8bgcPUkM6ApVgRN8WZsrWvp1Me74+CV7ti
         kXeNUSniuEnc2lTD1kYVnOQg/7DOxW7s5O8tjxfjNno6H80/H80Mm9rLsJj1NnjgVIHU
         1dKczPe0EwYm2a6VqUTYjFFt+gc7tuDt8B3HFd3gYWBV2XJn/3iMPzxl7YuDJa8fMp7S
         557Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QmMGTTah4w5osCjPVCppx1ln9vzAKse2Sad/xzeQxgs=;
        b=A9Lk/6i8kZefV3474993nMU8KvZBNPfika6IN/CJ9sDPYBL1obF11vjUs5UPPS12A9
         Zxn8p8CSCI8Pnl2CSBGfBGc3GaeO6Nv/182CoYJXYHEf6N2QWD7Dfz2Ri+knqwCJ2xYn
         jRpKyqowNTdwNJcOzSZFn7Z2JZLslvIcqTEpF3Nn4Fjz0s/c9wxMJkXhRAYDOMOGN+FE
         F6bM+dFpfEh5wHnrKiB8r764JXr00qZWu40VxrT5yT/MbHrP5jjUZ0moaO34c70qY64l
         HM5J/aFPtaVpLFHSkU3V52K97pn/LDIAxF7XVJRWDo3U8ydjVI5omg3mx6wNaFASJgqF
         zu1Q==
X-Gm-Message-State: AJIora++SS/siDRs4TJ8Mdu7v1gu4poTg6EJSw7PYNSaqxl9nRlU2iSV
	B9XMs+KB2MoUw45GpV6tlaxmEwQa+MA=
X-Google-Smtp-Source: AGRyM1t23CdXlmHsfH0rRJi+wLo4DrUNxPGZ4lWfdHQ7mi1uKTkl9rbo6KvxQ/1xIP94PB0toxl0Jw==
X-Received: by 2002:a17:90a:6809:b0:1ec:c213:56c8 with SMTP id p9-20020a17090a680900b001ecc21356c8mr1111723pjj.82.1657146094408;
        Wed, 06 Jul 2022 15:21:34 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e80900b0016a163d1cd5sm26517696plg.253.2022.07.06.15.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:21:33 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 09/14] client: update ap to use display_table_row
Date: Wed,  6 Jul 2022 15:19:02 -0700
Message-Id: <20220706221907.126408-9-prestwoj@gmail.com>
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

---
 client/ap.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

v2:
 * Make the signal buffer big enough to handle the maximum int16 value
   which is 7 characters including '\0'

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

