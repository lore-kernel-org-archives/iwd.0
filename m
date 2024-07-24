Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD3926287
	for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721836013; cv=none; b=C6ArbStEoc6pzPvSU8CJSZkGK2LX1dpN6kndkBRhjHEchB1JQnPxxaYjE/fUbj8frKXFJD//h7U+DlrCr9D85lwXRJ6VVqaLM3aNsm3byjSxoM3slptKYoCR33VRhf4NrRanmQruv3KVGi8Zm/+UkmDxEnrvQkak2R/bpLawVN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721836013; c=relaxed/simple;
	bh=OOGTiGgLTeU7mlHLVPiqWqc0PjC1RxhI6e6KCUE29ik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EVSAbDjjkt023VuUq0OoDo7PbHVyRklfzZfFmIWh4iNR8l9F3LAIxn9UnXMBYevhSUDT305chxOyoYYuYDXJn63KscBmZK8mV/dYVitV3u3GkecKRa6ev30P2w8fIfff1LKY2BBxgicKFstBInPmoRiBO91APuJ4yz6BFHevUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgYFDjmA; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgYFDjmA"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1c4475113so97228185a.1
        for <iwd@lists.linux.dev>; Wed, 24 Jul 2024 08:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721836010; x=1722440810; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnLC1m5xQAW3JJxH0wKuVck7tULL6CKQ4NXfkNZDcWM=;
        b=ZgYFDjmAnP2wAlO/ihttVAKI92iCDCjx6tPtRt1OHfGsgW+9CZhmiG6FkypYE3+W/i
         44MMiXSksYcWrOytm3AJkFKP/p8/SR2p+Z0n245ayI0hHkpawc6FJBahDPMAeYJbG/SW
         SI6x9Ia7lQHCqQBQbqHEGdLACG6TOS/FX3HRJpV1ZAcVH9JKioPIVoDZ6LggfU+pC8ax
         7cZcdQCoFEMX0aYpUlE+P1ImYtQuEeEeLFQevKFWaAgPR+W7/ZCwJGTu7Yl9vTuPG1Wu
         /2HoEKkU0hkVhRP8muV4/wKe+PFYyUUYyMNxErgYJPg4oyW5cS8AAx/MTqST/Egf8JsT
         KSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721836010; x=1722440810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NnLC1m5xQAW3JJxH0wKuVck7tULL6CKQ4NXfkNZDcWM=;
        b=n/wAdNSD9jU9YIWHoS/PuePBkJSNPEny+rZU1JKZa1OvFCALL0Fmot5DaBzflVfUQC
         Xcv+nJRtb0p+ecG103JaItTrcIxLEwpGD0ukybRANVL5GEd6zPluVd17MBKZePN04aqu
         oH7JaM0FX5mEHoWfXaTJgs2VFtCiqnUy+prDkKdLz5aSW31581R/NsiPlpkePoqwa9Gx
         pBcmxEu0LSrb7UjcLyzZkqoQImWtP9+FieCUq+mDDzPIelpAn7miPNLq3cVno74YijkT
         iC8nO+0CA9C9XHJJ1Zw1OWXch2MjXYDKDODgw5PsnvdMX2dAKoOASTvb+QpCgKoqEuHC
         v40Q==
X-Gm-Message-State: AOJu0YwOfJW6p4PesIWGcSDu1vDBQL71n+Mv75aD/OcqAOifk2drYGSQ
	CqLrzLuvF1ZJgQZ2r608DUALmjAjy+Yyis6FdMrQkfNhoynnLG4ym+CtKA==
X-Google-Smtp-Source: AGHT+IGJne6NmKUUB09DwpNmrwfuevoMeM5BakJt4Pu8m434+6RfvkySElPIzB5FGC4eo3B14Qbm8A==
X-Received: by 2002:a05:620a:460c:b0:7a1:456b:fd69 with SMTP id af79cd13be357-7a1d5cbe6cemr7988085a.20.1721836010367;
        Wed, 24 Jul 2024 08:46:50 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a199013905sm589001485a.67.2024.07.24.08.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 08:46:50 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/5] dpp: explicitly disconnect station if enrollee is started
Date: Wed, 24 Jul 2024 08:46:39 -0700
Message-Id: <20240724154641.1461593-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724154641.1461593-1-prestwoj@gmail.com>
References: <20240724154641.1461593-1-prestwoj@gmail.com>
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
 src/dpp.c | 198 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 147 insertions(+), 51 deletions(-)

