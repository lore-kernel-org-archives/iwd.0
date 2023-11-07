Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC09A30F88
	for <iwd@lists.linux.dev>; Tue,  7 Nov 2023 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6Bb/fdN"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-77774120c6eso361748985a.2
        for <iwd@lists.linux.dev>; Tue, 07 Nov 2023 06:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699366304; x=1699971104; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xlgQMJEMGYSVnfmuhVEVa9nQtXnHsubVQpyrEa3fWQU=;
        b=d6Bb/fdNkx+VWNdff9c8toaQg/u1aRkq67Nf6qOSXqGahetoAVQRUeUOOSNsaQBIwn
         GSc7/7Tl/c5LZ/6zRmAbIdOTeMQs1nHWHpZX4zPI9HtBD/LbBH+f1M0EACA6CJw9fwxt
         UBC2P/V4bF+tDC1p9AaRvN2h5KUYzszaxeJ6Jq9PMWpWmYP77TiyxVVUJrJTm3skRpSO
         VDqVojtEAwRhO5FKxfjAlKQ4DGlio7ZOMTyqc3uczK9wDBKStn6BceaLERNZxBgzEJt/
         ULtmU63uUO+b0R0RxdzpE+iJdLWxKJ+5FeTnJXCmB46NkeyER1B7gx15dmch80DQ7CJO
         VmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699366304; x=1699971104;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xlgQMJEMGYSVnfmuhVEVa9nQtXnHsubVQpyrEa3fWQU=;
        b=kxRFlARNrILYJ21AHCNHPR+/YBrFPy8lCEbR9hqJ9q+RdVBB8uRbmzcTqz3c0ZMJ7a
         tPcgZUdstrEN7XPTih1iyFTmwS2M7NJRAShMOXNpSkba6KsnyE0VdiDlDdXApfxNh9wO
         xV4bq5PNiPK238/MyR2TS396j8pTCspmdGmjodaGHxvCU6TwBLAHS1+7+tCIvkw/NbTV
         iEslxYZ7ehvk3FX42GkJUeJGF+v8RG4FTMjvwRE6587h73hs7fN3R3/jXHmF4V9vLWwV
         K7yEreMsvN7JAhPgNWXhnNdBS9DT/txrh/pErvDHiOlRqbDsKcxyxSZ+o4fEdrA2lPUd
         yz+w==
X-Gm-Message-State: AOJu0YySokATq5AlqwnuGxKIiPLChTmIE7CHY9ZGeGEi0mIPEKeSNLvf
	+TNqqnogYdOZ6SnAqu0bkjpGrzvIzY4=
X-Google-Smtp-Source: AGHT+IF1chdUAXpFFGsNk3EjFHCXPZ34CB1pJv7PzlMRQUrnTYOo0jM2cAnCVP7wjLQkY1Um4MjFdQ==
X-Received: by 2002:a05:620a:28c5:b0:774:30b7:ed93 with SMTP id l5-20020a05620a28c500b0077430b7ed93mr39173188qkp.29.1699366304590;
        Tue, 07 Nov 2023 06:11:44 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id b7-20020a05620a04e700b00765aa3ffa07sm4204890qkh.98.2023.11.07.06.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 06:11:44 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/2] station: start roam on beacon loss event
Date: Tue,  7 Nov 2023 06:11:39 -0800
Message-Id: <20231107141140.1706441-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Beacon loss handling was removed in the past because it was
determined that this even always resulted in a disconnect. This
was short sighted and not always true. The default kernel behavior
waits for 7 lost beacons before emitting this event, then sends
either a few nullfuncs or probe requests to the BSS to determine
if its really gone. If these come back successfully the connection
will remain alive. This can give IWD some time to roam in some
cases so we should be handling this event.

Since beacon loss indicates a very poor connection the roam scan
is delayed by a few seconds in order to give the kernel a chance
to send the nullfuncs/probes or receive more beacons. This may
result in a disconnect, but it would have happened anyways.
Attempting a roam mainly handles the case when the connection can
be maintained after beacon loss, but is still poor.
---
 src/netdev.h  |  1 +
 src/station.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

v2:
 * Delay the roam to give the kernel a chance to salvage the
   connection

FYI, I did attempt to add back the beacon loss test without much
luck. Blocking beacons with hwsim did not result in a beacon loss
event which may have been one of the reasons it was removed in the
first place. Even blocking _all_ frames doesn't result in an event
but instead just a local disconnect.

After looking more into it I see that actually only a few drivers
even use ieee80211_beacon_loss/ieee80211_connection_loss:

iwlwifi,wl1251,intersil,mt76,wfx,ath10/11k,wcn36xx

Every other driver likely disconnects rather than attempts to
handle beacon loss. So probably for the majority of users this
actually didn't matter, but for these drivers it does make sense
to handle the event.

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
index 5a202ebd..c3f26b5a 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3370,6 +3370,21 @@ static void station_packets_lost(struct station *station, uint32_t num_pkts)
 	station_start_roam(station);
 }
 
+static void station_beacon_lost(struct station *station)
+{
+	l_debug("Beacon lost event");
+
+	if (station_cannot_roam(station))
+		return;
+
+	station_debug_event(station, "beacon-loss-roam");
+
+	if (station->roam_trigger_timeout)
+		return;
+
+	station_roam_timeout_rearm(station, LOSS_ROAM_RATE_LIMIT);
+}
+
 static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
 					void *event_data, void *user_data)
 {
@@ -3414,6 +3429,9 @@ static void station_netdev_event(struct netdev *netdev, enum netdev_event event,
 
 		station_roamed(station);
 		break;
+	case NETDEV_EVENT_BEACON_LOSS_NOTIFY:
+		station_beacon_lost(station);
+		break;
 	}
 }
 
-- 
2.25.1
