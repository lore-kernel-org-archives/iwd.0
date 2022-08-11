Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6942E46AC
	for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 17:59:07 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id g12so17127687pfb.3
        for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=bQHd1bKvsoQtg+sNOI9cwdpCJrHos8NUF8yaXX7/Q9E=;
        b=Mcm4M74fZOgj81Vz44FdvbD1z/LL9P9AyqHQdRcCi7/wmQ5bP6jcfPFzK5hcDqCyQi
         qYwJ69SA4ilaYpEtimjQQmrfR/apbqKztJPB3mFaRZmoRMdwqY+SaPFTU13luOyR4hYR
         UCDmAHR+IGkn8uRawRYmrgzux27pvGsvrW0y5fdc2DAVDz/uyFMeBM25838vvl//V9Ug
         9gVYHzV6quaVCMBYFnujPfGdL0QyEDxu7Ey7Sia0QehZphofH915rgZo7po0REI5/L7z
         gHAyj0TIlxsz9ZER9qBkBsPjskaXWgZ0QpoeihTJeluvASn6fsGh8H4yuSjdJSSOCe2f
         zsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bQHd1bKvsoQtg+sNOI9cwdpCJrHos8NUF8yaXX7/Q9E=;
        b=7jstHIB35eL5LpkS2qCw2C257C22I7AvPmbEk35g7OiX4b/UHnh0jhr/lxbZQE+DJG
         elm/XVgxPhSp2J9RjJdiIlNLG2yfXzAeFhwlDK7vAGdaw+cdYyGb8YMG6K2pEdAiZPm9
         kfHgtH/O3F22WmOolrkBL3gI6vB8XQydtM8P/TyZQYKeAlOg5Fbpl1VQYNIuAEUJzYez
         /N9qDO5DWRjtILCYUBmMOW2cVq82D/EBNh0TWFH2TSNUmkLn6zRkynKXM/CmC6lq7QoE
         fUw/XlJ4pYNL9QLY9Wlk9ALiZZK8kTJcvVmGD4wKLjBk9mN+MPMXNWarmD3aooOD/wTL
         dBig==
X-Gm-Message-State: ACgBeo3hgU3+fAzkFIKxv12KcpDOmvg6ssqFfjkMt4ITt6rQGMsYNIRN
	ZkEKYCBMT7LhAOF40zEWq7ap0toXw/c=
X-Google-Smtp-Source: AA6agR4AIsvfQbmR4zgc0GMiQRxllsiXeUCi4IPvsD8Ck3NH69Ozx9CxfQGMp7rUCnrJKypo8AKMJA==
X-Received: by 2002:a63:d750:0:b0:41b:3eec:f9d0 with SMTP id w16-20020a63d750000000b0041b3eecf9d0mr163361pgi.289.1660240746659;
        Thu, 11 Aug 2022 10:59:06 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w125-20020a626283000000b0052ab602a7d0sm4292685pfb.100.2022.08.11.10.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 10:59:06 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 6/6] device: command: remove default device concept
Date: Thu, 11 Aug 2022 10:59:00 -0700
Message-Id: <20220811175900.443310-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220811175900.443310-1-prestwoj@gmail.com>
References: <20220811175900.443310-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was quite a bit of framework behind setting/resetting a default
device, which is now no longer needed.
---
 client/command.c    | 18 ----------------
 client/command.h    |  3 ---
 client/dbus-proxy.c |  2 --
 client/device.c     | 50 ---------------------------------------------
 4 files changed, 73 deletions(-)

diff --git a/client/command.c b/client/command.c
index 46752c72..dbd97703 100644
--- a/client/command.c
+++ b/client/command.c
@@ -329,9 +329,6 @@ static char **cmd_completion_match_family_cmd(const char *cmd_family,
 			break;
 		}
 
-		if (family->set_default_entity)
-			family->set_default_entity(arg1);
-
 		matches = cmd_completion_match_entity_cmd(arg2, text,
 							family->command_list);
 
