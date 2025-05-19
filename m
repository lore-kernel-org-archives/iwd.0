Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF32199931
	for <iwd@lists.linux.dev>; Mon, 19 May 2025 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747672592; cv=none; b=OKS89HuovaW4NAbMsJ7hIhrxSNXJM0A1YcWKJl8TX0QjEHc/fOrV7pj9D/m1hu51TkXYLVYaovROxOWam1LlGgnB398rJdtHiuRWM5bb/m+nb/RNfHu/xOnCK+9Qg7Yzx7kIqEakM5ywG58SV2xpXStD7laVTKEd3gyy7z66EAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747672592; c=relaxed/simple;
	bh=Wn8AoamB7c2ujxROlUjXzMIjG6pB5njQJi4ZrZnOfmo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YbXKFyoydD89jTDljDEiwGCcXiDBFZsn2WzA25mTRz2aLMu2Io8gXBpMvXtJb3ZIEYESOQGXyCpck/e6ZlYVNTo8u5L1E/lRNbdKLqdDb6X2SAXC/Gi3t2tKIVl1WrZsM6Ub03G8CY7ecem9zX7Dwi5gyrPhfOMAK6IC3COjqXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaM4cQKw; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaM4cQKw"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742c2ed0fe1so2085393b3a.1
        for <iwd@lists.linux.dev>; Mon, 19 May 2025 09:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747672590; x=1748277390; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PALVO9Jm+haCArMDBsP53WpWpyws1EcbjpIixWRqXcs=;
        b=GaM4cQKw1hW5ZClEOKZJtdc0kAHt362ROclyd8gfYrC1wHvFP2o64y2dK8EJPXEjTP
         s+fkb/G2ut2H9FnGiicC013zuy6s5HRmx0TuElNhTJBrf5eoJteKMsnauEDJZu3wkICu
         J2LIRhJbi7lhQ2pnQNAwJcJd6mw24SVxsEk8aZFD7HkiA+o8L4pR1UncaWcN9iNhnCVn
         Axejtv0k5lQnJcJZrAQsELKp3Nk5M/d6io0syut6Mbswap+TK6b2CaTH6NhN4IwG1Yh5
         5qn9brgY0sS+JsHGjmRybahZMwVEmjfCUQycTzZRra2Jy+Y+l3OAAHB4kte4K+viGblA
         KM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747672590; x=1748277390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PALVO9Jm+haCArMDBsP53WpWpyws1EcbjpIixWRqXcs=;
        b=YQbUYfiQyErUlN4I5LvBJKxefxDVgYB04PzuROr8mT+qkzjfJsxVMAOXf9au1AtJiZ
         VgqJg03T+9g3mPwXSrJyNWGiX0gL7iM3vt55AqZe+GYDf3rmSKPrqiyETVEnymOXiO4w
         AlKxKk+l4r4VvDOnRGuNvAYC94SiVqoBiOvHMc4WUZXG2UTicGLERO2GNOIxULSNMxND
         yDuQ88cisfgDAJGKwVkHCavl2KdNyQMKc0eFEwQEl1hDVMiydtZ9K7XBHdQM2240ftjq
         f4zJKtkckojet8yg+j47RsvWSCH12KF82weaFrw6z9zBfTR3i5DchKDh8tYZba8e2mwH
         Hdzw==
X-Gm-Message-State: AOJu0Yz5uNggC/oG1eDBV0Y1NhbfQkQXsshW5zdys7fVrnWW3zjAbWij
	LkxAMdZO46eO5vrGk0rQr88BRmkeBhRjHp7V7r8vC273e3aDPvxBNumCKUEuOQ==
X-Gm-Gg: ASbGncsJXKdtnXSHtbVXyZLTSYyAqYXX5UAnMWnq4cfBJ6c8/PYpBIB8DIfBuXXrzV8
	PR/wHILVI+W7ekh/a03Y6yCr5tNpnvzhb1b/1YuscACIWCSsDokWvvgrMNwaVvsyacvh9wkI70V
	KM8xFuZYKC61+o3x+884VM4MkHoF8oJJE8pGF2a7sze5hSlkSlqT7uKyiR87MnPLthTVCxUWoXe
	/+3RtJup5fE5IoCy7+fwbIqNyuejMJ5rkV0h3N/B1jv4jghPiA3MYHSzsjazYnAcoHMEJ/cf/nj
	ThwiJ28NhYTquJrQPE2oZ2G6IR96x8TMR8wHy3pqVagV3T3fUnG+BR7YYPLbfeXKjJGNk00zp0z
	io+Vg76w7NQ==
X-Google-Smtp-Source: AGHT+IHU4wrUV2Wqj6AB5pn0w02ozjDOnKf4I/VVVertGbAQs6Ln0zOHKra8BWEIZWtPYO92UV40lA==
X-Received: by 2002:a05:6a00:6f57:b0:73d:b1ff:c758 with SMTP id d2e1a72fcca58-742a98abbecmr17947950b3a.18.1747672589919;
        Mon, 19 May 2025 09:36:29 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970bae4sm6401731b3a.43.2025.05.19.09.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 09:36:29 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] blacklist: rename ROAM_REQUESTED to AP_BUSY
