Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2BB4A0B
	for <iwd@lists.linux.dev>; Wed, 10 Aug 2022 23:16:26 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id g12so15061437pfb.3
        for <iwd@lists.linux.dev>; Wed, 10 Aug 2022 16:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=sjbKpslGm3MRx9TOqkKXNo+KYLOWHmHJqO+DfzSrVX0=;
        b=Ro1uAjefPcQ1Uy7AtagG4oRVMwpcYRGb2ffRs+UQrngXirkO2RqBkQb5muw7xd0GM+
         TOFAMtg9LMGMoYdpf3umHVfxVy0iKJBN0RKXFkiF994iJr12g+gu7ZJ2ePbqZwakKDh6
         x+G9qpMyuCjVZd8LLI/yJrTWWyKoZnonk7APuKEh+ypnGRi+3ENk+E7G9/cxmITZNEQu
         BwCFkPdtHriKOHDwVvrIZc5YuKOl5biTiyLIeFwMx6pMBZ1qYrS8XuS2g3iFsOqn1lF7
         jNs6UN3jP6BvYVfcyqwWw40k5/lcn146DClIk4F6ijrEyYhed+ELjpmXu0XwRdoeeF9B
         N/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=sjbKpslGm3MRx9TOqkKXNo+KYLOWHmHJqO+DfzSrVX0=;
        b=UQRIh+yWpp+wt5NvckiJhlGeCiUJPqAYdZGuc4OhYyl/FOeOuOHEEFrwDzjDsbLnTo
         uhqhIKf15CpDwvpFsjyvmD9np2bbf8fKOkjpuWYL3W08NYs+nSiz4+S8WjdLgWMlvUqw
         j5OceuLWCXiNKLykgaspua9OQNLtJ9NF0iQ79+CZLx/T9CMiamT05+MDF7o3VjX/Lh04
         PVMn5QB/7xOb7aj+ubRV7XEmq9liwPMio00YblaTqiD3YPuG9etNMbpKILMVDh8MYvWV
         kkb1G2nGY81AbWoj+6as5Ekw057jwZvOTQ4haH25PbOUqLnZAGMiHTN2t1mqIaKgWgx+
         MnZg==
X-Gm-Message-State: ACgBeo3b96L51iMZ7IfZB0fP4e4l10kph4EECNoUaVu6jtmdmnYnS74F
	wR6OHMVNQo6/39L1lesKy7YDBQEluKc=
X-Google-Smtp-Source: AA6agR7g0OL4eg2Dgzlh02DC41TqCjvCnnESSnAXr10WF3t2BsV9rgLMBPx820FzI8pAH9ukMoYxnQ==
X-Received: by 2002:a05:6a00:1a44:b0:52a:ecd5:bbef with SMTP id h4-20020a056a001a4400b0052aecd5bbefmr28767611pfv.28.1660173385858;
        Wed, 10 Aug 2022 16:16:25 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id t7-20020a170902e84700b0016d62ba5665sm13540246plg.254.2022.08.10.16.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 16:16:25 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/8] client: allow entity name to be passed to completion
Date: Wed, 10 Aug 2022 16:16:18 -0700
Message-Id: <20220810231621.372514-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220810231621.372514-1-prestwoj@gmail.com>
References: <20220810231621.372514-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a limitation of libreadline where no context/userdata
can be passed to completion functions. This effects iwctl since
the entity value isn't known to completion functions.

Workarounds such as getting the default device are employed but
its not a great solution.

Instead hack around this limitation by parsing the prompt to
extract the entity (second arg). Then use a generic match function
given to readline which can call the actual match function and
include the entity.
---
 client/adapter.c        |  3 ++-
 client/command.c        | 39 ++++++++++++++++++++++++++++++++++++++-
 client/command.h        |  9 ++++++---
 client/device.c         |  3 ++-
 client/known-networks.c |  3 ++-
 client/station.c        |  6 ++++--
 6 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/client/adapter.c b/client/adapter.c
index 394eae0d..1719b970 100644
--- a/client/adapter.c
+++ b/client/adapter.c
@@ -319,7 +319,8 @@ static enum cmd_status cmd_set_property(const char *adapter_name,
 	return CMD_STATUS_TRIGGERED;
 }
 
-static char *set_property_cmd_arg_completion(const char *text, int state)
+static char *set_property_cmd_arg_completion(const char *text, int state,
+						const char *phy)
 {
 	return proxy_property_completion(adapter_properties, text, state);
 }
diff --git a/client/command.c b/client/command.c
index 80599620..835c00c5 100644
--- a/client/command.c
+++ b/client/command.c
@@ -214,20 +214,57 @@ bool command_line_find_token(const char *token, uint8_t num_to_inspect)
 	return false;
 }
 
