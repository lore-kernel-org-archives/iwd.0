Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6353712FB0A
	for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303124; cv=none; b=jmso8dhsopJtYtRHZDoUctW7BeWgEIcLBNceh4BYOGomE4GI/0I3I07DmC4HgbCbYH/n41GhwOGuYh007NcwGsnHGaVk2NMdQ6cCawqHBIy4zhgj/TbG8D3eMJSkAwiaS4meUPDvqC5iMJot57JvSH83v0Z1nuUClL8MISO5Hhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303124; c=relaxed/simple;
	bh=iMPkAiEo25I69eG4u/rLo85e8CEgQv2IiZZ7692nOCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ObmspbRE8J7Q6sRYgazCL4+R6jPszqgSe2ZeCTkK8YJROHIuBdC5x8f4q2vIy1CGH2+Lu9rW6a/Fha+ZPvZmLyY7P8ldtgcDDgm4+aU/iWDMiCpGKCmAprTec7u/RmJ1v2WMb0BKUOj/vPng3vUuVilDRGFZkd9B4xoHGMUdw5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/4nLlpA; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/4nLlpA"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b7a4668f1fso979306d6.3
        for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 04:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721303122; x=1721907922; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9KMScYpkyjctODl9YwsDQ03Qmx2HdjozWuFMEfE4fw=;
        b=k/4nLlpAz7Fp4TSaJXRQwcSFRzSLdMXX0VYuQ/DbXTqHhp/Z9k9mr2z9WhLDRcTR+g
         OTxDL426fsyGqw/mz63iQ/zZ/S297xALwe/XVd0inA8esntVsJdJuHtt43Yr7kdBttrm
         6+3SZ0MOQkvxyUVRo7TG/JvrKebVFvkQzvts+rkIYkvbH//FzTrHawNxvGDabUZYLdGK
         oRPifmRfuX90ehIop9RgiMVq6nFsTWkR1oWqyYUf6wXKQZUlURTdxiTnrsZJ8nl9uviY
         dfUMR3G1ByTWKGzPup2EMJs+F/WUWnaUzTdiRLeI29TxygrtXBS3hMhjMLHPgW812f3d
         cvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721303122; x=1721907922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9KMScYpkyjctODl9YwsDQ03Qmx2HdjozWuFMEfE4fw=;
        b=R29qxFZyjzc1sdYf8kdODZyV0RNzxwqatpkWnxVWQNRvZGz7g4qKlJzGjVKRYFATyy
         HXLhoEyY7RVayYKH8+BIvK+GGUqAndAsXVFLSLGGBjc7oKntLdABtJQOM0MX9nddfGTi
         lPagKsRpPaypR7Z8ljflSHdXXYJsqPgU1j9f6LkQ7Pp4z4uK28PMYRZ/VWPtNg6B92OR
         bKXiz3xAF8HcScDKwzXw35ffONppCrHs/D/OX+j0QLd2aMgEe8l6anbNEEyK/XwqwSvy
         oVcwzf8A2CG9KsK2Fc2ilRgm6/+BDBirTKyS3n25PWQSKO3qtAkZAQFf2q9eoRKqanhe
         1Yjw==
X-Gm-Message-State: AOJu0Yw45+lJMflcNn7mkGtt68tzZAIq0nmpA0h5Ulz7ZA+8PQ5frQso
	ZWQng6Uh0B2PGYld492KlU1DG/tOGfJYb1rzrGMAK58WKZw32uZIFMwXBA==
X-Google-Smtp-Source: AGHT+IGnD5XoCw8/Yp8PRefPAHYqV5yGDigCL+0YbKtDriJfUYFQK83iLJ9fZtNHAx36UY8QQJhD3Q==
X-Received: by 2002:ad4:5c8f:0:b0:6b5:dcd9:1cb5 with SMTP id 6a1803df08f44-6b78e2b409emr58065566d6.56.1721303122070;
        Thu, 18 Jul 2024 04:45:22 -0700 (PDT)
Received: from LOCLAP699.localdomain ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c5138bbsm7292006d6.61.2024.07.18.04.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 04:45:21 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 03/11] station: handle NETDEV_RESULT_DISCONNECTED
Date: Thu, 18 Jul 2024 04:45:06 -0700
Message-Id: <20240718114514.2916258-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718114514.2916258-1-prestwoj@gmail.com>
References: <20240718114514.2916258-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This new event is sent during a connection if netdev recieves a
disconnect event. This patch cleans up station to handle this
case and leave the existing NETDEV_EVENT_DISCONNECTED_BY_{AP,SME}
handling only for CONNECTED, NETCONFIG, and FW_ROAMING states.
---
 src/station.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/src/station.c b/src/station.c
index 01f6b78e..abbfc3dd 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3311,6 +3311,7 @@ static void station_connect_cb(struct netdev *netdev, enum netdev_result result,
 {
 	struct station *station = user_data;
 	bool continue_autoconnect;
+	uint16_t reason = MMPDU_REASON_CODE_UNSPECIFIED;
 
 	l_debug("%u, result: %d", netdev_get_ifindex(station->netdev), result);
 
@@ -3320,9 +3321,22 @@ static void station_connect_cb(struct netdev *netdev, enum netdev_result result,
 		station_connect_ok(station);
 		return;
 	case NETDEV_RESULT_DISCONNECTED:
+		reason = l_get_u16(event_data);
+
+		iwd_notice(IWD_NOTICE_DISCONNECT_INFO, "reason: %u", reason);
+
+		/* Disconnected while connecting */
+		network_blacklist_add(station->connected_network,
+						station->connected_bss);
+		if (station_try_next_bss(station))
+			return;
+
+		break;
 	case NETDEV_RESULT_HANDSHAKE_FAILED:
+		reason = l_get_u16(event_data);
+
 		/* reason code in this case */
-		if (station_retry_with_reason(station, l_get_u16(event_data)))
+		if (station_retry_with_reason(station, reason))
 			return;
 
 		break;
@@ -3383,17 +3397,12 @@ static void station_disconnect_event(struct station *station, void *event_data)
 	/*
 	 * If we're connecting, AP deauthenticated us, most likely because
 	 * we provided the wrong password or otherwise failed authentication
-	 * during the handshaking phase.  Treat this as a connection failure
+	 * during the handshaking phase. Connection failures should be handled
+	 * within station_connect_cb/station_reassociate_cb apart from netconfig
+	 * and FW roams.
 	 */
 	switch (station->state) {
-	case STATION_STATE_CONNECTING:
-	case STATION_STATE_CONNECTING_AUTO:
-		station_connect_cb(station->netdev,
-					NETDEV_RESULT_HANDSHAKE_FAILED,
-					event_data, station);
-		return;
 	case STATION_STATE_CONNECTED:
-	case STATION_STATE_FT_ROAMING:
 	case STATION_STATE_FW_ROAMING:
 	case STATION_STATE_NETCONFIG:
 		iwd_notice(IWD_NOTICE_DISCONNECT_INFO, "reason: %u",
-- 
2.34.1

