Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E2220332
	for <iwd@lists.linux.dev>; Tue, 31 Oct 2023 18:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aG7KtwtX"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-77891f362cfso10742385a.1
        for <iwd@lists.linux.dev>; Tue, 31 Oct 2023 11:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698778086; x=1699382886; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHWGQ0O3ysE606k3XcqdDR+69PqOBoxjxafEmFI6L9g=;
        b=aG7KtwtXGVUrHdD/rIECRLgrJrcdqotZZWdeARnaosCy91Ar1OQTQUw3RfFCKI3KrI
         uyzMl9NFGdT4OlDVL3SeWwoOwUDCKwDB3XfWAyQGSu1scAaiIkWaCqt8n3lHcE/Z5ntF
         TpOitpZlgoSJdkwxQAFC2fqD00SPsq/HyrfkTMXaM7zbHWfOY0c3ebfs+G5zDrLFsjPw
         Hf6piDvTNuS4CEPWtxgoBnGV3RqIJqMvzPiyGjvHTjwtwWcjlMmMhSvFS4jFugDeqqOr
         RRfSe4C0KBoSPZEWAphYPvNbFaouABjyuvIdcOZLUc0AokM7X1G1uRSmCc7WhUyRRJoE
         5Ndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698778086; x=1699382886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dHWGQ0O3ysE606k3XcqdDR+69PqOBoxjxafEmFI6L9g=;
        b=ZM9GgsHf+jgTVdlZeOyIT6iKad0qV6+bd73YjqBthqPMiZbm4hha3+eQQ9oKTgVxHX
         ACAZc6i8n6Jk8uDwbnT2VsT0CNJv/mhfCu3nyYnH/+ZBUxxNmjc432pv10VMnt9BXJZG
         7jkLe55ph1G99MGfID3ynR5BrCFINH0VAhOSnavX9Z5BHa/MY27l2DaIpvmhZaPvlDZp
         QKVHd8EE0uZ3wGzJQ2dVCrsRTT0ENMZZDfDrdwfL6RI4RjeZXiFN3qpCvK2pgz7o6CoG
         2PRRaM1VcYgejm8E56MQXlcEUMTx+tPN79aF51b+4+mjIZC37sw8tuyqAenSdLFqWiG4
         biYQ==
X-Gm-Message-State: AOJu0YzwZttmlnfcnLrl3jw4Rz+P2w29aJK2yvUM9sh6Ob7Nh7cUiSf7
	fFe9juWw9UzxoZrTStzp0O/WUwdcBoU=
X-Google-Smtp-Source: AGHT+IFxmV6EuHe4HDcE+mC9xig2AbN51h2eOh/4jiPspHLeOyA/sQpuSklQwR7hj06rvO8ef5MtMg==
X-Received: by 2002:a05:620a:4492:b0:773:ac84:3f57 with SMTP id x18-20020a05620a449200b00773ac843f57mr5047304qkp.5.1698778086614;
        Tue, 31 Oct 2023 11:48:06 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id bj30-20020a05620a191e00b00774292e636dsm736351qkb.63.2023.10.31.11.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 11:48:06 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 7/9] dpp: SharedCode interface, {Register,Unregister}SharedCodeAgent
Date: Tue, 31 Oct 2023 11:47:48 -0700
Message-Id: <20231031184750.722404-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231031184750.722404-1-prestwoj@gmail.com>
References: <20231031184750.722404-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the SharedCodeDeviceProvisioning interface as well as
the two agent methods. After the PKEX configurator role is added
it will need this to request a shared code from a registered agent.
---
 src/dpp.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/src/dpp.c b/src/dpp.c
