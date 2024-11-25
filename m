Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2A718C332
	for <iwd@lists.linux.dev>; Mon, 25 Nov 2024 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547193; cv=none; b=q+Kiwi109RuZu5A0K0Az0/YOYR/NBtTZ3V+qlEaAINByEb3tpSaY2nnpTCHxBIKUFo3Dc9tSCHqqSmuEj+KfUy7Qg8T0II0DR3VbOymwFfesS6ERV/n2JRmTpCSEryfuPcDqTnO9VwLqkWDyJVcRS+brW+oRuTtEgnENHdSTiBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547193; c=relaxed/simple;
	bh=g45tWZrgo7Ani2zYHQ3A4cdDNL9TH6mK0xFlKEsM3cg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UKKXr4tKeat0WMYiQQRr8UCoyHzVVg5nkzVUFdO29cE4Z6Bs23sA5d5kzyG0PmmWI5bpvwtxj4vQt23QfsZ+cVZ0eqas5SpBL8T0I/z76yEJEo5bEiBT67RN4vL1O+GLhQDw3FkU2q9RiAwyNPODzb+H4ibfUcTWLPk1XT26PnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jG1CIDih; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jG1CIDih"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6662bc408so113229385a.1
        for <iwd@lists.linux.dev>; Mon, 25 Nov 2024 07:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732547190; x=1733151990; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUKFo8EhxUdBRzV2Kf2eLXmJ1TYSWkZ65HgvlGErKAA=;
        b=jG1CIDihpUOf4fRuYfcEXFqMFpETCh3TKinxoQ+uM9y8YHNL3LcsOwMYDydhKAYt0U
         AYSOpc6+CctLHlqK3y3LkWoHN65Cy8tPazjyXBEIGhzTRhnPLvRW7tys3kajpZemnKNA
         hSsZr+vKVCjUOqkjzKiEMLeYgtntKaz0F+1dIgsJ5JjqgFy+hGE/cuSmLC4tALGTDLen
         Ub5dUn9FK197wS339dh81TN3lrXXJozhISEQDascBVjV91SkDX5a+Ta4HrQOA57medpN
         Rbe5KAtVL2hOiYltNMD+ta8z4b0LlxFJAV+W6nPFc9Ch/Mg5HxatrAn1Ik8P9ZD0wqhY
         CWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732547190; x=1733151990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUKFo8EhxUdBRzV2Kf2eLXmJ1TYSWkZ65HgvlGErKAA=;
        b=ectF+2PsvURym8uyYRBi4xZTauMLxmxb0bL9D2Ltb1qEj61TndaCQfk4c1uBj1iBlC
         H/16r4TwOzD95xNTeoa0KzxGilrf2EMkbCNxSWkWzHLIyp1WhtyyF/HAbzKhgzeYlJuN
         5R/ZCKtIxbtRy4YK1/66EHxFhx85G1XIQXSLpssNzH7Gz9aagkPY9tp5sXfOp8N7P3Ez
         KKgTAc+GILKSlJwqWIaVGx/4sO9kX8vew0Im55S0PnenR7ilKWcxjTVsAkc/EqlMnifm
         d/HBgzWZ7x+BTVbhFgheUoTa/sxMFZyIL24Tj7cIztS70V9Jzks8vKI3n/V54sSGDtR7
         W9Jg==
X-Gm-Message-State: AOJu0YzeZcRrprdtacsZtz3XtqbzL8OCLsZAlmDXGaa0Dx/+/Nl3frC3
	CdCedqbrxCPnAeU40A4865d4GRz/C30hjIFi3iZZQffjwDgV7smud3py7g==
X-Gm-Gg: ASbGnctnLM6jtFXY8+yxUiX+6WzOETq2KWP5OUQvbFDyhU6rbZdMZjz62GiMwZr8hyU
	Fxqt7X3V97OyvNGCYS+g/3zK+Oz5V0m46kii+iDxXkRqf2A9N7M57GmRRWcbbRJksgg8jFze41z
	OH4dRTxjtVVwFQ2tTA3qMrDxwMpikQP6j7dpOhkkgL7JFpoZQ8u0o3aYat3+GhGkMjgWulpdUL7
	1YHFC2p+XBSTdbF2I7O5Tg22Xd1miFiZJALchch13XcQto1UfRF3lpRGM+6
X-Google-Smtp-Source: AGHT+IFekzE0qNsgmb+XoMQn7ySabrIaatroabMfRwxVEBP6GDGeFT3hTCwyc5xOt+89ciXvPfkrpQ==
X-Received: by 2002:ad4:5bcf:0:b0:6d4:2737:6c11 with SMTP id 6a1803df08f44-6d4513459d6mr181888016d6.39.1732547189862;
        Mon, 25 Nov 2024 07:06:29 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451ab5cc3sm43569136d6.66.2024.11.25.07.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 07:06:29 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] dpp: use wiphy_supports_multicast_rx
Date: Mon, 25 Nov 2024 07:06:22 -0800
Message-Id: <20241125150623.1014890-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125150623.1014890-1-prestwoj@gmail.com>
References: <20241125150623.1014890-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ath10k driver has shown some performance issues, specifically
packet loss, when frame watches are registered with the multicast
RX flag set. This is relevant for DPP which registers for these
when DPP starts (if the driver supports it). This has only been
observed when there are large groups of clients all using the same
wifi channel so its unlikely to be much of an issue for those using
IWD/ath10k and DPP unless you run large deployments of clients.

But for large deployments with IWD/ath10k we need a way to disable
the multicast RX registrations. Now, with the addition of
wiphy_supports_multicast_rx we can both check that the driver
supports this as well as if its been disabled by the driver quirk.
---
 src/dpp.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 95c11f00..ac56e55d 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -3739,9 +3739,8 @@ static void dpp_create(struct netdev *netdev)
 	dpp->key_len = l_ecc_curve_get_scalar_bytes(dpp->curve);
 	dpp->nonce_len = dpp_nonce_len_from_key_len(dpp->key_len);
 	dpp->max_roc = wiphy_get_max_roc_duration(wiphy_find_by_wdev(wdev_id));
-	dpp->mcast_support = wiphy_has_ext_feature(
-				wiphy_find_by_wdev(dpp->wdev_id),
-				NL80211_EXT_FEATURE_MULTICAST_REGISTRATIONS);
+	dpp->mcast_support = wiphy_supports_multicast_rx(
+				wiphy_find_by_wdev(dpp->wdev_id));
 
 	l_ecdh_generate_key_pair(dpp->curve, &dpp->boot_private,
 					&dpp->boot_public);
@@ -4106,7 +4105,7 @@ static struct l_dbus_message *dpp_start_configurator_common(
 	} else
 		dpp->current_freq = bss->frequency;
 
-	dpp_add_frame_watches(dpp, responder);
+	dpp_add_frame_watches(dpp, responder && dpp->mcast_support);
 
 	dpp->uri = dpp_generate_uri(dpp->own_asn1, dpp->own_asn1_len, 2,
 					netdev_get_address(dpp->netdev),
@@ -4535,7 +4534,7 @@ static struct l_dbus_message *dpp_start_pkex_configurator(struct dpp_sm *dpp,
 	dpp->config = dpp_configuration_new(network_get_settings(network),
 						network_get_ssid(network),
 						hs->akm_suite);
-	dpp_add_frame_watches(dpp, true);
+	dpp_add_frame_watches(dpp, dpp->mcast_support);
 
 	dpp_reset_protocol_timer(dpp, DPP_PKEX_PROTO_TIMEOUT);
 	dpp_property_changed_notify(dpp);
-- 
2.34.1

