Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C901A707F
	for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179511; cv=none; b=uVxTp4pdFtuIRY67Ig+E3P9lq4V7tcFl9ObqoC+PQFgweZ/zLTtGBqS7Lpxn/U3GJwreYIIxIhJR1qUVBn7O4NNkbR6mgU2GD5Mpa/Ybg8FsY4gWCNfryO5n0IoN/RSog5b1y6YiKpb0+Xfc94jeaVFBB/qZXtNSfwlGCo+MQnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179511; c=relaxed/simple;
	bh=GtViNlQFKwvuLX4mnn8PIBFpPm+0UeD9yTz6Exjz3Sk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ea3jQYochf8d0lHd/VQEX+25dGz3M4iS/v7vJG1lxG3ZdtRJGOlKaTJLUpkcR72GuYNSA71BOQ/fNHB+xPbNGZNT3HNt2NA0bWLTGcxhCXwQN0inHEIGt7P1wU+SRkSWmjqwAd+efF7Gtqn4nS1trEqiUu447ddZZKXW//rOZA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNyqmM0s; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNyqmM0s"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6c56eec7fccso37924926d6.3
        for <iwd@lists.linux.dev>; Tue, 24 Sep 2024 05:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727179508; x=1727784308; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnTArKTL+e0C2Y6q/FbHwZZp+7nEAeSnKbzJj5QJ0II=;
        b=lNyqmM0spci247urh9p41cNl89LtJdWPmWQ+al+z+QzgWypT3bLzc2+GjNlV8EXkfD
         ctgqY++Ul5/ktKfEi5iZJni2F4VJk9GreHG+XMuqwvYVhG4RxBOu53TpB5XQ3AtRNyuo
         Suptwszxyq9pWG+r9HzZCa6Si16puXawn3OU+ame5nff/+N8aF4h63iknOhfhOl35cyC
         Iy3u6HuBqPQcs5djt4Qe4zxVvwM47XN5mg9tSfzZd4WtkYykSlcaR3rMOq4+vsTgDN2C
         31Sy5piPVTcoqHFJPcHUUsoG6u1vmkmeR3y4LjDRZH6HfsxxD5zuxGWM1xwYKbdQZPd8
         hgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727179508; x=1727784308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JnTArKTL+e0C2Y6q/FbHwZZp+7nEAeSnKbzJj5QJ0II=;
        b=A4FFc41QzRJQZ9kMW8xOZIwl5mUhFSICzB7F3lWQr/+0k3u3NSFjEBNMdf76bl6xBQ
         3ZZg2Lxm2eibaxJGMFdRTYJxrK3awFPYZ7FXsNRWhwjW3Tvet2/ZZ180CmXsZv4NhW3V
         JtUIbed1rUmfVaHbBMXk5nXaQuyaZCNoyIkopzmDFh2U2gyAETY2+Dsh5RwO4gwP+z3f
         HQugtQPIGQFReuCEytJyPgp6h8RgeUYG6h3kfXN0hdfZlzx22bLhsLiD7FeLix6jucrM
         sIOkBMbqlHwR4lKcrRSh8WN9sYwFfG8v3Nus19NOgX+vbb/kY7An90cQu4C5W1AmaqWx
         Xjiw==
X-Gm-Message-State: AOJu0Yy4zWtGQswceT0OPutbOfLi+bfg0nA/1dtv5KNKul1dqC91WESg
	AmGD+x+oThhdIuvgkSvINSCfxYD07GMS5GofKNGpqTRYl7M5qEcK7cSKYg==
X-Google-Smtp-Source: AGHT+IFw9RuD0k/UiSOk9vlbq2GRMFx+PQ3ivzYkAb2G8mayAM0JVotOeFlN+Uy1JeT8MoZrOHVizg==
X-Received: by 2002:a05:6214:4383:b0:6c5:aae1:6442 with SMTP id 6a1803df08f44-6c7bc67fc87mr184395136d6.15.1727179508232;
        Tue, 24 Sep 2024 05:05:08 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb0f4a6178sm5948056d6.7.2024.09.24.05.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:05:07 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 10/16] dpp: replace PKEX agent with generic DPP agent
Date: Tue, 24 Sep 2024 05:04:41 -0700
Message-Id: <20240924120447.251761-10-prestwoj@gmail.com>
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

This is one of two commits which replaces the existing shared code
agent with a generic DPP agent. This commit alone breaks DPP PKEX
but the next will fully remove the PKEX agent in place of the new
generic agent.

