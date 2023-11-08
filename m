Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2434F31A87
	for <iwd@lists.linux.dev>; Wed,  8 Nov 2023 17:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqJWWw5L"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d9caf5cc948so7429122276.0
        for <iwd@lists.linux.dev>; Wed, 08 Nov 2023 09:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699464121; x=1700068921; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaCYpNp2WNuykiGKrkz90qJEIbZBIenbERXR6ftYk7I=;
        b=fqJWWw5LcHooAjYMRYFq/twlL0VrHau7H6Vtht/9YCblUoBqn+/Au0afhQv/OlmKnj
         C1mZc7GXBBITCp1GPDtOD3bVo8cRXewjKZnXOdjaKuitp+87TNob1D+73QRCsz6j0Gu4
         iz5c2B8uKQul3hymXSp3YRJMwEIU3EeERraXcGMLx0ew4bv+C/2RVj2unuZwXZ7zLg3j
         UHS2YY7YdRL469wnnYgzoLIfvGXUPHeuNty0VU7l/Gzab8AvX3aXKKHAAJYYkTUQ4P02
         2BHPX/qVXtQ/0W4U0PeA+4cUYeSLFJN6oq0EQ78uUVeHsELIEGKZeZBqdb+4FTQwllqF
         Cluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699464121; x=1700068921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaCYpNp2WNuykiGKrkz90qJEIbZBIenbERXR6ftYk7I=;
        b=FkUTriEE7qBtkkXq+Waq5uVZLLg4PoR5V0CoM0RieOetUuPq+02nawISDXi5Lr1gUA
         7CyS1mSRxOZcS50klp2FAb98L4SvQFwjwFMU647BNsFP68I7FDDWm2J1IM+765Iq9xD6
         GWovmSePECRqFHqiurQyxER9PGwW6tXBhD4C9cS195wnJdLu3sOsIVBQD6mMnXhGJMIz
         AThybMbXeWnFrEDcbTiQ1faTSQQ42rT8EsGvoJHzptM/1WEGcFrI7qL41gjltegm80hH
         YAeQUkQuyXPAb/xLqKN3wS94c7r3qYdX+tqtmE7iMkgEM7Peq+AkefuXj311gXgT2ZH6
         RCsg==
X-Gm-Message-State: AOJu0YxWg3XAJkcq381hA3NvQfeUWjwSWAh/wWkltf2JgSYOxPxBrsdD
	7m4KiC9wIrBiLIhjotD1cna+DieuibA=
X-Google-Smtp-Source: AGHT+IGNt4foHc3zd8t0WmkpLvSvgcuBTD304ikAnGJQKaGAIGdpx/nwO77Elk1NMeol098jo4GE7A==
X-Received: by 2002:a25:2f8e:0:b0:d99:5613:213d with SMTP id v136-20020a252f8e000000b00d995613213dmr2078972ybv.61.1699464121009;
        Wed, 08 Nov 2023 09:22:01 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id qb1-20020ad44701000000b0065d03eae7a0sm1277003qvb.82.2023.11.08.09.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 09:22:00 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 02/10] dpp: introduce dpp_interface type, prep for PKEX
Date: Wed,  8 Nov 2023 09:21:47 -0800
Message-Id: <20231108172155.2129509-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231108172155.2129509-1-prestwoj@gmail.com>
References: <20231108172155.2129509-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PKEX and DPP will share the same state machine since the DPP protocol
follows PKEX. This does pose an issue with the DBus interfaces
because we don't want DPP initiated by the SharedCode interface to
start setting properties on the DeviceProvisioning interface.

To handle this a dpp_interface enum is being introduced which binds
the dpp_sm object to a particular interface, for the life of the
protocol run. Once the protocol finishes the dpp_sm can be unbound
allowing either interface to use it again later.
---
 src/dpp.c | 48 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index b0a79361..7a7301e2 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -79,6 +79,12 @@ enum dpp_capability {
 	DPP_CAPABILITY_CONFIGURATOR = 0x02,
 };
 
