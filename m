Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C443033B
	for <iwd@lists.linux.dev>; Wed,  8 Nov 2023 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmW583RH"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-66d190a8f87so45024906d6.0
        for <iwd@lists.linux.dev>; Wed, 08 Nov 2023 09:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699464127; x=1700068927; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j56D32wso/LyK+sfGtLSBLwZsm4Uwy4vUz6r3IxZcCQ=;
        b=NmW583RHziuTyZitXrvnfqfXkpDMsQn9UCfDJVYWoP8IBSXx9wyVm2bT6ylqdc82e/
         4sZZdLG0J5NYuOVug7tGFaU1Ymi8q02a0TCbIBeTXvfcMPPBNWCFn+Agnvj0nzJhBZkI
         LBi78gNU99YCcJ+PwfBtCw3GMBILSMrzCt/IoJafbOs7cOBFxzW/5lWKfmY8zYKiwzND
         6Ua7FmqAmzV0ATYmmODz7Udb+u8PH9B770Z5hJ633fmjXYHH5MZ/OhQurzUUkIJ3wSVI
         FpwONQAw2cpipdc6OP6JLtkHr1aQVb5FWDUBPhmFowwmguJKEAeDmVrYQo3peVrcZ873
         A0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699464127; x=1700068927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j56D32wso/LyK+sfGtLSBLwZsm4Uwy4vUz6r3IxZcCQ=;
        b=J/L8uwnfAWazBoi9vgx2osxpTO1h2sSAzijAR0pu1mJkLpZSdcHWhy6outrMw0BwVR
         KAMz5dep5qZBGwwiU91enm/C5kKnbTSFdS0IJ92EhoSbYWnhiHPHn9IQUmq0DGV/J+ce
         gkCJ9N3MqgVIkOWbsPc19zbEBrGamfmfBW3go54qOfMhrvDV+HU95rolrltQb4wE9Lml
         hHVzKBkMB1HL1dCS996ddx/UhMxdV4ADVK0VdzG/aorYdJJKGKRLI+amn8CzQkvD4g8V
         KDyu7svcfMuLCoZ5Hy8XY2VkA59yR9iMtz0xfvuSeqCt1zorz2ugjZhMcZVdC/f4TUQs
         /sXg==
X-Gm-Message-State: AOJu0YxxtunimZDUVTtY8L9E7qeXf3Ic8OnvbHQpYYGdJTwwNlc8JZdN
	v1X94PNLIxuc2xsnaiETCoAg+8BidK4=
X-Google-Smtp-Source: AGHT+IEuay80FHc92AhYvgE/6f4Eoa9GNhUPjSuJvjlHI3XZgiUGACsg6v71PJb/9bilhAcNneOEFg==
X-Received: by 2002:a05:6214:2b0d:b0:66d:368e:24f5 with SMTP id jx13-20020a0562142b0d00b0066d368e24f5mr2871694qvb.46.1699464126900;
        Wed, 08 Nov 2023 09:22:06 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id qb1-20020ad44701000000b0065d03eae7a0sm1277003qvb.82.2023.11.08.09.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 09:22:06 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 07/10] dpp: Add StartConfigurator, PKEX agent support
Date: Wed,  8 Nov 2023 09:21:52 -0800
Message-Id: <20231108172155.2129509-8-prestwoj@gmail.com>
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

Adds a configurator variant to be used along side an agent. When
called the configurator will start and wait for an initial PKEX
exchange message from an enrollee at which point it will request
the code from an agent. This provides more flexibility for
configurators that are capable of configuring multiple enrollees
with different identifiers/codes.

Note that the timing requirements per the DPP spec still apply
so this is not meant to be used with a human configurator but
within an automated agent which does a quick lookup of potential
identifiers/codes and can reply within the 200ms window.
---
 src/dpp.c | 224 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 222 insertions(+), 2 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 90de6945..6a27cf43 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -88,6 +88,13 @@ enum dpp_interface {
 	DPP_INTERFACE_PKEX,
 };
 
