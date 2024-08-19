Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF1D16132E
	for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724089928; cv=none; b=ZEuZvwC4Ke7JHtaxavWB7gl69P31QeR72H6a+dDOl26tsBqRSOoaQkBOXvNXAlj1UEb+QH0fNgBxsSMtEl8+DK+/3IMvoWpFLBPbgwgMYG7R2hi5dlx4HjaShTj0cQz8p1Vl37VC07FEMOJBC6ZUj4m/g2Ept8ynMsp3ZRwSLC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724089928; c=relaxed/simple;
	bh=Cdk+zmaL9pfqsn1FKIMizkcNDvfzCZ+TW+polvP0T1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KF7RiG+Z2JnvxSHzRo3oR9Muh8D0cNXNznStN/vvUpwwc2En5a1FyUOkGfXx3xUmw7owfOQg1h2/o8Rkr8n93zoXMh+8kP87Z7NVhIgMVZk1KRDLCk97AR6VLHVQdHyTAYVty0OqOk97B9UK+J06hhB1BcklkYKo8C5fGQVE8iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lT8DG+xt; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lT8DG+xt"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7a1d6f4714bso456529985a.1
        for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 10:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724089925; x=1724694725; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PgDUZtRcZALpBOQT0zUmihB2QjLTXjpOl88zRZafqUw=;
        b=lT8DG+xtEPHZdKCq0MbbS0OuEBVCQUXuoC42XSvWDvVAnn40bXIh13/VdK27W1jpIp
         1lPFlHjI2Y4dnBrleOZCS+fRjLKOAg7UHm060eMZEZT1tvp+SSD/8+AFUVN8rT/PG/Wb
         92xsKFc47AAWp8t8p6ihYoB+O+WinxmI0129agRhKbQaZ7HmFvwu9uK8h99PDWsxhi41
         /42ThBH2gDmxOGSebIG/GoRBSijLdGLHmttQmyezjx+aBzsgU7WLNINBKHbBTTVjeexB
         8n0FX26Ba+F6bootp0eKtNf9B0KEcfFvpQh4eInWVrm3xD7UEIWUlrXrOzA0CEvCmOe+
         of/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724089925; x=1724694725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PgDUZtRcZALpBOQT0zUmihB2QjLTXjpOl88zRZafqUw=;
        b=N+WvTAJYOPh9WkmGYEGGUehTXyxmeo/xl4Y7PArUejIvYYh3D64gJBiTYqxE45zw0u
         iAvY7UPeiqpp9kbLc0fo6TZZFISPrLE7eecatEIW0/IkJS0A37kHs2vfCKIGoKb+N1Go
         iCCpFAmQqeg6QbSnE34MRtS6/mUTILF4sWvlIsNWOLTQYMbuPhJAba4xfSDKUW9R4vKc
         cf+gwFI/r//oEFd7u6GE8qNCDRnTuJuxNEJ+wFGI47lLHSaWG7H9Z5N41Wgj+zXG70sB
         sLCUGDZ0N9BL7iHSfBLKLVsecVr72o3G+qctgx+nl7MxDxfZFZPDbIFfJGkcJoQb0j2D
         DB2A==
X-Gm-Message-State: AOJu0YxCuJU9rpFs/ZJJu3QOu9BlSV3v1A894f51ckkTfMPmVn/re2iI
	6nnjXpz1DTEXssYEKiUqqoyJBsS7t8pjEczpXNzkLaeB/0hGN+fnkxKefA==
X-Google-Smtp-Source: AGHT+IG5X1qAp+sU8HcQb/kSEbprnktrFfu0qPVkBNX2Un0IGmsr1sfuDUEc+9qCdclisuRdoLfXKA==
X-Received: by 2002:a05:620a:31a9:b0:7a4:dff8:35d5 with SMTP id af79cd13be357-7a667c537cdmr65356885a.33.1724089925131;
        Mon, 19 Aug 2024 10:52:05 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e5a1csm451854685a.74.2024.08.19.10.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 10:52:04 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 5/8] station: add Affinities DBus property
Date: Mon, 19 Aug 2024 10:51:48 -0700
Message-Id: <20240819175151.1310546-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819175151.1310546-1-prestwoj@gmail.com>
References: <20240819175151.1310546-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This property will hold an array of object paths for
BasicServiceSet (BSS) objects. For the purpose of this patch
only the setter/getter and client watch is implemented. The
purpose of this array is to guide or loosly lock IWD to certain
BSS's provided that some external client has more information
about the environment than what IWD takes into account for its
roaming decisions.

For the time being, the array is limited to only the connected
BSS path, and any roams or disconnects will clear the array.

The intended use case for this is if the device is stationary
an external client could reduce the likelihood of roaming by
setting the affinity to the current BSS.
---
 src/station.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

v2:
 * Limit Affinities to only the connected BSS
 * Change station->affinities to queue rather than char**

