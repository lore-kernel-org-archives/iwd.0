Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D048191466
	for <iwd@lists.linux.dev>; Thu,  8 Aug 2024 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138969; cv=none; b=Thue+cx138b58+ESI57wPaHuCATKkvaSrRAjkRz7NAO9Cexzx2QZZr1H3BsvztOQfNj1giWrXjDQfWD53abihBss3HyWdH5wtMLbptJvbV4+JpNkfgf4EZD9VOl5CpRE6ndJXBBc+3049PNUJXuTDQ1LV+pamqAr3n8B/j1jqk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138969; c=relaxed/simple;
	bh=0JXQUsU+CeZbduEPiJJveo0hTbm5nD6K/zdc+wnogXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wm0/PPEo6jtstW29Fb4YmnETlRYJ79ZNF/TvFFBbZhUR+wPLcOm8A9swDEFxpDOvyeXM0gYZcPl4ML7hpD/pTOiSZgbSGUwQ01QY2XRJkI6fVSuUy5Wx58/ThnU9sp+Ik9G5JNTf/xNCh44pmKJyPsJYGl3+GLb4awr5U+hyRrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dGycy4Of; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGycy4Of"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc491f9b55so10965945ad.3
        for <iwd@lists.linux.dev>; Thu, 08 Aug 2024 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723138965; x=1723743765; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkZzKtxYPZkT6hUlkqBEznSewHrv3kJaBT71xggLwjM=;
        b=dGycy4Ofgp+/prkd31e1ZsIhpNOd0M6zGP8Xs//RX/42FDIfSXXjq0defwHpaRE4zs
         h5/N1Qj0RhG0oibtqdovrnbWU7KHieo7ptRquwwrrtUUoaPl8o68//QbfwCtDbxNlO6N
         tPjOLxvIrdGYIsFWm7XgkShBdIZ71YgkJKkAcLebojzdKm1M0Aap3VMmV2SCgF/mAARm
         wcMPquhNBdBZ7FSC3MegV1xg+yO1Fk12CEY3wzSHkiSWJlvpE9dImUGZafnQK/ak9IP6
         o/tR3qT0LnuNoptK9+eJ4hjvpBxqa53uqBvIANpRbp0J6slhIgzu0WAW5Ax8Wz/92yxM
         ZgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723138965; x=1723743765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkZzKtxYPZkT6hUlkqBEznSewHrv3kJaBT71xggLwjM=;
        b=GK/7zvH7qZUhrYSjEJ6gdiS9fREC8rhtfkmsSp+V30lnVktYRfxBPvErE+Jbg3bXzy
         2bks6yNjoxQvUVdqcAv8EZ9NCltNZCVJZagne+lz7dvae9xFGufwstg7iH8MQnyDZOlz
         cssgAF/REOAq81hbkNp8cNYeMC3N6AJKfXALt40OO9o6t7AMmQTXtI4T3+5W8JmIZ5XE
         juW1d/QD0Z1prvlCAnTspex5UXxO0rm4ejNfcSGQlinWvcK/LjianK84NzqIb+f5O2Os
         RsglC6oXcJ72FfK4WxO9cb2Wxwa5p72ORTFwhPgn5loartyLyfvRA3HjN7yYDLD+mYBW
         0o1w==
X-Gm-Message-State: AOJu0Yy5qmDNn24/5LLF71F7yTNrlGlNMuj30DQC35l3mtA8U92XuxTM
	R/qwhjXWar8WqEWg0jbphRNpRYHlYCrxHm78/SyV0605eneJAu5BjskjFg==
X-Google-Smtp-Source: AGHT+IG/WngtTdSo/w0GVl9CoItR5NGFwR43xj0WgpHmV4JxgTNRYnvR+CxnJscbNyXqYXByHmPQOw==
X-Received: by 2002:a17:902:d4c2:b0:1ff:1bd:7e61 with SMTP id d9443c01a7336-20095252872mr28918305ad.14.1723138965431;
        Thu, 08 Aug 2024 10:42:45 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f53435sm127478355ad.64.2024.08.08.10.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:42:45 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 08/13] client: separate property header and values into two functions
Date: Thu,  8 Aug 2024 10:42:31 -0700
Message-Id: <20240808174236.218750-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808174236.218750-1-prestwoj@gmail.com>
References: <20240808174236.218750-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are certain cases where we may not want to display the entire
header for a given set of properties. For example displaying a list
of proxy interfaces. Add finer control by separating out the header
and the prop/value display into two functions.
---
 client/dbus-proxy.c | 38 +++++++++++++++++++++++++++++---------
 client/dbus-proxy.h |  7 +++++++
 2 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
index 42b8427f..1e50d902 100644
--- a/client/dbus-proxy.c
+++ b/client/dbus-proxy.c
@@ -47,10 +47,10 @@ static struct l_dbus *dbus;
 static struct l_queue *proxy_interfaces;
 static struct l_queue *proxy_interface_types;
 
-void proxy_properties_display(const struct proxy_interface *proxy,
-				const char *caption, const char *margin,
-				unsigned int name_column_width,
-				unsigned int value_column_width)
+void proxy_properties_display_inline(const struct proxy_interface *proxy,
+					const char *margin,
+					unsigned int name_column_width,
+					unsigned int value_column_width)
 {
 	const void *data;
 	const struct proxy_interface_property *properties;
@@ -59,11 +59,6 @@ void proxy_properties_display(const struct proxy_interface *proxy,
 	if (!proxy->type->properties)
 		return;
 
-	display_table_header(caption, "%s%-*s  %-*s  %-*s", margin,
-				8, "Settable",
-				name_column_width, "Property",
-				value_column_width, "Value");
-
 	data = proxy_interface_get_data(proxy);
 	properties = proxy->type->properties;
 
@@ -82,6 +77,31 @@ void proxy_properties_display(const struct proxy_interface *proxy,
 	}
 }
 
+void proxy_properties_display_header(const char *caption, const char *margin,
+					unsigned int name_column_width,
+					unsigned int value_column_width)
+{
+	display_table_header(caption, "%s%-*s  %-*s  %-*s", margin,
+				8, "Settable",
+				name_column_width, "Property",
+				value_column_width, "Value");
+}
+
+void proxy_properties_display(const struct proxy_interface *proxy,
+				const char *caption, const char *margin,
+				unsigned int name_column_width,
+				unsigned int value_column_width)
+{
+	if (!proxy->type->properties)
+		return;
+
+	proxy_properties_display_header(caption, margin, name_column_width,
+					value_column_width);
+
+	proxy_properties_display_inline(proxy, margin, name_column_width,
+					value_column_width);
+}
+
 static const void *proxy_interface_property_tostr(
 					const struct proxy_interface *proxy,
 					const char *name)
diff --git a/client/dbus-proxy.h b/client/dbus-proxy.h
index 98b0a2a4..f0a5d38a 100644
--- a/client/dbus-proxy.h
+++ b/client/dbus-proxy.h
@@ -95,6 +95,13 @@ void proxy_properties_display(const struct proxy_interface *proxy,
 				const char *caption, const char *margin,
 				unsigned int name_column_width,
 				unsigned int value_column_width);
+void proxy_properties_display_inline(const struct proxy_interface *proxy,
+					const char *margin,
+					unsigned int name_column_width,
+					unsigned int value_column_width);
+void proxy_properties_display_header(const char *caption, const char *margin,
+					unsigned int name_column_width,
+					unsigned int value_column_width);
 
 char *proxy_property_str_completion(const struct proxy_interface_type *type,
 					proxy_property_match_func_t function,
-- 
2.34.1

