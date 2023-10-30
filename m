Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C06F9E6
	for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejbHbgAf"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-41cd8bd5727so30328701cf.3
        for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 06:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698673726; x=1699278526; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvBixF0OuY0BLthWm479TL27u1v2r+Vng/YDZCMRjtw=;
        b=ejbHbgAffsZDzodM9TcYMP8ufsQaY3W2ohYirbJbldrIluAlVosSBL+0wdnJG8GnfA
         H5tu7jKd/hvG9pjVdYMqMkWkewN0s3w/sgI+d/lKnkkqJ7Y93L8rFheZqAJl08i1Z2nT
         ce+V96rfUXjG6lXSwFaX1lqa5Et2vy8mbwbS8KeTxnlvhY8Cw1cgJYO6JbmpUp1bVYM0
         m5PsFl6tb4gQEVCl/rZclGD/WjaeYVbsxNN+0E9jQohGR26wyjF7fXUWoJoAG56tUPOo
         8tDVGEfloZNHiND8lCKveCz5t8mib37sowwdBPm3OdiUyso0L/ybb50ED0h3AhVg5gPy
         OIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698673726; x=1699278526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvBixF0OuY0BLthWm479TL27u1v2r+Vng/YDZCMRjtw=;
        b=kKpQyI1Q9e1L/UQUV38ZxKKaE2AOBUXNl8XKFeXfI6W8/CXRmurKYOI0hLDiN8NXIV
         WnBG3jN+EG6dsFHVsu3atcqXtB6atsPxXJybrAlRq0hx0IOANHjCPd8i+cJO1/IKgkQU
         mz9IZorX79+CQ+4JDqv9jyFU9w8r3nN46FpXPshO4yFgrCnt/dtzWUtxPODQzfda9lZ9
         0HmD4WkiKA9ccpo/1Ol11O/kcDaj1kC7mlxYD/B6CSqg87PEmwGsCXIx4pJiKpQa0kFH
         LFBZ4GSMaKroHJE4mAbZ4n9J0WlWqy300Olrs8FwMTQ1iY+Bnb1hdTvEkqI2EC4EzIKx
         QDOw==
X-Gm-Message-State: AOJu0YwgirPPKGanmiCFaGO4vvQQS7JfwxDfTgGZdv6sooQKS32i2ujw
	la6HOIe7X2wPEb1CrxLu9X7CrhiT5rg=
X-Google-Smtp-Source: AGHT+IHqc1+8C+Vif8VsFBtpmk2bTyiKeMX3eOc5BuurGztDPM7MluDNplKQqpz8C9E1Ji9UH3+3Uw==
X-Received: by 2002:ac8:594a:0:b0:41e:172f:6e78 with SMTP id 10-20020ac8594a000000b0041e172f6e78mr12667960qtz.29.1698673726299;
        Mon, 30 Oct 2023 06:48:46 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id c18-20020ac86612000000b004181aa90b46sm3419929qtp.89.2023.10.30.06.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 06:48:46 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] station: start roam on beacon loss event
Date: Mon, 30 Oct 2023 06:48:35 -0700
Message-Id: <20231030134837.452957-3-prestwoj@gmail.com>
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

In past testing the beacon loss event seemed to always be followed
immediately by a disconnect. It was determined at the time that there
wasn't much point in even attempting a roam because a disconnect
would happen before the roam could finish. This was a bit short
sighted because its hardware dependent when the beacon loss event
is sent.

Recently it was seen that some hardware (ath10k in this case)
actually gives some time before the kernel finally disconnects.
In this example a beacon loss event came and IWD remained connected
for 4 seconds (until a packet loss which issued a roam scan).

11:30:25 iwd[1407046]: src/netdev.c:netdev_cqm_event() Beacon lost event
11:30:29 iwd[1407046]: src/netdev.c:netdev_mlme_notify() MLME notification Notify CQM(64)
11:30:29 iwd[1407046]: src/station.c:station_packets_lost() Packets lost event: 10
11:30:29 iwd[1407046]: src/station.c:station_roam_scan() ifindex: 6
11:30:29 iwd[1407046]: src/wiphy.c:wiphy_radio_work_insert() Inserting work item 144
11:30:29 iwd[1407046]: src/wiphy.c:wiphy_radio_work_next() Starting work item 144
11:30:29 iwd[1407046]: src/station.c:station_start_roam() Using cached neighbor report for roam
11:30:29 iwd[1407046]: src/scan.c:scan_notify() Scan notification Trigger Scan(33)
11:30:29 iwd[1407046]: src/scan.c:scan_request_triggered() Active scan triggered for wdev 4
11:30:29 iwd[1407046]: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
11:30:29 iwd[1407046]: src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
11:30:29 iwd[1407046]: src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
11:30:29 iwd[1407046]: src/netdev.c:netdev_deauthenticate_event()
11:30:29 iwd[1407046]: src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
11:30:29 iwd[1407046]: src/netdev.c:netdev_disconnect_event()
11:30:29 iwd[1407046]: Received Deauthentication event, reason: 4, from_ap: false

It makes sense to also handle beacon loss events and attempt a
roam, potentially saving the connection. One difference here is
the beacon loss event will force a roam (similar to ap directed
roaming when the imminent bit is set).
---
 src/netdev.h  |  1 +
 src/station.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/src/netdev.h b/src/netdev.h
index 73d38c32..f27130f1 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -51,6 +51,7 @@ enum netdev_event {
 	NETDEV_EVENT_RSSI_LEVEL_NOTIFY,
 	NETDEV_EVENT_PACKET_LOSS_NOTIFY,
 	NETDEV_EVENT_FT_ROAMED,
+	NETDEV_EVENT_BEACON_LOSS_NOTIFY,
 };
 
 enum netdev_watch_event {
diff --git a/src/station.c b/src/station.c
index a2358d95..8c87b3e0 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3347,6 +3347,20 @@ static void station_packets_lost(struct station *station, uint32_t num_pkts)
 	station_start_roam(station);
 }
 
+static void station_beacon_lost(struct station *station)
+{
+	l_debug("Beacon lost event");
+
+	if (station_cannot_roam(station))
+		return;
+
+	station->force_roam = true;
+
+	station_debug_event(station, "beacon-loss-roam");
+
+	station_start_roam(station);
+}
+
 static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
 					void *event_data, void *user_data)
 {
@@ -3391,6 +3405,9 @@ static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
 
 		station_roamed(station);
 		break;
+	case NETDEV_EVENT_BEACON_LOSS_NOTIFY:
+		station_beacon_lost(station);
+		break;
 	}
 }
 
-- 
2.25.1