@@ -663,21 +660,6 @@ int command_get_exit_status(void)
 	return exit_status;
 }
 
-void command_reset_default_entities(void)
-{
-	const struct l_queue_entry *entry;
-
-	for (entry = l_queue_get_entries(command_families); entry;
-							entry = entry->next) {
-		struct command_family *family = entry->data;
-
-		if (!family->reset_default_entity)
-			continue;
-
-		family->reset_default_entity();
-	}
-}
-
 void command_family_register(const struct command_family *family)
 {
 	l_queue_push_tail(command_families, (void *) family);
diff --git a/client/command.h b/client/command.h
index 1f841689..96eefdec 100644
--- a/client/command.h
+++ b/client/command.h
@@ -56,8 +56,6 @@ struct command_family {
 	const struct command *command_list;
 	command_rl_completion_func_t family_arg_completion;
 	command_rl_completion_func_t entity_arg_completion;
-	void (*set_default_entity)(const char *entity);
-	void (*reset_default_entity)(void);
 };
 
 bool command_option_get(const char *name, const char **value_out);
@@ -74,7 +72,6 @@ void command_noninteractive_trigger(void);
 bool command_is_interactive_mode(void);
 int command_get_exit_status(void);
 void command_set_exit_status(int status);
-void command_reset_default_entities(void);
 
 void command_family_register(const struct command_family *family);
 void command_family_unregister(const struct command_family *family);
diff --git a/client/dbus-proxy.c b/client/dbus-proxy.c
index 1534488e..42b8427f 100644
--- a/client/dbus-proxy.c
+++ b/client/dbus-proxy.c
@@ -806,8 +806,6 @@ static void service_disappeared_callback(struct l_dbus *dbus,
 
 	l_queue_clear(proxy_interfaces, proxy_interface_destroy);
 
-	command_reset_default_entities();
-
 	display_disable_cmd_prompt();
 }
 
diff --git a/client/device.c b/client/device.c
index 8b27ddd2..ce2afc81 100644
--- a/client/device.c
+++ b/client/device.c
@@ -42,8 +42,6 @@ struct device {
 	const struct proxy_interface *adapter;
 };
 
-static struct proxy_interface *default_device;
-
 static void display_device(const struct proxy_interface *proxy)
 {
 	const struct device *device = proxy_interface_get_data(proxy);
@@ -260,52 +258,6 @@ static bool match_by_partial_name(const void *a, const void *b)
 	return !strncmp(device->name, text, strlen(text));
 }
 
-static bool match_all(const void *a, const void *b)
-{
-	return true;
-}
-
-static void device_set_default(const char *device_name)
-{
-	struct l_queue *match;
-
-	if (!device_name)
-		return;
-
-	match = proxy_interface_find_all(device_interface_type.interface,
-						match_by_name, device_name);
-
-	if (!match)
-		return;
-
-	default_device = l_queue_pop_head(match);
-	l_queue_destroy(match, NULL);
-}
-
-static void device_reset_default(void)
-{
-	default_device = NULL;
-}
-
-const struct proxy_interface *device_get_default(void)
-{
-	struct l_queue *match;
-
-	if (default_device)
-		return default_device;
-
-	match = proxy_interface_find_all(device_interface_type.interface,
-							match_all, NULL);
-
-	if (!match)
-		return NULL;
-
-	default_device = l_queue_pop_head(match);
-	l_queue_destroy(match, NULL);
-
-	return default_device;
-}
-
 const struct proxy_interface *device_proxy_find_by_name(const char *name)
 {
 	struct l_queue *match;
@@ -464,8 +416,6 @@ static struct command_family device_command_family = {
 	.command_list = device_commands,
 	.family_arg_completion = family_arg_completion,
 	.entity_arg_completion = entity_arg_completion,
-	.set_default_entity = device_set_default,
-	.reset_default_entity = device_reset_default,
 };
 
 static int device_command_family_init(void)
-- 
2.34.3

