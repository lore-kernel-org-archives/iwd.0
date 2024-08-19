Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6188D186E2A
	for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724089926; cv=none; b=cxyxMisz97+Lv0tcoJiJRCDUqFLAfN+d5+vJPoMlFF7mOIg40e37GcgV/LzK+eQYkL5gKatADL3tvcEQdinYumNdWMTnHxSQna5WNsMkCtaD0mOV/rndmZaQ7FMlFfHXCT+ZceRnqEnlk85x2UD4inPsEjq2leduBF9mG5EFX4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724089926; c=relaxed/simple;
	bh=00E/Q41Zd2TOJrvpL/uo48OfjqhxcO7Lhb51yFY6IyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vqh23j4NiASbIKCoir+C9eETzUBlzU0Al1+HylfThk19m3aCYwtXs85qIJoYbc/Uj4BGdgyQ2/fdUMSSBhxubmn6/OYiBRlrX0mKSWlo52Mz5zN6Lc3ej16CSapdHiltlHSF9C6y+OdEjf68k3746L3HlnWBD/b0u77UzegZtbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfYA0Vr0; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfYA0Vr0"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-842fe6f6c04so1342777241.2
        for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 10:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724089924; x=1724694724; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsPBgH5j1k8yNYZmLRoPq0A2N0INvrJgLlqXadmlZh4=;
        b=LfYA0Vr0UiQtAofwdsbXoNMUh7IFPVDkxO1U6Rz/4ZnHJIS3lOwSjKi6OcPI0xQ/7R
         SVJqMLgU2VNvHHfcoWMhtD5P0tlxuhvKRRS3m42ueuhxQyE+qzC/HyjbvTimm4pQOlA2
         pX86nURNS2F9ytvcAZOtxiXyUEuZRO4saX6TBEgLWXgYkMCkp2WX/9WBkreglALGhOoa
         BMExwck+4Qo7fk/iv6csRuGbPh55wzmrHIOKtSlzi6QIYHecW3U14bzBSUHjqXOBax81
         wq33Q1/KKkqson3Md02Q3eOf74/bq5+iN1ciVcTCR4CVAQsxU4fQdXEXgZIPkfJBGFJ7
         Qrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724089924; x=1724694724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DsPBgH5j1k8yNYZmLRoPq0A2N0INvrJgLlqXadmlZh4=;
        b=v3byTjj1CwMBqwJoioeGMFTZeuoIc1lXpmcHz9c4d+vy1wT+7v2US5zvl0KqMxStBO
         bihrurDsCOLMOsp2V2K+X/Qx58Mn4OLN1V1gLpu0RjnwsgZ3zYCS9dDSv49HhKpGvd9B
         aa/z9CmhTcrxEr3UB04HQ+BHuKcRenhRdq+QiZfKC1Svja3BtjBnXQt7v/eXG8rGboDO
         P7RT5ZzVtj309GTb38DaO9KUsE3j9s1bCMNejetvHpDb9A5uihGvONf1IbpZhIdgeFLC
         6EZ3WF4Gx4+D5fJmRwBqi1mw4tV+lX23mBwHXL0NrYUulTbY6+r323RCDc/LgA6lWwlW
         wLfA==
X-Gm-Message-State: AOJu0Yy3vu0coQKWl+yzOnWcJUiwyfVdwd8Nz6JpBP1jtzMDUmew+PlA
	E+eTZBzuJQqJm/RoPmiKWOa8jNNCzO9rU77Y6zhIPUBz7vi+jSchRWj3sQ==
X-Google-Smtp-Source: AGHT+IFVwCa/iqkMXjBb8Z6jJHKZkqeZxkpB6mpvvvx/Qv0VDOc7C6p4FWVadv0OFOsgxtqAQmTj4g==
X-Received: by 2002:a05:6102:3906:b0:493:b965:7d03 with SMTP id ada2fe7eead31-497798f97e3mr13758109137.13.1724089924050;
        Mon, 19 Aug 2024 10:52:04 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e5a1csm451854685a.74.2024.08.19.10.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 10:52:03 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/8] station: emit property changed for ConnectedAccessPoint
Date: Mon, 19 Aug 2024 10:51:47 -0700
Message-Id: <20240819175151.1310546-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819175151.1310546-1-prestwoj@gmail.com>
References: <20240819175151.1310546-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was missed in a prior patch set. When station is connecting
or disconnecting ConnectedAccessPoint property change should be
emitted.
---
 src/station.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/station.c b/src/station.c
index 6a28254b..333b0fa1 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1694,6 +1694,8 @@ static void station_enter_state(struct station *station,
 
 		l_dbus_property_changed(dbus, netdev_get_path(station->netdev),
 				IWD_STATION_INTERFACE, "ConnectedNetwork");
+		l_dbus_property_changed(dbus, netdev_get_path(station->netdev),
+				IWD_STATION_INTERFACE, "ConnectedAccessPoint");
 		l_dbus_property_changed(dbus,
 				network_get_path(station->connected_network),
 				IWD_NETWORK_INTERFACE, "Connected");
@@ -1865,6 +1867,8 @@ static void station_reset_connection_state(struct station *station)
 
 	l_dbus_property_changed(dbus, netdev_get_path(station->netdev),
 				IWD_STATION_INTERFACE, "ConnectedNetwork");
+	l_dbus_property_changed(dbus, netdev_get_path(station->netdev),
+				IWD_STATION_INTERFACE, "ConnectedAccessPoint");
 	l_dbus_property_changed(dbus, network_get_path(network),
 				IWD_NETWORK_INTERFACE, "Connected");
 	l_dbus_object_remove_interface(dbus, netdev_get_path(station->netdev),
-- 
2.34.1