+enum dpp_interface {
+	DPP_INTERFACE_UNBOUND,
+	DPP_INTERFACE_DPP,
+	DPP_INTERFACE_PKEX,
+};
+
 struct dpp_sm {
 	struct netdev *netdev;
 	char *uri;
@@ -100,6 +106,7 @@ struct dpp_sm {
 	struct l_ecc_point *peer_boot_public;
 
 	enum dpp_state state;
+	enum dpp_interface interface;
 
 	/*
 	 * List of frequencies to jump between. The presence of this list is
@@ -159,7 +166,8 @@ static bool dpp_get_started(struct l_dbus *dbus,
 				void *user_data)
 {
 	struct dpp_sm *dpp = user_data;
-	bool started = (dpp->state != DPP_STATE_NOTHING);
+	bool started = (dpp->state != DPP_STATE_NOTHING &&
+			dpp->interface == DPP_INTERFACE_DPP);
 
 	l_dbus_message_builder_append_basic(builder, 'b', &started);
 
@@ -174,7 +182,8 @@ static bool dpp_get_role(struct l_dbus *dbus,
 	struct dpp_sm *dpp = user_data;
 	const char *role;
 
-	if (dpp->state == DPP_STATE_NOTHING)
+	if (dpp->state == DPP_STATE_NOTHING ||
+				dpp->interface != DPP_INTERFACE_DPP)
 		return false;
 
 	switch (dpp->role) {
@@ -199,7 +208,8 @@ static bool dpp_get_uri(struct l_dbus *dbus,
 {
 	struct dpp_sm *dpp = user_data;
 
-	if (dpp->state == DPP_STATE_NOTHING)
+	if (dpp->state == DPP_STATE_NOTHING ||
+				dpp->interface != DPP_INTERFACE_DPP)
 		return false;
 
 	l_dbus_message_builder_append_basic(builder, 's', dpp->uri);
@@ -210,12 +220,18 @@ static void dpp_property_changed_notify(struct dpp_sm *dpp)
 {
 	const char *path = netdev_get_path(dpp->netdev);
 
-	l_dbus_property_changed(dbus_get_bus(), path, IWD_DPP_INTERFACE,
-				"Started");
-	l_dbus_property_changed(dbus_get_bus(), path, IWD_DPP_INTERFACE,
-				"Role");
-	l_dbus_property_changed(dbus_get_bus(), path, IWD_DPP_INTERFACE,
-				"URI");
+	switch (dpp->interface) {
+	case DPP_INTERFACE_DPP:
+		l_dbus_property_changed(dbus_get_bus(), path, IWD_DPP_INTERFACE,
+					"Started");
+		l_dbus_property_changed(dbus_get_bus(), path, IWD_DPP_INTERFACE,
+					"Role");
+		l_dbus_property_changed(dbus_get_bus(), path, IWD_DPP_INTERFACE,
+					"URI");
+		break;
+	default:
+		break;
+	}
 }
 
 static void *dpp_serialize_iovec(struct iovec *iov, size_t iov_len,
@@ -333,6 +349,8 @@ static void dpp_reset(struct dpp_sm *dpp)
 	dpp_free_auth_data(dpp);
 
 	dpp_property_changed_notify(dpp);
+
+	dpp->interface = DPP_INTERFACE_UNBOUND;
 }
 
 static void dpp_free(struct dpp_sm *dpp)
@@ -2416,6 +2434,7 @@ static void dpp_create(struct netdev *netdev)
 
 	dpp->netdev = netdev;
 	dpp->state = DPP_STATE_NOTHING;
+	dpp->interface = DPP_INTERFACE_UNBOUND;
 	dpp->wdev_id = wdev_id;
 	dpp->curve = l_ecc_curve_from_ike_group(19);
 	dpp->key_len = l_ecc_curve_get_scalar_bytes(dpp->curve);
@@ -2535,7 +2554,8 @@ static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
 	uint32_t freq = band_channel_to_freq(6, BAND_FREQ_2_4_GHZ);
 	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
 
-	if (dpp->state != DPP_STATE_NOTHING)
+	if (dpp->state != DPP_STATE_NOTHING ||
+				dpp->interface != DPP_INTERFACE_UNBOUND)
 		return dbus_error_busy(message);
 
 	/*
@@ -2554,6 +2574,7 @@ static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
 
 	dpp->state = DPP_STATE_PRESENCE;
 	dpp->role = DPP_CAPABILITY_ENROLLEE;
+	dpp->interface = DPP_INTERFACE_DPP;
 
 	l_ecdh_generate_key_pair(dpp->curve, &dpp->proto_private,
 					&dpp->own_proto_public);
@@ -2663,7 +2684,8 @@ static struct l_dbus_message *dpp_start_configurator_common(
 	if (network_get_security(network) != SECURITY_PSK)
 		return dbus_error_not_supported(message);
 
-	if (dpp->state != DPP_STATE_NOTHING)
+	if (dpp->state != DPP_STATE_NOTHING ||
+				dpp->interface != DPP_INTERFACE_UNBOUND)
 		return dbus_error_busy(message);
 
 	l_ecdh_generate_key_pair(dpp->curve, &dpp->proto_private,
@@ -2695,6 +2717,7 @@ static struct l_dbus_message *dpp_start_configurator_common(
 					netdev_get_address(dpp->netdev),
 					&bss->frequency, 1, NULL, NULL);
 	dpp->role = DPP_CAPABILITY_CONFIGURATOR;
+	dpp->interface = DPP_INTERFACE_DPP;
 	dpp->config = dpp_configuration_new(settings,
 						network_get_ssid(network),
 						hs->akm_suite);
@@ -2730,6 +2753,9 @@ static struct l_dbus_message *dpp_dbus_stop(struct l_dbus *dbus,
 {
 	struct dpp_sm *dpp = user_data;
 
+	if (dpp->interface != DPP_INTERFACE_DPP)
+		return dbus_error_not_found(message);
+
 	dpp_reset(dpp);
 
 	return l_dbus_message_new_method_return(message);
-- 
2.25.1

