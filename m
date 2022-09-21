Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54908844E
	for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 22:32:01 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id d82so7389793pfd.10
        for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 15:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=B9WsOvBX3xcmmGL4201Y9XODv7plENMgT6qn+GXTiY8=;
        b=XYPG4krQvCknTGPVBB+y292/21Hm5wB1qO4bnFbOHfp9xHZC8uSnX5kApIXxGXxYsE
         mG7D/spb27IPfMY9mNrlFfI2p6kB85Ac7NBaAsGNM3IpFcS6NU8/Scw/Fiykj8/QuFsB
         SayaH9iGzXypxDb8gd7qQLqn3Md1OFFWOMdcvxzxOMqC1NhKdZxH1XsxRxt7KLuahrV7
         7spC4Lh2+vWwUAofqKNJlUx/BLwXhurS6RlmU9G1B1T5IvUy0V4IYoiKtOjT6I++NC+a
         aFkVxi6mI8rmfYPKqKrxOAajz6aHkFFRu5nI97djzkzQxir1dNSx+Du+5HZa13B25s/q
         r3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=B9WsOvBX3xcmmGL4201Y9XODv7plENMgT6qn+GXTiY8=;
        b=yd7grzJez3QgfLcJdgSJP0EWGnbgVYWB+MI4TQW0iPx+1B68NzOx8EHPqjwy7bGz1c
         CtzXS1kAZutIJo7QfCGAkFTRgMVXJPh6Af24Wot/MZ6kkit+mJuexVOBUuj/FB3kYEn3
         KWHDbPvCea1B2GkBEldq1+/qWuEtSxQF+LQ4updju+09vwgthWi2SMAGdRq7tKVBOAzn
         pCj1rLQ1MnDfCqdba5LuWZhVz2aKs+dpcZmMh9lxOYvVspFWM1MNzHZtla3ylDpwzIkT
         onyn+TInAbRI67WUOo+2y5s5E8NjcFg+crbfh9Zkrn5logwA4GiV1HQMLQ3OIQsbPS9S
         uWSw==
X-Gm-Message-State: ACrzQf1jNi8WminuQjvrKyeGZHtocx6CzNP1Ch6Zsc9ruweGf2JT0nzk
	E5leScMP4e2thpFZnwzUVb10W+zAtwE=
X-Google-Smtp-Source: AMsMyM5rmxX+Xtty9rgFemxNJG23H2DDYWV9KpeHOt/uFqw+AlGwpUNYmxE30xnFfpNDDQUUdqbhLw==
X-Received: by 2002:aa7:9e12:0:b0:53e:27d8:b71b with SMTP id y18-20020aa79e12000000b0053e27d8b71bmr441705pfq.46.1663799520625;
        Wed, 21 Sep 2022 15:32:00 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id r10-20020a63e50a000000b00438c0571456sm2393135pgh.24.2022.09.21.15.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:32:00 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 01/15] netdev: add NETDEV_EVENT_FT_ROAMED
Date: Wed, 21 Sep 2022 15:31:44 -0700
Message-Id: <20220921223158.704658-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FT is now driven (mostly) by station which removes the connect
callback. Instead once FT is completed, keys set, etc. netdev
will send an event to notify station.
---
 src/netdev.h  | 1 +
 src/station.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/src/netdev.h b/src/netdev.h
index dcf3ad1b..c5933ad0 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -50,6 +50,7 @@ enum netdev_event {
 	NETDEV_EVENT_RSSI_THRESHOLD_HIGH,
 	NETDEV_EVENT_RSSI_LEVEL_NOTIFY,
 	NETDEV_EVENT_PACKET_LOSS_NOTIFY,
+	NETDEV_EVENT_FT_ROAMED,
 };
 
 enum netdev_watch_event {
diff --git a/src/station.c b/src/station.c
index 79d2c755..868bb725 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3129,6 +3129,8 @@ static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
 	case NETDEV_EVENT_PACKET_LOSS_NOTIFY:
 		station_packets_lost(station, l_get_u32(event_data));
 		break;
+	case NETDEV_EVENT_FT_ROAMED:
+		break;
 	}
 }
 
-- 
2.34.3

