Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3892E3F1
	for <iwd@lists.linux.dev>; Fri,  5 Jan 2024 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEjt4s3x"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3bbbe583e04so996826b6e.3
        for <iwd@lists.linux.dev>; Fri, 05 Jan 2024 06:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704466076; x=1705070876; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ixw0WwMMTzXC+ikewb+Rj26bB6LoAIDO9OXuMVh3xo=;
        b=IEjt4s3x3xM7UKaletDJcJetbV0CAdDoxpZxpjhtJBj3M9ftiIMaTTofSabWPvCHLU
         7V/bOFPawmPdEv0rM/g6IPYPa3m4PA512O8ogX4K6n/7X14yBuhnrAfX0AzalTm4YCl6
         D26YPCj+Kh/pe2f1T+n+Ln3QTB6UQ5Uc64/Hev+ViQsyajrczF1vpXpmrKcjY7ULbTHT
         9cPmVBTguALIITNVrSlBivLpU3Tkxi33TCnIs9yfFWctlYBRPysofFVE6jQVibbi4U1M
         DXqKvIOzn8PZTFAIpFKYy5K8lkDrImR4WKUtMvSvVrTnyuHKuHPGD/kDy/+8p8b952IL
         Iieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704466076; x=1705070876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ixw0WwMMTzXC+ikewb+Rj26bB6LoAIDO9OXuMVh3xo=;
        b=P1VsA7Te0me8jXOG/RmhtOexHnhjJroTstdrez3vcdwZuH1iD7xVXBFEAA4s0Mum1N
         9h8U2yfs00tbR5P9QsyLvAiLGW56h8NU68oUrTXLlSgtKj4BXlXlFpsJ8Vf/nybH+9aB
         6sWaP/n4wIuy3YjhNIfmsSr5VD+bIelxInEcKGbNqCkLUbHyskw1ZurQAIhEaH2UbwLI
         HptVpIx/qQr7s5e9iZQRQEBLDWO/8/wa47pR92vtkbpqHjifJlXcxrPWDB7fnLFXIEW3
         9pEamQ1/WOMsZaKs7iPC/0luYNWK0Jgs9xA7iW+XwzaUTTnCnDOgQ7GW9T9whtDoJCNS
         P3QA==
X-Gm-Message-State: AOJu0YytvhCdTM4mmR2Vo2HbWWvqtBnFmrdNWl2YimWkBHyIlXwwqCep
	hYNOJzwUN/HFNtjaf0AVEcc3sKI00EY=
X-Google-Smtp-Source: AGHT+IEa3X3K2+rMt8dc9V1txQpSd/ZpcfMkdz+UwgcmE+Bny0naixSxJBQQ1hKQ7XIcRgKoEBZ8dA==
X-Received: by 2002:a05:6808:1415:b0:3bb:bd76:ae5f with SMTP id w21-20020a056808141500b003bbbd76ae5fmr2195551oiv.7.1704466074743;
        Fri, 05 Jan 2024 06:47:54 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id pz30-20020ad4551e000000b0067f8f04a2fcsm656843qvb.57.2024.01.05.06.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 06:47:54 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/3] station: add additional internal state, STATION_STATE_NETCONFIG
Date: Fri,  5 Jan 2024 06:47:48 -0800
Message-Id: <20240105144750.839705-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is still treated as "connecting" from a DBus perspective but
will allow for better handling internally for some roaming corner
cases.
---
 src/dpp.c     | 1 +
 src/station.c | 5 +++++
 src/station.h | 1 +
 src/wsc.c     | 1 +
 4 files changed, 8 insertions(+)

diff --git a/src/dpp.c b/src/dpp.c
index af6574fb..74b4c2bc 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -3761,6 +3761,7 @@ static void dpp_station_state_watch(enum station_state state, void *user_data)
 	case STATION_STATE_CONNECTING:
 	case STATION_STATE_CONNECTED:
 	case STATION_STATE_CONNECTING_AUTO:
+	case STATION_STATE_NETCONFIG:
 		if (L_WARN_ON(dpp->role == DPP_CAPABILITY_CONFIGURATOR))
 			dpp_reset(dpp);
 
diff --git a/src/station.c b/src/station.c
index ac53bf2a..68cac945 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1497,6 +1497,8 @@ static const char *station_state_to_string(enum station_state state)
 		return "ft-roaming";
 	case STATION_STATE_FW_ROAMING:
 		return "fw-roaming";
+	case STATION_STATE_NETCONFIG:
+		return "connecting (netconfig)";
 	}
 
 	return "invalid";
@@ -1635,6 +1637,7 @@ static void station_enter_state(struct station *station,
 		station_set_drop_unicast_l2_multicast(station, false);
 		break;
 	case STATION_STATE_DISCONNECTING:
+	case STATION_STATE_NETCONFIG:
 		break;
 	case STATION_STATE_ROAMING:
 	case STATION_STATE_FT_ROAMING:
@@ -3342,6 +3345,7 @@ static void station_disconnect_event(struct station *station, void *event_data)
 	case STATION_STATE_CONNECTED:
 	case STATION_STATE_FT_ROAMING:
 	case STATION_STATE_FW_ROAMING:
+	case STATION_STATE_NETCONFIG:
 		station_disassociated(station);
 		return;
 	default:
@@ -4272,6 +4276,7 @@ static bool station_property_get_state(struct l_dbus *dbus,
 		break;
 	case STATION_STATE_CONNECTING:
 	case STATION_STATE_CONNECTING_AUTO:
+	case STATION_STATE_NETCONFIG:
 		statestr = "connecting";
 		break;
 	case STATION_STATE_CONNECTED:
diff --git a/src/station.h b/src/station.h
index 0d502a08..a38327e4 100644
--- a/src/station.h
+++ b/src/station.h
@@ -45,6 +45,7 @@ enum station_state {
 	STATION_STATE_ROAMING,		/* Reassociation */
 	STATION_STATE_FT_ROAMING,	/* Fast transition */
 	STATION_STATE_FW_ROAMING,	/* Firmware roamed by itself */
+	STATION_STATE_NETCONFIG,
 };
 
 enum station_event {
diff --git a/src/wsc.c b/src/wsc.c
index cda877cf..f88f5deb 100644
--- a/src/wsc.c
+++ b/src/wsc.c
@@ -654,6 +654,7 @@ static void wsc_check_can_connect(struct wsc_station_dbus *wsc,
 	case STATION_STATE_CONNECTING:
 	case STATION_STATE_CONNECTING_AUTO:
 	case STATION_STATE_CONNECTED:
+	case STATION_STATE_NETCONFIG:
 		if (station_disconnect(wsc->station) < 0)
 			goto error;
 
-- 
2.34.1

