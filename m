Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CF212FB0A
	for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 11:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303127; cv=none; b=GTIpCHKm8SxnWLhJXItchR+17nKoYjB0+GqjO1Fv4/+bDTkNxQOPWguJUY5jqJNetSxBZiOUtGDzRaBDzSkagPUP6JzjcRIad7w8lJtvx9F5xN3nTcGu4fnIfqvTdX8YWcqlwoBtNJO5y+PdMhf+Y+A5GSnP4lcU9vs69+hm2j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303127; c=relaxed/simple;
	bh=SlFNNFuF6eChmtPDA34jZcaRxqUKmN1ZUmJrp4u0G4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D+I+UvdZfvnhoOblZHKBGIDKLpazb/a9HP3w1RkQhejdYbhOOFQYtQqB+eTXjuFNqc+EOkjZtPeNBfmc2ov7rETO2ziMDFJiz06chKpqQpP9TVNzxEIUQEnhxmOsmfMqRpbrVZAnDSXI0d5ZStmYD8Qn3+iyNtdKGwOgtv3aNks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqxTn1Qq; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqxTn1Qq"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e026a2238d8so741720276.0
        for <iwd@lists.linux.dev>; Thu, 18 Jul 2024 04:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721303124; x=1721907924; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sx3fRRnExPI828g4V9j8aSQ8ixzMKUs5b6fnOjrfq0=;
        b=FqxTn1QqO0YGAkhlDIz4hnXxXJKQdDA2K2Fd34oRdSb9bo9ZTlAup359BKoexfZlgQ
         pV864LvCQM1tQ3FNpmaueP49KW6zuf+iXEB6iyCDnLlFOnDIczb4F9tZSiwYa3/PRGgA
         X8s7UNUuq+15ibJG41b50ckYYz7rasUNRXt/LwNatCgQnmA/adAakL/xCVpLdNq703Dz
         fZ2cDjcRxgUyIxYxjc2JPtH+cCdNVmWNQqokfSCpj5cMdstW/ZvKYNasCRPNwkrnXMpP
         536ZMn68dwRNskfPOZVqkxpLn6UFZRGW0SVTjZCVjdurMh3JadceKbEX49ur8ezz6F7r
         xCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721303124; x=1721907924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sx3fRRnExPI828g4V9j8aSQ8ixzMKUs5b6fnOjrfq0=;
        b=XUbJBWwDcNLZh3vnCr2frJX7zRGCVTCZfTEaLliLe+zWe3b8bF69oQis9jYiK7sHfy
         K7uqtNlZkBz+XSGd9px0QEmnhRy3G2KSlkJcNYjpjg3LOsK6adqQnCtXujmqdKdMJT8l
         uIjKFt/SmuUNZ5Rw231X3NUnq85du9BXFIqcQI0JdvJO6uvk83oXpPbLkhO42TiRVmUg
         0x79SWMG2yUkH4Hdo3Q3eGAljsyYZV1N3YHlKyFhuQZNJFECM4Z04wHXl6r0y7/kF1kv
         +B62atJ6r6rJxZ3gfimnxUh6CKGDgH+HBQeuZ7gVh5tjHKoq6Ie6/K/dO9j0SGPpkYJX
         XwJA==
X-Gm-Message-State: AOJu0YyjOJMUbF2qbI2U6k5+ZFlO7QZTAsJWypNjGq739Xxn8df92r0T
	YVImYAMRPS6gKoUYkfaBPPk4JLDvSoeYOUnAR7kpO3wB8ibMdgnJ+Doq8g==
X-Google-Smtp-Source: AGHT+IGkfGZifAiJPCRqYkBvPhOq4NYnRWnPy4nQ7FnROeyxVrszjyA2MrkFeV4w0kugcOIeKq2Hxg==
X-Received: by 2002:a05:6902:124a:b0:e08:551c:9305 with SMTP id 3f1490d57ef6-e08551c9789mr877443276.47.1721303124213;
        Thu, 18 Jul 2024 04:45:24 -0700 (PDT)
Received: from LOCLAP699.localdomain ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b79c5138bbsm7292006d6.61.2024.07.18.04.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 04:45:23 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 05/11] netdev: handle disconnect event during a connection
Date: Thu, 18 Jul 2024 04:45:08 -0700
Message-Id: <20240718114514.2916258-6-prestwoj@gmail.com>
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

If a disconnect arrives at any point during the 4-way handshake or
key setting this would result in netdev sending a disconnect event
to station. If this is a reassociation this case is unhandled in
station and causes a hang as it expects any connection failure to
be handled via the reassociation callback, not a random disconnect
event.

To handle this case we can utilize netdev_disconnected() along with
the new NETDEV_RESULT_DISCONNECTED result to ensure the connect
callback gets called if it exists (indicating a pending connection)

Below are logs showing the "Unexpected disconnect event" which
prevents IWD from cleaning up its state and ultimately results in a
hang:

