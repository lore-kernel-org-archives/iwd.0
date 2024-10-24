Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6961E3763
	for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729775797; cv=none; b=rzwIczugVIXPGa9fNxPTtbYoKg5VNLH0YPLE7LPpejMRFBILWykxD32zRvryNFMwIQbV1ZVZsw4G3qvJJuSrFruXcu02tytQ2Z2GhxgkBmIig1pz2XYy4wGbjABlWrHfLyU0RRz1pe5S9HbDChhtc/41WKvMMmjV+bnhW5KiQGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729775797; c=relaxed/simple;
	bh=QWd+2+Z/Z8dRIeUtxlEJMwD59tee9Kj3A2Y1167K2h4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hx9EJOeTCZfAmhDSGFXEi1VnYD//wHgHMTZmMSa0YjNCpNkJkTU3FV6Xdh06imKyHBA7zeHariu1XOhwtnek5MT5uElem3I1C29VwsmroFXwWOmqdUuw8WwM8hfRujHuYmN/XGxioq6ej/uJlGRMoXbAAQ0eUv25HMSWS9m2Rr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXiCpoNz; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXiCpoNz"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71e467c3996so661113b3a.2
        for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 06:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729775794; x=1730380594; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C+dpV4Cfy3wlTzuZkHMq/ecCh9qUNcs5xq5sK1IWHJc=;
        b=PXiCpoNzYxbuAToK1iP8CCubrj8PIo0RfDR4HU1IPPhzt6Bt1IAIxCbOVQbIQ5swMU
         zWBPM44pMUwBXvVyBbXfI5hBzmdCXk4x3J+9lfbyEB6r9jgT9uVX6QMd7yCuh/EpGWux
         c7cdu7SeA7Y1Fo01+uRRc9Y1Hy21VHMowoaQHFQEi2K6sfIEbz2TUlfFwMyx/O4V2jA0
         fO6NZ54dNnlPfu/1F139bYke0NQ/gLQMFpAvX6D9vYIGvWNapo9/xeuuCzHHwzSIZ+F+
         DdGoejz8DfTzRPtxRKutdWdsqcgDGQuhoanHhRk6hA2S4favngylLn0o72EuGIjaiebf
         PDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729775794; x=1730380594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+dpV4Cfy3wlTzuZkHMq/ecCh9qUNcs5xq5sK1IWHJc=;
        b=ZR6hJ8Jmbc/eufwaB4PN7JYqq0mAIKFS5NXtjyrB/mFhzJ23dtaokS7nX25GIOGlh2
         fldy58yeX+Z/M3/wPuZpq3LWlTJrxcbI1HtQoz9U8DizQDDcytDvXby+LIVArIXUmglJ
         L04dVDoItOmCCt5IuWcz8WNoOOx6+zrhaIR7WGikRo3Daueh3dxZWdp94I9AuPd9OgJr
         jFOnVI7ahiWtoP/prq6sYcLbfe1QvA+XEa5M4zJJKrGOwiXtXmXJ3AXSHszFAPH6wmMr
         sqQhpHDTaDPRFvZwyrCxwrYlOnuGRowMkjBm6iknP52kf6kMjDAntFFtAh7UXZ4YfP05
         17Vw==
X-Gm-Message-State: AOJu0Yz8JFymOEOpYHmQZJu/wiktIHmw28KLwZMLvYn22ZLhb7mtJGIE
	+GrsUyaenbO4YlsmECj8gXkX0eUY6uXBVi99bbONBYL2fFdT4d0wzFT22w==
X-Google-Smtp-Source: AGHT+IE7r82Y/qIfln4qXfOFzUlJSsLUyWoNPazsCYkZ7uNwhE8KrB18z6rwARoGyRXBvmMUxIdTEw==
X-Received: by 2002:a05:6a00:4fc4:b0:71e:4196:ddb2 with SMTP id d2e1a72fcca58-72045e4903fmr2099043b3a.9.1729775794042;
        Thu, 24 Oct 2024 06:16:34 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec131391asm7897963b3a.26.2024.10.24.06.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 06:16:33 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: check support for all sysfs settings
