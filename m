Received: from mail-108-mta187.mxroute.com (mail-108-mta187.mxroute.com [136.175.108.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBEB1875
	for <iwd@lists.linux.dev>; Wed, 22 Jun 2022 19:47:34 +0000 (UTC)
Received: from filter006.mxroute.com ([140.82.40.27] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta187.mxroute.com (ZoneMTA) with ESMTPSA id 1818cefe7ce00028a7.001
 for <iwd@lists.linux.dev>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Wed, 22 Jun 2022 19:42:21 +0000
X-Zone-Loop: 71cdae5cbfc5d5f9b23a589102f03cf68c463c2464d4
X-Originating-IP: [140.82.40.27]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=twosheds.org; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date
	:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0CboKceZiTTpT2J1T4CPfsLIvJWkCZTAYBomjoXNvmc=; b=gBbZ4z+7ehW26hEp2cxLSj3ZlM
	u0nWddg+0r6odEQ55upN6Ue6pb//dv4JcA1N2AgWitTXWDYgH6++JwgGtg88n7eV/CPsQ9yGmNrRY
	nKwoll+xA0GdElAXM3VJ3mRJ5Qd/B0i45jmtPXfB89nVUELNZgijtikDjEl16iaeuH/3u0+xhiz7b
	UnY4rbbVEyXecAnXMCq1KgNjChGPyMz/XCFr6oPvgKQr+a6zDiCPmyWjrVSt4ZrfFs6rg4htiv/eo
	/NXIdjNv9T749rmd7Fv7ZhTR8cymVZ4PAzsKGY1JArOrHvYGv9vxMVou1Uu/tZo+53N53BFeMVflT
	W3MTaWAQ==;
From: Jesse Lentz <jesse@twosheds.org>
To: iwd@lists.linux.dev
Cc: Jesse Lentz <jesse@twosheds.org>
Subject: [PATCH 1/2] dpp: Add State and Role properties to dbus API
Date: Wed, 22 Jun 2022 15:41:41 -0400
Message-Id: <20220622194142.213135-1-jesse@twosheds.org>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: jesse@twosheds.org

Allow front-end applications to see DPP state (presence, authenticating,
or configuring) and role (enrollee or configurator) via dbus.
---
 src/dpp.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 1 deletion(-)

diff --git a/src/dpp.c b/src/dpp.c
index 0102dc58..93e4ca57 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -149,6 +149,58 @@ struct dpp_sm {
 	bool roc_started : 1;
 };
 
+static bool dpp_get_state(struct l_dbus *dbus,
+				struct l_dbus_message *message,
+				struct l_dbus_message_builder *builder,
+				void *user_data)
+{
+	struct dpp_sm *dpp = user_data;
+	const char *state;
+
+	switch (dpp->state) {
+	    case DPP_STATE_PRESENCE:
+		state = "presence";
+		break;
+	    case DPP_STATE_AUTHENTICATING:
+		state = "authenticating";
+		break;
+	    case DPP_STATE_CONFIGURING:
+		state = "configuring";
+		break;
+	    default:
+		return false;
+	}
+
+	l_dbus_message_builder_append_basic(builder, 's', state);
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
+	    return false;
+
+	switch (dpp->role) {
+	    case DPP_CAPABILITY_ENROLLEE:
+		role = "enrollee";
+		break;
+	    case DPP_CAPABILITY_CONFIGURATOR:
+		role = "configurator";
+		break;
+	    default:
+		return false;
+	}
+
+	l_dbus_message_builder_append_basic(builder, 's', role);
+	return true;
+}
+
 static void *dpp_serialize_iovec(struct iovec *iov, size_t iov_len,
 				size_t *out_len)
 {
@@ -253,6 +305,15 @@ static void dpp_reset(struct dpp_sm *dpp)
 	dpp->frame_retry = 0;
 	dpp->frame_cookie = 0;
 
+	l_dbus_property_changed(dbus_get_bus(),
+				netdev_get_path(dpp->netdev),
+				IWD_DPP_INTERFACE,
+				"State");
+	l_dbus_property_changed(dbus_get_bus(),
+				netdev_get_path(dpp->netdev),
+				IWD_DPP_INTERFACE,
+				"Role");
+
 	explicit_bzero(dpp->r_nonce, dpp->nonce_len);
 	explicit_bzero(dpp->i_nonce, dpp->nonce_len);
 	explicit_bzero(dpp->e_nonce, dpp->nonce_len);
@@ -494,6 +555,11 @@ static void dpp_configuration_start(struct dpp_sm *dpp, const uint8_t *addr)
 
 	dpp->state = DPP_STATE_CONFIGURING;
 
+	l_dbus_property_changed(dbus_get_bus(),
+				netdev_get_path(dpp->netdev),
+				IWD_DPP_INTERFACE,
+				"State");
+
 	dpp_send_frame(dpp, iov, 2, dpp->current_freq);
 }
 
@@ -994,6 +1060,11 @@ static void dpp_handle_config_request_frame(const struct mmpdu_header *frame,
 
 	dpp->state = DPP_STATE_CONFIGURING;
 
+	l_dbus_property_changed(dbus_get_bus(),
+				netdev_get_path(dpp->netdev),
+				IWD_DPP_INTERFACE,
+				"State");
+
 	dpp_send_config_response(dpp, DPP_STATUS_OK);
 
 	return;
@@ -1286,6 +1357,11 @@ static void authenticate_confirm(struct dpp_sm *dpp, const uint8_t *from,
 auth_confirm_failed:
 	dpp->state = DPP_STATE_PRESENCE;
 	dpp_free_auth_data(dpp);
+
+	l_dbus_property_changed(dbus_get_bus(),
+				netdev_get_path(dpp->netdev),
+				IWD_DPP_INTERFACE,
+				"State");
 }
 
 static void dpp_auth_request_failed(struct dpp_sm *dpp,
@@ -1750,6 +1826,11 @@ static void authenticate_request(struct dpp_sm *dpp, const uint8_t *from,
 	dpp->state = DPP_STATE_AUTHENTICATING;
 	dpp_reset_protocol_timer(dpp);
 
+	l_dbus_property_changed(dbus_get_bus(),
+				netdev_get_path(dpp->netdev),
+				IWD_DPP_INTERFACE,
+				"State");
+
 	/* Don't send if the frequency is changing */
 	if (!dpp->new_freq)
 		send_authenticate_response(dpp);
@@ -1757,7 +1838,6 @@ static void authenticate_request(struct dpp_sm *dpp, const uint8_t *from,
 	return;
 
 auth_request_failed:
-	dpp->state = DPP_STATE_PRESENCE;
 	dpp_free_auth_data(dpp);
 }
 
@@ -2040,6 +2120,11 @@ static void dpp_handle_presence_announcement(struct dpp_sm *dpp,
 
 	dpp->state = DPP_STATE_AUTHENTICATING;
 
+	l_dbus_property_changed(dbus_get_bus(),
+				netdev_get_path(dpp->netdev),
+				IWD_DPP_INTERFACE,
+				"State");
+
 	if (!dpp_send_authenticate_request(dpp))
 		return;
 
@@ -2416,6 +2501,15 @@ static struct l_dbus_message *dpp_dbus_start_enrollee(struct l_dbus *dbus,
 	dpp->state = DPP_STATE_PRESENCE;
 	dpp->role = DPP_CAPABILITY_ENROLLEE;
 
+	l_dbus_property_changed(dbus_get_bus(),
+				netdev_get_path(dpp->netdev),
+				IWD_DPP_INTERFACE,
+				"State");
+	l_dbus_property_changed(dbus_get_bus(),
+				netdev_get_path(dpp->netdev),
+				IWD_DPP_INTERFACE,
+				"Role");
+
 	l_ecdh_generate_key_pair(dpp->curve, &dpp->proto_private,
 					&dpp->own_proto_public);
 
@@ -2560,6 +2654,15 @@ static struct l_dbus_message *dpp_start_configurator_common(
 						network_get_ssid(network),
 						hs->akm_suite);
 
+	l_dbus_property_changed(dbus_get_bus(),
+				netdev_get_path(dpp->netdev),
+				IWD_DPP_INTERFACE,
+				"State");
+	l_dbus_property_changed(dbus_get_bus(),
+				netdev_get_path(dpp->netdev),
+				IWD_DPP_INTERFACE,
+				"Role");
+
 	scan_periodic_stop(dpp->wdev_id);
 
 	l_debug("DPP Start Configurator: %s", dpp->uri);
@@ -2606,6 +2709,11 @@ static void dpp_setup_interface(struct l_dbus_interface *interface)
 				dpp_dbus_configure_enrollee, "", "s", "uri");
 	l_dbus_interface_method(interface, "Stop", 0,
 				dpp_dbus_stop, "", "");
+
+	l_dbus_interface_property(interface, "State", 0, "s",
+				  dpp_get_state, NULL);
+	l_dbus_interface_property(interface, "Role", 0, "s",
+				  dpp_get_role, NULL);
 }
 
 static void dpp_destroy_interface(void *user_data)
-- 
2.36.1