diff --git a/src/station.c b/src/station.c
index 333b0fa1..3b64cd75 100644
--- a/src/station.c
+++ b/src/station.c
@@ -128,6 +128,10 @@ struct station {
 
 	uint64_t last_roam_scan;
 
+	struct l_queue *affinities;
+	unsigned int affinity_watch;
+	char *affinity_client;
+
 	bool preparing_roam : 1;
 	bool roam_scan_full : 1;
 	bool signal_low : 1;
@@ -449,6 +453,14 @@ static const char *station_get_bss_path(struct station *station,
 	return __network_path_append_bss(network_path, bss);
 }
 
+static bool match_bss_path(const void *data, const void *user_data)
+{
+	const char *path1 = data;
+	const char *path2 = user_data;
+
+	return !strcmp(path1, path2);
+}
+
 static bool station_unregister_bss(struct station *station,
 					struct scan_bss *bss)
 {
@@ -457,6 +469,8 @@ static bool station_unregister_bss(struct station *station,
 	if (L_WARN_ON(!path))
 		return false;
 
+	l_queue_remove_if(station->affinities, match_bss_path, path);
+
 	return l_dbus_unregister_object(dbus_get_bus(), path);
 }
 
@@ -1740,6 +1754,13 @@ static void station_enter_state(struct station *station,
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
@@ -1747,6 +1768,12 @@ static void station_enter_state(struct station *station,
 	case STATION_STATE_ROAMING:
 	case STATION_STATE_FT_ROAMING:
 	case STATION_STATE_FW_ROAMING:
+		if (station->affinity_watch) {
+			l_dbus_remove_watch(dbus_get_bus(),
+						station->affinity_watch);
+			station->affinity_watch = 0;
+		}
+
 		station_set_evict_nocarrier(station, false);
 		break;
 	}
@@ -4520,6 +4547,118 @@ static bool station_property_get_state(struct l_dbus *dbus,
 	return true;
 }
 
+static bool station_property_get_affinities(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct station *station = user_data;
+	const struct l_queue_entry *e;
+
+	if (!station->connected_network)
+		return false;
+
+	l_dbus_message_builder_enter_array(builder, "o");
+
+	for (e = l_queue_get_entries(station->affinities); e; e = e->next) {
+		const char *path = e->data;
+
+		l_dbus_message_builder_append_basic(builder, 'o', path);
+	}
+
+	l_dbus_message_builder_leave_array(builder);
+
+	return true;
+}
+
+static void station_affinity_disconnected_cb(struct l_dbus *dbus,
+						void *user_data)
+{
+	struct station *station = user_data;
+
+	l_dbus_remove_watch(dbus_get_bus(), station->affinity_watch);
+	station->affinity_watch = 0;
+
+	l_debug("client that set affinity has disconnected");
+}
+
+static void station_affinity_watch_destroy(void *user_data)
+{
+	struct station *station = user_data;
+
+	l_free(station->affinity_client);
+	station->affinity_client = NULL;
+
+	l_queue_destroy(station->affinities, l_free);
+	station->affinities = NULL;
+
+	l_dbus_property_changed(dbus_get_bus(),
+				netdev_get_path(station->netdev),
+				IWD_STATION_INTERFACE, "Affinities");
+}
+
+static struct l_dbus_message *station_property_set_affinities(
+					struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_iter *new_value,
+					l_dbus_property_complete_cb_t complete,
+					void *user_data)
+{
+	struct station *station = user_data;
+	struct l_dbus_message_iter array;
+	const char *sender = l_dbus_message_get_sender(message);
+	const char *path;
+	struct l_queue *new_affinities;
+
+	if (!station->connected_network)
+		return dbus_error_not_connected(message);
+
+	if (!station->affinity_watch) {
+		station->affinity_client = l_strdup(sender);
+		station->affinity_watch = l_dbus_add_disconnect_watch(dbus,
+					sender,
+					station_affinity_disconnected_cb,
+					station,
+					station_affinity_watch_destroy);
+	} else if (strcmp(station->affinity_client, sender)) {
+		l_warn("Only one client may manage Affinities property");
+		return dbus_error_not_available(message);
+	}
+
+	if (!l_dbus_message_iter_get_variant(new_value, "ao", &array))
+		return dbus_error_invalid_args(message);
+
+	new_affinities = l_queue_new();
+
+	while (l_dbus_message_iter_next_entry(&array, &path)) {
+		struct scan_bss *bss = l_dbus_object_get_data(dbus_get_bus(),
+						path,
+						IWD_BSS_INTERFACE);
+
+		/*
+		 * TODO: For now only allow the affinities array to contain the
+		 *       connected BSS path. Any other values will be rejected.
+		 *       This could change in the future.
+		 */
+		if (bss != station->connected_bss) {
+			l_queue_destroy(new_affinities, l_free);
+			return dbus_error_invalid_args(message);
+		}
+
+		l_queue_push_head(new_affinities, l_strdup(path));
+	}
+
+	l_queue_destroy(station->affinities, l_free);
+	station->affinities = new_affinities;
+
+	l_dbus_property_changed(dbus, netdev_get_path(station->netdev),
+				IWD_STATION_INTERFACE, "Affinities");
+
+	complete(dbus, message, NULL);
+
+	return NULL;
+}
+
 void station_foreach(station_foreach_func_t func, void *user_data)
 {
 	const struct l_queue_entry *entry;
@@ -4842,6 +4981,9 @@ static void station_free(struct station *station)
 
 	l_queue_destroy(station->roam_bss_list, l_free);
 
+	if (station->affinity_watch)
+		l_dbus_remove_watch(dbus_get_bus(), station->affinity_watch);
+
 	l_free(station);
 }
 
@@ -4878,6 +5020,9 @@ static void station_setup_interface(struct l_dbus_interface *interface)
 					station_property_get_scanning, NULL);
 	l_dbus_interface_property(interface, "State", 0, "s",
 					station_property_get_state, NULL);
+	l_dbus_interface_property(interface, "Affinities", 0, "ao",
+					station_property_get_affinities,
+					station_property_set_affinities);
 }
 
 static void station_destroy_interface(void *user_data)
-- 
2.34.1

