Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91A23EA88
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iw3Woq8w"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-77dce4d41d5so373353585a.3
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 07:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701875246; x=1702480046; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dh4q3U8aR5wWiqh479HUG4F7x1/MlU5Z12kadUzRPE8=;
        b=Iw3Woq8wu9jnuOxANgSnecvLzEj093qF8eJqZS3/rfbS9EHBSxZVKXCRf7IeZ5SbWN
         ixLaNhnEERHYOw+Cj9PttXnVOeFA4Bh7mz8SjZ9MM2pe06STtf0DUpibtxREnZYeUqK/
         ip0tPiyIOeuGoEodkH5ff6LnQGqmSowDEADI3W5aOYOXdSOrahVD+cyQNNosSc4pyx3W
         mPKWONaRTE4sHX4DV14KkGfR5sLb89tcm9t7fH1t6KCkznK5ViEzAI64q8s8zGdplPkH
         1YIsru7CSjictlAs2q9Xa2q4EwnAoqCG9UOWh51/+cASP5bPDc+Xjk6DEmXb+Aye8eSi
         6Ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875246; x=1702480046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dh4q3U8aR5wWiqh479HUG4F7x1/MlU5Z12kadUzRPE8=;
        b=HcvZGUn7JM3h9SBJLTlNLh2h2Anb5PxjFEVj7XXJlVKp9ye8sJ5QOCJv3g8Vid08ql
         AHr/xMpgLFFx61NYlmqsEjLr1Z1rDJLcZx6EX/HOJHgBsB9zO4wFp1Rm5s7aNTvskHhF
         MqdYfIDY5ncfznTy9ER5yNpxgV26WL+N403Wb2GvxG/koTe6CdQjTzLw5LrrKbJnfIWo
         +lRJmU2kSuqFP2N5sRXyN62xk5QstPm2whBEEq6wcrihJv9zRTm+WLRc7FrUNjSTCjmx
         EYRy53uhXdhZusYBoOIY+9KVaY5wqALJ0E7REYRGiVUUJLnKo4L5mpeLdAsHz/lNwmgw
         WZ1g==
X-Gm-Message-State: AOJu0YxCDy/rt6k0SyBCFp6VGQU2ykvfxCAziF5Ejl32wExpQJgBIDP8
	ghnPymaNZThzHvt0ZIUOz4BTZSPPf14=
X-Google-Smtp-Source: AGHT+IGhx398W97XwJwCrrcgULXY4cT2VwbJwVVTt/UNTOXUQ9DEDQ+0caSwW3TIiOnHHvi7p828bA==
X-Received: by 2002:ae9:e517:0:b0:77d:c7f6:679 with SMTP id w23-20020ae9e517000000b0077dc7f60679mr1058057qkf.58.1701875245608;
        Wed, 06 Dec 2023 07:07:25 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id vy22-20020a05620a491600b0077d66277e9asm11506qkn.116.2023.12.06.07.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:07:25 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 9/9] netdev: station: remove NETDEV_EVENT_FT_ROAMED
Date: Wed,  6 Dec 2023 07:07:08 -0800
Message-Id: <20231206150708.2080336-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206150708.2080336-1-prestwoj@gmail.com>
References: <20231206150708.2080336-1-prestwoj@gmail.com>
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
index b5e78a37..f5d6914f 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3436,12 +3436,6 @@ static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
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

