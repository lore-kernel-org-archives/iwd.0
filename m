Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9B32F21
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 21:31:08 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id 70so359673pfx.1
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 14:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iq22vUNPzzTKm6ZCaF0EBv4iOtV6HylvKXEDBEPrz0k=;
        b=jiFWIOVfUJvEFlpDflBruNK8+3jp/wjY80KWiv8he16MsKCVFEJZM3ZT3Oi/kI19jY
         srx4m02kfKbger55V77+QdvHX/DaaKcdoxiFegPanV1cJUU+Ixey1wwYPs811xvpjA4j
         UrcFCS1WU026S73o/Uf+wJ8WzFwl4w9iP3buLOEvnmPvs0Dsxu32O2RcezEyxzxC82Kw
         OfTCOv66AyDcl0G9VX5SbXdR3jr9U4hC4SsW3gOcWShtmjVGZWWefELyezUbU2g/wn/c
         hZnfDCovqGXC+64aObvgNPUUsL0BWZAZZFoeEroseTY6IgLgn8psQeyz4DV0arRh1avW
         RkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iq22vUNPzzTKm6ZCaF0EBv4iOtV6HylvKXEDBEPrz0k=;
        b=wnvKV1WyEvgadk3npclHTVQK1GOrzyqCRH65x+60P7E91eezx0GTKNyD2QA7UX0OVJ
         enHZUwxmepHL/DZnpBriLYpccEY9xBLyir9sZF+5c0bYJc2UoikF2VmzCAgirH0CiZz4
         HVD1NqiFX/oubbQEjPj92BNpLhFApUtDo0PQBYyhJdE3nWSCce34LFwRmsFWx2UsJuEb
         jKbT8so3ApXd15nt5wuMc6UxviZEWJqOGUPHhddzQ61UmQnakn/P5wyZZn9F/HUMI8TR
         HvpIR8rHpBk0o5eTd+QaH5ZyzFK62bcox6/taB2VoUVi/dXNp2BbXghY98KiCGOm606M
         Lyuw==
X-Gm-Message-State: AJIora8IUT59oCpSvx/pF1rhUn/cLjDLexRXabFouuj0mERINPPgtKkD
	WDBVbBxv885dcwI5UBuaC8yGVUrZ4C0=
X-Google-Smtp-Source: AGRyM1vzant/pkKuyIHDML4fifnTII0DVkjUqPkxif928cttlueCT0cJnpflMqQlXKWA6SZPtw6fOg==
X-Received: by 2002:aa7:90ce:0:b0:528:90a4:73ec with SMTP id k14-20020aa790ce000000b0052890a473ecmr12550645pfk.73.1657143067505;
        Wed, 06 Jul 2022 14:31:07 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id v6-20020aa799c6000000b00527f5aee1a4sm15347609pfi.33.2022.07.06.14.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:31:07 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 09/14] client: update ap to use display_table_row
Date: Wed,  6 Jul 2022 14:28:46 -0700
Message-Id: <20220706212851.92685-9-prestwoj@gmail.com>
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

---
 client/ap.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/client/ap.c b/client/ap.c
index b992c792..37a15fc3 100644
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
+			char signal[6];
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