Date: Thu, 24 Oct 2024 06:16:28 -0700
Message-Id: <20241024131628.152607-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If IPv6 is disabled or not supported at the kernel level writing the
sysfs settings will fail. A few of them had a support check but this
patch adds a supported bool to the remainder so we done get errors
like:

Unable to write drop_unsolicited_na to /proc/sys/net/ipv6/conf/wlan0/drop_unsolicited_na
---
 src/station.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/src/station.c b/src/station.c
index cef6c66a..34537b26 100644
--- a/src/station.c
+++ b/src/station.c
@@ -74,6 +74,10 @@ static uint32_t roam_retry_interval;
 static bool anqp_disabled;
 static bool supports_arp_evict_nocarrier;
 static bool supports_ndisc_evict_nocarrier;
+static bool supports_drop_gratuitous_arp;
+static bool supports_drop_unsolicited_na;
+static bool supports_ipv4_drop_unicast_in_l2_multicast;
+static bool supports_ipv6_drop_unicast_in_l2_multicast;
 static struct watchlist event_watches;
 static uint32_t known_networks_watch;
 static uint32_t allowed_bands;
@@ -1641,10 +1645,13 @@ static void station_set_drop_neighbor_discovery(struct station *station,
 {
 	char *v = value ? "1" : "0";
 
-	sysfs_write_ipv4_setting(netdev_get_name(station->netdev),
-				"drop_gratuitous_arp", v);
-	sysfs_write_ipv6_setting(netdev_get_name(station->netdev),
-				"drop_unsolicited_na", v);
+	if (supports_drop_gratuitous_arp)
+		sysfs_write_ipv4_setting(netdev_get_name(station->netdev),
+					"drop_gratuitous_arp", v);
+
+	if (supports_drop_unsolicited_na)
+		sysfs_write_ipv6_setting(netdev_get_name(station->netdev),
+					"drop_unsolicited_na", v);
 }
 
 static void station_set_drop_unicast_l2_multicast(struct station *station,
@@ -1652,10 +1659,13 @@ static void station_set_drop_unicast_l2_multicast(struct station *station,
 {
 	char *v = value ? "1" : "0";
 
-	sysfs_write_ipv4_setting(netdev_get_name(station->netdev),
-				"drop_unicast_in_l2_multicast", v);
-	sysfs_write_ipv6_setting(netdev_get_name(station->netdev),
-				"drop_unicast_in_l2_multicast", v);
+	if (supports_ipv4_drop_unicast_in_l2_multicast)
+		sysfs_write_ipv4_setting(netdev_get_name(station->netdev),
+					"drop_unicast_in_l2_multicast", v);
+
+	if (supports_ipv6_drop_unicast_in_l2_multicast)
+		sysfs_write_ipv6_setting(netdev_get_name(station->netdev),
+					"drop_unicast_in_l2_multicast", v);
 }
 
 static void station_signal_agent_notify(struct station *station);
@@ -5813,6 +5823,16 @@ static int station_init(void)
 						"arp_evict_nocarrier");
 	supports_ndisc_evict_nocarrier = sysfs_supports_ipv6_setting("all",
 						"ndisc_evict_nocarrier");
+	supports_drop_gratuitous_arp = sysfs_supports_ipv4_setting("all",
+						"drop_gratuitous_arp");
+	supports_drop_unsolicited_na = sysfs_supports_ipv6_setting("all",
+						"drop_unsolicited_na");
+	supports_ipv4_drop_unicast_in_l2_multicast =
+					sysfs_supports_ipv4_setting("all",
+					"drop_unicast_in_l2_multicast");
+	supports_ipv6_drop_unicast_in_l2_multicast =
+					sysfs_supports_ipv6_setting("all",
+					"drop_unicast_in_l2_multicast");
 
 	watchlist_init(&event_watches, NULL);
 
-- 
2.34.1

