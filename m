Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5368213D8A3
	for <iwd@lists.linux.dev>; Thu,  8 Aug 2024 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138969; cv=none; b=j1m+9SgbTaFMrMrLblJo64YdBts1EdjkrjMBHVRSLgg6u2a5wupDB7/y+pCVMlrMb6BoW3gGEIKubrOSrcwVBY5kKC+fOnFKAX8uOv0s7fjSq3I/6PQOE6N+jyZoHp3CKu5BhgYCNklX3gFoEWZ8ngtxF3OOol4MQtmlEi5e1ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138969; c=relaxed/simple;
	bh=vAb58u/XqBNtRFv1ckkIBuj3cRcHiM1+Zb6zKxs1xXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oclIsGFR1KZsCMWSd8R7KecvmYn8eRELvN1SkN6WSZTjTnlMg6ivlcTwjK3qk0ABlvQ1YW/rYpTwyLS1x5/NxQudn6m76X294mE7OeW14EIqpD0Pd5AtZx627zlcOOf9AM1DBRzU2bPr+TG70DCvMBFiE2P+Tyl774dqQw9+f7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeNX1UiI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeNX1UiI"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc566ac769so11115415ad.1
        for <iwd@lists.linux.dev>; Thu, 08 Aug 2024 10:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723138967; x=1723743767; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62JcGrbGI1cE9yKn+mCLTkRUEfkkg/yYCyCeCW/MocQ=;
        b=TeNX1UiIF4dFqAY8I1luurJivS7EwsH1exkx22Z2Fu8F6VJTNXZWHadfOvpA/scXJh
         CNDITyHVnVkArvX5jIHo/w7E1FjCe3wc6MuBELtTajEJdi8V7rHj7IFIHeG8eybZli1W
         IuvUbCotEEYqcuZTpr4rBZenwT3ko4Vr/cXGNXKJfMyEvGeesidw+d+ub8lFUSdqf0Ar
         5sPLHo5oVwsqdVGOG7hgWTGqajJy+KAaL2TQwiVLTESig15L6YvrpxKKG1xYIMD1vdfB
         sDlZ2JjkX98lBWOfm/catIKUK3ACTUT778L+PJzLWnW53W3WMfZgKSFUDHKWylO6nBXx
         VSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723138967; x=1723743767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62JcGrbGI1cE9yKn+mCLTkRUEfkkg/yYCyCeCW/MocQ=;
        b=NFJz6mxUCWQhxocoZPSHn4xIrvprjpeAPVrwnGW7Y73iODGZIRWPHgCFda86WJ367s
         LPSCKeKVsvKHtHVO/lGBKbouxb9K+S99VxoFFGMDhhRMZveqjUdQPCTTR83k5g2AFOmE
         SggdOl19xS/Bu8vVvaPDhngHZo3sOk6+9eRAX42a7T3hf6BlFyj85w+jjsjVY/0JzgvH
         ea9qQTIKLXlCeLhqOuVNDvvQ9sR705nUWLwH+ZW2+E6kM4sLZ3SH1MG9vAEFkIzNmrBS
         lCqZpaIBBZrz8Z+vvVlKVDiYM5Sx07YdE72fdVASw2uqm0aUfCN/aCSVx6l7zOQ9fW0I
         00KQ==
X-Gm-Message-State: AOJu0Yw4D8Q0cB35xH1xhcwpIL2qaS+wgHjn84423VE2omqZLGlf8Ct4
	LqM2R9qEDFhkxhr1j8GfxoyxLTgLLrhHiv93FpzpMSVBEDK9/QKoZ2PIsQ==
X-Google-Smtp-Source: AGHT+IHBrsoI6+Jp48I//vi7kTFg6KktViKPhmJyOo+zY33r5mcuIb+uTIQVtXny8djh6wBPZHQU8A==
X-Received: by 2002:a17:902:d490:b0:1fd:9c2d:2ef1 with SMTP id d9443c01a7336-200953c1d7emr32581855ad.53.1723138967238;
        Thu, 08 Aug 2024 10:42:47 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f53435sm127478355ad.64.2024.08.08.10.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:42:46 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 10/13] client: Add BasicServiceSets property to network
Date: Thu,  8 Aug 2024 10:42:33 -0700
Message-Id: <20240808174236.218750-10-prestwoj@gmail.com>
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