Jul 16 18:16:13: src/station.c:station_transition_reassociate()
Jul 16 18:16:13: event: state, old: connected, new: roaming
Jul 16 18:16:13: src/wiphy.c:wiphy_radio_work_done() Work item 65 done
Jul 16 18:16:13: src/wiphy.c:wiphy_radio_work_next() Starting work item 66
Jul 16 18:16:13: src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
Jul 16 18:16:13: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
Jul 16 18:16:13: src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
Jul 16 18:16:13: src/netdev.c:netdev_deauthenticate_event()
Jul 16 18:16:13: src/netdev.c:netdev_mlme_notify() MLME notification New Station(19)
Jul 16 18:16:13: src/station.c:station_netdev_event() Associating
Jul 16 18:16:13: src/netdev.c:netdev_mlme_notify() MLME notification Authenticate(37)
Jul 16 18:16:13: src/netdev.c:netdev_authenticate_event()
Jul 16 18:16:13: src/netdev.c:netdev_mlme_notify() MLME notification Associate(38)
Jul 16 18:16:13: src/netdev.c:netdev_associate_event()
Jul 16 18:16:13: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
Jul 16 18:16:13: src/netdev.c:netdev_mlme_notify() MLME notification Connect(46)
Jul 16 18:16:13: src/netdev.c:netdev_connect_event()
Jul 16 18:16:13: src/netdev.c:netdev_connect_event() aborting and ignore_connect_event not set, proceed
Jul 16 18:16:13: src/netdev.c:netdev_connect_event() expect_connect_failure not set, proceed
Jul 16 18:16:13: src/netdev.c:parse_request_ies()
Jul 16 18:16:13: src/netdev.c:netdev_connect_event() Request / Response IEs parsed
Jul 16 18:16:13: src/netdev.c:netdev_get_oci()
Jul 16 18:16:13: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
Jul 16 18:16:13: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
Jul 16 18:16:13: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
Jul 16 18:16:13: src/netdev.c:netdev_get_oci_cb() Obtained OCI: freq: 5220, width: 3, center1: 5210, center2: 0
Jul 16 18:16:13: src/eapol.c:eapol_start()
Jul 16 18:16:13: src/netdev.c:netdev_unicast_notify() Unicast notification Control Port Frame(129)
Jul 16 18:16:13: src/netdev.c:netdev_control_port_frame_event()
Jul 16 18:16:13: src/eapol.c:eapol_handle_ptk_1_of_4() ifindex=6
Jul 16 18:16:13: src/netdev.c:netdev_mlme_notify() MLME notification Control Port TX Status(139)
Jul 16 18:16:14: src/netdev.c:netdev_mlme_notify() MLME notification Notify CQM(64)
Jul 16 18:16:14: src/netdev.c:netdev_cqm_event() Signal change event (above=1 signal=-60)
Jul 16 18:16:17: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
Jul 16 18:16:17: src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
Jul 16 18:16:17: src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
Jul 16 18:16:17: src/netdev.c:netdev_deauthenticate_event()
Jul 16 18:16:17: src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
Jul 16 18:16:17: src/netdev.c:netdev_disconnect_event()
Jul 16 18:16:17: Received Deauthentication event, reason: 15, from_ap: true
Jul 16 18:16:17: src/wiphy.c:wiphy_radio_work_done() Work item 66 done
Jul 16 18:16:17: src/station.c:station_disconnect_event() 6
Jul 16 18:16:17: Unexpected disconnect event
Jul 16 18:16:17: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
Jul 16 18:16:17: src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
Jul 16 18:16:17: src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for (global) is XX
---
 src/netdev.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 153001ab..2d70fc38 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1243,8 +1243,7 @@ static void netdev_disconnect_event(struct l_genl_msg *msg,
 	const void *data;
 	uint16_t reason_code = 0;
 	bool disconnect_by_ap = false;
-	netdev_event_func_t event_filter;
-	void *event_data;
+	enum netdev_event event;
 
 	l_debug("");
 
@@ -1282,19 +1281,11 @@ static void netdev_disconnect_event(struct l_genl_msg *msg,
 	l_info("Received Deauthentication event, reason: %hu, from_ap: %s",
 			reason_code, disconnect_by_ap ? "true" : "false");
 
-	event_filter = netdev->event_filter;
-	event_data = netdev->user_data;
-	netdev_connect_free(netdev);
+	event = disconnect_by_ap ? NETDEV_EVENT_DISCONNECT_BY_AP :
+				NETDEV_EVENT_DISCONNECT_BY_SME;
 
-	if (!event_filter)
-		return;
-
-	if (disconnect_by_ap)
-		event_filter(netdev, NETDEV_EVENT_DISCONNECT_BY_AP,
-						&reason_code, event_data);
-	else
-		event_filter(netdev, NETDEV_EVENT_DISCONNECT_BY_SME,
-						&reason_code, event_data);
+	netdev_disconnected(netdev, NETDEV_RESULT_DISCONNECTED,
+				event, reason_code);
 }
 
 static void netdev_cmd_disconnect_cb(struct l_genl_msg *msg, void *user_data)
-- 
2.34.1

