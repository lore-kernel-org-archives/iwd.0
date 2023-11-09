Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A110FD2ED
	for <iwd@lists.linux.dev>; Thu,  9 Nov 2023 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMCDhZFi"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5a7b3d33663so14542427b3.3
        for <iwd@lists.linux.dev>; Thu, 09 Nov 2023 10:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699555777; x=1700160577; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9YAarbmNpolP1ZG9eSIyOxMMk4mK08bkRdOlD5HRE4=;
        b=IMCDhZFiPRKlAybOO7oM30Btsj3TJu46cgy8ysE75piYVedJGE8ragmcQOKdo98+wc
         zxwg92HV6WfjOGweTTi05Ys3fOSAJjSLSZYG8qJVrtn2GTYUQVxaIVh804W8Ra4Fbnec
         caMvJDpZZx9voUUrsrY3IfTMoliVqjeK7kRc9ajN0Dd+BmZHRzH/XroiLrHqNYgR/45E
         0YMjr0OM2Ttkt7XfyFGNJ4tLFmphoF43/XtE5Zct9AbPRRJfnIjI3+VQmrZ4WN9JYbNE
         HuQMZh1gWbRaS4jt/a+mGT8GewN4l6jqJW2DJg+FGbAYxSavXAZqH/R+4gNrVpyCXy8i
         XXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699555777; x=1700160577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9YAarbmNpolP1ZG9eSIyOxMMk4mK08bkRdOlD5HRE4=;
        b=r173dHZhZAj5BracPdWdAvGyemBFWFIlUdFd8XfwwzYHbWHZjfeCXIIgzf8rPODYF+
         WNaEp9u77IJN89o1JttO1AQ/VAUYn+7RsFUxlV2k8EHjyZclzuB0xu1rMkv+lL6y24P5
         36z4TFJdoSttdzYS8DZ+ckz/xYlnvp2g28MTT1NJCbYWrerophWo6ybGxaRq4SfGW10V
         Y+PKogWGtQhPoZ94QFPUY6sBFptQQ8fnIfnD/HKHQgHZCywzXNzOk1SyHnqKbJU92jGn
         T7y+7QhqsyC7Arn3vQ9nvdLw6T79adwStbSzIkQJT4AxfPFAzAkmbomwRu/SJOTkEvYR
         Vgbg==
X-Gm-Message-State: AOJu0YwaYDctF0JWY1Mo4YIselJ15qKndjSJrG7ddvplHEPmPGe0GLP0
	tZR7RQipYceNRy7veGWl/4T++w+hNW4=
X-Google-Smtp-Source: AGHT+IFvPnywwYTMJyixu9utFB67qkOp/FeeYFocjvJrnB7FyUwDac2xCGIaVFFvsJiSLsZ1F95nZQ==
X-Received: by 2002:a81:7106:0:b0:5a7:b560:12df with SMTP id m6-20020a817106000000b005a7b56012dfmr6186920ywc.8.1699555777319;
        Thu, 09 Nov 2023 10:49:37 -0800 (PST)
Received: from LOCLAP699.rst-07.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id en6-20020a05690c2b8600b0057a44e20fb8sm7961871ywb.73.2023.11.09.10.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 10:49:37 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] client: add client commands for shared code configuration
Date: Thu,  9 Nov 2023 10:49:26 -0800
Message-Id: <20231109184926.52629-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231109184926.52629-1-prestwoj@gmail.com>
References: <20231109184926.52629-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The StartConfigurator() call was left out since there would be no
functional difference to the user in iwctl. Its expected that
human users of the shared code API provide the code/id ahead of
time, i.e. use ConfigureEnrollee/StartEnrollee.
---
 Makefile.am       |   3 +-
 client/dpp-pkex.c | 342 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 344 insertions(+), 1 deletion(-)
 create mode 100644 client/dpp-pkex.c

diff --git a/Makefile.am b/Makefile.am
index 2e962153..d0247faf 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -314,7 +314,8 @@ client_iwctl_SOURCES = client/main.c \
 			client/wsc.c client/station.c \
 			client/diagnostic.c client/diagnostic.h \
 			client/daemon.c client/daemon.h \
-			client/dpp.c client/station-debug.c \
+			client/dpp.c client/dpp-pkex.c \
+			client/station-debug.c \
 			src/util.c src/util.h \
 			src/band.c src/band.h
 
