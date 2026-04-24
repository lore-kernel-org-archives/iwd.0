Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339C731F9A0
	for <iwd@lists.linux.dev>; Fri, 24 Apr 2026 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777019540; cv=none; b=PZS3AAv6WCvywVMmscU/MAFOSXpIvODkKczt12svjCqGHlFP4po86Pcanste5PKeg4BB6mwaLfzBq1hcF98y6gtMVIDRRRkus+JfU9Hwg/vzcQcH1WWltOx2crDjOFklOZKhYBgIMUnCDJQmoRRepcxztTHWOGa9jHWc7m8IYKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777019540; c=relaxed/simple;
	bh=amx+8rxu3QW0xNqh8NSgiMdmCtg8NsiJ1n9V27FKdB8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVLsfg688B6ZqVyrADdC2rPpmZixXfZhPRjmpJXbpn5H58buf0sXqpPeKld90zoiYPhchL8J4vFQWY2sjbwKB/GL2a0RNzkDcBw7RLn03rAWDhD+4b2jgzcqwflt9maQOhOMPBVG6XckvtHWBNkzU5TpoEzHEmm/TLz9Ad87faM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at; spf=pass smtp.mailfrom=irregular.at; dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b=eEORz6n0; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irregular.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b="eEORz6n0"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488af96f6b2so96815095e9.0
        for <iwd@lists.linux.dev>; Fri, 24 Apr 2026 01:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=irregular.at; s=google; t=1777019534; x=1777624334; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSxeRn6oT9XCaABM7VK4SXi/h7aX7OwA227ihIZhmjg=;
        b=eEORz6n0SoauNRDvXh4p9eRWpilWqvRtxwImPMHS3jSBEt/jLGTaw8zH6MMjQ13xNJ
         xna0499cHshSejRWkYS2f0rS4QmQWkTV6UYUmwz9BEFZzJvioBlO753B/FiQFrfhUGwm
         M/s92f+zlRKmPCt6IRJ3eo6zt5+GHQs+jpd+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777019534; x=1777624334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aSxeRn6oT9XCaABM7VK4SXi/h7aX7OwA227ihIZhmjg=;
        b=W+PA0iqnpmNq8sqL9XfiZO99SucepSQ1UXT1nB03CqXITkYHrsp498g0WO94QRGCZb
         xBrf16bWlt+Jvmtok4ou4p36DH/EKaOqD/kgw8PUwiv4bnIJQDU6iFHQyyzDb59zIIB0
         plvgD9/9L/tBJZXFkIdZjNZz/WYMxmhzmstggJnPGEAfgMhyVEp3/C3et0/9P1I4KEym
         3rJEpUv6MSpgl2gdLmzKyEGVSxAHngcneRHWBkj8M8lYCFZ/QTJ0ApYSzqjKU2NiiqVe
         I9rz+u37Xpmyj4rbVXz/Xj223K7p59abAuqbC17YMF3DGPUxAMLGuhPQPWiXXa7R/ut2
         vUbQ==
X-Gm-Message-State: AOJu0YwZ5f8qJYgK317z0YbDBHXV7Q43lkgGm2tkU7Ibokr3E0DQYTVD
	bTvG+i14SgGwzfjfbsB2HZOrZYTMhJI1uYUz4aqfYeYaa9SGIfdL2JT3SZHkbvIZYf7iYo5i3Th
	JalI4
X-Gm-Gg: AeBDietaU9RC2X0erHL8xSRG/1o7leBVmTNy/v5s2ORujpLRGoZ2SKNlSo/uAZt5pqD
	lo+SfFIb+alqh9OA378tubBNZCPZojgTXaR6NQiWKWGUSQltxxmPr7VzLIlXhNL4y6OT3bhI2kg
	MtVNxtmasaB92uLb9xZ4LBaCRmXZXrE9orVUDe0ctJ5/Wkl4/rWtYW2y57c0p11zNeXexnooB7y
	j3WPJhQeLpeWMpzH3jD9KlYAWuGscOPWxBBFGgMuNH+G4kklT/yMQNijU3ZWXQxHN7X0J+KAOJl
	htzhHbBkd9X0ha6n7Cfbc/fiy1mAicUTeSC1Xx6ySO0sJtuPCNRxuszsUfdxA6Mwv1lfbAbIgDZ
	Zyg9PEDNt/wCtI9B9SQSJWUDmzxxqTeQ13buciVG1rUtIf9B1PzoyYuVeDaRTNJcDs/vGJ4GZJ2
	MzX3HMMnJAArIdrqrLYBXfggsAj4sV4xz1q9Ca0i1oR1jZu6j0xnkX4PuSl3eQHoqfpEjbgVTMi
	K4pCY6c4RYys89a7ikh32aE2yTge5EFYblQIISDbpws0pWrTvx0bObgo71Nhw4m6r8tfpOIGBoQ
	BDczpfSfrZ6AJuorYMyUAggC5H7ePW4xdZ8gupZfqn4mwu2RoXGnRx8UN1+JqVbev4gjwni0bo0
	cUs6dhjwWOA==
