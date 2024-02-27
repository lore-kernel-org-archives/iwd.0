Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840FD2E64B
	for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 18:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058871; cv=none; b=Iv+8femTWOlEP0CeB5zU1vGx7oFLdb1mU7L/FijHHTsGmhNZHx62tYI7ICd+FRP5kX8sVfdEPf/9v+IqUIbqsWscEKklBmiuLU3P5eOBQCHcTQoV8L843W6m06CWxK7jUuI2lyW1Vmg1D5WJmgVraGX13HJjm4wj2qNc4259qR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058871; c=relaxed/simple;
	bh=CWIGXxX+IBehVy8ckQWj/WuUqwLmaB7WKAdr5N7/XLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D4X+iP+kdaBovX+HHp5Haypql6ucGeRjHjzxjZV36o0VDWdgKcnqnVHKZ9beuS+DKslvWyrwaLtNgu6nu/tjoD1mvnJF4xqZmUjK4qkMZ4fA5fCk4aA2AVuW0Klq9NhYjgw4d+bMhIRMj89lbqbBSKkzZ82VxXjD1mme0hJOZQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4uOeQSm; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4uOeQSm"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42a0ba5098bso27706351cf.0
        for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 10:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709058868; x=1709663668; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tf/+0KJKf8yc88ghGME20zNh8tArqlH3uLGTPsrzi5c=;
        b=e4uOeQSmnM5dfqEVds+mlPpKJS7ChDwZerrWIK2uPtf0xwFEc21fOUIeS04eUpgTTg
         nJRaWMyYmlkmTdsoDUHjWtpdGHNSTkvu5hxWzL3tXIwqigM1fhbC6bxtXqA4+8B19g8t
         Y4yVNkLJUsxaep0Qi4BNvcs4BV4DinOouBk54ypcC+tx//4rTT4mHxKGD3joMlGi2GLg
         CzMg3eCl254vBRDHBXE2+8E1XCmV0jhIu8r1Jj2OlyVlmlnUVvSwCOnq4e3EzYRc0e8z
         nGudHC3qvBKqg8Yxz7stn2Lv49esTj9zS3pwlKaaHULkMI47RA9xwubKGd6lpfOgpOJE
         KFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709058868; x=1709663668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tf/+0KJKf8yc88ghGME20zNh8tArqlH3uLGTPsrzi5c=;
        b=ceZtf00vdVNngOHAG8EMHdGUhYgzG6dks0aknjo+33oHPzY8sCFNLWDXFPKqMNjXTY
         M+jbLHgEeDEu6mrA610YL60hHzJsjvdFaSPuEFGR6v+x3O+HpCzWTZrJJD/ZF+7w0jGm
         DzJBAq5DPP+8oc8I1Rvk553ebrRAkcnA1k1yZPupUBoMhX5yGumti6JlYXvtnwOOhDEF
         k7NIiEqXG+vGf1S1v/3rVPLAX3xR6mRQdCgmbdUXV6vphzo7wYg7KOQyYOFAsrkIcS0l
         GRRNOT2+XkNnjI5gdeoH63c+Z3znY9ny01Qx9Uaz9t322N/BEx/Thy4w8sto0C0HMFyk
         N/kA==
X-Gm-Message-State: AOJu0YyzYi9En3MkOwLioLHtiHMWVgJWhBZcfJiRTnQeuCfx2CknLQtE
	FfAZADuAJfdh7j3PtZn7T5FAppUTZ7rEdvo4VzEYPT6JeQ3tjU11ohf8ridm
X-Google-Smtp-Source: AGHT+IGAfq2b7ByrdGhxg5ONGJiZ67c7BTArP0H44HGqXwEzD7qOhJEg6FNvalhQ27MOoM98Q8OIcQ==
X-Received: by 2002:ac8:5d51:0:b0:42e:8e36:63a1 with SMTP id g17-20020ac85d51000000b0042e8e3663a1mr5577432qtx.6.1709058868281;
        Tue, 27 Feb 2024 10:34:28 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id jy2-20020a05622a818200b0042e3468a98csm3819617qtb.4.2024.02.27.10.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:34:27 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 06/11] netdev: add NETDEV_EVENT_ECC_GROUP_RETRY, handle in station
Date: Tue, 27 Feb 2024 10:34:00 -0800
Message-Id: <20240227183405.257206-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227183405.257206-1-prestwoj@gmail.com>
References: <20240227183405.257206-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to complete the learned default group behavior station needs
to be aware of when an SAE/OWE connection retried. This is all
handled within netdev/sae so add a new netdev event so station can
set the appropriate network flags to prevent trying the non-default
group again.
---
 src/netdev.c  | 15 +++++++++++++++
 src/netdev.h  |  1 +
 src/station.c | 15 +++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index d80ce10f..09fac959 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2559,6 +2559,10 @@ static bool netdev_retry_owe(struct netdev *netdev)
 	if (!owe_next_group(netdev->owe_sm))
 		return false;
 
+	if (netdev->event_filter)
+		netdev->event_filter(netdev, NETDEV_EVENT_ECC_GROUP_RETRY,
+					NULL, netdev->user_data);
+
 	connect_cmd = netdev_build_cmd_connect(netdev, netdev->handshake, NULL);
 
 	netdev->connect_cmd_id = l_genl_family_send(nl80211, connect_cmd,
@@ -2966,6 +2970,17 @@ static void netdev_authenticate_event(struct l_genl_msg *msg,
 
 		ret = auth_proto_rx_authenticate(netdev->ap, frame, frame_len);
 
+		/*
+		 * Allows station to persist settings so it does not retry
+		 * the higher order ECC group again
+		 */
+		if (status_code ==
+				MMPDU_STATUS_CODE_UNSUPP_FINITE_CYCLIC_GROUP &&
+				netdev->event_filter)
+			netdev->event_filter(netdev,
+						NETDEV_EVENT_ECC_GROUP_RETRY,
+						NULL, netdev->user_data);
+
 		/* We have sent another CMD_AUTHENTICATE / CMD_ASSOCIATE */
 		if (ret == 0 || ret == -EAGAIN)
 			return;
diff --git a/src/netdev.h b/src/netdev.h
index d87f09f4..671d0d40 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -51,6 +51,7 @@ enum netdev_event {
 	NETDEV_EVENT_RSSI_LEVEL_NOTIFY,
 	NETDEV_EVENT_PACKET_LOSS_NOTIFY,
 	NETDEV_EVENT_BEACON_LOSS_NOTIFY,
+	NETDEV_EVENT_ECC_GROUP_RETRY,
 };
 
 enum netdev_watch_event {
diff --git a/src/station.c b/src/station.c
index 3712d5bb..77d4a547 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3456,6 +3456,18 @@ static void station_event_roaming(struct station *station)
 	station_enter_state(station, STATION_STATE_FW_ROAMING);
 }
 
+static void station_ecc_group_retry(struct station *station)
+{
+	struct network *network = station_get_connected_network(station);
+
+	if (L_WARN_ON(!network))
+		return;
+
+	station_debug_event(station, "ecc-group-rejected");
+
+	network_set_force_default_ecc_group(network);
+}
+
 static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
 					void *event_data, void *user_data)
 {
@@ -3497,6 +3509,9 @@ static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
 	case NETDEV_EVENT_BEACON_LOSS_NOTIFY:
 		station_beacon_lost(station);
 		break;
+	case NETDEV_EVENT_ECC_GROUP_RETRY:
+		station_ecc_group_retry(station);
+		break;
 	}
 }
 
-- 
2.34.1

