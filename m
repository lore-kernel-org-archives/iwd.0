Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA79E171CC
	for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blip7KMi"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-41cc44736f2so33839121cf.3
        for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 06:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698673728; x=1699278528; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9u+hty29+P7c9zIKJAJcDefyW9mA99xF7TP5MMp1a9A=;
        b=blip7KMiwN/8AKyA1y3svSmZkRJ6PvccuEg/7dJ4x2oGHiLjkE5pBzWr9Ryuocj4KT
         Voy0GcJ4vlDOVzMV+Kvu6QKXDfxCFK111bgy//FX+j80cAHm9KyuGKJTS/EC4kUEA8d+
         cVEw3FTHn5BMhko/5Q80DBLk0+7U/ASo2l5iPinFgUTW4SbZISUSTPYpwLAeNbnzCasU
         0KdemLgyO1xFJnxSnH1lcIvdcd/TiCRiNFC+0OSmMgqn5p9yVllPQh/5xmUnveH+wgcg
         3ajA62ijhK6C1hKJN2wpviorlA5I0nL2KzS2iRAuHPLGBmIvS2CIDcoOILFBDjygBHk0
         kPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698673728; x=1699278528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9u+hty29+P7c9zIKJAJcDefyW9mA99xF7TP5MMp1a9A=;
        b=vlImL6bS0rahkAYputnDcQ8/IUfhEJZq6Ii6hlkbkRUwPF2Uw2Ck0g1FhzvdH3YfnB
         +dpbZjiQx/T6DsTwOkjQ3BswVXgiJylAyH/JndTKirezVxvkF/rGw05Bzelck1Cf4cPP
         9zXX/T92l57Ydpix8gUSQXO4Ko6pV/dVuw3WcmMA5krG8CzSfahEmcTffMrr9EQHKu4n
         Izz+cE+WlwalUZh8IN+NICdt8/ntWKxUuAiTKF3eWt+8b0aWs3CRYDgTLqKWY2Ncp0hT
         zHOmCpqgtf+dryiChoYsiG3RxyROTPyqRCruJlFVZ1fEmKx8gw6+tv6hfuWp9jWHW9w8
         dlMQ==
X-Gm-Message-State: AOJu0Ywwwedet/p50fmkkrsohXOCc6FWB9CUN21oqXuIXkLl+kCGIp2r
	kE4juVqJDvBzBY/2iiB+sCrYcN+61/g=
X-Google-Smtp-Source: AGHT+IHlrhaKE2eN0HnqoOTOu9D0WZdjLmU98mmOFx8GDGl5rv2HI4EF3dNa0cALwijAhpK6Iy3Z/Q==
X-Received: by 2002:a05:622a:18a:b0:41c:c5bd:712 with SMTP id s10-20020a05622a018a00b0041cc5bd0712mr13135660qtw.62.1698673728505;
        Mon, 30 Oct 2023 06:48:48 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id c18-20020ac86612000000b004181aa90b46sm3419929qtp.89.2023.10.30.06.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 06:48:48 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] netdev: handle/send beacon loss event
Date: Mon, 30 Oct 2023 06:48:36 -0700
Message-Id: <20231030134837.452957-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231030134837.452957-1-prestwoj@gmail.com>
References: <20231030134837.452957-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/netdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index 56c6ebd2..86712658 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1054,6 +1054,7 @@ static void netdev_cqm_event(struct l_genl_msg *msg, struct netdev *netdev)
 	uint32_t *rssi_event = NULL;
 	int32_t *rssi_val = NULL;
 	uint32_t *pkt_event = NULL;
+	bool beacon_loss = false;
 
 	if (!l_genl_attr_init(&attr, msg))
 		return;
@@ -1081,7 +1082,7 @@ static void netdev_cqm_event(struct l_genl_msg *msg, struct netdev *netdev)
 					break;
 
 				case NL80211_ATTR_CQM_BEACON_LOSS_EVENT:
-					l_debug("Beacon lost event");
+					beacon_loss = true;
 					break;
 
 				case NL80211_ATTR_CQM_RSSI_LEVEL:
@@ -1111,6 +1112,9 @@ static void netdev_cqm_event(struct l_genl_msg *msg, struct netdev *netdev)
 	} else if (pkt_event && netdev->event_filter)
 		netdev->event_filter(netdev, NETDEV_EVENT_PACKET_LOSS_NOTIFY,
 					pkt_event, netdev->user_data);
+	else if (beacon_loss && netdev->event_filter)
+		netdev->event_filter(netdev, NETDEV_EVENT_BEACON_LOSS_NOTIFY,
+					NULL, netdev->user_data);
 }
 
 static void netdev_rekey_offload_event(struct l_genl_msg *msg,
-- 
2.25.1

