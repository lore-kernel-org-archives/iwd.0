Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE801DF99E
	for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288577; cv=none; b=t9JbQiGOfKDnRuPr3YkM883He23wX8gE+BnguUm01arsa1bzNFRk3zZjg0O9n+eoNi2kuqIhboosXeAxqhNcagNRL5aPhciredaSL0cD/Hq+15WLQy34AhDOAclKw72lPrwpMNkeQpXE3SRiQ8LelM413s8gFXzxN5GYa4iz3Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288577; c=relaxed/simple;
	bh=OWTe4bcMifh1PpNVFFL5ewEB+HErvlf7qJPYQvhLI1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vsc8Bld85DjdCoad+5yaR7OBiHwZPKiPlj6pDZk/rmUeswjo1pVj9J8WMDaYAwVMDBvRHk1ZwaLjqhFsWdXsvZ++ccsb6N1bkQ0CzQDkhoJ6DgjYCm3XbOQmoZTlf3bp92beK5wnXYcz3pnQh0aN1d8omYVH09NnjhAhAxce9yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHQBAL+Q; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHQBAL+Q"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b154f71885so144395985a.0
        for <iwd@lists.linux.dev>; Fri, 22 Nov 2024 07:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732288574; x=1732893374; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsa58RXp9lDeRDF1l2cBmiNv/WDJwW0rSNFj1Jebv68=;
        b=JHQBAL+QrDfiso/uAVGSkl9v4f6gxF7WwyVgOYX7NNc5/7eWxzguIoUKevxtCWMzMJ
         +eC4tOBZ6fk62nOI/tp/kgzw2ukhILTTfW8tLlF8MlTbgKpPNcR1+v2yclr/ZGlLiF/2
         V++XjCX1BONOXqYwvBUKHXohaS3TlRHOhgP6ERfZ3e24iV5QsM3XE0y1Ekn5/bzNhWNY
         bymxIOnNBuwPbtzbclUlX2KJMnBU71520ZPp31CPW2p6WhcfNn7l5+DkdnpgxxLHBC4Y
         cMOtOQB9NeMNgTApd7WcURIZXfxN6+mX0iPraaFVxa5nLzEbqDLrKOJlSrANY6Vtr+fD
         NTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288574; x=1732893374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsa58RXp9lDeRDF1l2cBmiNv/WDJwW0rSNFj1Jebv68=;
        b=sFGS/9tBhMHsvlTQlAdsNVO08ZELKD9q0+of+csxWI0yl0S6CEmS2MbUM6Ae50GQ0z
         uy6Ox9EkBes5Xc7F3KLBlgE4En11TF4/iyZ2gUj23g52vTyAS+Nt2I/R0bBtGOIOx/HS
         Lv8kX81V4t/VOOFYrucr2mM1HwbY+GjLVPmOk1I+l7MDY31eGrWeLuslnMzHPJ3Fj08c
         vJ0Ecf2WR490l9UcxAUhLjdonw1nLUiIyVYUC/Ku1iiLp+GqzwNmM0JKMfNFFKQldzCA
         XbW3o7sd2ir5o3dXIDJNcmTWG2SC/9vwyzcfLD3Rk1ShOGtxOk3Snbh3ODm6DsjFqst/
         1GxQ==
X-Gm-Message-State: AOJu0Yz760IJkTPv0tg/SZHmkVhdf9KNYBiCYxeleB24KtX+QibDurOy
	pRfuAUVI2Cv1Cw5nvAnWCIg2SrUIDPNUoQRGr/RfO7sQWsg19Ez4X/Mwuw==
X-Gm-Gg: ASbGncvq31HdiFi1JOo7sNA1DSGacG/2R2sbnsb5VpmYLtYM8ia4NbEijwHdI390CJ3
	gd53RQX5ZFoqv3GETpOisP3H/bjkODJT8ddjSiveInKALnU2UurypevQVJB34fmOBzx3VB2+aCR
	mgHb/lhqEHTnF8rBfSGSj1ZbYdRJH/bQemAy8Wb1miyGM6yVr0VKLcwQy741lOLlQOmOWBYthpv
	aKaf5xiQY6m9ry6P5F/xYJ020q30CFHhfXp70ZyZiSr5Er+sN9ThbpyCz7/
X-Google-Smtp-Source: AGHT+IGy4ViIbSXCdTsvshx/bRK/8/jQuXWcIJQF7nznwFDLV4WiNQM19sDSY/BtyKa+9f9SMwm6KQ==
X-Received: by 2002:a05:6214:19c6:b0:6d4:e46:b438 with SMTP id 6a1803df08f44-6d450eed1edmr51696686d6.23.1732288574199;
        Fri, 22 Nov 2024 07:16:14 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451a9a720sm10722706d6.50.2024.11.22.07.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 07:16:13 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 13/15] station: support PMKSA connections
Date: Fri, 22 Nov 2024 07:15:49 -0800
Message-Id: <20241122151551.286355-14-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241122151551.286355-1-prestwoj@gmail.com>
References: <20241122151551.286355-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The actual connection piece of this is very minimal, and only
requires station to check if there is a PMKSA cached, and if so
include the PMKID in the RSNE. Netdev then takes care of the rest.