index b0a79361..57024a26 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -79,6 +79,13 @@ enum dpp_capability {
 	DPP_CAPABILITY_CONFIGURATOR = 0x02,
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
@@ -101,6 +108,8 @@ struct dpp_sm {
 
 	enum dpp_state state;
 
+	struct pkex_agent *agent;
+
 	/*
 	 * List of frequencies to jump between. The presence of this list is
 	 * also used to signify that a configurator is an initiator vs responder
@@ -335,6 +344,16 @@ static void dpp_reset(struct dpp_sm *dpp)
 	dpp_property_changed_notify(dpp);
 }
 
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
 static void dpp_free(struct dpp_sm *dpp)
 {
 	dpp_reset(dpp);
@@ -354,6 +373,11 @@ static void dpp_free(struct dpp_sm *dpp)
 		dpp->boot_private = NULL;
 	}
 
+	if (dpp->agent) {
+		pkex_agent_free(dpp->agent);
+		dpp->agent = NULL;
+	}
+
 	l_free(dpp);
 }
 
@@ -2753,6 +2777,79 @@ static void dpp_setup_interface(struct l_dbus_interface *interface)
 	l_dbus_interface_property(interface, "URI", 0, "s", dpp_get_uri, NULL);
 }
 
+static void pkex_agent_disconnect(struct l_dbus *dbus, void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+
+	l_debug("SharedCodeAgent %s disconnected", dpp->agent->path);
+
+	if (dpp->agent->pending_id)
+		l_dbus_cancel(dbus_get_bus(), dpp->agent->pending_id);
+
+	pkex_agent_free(dpp->agent);
+	dpp->agent = NULL;
+}
+
+static struct l_dbus_message *dpp_dbus_pkex_register_agent(
+						struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+	const char *sender = l_dbus_message_get_sender(message);
+	const char *path;
+
+	if (dpp->agent)
+		return dbus_error_already_exists(message);
+
+	if (!l_dbus_message_get_arguments(message, "o", &path))
+		return dbus_error_invalid_args(message);
+
+	dpp->agent = l_new(struct pkex_agent, 1);
+	dpp->agent->owner = l_strdup(sender);
+	dpp->agent->path = l_strdup(path);
+	dpp->agent->disconnect_watch = l_dbus_add_disconnect_watch(dbus, sender,
+							pkex_agent_disconnect,
+							dpp, NULL);
+
+	l_debug("%s registered a SharedCodeAgent on path %s", sender, path);
+
+	return l_dbus_message_new_method_return(message);
+}
+
+static struct l_dbus_message *dpp_dbus_pkex_unregister_agent(
+						struct l_dbus *dbus,
+						struct l_dbus_message *message,
+						void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+
+	if (!dpp->agent)
+		return dbus_error_not_found(message);
+
+	if (strcmp(dpp->agent->owner, l_dbus_message_get_sender(message)))
+		return dbus_error_not_found(message);
+
+	l_debug("%s unregistered SharedCodeAgent on path %s", dpp->agent->owner,
+			dpp->agent->path);
+
+	if (dpp->agent->pending_id)
+		l_dbus_cancel(dbus_get_bus(), dpp->agent->pending_id);
+
+	pkex_agent_free(dpp->agent);
+	dpp->agent = NULL;
+
+	return l_dbus_message_new_method_return(message);
+}
+
+static void dpp_setup_pkex_interface(struct l_dbus_interface *interface)
+{
+	l_dbus_interface_method(interface, "RegisterSharedCodeAgent", 0,
+			dpp_dbus_pkex_register_agent, "", "o", "path");
+	l_dbus_interface_method(interface, "UnregisterSharedCodeAgent", 0,
+			dpp_dbus_pkex_unregister_agent, "", "");
+}
+
 static void dpp_destroy_interface(void *user_data)
 {
 	struct dpp_sm *dpp = user_data;
@@ -2775,6 +2872,9 @@ static int dpp_init(void)
 	l_dbus_register_interface(dbus_get_bus(), IWD_DPP_INTERFACE,
 					dpp_setup_interface,
 					dpp_destroy_interface, false);
+	l_dbus_register_interface(dbus_get_bus(), IWD_DPP_PKEX_INTERFACE,
+					dpp_setup_pkex_interface,
+					NULL, false);
 
 	mlme_watch = l_genl_family_register(nl80211, "mlme", dpp_mlme_notify,
 						NULL, NULL);
-- 
2.25.1

