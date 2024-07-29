Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4631487C4
	for <iwd@lists.linux.dev>; Mon, 29 Jul 2024 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257064; cv=none; b=EW3r9tBK5D0UlbGQp8Gp0Brnp7EmlVQXDTSTSVeuk+B6QW4GcEJ/s0+DJ0qVQx5gZTXccG0QlXnl+QTN9k3mq0J8A1SPamVjfOX352ij0IdyZbQRnPI5pGNEJrf0UPkHv7G+irltW5W+WgUWMHCbP59VspEWH7v1/1q1EReMtzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257064; c=relaxed/simple;
	bh=wx1bXoyiUu/0XlF32T0pmCEjxlwxHbUUPu/AgHpeR+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nNmBw+6i3JCcK1ctRryR5cTM4JRktR6IRKIh+EPTdXfHOzUt+vcKNGt611vsmp1NwMgk7cQXEl87Pye7wbK9QDgixH4iLc44zZRQhaMTb25x8K6xHx87YBrB+psUGn29JAtzXwiI2TmZYwoa+1qGJzIUp1dXN54COSc64vAvgzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsS2VXwS; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsS2VXwS"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-661369ff30aso17439867b3.2
        for <iwd@lists.linux.dev>; Mon, 29 Jul 2024 05:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722257062; x=1722861862; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9rq7h3IBjpITtbFjil7bJuaDsith8FK5pmZ39rQk5Rs=;
        b=SsS2VXwSGER27yWbMW0MK1RgdzaUAO98ZLEvRTD8T3E92x3wbcrd5ARaXPtOkXXgVR
         atqd+jldZrXLkBVh7L1jSxHyH4HzY9fjt2UjrFKLYds7TrQ7gNzJw1EQnrgOFg982aH8
         JZVbeVdy2Ctb3kRbUEj0pjYPt87iLziBAF5Kb4IaZ1PdzXYl+AhztjoFC+/TUND15skB
         sOaDnA+fFudLTlJrxaZqC4Tm8NzODRD6Fzv+bHQlFsMzq2jcUE7uWJBG2SGNdvdyDkfg
         mLaSWCPpjd5kXlBtBagjFiKAoQARJ6ul+Lngl3D4c6B2onxJCpXuB0Fapu4N+jyp/PWs
         yr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722257062; x=1722861862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rq7h3IBjpITtbFjil7bJuaDsith8FK5pmZ39rQk5Rs=;
        b=cKb/oz+htXnUlci3rlfUqmgWRDIYZppF0+8M+erOIDuSsb/zAzdmNSt4YLgyT4gGgH
         WTl+LsKCu/FKkF/mmLI3bA8vp9IzbX15XMmKjiTLsHiv4Tm1rqdmRQ7eRPyQjHBJpqrD
         ctR70Rkrp2ycEQVoFoQ4S20KJfft5vkGeGjHTfjvsdn95jg9PX5HBOjn0kp3MDtAVYrl
         wR24CAqTH12d09zpuL62l1IEg7RGHhPxvGJjF+/LygohmiO2OLnW+ExPLl06cUWlwZ+B
         17C0gcHgW7Fchr/zRA3MCcRnhVELzyoD6puAQrZZXN25FEK7sRj3gEY4biRzX1NoHWJd
         K9rA==
X-Gm-Message-State: AOJu0YxlR20gvrD3RX5Pgbx2lh/PX1MjwW3jtGx6dC+U07xJTTLM3Por
	E0iuOuGdAhh+66kl2uNAxjlmA1VNvwJ5kkqfwGi6++bV4LpltSN6n4vCBg==
X-Google-Smtp-Source: AGHT+IH5xDCgJiMqYhltVb/lU4NGniFvWwxyQOmGlhpVom8bM0v+1NIbUL/NdQYD+mTr+230SrjK9g==
X-Received: by 2002:a0d:c806:0:b0:64b:52e8:4ae3 with SMTP id 00721157ae682-67a053e06d6mr82685067b3.3.1722257062078;
        Mon, 29 Jul 2024 05:44:22 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8d84edsm51171266d6.14.2024.07.29.05.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:44:21 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/6] station: add {Set,Unset}ConnectedBssAffinity DBus methods
Date: Mon, 29 Jul 2024 05:44:08 -0700
Message-Id: <20240729124410.1763549-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729124410.1763549-1-prestwoj@gmail.com>
References: <20240729124410.1763549-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These methods can be used to loosly lock IWD to its current BSS.
Calling SetConnectedBssAffinity() will lower the roaming threshold
to a critical level ([General].CriticalRoamThreshold) thereby
preventing IWD from trying to roam unless the RSSI reaches this
level.

