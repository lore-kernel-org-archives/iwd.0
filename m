Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001801A7070
	for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179513; cv=none; b=X0SuFyk8CDd3tdiqA8GRNw/vh9MoMZoJRUL3BGg2KftrxManyV70L8o3gOQoDH5H6C+UTDwqCu5TESRlbhzB/J9D04TmfuqPebdQbRjqgXhf987//dER0mJpJ9VycHefFE29o5GWWzfYCwLPP865uPInckAJYkH1AWuphkC0DNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179513; c=relaxed/simple;
	bh=Tx5Qjb/6pIct0YUF7PFUL23Ag2a44T4TOhBzDrGxal8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uA4DAm+pndR8ESHHnrWwlK9qQGmyM5vSqlWXI9sK/CZoRA6CuoZ78C2MCHmrpHiSpLsYK8FF0H6lLnm/ewd8cmj9BYe/WeWAhx2XiE7uIAy5kvtw1GzRYUuixOZQ+oNTC4W37BON/e9HNczueBylZZFbJA0gKmuR+3p/sqaYdyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzAXbt7V; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzAXbt7V"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6c358b725feso37377196d6.1
        for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 05:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727179511; x=1727784311; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvfVAwe5kKt4axdHz2a/S6EMPXABIqcprO+86garDts=;
        b=JzAXbt7VXI5pnhwnLTV5zIa6J06uY55dSVw9yF+C4KVfNh3y2Odvo8e22V1IJaMGNM
         LhRQDweIye53+otpFlWWDlMIF52eKJIcEo3ASdbJ+4OqTL7TSjmFP7e3epCM5fpFTjbE
         PUoj4tNCSmSLUDKhyBVgwezIwSnk25/K7V9VKRnyvKwDzZK4er0CHIQz+3Od1fhULvR8
         AOzE0ie/HshabX9ZWv1gkieLQD7gBo0DH7yqU1Vzg6fD3ElCMN+yjDkxwAnL415uhvYQ
         j5JPNOw08WlyZPoubVeFY5+V9oaE7OO7NP6OHo9WGF+SRBToMD+EXLvhO3iSzzDhzK2L
         jdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727179511; x=1727784311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvfVAwe5kKt4axdHz2a/S6EMPXABIqcprO+86garDts=;
        b=wOgOpC0mPI0WMm/w4gCJ9oYMBEeXZy8OLw7ZbJQ5BQg5q5p4VhTC6G80qqQ2cJ2f4O
         tfcVF/aYMaokAFYfioLRYpnowLWd5WEa8VrS4BrFNa2mmB7sLeHtxATP9359iAkZKn1k
         bLr2aoFkudwmeBhZk1ymEqC6+5L+q8IE2sDsrC4yyMgJMTtNClU3HgLFcKwnVOuOs53q
         XKjT9raJli/Y6GD2Sju0rBdPs+MXDYKa9VGnRjewE31eKIktqHTbAlxgtUe5Yi3kClx2
         w0AtEG661Kg0AE9dyiPb60QMiImE93aMVfykTHSLqvy6KYk3HPpoZ1SPDXuKyYyM/O8f
         7KxQ==
X-Gm-Message-State: AOJu0Ywd1KI+9iIt2JsvY0jfs6/LiPKt5x8zMRmzDSutTzo2FKAkBkLI
	M9GIpZ/p/qpE2qw4FCKqy3F9O07yiJ/n7Gk4gJbDILQ5ZxBPwzzb1uFWUg==
X-Google-Smtp-Source: AGHT+IHHfKz3vxMGKazH824Fl5KspC9WV/em8X6hjPoXAG+/tMfH7hg+dyTOrKntOkn5fmADLuz7aQ==
X-Received: by 2002:a05:6214:398c:b0:6c5:50bb:d59d with SMTP id 6a1803df08f44-6c7bc7ec5a4mr222238356d6.37.1727179510701;
        Tue, 24 Sep 2024 05:05:10 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4a6178sm5948056d6.7.2024.09.24.05.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:05:10 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 12/16] dpp: replace SharedCodeAgent with DeviceProvisioningAgent
Date: Tue, 24 Sep 2024 05:04:43 -0700
Message-Id: <20240924120447.251761-12-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924120447.251761-1-prestwoj@gmail.com>
References: <20240924120447.251761-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fully removes the SharedCodeAgent which was specific to the PKEX
protocol and replaces it with the more generalized
DeviceProvisioningAgent. The new agent should still implement the
shared code method and effectively behave no differently in that
regard.

The main difference as far as the API is the new agent must be
registered via the AgentManager interface, not passed in via the
method arguments to ConfigureEnrollee().
---
 src/dpp.c | 63 ++++++++++++-------------------------------------------
 1 file changed, 13 insertions(+), 50 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 7b700018..d1912eaf 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -106,13 +106,6 @@ enum dpp_interface {
 	DPP_INTERFACE_PKEX,
 };
 