The remainder of this patch is the error handling if a PMKSA
connection fails with INVALID_PMKID. In this case IWD should retry
the same BSS without PMKSA.

An option was also added to disable PMKSA if a user wants to do
that. In theory PMKSA is actually less secure compared to SAE so
it could be something a user wants to disable. Going forward though
it will be enabled by default as its a requirement from the WiFi
alliance for WPA3 certification.
---
 src/station.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 09193eed..5403c332 100644
--- a/src/station.c
+++ b/src/station.c
@@ -63,6 +63,7 @@
 #include "src/eap.h"
 #include "src/eap-tls-common.h"
 #include "src/storage.h"
+#include "src/pmksa.h"
 
 #define STATION_RECENT_NETWORK_LIMIT	5
 #define STATION_RECENT_FREQS_LIMIT	5
@@ -78,6 +79,7 @@ static bool supports_drop_gratuitous_arp;
 static bool supports_drop_unsolicited_na;
 static bool supports_ipv4_drop_unicast_in_l2_multicast;
 static bool supports_ipv6_drop_unicast_in_l2_multicast;
+static bool pmksa_disabled;
 static struct watchlist event_watches;
 static uint32_t known_networks_watch;
 static uint32_t allowed_bands;
@@ -1157,6 +1159,7 @@ static int station_build_handshake_rsn(struct handshake_state *hs,
 					struct network *network,
 					struct scan_bss *bss)
 {
+	struct netdev *netdev = netdev_find(hs->ifindex);
 	const struct l_settings *settings = iwd_get_config();
 	enum security security = network_get_security(network);
 	bool add_mde = false;
@@ -1167,6 +1170,7 @@ static int station_build_handshake_rsn(struct handshake_state *hs,
 	uint8_t *ap_ie;
 	bool disable_ocv;
 	enum band_freq band;
+	struct pmksa *pmksa;
 
 	memset(&info, 0, sizeof(info));
 
@@ -1300,6 +1304,17 @@ build_ie:
 			IE_CIPHER_IS_GCMP_CCMP(info.pairwise_ciphers))
 		info.extended_key_id = true;
 
+	if (IE_AKM_IS_SAE(info.akm_suites) && !pmksa_disabled) {
+		pmksa = pmksa_cache_get(netdev_get_address(netdev), bss->addr,
+					bss->ssid, bss->ssid_len,
+					info.akm_suites);
+		if (pmksa) {
+			handshake_state_set_pmksa(hs, pmksa);
+			info.num_pmkids = 1;
+			info.pmkids = hs->pmksa->pmkid;
+		}
+	}
+
 	/* RSN takes priority */
 	if (bss->rsne) {
 		ap_ie = bss->rsne;
@@ -3391,6 +3406,39 @@ try_next:
 	return station_try_next_bss(station);
 }
 
+static bool station_pmksa_fallback(struct station *station, uint16_t status)
+{
+	/*
+	 * IEEE 802.11-2020 12.6.10.3 Cached PMKSAs and RSNA key management
+	 *
+	 * "If the Authenticator does not have a PMKSA for the PMKIDs in the
+	 * (re)association request or the AKM does not match, its behavior
+	 * depends on how the PMKSA was established. If SAE authentication was
+	 * used to establish the PMKSA, then the AP shall reject (re)association
+	 * by sending a (Re)Association Response frame with status code
+	 * STATUS_INVALID_PMKID. Note that this allows the non-AP STA to fall
+	 * back to full SAE authentication to establish another PMKSA"
+	 */
+	if (status != MMPDU_STATUS_CODE_INVALID_PMKID)
+		return false;
+
+	if (L_WARN_ON(!station->hs))
+		return false;
+
+	if (!IE_AKM_IS_SAE(station->hs->akm_suite) || !station->hs->have_pmksa)
+		return false;
+
+	/*
+	 * Remove the PMKSA from the handshake and return true to re-try the
+	 * same BSS without PMKSA.
+	 */
+	handshake_state_remove_pmksa(station->hs);
+
+	station_debug_event(station, "pmksa-invalid-pmkid");
+
+	return true;
+}
+
 /* A bit more concise for trying to fit these into 80 characters */
 #define IS_TEMPORARY_STATUS(code) \
 	((code) == MMPDU_STATUS_CODE_DENIED_UNSUFFICIENT_BANDWIDTH || \
@@ -3414,7 +3462,7 @@ static bool station_retry_with_status(struct station *station,
 	if (IS_TEMPORARY_STATUS(status_code))
 		network_blacklist_add(station->connected_network,
 						station->connected_bss);
-	else
+	else if (!station_pmksa_fallback(station, status_code))
 		blacklist_add_bss(station->connected_bss->addr);
 
 	iwd_notice(IWD_NOTICE_CONNECT_FAILED, "status: %u", status_code);
@@ -5830,6 +5878,10 @@ static int station_init(void)
 				&anqp_disabled))
 		anqp_disabled = true;
 
+	if (!l_settings_get_bool(iwd_get_config(), "General", "DisablePMKSA",
+				&pmksa_disabled))
+		pmksa_disabled = false;
+
 	if (!netconfig_enabled())
 		l_info("station: Network configuration is disabled.");
 
-- 
2.34.1

