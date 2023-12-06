Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCE36F631
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkIm8NO/"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ce33234fd7so213568b3a.0
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 12:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701893895; x=1702498695; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mxJF5StbFHgA8xLY14uDOHYGQjLyG4VM1xi5k1s7+c=;
        b=KkIm8NO/49i/xQPnflGowsBcj2PrMREgIGj195/jlS2B7JH3qqQWg863xMAtPoTn3T
         q36dmKehKpKFgZLyh0NlCgFwmaQogZRW/YSw2vOwWahstI17gpKqUjs6xEmGGvbMMQSX
         6II+nLbyX6vX2YXP/F62SpsJlszWb84dbZ7wpaivFAy6YFhSdMSImf2bkjuU41qirUcK
         nplyyQnOo4tgKowummtnH7Gt+9/JI3Nac3dqKD3QxBkpPZgF7ylU58SvOQNeVyWIWMdN
         IjKzdvB8/l89gJ2LHKLXhBsdW2/S2WJuSuKsg0CZ70KULE8qHyRgk4Ms7+AudOJdOull
         y+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893895; x=1702498695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mxJF5StbFHgA8xLY14uDOHYGQjLyG4VM1xi5k1s7+c=;
        b=hbBeYPL37prGTxCqZA3Ge9eiWP73cqlTx9bswo1KOoiAJLpgsyJF5816Wfnj3/0UDe
         L4upBBXpfE/V0QehCqfmxE3L+xfVrqgyVS95WNw0RiVvITp4V90RFrxfsMzCsqZcsaw+
         ab1m1qJ3Q6l29pXPL4reoyz3wdLmZcJCCOa6CoJ/2T8Jdufoe5Vwcsxoa/o+XUKxsTVy
         1CDoCWCWDTf8FV5sw+uaIkd0PYrKyoYfs7DiDdVTNCRqNjVO3Wo7lYLvdy4y3B5/Q7Fp
         xU9n2ONhSGZUrKBxVFawYx6yS+0uiLoCzkL9+XEqnq2HoLyTsLECugNSpMkbdwtTBFro
         N+Yg==
X-Gm-Message-State: AOJu0YxWUUOUGbJVDWDsCJjwqZilNNmi7IpJuwTxlh+WLh2w4p234pPX
	auXPBBucNMZFROh9K5EyQ6TmjcW0CFeO6g==
X-Google-Smtp-Source: AGHT+IEZSRP+Lokp6uvZoJH6qNarKQp7TOJruDN9PZ4GbrliKiSseBmlz3FTEA6rAHbZGCT9mUIQzQ==
X-Received: by 2002:a05:6a00:2d25:b0:6cd:a145:6703 with SMTP id fa37-20020a056a002d2500b006cda1456703mr1208722pfb.2.1701893894699;
        Wed, 06 Dec 2023 12:18:14 -0800 (PST)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id by40-20020a056a0205a800b005c2185be2basm243168pgb.54.2023.12.06.12.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:18:14 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 13/13] netdev: station: remove NETDEV_EVENT_FT_ROAMED
Date: Wed,  6 Dec 2023 12:18:02 -0800
Message-Id: <20231206201802.2139649-13-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206201802.2139649-1-prestwoj@gmail.com>
References: <20231206201802.2139649-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The notification for roaming success/failure is now handled with
the connect callback.
---
 src/netdev.h  | 1 -
 src/station.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/src/netdev.h b/src/netdev.h
index fb31b571..d87f09f4 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -50,7 +50,6 @@ enum netdev_event {
 	NETDEV_EVENT_RSSI_THRESHOLD_HIGH,
 	NETDEV_EVENT_RSSI_LEVEL_NOTIFY,
 	NETDEV_EVENT_PACKET_LOSS_NOTIFY,
-	NETDEV_EVENT_FT_ROAMED,
 	NETDEV_EVENT_BEACON_LOSS_NOTIFY,
 };
 
diff --git a/src/station.c b/src/station.c
index 52d87c84..73de26bb 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3444,12 +3444,6 @@ static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
 	case NETDEV_EVENT_PACKET_LOSS_NOTIFY:
 		station_packets_lost(station, l_get_u32(event_data));
 		break;
-	case NETDEV_EVENT_FT_ROAMED:
-		if (L_WARN_ON(station->state != STATION_STATE_FT_ROAMING))
-			return;
-
-		station_roamed(station);
-		break;
 	case NETDEV_EVENT_BEACON_LOSS_NOTIFY:
 		station_beacon_lost(station);
 		break;
-- 
2.34.1