-struct pkex_agent {
-	char *owner;
-	char *path;
-	unsigned int disconnect_watch;
-	uint32_t pending_id;
-};
-
 struct dpp_sm {
 	struct netdev *netdev;
 	char *uri;
@@ -140,7 +133,6 @@ struct dpp_sm {
 	enum dpp_interface interface;
 
 	uint32_t agent_request_id;
-	struct pkex_agent *agent;
 
 	/*
 	 * List of frequencies to jump between. The presence of this list is
@@ -2088,7 +2080,7 @@ static void dpp_offchannel_timeout(int error, void *user_data)
 
 	switch (dpp->state) {
 	case DPP_STATE_PKEX_EXCHANGE:
-		if (dpp->role != DPP_CAPABILITY_CONFIGURATOR || !dpp->agent)
+		if (dpp->role != DPP_CAPABILITY_CONFIGURATOR || !dpp_agent_name)
 			break;
 
 		/*
@@ -2097,7 +2089,7 @@ static void dpp_offchannel_timeout(int error, void *user_data)
 		 * for our response so cancel the request and continue waiting
 		 * for another request
 		 */
-		if (dpp->agent->pending_id) {
+		if (dpp->agent_request_id) {
 			dpp_free_pending_pkex_data(dpp);
 			dpp_agent_cancel(dpp);
 		}
@@ -3228,10 +3220,10 @@ static void dpp_pkex_agent_reply(struct l_dbus_message *message,
 	const char *error, *text;
 	const char *code;
 
-	dpp->agent->pending_id = 0;
+	dpp->agent_request_id = 0;
 
-	l_debug("SharedCodeAgent %s path %s replied", dpp->agent->owner,
-			dpp->agent->path);
+	l_debug("DeviceProvisioningAgent %s path %s replied", dpp_agent_name,
+			dpp_agent_path);
 
 	if (l_dbus_message_get_error(message, &error, &text)) {
 		l_error("RequestSharedCode(%s) returned %s(\"%s\")",
@@ -3240,7 +3232,7 @@ static void dpp_pkex_agent_reply(struct l_dbus_message *message,
 	}
 
 	if (!l_dbus_message_get_arguments(message, "s", &code)) {
-		l_debug("Invalid arguments, check SharedCodeAgent!");
+		l_debug("Invalid arguments, check DeviceProvisioningAgent!");
 		goto reset;
 	}
 
@@ -3257,25 +3249,25 @@ static bool dpp_pkex_agent_request(struct dpp_sm *dpp)
 {
 	struct l_dbus_message *msg;
 
-	if (!dpp->agent)
+	if (!dpp_agent_name)
 		return false;
 
-	if (L_WARN_ON(dpp->agent->pending_id))
+	if (L_WARN_ON(dpp->agent_request_id))
 		return false;
 
 	msg = l_dbus_message_new_method_call(dbus_get_bus(),
-						dpp->agent->owner,
-						dpp->agent->path,
-						IWD_SHARED_CODE_AGENT_INTERFACE,
+						dpp_agent_name,
+						dpp_agent_path,
+						IWD_DPP_AGENT_INTERFACE,
 						"RequestSharedCode");
 	l_dbus_message_set_arguments(msg, "s", dpp->pkex_id);
 
 
-	dpp->agent->pending_id = l_dbus_send_with_reply(dbus_get_bus(),
+	dpp->agent_request_id = l_dbus_send_with_reply(dbus_get_bus(),
 							msg,
 							dpp_pkex_agent_reply,
 							dpp, NULL);
-	return dpp->agent->pending_id != 0;
+	return dpp->agent_request_id != 0;
 }
 
 static void dpp_handle_pkex_exchange_request(struct dpp_sm *dpp,
@@ -4648,32 +4640,6 @@ invalid_args:
 	return dbus_error_invalid_args(message);
 }
 
-static void pkex_agent_disconnect(struct l_dbus *dbus, void *user_data)
-{
-	struct dpp_sm *dpp = user_data;
-
-	l_debug("SharedCodeAgent %s disconnected", dpp->agent->path);
-
-	dpp_reset(dpp);
-}
-
-static void dpp_create_agent(struct dpp_sm *dpp, const char *path,
-					struct l_dbus_message *message)
-{
-	const char *sender = l_dbus_message_get_sender(message);
-
-	dpp->agent = l_new(struct pkex_agent, 1);
-	dpp->agent->owner = l_strdup(sender);
-	dpp->agent->path = l_strdup(path);
-	dpp->agent->disconnect_watch = l_dbus_add_disconnect_watch(
-							dbus_get_bus(),
-							sender,
-							pkex_agent_disconnect,
-							dpp, NULL);
-
-	l_debug("Registered a SharedCodeAgent on path %s", path);
-}
-
 static struct l_dbus_message *dpp_start_pkex_configurator(struct dpp_sm *dpp,
 					const char *key, const char *identifier,
 					const char *agent_path,
@@ -4708,9 +4674,6 @@ static struct l_dbus_message *dpp_start_pkex_configurator(struct dpp_sm *dpp,
 	if (key)
 		dpp->pkex_key = l_strdup(key);
 
-	if (agent_path)
-		dpp_create_agent(dpp, agent_path, message);
-
 	dpp->role = DPP_CAPABILITY_CONFIGURATOR;
 	dpp->state = DPP_STATE_PKEX_EXCHANGE;
 	dpp->interface = DPP_INTERFACE_PKEX;
-- 
2.34.1