The motivation for this is a use case in which an external
client/daemon has additional information about the environment and
can use this to make an informed decision about roaming. For example
if the device is stationary its unlikely IWD will find a better roam
target.
---
 src/station.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/src/station.c b/src/station.c
index db069981..dc07bacc 100644
--- a/src/station.c
+++ b/src/station.c
@@ -128,6 +128,8 @@ struct station {
 
 	uint64_t last_roam_scan;
 
+	unsigned int affinity_watch;
+
 	bool preparing_roam : 1;
 	bool roam_scan_full : 1;
 	bool signal_low : 1;
@@ -1660,6 +1662,13 @@ static void station_enter_state(struct station *station,
 		station_set_evict_nocarrier(station, true);
 		station_set_drop_neighbor_discovery(station, false);
 		station_set_drop_unicast_l2_multicast(station, false);
+
+		if (station->affinity_watch) {
+			l_dbus_remove_watch(dbus_get_bus(),
+						station->affinity_watch);
+			station->affinity_watch = 0;
+		}
+
 		break;
 	case STATION_STATE_DISCONNECTING:
 	case STATION_STATE_NETCONFIG:
@@ -1668,6 +1677,13 @@ static void station_enter_state(struct station *station,
 	case STATION_STATE_FT_ROAMING:
 	case STATION_STATE_FW_ROAMING:
 		station_set_evict_nocarrier(station, false);
+
+		if (station->affinity_watch) {
+			l_dbus_remove_watch(dbus_get_bus(),
+						station->affinity_watch);
+			station->affinity_watch = 0;
+		}
+
 		break;
 	}
 
@@ -4328,6 +4344,79 @@ static struct l_dbus_message *station_dbus_signal_agent_unregister(
 	return l_dbus_message_new_method_return(message);
 }
 
+static int station_change_affinity(struct station *station, bool lower)
+{
+	if (!station->connected_network)
+		return -ENOTCONN;
+
+	if (lower)
+		return netdev_lower_signal_threshold(station->netdev);
+	else
+		return netdev_raise_signal_threshold(station->netdev);
+}
+
+static void station_affinity_disconnected_cb(struct l_dbus *dbus,
+						void *user_data)
+{
+	struct station *station = user_data;
+
+	l_debug("client that set affinity has disconnected, setting default");
+
+	/* The client who set the affinity disconnected, raise the threshold */
+	station_change_affinity(station, false);
+
+	station->affinity_watch = 0;
+}
+
+static struct l_dbus_message *station_dbus_set_affinity(
+						struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct station *station = user_data;
+	int ret;
+
+	if (station->affinity_watch) {
+		l_warn("A client already set the affinity!");
+		return dbus_error_already_exists(message);
+	}
+
+	ret = station_change_affinity(station, true);
+	if (ret < 0)
+		return dbus_error_from_errno(ret, message);
+
+	station->affinity_watch = l_dbus_add_disconnect_watch(dbus,
+					l_dbus_message_get_sender(message),
+					station_affinity_disconnected_cb,
+					station,
+					NULL);
+
+	return l_dbus_message_new_method_return(message);
+}
+
+static struct l_dbus_message *station_dbus_unset_affinity(
+						struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct station *station = user_data;
+	int ret;
+
+	if (!station->affinity_watch) {
+		l_warn("A client has not set the affinity!");
+		return dbus_error_not_configured(message);
+	}
+
+	ret = station_change_affinity(station, false);
+	if (ret < 0)
+		return dbus_error_from_errno(ret, message);
+
+	l_dbus_remove_watch(dbus, station->affinity_watch);
+	station->affinity_watch = 0;
+
+	return l_dbus_message_new_method_return(message);
+}
+
 static bool station_property_get_connected_network(struct l_dbus *dbus,
 					struct l_dbus_message *message,
 					struct l_dbus_message_builder *builder,
@@ -4722,6 +4811,9 @@ static void station_free(struct station *station)
 
 	l_queue_destroy(station->roam_bss_list, l_free);
 
+	if (station->affinity_watch)
+		l_dbus_remove_watch(dbus_get_bus(), station->affinity_watch);
+
 	l_free(station);
 }
 
@@ -4747,6 +4839,10 @@ static void station_setup_interface(struct l_dbus_interface *interface)
 	l_dbus_interface_method(interface, "UnregisterSignalLevelAgent", 0,
 				station_dbus_signal_agent_unregister,
 				"", "o", "path");
+	l_dbus_interface_method(interface, "SetConnectedBssAffinity", 0,
+				station_dbus_set_affinity, "", "");
+	l_dbus_interface_method(interface, "UnsetConnectedBssAffinity", 0,
+				station_dbus_unset_affinity, "", "");
 
 	l_dbus_interface_property(interface, "ConnectedNetwork", 0, "o",
 					station_property_get_connected_network,
-- 
2.34.1

