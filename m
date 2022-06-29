Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B296F6AB4
	for <iwd@lists.linux.dev>; Wed, 29 Jun 2022 19:29:18 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id x4so16041779pfq.2
        for <iwd@lists.linux.dev>; Wed, 29 Jun 2022 12:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fdnFL5XnWt70hBI3QkLY123iL6CCK5NEa7rKhqjbxIs=;
        b=MTynJJckER3AWHtwjuUxrrDQfAp7h6H3NIKIMQa++UNFldbmRllpe2h6ricmYu63p2
         wyzMICqfGl6n051ZeGeWfZxqjyUTZTXlUk0c1XwSOT0OhfQDiWqjj7QP8KH+Bq9flu+V
         21yGM5eeX+xsNaQD+mPd8ymMOn40Usq+U4m7hDPnxSwVVtVVRV0Pv7fQAL534uGrgBIO
         Hd0CU0syrJdxkR1uM3TvqJOC2vlLjJ9VVP4W+SiIg4t7ESxHGVYZ77Q8XgVIJTv2xWfW
         X4nJjzlkjN5Gkn1me0jsACTQPxQXBZ9hDicvUVXXCA66LWbPmtCeZ6osOt9X7qaGLvES
         PWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fdnFL5XnWt70hBI3QkLY123iL6CCK5NEa7rKhqjbxIs=;
        b=Q9MlsQCjh6OCX3RjLPsaSaAdwK5SQo2lCW7wrCsiwm43B1fXp7vRkIGpNfpXqfle2c
         EuNoW7b/FVmqzH/kBfZEGDMBz8ZbmlS5fJfZFzn3z66QZLWc+oZ+BXFhtt4xhX3jBHRQ
         AZsvc0OJ0KhGbctfNEXbqiTCysAQRyZAW1a97yleQCALGe/1w7LAHcGLhrsKugWIOWs5
         KNvByXpOWVnQ16siXR7gnFsv55kIqPFZ0X1OMs2Xelz5rnCe+dMlpGgkPD27xS095q0n
         JAg2AO4RGjTcCfTe0Y97/PE93yuLcaatDDUzR63exRx03JAIsi4TIf7LcMTEQJ7Ev+G2
         8EBA==
X-Gm-Message-State: AJIora/Kcr0bWY9TfGQponIBmVlhYpZsiDLqQt4CsqKJFNyMwUASn6BI
	arendvr0DpbzjIQxScDRw/XnSMApnHc=
X-Google-Smtp-Source: AGRyM1tkzYEyBRN8O0OuKX6ZeudQK7+WTxknS98B4oJBE+LHmH1oQU8bp9wp4f74bSoz7U/5aJN97A==
X-Received: by 2002:a65:53c8:0:b0:40d:77fc:5f05 with SMTP id z8-20020a6553c8000000b0040d77fc5f05mr4064183pgr.263.1656530957971;
        Wed, 29 Jun 2022 12:29:17 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id i29-20020a63585d000000b00407e25d4527sm11497734pgm.22.2022.06.29.12.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 12:29:17 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] client: add "dpp <wlan> show" command
Date: Wed, 29 Jun 2022 12:27:09 -0700
Message-Id: <20220629192709.38743-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220629192709.38743-1-prestwoj@gmail.com>
References: <20220629192709.38743-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will show the newly added DPP properties
---
 client/dpp.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/client/dpp.c b/client/dpp.c
index 120dd9ee..af69d2c0 100644
--- a/client/dpp.c
+++ b/client/dpp.c
@@ -34,8 +34,111 @@
 #include "client/device.h"
 #include "client/display.h"
 
+struct dpp {
+	bool started;
+	char *role;
+	char *uri;
+};
+
+static void *dpp_create(void)
+{
+	return l_new(struct dpp, 1);
+}
+
+static void dpp_destroy(void *data)
+{
+	struct dpp *dpp = data;
+
+	if (dpp->role)
+		l_free(dpp->role);
+	if (dpp->uri)
+		l_free(dpp->uri);
+
+	l_free(dpp);
+}
+
+static void update_started(void *data, struct l_dbus_message_iter *variant)
+{
+	struct dpp *dpp = data;
+	bool value;
+
+	if (!l_dbus_message_iter_get_variant(variant, "b", &value)) {
+		dpp->started = false;
+		return;
+	}
+
+	dpp->started = value;
+}
+
+static const char *started_tostr(const void *data)
+{
+	const struct dpp *dpp = data;
+
+	return dpp->started ? "yes" : "no";
+}
+
+static void update_role(void *data, struct l_dbus_message_iter *variant)
+{
+	struct dpp *dpp = data;
+	const char *value;
+
+	if (dpp->role)
+		l_free(dpp->role);
+
+	if (!l_dbus_message_iter_get_variant(variant, "s", &value)) {
+		dpp->role = NULL;
+		return;
+	}
+
+	dpp->role = l_strdup(value);
+}
+
+static const char *role_tostr(const void *data)
+{
+	const struct dpp *dpp = data;
+
+	return dpp->role;
+}
+
+static void update_uri(void *data, struct l_dbus_message_iter *variant)
+{
+	struct dpp *dpp = data;
+	const char *value;
+
+	if (dpp->uri)
+		l_free(dpp->uri);
+
+	if (!l_dbus_message_iter_get_variant(variant, "s", &value)) {
+		dpp->uri = NULL;
+		return;
+	}
+
+	dpp->uri = l_strdup(value);
+}
+
+static const char *uri_tostr(const void *data)
+{
+	const struct dpp *dpp = data;
+
+	return dpp->uri;
+}
+
+static const struct proxy_interface_property dpp_properties[] = {
+	{ "Started",	"b", update_started,	started_tostr },
+	{ "Role",	"s", update_role, 	role_tostr },
+	{ "URI",	"s", update_uri,	uri_tostr },
+	{ }
+};
+
+static const struct proxy_interface_type_ops dpp_ops = {
+	.create = dpp_create,
+	.destroy = dpp_destroy,
+};
+
 static struct proxy_interface_type dpp_interface_type = {
 	.interface = IWD_DPP_INTERFACE,
+	.properties = dpp_properties,
+	.ops = &dpp_ops,
 };
 
 static void check_errors_method_callback(struct l_dbus_message *message,
@@ -174,6 +277,19 @@ static enum cmd_status cmd_stop(const char *device_name,
 	return CMD_STATUS_TRIGGERED;
 }
 
+static enum cmd_status cmd_show(const char *device_name,
+						char **argv, int argc)
+{
+	const struct proxy_interface *proxy =
+			device_proxy_find(device_name, IWD_DPP_INTERFACE);
+	char *caption = l_strdup_printf("%s: %s", "DPP", device_name);
+
+	proxy_properties_display(proxy, caption, MARGIN, 20, 47);
+	l_free(caption);
+
+	return CMD_STATUS_DONE;
+}
+
 static const struct command dpp_commands[] = {
 	{ NULL, "list", NULL, cmd_list, "List DPP-capable devices", true },
 	{ "<wlan>", "start-enrollee", NULL, cmd_start_enrollee,
@@ -181,6 +297,7 @@ static const struct command dpp_commands[] = {
 	{ "<wlan>", "start-configurator", NULL, cmd_start_configurator,
 							"Starts a DPP Configurator" },
 	{ "<wlan>", "stop", NULL, cmd_stop, "Aborts DPP operations" },
+	{ "<wlan>", "show", NULL, cmd_show, "Shows the DPP state" },
 	{ }
 };
 
-- 
2.34.1

