Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6F5186E35
	for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477600; cv=none; b=t8Sjl7zg7+hsrz29I43kKkbxqKX30kby8Lui5OV+K+5KXepb2LYtED087asxTYMWshANJXH/oKRpM7PZkhz8/JWXEfUfbcJqilGR98obbaPpPvzLoR6vWPtqkbTkEGkSLtVbxh0I5DtTH21XtvFMTPFXrrvG48mVvcmRrwxlkhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477600; c=relaxed/simple;
	bh=vAb58u/XqBNtRFv1ckkIBuj3cRcHiM1+Zb6zKxs1xXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NCf1/3fLISdFCq94c/DI823GNaRELdBHEUxrq/9AW/ghL/fCz7GXqBJ6CygnY+BAUPglgHLl8V3lFOwg+tzpb2LXngbPb0UwfB3STwPZLQty2hjHRjA5vczLsZHyKCyZ1/UENeC7ubMUHTKjYh2Oyp5jlUNYRpW0hKWO2gcppOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgsJ2xp4; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgsJ2xp4"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52efd855adbso5680824e87.2
        for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 08:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723477596; x=1724082396; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62JcGrbGI1cE9yKn+mCLTkRUEfkkg/yYCyCeCW/MocQ=;
        b=EgsJ2xp4XT4YYTBYOLWmXZrvBs+K2ehAwcuGLiMudv7bZGB7of3Wnut5/Q5qkALJ7T
         yNOmoMW3cq7hxH4WNEQMIrfNw+aRwqqwi+90NtIh8vp1p4jVIcds4wsxopXBxkTOPF8S
         c1Fw5BAUGNZg9i5izYWsJcbN8fGEqCFg89CVDXhGpd024xc4ZrTFfuG0klxZkOVTxRZH
         9aPQM+6GrsH9KvlEzXb8mRCexzCqNCQyf20lUE2QnpP6nvfkm+OfJ46JbJ7ao4trmTZu
         xXiXgkl5GSBm8Jp6LmsmBeEbpt4Imb+ds9DpIh2B0MIsUboklIy5BAJiZ0JwJcrrpQIZ
         SGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723477596; x=1724082396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62JcGrbGI1cE9yKn+mCLTkRUEfkkg/yYCyCeCW/MocQ=;
        b=H7V0QwpVkMuFlSLaMbRg24e932ztJQoOixL5c841BFRUoKWdMAm5JF5JIk93zKvq5P
         5pxIJkjEnbAmVPSTZVlBlkNuSXRTr/YXmneOiQmV73tF/JXaZCa8blmZjuITPuCn3nmw
         r6W5skaXbKCW0Upg5pTerRP5YPz4TyGPtktBqrDAre/OSQsOH7aCfBN0yCGSGGl0Tqaf
         qnsGFbbI3+NIsa5PR6lb+OWtF3CLdI9Yuo1IfOnVe5WDlALAbRnRI+pTVx7n4kP3zvsx
         n09qfYC7GxQp87RZAEK/NKpV+538SI9cpLc99SCDOv37rgpj41nVjT8jTwmxdV/hAlJB
         QIMg==
X-Gm-Message-State: AOJu0YxIizGqJAUkkKoNDs7/KkJU4hCC6CJGZFxpBmFVh0Q+8zmWwZHY
	clBuPXSJM4by/TwfndVATz/2oYGtrioXSqiSO9UOOUxoQnzuB9jxZp9AXA==
X-Google-Smtp-Source: AGHT+IE8HHcCKzjnI0zxwThS9E213JYTvY7x9VFAM2eEQBekKuWHw7W/TiMkI6F1C8ZtRx19I7smGg==
X-Received: by 2002:a05:6512:e92:b0:52e:7125:c70a with SMTP id 2adb3069b0e04-532136841b4mr331126e87.47.1723477596120;
        Mon, 12 Aug 2024 08:46:36 -0700 (PDT)
Received: from LOCLAP699.vf-sint-niklaas.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd190adb45sm2224931a12.32.2024.08.12.08.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:46:35 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 10/13] client: Add BasicServiceSets property to network
Date: Mon, 12 Aug 2024 08:46:10 -0700
Message-Id: <20240812154613.126522-10-prestwoj@gmail.com>
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

The property itself is an array of paths, but this is difficult
to fit nicely within a terminal. Instead just display the count
of BSS's. Displaying a detailed list of BSS's will be done via
a separate command.
---
 client/network.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 client/network.h |  2 ++
 2 files changed, 51 insertions(+)

diff --git a/client/network.c b/client/network.c
index 6b79bcd1..7431183b 100644
--- a/client/network.c
+++ b/client/network.c
@@ -35,6 +35,7 @@ struct network {
 	char *identity;
 	char *name;
 	char *type;
+	struct l_queue *bss_list;
 	const struct proxy_interface *device;
 };
 
@@ -146,11 +147,58 @@ static void update_type(void *data, struct l_dbus_message_iter *variant)
 	network->type = l_strdup(value);
 }
 
+static bool match_path(const void *a, const void *user_data)
+{
+	const char *path1 = a;
+	const char *path2 = user_data;
+
+	return !strcmp(path1, path2);
+}
+
+static void update_ess(void *data, struct l_dbus_message_iter *variant)
+{
+	struct network *network = data;
+	struct l_dbus_message_iter array;
+	const char *path;
+
+	if (!network->bss_list)
+		network->bss_list = l_queue_new();
+
+	if (!l_dbus_message_iter_get_variant(variant, "ao", &array))
+		return;
+
+	while (l_dbus_message_iter_next_entry(&array, &path)) {
+		l_free(l_queue_remove_if(network->bss_list, match_path, path));
+		l_queue_push_head(network->bss_list, l_strdup(path));
+	}
+}
+
+static const char *get_ess(const void *data)
+{
+	const struct network *network = data;
+	static char count[10];
+
+	snprintf(count, 10, "Count %u", l_queue_length(network->bss_list));
+
+	return count;
+}
+
+struct l_queue *network_get_bss_list(
+				const struct proxy_interface *network_proxy)
+{
+	const struct network *network = proxy_interface_get_data(network_proxy);
+	if (!network)
+		return NULL;
+
+	return network->bss_list;
+}
+
 static const struct proxy_interface_property network_properties[] = {
 	{ "Name",       "s", update_name, get_name },
 	{ "Connected",  "b", update_connected},
 	{ "Device",     "o", update_device},
 	{ "Type",       "s", update_type},
+	{ "ExtendedServiceSet",  "ao", update_ess, get_ess },
 	{ }
 };
 
@@ -186,6 +234,7 @@ static void network_destroy(void *data)
 	l_free(network->name);
 	l_free(network->type);
 	l_free(network->identity);
+	l_queue_destroy(network->bss_list, l_free);
 
 	network->device = NULL;
 
diff --git a/client/network.h b/client/network.h
index 41624749..56d74e3f 100644
--- a/client/network.h
+++ b/client/network.h
@@ -37,3 +37,5 @@ char *network_name_completion(const struct proxy_interface *device,
 struct l_queue *network_match_by_device_and_args(
 					const struct proxy_interface *device,
 					const struct network_args *args);
+struct l_queue *network_get_bss_list(
+				const struct proxy_interface *network_proxy);
-- 
2.34.1

