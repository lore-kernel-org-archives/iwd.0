Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C205938C412
	for <iwd@lists.linux.dev>; Thu,  2 Jul 2026 19:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783021374; cv=none; b=a22A3y8A8rtoYMdFl6bqODyc/ABfU1AQoxU3Vd7Ny1eN0S5AT65QD1dtnuEn3dU9FzoExm3VNjVIqtGTWqRjTr8xYctqELD+2DOk9ZndJ4pq8GBbu7okT5bNFNnS/zwn1onnQHpRdtFzry/38xGLt8iFA533smFtpT3OfqOjZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783021374; c=relaxed/simple;
	bh=W5drRniVC8Pr5Y+DCNu0T8gHo2EeEbVP2PyFuyGW6i8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mlytbR8IshdlNDEWKDK3rbCqpPRvI/Nlv78qN+U/zYw2qhV+u9j0kBAd7sflbep4JJ0hqB/6W6fylykrbgxRV9gGI91PKgg9+stSScpxzCPILMWKMyrG/pc4dlP1bDn+JHB4I62vMUjbrXCuqRHuVxav6HHHS2uqHEI6kE0uQIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=K/04Z+T5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="K/04Z+T5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783021370;
	bh=W5drRniVC8Pr5Y+DCNu0T8gHo2EeEbVP2PyFuyGW6i8=;
	h=From:Date:Subject:To:Cc:From;
	b=K/04Z+T5Qv+lZQdcZu4JzlGoSdOteR3RTmn9r3H4Yx06UaGqbdTB5A0MgyyuPoISt
	 Nc0XHTqPIcPMsKCdXvQ9//aX9iJUqhtHG2Up5pDFYQNs2TSaDpxduaTpPDwv+bVFIS
	 FwLFn5YmlKP/Oe4OxM5s281kpdnlAQDjHw6faUfKIAAYcNNpL6dVjZkVZMAaRFTpcp
	 MHsHhny2TFUrWAJrPlkkZp+2PG4ntubh4/VqxsWOR4f9UTsEDzBXEuIg1RPQWu5HS+
	 vCWZCYHxSJkQceyQy/NOjrnVyY8kW4HC3fGPEtl33QtDRVFz4pWs6iJAWs88F/tI9C
	 8iwsJ924DMs7A==
Received: from [192.168.1.156] (unknown [100.64.1.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mattl)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AAF7A17E0246;
	Thu,  2 Jul 2026 21:42:50 +0200 (CEST)
From: Matthew Leach <matthew.leach@collabora.com>
Date: Thu, 02 Jul 2026 20:42:42 +0100
Subject: [PATCH] knownnetwroks: add DisableRoamingScan option
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-knownnetworks-disable-roaming-option-v1-1-6b02b89d95f2@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNSw7CMAwA0atUXmMpBJEiroJY5GOKKThVHChS1
 bsTYDmbNwsoFSaFY7dAoRcrZ2mx3XQQr14GQk6twRrrTG8sjpJnEapzLqNiYvXhTliyf7AMmKf
 aAHTxsIu29ynsHTRqKnTh929zOv9bn+FGsX5tWNcPI673cIgAAAA=
X-Change-ID: 20260702-knownnetworks-disable-roaming-option-6c83c27adb56
To: iwd@lists.linux.dev
Cc: matthew.leach@collabora.com
X-Mailer: b4 0.15.2

Add a new knownnetworks option: DisableRoamingScan. When set, and the
STA is connected to that network, roaming scans are disabled.

---
 src/iwd.network.rst | 4 ++++
 src/knownnetworks.c | 5 +++++
 src/knownnetworks.h | 2 ++
 src/station.c       | 8 ++++++++
 4 files changed, 19 insertions(+)

diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index 892c6eb8..7c50e76f 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -181,6 +181,10 @@ The group ``[Settings]`` contains general settings.
        (WPA3 and OWE) if set true. If unset IWD will learn the capabilities of
        the network based on its initial association and retain that setting for
        the duration of its process lifetime.
+   * - DisableRoamingScan
+     - Values: true, **false**
+
+       Whether roaming scans are inhibited while connected to this network.
 
 Network Authentication Settings
 -------------------------------
diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index 886f8145..c6d141a0 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -135,6 +135,11 @@ void __network_config_parse(const struct l_settings *settings,
 					NET_USE_DEFAULT_ECC_GROUP);
 	} else
 		config->ecc_group = KNOWN_NETWORK_ECC_GROUP_AUTO;
+
+	if (!l_settings_get_bool(settings, NET_DISABLE_ROAMING_SCAN, &b))
+		b = false;
+
+	config->disable_roaming_scan = b;
 }
 
 void __network_info_init(struct network_info *info,
diff --git a/src/knownnetworks.h b/src/knownnetworks.h
index a117ded5..c2fce4c2 100644
--- a/src/knownnetworks.h
+++ b/src/knownnetworks.h
@@ -30,6 +30,7 @@
 #define NET_TRANSITION_DISABLE SETTINGS, "TransitionDisable"
 #define NET_TRANSITION_DISABLE_MODES SETTINGS, "DisabledTransitionModes"
 #define NET_USE_DEFAULT_ECC_GROUP SETTINGS, "UseDefaultEccGroup"
+#define NET_DISABLE_ROAMING_SCAN SETTINGS, "DisableRoamingScan"
 
 enum security;
 struct scan_freq_set;
@@ -78,6 +79,7 @@ struct network_config {
 	bool is_autoconnectable:1;
 	bool override_addr:1;
 	bool always_random_addr:1;
+	bool disable_roaming_scan:1;
 	uint8_t sta_addr[6];
 	bool have_transition_disable : 1;
 	uint8_t transition_disable;
diff --git a/src/station.c b/src/station.c
index 8fcf8c70..b94236fe 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3198,6 +3198,14 @@ static bool station_cannot_roam(struct station *station)
 	if (wiphy_supports_firmware_roam(station->wiphy))
 		return true;
 
+	if (station->connected_network) {
+		const struct network_info *info =
+		    network_get_info(station->connected_network);
+
+		if (info && info->config.disable_roaming_scan)
+			return true;
+	}
+
 	if (!l_settings_get_bool(config, "Scan", "DisableRoamingScan",
 								&disabled))
 		disabled = false;

---
base-commit: d003d0e593323b3de427f01284ede81ba61e9dcc
change-id: 20260702-knownnetworks-disable-roaming-option-6c83c27adb56

Best regards,
--  
Matt