+/*
+ * Work around readline limitations of not being able to pass a context pointer
+ * to match functions. Set the command match function/entity to these globals
+ * and call a generic match function which can call the _real_ match function
+ * and include the entity.
+ */
+static command_completion_func_t cmd_current_completion_func = NULL;
+static const char *cmd_current_entity = NULL;
+
+static char *cmd_completion_generic(const char *text, int state)
+{
+	return cmd_current_completion_func(text, state, cmd_current_entity);
+}
+
 static char **cmd_completion_match_entity_cmd(const char *cmd, const char *text,
 						const struct command *cmd_list)
 {
 	char **matches = NULL;
 	size_t i;
+	char *family = NULL;
+	char *entity = NULL;
+	char *prompt = NULL;
 
 	for (i = 0; cmd_list[i].cmd; i++) {
+		char *tmp;
+
 		if (strcmp(cmd_list[i].cmd, cmd))
 			continue;
 
 		if (!cmd_list[i].completion)
 			break;
 
-		matches = rl_completion_matches(text, cmd_list[i].completion);
+		if (cmd_list[i].entity) {
+			prompt = rl_copy_text(0, rl_end);
+
+			family = strtok_r(prompt, " ", &tmp);
+			if (!family)
+				goto done;
+
+			entity = strtok_r(NULL, " ", &tmp);
+		}
+
+done:
+		cmd_current_completion_func = cmd_list[i].completion;
+		cmd_current_entity = entity;
+
+		matches = rl_completion_matches(text, cmd_completion_generic);
+
+		l_free(prompt);
+		cmd_current_completion_func = NULL;
+		cmd_current_entity = NULL;
 
 		break;
 	}
diff --git a/client/command.h b/client/command.h
index bdfc7e99..70a54e7e 100644
--- a/client/command.h
+++ b/client/command.h
@@ -25,7 +25,10 @@
 #define COMMAND_OPTION_PASSPHRASE	"passphrase"
 #define COMMAND_OPTION_DONTASK		"dont-ask"
 
-typedef char *(*command_completion_func_t) (const char *text, int state);
+typedef char *(*command_completion_func_t)(const char *text, int state,
+						const char *entity);
+typedef char *(*command_rl_completion_func_t)(const char *text, int state);
+
 
 enum cmd_status {
 	CMD_STATUS_TRIGGERED,
@@ -51,8 +54,8 @@ struct command_family {
 	const char *caption;
 	const char *name;
 	const struct command *command_list;
-	command_completion_func_t family_arg_completion;
-	command_completion_func_t entity_arg_completion;
+	command_rl_completion_func_t family_arg_completion;
+	command_rl_completion_func_t entity_arg_completion;
 	void (*set_default_entity)(const char *entity);
 	void (*reset_default_entity)(void);
 };
diff --git a/client/device.c b/client/device.c
index 9f8d731c..8b27ddd2 100644
--- a/client/device.c
+++ b/client/device.c
@@ -398,7 +398,8 @@ static enum cmd_status cmd_set_property(const char *device_name,
 	return CMD_STATUS_TRIGGERED;
 }
 
-static char *set_property_cmd_arg_completion(const char *text, int state)
+static char *set_property_cmd_arg_completion(const char *text, int state,
+						const char *device_name)
 {
 	return proxy_property_completion(device_properties, text, state);
 }
diff --git a/client/known-networks.c b/client/known-networks.c
index 56c34a2e..b2023e35 100644
--- a/client/known-networks.c
+++ b/client/known-networks.c
@@ -387,7 +387,8 @@ static enum cmd_status cmd_set_property(const char *network_name,
 	return CMD_STATUS_TRIGGERED;
 }
 
-static char *set_property_cmd_arg_completion(const char *text, int state)
+static char *set_property_cmd_arg_completion(const char *text, int state,
+						const char *network_name)
 {
 	return proxy_property_completion(known_network_properties, text, state);
 }
diff --git a/client/station.c b/client/station.c
index 64becdbd..90291c88 100644
--- a/client/station.c
+++ b/client/station.c
@@ -277,7 +277,8 @@ static enum cmd_status cmd_list(const char *device_name, char **argv, int argc)
 	return CMD_STATUS_DONE;
 }
 
-static char *connect_cmd_arg_completion(const char *text, int state)
+static char *connect_cmd_arg_completion(const char *text, int state,
+					const char *device_name)
 {
 	const struct proxy_interface *device = device_get_default();
 
@@ -489,7 +490,8 @@ static void ordered_networks_callback(struct l_dbus_message *message,
 	l_queue_destroy(networks, ordered_networks_destroy);
 }
 
-static char *get_networks_cmd_arg_completion(const char *text, int state)
+static char *get_networks_cmd_arg_completion(const char *text, int state,
+						const char *device_name)
 {
 	static int index;
 	static int len;
-- 
2.34.3

