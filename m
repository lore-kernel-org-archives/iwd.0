Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9A8184541
	for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477596; cv=none; b=HWBl4z5eU6VdjMl1sgKzJHUW/VNq2iqi/kQbdPJb6p5NrNzet3csJfu9wTJvlu0yCRCJs3UmwHMyUdGGTuAQWTl7dNhUl+YIONFh1bnmc7hEWJ0LN4hQ80sZInYYAA4M/uO7DeBPNbELrKY64kjRvtnljfyAHkuFFowgqpIDaJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477596; c=relaxed/simple;
	bh=0JXQUsU+CeZbduEPiJJveo0hTbm5nD6K/zdc+wnogXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UtwS/wvVQD7b/a3Vc7Q9u85ZujLOOu2S1ILQfBeUJomU6zmauKeT9UnnBidb8RFUMerPE84zqGYnXv6o4LMc7ZenL+cMMC9puHbaHwl/8iiZ9CHrQSRkAmJYTan08rjw0oA0Cb3QDnpNwmkebIGtllhGbrnv4Yc0WyftAko/r7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4siSNkd; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4siSNkd"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5b3fff87e6bso5037852a12.0
        for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723477593; x=1724082393; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkZzKtxYPZkT6hUlkqBEznSewHrv3kJaBT71xggLwjM=;
        b=G4siSNkdglJDUsNVI/Bageq+D0BzJRySsrdY6ic/ZVF282aGrqZvmzvv1o+pWSGU4r
         8jAs56dA5468+GC5d1p4URJZUFriJBjrjpIGb2ffSJjhmyTjJSQTg6Y0Hz4OxJ1xSzWH
         gSCywh7TKfsNUAIUCZY+pCOXHcRsVflaj+an4S4UppOeimY9tD53EZDJa0pxbri8Jvuj
         NKHT1XWN5lxmqCw2F3xmniHGtpgZsmJCPfi6shlOfiHeZmxXtljgfO0h+UpPn0bL3UJz
         ggTg/XGnMj/K64e1vhcR1DL/7m7OfTBb7Uf8hkEM554+qCniG5doOHWzA6V2G5VBdx88
         1J/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723477593; x=1724082393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkZzKtxYPZkT6hUlkqBEznSewHrv3kJaBT71xggLwjM=;
        b=wkW5ovrcjdMEQ6YgTwavnpPTDCJXkrsEffr5cbJCLWQGk44E1BcPC0LurDyKCYCTsf
         +7S4ARjxoPYkwdy1OSY+hkLhKm6SSJVJVRM1q/wysqhIDaWLBVoFm0Z4yHSO8EbhFdMw
         owEOeqa1iB997A7+Uag37CocaJnQaVm5h4cEBHaCdUnYK74ckoxiu7QXVevBty+/deai
         zhu0d9jYRbBzkXJraKVmQPDKV9yJUhDknaXnohzv0gBq2h03MRJ6qzEHW2PYhtEzwlt3
         AiTQsmne3GmaxIfdNGDi+BPKugl87X0dUtac98Zo9Jp79rfcC5NLftnTIVcw+8SknFDf
         LQ8g==
X-Gm-Message-State: AOJu0YxO6cNos8BMKp3t4aDCDBwrkaIVxkE8y3NxQjF3s908B1yIkCO3
	vE43xJV1Rwu8hRS4b5js0g9dHP96f8AdeB3I2C96F7+I5c82voBqoKovwQ==
X-Google-Smtp-Source: AGHT+IH7pm/e2t2AYSgkE1qKEmWLINxY8lF1+uRkH4vKlhOIqmQS1QB4BVd11/e62RlXHoNpvyCKtA==
X-Received: by 2002:a05:6402:40cc:b0:5a2:ff64:1218 with SMTP id 4fb4d7f45d1cf-5bd44bc45c9mr636279a12.0.1723477592637;
        Mon, 12 Aug 2024 08:46:32 -0700 (PDT)
Received: from LOCLAP699.vf-sint-niklaas.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd190adb45sm2224931a12.32.2024.08.12.08.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:46:32 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 08/13] client: separate property header and values into two functions
Date: Mon, 12 Aug 2024 08:46:08 -0700
Message-Id: <20240812154613.126522-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812154613.126522-1-prestwoj@gmail.com>
References: <20240812154613.126522-1-prestwoj@gmail.com>
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

