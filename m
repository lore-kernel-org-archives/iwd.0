Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58CE1A0AEA
	for <iwd@lists.linux.dev>; Tue, 13 Aug 2024 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564618; cv=none; b=I5rE8FlV/L9CSmtO1AVmPDDf6SFoce9Xr6NfPBA2fcF5Xyi7HVJedf5hAKpfrZVngpog+J4Hzj0qxEXdX2KHDpt9PAnGVSj1Oq4SeDh8J3qBwKyt7yts6Tmm3phPRb7ig/8ePwyMnVeZxqYxgZFSfqW+4cs6bH0LiN1QI4h77u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564618; c=relaxed/simple;
	bh=+JGkrbS5gRabEE/gZQytXyVytzo5CjkcleAJqqcbBQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rIQlfI4v28DEs6whT5rjFJ1YbOGv2FcDyMtXk1GZdkSOWrdQV8Qry6NHQmiOd+I2xYkOdqP0ia24q5V4axmK7IypekD6AmWDWeBNd8g5tRkWyygiKNEqqk6BhdMeLbQRKqoBM0e7XI6kT+JAnE/9aCYJsgI9FHtyMpCzF03Z4fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8kbm0VG; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8kbm0VG"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44fdcd7a622so28891141cf.0
        for <iwd@lists.linux.dev>; Tue, 13 Aug 2024 08:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723564615; x=1724169415; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dmXZytG3ukuaCtKImFchOvWdu9wvkdksozRnpw0aPM=;
        b=J8kbm0VGVitCGMK1FM3PTlQPm4ynwCXBOtjXEYViOTAvdLDvFNhIwo1BktdVKEZTk+
         Fb34VUPoQVIJ+CE7hQhzxNWfyD9eTzW9tU4R6pBfSV+G/yUgcH1kxYOnTUhBVPVk2cy+
         qdLujTqlTSQgohvEyixpPvkmbw2Ui+4XEaPXa+VCn0EgQMF60j8VaxLNlj2G4qzOqStl
         49TAIGA3WOx2+s2LutzDAt7R/KsvtSbhCMD6qtWv1g6GaBUO4Ht7qe7SQ+T+R7YL5aL6
         1ArP+8EauJNjgncI9Ci2EZm5u//QXroDo4w65AfO5cfIEjnflkuJ64cYmtDJEE1GCLEW
         d6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723564615; x=1724169415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dmXZytG3ukuaCtKImFchOvWdu9wvkdksozRnpw0aPM=;
        b=s3Fx71mO7RIza+4DXsrpxWHcBLRrDCrqSKqfe1HmQmUuArOOjiFPRF8YQ4+k87knjA
         7HRlbGQo0Zd1MxkcjFmzhqvbOQEf9LXzq+i4lxJsI46Yn4An+EYD5KAEx8dUJ3H4v7is
         sXocUcMgOTyjObHveEP/2zxNXBlKezdIscuNDfqwF2AYmUTKRlGRBwd2t7kpbGygl78v
         NJ4asSRGeggmCjyFiXtf1pC7oPrq115xfGNhlS6DEWPbERqW/j/Ek9HExiBU0kguQVsO
         dJrrmiLi0wzfnbu2LlzukLdbg7TjRwsXFLEeAsOpwXzr2qa+OqLmRUhbxAkaHScLiHTL
         8q5g==
X-Gm-Message-State: AOJu0YwJLSuE3xP7kvM5pZ4SgQWaFOdl5HvoY76xp57aLD3cafbSCVeI
	dm3xAWpjUb0ZURCFY3WmiZ7yVAeGEXalTJfO7a5cYBh8prIz4A/LwdwmBg==
X-Google-Smtp-Source: AGHT+IGwKT+p6JPYpDiQo9bug+dlVl/KzOxonGONuHp+KqJ83a7XgRX/McQXTMjIft7JGn5WRUY3eQ==
X-Received: by 2002:a05:6214:2f8f:b0:6b5:e190:435 with SMTP id 6a1803df08f44-6bf4f8c13f3mr52433726d6.50.1723564614673;
        Tue, 13 Aug 2024 08:56:54 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82ca2024sm35825706d6.72.2024.08.13.08.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:56:54 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/9] station: Use Affinities property for roaming/ranking decisions
Date: Tue, 13 Aug 2024 08:56:36 -0700
Message-Id: <20240813155638.74987-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813155638.74987-1-prestwoj@gmail.com>
References: <20240813155638.74987-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two pieces where the affinity to a BSS will come into play:

The first is while connected to a BSS with the affinity set. In this
scenario station will lower the roaming threshold in order to loosly
lock IWD to this BSS. By lowering the roaming threshold we can avoid
roaming/scanning in cases where the device is not moving i.e. if an
external client knows this information.

