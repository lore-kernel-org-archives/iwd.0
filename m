Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76AE2585
	for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 22:32:07 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id q9so7325323pgq.8
        for <iwd@lists.linux.dev>; Wed, 21 Sep 2022 15:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ioEKODYh1ZSY5cAJq5YWMBG1r0OefmyNwXVK8B1HyOU=;
        b=MzqGCHpeBcZ35hZrYcQWS8164GSdtjuPSsgPVIDTYCSPdkvKsdPWNuoBv5FDkyuzlg
         gks007O1Ss0YM6eLe85JgTPtx/qozfwhqFVFaLl31Q/2I6xVt9lxV/8grNj5rEQ1y3Bn
         h5vrujzIv63/VSxtpdZ1o2Z8+0QZzae9DScSxC579JRwiLbmnlMS7Wdj+ThA8ds+I4mB
         S0KQ9GmpDrVP4D9F9NFArR7IgbdLzdRl/PyOnLROa8k5MtywPmDF5G9c0dwzwl/hbvmn
         NN4vALwM5h0DiTfoCqH7G+nIMD5S4OAw62A5Kf36gThBH5MLUkurpKj9BgvVf0PGpynV
         E0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ioEKODYh1ZSY5cAJq5YWMBG1r0OefmyNwXVK8B1HyOU=;
        b=O+zITNLeYJ6VPdzFMv/XvP1UEszVsIUT8mE2QyCKA37But94bhtppEHXFmFXXoLEKw
         PejhNpAmyzp7ei+L2/IKPAAnx7Lre8/809MdvyQPfbBGp1MIjFSAIfpujOoS7P6cMfkm
         uazDxco676n9faXwBzK4Z6mJE782hKHfJnQbctkGQfs9hzui/Amh6Yc7oAcAUgufYRU+
         WBfGoyU3QA6RD7T7PgVNjcj+pjdLVgEWyr3tz+LAPEOEcRIO8cYMSf0HBMGxnaOCscKG
         L3ko4ngh/wUPxE6t4W31t418qW0MONbbbf+DeYKUyzQRiQCuM9am/tvIyJZgd6Xh2Gd2
         0EbA==
X-Gm-Message-State: ACrzQf09RDhyrZU27DTfLrQ/GxVnA/URc7hlr4QUXQ4FkwmTDnU6+b4H
	WomlaLN2Y5/OFrJsrRwVFDTGYw0TobI=
X-Google-Smtp-Source: AMsMyM7nOp3wJKHdCXyILg8gXktUe2ccBhpuezBErWIKVUAwuVUlL9EE0hIWYE8wlS2RwokhPUZZFQ==
X-Received: by 2002:a63:1351:0:b0:439:14a8:87 with SMTP id 17-20020a631351000000b0043914a80087mr384159pgt.66.1663799527036;
        Wed, 21 Sep 2022 15:32:07 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id r10-20020a63e50a000000b00438c0571456sm2393135pgh.24.2022.09.21.15.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 15:32:06 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 11/15] station: handle NETDEV_EVENT_FT_ROAMED
Date: Wed, 21 Sep 2022 15:31:54 -0700
Message-Id: <20220921223158.704658-11-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220921223158.704658-1-prestwoj@gmail.com>
References: <20220921223158.704658-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/station.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/station.c b/src/station.c
index df54936e..03b0ddcb 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3152,6 +3152,10 @@ static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
 		station_packets_lost(station, l_get_u32(event_data));
 		break;
 	case NETDEV_EVENT_FT_ROAMED:
+		if (station->state != STATION_STATE_ROAMING)
+			return;
+
+		station_roamed(station);
 		break;
 	}
 }
-- 
2.34.3

