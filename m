Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859C16651
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 21:31:12 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id z1so8899588plb.1
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 14:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nhQtO/Y2h9D6l5zhv4lQX1YLXzkVZFFQJbFi4F+4SY8=;
        b=bgEUd2cswzSMAEiJh+qfMPA5JaAlnyJanNvsLMuM67Y0r/7TB29fROxxvE6z4gV6Ky
         XHS3gmmJB3pc8/AuKtg0/Pc/XSMoejixLhC93Rc0Q9dG2UIkazMMfcuN3qhnAwsS2gE4
         CzVIUAsh69fX9HrZ7G6/neRGSBBm7DeDOwLFT9QYguyRqrwSYsLVRp7FfNQKIjihUXfR
         7yTXfV++rdCsTPKzXhoSJN6Unw9DCY1UMdVwbga7jh85Be1to65nlzCsAJbGHioMVld+
         ZALrEItQsygIj0cH6aAxW2MAGeLvUVlBzoYiu4ZJ7mbRbnjJxmMZ34KuDeWnnfYK+mqu
         jtuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nhQtO/Y2h9D6l5zhv4lQX1YLXzkVZFFQJbFi4F+4SY8=;
        b=zPIsP32TO0hFs0FdcONP4JF3p7HFQIh/td7pwSW9A6U6ifEJh5BCKkp/wTpHYT8lI1
         6AUfVNdGmrObbwnQGSPkuJeOmU5jPSef2BRJ8hCwZ3GSNCXV4m8QXyCW72ttybfD73nY
         aIDxFalyv6qaqmKUzOEL7esVQDzitaaCg31kZlc1rpXrokwjKqqXF4uxdnxyzR+k0fxS
         kBOIF/lisP3OB3JP5OD/ISZJyWETX+HV9ObV5dKI9IVnnK002HHxjBjzfBeOl9Ee3+0N
         l9k/l6+a1lYN9+yyZb4Mi9WoiWeaeFSIWhfsudLKUBszz0nW5Kl/fZza0c2+1uPmKGlk
         vg/Q==
X-Gm-Message-State: AJIora9y3DGaVRhkHFDVeomTZ6dQSazqVQGO6ylDLWR2BN7V7k76pf8r
	Sw0cwf5F4DWiy7zPyt2EIUF9dOa6fcY=
X-Google-Smtp-Source: AGRyM1uFM0eX8EzwUchIFzZBpm7QEo8dFv2RSrzMVwxdzmbR147M4pP/SeN2iFRyf0o/zWzKemTMPA==
X-Received: by 2002:a17:90b:3e85:b0:1ed:5a12:513c with SMTP id rj5-20020a17090b3e8500b001ed5a12513cmr866642pjb.64.1657143071743;
        Wed, 06 Jul 2022 14:31:11 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id v6-20020aa799c6000000b00527f5aee1a4sm15347609pfi.33.2022.07.06.14.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:31:11 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 13/14] client: update adapter table header
Date: Wed,  6 Jul 2022 14:28:50 -0700
Message-Id: <20220706212851.92685-13-prestwoj@gmail.com>
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

The table header needs to be adjusted to include spaces between
columns.

The 'adapter list' command was also updated to shorted a few
columns which were quite long for the data that is actually displayed.
---
 client/adapter.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/client/adapter.c b/client/adapter.c
index 6a0d3455..394eae0d 100644
--- a/client/adapter.c
+++ b/client/adapter.c
@@ -185,9 +185,10 @@ static void display_adapter_inline(const char *margin, const void *data)
 {
 	const struct adapter *adapter = data;
 
-	display("%s%-*s%-*s%-.*s%-.*s\n", margin,
-		19, adapter->name ? : "-", 10, get_powered_tostr(adapter),
-		20, adapter->vendor ? : "-", 20, adapter->model ? : "-");
+	display_table_row(margin, 4, 8, adapter->name ? : "-",
+				8, get_powered_tostr(adapter),
+				20, adapter->vendor ? : "-",
+				20, adapter->model ? : "-");
 }
 
 static void *adapter_create(void)
@@ -268,8 +269,9 @@ static const struct proxy_interface *get_adapter_proxy_by_name(
 static enum cmd_status cmd_list(const char *adapter_name,
 						char **argv, int argc)
 {
-	display_table_header("Adapters", MARGIN "%-*s%-*s%-*s%-*s", 19, "Name",
-				10, "Powered", 20, "Vendor", 20, "Model");
+	display_table_header("Adapters", MARGIN "%-*s  %-*s  %-*s  %-*s",
+				8, "Name", 8, "Powered",
+				20, "Vendor", 20, "Model");
 
 	proxy_interface_display_list(adapter_interface_type.interface);
 
-- 
2.34.1

