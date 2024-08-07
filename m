Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0528913E02E
	for <iwd@lists.linux.dev>; Wed,  7 Aug 2024 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054488; cv=none; b=Rf51puBPSuwQgTAjOiWzVxSm3v/HjXJFJMu/wjh5r0qPw9ilOsOc7fqjtPbqbWWmFTOld0BuktxaG+2oBFQHZwYr5o6shjqLqtlkWUxjH+7ZMgXGx/H0BsF0GzgWrcahyQRZgZdpJ/tD7BxQn2VD5E0vwe1cqsTulxX4MiQRCis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054488; c=relaxed/simple;
	bh=0CxoP8yLcs+mK9CigTo34USqvkY8DtaZ6lWVEiiFJh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lw5x+owewM3opyq8rlc+voTMdW44rwBQdbqp7f63uUr01s4/slwVIlWIJSQqzvj9j0PZQOm1E7kd5v5IilMqbdmMJozS7EWkAeuFSQG2CJAZI1g3EKkW2SIruU4WWwllIvUNbXa20cv5OZT4PDPtqRMfXZYY3GZXyHrVDQ7B06E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+vOI80/; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+vOI80/"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a1e4c75488so13398485a.0
        for <iwd@lists.linux.dev>; Wed, 07 Aug 2024 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723054486; x=1723659286; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHB5jdKwmPEJ4E50Miq0V5W+hpBUXM56GEW+CN1LpJk=;
        b=L+vOI80/F9drZc00e4fzfxvcnrnv9UWdbg9dfYZvKEBLEDJ4PhnpAK7pSFeu30sv2l
         72nX2jXaLRJJROWksRRH/TnJO8PDP7IeRlgT4rXZsKqQclzr4RzwiISAFOYEY1zCOmfs
         AQQmtuvU3Ng5NLsjixHUxL8FRW++3+4u8bhQ7oMFEixMTa2FAW0wWD1Z0mnYhOElSCvE
         dCTILhsO8Tuar2AUJ7WLzM6kNjHIm/lZ2D6EKnJskqE8LWJvi84/AmWsYdF2rs7LUJum
         Gkl6Ua3CxicgDpvY/D31a2NqKsDWz3RMpkcb9CvsXaexsdv13xRLdymEBRKTrNAA2LBa
         vnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054486; x=1723659286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QHB5jdKwmPEJ4E50Miq0V5W+hpBUXM56GEW+CN1LpJk=;
        b=sO+Bqa1ktj1QD+py3ocLQ3JMuBNo4NKRa9XK7CYE7woQN58JjkViEx5XoDvq6x6ExF
         0wfztP8BNASwaP5l+f/BLBW/3nEmB6ah8Z6PYJCfiz82AkAtiAE+uS/i7CpLZ2qOkuZY
         dUXn/mT4e3XUkBWHQhf5I6Tlr0qLFcsTo27bpnTJek4a2nRKLtxiCwcL/tSs7uW388Lj
         pUFj0eX0K5/ciGqL2ZtVXVjv5OtMciCsmeD2Xt6Yruf5l0k0skHKZ0w2v9QEx/iSUrNj
         7H0LSzeyzugxTxRgv39bqJ/pKhDnwlxeskxEhfWfaBNiN+0TmUBNMXldgZSGp0pqCUPV
         P5kg==
X-Gm-Message-State: AOJu0YyUNydi9J58zIY8UkiYbXDoDMG6jxyadJ+yhSEstprsOYK8vj2u
	KB4ukz7PXrtvB4k3MQ8HM6q6Q9zRKE5udDFsS3n1HVsbTTanVRFbT5xzMQ==
X-Google-Smtp-Source: AGHT+IEEWX8nmmKVYybkWVnaYxLUOfH5zpJD6Y7spHAYLajcXbvUlbl6A+JtC62OBbNmpw6IfF1epQ==
X-Received: by 2002:a05:620a:4551:b0:79e:f850:e4de with SMTP id af79cd13be357-7a34ed88bf6mr2430045585a.0.1723054485731;
        Wed, 07 Aug 2024 11:14:45 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785d0db4sm82194685a.7.2024.08.07.11.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:14:45 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 11/14] client: Add BasicServiceSets property to network
Date: Wed,  7 Aug 2024 11:14:24 -0700
Message-Id: <20240807181427.170515-11-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807181427.170515-1-prestwoj@gmail.com>
References: <20240807181427.170515-1-prestwoj@gmail.com>
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
index 6b79bcd1..2bb986ce 100644
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
+static void update_bss(void *data, struct l_dbus_message_iter *variant)
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
+static const char *get_bss(const void *data)
+{
+	const struct network *network = data;
+	static char count[4];
+
+	snprintf(count, 4, "%u", l_queue_length(network->bss_list));
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
+	{ "BasicServiceSets",  "ao", update_bss, get_bss },
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

