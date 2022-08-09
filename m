Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571664A0C
	for <iwd@lists.linux.dev>; Tue,  9 Aug 2022 23:04:42 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id t22so13113844pjy.1
        for <iwd@lists.linux.dev>; Tue, 09 Aug 2022 16:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=w5duT/nPJGlFO14/looRu87ErZukYHkxP7tNj0kPUaA=;
        b=mUJy0Gak4pM9kEs3OUISLmHofoSuBUH9bCQwwOw5/Xk6Oj6VSfRykocoZlSHqBvJao
         +xgOugivD2XauxcR+JE/FY01RW5u3HhwG66BwR82XCq0dBXClsiAA/3Vg0ctnAUHGefr
         sxPqBdRNv47eCCduDYLup3tYbDWEWRdH6/3fT9MyuLanmtsv1CCoxyHJeIjd2BnkKgu5
         5+qoPfzJnji0gaIgXXqXvCO7ndWyjjC5kwsrYeVQDqFE8iYhdl8DSopH1x5FTMSvBiJE
         3E5Vc25tDFOTpCo8NluIr1ar3kQEO6y0PkaCsyDHTbAWF0iSsNl0kQ2irUkhReO5ZBWn
         qJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=w5duT/nPJGlFO14/looRu87ErZukYHkxP7tNj0kPUaA=;
        b=cSh+OSksHKTDl27A8YCdEQirNqxFFVZn/w280U/TWUcEAYXfHyibBNbvunkHSpdat1
         xOFAw8Du/LMS53LpTSM/zrlfIPeNC8o4DEQ7kp9h9hEssbVhn14bim6ZzJdtaMMRXwZW
         Xops7jhF07+fd4Tu3aTdfAJsTK1vDcI81uDwbxar55WWqMfalqUGc48FwAADmLTlIpry
         lKuXtT8l2V+qdB08a/1oxNjKdNQEccjZDeanH/VRRJWwsiBehRHJ5d4q2VhFpITW6KWa
         Y7Dv5C0oq0aFreV4/vPcds+RS/Gg3fiAiftpEzZAGA9pao1PMEEuTyWCTPw5v+zBdT9b
         BV7g==
X-Gm-Message-State: ACgBeo2BT92N4kAdd5cx6OwNUifBmzhY2L6DCfQmtVXXsd3q2AGTUqyk
	WYXNjGAxozG7/cpkn+jtfNWVIkk7Kas=
X-Google-Smtp-Source: AA6agR5kqGd79/wBLb0tpP+ZQcIU5GliYgpRq8ylnYkdktTejA0smWVF1NcEqH6524iJquRQ07HpRg==
X-Received: by 2002:a17:902:8c92:b0:170:aff6:e3a6 with SMTP id t18-20020a1709028c9200b00170aff6e3a6mr10472136plo.164.1660086281617;
        Tue, 09 Aug 2022 16:04:41 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w13-20020a62820d000000b0052d748498edsm459063pfd.13.2022.08.09.16.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 16:04:41 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>,
	mjohnson459@gmail.com
Subject: [RFC 1/4] station: react to (new) netdev packet loss event
Date: Tue,  9 Aug 2022 16:04:25 -0700
Message-Id: <20220809230428.215970-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220809230428.215970-1-prestwoj@gmail.com>
References: <20220809230428.215970-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a new netdev event for packet loss notifications from
the kernel. Depending on the scenario a station may see packet
loss events without any other indications like low RSSI. In these
cases IWD should still roam since there is no data flowing.
---
 src/netdev.h  |  1 +
 src/station.c | 39 +++++++++++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/src/netdev.h b/src/netdev.h
index f093c499..d13bc5e6 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -49,6 +49,7 @@ enum netdev_event {
 	NETDEV_EVENT_RSSI_THRESHOLD_LOW,
 	NETDEV_EVENT_RSSI_THRESHOLD_HIGH,
 	NETDEV_EVENT_RSSI_LEVEL_NOTIFY,
+	NETDEV_EVENT_PACKET_LOSS_NOTIFY,
 };
 
 enum netdev_watch_event {
diff --git a/src/station.c b/src/station.c
index b9038431..458c6ee2 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2535,15 +2535,10 @@ static void station_neighbor_report_cb(struct netdev *netdev, int err,
 		station_roam_failed(station);
 }
 
-static void station_roam_trigger_cb(struct l_timeout *timeout, void *user_data)
+static void station_start_roam(struct station *station)
 {
-	struct station *station = user_data;
 	int r;
 
-	l_debug("%u", netdev_get_ifindex(station->netdev));
-
-	l_timeout_remove(station->roam_trigger_timeout);
-	station->roam_trigger_timeout = NULL;
 	station->preparing_roam = true;
 
 	/*
@@ -2577,6 +2572,18 @@ static void station_roam_trigger_cb(struct l_timeout *timeout, void *user_data)
 		station_roam_failed(station);
 }
 
+static void station_roam_trigger_cb(struct l_timeout *timeout, void *user_data)
+{
+	struct station *station = user_data;
+
+	l_debug("%u", netdev_get_ifindex(station->netdev));
+
+	l_timeout_remove(station->roam_trigger_timeout);
+	station->roam_trigger_timeout = NULL;
+
+	station_start_roam(station);
+}
+
 static void station_roam_timeout_rearm(struct station *station, int seconds)
 {
 	struct timespec now, min_timeout;
@@ -3057,6 +3064,23 @@ static void station_disconnect_event(struct station *station, void *event_data)
 	l_warn("Unexpected disconnect event");
 }
 
+#define STATION_PKT_LOSS_THRESHOLD 10
+
+static void station_packets_lost(struct station *station, uint32_t num_pkts)
+{
+	l_debug("Packets lost event: %u", num_pkts);
+
+	if (num_pkts < STATION_PKT_LOSS_THRESHOLD)
+		return;
+
+	if (station_cannot_roam(station))
+		return;
+
+	station_debug_event(station, "packet-loss-roam");
+
+	station_start_roam(station);
+}
+
 static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
 					void *event_data, void *user_data)
 {
@@ -3092,6 +3116,9 @@ static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
 	case NETDEV_EVENT_CHANNEL_SWITCHED:
 		station_event_channel_switched(station, l_get_u32(event_data));
 		break;
+	case NETDEV_EVENT_PACKET_LOSS_NOTIFY:
+		station_packets_lost(station, l_get_u32(event_data));
+		break;
 	}
 }
 
-- 
2.34.3