v2:
 * Used an bool out parameter to distinguish if a disconnect is in
   progress as opposed to a true/false/< 0 return

diff --git a/src/dpp.c b/src/dpp.c
index 6f05aae9..d89c3056 100644
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
 
+static int dpp_try_disconnect_station(struct dpp_sm *dpp,
+					bool *out_disconnect_started)
+{
+	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
+	int ret;
+	bool started = false;
+
+	/* Unusual case, but an enrollee could still be started */
+	if (!station)
+		goto done;
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
+		break;
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
+		if (ret < 0) {
+			l_warn("failed to start disconnecting (%d)", ret);
+			station_set_autoconnect(station, dpp->autoconnect);
+
+			return ret;
+		}
+		/* fall through */
+	case STATION_STATE_DISCONNECTING:
+		l_debug("Delaying DPP start until after disconnect");
+		started = true;
+
+		break;
+	}
+
+	dpp->station_watch = station_add_state_watch(station,
+						dpp_station_state_watch,
+						dpp, NULL);
+done:
+	*out_disconnect_started = started;
+
+	return 0;
+}
+
 static void dpp_start_enrollee(struct dpp_sm *dpp)
 {
 	uint32_t freq = band_channel_to_freq(6, BAND_FREQ_2_4_GHZ);
@@ -3955,27 +4033,30 @@ static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
 						void *user_data)
 {
 	struct dpp_sm *dpp = user_data;
-	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
+	bool wait_for_disconnect;
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
+	ret = dpp_try_disconnect_station(dpp, &wait_for_disconnect);
+	if (ret < 0) {
+		dpp_reset(dpp);
+		return dbus_error_from_errno(ret, message);
+	}
+
+	if (!wait_for_disconnect)
+		dpp_start_enrollee(dpp);
+
+	/*
+	 * If a disconnect was started/in progress the enrollee will start once
+	 * that has finished
+	 */
 
 	dpp->pending = l_dbus_message_ref(message);
 
@@ -4111,6 +4192,9 @@ static struct l_dbus_message *dpp_start_configurator_common(
 
 	dpp_property_changed_notify(dpp);
 
+	dpp->station_watch = station_add_state_watch(station,
+					dpp_station_state_watch, dpp, NULL);
+
 	l_debug("DPP Start Configurator: %s", dpp->uri);
 
 	reply = l_dbus_message_new_method_return(message);
@@ -4361,7 +4445,8 @@ static struct l_dbus_message *dpp_dbus_pkex_start_enrollee(struct l_dbus *dbus,
 	struct dpp_sm *dpp = user_data;
 	const char *key;
 	const char *id;
-	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
+	bool wait_for_disconnect;
+	int ret;
 
 	l_debug("");
 
@@ -4369,9 +4454,6 @@ static struct l_dbus_message *dpp_dbus_pkex_start_enrollee(struct l_dbus *dbus,
 				dpp->interface != DPP_INTERFACE_UNBOUND)
 		return dbus_error_busy(message);
 
-	if (station && station_get_connected_network(station))
-		return dbus_error_busy(message);
-
 	if (!dpp_parse_pkex_args(message, &key, &id))
 		goto invalid_args;
 
@@ -4384,9 +4466,20 @@ static struct l_dbus_message *dpp_dbus_pkex_start_enrollee(struct l_dbus *dbus,
 	dpp->state = DPP_STATE_PKEX_EXCHANGE;
 	dpp->interface = DPP_INTERFACE_PKEX;
 
-	if (!dpp_start_pkex_enrollee(dpp))
+	ret = dpp_try_disconnect_station(dpp, &wait_for_disconnect);
+	if (ret < 0) {
+		dpp_reset(dpp);
+		return dbus_error_from_errno(ret, message);
+	}
+
+	if (!wait_for_disconnect && !dpp_start_pkex_enrollee(dpp))
 		goto invalid_args;
 
+	/*
+	 * If a disconnect was started/in progress the PKEX enrollee will start
+	 * once that has finished
+	 */
+
 	return l_dbus_message_new_method_return(message);
 
 invalid_args:
@@ -4470,6 +4563,9 @@ static struct l_dbus_message *dpp_start_pkex_configurator(struct dpp_sm *dpp,
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

