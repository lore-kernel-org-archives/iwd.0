Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2CF16C6B0
	for <iwd@lists.linux.dev>; Mon, 22 Jul 2024 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721672980; cv=none; b=oVM6Gd2ddozX/xvwME9C8BCcq93Ir8LaAUxhvLopUc6LbI9caIePuruBJ70LKMaWeHiF3d/ndUJJZOCClvXrHNoMqC7rLmU4CjPNNN3XdJfQIQ1EpoS2CX5vGGAaeFQN28n3uAT1W9h90oullNVjZxwu878Qd3qamAZiCdTIWoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721672980; c=relaxed/simple;
	bh=0aKaNlchXAfpifcJRt69jwR82Y/yUOcGdPTqEana/Iw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hCHR/1Vd/vVChY9KU5Hm0UxHsj1sWMuqKCiPKlq0yfUhCceyX9SYSEBOyOOKJQ43QtcuWEtFAOBHYayK8sZNQwAJfAmJxJK5mf9J5+0hn7X1/FDc2XRg53RI6O0S2i2k+750s2fyXbJtLyHmOYaWoMdmIxewUZKJppSwwTbuFSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNX+AuNk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNX+AuNk"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fd640a6454so22729505ad.3
        for <iwd@lists.linux.dev>; Mon, 22 Jul 2024 11:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721672977; x=1722277777; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEMjiconc0/ACjkmCoOZFJDsYrqSNvF3TRXhZUy6ijw=;
        b=mNX+AuNkQ/8Bh9GGBS31/L5voWy/x+UZ3her3/DA2LBuhmtLRdj+3LROrr76R7nqg5
         ANaqE6Y94TTHsD1e2jQjCiGkZfpQKnOXhgCI+f6Ul5hRtcL0u60grEHHwwmFpBAp78w1
         Nx3b+N4r3XAXoVFwt88lxbvLS39MbOISwwcsZy7MXdcSWYH9RF/YcPrOs8IwICZjtx3R
         oU6OnNsx3beKO/isax0jbpDMN5wHsyWIrBXcdrEso0BINAvhLraZWXxnEo34Qv1B+Txq
         JiSjfgeVHDaZHL7dIC2OZiwA0hVmjyvw+eEIOlhuf/WiBSCKzBrHTUPJHWXZUyshA6Ek
         JJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721672977; x=1722277777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEMjiconc0/ACjkmCoOZFJDsYrqSNvF3TRXhZUy6ijw=;
        b=f9C7Q0xxXXBnBkn4VRgYtqx10ub/kz4WFcuWd/dt9Y4OpcfD85+obFsC88wdDSecyZ
         Ntx+CBMubY5TUpJJQpVjV2FCIRwskKBbZOx4LlOnzLidvocDvsImwT8OSSoP+SiQ9AHG
         MujGWYSEkRoMRwTs3EZY1INWMDSAi3FZf0a6JoZewmX0yetElMjf/UjCr8cH3AKhsoxJ
         t9INXxOnHkmpNvAWGaQc0GDetYS96eSWg62q+T6RjwZEKN+EtUEcS67/fdyF9urOkAlH
         JWC/dsjmUeS/sIk/l6hUaLdhW2nYO+vv2k+VgfPsleYrmVGZEqoscU5uHjsHUu1H/gty
         Mu1w==
X-Gm-Message-State: AOJu0Yy4iULxbzggksIWCd9pTIuQx0XifCuKAP9y0g/XkpgUTlWVQZZs
	zfn+iCAFdCYWme96PZNFDO6Fg4JCQbjcdTg2tfPJe7016yRECAlsfzb39g==
X-Google-Smtp-Source: AGHT+IE9wSjVt0e5JVUlzedtMcjvFMxyVyhG8yJ8opGdLuceGBbU4zHCIXv7ktALgGLNl3krte77ng==
X-Received: by 2002:a17:902:e88b:b0:1fd:672f:2b34 with SMTP id d9443c01a7336-1fd7457d357mr48764525ad.33.1721672977184;
        Mon, 22 Jul 2024 11:29:37 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd8dff753bsm33622625ad.243.2024.07.22.11.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 11:29:36 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/5] dpp: explicitly disconnect station if enrollee is started
Date: Mon, 22 Jul 2024 11:29:30 -0700
Message-Id: <20240722182932.4091008-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722182932.4091008-1-prestwoj@gmail.com>
References: <20240722182932.4091008-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prior to now the DPP state was required to be disconnected before
DPP would start. This is inconvenient for the user since it requires
extra state checking and/or DBus method calls. Instead model this
case like WSC and issue a disconnect to station if DPP is requested
to start.

