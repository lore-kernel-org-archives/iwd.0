Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A643181311
	for <iwd@lists.linux.dev>; Wed, 17 Jul 2024 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721224845; cv=none; b=NDB78GM3c9DOzp2IsrqVq+5wbqVSm/QiINHANwKC+eig5EE3PehUxRNIxNEfjojmYvJndYE5yEno/M/ml/pU3pQcQ9Kj/6+epwM/CdY4S56Ux1scH6nd5PUZjYtHzkZo61pJzGeVy2PXtJ2c0pa5pqBHngmHdJEQMfHJmg5ZCGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721224845; c=relaxed/simple;
	bh=cCsHgV8WDXYVCih+4qwcuZvAoj1JFnYsdwtzlaX/3tE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NbJHCiTUGPtE9/PUL5mJnaobGaFj07EuIsa/Agl2deSrC4TYaz35sTwTENzd+74PhbFoDai3MBFgqgzBIF25yrgmDupcE0rXGPg+1i1ZPiEG0bzdbtS26DLRzPONzO60Ku52zlVAAZvCugtxqpYWVxoNFeLx2zZXzHMhU0xmBZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4Kd0tX2; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4Kd0tX2"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-79f08b01ba6so71818085a.0
        for <iwd@lists.linux.dev>; Wed, 17 Jul 2024 07:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721224843; x=1721829643; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pfr/GCpfKxCAelDwcRewfzmzaZSCStziFEG6XlEtMdA=;
        b=P4Kd0tX2Dke0F8TBwnowIbPuSPXsgPSrMf/zCwf/uBe/pP2+yoNwGxs1/WKRA8WEtK
         XtdwtRvenQlABV1ikOL8rJVJymYQbfKFbt5U0oCOwJpn5x2Yd3s8otX9VZwcXzfT6Cm1
         SHY0hwO++p9ZQN5G917lMxVLfBxhPb7UE+hDnz1aIrlFV7cm6TLe74XvpDaevQLFP37g
         ug2tt4n/DqGVXWkSGgfewS3dmkBdTWhDfXjbDWnHa/QNN6t4gherwjEXB4duN3i5B3S9
         9UAEYjfEqYTVImoxZSDEWhf3WNpq5DoghGqFJcLyjLF9rLjnrBEyDJQwpPegwiMKpetT
         yEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721224843; x=1721829643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pfr/GCpfKxCAelDwcRewfzmzaZSCStziFEG6XlEtMdA=;
        b=F/RUbjZDysKpgoF2+ELrC2l1IRtNEj72oU2Q6ycXCDLnq1nJQbXdzrx9mfpI0WqsH8
         SQTfhrzHsxuP0+AAkdmv9wE6A61GnPN+OZjVfZCcuZy/ry9DI/dGYb1Jof5GdYiNEMHx
         liWeeG5TAVPBjyP2nwbIED6yRYutahT6LvrY1YlI/nHcCsPPBh7EtUi7Po4xdofzbQx8
         pN2LIk/8fkO5DbnfcMqF5OXedEhfnpBwQzgLIDGBPjefV/7jb+NF4RtmfWsBEDERTQF4
         lptTVwwW1AqZvAV7UFL1lfQrinLPO8hz02L5pjMbbAT2maUlK8ubjgrT9q36N44AR5JI
         2AFA==
X-Gm-Message-State: AOJu0YwoVs4W53nrxnlr3H09l5ivXF+s7fX02EnyZqhXBDTpafL6Pu25
	boeeVecF/8TufPXZonL1Ixe6JbK/49NvLL6/8Wg39lV8At5jyd3WnPddTA==
X-Google-Smtp-Source: AGHT+IFJzuwSJFN9dIHcD7fzZ4JOx1jvdzS3/cBKTNOrS6iiD2T6szHU9lB1OhNjl1jhMQgZt428+Q==
X-Received: by 2002:a05:620a:179f:b0:79f:c5d:2177 with SMTP id af79cd13be357-7a17ccfdfd5mr877440285a.34.1721224814642;
        Wed, 17 Jul 2024 07:00:14 -0700 (PDT)
Received: from LOCLAP699.localdomain ([50.78.19.50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160bbe839sm403383885a.40.2024.07.17.07.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 07:00:14 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] netdev: handle disconnect event during the 4-way handshake
Date: Wed, 17 Jul 2024 07:00:09 -0700
Message-Id: <20240717140009.2648885-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a disconnect arrives during the 4-way handshake this would result
in netdev sending a disconnect event to station. If this is a
reassociation this case is unhandled in station and causes a hang as
it expects any connection failure to be handled via the reassociation
callback, not a random disconnect event.

To handle this case the disconnect event can check if there is a
pending connect callback and call that instead of the event handler.

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
 src/netdev.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index 7a335894..c6be05b5 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1270,6 +1270,8 @@ static void netdev_disconnect_event(struct l_genl_msg *msg,
 	uint16_t reason_code = 0;
 	bool disconnect_by_ap = false;
 	netdev_event_func_t event_filter;
+	netdev_connect_cb_t connect_cb;
+	void *user_data;
 	void *event_data;
 
 	l_debug("");
@@ -1310,9 +1312,20 @@ static void netdev_disconnect_event(struct l_genl_msg *msg,
 
 	event_filter = netdev->event_filter;
 	event_data = netdev->user_data;
+	connect_cb = netdev->connect_cb;
+	user_data = netdev->user_data;
 	netdev_connect_free(netdev);
 
-	if (!event_filter)
+	/*
+	 * If a deauth frame come in after the connect event during the 4-way
+	 * handshake we need to handle this via the connect callback since its
+	 * still effectively a connection failure.
+	 */
+	if (connect_cb) {
+		connect_cb(netdev, NETDEV_RESULT_AUTHENTICATION_FAILED,
+				&reason_code, user_data);
+		return;
+	} else if (!event_filter)
 		return;
 
 	if (disconnect_by_ap)
-- 
2.34.1

