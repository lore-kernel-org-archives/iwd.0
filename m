Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09543F9E6
	for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOUxaveB"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1dc9c2b2b79so1886835fac.0
        for <iwd@lists.linux.dev>; Mon, 30 Oct 2023 06:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698673730; x=1699278530; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3Gjbrqb/Rmqp4j8t39MW+WhEVN0ovDkDLbWrFkUeD0=;
        b=LOUxaveBb5ngehXpm31F3An5F5JoUIDC6s0xbHmmviHkt21pEx4Z/bYz1P6m+dlUyZ
         fEOseIM/pKxvJ8L3aENI9PxFhzr4tZV1QqVbUK98VKd2etHmAe4z2G1F23jJyrLdZCyv
         LttIiiv1aUjOvhUQZenFrOA6A8C6gdDPjdYhn23YupI5NV/cb0Vm2wsOXMwwATYx7i2v
         YzNjC9yIVT83y1RMxDAj9Mg0XmwiX8Y2XNYcHjnx/o9KIYuHAejPnky9TfPuZPVZVm+v
         CK/jSEL1SRZjMIEFDjXZ3yOmm1yZC+jixy6EsrMx7zSySFY6+NjlETSRR+8yz/RHHapx
         XK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698673730; x=1699278530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3Gjbrqb/Rmqp4j8t39MW+WhEVN0ovDkDLbWrFkUeD0=;
        b=PsHHffaiI+8N2wi6Ja7QatIdBrJHGk85etvaJWN6ry/NZ0BJHURft/zkS9StWOo6GR
         lgooMuWE5LgmlPkM8C80zYoU+frvKybBimOTFnua1qrZBQt0kEEaM9ABKutTaOIv6SW8
         Jx96+vFMA2nLpdQfs4OOAGhrb5Y+zCK0PHXnvHYQStdER5sk8pWj3OeL+4VYwm5SlbBt
         K2O49YyqiuoOtrUPZV1rlg0BLiXLJENbisnavsmCgK3+y1Z6SyrzpEphoR55gguFQs0F
         qsoZhOSm4VcrQlBNTfZT8O5mQS+8s3DUkDGCBb/cSbRimXLmyXMd2dW3VXuQ3nXmya6H
         Caew==
X-Gm-Message-State: AOJu0Yyh3wZ4lNmaDd5rEzN9c8/t/rcZGuYOkcmc/ON1uYDfXsOR9LfW
	DhB0j8eV9GkjTj3uZ1qsVOLWckCbSXU=
X-Google-Smtp-Source: AGHT+IF5YUaUY61wLZ9K0Pn6ja5QiuwJ8wG8tKPaEKxz4q7Vzg2IT44bZnEYkDpY6PtdkdUNfetOeQ==
X-Received: by 2002:a05:6871:70b:b0:1e9:8885:b537 with SMTP id f11-20020a056871070b00b001e98885b537mr9487943oap.41.1698673729778;
        Mon, 30 Oct 2023 06:48:49 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id c18-20020ac86612000000b004181aa90b46sm3419929qtp.89.2023.10.30.06.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 06:48:49 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] station: rate limit packet loss roam scans
Date: Mon, 30 Oct 2023 06:48:37 -0700
Message-Id: <20231030134837.452957-5-prestwoj@gmail.com>
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

The packet loss handler puts a higher priority on roaming compared
to the low signal roam path. This is generally beneficial since this
event usually indicates some problem with the BSS and generally is
an indicator that a disconnect will follow sometime soon.

But by immediately issuing a scan we run the risk of causing many
successive scans if more packet loss events arrive following
the roam scans (and if no candidates are found). Logs provided
further.

To help with this handle the first event with priority and
immediately issue a roam scan. If another event comes in within a
certain timeframe (2 seconds) don't immediately scan, but instead
rearm the roam timer instead of issuing a scan. This also handles
the case of a low signal roam scan followed by a packet loss
event. Delaying the roam will at least provide some time for packets
to get out in between roam scans.

Logs were snipped to be less verbose, but this cycled happened
5 times prior. In total 7 scans were issued in 5 seconds which may
very well have been the reason for the local disconnect:

