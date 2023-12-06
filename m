Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B0B3EA88
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 15:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmwDufAn"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-77d895c298eso418082485a.3
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 07:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701875243; x=1702480043; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BP2GXecCLTCwhtG6lubs+kIXOz4u2K6hWAydD47yba8=;
        b=RmwDufAnMIg1h6olqH6faFbrtPSHIG9FV2yCprfli/nax8LWm6GeFA7C945ZPFt+Qy
         2MxjEr0DyVGSZYSmkOdiIsPsgIriC+qy4Sg0v9hIcsZXaIShF0G/83bzw0Dm7kDzQqw4
         uU1Q/qswM2uK30TN67QGA7kmlZi/gUo4wbo8I6s5u5/rI2OC/zSvidjFvt4GUiYSPZos
         lv70Lr9dB6316zNAaVFZfwNRZpeeEhHjz/rXKP6A4b2VFFFM+ydNDpgKbs8q9VAJECj+
         4QsglXdzQ+7SD2p9zm3QIgxJt0h7HpUwzlPvfuTW5XAl23cFsJceV/I0GLmlLW5zkrVI
         rTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701875243; x=1702480043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BP2GXecCLTCwhtG6lubs+kIXOz4u2K6hWAydD47yba8=;
        b=g1OXWg1HdKgMXre9sIyYWuHKLMee4DW7gYAjSQo5mmASi+jD7lDrnAlig4C2m1eOp+
         PPsLBq2hDPHIOLJKsJK12R9GE/iFYOPQhh5uihTqlQrmqHFcg2srdYmsBFHyntYra23C
         mh7w9tGS0cFdpROnKidyYeGIRZDZMBtkYoUbWszlP7qIP0h/8ynTG1LtavLLup14ocB2
         taccXnrw0Zr68E4Gm3GmYocVi8DDCNdUh5tpm+up24lWAK0c+uZeMwAl7eKgBh3sVtEC
         Ww1DZyM49QStNwIlSNhyXMXYe/CPcL8XS2zQCjJ6d5Qe8ftbzpOtTsEiBn0VjYfTXVKx
         hMYQ==
X-Gm-Message-State: AOJu0Yz0XoKR4ecEIoVr2ytWFnbCRjJ8/6LywuV/VLcKCe2UvU9dm8ib
	VC160Qz5tqOKnYRLJAZAGOXr1pq1p40=
X-Google-Smtp-Source: AGHT+IH0xcpCfe66ATtslLL/0MEHVDfEZK4/diqb0+YIYol6tYENcpIgpoM8MlXyNtEAL4iOZWExWg==
X-Received: by 2002:a05:620a:55b0:b0:77e:fba3:4efc with SMTP id vr16-20020a05620a55b000b0077efba34efcmr1066005qkn.82.1701875242460;
        Wed, 06 Dec 2023 07:07:22 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id vy22-20020a05620a491600b0077d66277e9asm11506qkn.116.2023.12.06.07.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 07:07:22 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 7/9] station: use netdev_ft_reassociate
Date: Wed,  6 Dec 2023 07:07:06 -0800
Message-Id: <20231206150708.2080336-8-prestwoj@gmail.com>
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

Using this will provide netdev with a connect callback and unify the
roaming result notification between FT and reassociation. Both paths
will now end up in station_reassociate_cb.

Fixes: 30c6a10f28 ("netdev: Separate connect_failed and disconnected paths")
---
 src/station.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index 48a595dc..b5e78a37 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2181,7 +2181,8 @@ static void station_reassociate_cb(struct netdev *netdev,
 
 	l_debug("%u, result: %d", netdev_get_ifindex(station->netdev), result);
 
-	if (station->state != STATION_STATE_ROAMING)
+	if (station->state != STATION_STATE_ROAMING &&
+			station->state != STATION_STATE_FT_ROAMING)
 		return;
 
 	if (result == NETDEV_RESULT_OK)
@@ -2314,7 +2315,8 @@ static bool station_ft_work_ready(struct wiphy_radio_work_item *item)
 	if (!bss)
 		goto try_next;
 
-	ret = ft_associate(netdev_get_ifindex(station->netdev), bss->addr);
+	ret = ft_handshake_setup(netdev_get_ifindex(station->netdev),
+					bss->addr);
 	switch (ret) {
 	case MMPDU_STATUS_CODE_INVALID_PMKID:
 		/*
@@ -2343,6 +2345,13 @@ try_next:
 		station_transition_start(station);
 		break;
 	case 0:
+		ret = netdev_ft_reassociate(station->netdev, bss,
+					station->connected_bss,
+					station_netdev_event,
+					station_reassociate_cb, station);
+		if (ret < 0)
+			goto roam_failed;
+
 		station->connected_bss = bss;
 		station->preparing_roam = false;
 		station_enter_state(station, STATION_STATE_FT_ROAMING);
@@ -2354,6 +2363,7 @@ try_next:
 		if (ret > 0)
 			goto try_next;
 
+roam_failed:
 		station_roam_failed(station);
 		break;
 	}
-- 
2.34.1

