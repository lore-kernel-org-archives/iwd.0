Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2B64A1C
	for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 18:47:41 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so5928186pjf.5
        for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 11:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=bQHd1bKvsoQtg+sNOI9cwdpCJrHos8NUF8yaXX7/Q9E=;
        b=eIs5JB1zivf3pm+Oo2RzdKIoX9K9TckHGSd1rmx02CdkdGTunbNkQDCkZoasb7AWNA
         07rSGxpiBqPXefiF9d2L/cM/t4OHqfvc9KTDajGVfLzUpMvMqz7J19kzb+OfpmQWvoKW
         ELmNCKHeJF+FmuET/vdbRTF/eFGaAWfqDnErjRZ91/NfnEDpvo6dvhSVDx2glIv4ejtk
         2wCa7iuI8NvKHjEC0HZMgRl+CFscPOy8rFOTEyEQvELlrhcSWkdCUj3V0jC5Kml46jd+
         +dls4mSjqJQdpDcLWICIjULW/yKOhZCl4CL/oD4nGHqd9h0DOM7vqz0P9TJNJAZ7PMOG
         Tkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=bQHd1bKvsoQtg+sNOI9cwdpCJrHos8NUF8yaXX7/Q9E=;
        b=RwTKa0+o/ax398797WUO8yy8go/dB5JwsXJ27Mtt4br6UEJFtq5weUmrUUtmDhy6+I
         74/di6oBTfBKnY7xVGLssJ5LKwBMXqZHsIhVAhlFkOv5NmeAy5OjJZeMTNgSyYaUUJXz
         Yqt5yVo6HV0gR5Jk6jSdxfLfTOLfexbBn+GDbnagbP4aQnZOZdhU2aBz/vmaMLgW1OAR
         XKApK+TFRsi5CRYIOnpDt1P6aWuU+WblRzWGhnnRpW44Lg85RHdhiuukJm7zwAf3sgHE
         qxPfagHZRTunxeMBosxzpNdvUyoVj+AnyvfoN67pVmU9CNEUR3Ga0e3neVptW+f+p3pk
         xeCw==
X-Gm-Message-State: ACgBeo1LztFYraq2ly2XcpjYagsk4pssldh3ylx0aUHvM+dnHzOzInkS
	l/wvnerKIT/BnLvs1mpbfeZ9FWfHvCk=
X-Google-Smtp-Source: AA6agR4iZQ6tKxIVN2j4fLhu6Rfp3KU4VxPHOJpP2gK69BeFtxg8pSa8gnoqTkbKNUllfoqhyDJMhA==
X-Received: by 2002:a17:902:f314:b0:16d:c219:55a1 with SMTP id c20-20020a170902f31400b0016dc21955a1mr496975ple.171.1660243660835;
        Thu, 11 Aug 2022 11:47:40 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79983000000b0052b84ca900csm24986pfh.62.2022.08.11.11.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 11:47:40 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 6/6] device: command: remove default device concept
Date: Thu, 11 Aug 2022 11:47:35 -0700
Message-Id: <20220811184735.465951-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220811184735.465951-1-prestwoj@gmail.com>
References: <20220811184735.465951-1-prestwoj@gmail.com>
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

