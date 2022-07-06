Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995E86648
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 21:31:11 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id o18so13809801pgu.9
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 14:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bK+1hhQOyVtvJnFigsHxDF6e/MUMdEEF7UQ1BjC5dVE=;
        b=iuWU7N6AnrKXkwxutZYkPsVehOOkiEjyf7wPo+ppOEv+UDJ9oIir1S6zyL9BEXJjND
         OrA7L702fCkqUtWht13q18ijt/0QO2Qy8ltIR6khuAsN5S8Sqko9bFOTwOqnbzxqO9ru
         BQ0tjd2+fpxFGhw/8XXGO5aBC3wXSIUFDA4DKlle93Y6boFKx7Amw52v3DhtA4ycUhGe
         b0hfzpBIM8A0+HjTlPoSlfV99mFUIxgjBAFyOG/pnrulcNLhKyvzEZ7Rs5Xv5Vk3qhtV
         g9zfemtMdG5OsikF/Uvv+zn7HbXyHTd5Rftlo5vxaFgbK370/Ya9s5q8oWTjGp7zwpQz
         UD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bK+1hhQOyVtvJnFigsHxDF6e/MUMdEEF7UQ1BjC5dVE=;
        b=utkw21zjYN8wf+FfD4Jwv+MNKAly7463BsYfbC176iWeCNjYNq+5Bn8mqRxkpe9Exv
         fx7V81S0lvqWIxWCG9wdeY3EbBK/F+2SMGafR2AdcSNv4MU6LUf1716UT9VKpRjS8U9I
         2v/Uj9tX6hELKQ5pkFDr3zfHR008tsEFMMprdXNEEW5Wg8wa6WhKw5oWDXRk8qPThzaJ
         K2d+L2rrljtTwbTc0rQabUcPHOizFQgZOUDNZVzMz+5EBwWyHIpKcPrrT5OIComEhyTq
         Iu8N4QAjxwD1Qcjo0K4Yy7qf2ATyCDQVTL6tqiWGly04KpKvpnr6WEexurtrYZVbJtGF
         tRcA==
X-Gm-Message-State: AJIora/YOG4UJSc+ylx+a2IWFRSEUvjpAVqeVnZafaXOLOfemTVgyGmk
	zotzC9ACSVe+d1F7XR2Nsxq5DZI90Mk=
X-Google-Smtp-Source: AGRyM1vCQznJvojDyUmf1AoOW8XsUYsZvjq567ZLl+MEe+K2IlYiUlemis1OWXgrGsJ1Dndk+fuf+g==
X-Received: by 2002:a05:6a00:18a7:b0:51b:c63f:1989 with SMTP id x39-20020a056a0018a700b0051bc63f1989mr49647933pfh.49.1657143070822;
        Wed, 06 Jul 2022 14:31:10 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id v6-20020aa799c6000000b00527f5aee1a4sm15347609pfi.33.2022.07.06.14.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:31:10 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 12/14] client: update device to use display_table_row
Date: Wed,  6 Jul 2022 14:28:49 -0700
Message-Id: <20220706212851.92685-12-prestwoj@gmail.com>
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
 client/device.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/client/device.c b/client/device.c
index 5b971883..9f8d731c 100644
--- a/client/device.c
+++ b/client/device.c
@@ -54,9 +54,10 @@ static void display_device(const struct proxy_interface *proxy)
 	l_free(caption);
 
 	if (device->adapter) {
-		display("%s%*s  %-*s%-*s\n", MARGIN, 8, "", 20, "Adapter", 47,
-			proxy_interface_get_identity_str(
+		display_table_row(MARGIN, 3, 8, "", 20, "Adapter", 47,
+				proxy_interface_get_identity_str(
 						device->adapter) ? : "");
+
 	}
 
 	display_table_footer();
@@ -216,12 +217,11 @@ static void display_device_inline(const char *margin, const void *data)
 	else
 		adapter_str = "-";
 
-	display("%s%-*s%-*s%-*s%-*s%-*s\n", margin,
-		20, device->name ? : "",
-		20, device->address ? : "",
-		10, get_powered_tostr(device),
-		10, adapter_str,
-		10, device->mode);
+	display_table_row(margin, 5, 20, device->name ? : "",
+				20, device->address ? : "",
+				10, get_powered_tostr(device),
+				10, adapter_str,
+				10, device->mode);
 }
 
 static const char *device_identity(void *data)
@@ -368,7 +368,7 @@ static void check_errors_method_callback(struct l_dbus_message *message,
 static enum cmd_status cmd_list(const char *device_name,
 						char **argv, int argc)
 {
-	display_table_header("Devices", MARGIN "%-*s%-*s%-*s%-*s%-*s",
+	display_table_header("Devices", MARGIN "%-*s  %-*s  %-*s  %-*s  %-*s",
 				20, "Name", 20, "Address", 10, "Powered",
 				10, "Adapter", 10, "Mode");
 
-- 
2.34.1

