Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739C537D06
	for <iwd@lists.linux.dev>; Tue, 19 Dec 2023 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iB3pvJ//"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3ba084395d9so3372304b6e.0
        for <iwd@lists.linux.dev>; Tue, 19 Dec 2023 10:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703009309; x=1703614109; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aiApK1YSInACtcDzvMZY/WjaeNQq3mzQCB0iF5xGVkE=;
        b=iB3pvJ//Z0J9GneXJ8nuhwvhALUEDMiui2dT5U6MqZnc692oRx6ODeGpLPvelkAWY+
         DlshAeZB0ipsLBv5krntM78oIutqpzaPBJSCDyKmjg9yeET1ydxhXm2sGUY3z/U5VmyX
         rpUryElUONcFXtralKKW6BFTxogWwOcPuuZOow6te667A4slIQ0W+Bfi3hd8dYwx76kY
         dcSoXEbXsstMEwXrF0OpfS30rKwU0pZZKlUUZoZ5b1VsZJv5eOu/flhZrmY+At2IgYjN
         wgSWZrIX4zfVPGyjs15sQuQVeTr3AE+0NoSSevfpNWmae0iuHzLP3CcFX8AehdYaYmx2
         f2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703009309; x=1703614109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aiApK1YSInACtcDzvMZY/WjaeNQq3mzQCB0iF5xGVkE=;
        b=Mg62vT4kH/I5sutNwthOGTOZdWfKvif4pVXe05cURzM/5MzuCtVKhpovEVP3mkmAvE
         0U3afSv2D6VWEsHhz0bIFTpRkWumLrk//pBZOyBhWST1qicDa/oehHupzQbNTh+nhbVs
         IAsSKoYEOmQVsCHuiJ7pm0CkyHna9N1kM6ScPoZ0UnwgW8SlmI5svs777FObEEQPR8sZ
         IemwVDJLI9Hxb4GiCJrI6YnOyU0Mhnc18WzGFrkM3mhyEGlob2d6N95+mOQ7m6KW9y+8
         a0iQEdTijTTR4mQTc+kGzEBcP1n1ovFkRj9rG+YqiwhVAJiZfmY/YO1LT16jp//rxloC
         EExw==
X-Gm-Message-State: AOJu0Yx3OHe6kPDabW7MiQ+Oyxd/lQ6sHmo7p/JoK57xkpOiWPJCpPWs
	X743Fv9mfdo8tJIzaxstr1qjdfRFKYI=
X-Google-Smtp-Source: AGHT+IECJfnN22zvp2TvRGqNoVavm5EYFt5hi5CzihDXGTW2rIPCBMQDGxMLC8h86solERsYizcb5Q==
X-Received: by 2002:a05:6808:218a:b0:3b9:e64c:dfc9 with SMTP id be10-20020a056808218a00b003b9e64cdfc9mr22984962oib.22.1703009309212;
        Tue, 19 Dec 2023 10:08:29 -0800 (PST)
Received: from LOCLAP699.barrett-olive-branch.locus ([50.222.209.222])
        by smtp.gmail.com with ESMTPSA id z25-20020a056808049900b003ba322fa9a8sm2095130oid.43.2023.12.19.10.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 10:08:29 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/4] knownnetworks: Add UPDATED event
Date: Tue, 19 Dec 2023 10:08:23 -0800
Message-Id: <20231219180826.201540-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a known network is modified on disk known networks does not have
any way of notifying other modules. This will be needed to support a
corner case in DPP if a profile exists but is overwritten after DPP
configuration. Add this event to known networks and handle it in
network.c (though nothing needs to be done in that case).
---
 src/knownnetworks.c | 4 ++++
 src/knownnetworks.h | 1 +
 src/network.c       | 2 ++
 3 files changed, 7 insertions(+)

v3:
 * Removed bulk of this change, just emit UPDATED to let DPP know the
   profile was seen by knownnetworks

diff --git a/src/knownnetworks.c b/src/knownnetworks.c
index d4d50a6f..04ce74ec 100644
--- a/src/knownnetworks.c
+++ b/src/knownnetworks.c
@@ -468,6 +468,10 @@ void known_network_update(struct network_info *network,
 	known_network_set_autoconnect(network, new->is_autoconnectable);
 
 	memcpy(&network->config, new, sizeof(struct network_config));
+
+	WATCHLIST_NOTIFY(&known_network_watches,
+				known_networks_watch_func_t,
+				KNOWN_NETWORKS_EVENT_UPDATED, network);
 }
 
 bool known_networks_foreach(known_networks_foreach_func_t function,
diff --git a/src/knownnetworks.h b/src/knownnetworks.h
index 0a5c9e25..e8ffac0b 100644
--- a/src/knownnetworks.h
+++ b/src/knownnetworks.h
@@ -35,6 +35,7 @@ struct network_info;
 enum known_networks_event {
 	KNOWN_NETWORKS_EVENT_ADDED,
 	KNOWN_NETWORKS_EVENT_REMOVED,
+	KNOWN_NETWORKS_EVENT_UPDATED,
 };
 
 struct network_info_ops {
diff --git a/src/network.c b/src/network.c
index 3918ae08..4723334e 100644
--- a/src/network.c
+++ b/src/network.c
@@ -2033,6 +2033,8 @@ static void known_networks_changed(enum known_networks_event event,
 	case KNOWN_NETWORKS_EVENT_REMOVED:
 		station_foreach(emit_known_network_removed, (void *) info);
 		break;
+	case KNOWN_NETWORKS_EVENT_UPDATED:
+		break;
 	}
 }
 
-- 
2.34.1