The other conditions on stopping DPP are also preserved and no
changes to the configurator role have been made, i.e. being
disconnected while configuring still stops DPP. Similarly any
connection made during enrolling will stop DPP.

It should also be noted that station's autoconfigure setting is also
preserved and set back to its original value upon DPP completing.
---
 src/dpp.c | 195 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 143 insertions(+), 52 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 6f05aae9..b04477ca 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -193,6 +193,7 @@ struct dpp_sm {
 	bool roc_started : 1;
 	bool channel_switch : 1;
 	bool mutual_auth : 1;
+	bool autoconnect : 1;
 };
 
 static const char *dpp_role_to_string(enum dpp_capability role)
@@ -469,6 +470,8 @@ static void dpp_free_auth_data(struct dpp_sm *dpp)
 
 static void dpp_reset(struct dpp_sm *dpp)
 {
+	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
+
 	if (dpp->uri) {
 		l_free(dpp->uri);
 		dpp->uri = NULL;
@@ -549,12 +552,19 @@ static void dpp_reset(struct dpp_sm *dpp)
 	dpp_property_changed_notify(dpp);
 
 	dpp->interface = DPP_INTERFACE_UNBOUND;
+
+	if (station) {
+		if (dpp->station_watch)
+			station_remove_state_watch(station, dpp->station_watch);
+
+		/* Set the old autoconnect state back to what it was */
+		if (dpp->role == DPP_CAPABILITY_ENROLLEE)
+			station_set_autoconnect(station, dpp->autoconnect);
+	}
 }
 
 static void dpp_free(struct dpp_sm *dpp)
 {
-	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
-
 	dpp_reset(dpp);
 
 	if (dpp->own_asn1) {
@@ -572,13 +582,6 @@ static void dpp_free(struct dpp_sm *dpp)
 		dpp->boot_private = NULL;
 	}
 
-	/*
-	 * Since this is called when the netdev goes down, station may already
-	 * be gone in which case the state watch will automatically go away.
-	 */
-	if (station)
-		station_remove_state_watch(station, dpp->station_watch);
-
 	known_networks_watch_remove(dpp->known_network_watch);
 
 	l_free(dpp);
@@ -3721,6 +3724,9 @@ static void dpp_frame_watch(struct dpp_sm *dpp, uint16_t frame_type,
 					L_UINT_TO_PTR(frame_type), NULL);
 }
 
+static void dpp_start_enrollee(struct dpp_sm *dpp);
+static bool dpp_start_pkex_enrollee(struct dpp_sm *dpp);
+
 /*
  * Station is unaware of DPP's state so we need to handle a few cases here so
  * weird stuff doesn't happen:
@@ -3734,27 +3740,50 @@ static void dpp_frame_watch(struct dpp_sm *dpp, uint16_t frame_type,
  *     DPP finishes.
  *
  * Other conditions shouldn't ever happen i.e. configuring and going into a
- * connecting state or enrolling and going to a disconnected/roaming state.
+ * connecting state or enrolling and going to a roaming state.
  */
 static void dpp_station_state_watch(enum station_state state, void *user_data)
 {
 	struct dpp_sm *dpp = user_data;
 
-	if (dpp->state == DPP_STATE_NOTHING)
+	if (dpp->state == DPP_STATE_NOTHING ||
+					dpp->interface == DPP_INTERFACE_UNBOUND)
 		return;
 
 	switch (state) {
 	case STATION_STATE_DISCONNECTED:
+		/* DPP-initiated disconnect, the enrollee can now start */
+		if (dpp->role == DPP_CAPABILITY_ENROLLEE) {
+			l_debug("Starting enrollee after disconnect");
+
+			if (dpp->interface == DPP_INTERFACE_DPP)
+				dpp_start_enrollee(dpp);
+			else
+				dpp_start_pkex_enrollee(dpp);
+
+			return;
+		}
+
+		break;
 	case STATION_STATE_DISCONNECTING:
+		/* Normal part of disconnecting prior to enrolling */
+		if (dpp->role == DPP_CAPABILITY_ENROLLEE)
+			return;
+
+		/* fall through */
 	case STATION_STATE_ROAMING:
 	case STATION_STATE_FT_ROAMING:
 	case STATION_STATE_FW_ROAMING:
+		/*
+		 * An enrollee will always be disconnected prior to starting
+		 * so a roaming condition should never happen.
+		 */
 		if (L_WARN_ON(dpp->role == DPP_CAPABILITY_ENROLLEE))
-			dpp_reset(dpp);
+			goto reset;
 
 		if (dpp->role == DPP_CAPABILITY_CONFIGURATOR) {
 			l_debug("Disconnected while configuring, stopping DPP");
-			dpp_reset(dpp);
+			goto reset;
 		}
 
 		break;
@@ -3762,28 +3791,22 @@ static void dpp_station_state_watch(enum station_state state, void *user_data)
 	case STATION_STATE_CONNECTED:
 	case STATION_STATE_CONNECTING_AUTO:
 	case STATION_STATE_NETCONFIG:
-		if (L_WARN_ON(dpp->role == DPP_CAPABILITY_CONFIGURATOR))
-			dpp_reset(dpp);
-
-		if (dpp->role == DPP_CAPABILITY_ENROLLEE) {
-			l_debug("Connecting while enrolling, stopping DPP");
-			dpp_reset(dpp);
-		}
-
-		break;
-
-	/*
-	 * Autoconnect states are fine for enrollees. This makes it nicer for
-	 * the user since they don't need to explicity Disconnect() to disable
-	 * autoconnect, then re-enable it if DPP fails.
-	 */
 	case STATION_STATE_AUTOCONNECT_FULL:
 	case STATION_STATE_AUTOCONNECT_QUICK:
-		if (L_WARN_ON(dpp->role == DPP_CAPABILITY_CONFIGURATOR))
-			dpp_reset(dpp);
+		/*
+		 * The user could have issued a connection request during
+		 * enrolling, in which case DPP should be canceled. We should
+		 * never hit this case as a configurator as a disconnect would
+		 * need to come prior.
+		 */
+		L_WARN_ON(dpp->role == DPP_CAPABILITY_CONFIGURATOR);
 
-		break;
+		goto reset;
 	}
+
+reset:
+	l_debug("Resetting DPP after station state change (state=%u)", state);
+	dpp_reset(dpp);
 }
 
 static void dpp_create(struct netdev *netdev)
@@ -3793,7 +3816,6 @@ static void dpp_create(struct netdev *netdev)
 	uint8_t dpp_conf_response_prefix[] = { 0x04, 0x0b };
 	uint8_t dpp_conf_request_prefix[] = { 0x04, 0x0a };
 	uint64_t wdev_id = netdev_get_wdev_id(netdev);
-	struct station *station = station_find(netdev_get_ifindex(netdev));
 
 	dpp->netdev = netdev;
 	dpp->state = DPP_STATE_NOTHING;
@@ -3839,8 +3861,6 @@ static void dpp_create(struct netdev *netdev)
 				sizeof(dpp_conf_request_prefix),
 				dpp_handle_config_request_frame, dpp, NULL);
 
