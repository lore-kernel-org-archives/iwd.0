Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03B113E02E
	for <iwd@lists.linux.dev>; Wed,  7 Aug 2024 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054492; cv=none; b=nr91VFOCxrC6r63U0whxNm9mKzOFlS+rzhWGkFPEz0HbInCaSuu2fOLycyKMGr3MYnmQebncLQ5zYk2wFcNiQI3u9H4F/jyHS89dL63+Wka4FUIwsrC1EH1TvwLSc46WOY173RU9F/4hEaLLZ9fA9o5T1VHKBU7BmJqPCi8/0k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054492; c=relaxed/simple;
	bh=cgLZfJReiqyoHO2vj5i33u/5uHkuCEpQxKVkzMASb7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YASn6rcS/0+VAifOLAKuVVwrlJkfd/e+yIWErecCz9D4+abWEOMa2Pe5a4h5Xgg4jUJdMFnpEDy1zhpYO/+tj2+PmwRWhSoovIf0sXaRXPkPVNPLXcVOiwNw6aBV78WNABH4KtHjYkoJVKaK/8WyOEqx9cFcMteGkUs4oe76tqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dv/YTaqM; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dv/YTaqM"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4f51981b1beso50714e0c.2
        for <iwd@lists.linux.dev>; Wed, 07 Aug 2024 11:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723054489; x=1723659289; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkSDlpminQGhbEfKy7XbbczaPNShZF8GbJOpidG1zbs=;
        b=dv/YTaqM7C9rurSGvSTRDakNyIH5cLriIgsaRYsF3YyJH5L2c25iCMDerjkSlPcycO
         oAVOCgCCSTmKqE6bP9d/Nih1y5CWpXU7y3AlWIdDDON7VsLWG3Godov5op9hfbzeUp2l
         kc0ixnI2XX21dy2Uc9JPkn4lNg1Eh31zjmWCiudi0+5VKeSYnjuMQaegaHz/JGd9JxZo
         ZbM3RMmNjaIdSHDkSLxV8Ka0Ps6Ru/5JUs8hKsjdpFM8u/uEE0tpstXmDoSz+e2BWs5X
         mWAolMim+k/uvtR+QVHgLOjjGrPtYrJeGvJB1Ts2yI9SSoX50Ihb+diu4ri4FPpJykTN
         2RZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054489; x=1723659289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkSDlpminQGhbEfKy7XbbczaPNShZF8GbJOpidG1zbs=;
        b=vyglcEHQhNeJ62zSvqJnqtZ7JprIw7ivmBuqdKaomxwURLsUVOZ1GZnsR9ptAP0u5l
         AspcWnBc1COB6NUvq90rKv65dA59biYBVSzEBIVArFEPI+pZMtidWkceKyNTzTHtIKnR
         sezPiLBBcoKkvj1H+g9rB3Nu7OfmndmzcCvdcebF1prv8fdTk3qPqx57BputG4pu19ba
         /q4Ao9eavVBOD7Mh9OTVTvMCItZkpZ5s7AImNErKml0ITY62cY0HFlgyY9JbFSMpcBir
         KR8HhdDKzQBu9IHJ4nbi7vK/NKJrGJ0FhTEnekeDLDUYyc/OABESiAGUdwMcPRVoIYxA
         Rebw==
X-Gm-Message-State: AOJu0YxVLXID8qTkatTyov+BsgIw+UU2JBD0YjiQgmSoVZQxK3o2zFkj
	b5qw7dv84T+OI9xFUGBQR50wlQRGE0d95eKWl+y8e7VAioPLceeC2FebzQ==
X-Google-Smtp-Source: AGHT+IHK98KtAi39OVOe6ydKuKh5lro/cjG/p89r/Mm+6hB7SQTQ1QyZXrNJHTKnwhYdP+Bv8vVs6w==
X-Received: by 2002:a05:6122:3c87:b0:4f6:ad39:dab1 with SMTP id 71dfb90a1353d-4f89ff611cfmr24127526e0c.5.1723054489331;
        Wed, 07 Aug 2024 11:14:49 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785d0db4sm82194685a.7.2024.08.07.11.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:14:48 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 14/14] client: add station command "get-bsses"
Date: Wed,  7 Aug 2024 11:14:27 -0700
Message-Id: <20240807181427.170515-14-prestwoj@gmail.com>
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

