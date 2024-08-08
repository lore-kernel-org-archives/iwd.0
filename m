Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A637D1917D0
	for <iwd@lists.linux.dev>; Thu,  8 Aug 2024 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138973; cv=none; b=U1KaTxmVEJnqlP1lSQ/qTnIxdKUURJTwl3q+OnYoB7iaPkhbY2hh1XMaZ2si/imWe0H9S6OInlzADbEksGqkPUHo9iVeTqiujmAm2yVAvI8HSkWqmJRVL4w55Z+YhBEM/bXr144vMMUtjdpGo5b+kiaParx+Oi7x17vlI8+58VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138973; c=relaxed/simple;
	bh=cgLZfJReiqyoHO2vj5i33u/5uHkuCEpQxKVkzMASb7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hXJ7lvM+AZ3Qdc4HntbFX6xsjS5rGIQhxhOJLAbf1JBM0F9RGdt2WEdLYfpNVeSU5B7E9ZQz3T32gkDFcPEJNdIzdA+6e4Vmfl00wxg739btI0rIujKX73LojNS77hrGTvfwUa3RWiLy8GKBuoucP4G1n/GARFnL6iFEorTPYv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gisISUHk; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gisISUHk"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fd90c2fc68so11504185ad.1
        for <iwd@lists.linux.dev>; Thu, 08 Aug 2024 10:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723138971; x=1723743771; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkSDlpminQGhbEfKy7XbbczaPNShZF8GbJOpidG1zbs=;
        b=gisISUHkDGaT9PxDTNCcCJ2+OlanQ6TCD69Lk1tIyDsOAb2M+BlwSBGCnPn1z3fPri
         VzPEV+NfInrsxHdXDhsJncIUXc7FmdXj7CbAsUtzfL+mB5b9mHiXSdpggdEoESP8Lwus
         qTfXzYKVXAiNoAQgFIehG9oUkq7HQgsLzSQKluNsFRubveVsezT1cwTn3svWv6iD+ELp
         U0U15aqnBZMtVYNFeTc1gPL0IZSY8G8sP447OY7NgXeVzKZ9c4I3M2ay90Pc/CFj6DDg
         VMu0+sV2WdISry2z0ZnwrLQInT9l4Kw4zK2YanpFTlxFKyQj/1YEo+uk5DNuvo2T0Tqe
         q48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723138971; x=1723743771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkSDlpminQGhbEfKy7XbbczaPNShZF8GbJOpidG1zbs=;
        b=F3T8vY8zxtx/ZrG218bbkn63lt7MmswJGV2NePHi0SZ93CJ/aKnwS4bxfSj/tt3qqd
         LV1ZEPhlan23z9nw+C7lx0yh/bFXoOGM/orBgKR8ursGJjjIbWQc9VVw37DF3dIa52Ot
         QKoB6PckZp2+G3dnWBOjx2WfDd32Z3aOA9h8tFrI8Sn/H72bl/tKFu8WyLL+pJfxjlEL
         QoxbFeOdc6tsTe3e4+INdquwG45W3LJz26DEP8JJ6nuCied+5WrviMarsWeYNU8T6ZnK
         rCx1Ybc/vaR9T93Qqadtrf+sB50sfgIdavxqwzZBVUg7Sj/oauG2VFWDE9IngCe2hiV8
         rCAg==
X-Gm-Message-State: AOJu0YxOIuDoNcpl+yrn1s5uSMmfAz9Ox6w1xFQlZOHxr0khL3fDSPsM
	bKYnqlk4e5AqU9YEu8XisWOtz1UrBzSD7vYxWuNUkpa1V9n29jBwQegicQ==
X-Google-Smtp-Source: AGHT+IFwg2lb6t/pS4oAWJXZdUWI3+zyS23oPWov7kZSTNxRuT7piMCbOx4qK0XeTF4Ibqyx6akJ/Q==
X-Received: by 2002:a17:902:cf03:b0:1fd:9a23:90cc with SMTP id d9443c01a7336-2009524a0b6mr27797585ad.26.1723138970787;
        Thu, 08 Aug 2024 10:42:50 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f53435sm127478355ad.64.2024.08.08.10.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 10:42:49 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 13/13] client: add station command "get-bsses"
Date: Thu,  8 Aug 2024 10:42:36 -0700
Message-Id: <20240808174236.218750-13-prestwoj@gmail.com>
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