This is being done to prepare for enterprise DPP configuration where
additional agent APIs will be needed. Rather than invent a new
agent type it makes sense to bundle both into one and just define
separate methods, PKEX/Enterprise.
---
 src/dpp.c | 168 +++++++++++++++++++++++++++++++++++-------------------
 src/dpp.h |  24 ++++++++
 2 files changed, 133 insertions(+), 59 deletions(-)
 create mode 100644 src/dpp.h

diff --git a/src/dpp.c b/src/dpp.c
index 3ad60188..7b700018 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -54,6 +54,7 @@
 #include "src/handshake.h"
 #include "src/nl80211util.h"
 #include "src/knownnetworks.h"
+#include "src/dpp.h"
 
 #define DPP_FRAME_MAX_RETRIES 5
 #define DPP_FRAME_RETRY_TIMEOUT 1
@@ -81,6 +82,10 @@ static uint32_t unicast_watch;
 
 static uint8_t dpp_prefix[] = { 0x04, 0x09, 0x50, 0x6f, 0x9a, 0x1a, 0x01 };
 
+static char *dpp_agent_name;
+static char *dpp_agent_path;
+static unsigned int dpp_agent_watch;
+
 enum dpp_state {
 	DPP_STATE_NOTHING,
 	DPP_STATE_PRESENCE,
@@ -134,6 +139,7 @@ struct dpp_sm {
 	enum dpp_state state;
 	enum dpp_interface interface;
 
+	uint32_t agent_request_id;
 	struct pkex_agent *agent;
 
 	/*
@@ -373,64 +379,6 @@ static void dpp_free_pending_pkex_data(struct dpp_sm *dpp)
 	}
 }
 
-static void pkex_agent_free(void *data)
-{
-	struct pkex_agent *agent = data;
-
-	l_free(agent->owner);
-	l_free(agent->path);
-	l_dbus_remove_watch(dbus_get_bus(), agent->disconnect_watch);
-	l_free(agent);
-}
-
-static void dpp_agent_cancel(struct dpp_sm *dpp)
-{
-	struct l_dbus_message *msg;
-
-	const char *reason = "shutdown";
-
-	msg = l_dbus_message_new_method_call(dbus_get_bus(),
-						dpp->agent->owner,
-						dpp->agent->path,
-						IWD_SHARED_CODE_AGENT_INTERFACE,
-						"Cancel");
-	l_dbus_message_set_arguments(msg, "s", reason);
-	l_dbus_message_set_no_reply(msg, true);
-	l_dbus_send(dbus_get_bus(), msg);
-}
-
-static void dpp_agent_release(struct dpp_sm *dpp)
-{
-	struct l_dbus_message *msg;
-
-	msg = l_dbus_message_new_method_call(dbus_get_bus(),
-						dpp->agent->owner,
-						dpp->agent->path,
-						IWD_SHARED_CODE_AGENT_INTERFACE,
-						"Release");
-	l_dbus_message_set_arguments(msg, "");
-	l_dbus_message_set_no_reply(msg, true);
-	l_dbus_send(dbus_get_bus(), msg);
-}
-
-static void dpp_destroy_agent(struct dpp_sm *dpp)
-{
-	if (!dpp->agent)
-		return;
-
-	if (dpp->agent->pending_id) {
-		dpp_agent_cancel(dpp);
-		l_dbus_cancel(dbus_get_bus(), dpp->agent->pending_id);
-	}
-
-	dpp_agent_release(dpp);
-
-	l_debug("Released SharedCodeAgent on path %s", dpp->agent->path);
-
-	pkex_agent_free(dpp->agent);
-	dpp->agent = NULL;
-}
-
 static void dpp_free_auth_data(struct dpp_sm *dpp)
 {
 	if (dpp->own_proto_public) {
@@ -480,6 +428,47 @@ static void dpp_free_auth_data(struct dpp_sm *dpp)
 
 }
 
+static void dpp_agent_cancel(struct dpp_sm *dpp)
+{
+	struct l_dbus_message *msg;
+	const char *reason = "shutdown";
+
+	if (L_WARN_ON(!dpp_agent_name))
+		return;
+
+	msg = l_dbus_message_new_method_call(dbus_get_bus(),
+						dpp_agent_name,
+						dpp_agent_path,
+						IWD_DPP_AGENT_INTERFACE,
+						"CancelSharedCode");
+	l_dbus_message_set_arguments(msg, "s", reason);
+	l_dbus_message_set_no_reply(msg, true);
+	l_dbus_send(dbus_get_bus(), msg);
+
+	l_dbus_cancel(dbus_get_bus(), dpp->agent_request_id);
+	dpp->agent_request_id = 0;
+}
+
+static void dpp_agent_release(void)
+{
+	struct l_dbus_message *msg;
+
+	if (L_WARN_ON(!dpp_agent_name))
+		return;
+
+	msg = l_dbus_message_new_method_call(dbus_get_bus(),
+						dpp_agent_name,
+						dpp_agent_path,
+						IWD_DPP_AGENT_INTERFACE,
+						"Release");
+	l_dbus_message_set_arguments(msg, "");
+	l_dbus_message_set_no_reply(msg, true);
+	l_dbus_send(dbus_get_bus(), msg);
+
+	l_dbus_remove_watch(dbus_get_bus(), dpp_agent_watch);
+}
+
+
 static void dpp_reset(struct dpp_sm *dpp)
 {
 	struct station *station = station_find(netdev_get_ifindex(dpp->netdev));
@@ -555,7 +544,8 @@ static void dpp_reset(struct dpp_sm *dpp)
 	explicit_bzero(dpp->z, dpp->key_len);
 	explicit_bzero(dpp->u, dpp->u_len);
 
-	dpp_destroy_agent(dpp);
+	if (dpp->agent_request_id)
+		dpp_agent_cancel(dpp);
 
 	dpp_free_pending_pkex_data(dpp);
 
@@ -599,6 +589,63 @@ static void dpp_free(struct dpp_sm *dpp)
 	l_free(dpp);
 }
 
+static void dpp_agent_disconnect_cb(struct l_dbus *dbus, void *user_data)
+{
+	const struct l_queue_entry *e;
+
+	l_debug("DPP agent disconnected");
+
+	for (e = l_queue_get_entries(dpp_list); e; e = e->next) {
+		struct dpp_sm *dpp = e->data;
+
+		/*
+		 * If this DPP SM was in the process of making an agent request
+		 * this protocol run won't complete, reset
+		 */
+		if (dpp->agent_request_id)
+			dpp_reset(dpp);
+	}
+
+	l_dbus_remove_watch(dbus, dpp_agent_watch);
+}
+
+static void dpp_agent_watch_destroy(void *user_data)
+{
+	dpp_agent_watch = 0;
+
+	l_free(dpp_agent_name);
+	dpp_agent_name = NULL;
+	l_free(dpp_agent_path);
+	dpp_agent_path = NULL;
+}
+
+int dpp_register_agent(const char *name, const char *path)
+{
+	if (dpp_agent_path)
+		return -EEXIST;
+
+	dpp_agent_name = l_strdup(name);
+	dpp_agent_path = l_strdup(path);
+	dpp_agent_watch = l_dbus_add_disconnect_watch(dbus_get_bus(),
+						name,
+						dpp_agent_disconnect_cb,
+						NULL, dpp_agent_watch_destroy);
+	return 0;
+}
+
+int dpp_unregister_agent(const char *name, const char *path)
+{
+	if (!dpp_agent_path || strcmp(dpp_agent_path, path))
+		return -ENOENT;
+
+	if (strcmp(dpp_agent_name, name))
+		return -EPERM;
+
+	l_dbus_remove_watch(dbus_get_bus(), dpp_agent_watch);
+
+	return 0;
+}
+
 static void dpp_send_frame_cb(struct l_genl_msg *msg, void *user_data)
 {
 	struct dpp_sm *dpp = user_data;
@@ -4832,6 +4879,9 @@ static void dpp_exit(void)
 	nl80211 = NULL;
 
 	l_queue_destroy(dpp_list, (l_queue_destroy_func_t) dpp_free);
+
+	if (dpp_agent_name)
+		dpp_agent_release();
 }
 
 IWD_MODULE(dpp, dpp_init, dpp_exit);
diff --git a/src/dpp.h b/src/dpp.h
new file mode 100644
index 00000000..d66deb52
--- /dev/null
+++ b/src/dpp.h
@@ -0,0 +1,24 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2024  Locus Robotics. All rights reserved.
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+int dpp_register_agent(const char *name, const char *path);
+int dpp_unregister_agent(const char *name, const char *path);
-- 
2.34.1

