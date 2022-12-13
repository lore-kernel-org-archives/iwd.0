Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC77C23A7
	for <iwd@lists.linux.dev>; Tue, 13 Dec 2022 20:36:34 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso4884763pjt.0
        for <iwd@lists.linux.dev>; Tue, 13 Dec 2022 12:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+x8Pze7qqhT2t69iknSN63dntsXi7vMZnGb9bsmMiYk=;
        b=Vy+tCudZNAr4GXGw+6wkKunGcsurPhSsn9PXP3+eBSaTl4Xj1+HlaY/duAb1UbzKG9
         pGFvAezJmraW6mLX3rwP5kvYavnpNUS2+ApmKoUpkm2uAKrrvisKoodCadUPTjRDFdzA
         Cf+0p86u/sEwth+3dPLeBHIrhxle+EcKKoekq+lCd3Yp9GC+4wqEfPZ+LDZLHPCViTmP
         oOZ5xaB69KKtruxZq2mmIIqzjtqGhkqKVpLJ+QzUXP4a2IA8lmOunEmtklpQT8Um0eI4
         ik3aHqvNJey3hXuFL9vBnD+afKgbzmteqFuFtrkEPmWWwXnHQ2a0sdP6Xjp14daVwEGq
         tT+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+x8Pze7qqhT2t69iknSN63dntsXi7vMZnGb9bsmMiYk=;
        b=ONCRQ0UwUZSbPveT9DONH+evU4SmG455Lb/kmmJkkmLDemOY/y2bVLl4COkmT531Ap
         8Q3JkcIC2+SmXthj/yIkW2cgpohu3osMtpD0QxjWdWhI/7RZW63P96ORdnrqzNGEPkdd
         G6WBHddDYkzDXzWUXZ+D+PRB+0qeEj0y7pnwqcp88TOQmXna+MZ0dcEgS6xOjKfODq6V
         7qcdpw+Pw1yv1KwJ+JlD4AZtEgzjpOaeoojpW/b/h7KP3AefjVWrVdtQMzrrjG3PBcDa
         Bbmxc1ofsClOub98FizxG31mJD0CmuQ2vhGmr8qFd6P4YvH5ZH/NYKPXIZqGBHYypYMP
         XWfA==
X-Gm-Message-State: ANoB5pnQoGhD87ER8tzuyZUONB65NGjr/yniV3bwc4LdGgXFih3cP6mP
	nm81mXz12PxfTEwdNEMZU0N+fanGm8k=
X-Google-Smtp-Source: AA0mqf4+4siTZ1gWKoyFx1oOczYNhfH33z5vB2RIWvaROBStve0UmEQd4D7DjOQyqLqFOou2vDUk3w==
X-Received: by 2002:a17:903:258c:b0:189:6a5a:7289 with SMTP id jb12-20020a170903258c00b001896a5a7289mr26403306plb.52.1670963793983;
        Tue, 13 Dec 2022 12:36:33 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709028d9700b00189f69c1aa0sm272113plo.270.2022.12.13.12.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 12:36:33 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/7] station: use wiphy_check_{frequency,band}
Date: Tue, 13 Dec 2022 12:36:22 -0800
Message-Id: <20221213203624.1423277-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221213203624.1423277-1-prestwoj@gmail.com>
References: <20221213203624.1423277-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove uses of supported/disabled scan_freq_set's and replace
with the equivalent calls to wiphy_check_frequency/band.
---
 src/station.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/src/station.c b/src/station.c
index a467b4e9..95a6d830 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1407,8 +1407,6 @@ static int station_quick_scan_trigger(struct station *station)
 {
 	_auto_(scan_freq_set_free) struct scan_freq_set *known_freq_set = NULL;
 	bool known_6ghz;
-	const struct scan_freq_set *disabled = wiphy_get_disabled_freqs(
-								station->wiphy);
 
 	if (wiphy_regdom_is_updating(station->wiphy)) {
 		l_debug("regdom is updating, delaying quick scan");
@@ -1430,9 +1428,10 @@ static int station_quick_scan_trigger(struct station *station)
 	 * this since its so limited, so return an error which will fall back to
 	 * full autoconnect.
 	 */
-	if ((scan_freq_set_get_bands(disabled) & BAND_FREQ_6_GHZ) &&
-				wiphy_country_is_unknown(station->wiphy) &&
-				known_6ghz)
+	if (wiphy_check_band(station->wiphy, BAND_FREQ_6_GHZ,
+			BAND_FREQ_ATTR_SUPPORTED | BAND_FREQ_ATTR_DISABLED) &&
+			wiphy_country_is_unknown(station->wiphy) &&
+			known_6ghz)
 		return -ENOTSUP;
 
 	if (!wiphy_constrain_freq_set(station->wiphy, known_freq_set)) {
@@ -1812,10 +1811,6 @@ static void parse_neighbor_report(struct station *station,
 	struct scan_freq_set *freq_set_md, *freq_set_no_md;
 	uint32_t current_freq = 0;
 	struct handshake_state *hs = netdev_get_handshake(station->netdev);
-	const struct scan_freq_set *supported =
-				wiphy_get_supported_freqs(station->wiphy);
-	const struct scan_freq_set *disabled =
-				wiphy_get_disabled_freqs(station->wiphy);
 
 	freq_set_md = scan_freq_set_new();
 	freq_set_no_md = scan_freq_set_new();
@@ -1853,8 +1848,10 @@ static void parse_neighbor_report(struct station *station,
 			continue;
 
 		/* Skip if frequency is not supported or disabled */
-		if (!scan_freq_set_contains(supported, freq) ||
-				scan_freq_set_contains(disabled, freq))
+		if (!wiphy_check_frequency(station->wiphy, freq,
+						BAND_FREQ_ATTR_SUPPORTED) ||
+				wiphy_check_frequency(station->wiphy, freq,
+						BAND_FREQ_ATTR_DISABLED))
 			continue;
 
 		if (!memcmp(info.addr,
-- 
2.34.3

