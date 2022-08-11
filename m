Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBD54A13
	for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 18:47:39 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so5935880pjf.2
        for <iwd@lists.linux.dev>; Thu, 11 Aug 2022 11:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=E81VTOvPCEUHxm0VJkd0oBTpejh7M3DlPSx5n7K/QDU=;
        b=qDiJajsU08aKBC39HCOo1PO7Ng8RH1JEx7UBEcvNlqX4UDIpqxP6t1pzq1Ub/U0SFh
         03F7MEcC0pR1PrvmwZdXMxYvwJ+0CNdgjECLxm4IDLcVZL8JTu1hcqVW53HWwoGEaHby
         ItmTp6FNPGGWeyVU0pUtIKNJ0Bn1fGP2JYHYG+uL3F6wE/B1bv5tQAsum8F00cghmOwI
         D08taZ6zqlvuzONQIikOpI0T3CsUflM8ow/35ygmEG72HJTHpVxmH2nDxyPgdzyNlvV5
         P+cGXWinKmYq+KatQnCWLUvkNVQ2mXNK26sL7uV4sqalv36c43RGiTqYLWa4dVnkgI96
         9I8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=E81VTOvPCEUHxm0VJkd0oBTpejh7M3DlPSx5n7K/QDU=;
        b=PA/mn2CU3D0q/HJDm7iwY2NPvALQtzWHTFvTiLJMj85JRk7LeYZX/+QBDv8L0B07B5
         4uOoE8blYCts7SXmQ8qx4gwHvwsRs6JWqeJ+AbDosrqqP/+5CZX4rEY5fnFuHi6L+gfN
         YjfgwKZNdcRL0uwDz8y0QbjTVVK7WkTOAF3aiKE8dICMICqsehb6MKFA64t165GY5Kv7
         2cdrLxTOQaC4Wqk+LmfK8y3rFbljw9YvGxE2p5bOL6fp1/WidUA4/gQI9Pu1dlQI7x02
         ocOjzOqF1znMQkzS5dYhQDB9Co5svXT7mKtzKKG0V5VLtEDKgbvaZglRGuE6gBVIzbp9
         GSKw==
X-Gm-Message-State: ACgBeo3lBBVytL4j4gvOtKQ1qqmUt3P5Sk2I6lpFEipl2fY3E0TLYmyU
	wCfAYxEaH4JaO3QLkWr09stTEp7hu1I=
X-Google-Smtp-Source: AA6agR4XTObz+UuW9yqZuUpB/DxWU6hdk50ie9jAtko/8cyN8kpDRxoT9baZVL/RV78II2ay9ZsPRQ==
X-Received: by 2002:a17:902:ec8e:b0:16d:d156:2bf1 with SMTP id x14-20020a170902ec8e00b0016dd1562bf1mr517192plg.17.1660243659046;
        Thu, 11 Aug 2022 11:47:39 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79983000000b0052b84ca900csm24986pfh.62.2022.08.11.11.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 11:47:38 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/6] client: allow entity name to be passed to completion
Date: Thu, 11 Aug 2022 11:47:32 -0700
Message-Id: <20220811184735.465951-3-prestwoj@gmail.com>
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
index c0576e97..46752c72 100644
--- a/client/command.c
+++ b/client/command.c
@@ -213,20 +213,57 @@ bool command_line_find_token(const char *token, uint8_t num_to_inspect)
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
index 23f23dc9..1f841689 100644
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