Oct 27 16:23:46 src/station.c:station_roam_failed() 9
Oct 27 16:23:46 src/wiphy.c:wiphy_radio_work_done() Work item 29 done
Oct 27 16:23:47 src/netdev.c:netdev_mlme_notify() MLME notification Notify CQM(64)
Oct 27 16:23:47 src/station.c:station_packets_lost() Packets lost event: 10
Oct 27 16:23:47 src/station.c:station_roam_scan() ifindex: 9
Oct 27 16:23:47 src/wiphy.c:wiphy_radio_work_insert() Inserting work item 30
Oct 27 16:23:47 src/wiphy.c:wiphy_radio_work_next() Starting work item 30
Oct 27 16:23:47 src/station.c:station_start_roam() Using cached neighbor report for roam
Oct 27 16:23:47 src/scan.c:scan_notify() Scan notification Trigger Scan(33)
Oct 27 16:23:47 src/scan.c:scan_request_triggered() Active scan triggered for wdev a
Oct 27 16:23:47 src/scan.c:scan_notify() Scan notification New Scan Results(34)
Oct 27 16:23:47 src/netdev.c:netdev_link_notify() event 16 on ifindex 9
... scan results ...
Oct 27 16:23:47 src/station.c:station_roam_failed() 9
Oct 27 16:23:47 src/wiphy.c:wiphy_radio_work_done() Work item 30 done
Oct 27 16:23:47 src/netdev.c:netdev_mlme_notify() MLME notification Notify CQM(64)
Oct 27 16:23:47 src/station.c:station_packets_lost() Packets lost event: 10
Oct 27 16:23:47 src/station.c:station_roam_scan() ifindex: 9
Oct 27 16:23:47 src/wiphy.c:wiphy_radio_work_insert() Inserting work item 31
Oct 27 16:23:47 src/wiphy.c:wiphy_radio_work_next() Starting work item 31
Oct 27 16:23:47 src/station.c:station_start_roam() Using cached neighbor report for roam
Oct 27 16:23:47 src/scan.c:scan_notify() Scan notification Trigger Scan(33)
Oct 27 16:23:47 src/scan.c:scan_request_triggered() Active scan triggered for wdev a
Oct 27 16:23:48 src/scan.c:scan_notify() Scan notification New Scan Results(34)
Oct 27 16:23:48 src/netdev.c:netdev_link_notify() event 16 on ifindex 9
... scan results ...
Oct 27 16:23:48 src/station.c:station_roam_failed() 9
Oct 27 16:23:48 src/wiphy.c:wiphy_radio_work_done() Work item 31 done
Oct 27 16:23:48 src/netdev.c:netdev_mlme_notify() MLME notification Notify CQM(64)
Oct 27 16:23:48 src/station.c:station_packets_lost() Packets lost event: 10
Oct 27 16:23:48 src/station.c:station_roam_scan() ifindex: 9
Oct 27 16:23:48 src/wiphy.c:wiphy_radio_work_insert() Inserting work item 32
Oct 27 16:23:48 src/wiphy.c:wiphy_radio_work_next() Starting work item 32
Oct 27 16:23:48 src/station.c:station_start_roam() Using cached neighbor report for roam
Oct 27 16:23:48 src/scan.c:scan_notify() Scan notification Trigger Scan(33)
Oct 27 16:23:48 src/scan.c:scan_request_triggered() Active scan triggered for wdev a
Oct 27 16:23:49 src/netdev.c:netdev_link_notify() event 16 on ifindex 9
Oct 27 16:23:49 src/netdev.c:netdev_mlme_notify() MLME notification Del Station(20)
Oct 27 16:23:49 src/netdev.c:netdev_mlme_notify() MLME notification Deauthenticate(39)
Oct 27 16:23:49 src/netdev.c:netdev_deauthenticate_event()
Oct 27 16:23:49 src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
Oct 27 16:23:49 src/netdev.c:netdev_disconnect_event()
Oct 27 16:23:49 Received Deauthentication event, reason: 4, from_ap: false
---
 src/station.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 8c87b3e0..bab690b9 100644
--- a/src/station.c
+++ b/src/station.c
@@ -123,6 +123,8 @@ struct station {
 
 	struct wiphy_radio_work_item ft_work;
 
+	uint64_t last_roam_scan;
+
 	bool preparing_roam : 1;
 	bool roam_scan_full : 1;
 	bool signal_low : 1;
@@ -1708,6 +1710,7 @@ static void station_roam_state_clear(struct station *station)
 	station->signal_low = false;
 	station->roam_min_time.tv_sec = 0;
 	station->netconfig_after_roam = false;
+	station->last_roam_scan = 0;
 
 	if (station->roam_scan_id)
 		scan_cancel(netdev_get_wdev_id(station->netdev),
@@ -2711,6 +2714,8 @@ static int station_roam_scan(struct station *station,
 	if (L_WARN_ON(scan_freq_set_isempty(params.freqs)))
 		return -ENOTSUP;
 
+	station->last_roam_scan = l_time_now();
+
 	station->roam_scan_id =
 		scan_active_full(netdev_get_wdev_id(station->netdev), &params,
 					station_roam_scan_triggered,
@@ -3330,10 +3335,13 @@ static void station_disconnect_event(struct station *station, void *event_data)
 	l_warn("Unexpected disconnect event");
 }
 
-#define STATION_PKT_LOSS_THRESHOLD 10
+#define STATION_PKT_LOSS_THRESHOLD	10
+#define LOSS_ROAM_RATE_LIMIT		2
 
 static void station_packets_lost(struct station *station, uint32_t num_pkts)
 {
+	uint64_t elapsed;
+
 	l_debug("Packets lost event: %u", num_pkts);
 
 	if (num_pkts < STATION_PKT_LOSS_THRESHOLD)
@@ -3344,6 +3352,24 @@ static void station_packets_lost(struct station *station, uint32_t num_pkts)
 
 	station_debug_event(station, "packet-loss-roam");
 
+	elapsed = l_time_diff(station->last_roam_scan, l_time_now());
+
+	/*
+	 * If we just issued a roam scan, delay the roam to avoid constant
+	 * scanning.
+	 */
+	if (LOSS_ROAM_RATE_LIMIT > l_time_to_secs(elapsed)) {
+		l_debug("Too many roam attempts in %u second timeframe, "
+			"delaying roam", LOSS_ROAM_RATE_LIMIT);
+
+		if (station->roam_trigger_timeout)
+			return;
+
+		station_roam_timeout_rearm(station, LOSS_ROAM_RATE_LIMIT);
+
+		return;
+	}
+
 	station_start_roam(station);
 }
 
-- 
2.25.1

