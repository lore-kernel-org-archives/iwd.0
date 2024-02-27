Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4AF3C099
	for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058867; cv=none; b=Lg/KJbTTH4L/GLbNmylW5PUwXxCl9D4VKvWSelwnaRcEtccdqJu3LV6xW/Nx95yxADFMikEqVu96QtCUG6KgEhM+/flhmnHzj0j33k9t8UJqd9qwwmltA0QwPupiH+ys+k+XBvnOAVwt6adZO8zsQYufS5n/cPlWlbXTyiPy9mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058867; c=relaxed/simple;
	bh=AaVfMNKyR+s1giFbgO5pAWXl7LBq/1L5RzICdGECOoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S6+AP2Ad7fR7CbyQPrmvg8SID3PH0oN6n3SZnG60ZjsXG30pWKHRJNUX67qt+SJQQ0IH8XjLYqTPldyKkUUN4WescKx8Yz4rcezTCI5gifEIAPl/uagddnhYaNRyIlHrpoZlUGHT4oNj5xOfqD9cWDkcZKLITTDWdFwo7PGoJCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEVJuxXi; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEVJuxXi"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42a029c8e62so38180241cf.1
        for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 10:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709058865; x=1709663665; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SjwUwRTCIfwybhBNg6EVCAHTsl8oY/SqeIVyBvpxtc=;
        b=jEVJuxXixRrgkX8P8GmHeNW4VNyQdI2S087zSePSm5lEnIJMqDqOKIcIvtwdPh39Fq
         feevULx0Vbcih9wF7/anCMF1ZTRDgbed+mI94qcgtWvsDbIU7DgoltwvL1W1g00oOmV/
         DenXuaUqWrE8ZPOZ7fZPmEZzO6/+Z1oCpeFDZ3QvTzvM0vsQZmh56r/XiNMl0yjzsX7+
         4wgdDYqDBH/T/pTl5e3YqZmjr7V97txa9u2ns7xkybVdgA34ZBa+UOLBR3An9Lo+UFx/
         A9naNP6jvxYbYD61VMJ+/jjT1zksW823e4R41xS2gPf0tgOKNnMzN+GiJVzd9KUx5dkn
         8fYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709058865; x=1709663665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SjwUwRTCIfwybhBNg6EVCAHTsl8oY/SqeIVyBvpxtc=;
        b=LiG9T9LnRlTeddsg9769li8DwqMvNe77v3/lMlyOF91PQm32DC/jzEdp+iwizZEBa3
         BZ0abz1E/tAR5smDRB8lm74gd/800d0n1MxdAMk7layA28Z1mhTr0l1iWgyQXo7GrCnL
         RvjdKdpyX6vbiQFEcz0KPrkfpHD8l/r68F8SuD0e5LPdxdsfdZTcFf/rnxA/sNo01ygL
         l3EluRzHKIlJfJJLwMzZyLL1Wm9pVyCdlwEspwWiFnoY3fL+nATLDQhZWxh18a+/QFTc
         nQQHpuEIBVBfqnvSLcHC3lHPsboIZ9/PDTxctkGgfe17v+yKjsbllZsCP8WqkgRiEE3M
         riSQ==
X-Gm-Message-State: AOJu0YzuaGaGNgAohjWcXnu65vHaRetNfK+CuPqhqTVL2UAmhw2dIPfy
	sNViCRH1jKMIn9GxgrtOOjyz8vaoIVmxB2mQ7jXXC9oHIaHSsUkjxnc2+Bjp
X-Google-Smtp-Source: AGHT+IGVc2datESiwDsDtHHIqBjdejxcYgtlbpg4aOwoAGcBaGAuR/GAP39FQEzTZD+REm0yT0r38w==
X-Received: by 2002:a05:622a:216:b0:42e:7fd7:c68b with SMTP id b22-20020a05622a021600b0042e7fd7c68bmr8482965qtx.44.1709058864621;
        Tue, 27 Feb 2024 10:34:24 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id jy2-20020a05622a818200b0042e3468a98csm3819617qtb.4.2024.02.27.10.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:34:24 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 03/11] network: retain default ECC group for OWE after setting
Date: Tue, 27 Feb 2024 10:33:57 -0800
Message-Id: <20240227183405.257206-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227183405.257206-1-prestwoj@gmail.com>
References: <20240227183405.257206-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is special handling for buggy OWE APs which set a network flag
to use the default OWE group. Utilize the more persistent setting
within known-networks as well as the network object (in case there
is no profile).

