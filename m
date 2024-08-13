Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C651A08AF
	for <iwd@lists.linux.dev>; Tue, 13 Aug 2024 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564616; cv=none; b=J0jIZvWkXZnSUvUx6oCqKwQ3bfTQJ/8JvQjEwglfCiqNuzoAf+IcmZPI4e0BxrO2SzRrNCSfgOi5RWF+4LPg5Weu1ZJD7/Ehlp0173Afvn1SYkl8+VOUBtFSiQWCA3QNVMcnP6UVtPeQP+2yPcR90I6DMT/y5KAYXESrahv45yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564616; c=relaxed/simple;
	bh=5cS2Ng99j8FvnlYVAL2agErIfEhzVRe2cCiT95Pst7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dRhCT1s3ugis8T1zLRbLh26lQgjyKdU7ffXKjUvTx1gC9IhtJtgFHiJ2lbKuZY6m357Ac3gvDUv/lcgNHyB2TYE8WVQ49c6e3BXqg9xWERmfukqsBW4EaMtj/cqxc+WV/lDjCRFs1p2QF7A+YlK2ppBpJ6NhGeGtdupHEdhyuuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9QoiQvx; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9QoiQvx"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b79fc76d03so32346916d6.1
        for <iwd@lists.linux.dev>; Tue, 13 Aug 2024 08:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723564613; x=1724169413; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9RiH8vthCTFHuc0Xkd7Boj5/77AjlJKly806m0IT0c=;
        b=Y9QoiQvxFyB3jCX9mjd0eviE8gk8qx0p6jlBOBDlI8rKlw8f/WuOx9oeWCwHZ2JaOB
         2V3ChBWrZCS44TuTPjvu2x92ec4WCp7CHFelGXx3dAhaIpGPKgzd7uJ38l5kthE32UI9
         F9yhP6ak2LiDXFqx53Yf2GKR5ro4LosDZLMC1esX5RO8qGVhpFNvNkorSc+ndR5U+wGD
         C/4PB39gAPa575QCnBL1fjBAeuuIy/aJEWbfKcjj6Tchiq3Q/WnivIdnGprnj+PTh8HC
         HHCZm/8yc3VK6hTSBVXbXk6jhS6gqpA4YKvzUjWeHYbXU9ZTtiVQ8oHrmiy4+L2n/eEK
         TYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723564613; x=1724169413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9RiH8vthCTFHuc0Xkd7Boj5/77AjlJKly806m0IT0c=;
        b=t21IazMiXevhhQruTkmNURRvNKpRUvhgoZBcatGFrGq7KgcW8gVqoAYnhT+OLQCRXx
         od0hytprJKRjYshp17n+Dsk4VZpR+Hp3tH+Vn6B8e6Rk8qroZfFC1srUIEu17XpsWpZN
         bA1nDpa2gMUyU6pTUEMqE/8sLM/4b4XnbWL7LFGmDZ0qSF/3FRnPtcZoDraRI80d7uEj
         irwmjR5t4e35QHxMhdgiG7hNr9hti6+rHf2j5+eXiMZBsRXAhdbw1xNQP6ElMwpmknLZ
         +/bKw7sI0vLflz/HFW+ybeHNjviNH+tYbuwPd3tL1PnfM2t7eRA1j5oJ7TFOTLOSAkQi
         BO2w==
X-Gm-Message-State: AOJu0YwTCJouxW7Ub+bwkUD5SZzZ8luJB0mtz1js4B/tS5PKXdsL47+D
	bhsYcq6spr3P4PxQCt+VaUfbXdnfm1ByUgM3WfnZXRz+X2lKaSftSUm3Dg==
X-Google-Smtp-Source: AGHT+IENDketRdmis9NfJelxC4udnPJM5iezA9de+vTrEzqhT7vO1zOhxooOdAyw3AA1dq/IOeE32g==
X-Received: by 2002:a05:6214:2f8f:b0:6b5:ea0e:98f with SMTP id 6a1803df08f44-6bf4f444f9dmr55814476d6.0.1723564613549;
        Tue, 13 Aug 2024 08:56:53 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82ca2024sm35825706d6.72.2024.08.13.08.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:56:53 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/9] station: add Affinities DBus property
Date: Tue, 13 Aug 2024 08:56:35 -0700
Message-Id: <20240813155638.74987-6-prestwoj@gmail.com>
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

This property will hold an array of object paths for
BasicServiceSet (BSS) objects. For the purpose of this patch
only the setter/getter and client watch is implemented. The
purpose of this array is to guide or loosly lock IWD to certain
BSS's provided that some external client has more information
about the environment than what IWD takes into account for its
roaming decisions. For example:

 - If the device is stationary an external client could reduce
   the likelihood of roaming by setting the affinity to the
   current BSS.
 - If an external client has knowledge of the devices planned
   route though the environment it could plan a path to roam
   between particular APs to reduce and optimize roaming.
---
 src/station.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/src/station.c b/src/station.c
index 3b61f264..75dd13bb 100644
--- a/src/station.c
+++ b/src/station.c
@@ -128,6 +128,10 @@ struct station {
 
 	uint64_t last_roam_scan;
 
+	char **affinities;
+	unsigned int affinity_watch;
+	char *affinity_client;
+
 	bool preparing_roam : 1;
 	bool roam_scan_full : 1;
 	bool signal_low : 1;
@@ -1685,6 +1689,13 @@ static void station_enter_state(struct station *station,
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
@@ -4463,6 +4474,112 @@ static bool station_property_get_state(struct l_dbus *dbus,
 	return true;
 }
 
+static bool station_property_get_affinities(struct l_dbus *dbus,
+					struct l_dbus_message *message,
+					struct l_dbus_message_builder *builder,
+					void *user_data)
+{
+	struct station *station = user_data;
+	char **path = station->affinities;
+
+	if (!station->connected_network)
+		return false;
+
+	l_dbus_message_builder_enter_array(builder, "o");
+
+	while (path && *path) {
+		l_dbus_message_builder_append_basic(builder, 'o', *path);
+		path++;
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
+	l_strv_free(station->affinities);
+	station->affinities = NULL;
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
+	char **new_affinities;
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
+	new_affinities = l_strv_new();
+
+	while (l_dbus_message_iter_next_entry(&array, &path)) {
+		const char *p = network_get_path(station->connected_network);
+
+		/*
+		 * It can't be assumed that the specific BSS has been seen, but
+		 * at least validate the device/network portion matches the
+		 * connected network.
+		 */
+		if (strncmp(p, path, strlen(p))) {
+			l_warn("Can't set affinity to BSS (%s)", path);
+			l_strv_free(new_affinities);
+			return dbus_error_invalid_args(message);
+		}
+
+		new_affinities = l_strv_append(new_affinities, path);
+	}
+
+	l_strv_free(station->affinities);
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
@@ -4693,6 +4810,7 @@ static struct station *station_create(struct netdev *netdev)
 	station_set_autoconnect(station, autoconnect);
 
 	station->roam_bss_list = l_queue_new();
+	station->affinities = l_strv_new();
 
 	return station;
 }
@@ -4785,6 +4903,9 @@ static void station_free(struct station *station)
 
 	l_queue_destroy(station->roam_bss_list, l_free);
 
+	if (station->affinity_watch)
+		l_dbus_remove_watch(dbus_get_bus(), station->affinity_watch);
+
 	l_free(station);
 }
 
@@ -4821,6 +4942,9 @@ static void station_setup_interface(struct l_dbus_interface *interface)
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