+struct pkex_agent {
+	char *owner;
+	char *path;
+	unsigned int disconnect_watch;
+	uint32_t pending_id;
+};
+
 struct dpp_sm {
 	struct netdev *netdev;
 	char *uri;
@@ -112,6 +119,8 @@ struct dpp_sm {
 	enum dpp_state state;
 	enum dpp_interface interface;
 
+	struct pkex_agent *agent;
+
 	/*
 	 * List of frequencies to jump between. The presence of this list is
 	 * also used to signify that a configurator is an initiator vs responder
@@ -162,6 +171,7 @@ struct dpp_sm {
 	char *pkex_id;
 	char *pkex_key;
 	uint8_t pkex_version;
+	struct l_ecc_point *peer_encr_key;
 	struct l_ecc_point *pkex_m;
 	/* Ephemeral key Y' or X' for enrollee or configurator */
 	struct l_ecc_point *y_or_x;
@@ -335,6 +345,68 @@ static void dpp_free_pending_pkex_data(struct dpp_sm *dpp)
 	}
 
 	memset(dpp->peer_addr, 0, sizeof(dpp->peer_addr));
+
+	if (dpp->peer_encr_key) {
+		l_ecc_point_free(dpp->peer_encr_key);
+		dpp->peer_encr_key = NULL;
+	}
+}
+
+static void pkex_agent_free(void *data)
+{
+	struct pkex_agent *agent = data;
+
+	l_free(agent->owner);
+	l_free(agent->path);
+	l_dbus_remove_watch(dbus_get_bus(), agent->disconnect_watch);
+	l_free(agent);
+}
+
+static void dpp_agent_cancel(struct dpp_sm *dpp)
+{
+	struct l_dbus_message *msg;
+
+	const char *reason = "shutdown";
+
+	msg = l_dbus_message_new_method_call(dbus_get_bus(),
+						dpp->agent->owner,
+						dpp->agent->path,
+						IWD_SHARED_CODE_AGENT_INTERFACE,
+						"Cancel");
+	l_dbus_message_set_arguments(msg, "s", reason);
+	l_dbus_message_set_no_reply(msg, true);
+	l_dbus_send(dbus_get_bus(), msg);
+}
+
+static void dpp_agent_release(struct dpp_sm *dpp)
+{
+	struct l_dbus_message *msg;
+
+	msg = l_dbus_message_new_method_call(dbus_get_bus(),
+						dpp->agent->owner,
+						dpp->agent->path,
+						IWD_SHARED_CODE_AGENT_INTERFACE,
+						"Release");
+	l_dbus_message_set_no_reply(msg, true);
+	l_dbus_send(dbus_get_bus(), msg);
+}
+
+static void dpp_destroy_agent(struct dpp_sm *dpp)
+{
+	if (!dpp->agent)
+		return;
+
+	if (dpp->agent->pending_id) {
+		dpp_agent_cancel(dpp);
+		l_dbus_cancel(dbus_get_bus(), dpp->agent->pending_id);
+	}
+
+	dpp_agent_release(dpp);
+
+	l_debug("Released SharedCodeAgent on path %s", dpp->agent->path);
+
+	pkex_agent_free(dpp->agent);
+	dpp->agent = NULL;
 }
 
 static void dpp_free_auth_data(struct dpp_sm *dpp)
@@ -449,6 +521,8 @@ static void dpp_reset(struct dpp_sm *dpp)
 	explicit_bzero(dpp->z, dpp->key_len);
 	explicit_bzero(dpp->u, dpp->u_len);
 
+	dpp_destroy_agent(dpp);
+
 	dpp_free_pending_pkex_data(dpp);
 
 	dpp_free_auth_data(dpp);