X-Received: by 2002:a05:600c:8183:b0:488:b187:d898 with SMTP id 5b1f17b1804b1-488fb771445mr371890605e9.14.1777019534017;
        Fri, 24 Apr 2026 01:32:14 -0700 (PDT)
Received: from mkurz-macbook-pro.fritz.box (2a02-8388-82c0-2a80-8de6-cca3-34a7-690d.cable.dynamic.v6.surfer.at. [2a02:8388:82c0:2a80:8de6:cca3:34a7:690d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c01cfsm601386945e9.10.2026.04.24.01.32.13
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 01:32:13 -0700 (PDT)
From: Matthias Kurz <m.kurz@irregular.at>
To: iwd@lists.linux.dev
Subject: [PATCH 1/3] agent: Add passphrase storage options
Date: Fri, 24 Apr 2026 10:31:57 +0200
Message-ID: <20260424083209.383093-2-m.kurz@irregular.at>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260424083209.383093-1-m.kurz@irregular.at>
References: <20260424083209.383093-1-m.kurz@irregular.at>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RequestPassphraseWithOptions support for PSK passphrase requests.
The method lets an agent return the passphrase together with options
that affect how IWD handles it.

Currently the only option is Store. When Store is false, use the
passphrase for the current connection attempt but keep it out of the
network profile.

Fall back to RequestPassphrase if the agent does not implement the new
method.
---
 src/agent.c   | 108 +++++++++++++++++++++++++++++++++++++++++++-------
 src/agent.h   |   1 +
 src/network.c |  12 ++++++
 3 files changed, 107 insertions(+), 14 deletions(-)

diff --git a/src/agent.c b/src/agent.c
index 0f718b87..03538db1 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -44,11 +44,13 @@ enum agent_request_type {
 struct agent_request {
 	enum agent_request_type type;
 	struct l_dbus_message *message;
+	char *path;
 	unsigned int id;
 	void *user_data;
 	void *user_callback;
 	struct l_dbus_message *trigger;
 	agent_request_destroy_func_t destroy;
+	bool passphrase_with_options;
 };
 
 struct agent {
@@ -126,6 +128,7 @@ static void agent_request_free(void *user_data)
 	if (request->destroy)
 		request->destroy(request->user_data);
 
+	l_free(request->path);
 	l_free(request);
 }
 
@@ -134,19 +137,37 @@ static void passphrase_reply(struct l_dbus_message *reply,
 {
 	const char *error, *text;
 	char *passphrase = NULL;
+	bool store = true;
 	enum agent_result result = AGENT_RESULT_FAILED;
 	agent_request_passphrase_func_t user_callback = request->user_callback;
 
 	if (l_dbus_message_get_error(reply, &error, &text))
 		goto done;
 
-	if (!l_dbus_message_get_arguments(reply, "s", &passphrase))
+	if (request->passphrase_with_options) {
+		struct l_dbus_message_iter options;
+		struct l_dbus_message_iter value;
+		const char *key;
+
+		if (!l_dbus_message_get_arguments(reply, "sa{sv}",
+							&passphrase, &options))
+			goto done;
+
+		while (l_dbus_message_iter_next_entry(&options, &key, &value)) {
+			if (!strcmp(key, "Store")) {
+				if (!l_dbus_message_iter_get_variant(&value,
+								"b", &store))
+					goto done;
+			}
+		}
+	} else if (!l_dbus_message_get_arguments(reply, "s", &passphrase))
 		goto done;
 
 	result = AGENT_RESULT_OK;
 
 done:
-	user_callback(result, passphrase, request->trigger, request->user_data);
+	user_callback(result, passphrase, store, request->trigger,
+			request->user_data);
 }
 
 static void user_name_passwd_reply(struct l_dbus_message *reply,
@@ -224,6 +245,57 @@ static void agent_free(void *data)
 }
 
 static void agent_send_next_request(struct agent *agent);
+static void agent_receive_reply(struct l_dbus_message *message,
+							void *user_data);
+
+static struct l_dbus_message *agent_new_passphrase_message(struct agent *agent,
+					const char *path, bool with_options)
+{
+	struct l_dbus_message *message;
+
+	message = l_dbus_message_new_method_call(dbus_get_bus(),
+							agent->owner,
+							agent->path,
+							IWD_AGENT_INTERFACE,
+							with_options ?
+							"RequestPassphraseWithOptions" :
+							"RequestPassphrase");
+
+	l_dbus_message_set_arguments(message, "o", path);
+
+	return message;
+}
+
+static bool agent_retry_passphrase_without_options(struct agent *agent,
+					struct agent_request *request,
+					struct l_dbus_message *reply)
+{
+	const char *error, *text;
+
+	if (request->type != AGENT_REQUEST_TYPE_PASSPHRASE ||
+			!request->passphrase_with_options)
+		return false;
+
+	if (!l_dbus_message_get_error(reply, &error, &text))
+		return false;
+
+	if (strcmp(error, "org.freedesktop.DBus.Error.UnknownMethod") &&
+			strcmp(error, "org.freedesktop.DBus.Error.UnknownInterface"))
+		return false;
+
+	request->passphrase_with_options = false;
+	request->message = agent_new_passphrase_message(agent, request->path,
+							false);
+
+	agent->pending_id = l_dbus_send_with_reply(dbus_get_bus(),
+							request->message,
+							agent_receive_reply,
+							agent, NULL);
+
+	request->message = NULL;
+
+	return true;
+}
 
 static void request_timeout(struct l_timeout *timeout, void *user_data)
 {
@@ -242,11 +314,17 @@ static void agent_receive_reply(struct l_dbus_message *message,
 							void *user_data)
 {
 	struct agent *agent = user_data;
+	struct agent_request *pending;
 
 	l_debug("agent %p request id %u", agent, agent->pending_id);
 
 	agent->pending_id = 0;
 
+	pending = l_queue_peek_head(agent->requests);
+	if (pending && agent_retry_passphrase_without_options(agent, pending,
+								message))
+		return;
+
 	agent_finalize_pending(agent, message);
 
 	if (!agent->pending_id)
@@ -281,7 +359,9 @@ static unsigned int agent_queue_request(struct agent *agent,
 					int timeout, void *callback,
 					struct l_dbus_message *trigger,
 					void *user_data,
-					agent_request_destroy_func_t destroy)
+					agent_request_destroy_func_t destroy,
+					const char *path,
+					bool passphrase_with_options)
 {
 	struct agent_request *request;
 
@@ -289,11 +369,13 @@ static unsigned int agent_queue_request(struct agent *agent,
 
 	request->type = type;
 	request->message = message;
+	request->path = l_strdup(path);
 	request->id = ++next_request_id;
 	request->user_data = user_data;
 	request->user_callback = callback;
 	request->trigger = l_dbus_message_ref(trigger);
 	request->destroy = destroy;
+	request->passphrase_with_options = passphrase_with_options;
 
 	agent->timeout_secs = timeout;
 
@@ -365,17 +447,12 @@ unsigned int agent_request_passphrase(const char *path,
 
 	l_debug("agent %p owner %s path %s", agent, agent->owner, agent->path);
 
-	message = l_dbus_message_new_method_call(dbus_get_bus(),
-							agent->owner,
-							agent->path,
-							IWD_AGENT_INTERFACE,
-							"RequestPassphrase");
-
-	l_dbus_message_set_arguments(message, "o", path);
+	message = agent_new_passphrase_message(agent, path, true);
 
 	return agent_queue_request(agent, AGENT_REQUEST_TYPE_PASSPHRASE,
 					message, agent_timeout_input_request(),
-					callback, trigger, user_data, destroy);
+					callback, trigger, user_data, destroy,
+					path, true);
 }
 
 unsigned int agent_request_pkey_passphrase(const char *path,
@@ -401,7 +478,8 @@ unsigned int agent_request_pkey_passphrase(const char *path,
 
 	return agent_queue_request(agent, AGENT_REQUEST_TYPE_PASSPHRASE,
 					message, agent_timeout_input_request(),
-					callback, trigger, user_data, destroy);
+					callback, trigger, user_data, destroy,
+					NULL, false);
 }
 
 unsigned int agent_request_user_name_password(const char *path,
@@ -427,7 +505,8 @@ unsigned int agent_request_user_name_password(const char *path,
 
 	return agent_queue_request(agent, AGENT_REQUEST_TYPE_USER_NAME_PASSWD,
 					message, agent_timeout_input_request(),
-					callback, trigger, user_data, destroy);
+					callback, trigger, user_data, destroy,
+					NULL, false);
 }
 
 unsigned int agent_request_user_password(const char *path, const char *user,
@@ -452,7 +531,8 @@ unsigned int agent_request_user_password(const char *path, const char *user,
 
 	return agent_queue_request(agent, AGENT_REQUEST_TYPE_PASSPHRASE,
 					message, agent_timeout_input_request(),
-					callback, trigger, user_data, destroy);
+					callback, trigger, user_data, destroy,
+					NULL, false);
 }
 
 static bool find_request(const void *a, const void *b)
diff --git a/src/agent.h b/src/agent.h
index eb08c6b6..220339db 100644
--- a/src/agent.h
+++ b/src/agent.h
@@ -29,6 +29,7 @@ enum agent_result {
 
 typedef void (*agent_request_passphrase_func_t) (enum agent_result result,
 					const char *passphrase,
+					bool store,
 					struct l_dbus_message *message,
 					void *user_data);
 typedef void (*agent_request_user_name_passwd_func_t) (enum agent_result result,
diff --git a/src/network.c b/src/network.c
index a5a2375a..1d14c04c 100644
--- a/src/network.c
+++ b/src/network.c
@@ -84,6 +84,7 @@ struct network {
 	char **nai_realms;
 	uint8_t *rc_ie;
 	bool sync_settings:1;  /* should settings be synced on connect? */
+	bool agent_passphrase_transient:1;
 	bool ask_passphrase:1; /* Whether we should force-ask agent */
 	bool is_hs20:1;
 	bool anqp_pending:1;	/* Set if there is a pending ANQP request */
@@ -324,6 +325,7 @@ static bool __network_set_passphrase(struct network *network,
 
 	network_reset_passphrase(network);
 	network->passphrase = l_strdup(passphrase);
+	network->agent_passphrase_transient = false;
 
 	network->sae_pt_19 = network_generate_sae_pt(network, 19);
 	network->sae_pt_20 = network_generate_sae_pt(network, 20);
@@ -664,6 +666,7 @@ static int network_load_psk(struct network *network, struct scan_bss *bss)
 
 	network_reset_passphrase(network);
 	network_reset_psk(network);
+	network->agent_passphrase_transient = false;
 	network->passphrase = l_steal_ptr(passphrase);
 	network->password_identifier = l_steal_ptr(password_id);
 
@@ -727,6 +730,9 @@ static void network_settings_save(struct network *network,
 	/* We only update the [Security] bits here, wipe the group first */
 	l_settings_remove_group(settings, "Security");
 
+	if (network->agent_passphrase_transient)
+		return;
+
 	if (network->psk)
 		l_settings_set_bytes(settings, "Security", "PreSharedKey",
 					network->psk, 32);
@@ -1316,6 +1322,7 @@ struct scan_bss *network_bss_select(struct network *network,
 
 static void passphrase_callback(enum agent_result result,
 				const char *passphrase,
+				bool store,
 				struct l_dbus_message *message,
 				void *user_data)
 {
@@ -1355,6 +1362,8 @@ static void passphrase_callback(enum agent_result result,
 		goto err;
 	}
 
+	network->agent_passphrase_transient = !store;
+
 	station_connect_network(station, network, bss, message);
 	l_dbus_message_unref(message);
 	return;
@@ -1424,11 +1433,14 @@ static bool eap_secret_info_match_local(const void *a, const void *b)
 }
 
 static void eap_password_callback(enum agent_result result, const char *value,
+					bool store,
 					struct l_dbus_message *message,
 					void *user_data)
 {
 	struct eap_secret_request *req = user_data;
 
+	(void) store;
+
 	req->network->agent_request = 0;
 
 	if (value) {
-- 
2.54.0

