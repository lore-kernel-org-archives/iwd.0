Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023912F21
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 22:21:29 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id l124so5266489pfl.8
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 15:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e9ieV3CILIiKWCqTQ7cPR9lgx3GxdbKLHByre30dKcA=;
        b=Ej6CxrLlgHKjjU1jhZfC+zBxK03K9hLpQ9Tp3O0wqCfBD40D046/VUIUcphSNP6G9w
         YlHRO4jDeOcJfPXs6Ek+Csv0a8sdlCMiSuZkBQbxt0/j276TipxNzq3r42CY5Yqod9u/
         Z6XAQdvOfi5rrim95hwCtYFCemWKlfukhy7CKEIUm0eskWhONKRzS+Js9pCIExc18cey
         xh3so/Hd5DBL6ofByuAYVdDYZHD6r23eLeHJgqP1x9HmbtDflMUXzOeIZ2Cq99ZL06lx
         Bp8+YV8jMGtv2dV94mOQrjTuljawfgYJZujuND5OfW2bxMyLLUhIIqHhyVbkeNOH5JLt
         I5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e9ieV3CILIiKWCqTQ7cPR9lgx3GxdbKLHByre30dKcA=;
        b=mDROz2tBZdvVUTaKnRKb/l5dJKs57HWz7RRGAMDNBkl3b1RV+pWRDixAny8NK+T/gT
         KmZo/RfCExRXvEYK8jvfZ6ZtfuK60IlvXzsgCWgVR+azAyYeErOrz3gkXpvJ4wihe7wH
         DJsGHJyWwZErM5Im2ZDbgCy82lBXzefDIauiFCJPivmEVEOOD2JDH9PXsqmaXObTbTBn
         u13Hm5nP81BojYgoOQS/lcWYLWWoymHiORhwe/SQuA6MqkYEunuACdv15avlxGW3n3NI
         Tyu8R1y5dNyIL72PzoLuCJ+Tlzc86pTr3rqBJ+WEv18NujJ7Mu++4CsQ9sWIOfHPOGzL
         rUHg==
X-Gm-Message-State: AJIora8ae1ru9wccfIEGLqHHcYNVD+IwEL4OnIPOHBR7oATd25w43/x8
	LGQt8jCdxImC/mqxWMee5jiodKGDs8k=
X-Google-Smtp-Source: AGRyM1tmdSfnS4O62FBDhF8wXJgdo54CM7c/ZN2GhaQNZ3vTKzmr4CQDugkKH++bB3x4eeN/xXhERg==
X-Received: by 2002:a17:902:a502:b0:16b:fbd9:7fc5 with SMTP id s2-20020a170902a50200b0016bfbd97fc5mr8292070plq.112.1657146089213;
        Wed, 06 Jul 2022 15:21:29 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e80900b0016a163d1cd5sm26517696plg.253.2022.07.06.15.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:21:28 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 03/14] client: update dbus-proxy to use display_table_row
Date: Wed,  6 Jul 2022 15:18:56 -0700
Message-Id: <20220706221907.126408-3-prestwoj@gmail.com>
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

