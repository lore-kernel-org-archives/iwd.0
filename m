Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80062186E47
	for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477605; cv=none; b=KjwIQTM0bqoUeLbSe67b2Ud26uNBGJ8VvLvCD7yWOtv+CFyNCp58fdWLeq2y2fQQjc0q1jJnzW0OrHyLYjusTzjRYurl00q7K/LdMV+2NEpTIQjlOxXCXNxCTQzrzpZPrM+pfCZCHtWgdP1QmwUGd8ScWUz1pNnznwK2tAzUlzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477605; c=relaxed/simple;
	bh=cgLZfJReiqyoHO2vj5i33u/5uHkuCEpQxKVkzMASb7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lnO5wdPyoga98ykenrjtgzJJZ45hRKfJXxSHB0oOtFSgRYL1EpZlM8GshT0MhsBFxK7/P/Kv8yBBtwMd4HLSpwCMfyfS+PBxcUKpMFbkjjXuezpaReyQb2/VkRbjVRYubViBjX016wOaMad/jrFvC0YhaPxkRdyCYzgbuj+qNBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2kt88+C; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2kt88+C"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5b391c8abd7so5263401a12.2
        for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 08:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723477601; x=1724082401; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkSDlpminQGhbEfKy7XbbczaPNShZF8GbJOpidG1zbs=;
        b=R2kt88+COLtbXsiFDquZyyPGMFZ3GZLcZ7l0L187ROBO37DSeCckNNJAv4MmzfAtvX
         Mq4Caj9fmoqOo1YiQ6YeXJ+2LNafJJlIVtj3zUzt/IGHdx4wGWdjWtlCUH/XWljnWmct
         OyuHlDTJ6RYhQE6f4Q7Ngf7pe/NLOvUI+nqPufQxaovKbhvsr9nS7sVObW9POTZ7oTSE
         hPwo8paqP9xBrqQxo+MC8NInxm130zYcOhumpctkBafdLtCWgAStEe7xf5uvbI5UywTi
         rp6mQFoL8QgDJ4HsagBUjMVG3jKu5ajLtEGmdNP4OSeBZIAHgR6USHh2rL0ShRuPheq8
         MiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723477601; x=1724082401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkSDlpminQGhbEfKy7XbbczaPNShZF8GbJOpidG1zbs=;
        b=g9Zy/1Om8obmuI6vXufHDkqMDoffoJNr9a3qJYeERH0fFZTovIiSQJVlQYNTZgFAyN
         Zm5cFJZy6lOBIlEAH9LCha9oz1mFtObveqqbdB438cRiaKMLgqdw7d+EYQsP2r3dj4df
         DsyJKpb0ELsl/hIzXdSEzVyC0x9D39D6OKLoDzZqyDHXzJB6oTr7nmntBUKAYWbSYCfM
         HeHUnYms8toez0ZKtVwZjqYF4gFRSp1A6xmoEK+IQTnjqqp641vGtlA2emaSroCnXoPA
         Ay8Aq1dlj+CWWU4Tx72Y2QqZnz3cFex0TcrDYLY1D38O4+6Wb0qPRltxuQwwtnyTL4Or
         seMg==
X-Gm-Message-State: AOJu0YyFIz0vpDSVTo5KoL3OpAbe/B3aouXe+IENcvZKjBH2BdTLpn4I
	vPshA14DJc0RoPvuqXkUsC81MzXz+mjDeKaYvCiX2SZ3EJvGBHd5rAW4vg==
X-Google-Smtp-Source: AGHT+IGLXxZr1ClbK0evJI43K0p2taPKbdun2AwZxFWDy7nyfAo21angcOIapdJ5kMvovhEZK7aL1w==
X-Received: by 2002:a05:6402:430b:b0:5a1:1740:33cc with SMTP id 4fb4d7f45d1cf-5bd44c0e074mr619439a12.3.1723477601434;
        Mon, 12 Aug 2024 08:46:41 -0700 (PDT)
Received: from LOCLAP699.vf-sint-niklaas.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd190adb45sm2224931a12.32.2024.08.12.08.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:46:41 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 13/13] client: add station command "get-bsses"
Date: Mon, 12 Aug 2024 08:46:13 -0700
Message-Id: <20240812154613.126522-13-prestwoj@gmail.com>
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

This command will get the BasicServiceSet list for a given network.
If no network is supplied, its assumed to be the current network.
---
 client/station.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/client/station.c b/client/station.c
index 58aac29e..5066a9f1 100644
--- a/client/station.c
+++ b/client/station.c
@@ -723,6 +723,55 @@ static enum cmd_status cmd_show(const char *device_name,
 	return CMD_STATUS_TRIGGERED;
 }
 
+
+static enum cmd_status cmd_get_bsses(const char *device_name,
+						char **argv, int argc)
+{
+	const struct proxy_interface *station_i =
+			device_proxy_find(device_name, IWD_STATION_INTERFACE);
+	const struct station *station = proxy_interface_get_data(station_i);
+	struct l_queue *bss_list;
+	const struct l_queue_entry *e;
+	const struct proxy_interface *network_proxy;
+	char header[256];
+
+	if (argc > 0)
+		network_proxy = find_network(device_name, argv[0],
+						argc >= 2 ? argv[1] : NULL);
+	else
+		network_proxy = station->connected_network;
+
+	if (!network_proxy) {
+		display_error("Can't find network");
+		return CMD_STATUS_INVALID_ARGS;
+	}
+
+	bss_list = network_get_bss_list(network_proxy);
+	if (!bss_list) {
+		display_error("No BSS list for network");
+		return CMD_STATUS_FAILED;
+	}
+
+	sprintf(header, "%s BasicServiceSets", network_get_name(network_proxy));
+
+	proxy_properties_display_header(header, MARGIN, 10, 18);
+
+	for (e = l_queue_get_entries(bss_list); e; e = e->next) {
+		const char *path = e->data;
+		const struct proxy_interface *bss_i = proxy_interface_find(
+						IWD_BSS_INTERFACE, path);
+
+		if (!bss_i)
+			continue;
+
+		display_table_row(MARGIN, 1, strlen(path), path);
+		proxy_properties_display_inline(bss_i, MARGIN, 10, 18);
+		display_table_row(MARGIN, 1, 1, "");
+	}
+
+	return CMD_STATUS_DONE;
+}
+
 static const struct command station_commands[] = {
 	{ NULL, "list", NULL, cmd_list, "List devices in Station mode", true },
 	{ "<wlan>", "connect",
@@ -747,6 +796,8 @@ static const struct command station_commands[] = {
 						"Get hidden APs", true },
 	{ "<wlan>", "scan",     NULL,   cmd_scan, "Scan for networks" },
 	{ "<wlan>", "show",     NULL,   cmd_show, "Show station info", true },
+	{ "<wlan>", "get-bsses", "[network] [security]", cmd_get_bsses,
+				"Get BSS's for a network", true },
 	{ }
 };
 
-- 
2.34.1

