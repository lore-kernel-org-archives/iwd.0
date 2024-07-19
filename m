Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A082A43687
	for <iwd@lists.linux.dev>; Fri, 19 Jul 2024 18:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721413174; cv=none; b=cYhv1CzO5mRRSR4TmFmL216ayBWYZ/EVFS6OEIze0xOUQWdgUTeFRCah07/JtiC7NRfdnLxoahRrqAnX5NqguvR8UHl9KtQIgqzZ1uLIs4yv+39DuMBKOa1Q9wxg+92KpyqvV69XWUQKa817bOOxKpdL0lUjRyy2nHiCBVeQYuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721413174; c=relaxed/simple;
	bh=ddthYt52sc97M0xeLBcQJtTxXbZKG+OpdayIDR4wJ74=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KkC7WP5LU1E1E9sGTSL7icaHdH0MkAkYbPSmHULq9E8m9ZXie+Mxt7jAOrOvHI5lykCM3x15Dw7wpR1KNzk6pzeDSjEjPMkih0MyghCUIdT/bqE45caswh6KcT/HI6y0jdCRWd3WyePCGPL5UAI+sr4Job8R6VqwkCa8emb2aug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1lV/vsF; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1lV/vsF"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b7b28442f9so7461496d6.3
        for <iwd@lists.linux.dev>; Fri, 19 Jul 2024 11:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721413170; x=1722017970; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+vVkBlK5fKM6U1WRuOY9gwGUcfFueQrluIapk/QRM40=;
        b=k1lV/vsF7i3941APGXIp7dSMFX0Jg0cISMgSWmfnDKPiczx3MWUvTV0p3s3TfVd+hm
         ogGeSK6GhKipgj2M3elFwJ4QHLVU/LMRZQsdhLuSCusvSMnDhDf65l3N6V6Tr4Eq2l/+
         GgPtv4bNjKZ5/jfqTQDdbIcA2CUiKPDurDD89hRyN5fMr2A+EtfMilgmQNL3Bl3NqL2X
         Y8y9/xn27lGcAQcSq7FJc8+HaWu1Veb1pf0qOoD+UvEbAVP/x6NVTStkvxbtVZyg05Hz
         K7nfvvBLnJbCqV5sMcGenjTK7LmwE6VwgdWPdEREAllOZDXauF96B8KE5KUjIxOWd3/3
         J8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721413170; x=1722017970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vVkBlK5fKM6U1WRuOY9gwGUcfFueQrluIapk/QRM40=;
        b=iW0CeNUPmdVQuRaXYrmvBZcR3wJapGbxNMwRJ4W3y20X++d25s9XO8zkY6fbxxzccu
         BTys98eX3XSfeVvLYSR+6cYinYcZboHFAm+YENgF0NFxxBMnUEV/xhqsGNGCimVehMDS
         O8Dmz322FD05/NGAg3T+BETYZJtjYEjCJBfvdfYNcBcw3kfS0JQN2kBcuH1cK97Iss9j
         ahV8Fx5CQ6jT93uImst3Sqxz4LSJoMTVO61NRgEoS/Bt94uPD4AYQyrpGQIBtsrpKgS5
         Gbfw3jsm/fYdqLpqUeEoAgluR1Psgip/+a01AeZZs1jn9625gPwM68gj/RzqocNZOEet
         br2w==
X-Gm-Message-State: AOJu0YzvpXSPcIZbS09p7Ls2WPJHCTQA/PgcPnnwqtXCfEGVNbDyqQBn
	Pq5wQAa9MMgndhV6ZGcO6Vl5j17B6nwKMnjYkKsOEqCQ5oUR+E+75yAAHw==
X-Google-Smtp-Source: AGHT+IHkeJpU9ByAB7s6Y1UJfzk0HAbewZtWmlGtOX7Xtljle4gOwe6yssQi4Hu5gPe+Y/iGfcgexw==
X-Received: by 2002:a05:6214:2346:b0:6b5:7ee:1d79 with SMTP id 6a1803df08f44-6b78ca51fa5mr82584646d6.26.1721413170192;
        Fri, 19 Jul 2024 11:19:30 -0700 (PDT)