@@ -1802,6 +1876,20 @@ static void dpp_offchannel_timeout(int error, void *user_data)
 
 	switch (dpp->state) {
 	case DPP_STATE_PKEX_EXCHANGE:
+		if (dpp->role != DPP_CAPABILITY_CONFIGURATOR || !dpp->agent)
+			break;
+
+		/*
+		 * We have a pending agent request but it did not arrive in
+		 * time, we cant assume the enrollee will be waiting around
+		 * for our response so cancel the request and continue waiting
+		 * for another request
+		 */
+		if (dpp->agent->pending_id) {
+			dpp_free_pending_pkex_data(dpp);
+			dpp_agent_cancel(dpp);
+		}
+		/* Fall through */
 	case DPP_STATE_PRESENCE:
 		break;
 	case DPP_STATE_NOTHING:
@@ -2914,6 +3002,63 @@ bad_code:
 	return;
 }
 
+static void dpp_pkex_agent_reply(struct l_dbus_message *message,
+					void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+	const char *error, *text;
+	const char *code;
+
+	dpp->agent->pending_id = 0;
+
+	l_debug("SharedCodeAgent %s path %s replied", dpp->agent->owner,
+			dpp->agent->path);
+
+	if (l_dbus_message_get_error(message, &error, &text)) {
+		l_error("RequestSharedCode(%s) returned %s(\"%s\")",
+				dpp->pkex_id, error, text);
+		goto reset;
+	}
+
+	if (!l_dbus_message_get_arguments(message, "s", &code)) {
+		l_debug("Invalid arguments, check SharedCodeAgent!");
+		goto reset;
+	}
+
+	dpp->pkex_key = l_strdup(code);
+	dpp_process_pkex_exchange_request(dpp, dpp->peer_encr_key);
+
+	return;
+
+reset:
+	dpp_free_pending_pkex_data(dpp);
+}
+
+static bool dpp_pkex_agent_request(struct dpp_sm *dpp)
+{
+	struct l_dbus_message *msg;
+
+	if (!dpp->agent)
+		return false;
+
+	if (L_WARN_ON(dpp->agent->pending_id))
+		return false;
+
+	msg = l_dbus_message_new_method_call(dbus_get_bus(),
+						dpp->agent->owner,
+						dpp->agent->path,
+						IWD_SHARED_CODE_AGENT_INTERFACE,
+						"RequestSharedCode");
+	l_dbus_message_set_arguments(msg, "s", dpp->pkex_id);
+
+
+	dpp->agent->pending_id = l_dbus_send_with_reply(dbus_get_bus(),
+							msg,
+							dpp_pkex_agent_reply,
+							dpp, NULL);
+	return dpp->agent->pending_id != 0;
+}
+
 static void dpp_handle_pkex_exchange_request(struct dpp_sm *dpp,
 					const uint8_t *from,
 					const uint8_t *body, size_t body_len)
@@ -3013,6 +3158,33 @@ static void dpp_handle_pkex_exchange_request(struct dpp_sm *dpp,
 
 	memcpy(dpp->peer_addr, from, 6);
 
+	if (!dpp->pkex_key) {
+		/*
+		 * "If an optional code identifier is used, it shall be a UTF-8
+		 *  string not greater than eighty (80) octets"
+		 */
+		if (!id || id_len > 80 || !l_utf8_validate(id, id_len, NULL)) {
+			l_debug("Configurator started with agent but enrollee "
+				"sent invalid or no identifier, ignoring");
+			return;
+		}
+
+		dpp->pkex_id = l_strndup(id, id_len);
+
+		/* Need to obtain code from agent */
+		if (!dpp_pkex_agent_request(dpp)) {
+			l_debug("Failed to request code from agent!");
+			dpp_free_pending_pkex_data(dpp);
+			return;
+		}
+
+		/* Save the encrypted key/identifier for the agent callback */
+
+		dpp->peer_encr_key = l_steal_ptr(m);
+
+		return;
+	}
+
 	dpp_process_pkex_exchange_request(dpp, m);
 
 	return;
@@ -3957,8 +4129,34 @@ invalid_args:
 	return dbus_error_invalid_args(message);
 }
 
