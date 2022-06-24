Received: from mail-108-mta158.mxroute.com (mail-108-mta158.mxroute.com [136.175.108.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C48A7C
	for <iwd@lists.linux.dev>; Fri, 24 Jun 2022 16:50:54 +0000 (UTC)
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta158.mxroute.com (ZoneMTA) with ESMTPSA id 181969ae92d00028a7.001
 for <iwd@lists.linux.dev>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Fri, 24 Jun 2022 16:45:43 +0000
X-Zone-Loop: 7da170bd0cec4926542f57d7838175e7498ee375f96a
X-Originating-IP: [140.82.40.27]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=twosheds.org; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date
	:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZDXgRaekbcFEFt8mRCxQvRf/a8SyAIjW0Yr4+s+YF5s=; b=4mfFNKCjuikfAAyH1XhM+lvAh/
	O8dvExJ00TZCpwTccMsslKk5zNNj/daRyZ0veUzGIKXGgPubckwA8BoYawmVpIOWk6SdyCBE8+UnO
	agYrYflvo3eEaQBkrWdt3UKN3vKZWVK2BNnZWKDvFHSC93KwqpQN/N3UE89fuQO+PVRBD1A8LcAI8
	fZyz3F42c9htuhPz69iyPbOhsAiAf32scDl97YfR4LNDKu06cRKtrMY60FjpaoMUzmEAa6zL8U4+T
	qRb5wqqyH7UL+0lSZfdoKrU611rDXB3hbl4wc6k+5xcPYbND6sl4EJK1XLXRJkN/YShpyUs4fDydh
	WSrvY9eQ==;
From: Jesse Lentz <jesse@twosheds.org>
To: iwd@lists.linux.dev
Cc: Jesse Lentz <jesse@twosheds.org>
Subject: [PATCH 1/2] dpp: Add Started, Role, and URI properties to API
Date: Fri, 24 Jun 2022 12:43:47 -0400
Message-Id: <20220624164346.254771-1-jesse@twosheds.org>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: jesse@twosheds.org

Add three new properties to the DeviceProvisioning API: Started, Role,
and URI.
---
Unlike the previously proposed State property, the Started property
proposed in this patch only requires l_dbus_property_changed() calls
near the dbus entry points.

 src/dpp.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/src/dpp.c b/src/dpp.c
index 0102dc58..2c8832ff 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -149,6 +149,71 @@ struct dpp_sm {
 	bool roc_started : 1;
 };
 
+static bool dpp_get_started(struct l_dbus *dbus,
+				struct l_dbus_message *message,
+				struct l_dbus_message_builder *builder,
+				void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+	bool started = (dpp->state != DPP_STATE_NOTHING);
+
+	l_dbus_message_builder_append_basic(builder, 'b', &started);
+
+	return true;
+}
+
+static bool dpp_get_role(struct l_dbus *dbus,
+				struct l_dbus_message *message,
+				struct l_dbus_message_builder *builder,
+				void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+	const char *role;
+
+	if (dpp->state == DPP_STATE_NOTHING)
+		return false;
+
+	switch (dpp->role) {
+	case DPP_CAPABILITY_ENROLLEE:
+		role = "enrollee";
+		break;
+	case DPP_CAPABILITY_CONFIGURATOR:
+		role = "configurator";
+		break;
+	default:
+		return false;
+	}
+
+	l_dbus_message_builder_append_basic(builder, 's', role);
+	return true;
+}
+
+static bool dpp_get_uri(struct l_dbus *dbus,
+				struct l_dbus_message *message,
+				struct l_dbus_message_builder *builder,
+				void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+
+	if (dpp->state == DPP_STATE_NOTHING)
+		return false;
+
+	l_dbus_message_builder_append_basic(builder, 's', dpp->uri);
+	return true;
+}
+
+static void dpp_property_changed_notify(struct dpp_sm *dpp)
+{
+	const char *path = netdev_get_path(dpp->netdev);
+
+	l_dbus_property_changed(dbus_get_bus(), path, IWD_DPP_INTERFACE,
+				"Started");
+	l_dbus_property_changed(dbus_get_bus(), path, IWD_DPP_INTERFACE,
+				"Role");
+	l_dbus_property_changed(dbus_get_bus(), path, IWD_DPP_INTERFACE,
+				"URI");
+}
+
 static void *dpp_serialize_iovec(struct iovec *iov, size_t iov_len,
 				size_t *out_len)
 {
@@ -262,6 +327,8 @@ static void dpp_reset(struct dpp_sm *dpp)
 	explicit_bzero(dpp->auth_tag, dpp->key_len);
 
 	dpp_free_auth_data(dpp);
+
+	dpp_property_changed_notify(dpp);
 }
 
 static void dpp_free(struct dpp_sm *dpp)
@@ -2432,6 +2499,8 @@ static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
 
 	scan_periodic_stop(dpp->wdev_id);
 
+	dpp_property_changed_notify(dpp);
+
 	return NULL;
 }
 
@@ -2562,6 +2631,8 @@ static struct l_dbus_message *dpp_start_configurator_common(
 
 	scan_periodic_stop(dpp->wdev_id);
 
+	dpp_property_changed_notify(dpp);
+
 	l_debug("DPP Start Configurator: %s", dpp->uri);
 
 	reply = l_dbus_message_new_method_return(message);
@@ -2606,6 +2677,12 @@ static void dpp_setup_interface(struct l_dbus_interface *interface)
 				dpp_dbus_configure_enrollee, "", "s", "uri");
 	l_dbus_interface_method(interface, "Stop", 0,
 				dpp_dbus_stop, "", "");
+
+	l_dbus_interface_property(interface, "Started", 0, "b", dpp_get_started,
+					NULL);
+	l_dbus_interface_property(interface, "Role", 0, "s", dpp_get_role,
+					NULL);
+	l_dbus_interface_property(interface, "URI", 0, "s", dpp_get_uri, NULL);
 }
 
 static void dpp_destroy_interface(void *user_data)
-- 
2.36.1