diff --git a/client/dpp-pkex.c b/client/dpp-pkex.c
new file mode 100644
index 00000000..7a6934e1
--- /dev/null
+++ b/client/dpp-pkex.c
@@ -0,0 +1,342 @@
+/*
+ *
+ *  Wireless daemon for Linux
+ *
+ *  Copyright (C) 2023  Intel Corporation. All rights reserved.
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <linux/limits.h>
+
+#include <ell/ell.h>
+
+#include "client/command.h"
+#include "client/dbus-proxy.h"
+#include "client/device.h"
+#include "client/display.h"
+#include "src/util.h"
+
+struct pkex {
+	bool started;
+	char *role;
+};
+
+static void *pkex_create(void)
+{
+	return l_new(struct pkex, 1);
+}
+
+static void pkex_destroy(void *data)
+{
+	struct pkex *pkex = data;
+
+	l_free(pkex->role);
+	l_free(pkex);
+}
+
+static void display_pkex_inline(const char *margin, const void *data)
+{
+	const struct proxy_interface *pkex_i = data;
+	struct proxy_interface *device_i =
+		proxy_interface_find(IWD_DEVICE_INTERFACE,
+					proxy_interface_get_path(pkex_i));
+	const char *identity;
+
+	if (!device_i)
+		return;
+
+	identity = proxy_interface_get_identity_str(device_i);
+	if (!identity)
+		return;
+
+	display("%s%-*s\n", margin, 20, identity);
+}
+
+static void check_errors_method_callback(struct l_dbus_message *message,
+								void *user_data)
+{
+	dbus_message_has_error(message);
+}
+
+static enum cmd_status cmd_list(const char *device_name, char **argv, int argc)
+{
+	const struct l_queue_entry *entry;
+	struct l_queue *match =
+		proxy_interface_find_all(IWD_DPP_PKEX_INTERFACE, NULL, NULL);
+
+	display_table_header("DPP-PKEX-capable Devices",
+				MARGIN "%-*s", 20, "Name");
+
+	if (!match) {
+		display("No DPP-PKEX-capable devices available\n");
+		display_table_footer();
+
+		return CMD_STATUS_DONE;
+	}
+
+	for (entry = l_queue_get_entries(match); entry; entry = entry->next) {
+		const struct proxy_interface *pkex = entry->data;
+		display_pkex_inline(MARGIN, pkex);
+	}
+
+	display_table_footer();
+
+	l_queue_destroy(match, NULL);
+
+	return CMD_STATUS_DONE;
+}
+
+static bool append_dict_basic(struct l_dbus_message_builder *builder,
+				const char *name, char type,
+				const void *data)
+{
+	char strtype[] = { type, '\0' };
+
+	if (!l_dbus_message_builder_enter_dict(builder, "sv"))
+		return false;
+	if (!l_dbus_message_builder_append_basic(builder, 's', name))
+		return false;
+	if (!l_dbus_message_builder_enter_variant(builder, strtype))
+		return false;
+	if (!l_dbus_message_builder_append_basic(builder, type, data))
+		return false;
+	if (!l_dbus_message_builder_leave_variant(builder))
+		return false;
+	if (!l_dbus_message_builder_leave_dict(builder))
+		return false;
+
+	return true;
+}
+
+static enum cmd_status cmd_enroll_or_configure(const char *device_name,
+						char **argv, int argc,
+						const char *method)
+{
+	struct l_dbus_message_builder *builder;
+	const struct proxy_interface *pkex;
+	const char *key;
+	const char *id = NULL;
+
+	pkex = device_proxy_find(device_name, IWD_DPP_PKEX_INTERFACE);
+	if (!pkex) {
+		display("No pkex pkex on device: '%s'\n", device_name);
+		return CMD_STATUS_INVALID_VALUE;
+	}
+
+	if (argc < 1)
+		return CMD_STATUS_INVALID_ARGS;
+
+	key = argv[0];
+
+	if (argc > 1)
+		id = argv[1];
+
+	builder = proxy_interface_new_builder(pkex, method);
+
+	l_dbus_message_builder_enter_array(builder, "{sv}");
+
+	append_dict_basic(builder, "Code", 's', key);
+
+	if (id)
+		append_dict_basic(builder, "Identifier", 's', id);
+
+	l_dbus_message_builder_leave_array(builder);
+
+	proxy_interface_method_call_from_builder(pkex, builder,
+						check_errors_method_callback);
+	l_dbus_message_builder_destroy(builder);
+
+	return CMD_STATUS_TRIGGERED;
+}
+
+static enum cmd_status cmd_enroll(const char *device_name,
+					char **argv, int argc)
+{
+	return cmd_enroll_or_configure(device_name, argv, argc,
+					"StartEnrollee");
+}
+
+static enum cmd_status cmd_configure(const char *device_name,
+					char **argv, int argc)
+{
+	return cmd_enroll_or_configure(device_name, argv, argc,
+					"ConfigureEnrollee");
+}
+
+static enum cmd_status cmd_stop(const char *device_name, char **argv, int argc)
+{
+	const struct proxy_interface *pkex_i =
+		device_proxy_find(device_name, IWD_DPP_PKEX_INTERFACE);
+
+	if (!pkex_i) {
+		display("No pkex on device: '%s'\n", device_name);
+		return CMD_STATUS_INVALID_VALUE;
+	}
+
+	proxy_interface_method_call(pkex_i, "Stop", "",
+						check_errors_method_callback);
+
+	return CMD_STATUS_TRIGGERED;
+}
+
+static enum cmd_status cmd_show(const char *device_name,
+						char **argv, int argc)
+{
+	const struct proxy_interface *proxy =
+			device_proxy_find(device_name, IWD_DPP_PKEX_INTERFACE);
+	char *caption = l_strdup_printf("%s: %s", "DPP-PKEX", device_name);
+
+	if (!proxy) {
+		display("No DPP-PKEX interface on device: '%s'\n", device_name);
+		return CMD_STATUS_INVALID_VALUE;
+	}
+
+	proxy_properties_display(proxy, caption, MARGIN, 20, 47);
+	l_free(caption);
+
+	display_table_footer();
+
+	return CMD_STATUS_DONE;
+}
+
+static const struct command pkex_commands[] = {
+	{ NULL, "list", NULL, cmd_list,
+				"List shared code capable devices", true },
+	{ "<wlan>", "stop", NULL, cmd_stop, "Aborts shared code operations" },
+	{ "<wlan>", "show", NULL, cmd_show,
+				"Shows the shared code state", true },
+	{ "<wlan>", "enroll", "key [identifier]",
+				cmd_enroll, "Start a shared code enrollee"},
+	{ "<wlan>", "configure", "key [identifier]",
+				cmd_configure,
+				"Start a shared code configurator"},
+	{ }
+};
+
+static char *family_arg_completion(const char *text, int state)
+{
+	return device_arg_completion(text, state, pkex_commands,
+						IWD_DPP_PKEX_INTERFACE);
+}
+
+static char *entity_arg_completion(const char *text, int state)
+{
+	return command_entity_arg_completion(text, state, pkex_commands);
+}
+
+static void update_started(void *data, struct l_dbus_message_iter *variant)
+{
+	struct pkex *pkex = data;
+	bool value;
+
+	if (!l_dbus_message_iter_get_variant(variant, "b", &value)) {
+		pkex->started = false;
+		return;
+	}
+
+	pkex->started = value;
+}
+
+static const char *started_tostr(const void *data)
+{
+	const struct pkex *pkex = data;
+
+	return pkex->started ? "yes" : "no";
+}
+
+static void update_role(void *data, struct l_dbus_message_iter *variant)
+{
+	struct pkex *pkex = data;
+	const char *value;
+
+	if (pkex->role)
+		l_free(pkex->role);
+
+	if (!l_dbus_message_iter_get_variant(variant, "s", &value)) {
+		pkex->role = NULL;
+		return;
+	}
+
+	pkex->role = l_strdup(value);
+}
+
+static const char *role_tostr(const void *data)
+{
+	const struct pkex *pkex = data;
+
+	return pkex->role;
+}
+
+static const struct proxy_interface_property pkex_properties[] = {
+	{ "Started",	"b", update_started,	started_tostr },
+	{ "Role",	"s", update_role, 	role_tostr },
+	{ }
+};
+
+static const struct proxy_interface_type_ops pkex_ops = {
+	.create = pkex_create,
+	.destroy = pkex_destroy,
+};
+
+static struct proxy_interface_type pkex_interface_type = {
+	.interface = IWD_DPP_PKEX_INTERFACE,
+	.properties = pkex_properties,
+	.ops = &pkex_ops,
+};
+
+
+static struct command_family pkex_command_family = {
+	.caption = "Shared Code Device Provisioning (PKEX)",
+	.name = "pkex",
+	.command_list = pkex_commands,
+	.family_arg_completion = family_arg_completion,
+	.entity_arg_completion = entity_arg_completion,
+};
+
+static int pkex_command_family_init(void)
+{
+	command_family_register(&pkex_command_family);
+
+	return 0;
+}
+
+static void pkex_command_family_exit(void)
+{
+	command_family_unregister(&pkex_command_family);
+}
+
+COMMAND_FAMILY(pkex_command_family, pkex_command_family_init,
+						pkex_command_family_exit)
+
+static int pkex_interface_init(void)
+{
+	proxy_interface_type_register(&pkex_interface_type);
+
+	return 0;
+}
+
+static void pkex_interface_exit(void)
+{
+	proxy_interface_type_unregister(&pkex_interface_type);
+}
+
+INTERFACE_TYPE(pkex_interface_type, pkex_interface_init, pkex_interface_exit)
-- 
2.25.1

