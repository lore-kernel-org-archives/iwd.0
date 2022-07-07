Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13AF258B
	for <iwd@lists.linux.dev>; Thu,  7 Jul 2022 17:57:36 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id g126so6486689pfb.3
        for <iwd@lists.linux.dev>; Thu, 07 Jul 2022 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bK+1hhQOyVtvJnFigsHxDF6e/MUMdEEF7UQ1BjC5dVE=;
        b=dLn6QfEbcn9ZfbwQ/JGbJM3RSW4NqLI9e2U7YyusxgUCOSEe5Jarg/3LlPqYnYizv5
         90xHFZoIYzTHbqjC2yaHzaG57fYkFGjeCZp+0XeJFpzLcClMHcq/4ixBGnx048QAsaFo
         clNeO4MZCVDsdDfiEIwPgK58XCDA2Wag+V8QTpsZLdhKstII8/Pin3vOdqK78VyoWECR
         B+Nh1338X7nrK4REB+IoUtjL19cHLo670SUk+cNl//4B/Qv9xdoMVkhT6oKv9XEJm2OY
         +tDw4MNa2GeppDASM2dEvA+Qrw/JetILIOFVBDZnaT3J4x8cncg1uplSPNaxYa+AvCxE
         On3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bK+1hhQOyVtvJnFigsHxDF6e/MUMdEEF7UQ1BjC5dVE=;
        b=wNgAvG1rSsCKVAcqJW3O/4o+ukCPihLBf2Q6BUiaSjWBW3bI19WpsAewabi5jw+Dic
         upnhLXahjrBa6zlLPfPpGgkG6YQ292IAXZ0EQCzTYDT+8gOOq/95v7OAU0IeaCtJdxhU
         AqtzjmcKv5JUeYXvrJdMa04uQD2stLKd2FKRZrROLq+lj9mglZXreL3c7N8PRginXrh3
         evZGyOdLhfpR0q+j2ndIWnUb89ZEqQRPD+qR70gVIjv4PFxxLRxIYk7Ca5z9xKidVifb
         IGA996aoYLoR5Gi/HD3i+C9gmfapuakVdFw2+qrTMq4ulGLNyDfk00y6z+6WFx6nw56Q
         tNiQ==
X-Gm-Message-State: AJIora8WL4b6gsALo1SHj2u3LQ+Blv6d4hdUZ17ZTh42kn9bpkHnnL6Q
	NTkkJ1xYiDY9Vbu+3XKOYglx+rVFX4k=
X-Google-Smtp-Source: AGRyM1sql/xR9tZ7yYu5aruF+BoaMV4Un4WjH8bwuC4yPqbj9n1DHe0Jyi2/W+1dQ9aobFRZd+Umaw==
X-Received: by 2002:a17:903:228b:b0:16b:ee10:b91 with SMTP id b11-20020a170903228b00b0016bee100b91mr18867676plh.27.1657216656218;
        Thu, 07 Jul 2022 10:57:36 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b001618b70dcc9sm28855223plg.101.2022.07.07.10.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:57:35 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 12/14] client: update device to use display_table_row
Date: Thu,  7 Jul 2022 10:55:09 -0700
Message-Id: <20220707175511.224597-12-prestwoj@gmail.com>
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

