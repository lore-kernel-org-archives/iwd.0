Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9B62563
	for <iwd@lists.linux.dev>; Thu,  7 Jul 2022 17:57:24 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id i190so7268059pge.7
        for <iwd@lists.linux.dev>; Thu, 07 Jul 2022 10:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e9ieV3CILIiKWCqTQ7cPR9lgx3GxdbKLHByre30dKcA=;
        b=g2iwoh2iqSqtP8D1+imMa87GOklH8CbJwPYi7fdnqKve6IYsy8bgGVrBK1Va2gDQHm
         Zww1k3ZcuizWf6uZ44oI1HFdvcnMdELLIQnXrHP3Wb56h4fcZCF4xpDKn+rtWrd+4o8C
         W9ThI/qMlFR164dz1ESOPmy0yHT0OSMqkmfb7POveUCtLQg4AThXWPMYJqyQTNWw/pFV
         ydPGWOXZC5JeprCLl42oaPhySmlHY1NwtECgmqC9vyAG3y4Mk5BubPU+Mr6OnzKHo6SN
         FPdV/ekeggC1M4h0aCKn8s3hJbO/8lyjYp5nTZzKElWHoMKbKKni4Pz03qai03bu0Lvh
         JlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e9ieV3CILIiKWCqTQ7cPR9lgx3GxdbKLHByre30dKcA=;
        b=oq7ftlYYZeBpRtZ4WEVs/rqYcXkOfEMm3B1xy23jSmpM/Gyql3YxqXztgsGpwA/bZz
         jzJGjjsR/79EKj9rjamt2ufFAlNiql9l/fPbdQozB//ZBvoyQ7Z3aFxpZh44niSoaav5
         XkQ+QtvByarO/fK/VrvIDnbIV/Eb0mUmeT/uHFrfy6bi/qNPue0rmioUYk/YK2lD7ePj
         aPvX7BDpQ61/khFd5BbIcsBq8/oj2+x8zo5z9uL8C2iyv1FTSQeB5B5agLAFLr0bngBF
         kK03IeM67jpLtHYQXN0w+rYRRJTYvex70OgtMle9shFhU1a6KBArUDtJAfzTNfOd76XW
         NzoA==
X-Gm-Message-State: AJIora8oQUYBYrqovNKoMV5Lrb0UQtqWmAE+mdCOc0g0GJRgC2whbjDx
	EcjfmHQBK8QZ5nlnYCc6F1AGl8cON+Y=
X-Google-Smtp-Source: AGRyM1uJpom991KpnGrA4eeiZ1FBuNKOoTLUAmlL6VWivGiGI1l7cfTRmdeiS97S/ai6KXSLBHZtHQ==
X-Received: by 2002:a17:903:2cf:b0:151:a932:f1f0 with SMTP id s15-20020a17090302cf00b00151a932f1f0mr55145399plk.130.1657216643193;
        Thu, 07 Jul 2022 10:57:23 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b001618b70dcc9sm28855223plg.101.2022.07.07.10.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:57:22 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 03/14] client: update dbus-proxy to use display_table_row
Date: Thu,  7 Jul 2022 10:55:00 -0700
Message-Id: <20220707175511.224597-3-prestwoj@gmail.com>
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
 client/dbus-proxy.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
index 9f05c0e7..bbb97eb5 100644
--- a/client/dbus-proxy.c
+++ b/client/dbus-proxy.c
@@ -59,7 +59,7 @@ void proxy_properties_display(const struct proxy_interface *proxy,
 	if (!proxy->type->properties)
 		return;
 
-	display_table_header(caption, "%s%-*s  %-*s%-*s", margin,
+	display_table_header(caption, "%s%-*s  %-*s  %-*s", margin,
 				8, "Settable",
 				name_column_width, "Property",
 				value_column_width, "Value");
@@ -69,29 +69,16 @@ void proxy_properties_display(const struct proxy_interface *proxy,
 
 	for (i = 0; properties[i].name; i++) {
 		const char *str;
-		size_t len;
-		size_t j;
 
 		if (!properties[i].tostr)
 			continue;
 
 		str = properties[i].tostr(data);
-		len = str ? strlen(str) : 0;
 
-		display("%s%*s  %-*s%-.*s\n", margin,
-			8, properties[i].is_read_write ?
+		display_table_row(MARGIN, 3, 8, properties[i].is_read_write ?
 				COLOR_BOLDGRAY "       *" COLOR_OFF : "",
-			name_column_width, properties[i].name,
-			value_column_width, str ? : "");
-
-		if (len <= value_column_width)
-			continue;
-
-		/* Display remaining data */
-		for (j = value_column_width; j < len; j += value_column_width)
-			display("%s%*s  %-*s%-.*s\n", margin, 8, "",
-				name_column_width, "", value_column_width,
-				str + j);
+				name_column_width, properties[i].name,
+				value_column_width, str ? : "");
 	}
 }
 
-- 
2.34.1