The second effect BSS affinity has is to modify ranking when choosing
a roam candidate. A new ranking modifier has been added that will be
applied to a BSS rank given:
 - The BSS is in the Affinities array
 - The BSS signal is above the critical threshold (set in main.conf
   [General].CriticalRoamThreshold{_5GHZ}).
---
 src/station.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/src/station.c b/src/station.c
index 75dd13bb..ab04dcf2 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1682,6 +1682,11 @@ static void station_enter_state(struct station *station,
 		if (station->connected_bss->hs20_dgaf_disable)
 			station_set_drop_unicast_l2_multicast(station, true);
 
+		if (l_strv_contains(station->affinities,
+				network_bss_get_path(station->connected_network,
+						station->connected_bss)))
+			netdev_lower_signal_threshold(station->netdev);
+
 		break;
 	case STATION_STATE_DISCONNECTED:
 		periodic_scan_stop(station);
@@ -2673,6 +2678,23 @@ static void station_update_roam_bss(struct station *station,
 		scan_bss_free(old);
 }
 
+static bool station_apply_bss_affinity(struct station *station,
+						struct scan_bss *bss)
+{
+	struct network *network = station->connected_network;
+	const char *path = network_bss_get_path(network, bss);
+
+	/*
+	 * Even if the BSS has the affinity set, don't apply the factor if its
+	 * RSSI is below the critical threshold.
+	 */
+	if (bss->signal_strength / 100 <
+			netdev_get_critical_signal_threshold(station->netdev))
+		return false;
+
+	return l_strv_contains(station->affinities, path);
+}
+
 static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 					const struct scan_freq_set *freqs,
 					void *userdata)
@@ -2684,6 +2706,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 	struct scan_bss *bss;
 	double cur_bss_rank = 0.0;
 	static const double RANK_FT_FACTOR = 1.3;
+	static const double RANK_AFFINITY_FACTOR = 1.7;
 	uint16_t mdid;
 	enum security orig_security, security;
 
@@ -2715,6 +2738,9 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 
 		if (hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
 			cur_bss_rank *= RANK_FT_FACTOR;
+
+		if (station_apply_bss_affinity(station, bss))
+			cur_bss_rank *= RANK_AFFINITY_FACTOR;
 	}
 
 	/*
@@ -2765,6 +2791,9 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 		if (hs->mde && bss->mde_present && l_get_le16(bss->mde) == mdid)
 			rank *= RANK_FT_FACTOR;
 
+		if (station_apply_bss_affinity(station, bss))
+			rank *= RANK_AFFINITY_FACTOR;
+
 		if (rank <= cur_bss_rank)
 			goto next;
 
@@ -4506,6 +4535,9 @@ static void station_affinity_disconnected_cb(struct l_dbus *dbus,
 	station->affinity_watch = 0;
 
 	l_debug("client that set affinity has disconnected");
+
+	/* The client who set the affinity disconnected, raise the threshold */
+	netdev_raise_signal_threshold(station->netdev);
 }
 
 static void station_affinity_watch_destroy(void *user_data)
@@ -4531,6 +4563,8 @@ static struct l_dbus_message *station_property_set_affinities(
 	const char *sender = l_dbus_message_get_sender(message);
 	const char *path;
 	char **new_affinities;
+	const char *connected_path;
+	bool lower_threshold = false;
 
 	if (!station->connected_network)
 		return dbus_error_not_connected(message);
@@ -4550,6 +4584,8 @@ static struct l_dbus_message *station_property_set_affinities(
 	if (!l_dbus_message_iter_get_variant(new_value, "ao", &array))
 		return dbus_error_invalid_args(message);
 
+	connected_path = network_bss_get_path(station->connected_network,
+						station->connected_bss);
 	new_affinities = l_strv_new();
 
 	while (l_dbus_message_iter_next_entry(&array, &path)) {
@@ -4566,6 +4602,9 @@ static struct l_dbus_message *station_property_set_affinities(
 			return dbus_error_invalid_args(message);
 		}
 
+		if (!strcmp(path, connected_path))
+			lower_threshold = true;
+
 		new_affinities = l_strv_append(new_affinities, path);
 	}
 
@@ -4575,6 +4614,17 @@ static struct l_dbus_message *station_property_set_affinities(
 	l_dbus_property_changed(dbus, netdev_get_path(station->netdev),
 				IWD_STATION_INTERFACE, "Affinities");
 
+	/*
+	 * If affinity was set to the current BSS, lower the roam threshold. If
+	 * the connected BSS was not in the list raise the signal threshold.
+	 * The threshold may already be raised, in which case netdev will detect
+	 * this and do nothing.
+	 */
+	if (lower_threshold)
+		netdev_lower_signal_threshold(station->netdev);
+	else
+		netdev_raise_signal_threshold(station->netdev);
+
 	complete(dbus, message, NULL);
 
 	return NULL;
-- 
2.34.1