Date: Mon, 19 May 2025 09:36:21 -0700
Message-Id: <20250519163624.198865-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The initial pass of this feature only envisioned BSS transition
management frames as the trigger to "roam blacklist" a BSS, hence
the original name. But some APs actually utilize status codes that
also indicate to the stations that they are busy, or not able to
handle more connections. This directly aligns with the original
motivation of the "roam blacklist" series and these events should
also trigger this type of blacklist.

First, since we will be applying this blacklist to cases other
than being told to roam, rename this reason code internally to
BLACKLIST_REASON_AP_BUSY. The config option is also being renamed
to [Blacklist].InitialAccessPointBusyTimeout while also supporting
the old config option, but warning that it is deprecated.
---
 src/blacklist.c | 20 ++++++++++++++------
 src/blacklist.h | 12 +++++++-----
 src/station.c   |  5 ++---
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/src/blacklist.c b/src/blacklist.c
index 4250618b..a1299261 100644
--- a/src/blacklist.c
+++ b/src/blacklist.c
@@ -45,7 +45,7 @@
 
 static uint64_t blacklist_multiplier;
 static uint64_t blacklist_initial_timeout;
-static uint64_t blacklist_roam_initial_timeout;
+static uint64_t blacklist_ap_busy_initial_timeout;
 static uint64_t blacklist_max_timeout;
 
 struct blacklist_entry {
@@ -67,8 +67,8 @@ static uint64_t get_reason_timeout(enum blacklist_reason reason)
 	switch (reason) {
 	case BLACKLIST_REASON_CONNECT_FAILED:
 		return blacklist_initial_timeout;
-	case BLACKLIST_REASON_ROAM_REQUESTED:
-		return blacklist_roam_initial_timeout;
+	case BLACKLIST_REASON_AP_BUSY:
+		return blacklist_ap_busy_initial_timeout;
 	default:
 		l_warn("Unhandled blacklist reason: %u", reason);
 		return 0;
@@ -218,11 +218,19 @@ static int blacklist_init(void)
 
 	if (!l_settings_get_uint64(config, "Blacklist",
 					"InitialRoamRequestedTimeout",
-					&blacklist_roam_initial_timeout))
-		blacklist_roam_initial_timeout = BLACKLIST_DEFAULT_TIMEOUT;
+					&blacklist_ap_busy_initial_timeout))
+		blacklist_ap_busy_initial_timeout = BLACKLIST_DEFAULT_TIMEOUT;
+	else
+		l_warn("[Blacklist].InitialRoamRequestedTimeout is deprecated, "
+			"use [Blacklist].InitialAccessPointBusyTimeout");
+
+	if (!l_settings_get_uint64(config, "Blacklist",
+					"InitialAccessPointBusyTimeout",
+					&blacklist_ap_busy_initial_timeout))
+		blacklist_ap_busy_initial_timeout = BLACKLIST_DEFAULT_TIMEOUT;
 
 	/* For easier user configuration the timeout values are in seconds */
-	blacklist_roam_initial_timeout *= L_USEC_PER_SEC;
+	blacklist_ap_busy_initial_timeout *= L_USEC_PER_SEC;
 
 	if (!l_settings_get_uint64(config, "Blacklist",
 					"Multiplier",
diff --git a/src/blacklist.h b/src/blacklist.h
index f5c899e0..f606157c 100644
--- a/src/blacklist.h
+++ b/src/blacklist.h
@@ -27,12 +27,14 @@ enum blacklist_reason {
 	 */
 	BLACKLIST_REASON_CONNECT_FAILED,
 	/*
-	 * This type of blacklist is added when a BSS requests IWD roams
-	 * elsewhere. This is to aid in preventing IWD from roaming/connecting
-	 * back to that BSS in the future unless there are no other "good"
-	 * candidates to connect to.
+	 * This type of blacklist is added when an AP indicates that its unable
+	 * to handle more connections. This is done via BSS-TM requests or
+	 * denied authentications/associations with certain status codes.
+	 *
+	 * Once this type of blacklist is applied to a BSS IWD will attempt to
+	 * avoid roaming to it for a configured period of time.
 	 */
-	BLACKLIST_REASON_ROAM_REQUESTED,
+	BLACKLIST_REASON_AP_BUSY,
 };
 
 void blacklist_add_bss(const uint8_t *addr, enum blacklist_reason reason);
diff --git a/src/station.c b/src/station.c
index d8016c2a..71f4db99 100644
--- a/src/station.c
+++ b/src/station.c
@@ -191,8 +191,7 @@ static uint32_t evaluate_bss_group_rank(const uint8_t *addr, uint32_t freq,
 	if (blacklist_contains_bss(addr, BLACKLIST_REASON_CONNECT_FAILED))
 		return 0;
 
-	roam_blacklist = blacklist_contains_bss(addr,
-					BLACKLIST_REASON_ROAM_REQUESTED);
+	roam_blacklist = blacklist_contains_bss(addr, BLACKLIST_REASON_AP_BUSY);
 	good_signal = signal >= netdev_get_low_signal_threshold(freq);
 
 	if (good_signal)
@@ -3326,7 +3325,7 @@ static void station_ap_directed_roam(struct station *station,
 	}
 
 	blacklist_add_bss(station->connected_bss->addr,
-				BLACKLIST_REASON_ROAM_REQUESTED);
+				BLACKLIST_REASON_AP_BUSY);
 	station_debug_event(station, "ap-roam-blacklist-added");
 
 	/*
-- 
2.34.1

