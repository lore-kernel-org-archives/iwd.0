Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B673E1CA82
	for <iwd@lists.linux.dev>; Wed,  3 Jan 2024 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov+EbyWs"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dbfe3fe308so2402462a34.1
        for <iwd@lists.linux.dev>; Wed, 03 Jan 2024 10:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704307617; x=1704912417; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igAAo3g1l3VHhGPJSjX2tgH+xOx4tYN1jMtUohUPvSI=;
        b=Ov+EbyWsuG1O4VZtl9aL5hln8pO5QL7phpuRo5h4VF+l0tc+Bt1TO5Omb+vyf3EKNK
         LJ24+g2JdHVIQ3NE1tqOvbwR1Gn2v/KS7mIyeVqWr8V3VPoxPTqp1AkGXqYKIc7JfnVf
         ohBdA0psGR+pBdgClmSvFavDuR1J6T3vdXrhNzKoNBzR7GKc+QFfntiCiIs/pKLrxMrl
         7vyKN6kqX29LpdR4vAGXomjw8El2BIah64MKf3aCtW58aWlXmbCZcD8hq65RNTVJIPGI
         IRRqXtMGnzfdKTvzz8Tiq8i286Vp2pIGm3bZSC0VE+UYBUmr0nbWiCBuSQUduH9n2nZn
         M2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704307617; x=1704912417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igAAo3g1l3VHhGPJSjX2tgH+xOx4tYN1jMtUohUPvSI=;
        b=EskDfBC981xide+qQChwp714Wg+HnhALS93Yd291cTVl6JzFCH1eofnAWEmu2Zq1fT
         DtZyssD92HNqJazH53OJiOy+UuWbyiCKktHYfuTn/xE/7CrzbcVQztSCIoWFMLWvKRSc
         Nx34nJiP7oinY5iqJGMlpGXr1MA1EAD7Au1JsN3bON9MfEz3dScdwXKxI/RAWFxbHWdA
         hQGAsHHXng87iRba8Y4uSxZjMbFd9SdWHS2p3KXjysYCtYPsfH20GcGz+4MR72FQmJ09
         RDboJehu+wqGAAF/5RJO3oXUMlcSvrVTqnUaY5u/R3pMosHflOgyi06yGIVsE2lbM/Ot
         FfOw==
X-Gm-Message-State: AOJu0YwEZH6jrBgW0vANVoI9wR4Lc4NmVWH9odfa3huzCRp/wRSq1fXO
	dN9pX3CAA055Y8SK/NnMcPsOjUXc3bM1iQ==
X-Google-Smtp-Source: AGHT+IG8b1zR+MANf4LZDBHFFZrCsZK8omKdSHDvGC90PLPhEJgv0GPzMVfGXYgXh07nPmsVVRF7DA==
X-Received: by 2002:a05:6871:3a0b:b0:203:535d:102e with SMTP id pu11-20020a0568713a0b00b00203535d102emr9821469oac.21.1704307617335;
        Wed, 03 Jan 2024 10:46:57 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a22d500b00781a147e444sm3693370qki.92.2024.01.03.10.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 10:46:56 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/8] station: add additional internal state, STATION_STATE_NETCONFIG
Date: Wed,  3 Jan 2024 10:46:32 -0800
Message-Id: <20240103184638.533221-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103184638.533221-1-prestwoj@gmail.com>
References: <20240103184638.533221-1-prestwoj@gmail.com>
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
index 5c9ede8b..57d22e91 100644
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
@@ -1633,6 +1635,7 @@ static void station_enter_state(struct station *station,
 		station_set_drop_unicast_l2_multicast(station, false);
 		break;
 	case STATION_STATE_DISCONNECTING:
+	case STATION_STATE_NETCONFIG:
 		break;
 	case STATION_STATE_ROAMING:
 	case STATION_STATE_FT_ROAMING:
@@ -3344,6 +3347,7 @@ static void station_disconnect_event(struct station *station, void *event_data)
 	case STATION_STATE_CONNECTED:
 	case STATION_STATE_FT_ROAMING:
 	case STATION_STATE_FW_ROAMING:
+	case STATION_STATE_NETCONFIG:
 		station_disassociated(station);
 		return;
 	default:
@@ -4274,6 +4278,7 @@ static bool station_property_get_state(struct l_dbus *dbus,
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