This also renames the get/set APIs to be generic to ECC groups rather
than only OWE.
---
 src/network.c | 38 +++++++++++++++++++++++++++++++-------
 src/network.h |  4 ++--
 src/station.c |  4 ++--
 3 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/src/network.c b/src/network.c
index 287e2be0..a0a89e63 100644
--- a/src/network.c
+++ b/src/network.c
@@ -89,7 +89,7 @@ struct network {
 	bool provisioning_hidden:1;
 	uint8_t transition_disable; /* Temporary cache until info is set */
 	bool have_transition_disable:1;
-	bool force_default_owe_group:1;
+	bool force_default_ecc_group:1;
 	int rank;
 	/* Holds DBus Connect() message if it comes in before ANQP finishes */
 	struct l_dbus_message *connect_after_anqp;
@@ -271,8 +271,12 @@ struct network *network_create(struct station *station, const char *ssid,
 	network->security = security;
 
 	network->info = known_networks_find(ssid, security);
-	if (network->info)
+	if (network->info) {
 		network->info->seen_count++;
+		if (network->info->config.ecc_group ==
+						KNOWN_NETWORK_ECC_GROUP_DEFAULT)
+			network->force_default_ecc_group = true;
+	}
 
 	network->bss_list = l_queue_new();
 	network->blacklist = l_queue_new();
@@ -553,7 +557,7 @@ int network_handshake_setup(struct network *network, struct scan_bss *bss,
 	}
 
 	if (hs->akm_suite == IE_RSN_AKM_SUITE_OWE)
-		hs->force_default_owe_group = network->force_default_owe_group;
+		hs->force_default_owe_group = network->force_default_ecc_group;
 
 	/*
 	 * The randomization options in the provisioning file are dependent on
@@ -818,14 +822,34 @@ void network_set_info(struct network *network, struct network_info *info)
 					IWD_NETWORK_INTERFACE, "KnownNetwork");
 }
 
-void network_set_force_default_owe_group(struct network *network)
+void network_set_force_default_ecc_group(struct network *network)
 {
-	network->force_default_owe_group = true;
+	/* No network info, likely a failed OWE connection */
+	if (!network->info) {
+		network->force_default_ecc_group = true;
+		return;
+	}
+
+	/* Profile explicitly wants to try the most secure group */
+	if (network->info->config.ecc_group ==
+					KNOWN_NETWORK_ECC_GROUP_MOST_SECURE)
+		return;
+
+	l_debug("Forcing default group for %s", network->ssid);
+
+	network->force_default_ecc_group = true;
+	network->info->config.ecc_group = KNOWN_NETWORK_ECC_GROUP_DEFAULT;
 }
 
-bool network_get_force_default_owe_group(struct network *network)
+bool network_get_force_default_ecc_group(struct network *network)
 {
-	return network->force_default_owe_group;
+	if (!network->info)
+		return network->force_default_ecc_group;
+
+	if (network->info->config.ecc_group == KNOWN_NETWORK_ECC_GROUP_DEFAULT)
+		return true;
+
+	return false;
 }
 
 int network_can_connect_bss(struct network *network, const struct scan_bss *bss)
diff --git a/src/network.h b/src/network.h
index ea619f3f..17dfcca8 100644
--- a/src/network.h
+++ b/src/network.h
@@ -58,8 +58,8 @@ void network_sync_settings(struct network *network);
 
 const struct network_info *network_get_info(const struct network *network);
 void network_set_info(struct network *network, struct network_info *info);
-void network_set_force_default_owe_group(struct network *network);
-bool network_get_force_default_owe_group(struct network *network);
+void network_set_force_default_ecc_group(struct network *network);
+bool network_get_force_default_ecc_group(struct network *network);
 
 bool network_update_known_frequencies(struct network *network);
 
diff --git a/src/station.c b/src/station.c
index 8817637b..3712d5bb 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3152,7 +3152,7 @@ static bool station_retry_owe_default_group(struct station *station)
 		return false;
 
 	/* If we already forced group 19, allow the BSS to be blacklisted */
-	if (network_get_force_default_owe_group(station->connected_network))
+	if (network_get_force_default_ecc_group(station->connected_network))
 		return false;
 
 	l_warn("Failed to connect to OWE BSS "MAC" possibly because the AP is "
@@ -3160,7 +3160,7 @@ static bool station_retry_owe_default_group(struct station *station)
 		"Retrying with group 19 as a workaround",
 		MAC_STR(station->connected_bss->addr));
 
-	network_set_force_default_owe_group(station->connected_network);
+	network_set_force_default_ecc_group(station->connected_network);
 
 	return true;
 }
-- 
2.34.1