+static void pkex_agent_disconnect(struct l_dbus *dbus, void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+
+	l_debug("SharedCodeAgent %s disconnected", dpp->agent->path);
+
+	dpp_reset(dpp);
+}
+
+static void dpp_create_agent(struct dpp_sm *dpp, const char *path,
+					struct l_dbus_message *message)
+{
+	const char *sender = l_dbus_message_get_sender(message);
+
+	dpp->agent = l_new(struct pkex_agent, 1);
+	dpp->agent->owner = l_strdup(sender);
+	dpp->agent->path = l_strdup(path);
+	dpp->agent->disconnect_watch = l_dbus_add_disconnect_watch(dbus_get_bus(),
+							sender,
+							pkex_agent_disconnect,
+							dpp, NULL);
+
+	l_debug("Registered a SharedCodeAgent on path %s", path);
+}
+
 static struct l_dbus_message *dpp_start_pkex_configurator(struct dpp_sm *dpp,
 					const char *key, const char *identifier,
+					const char *agent_path,
 					struct l_dbus_message *message)
 {
 	struct handshake_state *hs = netdev_get_handshake(dpp->netdev);
@@ -3986,6 +4184,9 @@ static struct l_dbus_message *dpp_start_pkex_configurator(struct dpp_sm *dpp,
 	if (key)
 		dpp->pkex_key = l_strdup(key);
 
+	if (agent_path)
+		dpp_create_agent(dpp, agent_path, message);
+
 	dpp->role = DPP_CAPABILITY_CONFIGURATOR;
 	dpp->state = DPP_STATE_PKEX_EXCHANGE;
 	dpp->interface = DPP_INTERFACE_PKEX;
@@ -3998,7 +4199,10 @@ static struct l_dbus_message *dpp_start_pkex_configurator(struct dpp_sm *dpp,
 	dpp_reset_protocol_timer(dpp, DPP_PKEX_PROTO_TIMEOUT);
 	dpp_property_changed_notify(dpp);
 
-	l_debug("Starting PKEX configurator for single enrollee");
+	if (dpp->pkex_key)
+		l_debug("Starting PKEX configurator for single enrollee");
+	else
+		l_debug("Starting PKEX configurator with agent");
 
 	return l_dbus_message_new_method_return(message);
 }
@@ -4017,7 +4221,21 @@ static struct l_dbus_message *dpp_dbus_pkex_configure_enrollee(
 	if (!dpp_parse_pkex_args(message, &key, &id))
 		return dbus_error_invalid_args(message);
 
-	return dpp_start_pkex_configurator(dpp, key, id, message);
+	return dpp_start_pkex_configurator(dpp, key, id, NULL, message);
+}
+
+static struct l_dbus_message *dpp_dbus_pkex_start_configurator(
+						struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+	const char *path;
+
+	if (!l_dbus_message_get_arguments(message, "o", &path))
+		return dbus_error_invalid_args(message);
+
+	return dpp_start_pkex_configurator(dpp, NULL, NULL, path, message);
 }
 
 static void dpp_setup_interface(struct l_dbus_interface *interface)
@@ -4057,6 +4275,8 @@ static void dpp_setup_pkex_interface(struct l_dbus_interface *interface)
 			dpp_dbus_pkex_stop, "", "");
 	l_dbus_interface_method(interface, "ConfigureEnrollee", 0,
 			dpp_dbus_pkex_configure_enrollee, "", "a{sv}", "args");
+	l_dbus_interface_method(interface, "StartConfigurator", 0,
+			dpp_dbus_pkex_start_configurator, "", "o", "path");
 
 	l_dbus_interface_property(interface, "Started", 0, "b",
 			dpp_pkex_get_started, NULL);
-- 
2.25.1