Received: from LOCLAP699.localdomain ([50.170.153.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7ac9cb02esm10589106d6.91.2024.07.19.11.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 11:19:29 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] dpp: relax requirement on IWD being in a disconnected state
Date: Fri, 19 Jul 2024 11:19:25 -0700
Message-Id: <20240719181926.3888420-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initially this made sense and for a completely unconfigured device
there is little to no downside to limiting IWD's state to
disconnected (or autoconnect states).

Where this poses a problem is if the device has been configured
incorrectly, for example with an invalid PSK. IWD will continue to
try and connect to the network, blocking DPP from ever being
started and always returning busy. Even if you timed it perfectly
to start DP between connection attempts it would be canceled right
away when IWD tried connecting again.

Instead we can relax this requirement by allowing DPP to start even
if IWD is connecting, and only cancel DPP when IWD's state
transitions to connnected. Since DPP effectively blocks the wiphy
work queue once it is started it will prevent any further connection
attempts until it completes.
---
 src/dpp.c | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 567fe8d2..650e1e96 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -3744,14 +3744,14 @@ static void dpp_station_state_watch(enum station_state state, void *user_data)
 		return;
 
 	switch (state) {
-	case STATION_STATE_DISCONNECTED:
-	case STATION_STATE_DISCONNECTING:
 	case STATION_STATE_ROAMING:
 	case STATION_STATE_FT_ROAMING:
 	case STATION_STATE_FW_ROAMING:
 		if (L_WARN_ON(dpp->role == DPP_CAPABILITY_ENROLLEE))
 			dpp_reset(dpp);
-
+		/* fall through */
+	case STATION_STATE_DISCONNECTED:
+	case STATION_STATE_DISCONNECTING:
 		if (dpp->role == DPP_CAPABILITY_CONFIGURATOR) {
 			l_debug("Disconnected while configuring, stopping DPP");
 			dpp_reset(dpp);
@@ -3927,6 +3927,44 @@ static void dpp_start_presence(struct dpp_sm *dpp, uint32_t *limit_freqs,
 	dpp_start_offchannel(dpp, dpp->current_freq);
 }
 
+static bool dpp_can_start(struct station *station)
+{
+	enum station_state state = station_get_state(station);
+
+	/*
+	 * The obvious cases where DPP can start without a second thought are
+	 * disconnected/disconnecting/autoconnecting.
+	 *
+	 * The reason DPP is allowed to start while connecting, and even
+	 * netconfig is to handle misconfigured profiles e.g. an incorrect
+	 * passphrase. If IWD has been misconfigured either by a prior DPP run
+	 * or other means it remains in a connecting state failing repeatedly.
+	 * This will prevent DPP from being started, or cancel it each time a
+	 * connection is attempted. This will render the device unconfigurable
+	 * via DPP until that invalid profile is removed. Since all offchannel
+	 * work is gated by the wiphy work queue there should be no contention
+	 * between station trying to connect and DPP trying to configure.
+	 */
+
+	switch (state) {
+	case STATION_STATE_DISCONNECTED:
+	case STATION_STATE_DISCONNECTING:
+	case STATION_STATE_AUTOCONNECT_QUICK:
+	case STATION_STATE_AUTOCONNECT_FULL:
+	case STATION_STATE_CONNECTING:
+	case STATION_STATE_CONNECTING_AUTO:
+	case STATION_STATE_NETCONFIG:
+		return true;
+	case STATION_STATE_CONNECTED:
+	case STATION_STATE_ROAMING:
+	case STATION_STATE_FT_ROAMING:
+	case STATION_STATE_FW_ROAMING:
+		return false;
+	default:
+		return false;
+	}
+}
+
 static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
 						struct l_dbus_message *message,
 						void *user_data)
@@ -3943,7 +3981,7 @@ static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
 	 * Station isn't actually required for DPP itself, although this will
 	 * prevent connecting to the network once configured.
 	 */
-	if (station && station_get_connected_network(station)) {
+	if (station && !dpp_can_start(station)) {
 		l_warn("cannot be enrollee while connected, please disconnect");
 		return dbus_error_busy(message);
 	} else if (!station)
@@ -4370,7 +4408,7 @@ static struct l_dbus_message *dpp_dbus_pkex_start_enrollee(struct l_dbus *dbus,
 				dpp->interface != DPP_INTERFACE_UNBOUND)
 		return dbus_error_busy(message);
 
-	if (station && station_get_connected_network(station))
+	if (station && !dpp_can_start(station))
 		return dbus_error_busy(message);
 
 	if (!dpp_parse_pkex_args(message, &key, &id))
-- 
2.34.1