-	dpp->station_watch = station_add_state_watch(station,
-					dpp_station_state_watch, dpp, NULL);
 	dpp->known_network_watch = known_networks_watch_add(
 					dpp_known_network_watch, dpp, NULL);
 
@@ -3927,6 +3947,64 @@ static void dpp_start_presence(struct dpp_sm *dpp, uint32_t *limit_freqs,
 	dpp_start_offchannel(dpp, dpp->current_freq);
 }
 
+static int dpp_disconnect_started(struct dpp_sm *dpp)
+{
+	int ret = 0;
+	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
+
+	/* Unusual case, but an enrollee could still be started */
+	if (!station)
+		return false;
+
+	dpp->autoconnect = station_get_autoconnect(station);
+	station_set_autoconnect(station, false);
+
+	switch (station_get_state(station)) {
+	case STATION_STATE_AUTOCONNECT_QUICK:
+	case STATION_STATE_AUTOCONNECT_FULL:
+		/* Should never happen since we just set autoconnect false */
+		l_warn("Still in autoconnect state after setting false!");
+
+		/* fall through */
+	case STATION_STATE_DISCONNECTED:
+		ret = false;
+		goto register_watch;
+	case STATION_STATE_ROAMING:
+	case STATION_STATE_FT_ROAMING:
+	case STATION_STATE_FW_ROAMING:
+	case STATION_STATE_CONNECTING:
+	case STATION_STATE_CONNECTING_AUTO:
+	case STATION_STATE_CONNECTED:
+	case STATION_STATE_NETCONFIG:
+		/*
+		 * For any connected or connection in progress state, start a
+		 * disconnect
+		 */
+		ret = station_disconnect(station);
+		if (ret < 0)
+			goto error;
+
+		/* fall through */
+	case STATION_STATE_DISCONNECTING:
+		l_debug("Delaying DPP start until after disconnect");
+
+		ret = true;
+		goto register_watch;
+	}
+
+error:
+	l_warn("failed to start disconnecting (%d)", ret);
+	station_set_autoconnect(station, dpp->autoconnect);
+
+	return ret;
+
+register_watch:
+	dpp->station_watch = station_add_state_watch(station,
+						dpp_station_state_watch,
+						dpp, NULL);
+	return ret;
+}
+
 static void dpp_start_enrollee(struct dpp_sm *dpp)
 {
 	uint32_t freq = band_channel_to_freq(6, BAND_FREQ_2_4_GHZ);
@@ -3955,27 +4033,27 @@ static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
 						void *user_data)
 {
 	struct dpp_sm *dpp = user_data;
-	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
+	int ret;
 
 	if (dpp->state != DPP_STATE_NOTHING ||
 				dpp->interface != DPP_INTERFACE_UNBOUND)
 		return dbus_error_busy(message);
 
-	/*
-	 * Station isn't actually required for DPP itself, although this will
-	 * prevent connecting to the network once configured.
-	 */
-	if (station && station_get_connected_network(station)) {
-		l_warn("cannot be enrollee while connected, please disconnect");
-		return dbus_error_busy(message);
-	} else if (!station)
-		l_debug("No station device, continuing anyways...");
-
 	dpp->state = DPP_STATE_PRESENCE;
 	dpp->role = DPP_CAPABILITY_ENROLLEE;
 	dpp->interface = DPP_INTERFACE_DPP;
 
-	dpp_start_enrollee(dpp);
+	ret = dpp_disconnect_started(dpp);
+	if (ret < 0) {
+		dpp_reset(dpp);
+		return dbus_error_from_errno(ret, message);
+	} else if (ret == false)
+		dpp_start_enrollee(dpp);
+
+	/*
+	 * If a disconnect was started/in progress the enrollee will start once
+	 * that has finished
+	 */
 
 	dpp->pending = l_dbus_message_ref(message);
 
@@ -4111,6 +4189,9 @@ static struct l_dbus_message *dpp_start_configurator_common(
 
 	dpp_property_changed_notify(dpp);
 
+	dpp->station_watch = station_add_state_watch(station,
+					dpp_station_state_watch, dpp, NULL);
+
 	l_debug("DPP Start Configurator: %s", dpp->uri);
 
 	reply = l_dbus_message_new_method_return(message);
@@ -4361,7 +4442,7 @@ static struct l_dbus_message *dpp_dbus_pkex_start_enrollee(struct l_dbus *dbus,
 	struct dpp_sm *dpp = user_data;
 	const char *key;
 	const char *id;
-	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
+	int ret;
 
 	l_debug("");
 
@@ -4369,9 +4450,6 @@ static struct l_dbus_message *dpp_dbus_pkex_start_enrollee(struct l_dbus *dbus,
 				dpp->interface != DPP_INTERFACE_UNBOUND)
 		return dbus_error_busy(message);
 
-	if (station && station_get_connected_network(station))
-		return dbus_error_busy(message);
-
 	if (!dpp_parse_pkex_args(message, &key, &id))
 		goto invalid_args;
 
@@ -4384,8 +4462,18 @@ static struct l_dbus_message *dpp_dbus_pkex_start_enrollee(struct l_dbus *dbus,
 	dpp->state = DPP_STATE_PKEX_EXCHANGE;
 	dpp->interface = DPP_INTERFACE_PKEX;
 
-	if (!dpp_start_pkex_enrollee(dpp))
-		goto invalid_args;
+	ret = dpp_disconnect_started(dpp);
+	if (ret < 0) {
+		dpp_reset(dpp);
+		return dbus_error_from_errno(ret, message);
+	} else if (ret == false)
+		if (!dpp_start_pkex_enrollee(dpp))
+			goto invalid_args;
+
+	/*
+	 * If a disconnect was started/in progress the PKEX enrollee will start
+	 * once that has finished
+	 */
 
 	return l_dbus_message_new_method_return(message);
 
@@ -4470,6 +4558,9 @@ static struct l_dbus_message *dpp_start_pkex_configurator(struct dpp_sm *dpp,
 	dpp_reset_protocol_timer(dpp, DPP_PKEX_PROTO_TIMEOUT);
 	dpp_property_changed_notify(dpp);
 
+	dpp->station_watch = station_add_state_watch(station,
+					dpp_station_state_watch, dpp, NULL);
+
 	if (dpp->pkex_key)
 		l_debug("Starting PKEX configurator for single enrollee");
 	else
-- 
2.34.1

