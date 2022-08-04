Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048115380
	for <iwd@lists.linux.dev>; Thu,  4 Aug 2022 18:51:16 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id a8so583915pjg.5
        for <iwd@lists.linux.dev>; Thu, 04 Aug 2022 11:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=64iFZ5d0cTUCU7ewULKck6X5mJo5Bk5AG9qkKfeS31U=;
        b=eb9ZTpC8T1oWgHV1a1I3aI5i28L7DFxbdF/LK3Sc0LLEadwbX2Cb53csiy+gh9KmuR
         DCC4h2PfEkBHxSWuFO5cISK7g5azUWYwdaMjJSzrZjjkq+i4bQj2FGAK8OTdx+WYM2zh
         j8u+DmXe1CRGF2PTnKSNvQJ5QPzBUO/Qxo0fpTy/IaYfYYvO+F+K3vxDTaljwtHdIgZE
         c485I4Fqd48TfNNit4dMvkE22zNlvT6bZtzGh2e22GW+taDBOwDuQsFx1fSU+jyTf4fm
         nm2Ax1XvWfATTmXefIh/2a5+j+8bWvp6vqa0BNEncfILPdrtf916bLNAe+q1KTx2FnNS
         fO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=64iFZ5d0cTUCU7ewULKck6X5mJo5Bk5AG9qkKfeS31U=;
        b=ByDma5aEsvBgKDIa2h7Vyc83PhTgB9BWqe8f8fVEt7EozcTs9tDVxTcmNAdmNB64Ra
         wNkHrecI2ATah/fUSdSJ8BN8ZCTOgF2RvB6wKJKx9+rHMvsT6/8iK8mD8nzDCehxzb14
         Y0EP43mEFCbVHPE9qaxm/bi6D2WYtuJq5eMeowN7oHApnAeK92c8nKcFUhtRq84O/wFC
         ORD0lJrgj/QCEckCvvc1/oyfvl44WkKhRb7l9U2pI9mMQlCIsqiuxVPNroMxuIuQvhGM
         sBtYCo47en3eibKMskQCuOQXgMBqSTNbMNorXRI24Mp32Cw6XpFKP8j1JQbCQbn2nVf7
         eing==
X-Gm-Message-State: ACgBeo3JAbe0MAUV1THNDRwEGsmYZ2LWe6EUWIhFrKkadvBUJxXwXO/Z
	p6kGmUamHeGj7HV1PMpCuddCOitj2b0=
X-Google-Smtp-Source: AA6agR6aHALN4Kov32H5KjWd0yktiPLKD95oP6Q0xY7+pgm+40Qyw3hsbyMKxrjCV+MfgJa0iX9zug==
X-Received: by 2002:a17:90b:1bc7:b0:1f5:37a6:e473 with SMTP id oa7-20020a17090b1bc700b001f537a6e473mr3410924pjb.87.1659639076142;
        Thu, 04 Aug 2022 11:51:16 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id c7-20020a634e07000000b0041b3c112b1esm219954pgb.29.2022.08.04.11.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:51:15 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/7] wiphy: dump wiphy's on regulatory domain change
Date: Thu,  4 Aug 2022 11:51:07 -0700
Message-Id: <20220804185112.457670-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220804185112.457670-1-prestwoj@gmail.com>
References: <20220804185112.457670-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A change in regulatory domain can result in frequencies being
enabled or disabled depending on the domain. This effects the
frequencies stored in wiphy which other modules depend on
such as scanning, offchannel work etc.

When the regulatory domain changes re-dump the wiphy in order
to update any frequency restrictions.
---
 src/wiphy.c | 202 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 195 insertions(+), 7 deletions(-)

v3:
 * Removed the GET_REG handling and instead only dump wiphy from
   the notify callback directly

diff --git a/src/wiphy.c b/src/wiphy.c
index 30b860da..dfdca989 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -66,6 +66,7 @@ static char **blacklist_filter;
 static int mac_randomize_bytes = 6;
 static char regdom_country[2];
 static uint32_t work_ids;
+static unsigned int wiphy_dump_id;
 
 enum driver_flag {
 	DEFAULT_IF = 0x1,
@@ -105,6 +106,7 @@ struct wiphy {
 	uint16_t supported_ciphers;
 	struct scan_freq_set *supported_freqs;
 	struct scan_freq_set *disabled_freqs;
+	struct scan_freq_set *pending_freqs;
 	struct band *band_2g;
 	struct band *band_5g;
 	struct band *band_6g;
@@ -122,6 +124,7 @@ struct wiphy {
 	struct l_queue *work;
 	bool work_in_callback;
 	unsigned int get_reg_id;
+	unsigned int dump_id;
 
 	bool support_scheduled_scan:1;
 	bool support_rekey_offload:1;
@@ -342,6 +345,9 @@ static void wiphy_free(void *data)
 
 	l_debug("Freeing wiphy %s[%u]", wiphy->name, wiphy->id);
 
+	if (wiphy->dump_id)
+		l_genl_family_cancel(nl80211, wiphy->dump_id);
+
 	if (wiphy->get_reg_id)
 		l_genl_family_cancel(nl80211, wiphy->get_reg_id);
 
@@ -1839,6 +1845,182 @@ static void wiphy_setup_rm_enabled_capabilities(struct wiphy *wiphy)
 	 */
 }
 
+static void wiphy_dump_done(void *user_data)
+{
+	struct wiphy *wiphy = user_data;
+	const struct l_queue_entry *e;
+
+	/* This dump was canceled due to another dump */
+	if ((wiphy && !wiphy->dump_id) || (!wiphy && !wiphy_dump_id))
+		return;
+
+	if (wiphy) {
+		wiphy->dump_id = 0;
+		scan_freq_set_free(wiphy->disabled_freqs);
+		wiphy->disabled_freqs = wiphy->pending_freqs;
+		wiphy->pending_freqs = NULL;
+
+		WATCHLIST_NOTIFY(&wiphy->state_watches,
+				wiphy_state_watch_func_t, wiphy,
+				WIPHY_STATE_WATCH_EVENT_REGDOM_DONE);
+
+		return;
+	}
+
+	wiphy_dump_id = 0;
+
+	for (e = l_queue_get_entries(wiphy_list); e; e = e->next) {
+		wiphy = e->data;
+
+		if (!wiphy->pending_freqs || wiphy->self_managed)
+			continue;
+
+		scan_freq_set_free(wiphy->disabled_freqs);
+		wiphy->disabled_freqs = wiphy->pending_freqs;
+		wiphy->pending_freqs = NULL;
+
+		WATCHLIST_NOTIFY(&wiphy->state_watches,
+				wiphy_state_watch_func_t, wiphy,
+				WIPHY_STATE_WATCH_EVENT_REGDOM_DONE);
+	}
+}
+
+/* We are dumping wiphy(s) due to a regulatory change */
+static void wiphy_dump_callback(struct l_genl_msg *msg,
+						void *user_data)
+{
+	struct wiphy *wiphy;
+	uint32_t id;
+	struct l_genl_attr bands;
+	struct l_genl_attr attr;
+	uint16_t type;
+
+	if (nl80211_parse_attrs(msg, NL80211_ATTR_WIPHY, &id,
+					NL80211_ATTR_WIPHY_BANDS, &bands,
+					NL80211_ATTR_UNSPEC) < 0)
+		return;
+
+	wiphy = wiphy_find(id);
+	if (L_WARN_ON(!wiphy))
+		return;
+
+	while (l_genl_attr_next(&bands, NULL, NULL, NULL)) {
+		if (!l_genl_attr_recurse(&bands, &attr))
+			return;
+
+		while (l_genl_attr_next(&attr, &type, NULL, NULL)) {
+			if (type != NL80211_BAND_ATTR_FREQS)
+				continue;
+
+			nl80211_parse_supported_frequencies(&attr, NULL,
+							wiphy->pending_freqs);
+		}
+	}
+}
+
+static bool wiphy_cancel_last_dump(struct wiphy *wiphy)
+{
+	const struct l_queue_entry *e;
+	unsigned int id = 0;
+
+	/*
+	 * Zero command ID to signal that wiphy_dump_done doesn't need to do
+	 * anything. For a self-managed wiphy just free/NULL pending_freqs. For
+	 * a global dump each wiphy needs to be checked and dealt with.
+	 */
+	if (wiphy && wiphy->dump_id) {
+		id = wiphy->dump_id;
+		wiphy->dump_id = 0;
+
+		scan_freq_set_free(wiphy->pending_freqs);
+		wiphy->pending_freqs = NULL;
+	} else if (!wiphy && wiphy_dump_id) {
+		id = wiphy_dump_id;
+		wiphy_dump_id = 0;
+
+		for (e = l_queue_get_entries(wiphy_list); e; e = e->next) {
+			struct wiphy *w = e->data;
+
+			if (!w->pending_freqs || w->self_managed)
+				continue;
+
+			scan_freq_set_free(w->pending_freqs);
+			w->pending_freqs = NULL;
+		}
+	}
+
+	if (id) {
+		l_debug("Canceling pending regdom wiphy dump (%s)",
+					wiphy ? wiphy->name : "global");
+
+		l_genl_family_cancel(nl80211, id);
+	}
+
+	return id != 0;
+}
+
+static void wiphy_dump_after_regdom(struct wiphy *wiphy)
+{
+	const struct l_queue_entry *e;
+	struct l_genl_msg *msg;
+	unsigned int id;
+	bool no_start_event;
+
+	msg = l_genl_msg_new_sized(NL80211_CMD_GET_WIPHY, 128);
+
+	if (wiphy)
+		l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY, 4, &wiphy->id);
+
+	l_genl_msg_append_attr(msg, NL80211_ATTR_SPLIT_WIPHY_DUMP, 0, NULL);
+	id = l_genl_family_dump(nl80211, msg, wiphy_dump_callback,
+						wiphy, wiphy_dump_done);
+	if (!id) {
+		l_error("Wiphy information dump failed");
+		l_genl_msg_unref(msg);
+		return;
+	}
+
+	/*
+	 * Another update while dumping wiphy. This next dump should supercede
+	 * the first and not result in a DONE event until this new dump is
+	 * finished. This is because the disabled frequencies are in an unknown
+	 * state and could cause incorrect behavior by any watchers.
+	 */
+	no_start_event = wiphy_cancel_last_dump(wiphy);
+
+	/* Limited dump so just emit the event for this wiphy */
+	if (wiphy) {
+		wiphy->dump_id = id;
+		wiphy->pending_freqs = scan_freq_set_new();
+
+		if (no_start_event)
+			return;
+
+		WATCHLIST_NOTIFY(&wiphy->state_watches,
+				wiphy_state_watch_func_t, wiphy,
+				WIPHY_STATE_WATCH_EVENT_REGDOM_STARTED);
+		return;
+	}
+
+	wiphy_dump_id = id;
+
+	/* Otherwise for a global regdom change notify for all wiphy's */
+	for (e = l_queue_get_entries(wiphy_list); e; e = e->next) {
+		struct wiphy *w = e->data;
+
+		if (w->self_managed)
+			continue;
+
+		w->pending_freqs = scan_freq_set_new();
+
+		if (no_start_event)
+			continue;
+
+		WATCHLIST_NOTIFY(&w->state_watches, wiphy_state_watch_func_t,
+				w, WIPHY_STATE_WATCH_EVENT_REGDOM_STARTED);
+	}
+}
+
 static void wiphy_update_reg_domain(struct wiphy *wiphy, bool global,
 					struct l_genl_msg *msg)
 {
@@ -2110,6 +2292,8 @@ static void setup_wiphy_interface(struct l_dbus_interface *interface)
 static void wiphy_reg_notify(struct l_genl_msg *msg, void *user_data)
 {
 	uint8_t cmd = l_genl_msg_get_command(msg);
+	struct wiphy *wiphy = NULL;
+	uint32_t wiphy_id;
 
 	l_debug("Notification of command %s(%u)",
 		nl80211cmd_to_string(cmd), cmd);
@@ -2119,22 +2303,21 @@ static void wiphy_reg_notify(struct l_genl_msg *msg, void *user_data)
 		wiphy_update_reg_domain(NULL, true, msg);
 		break;
 	case NL80211_CMD_WIPHY_REG_CHANGE:
-	{
-		uint32_t wiphy_id;
-		struct wiphy *wiphy;
-
 		if (nl80211_parse_attrs(msg, NL80211_ATTR_WIPHY, &wiphy_id,
 					NL80211_ATTR_UNSPEC) < 0)
-			break;
+			return;
 
 		wiphy = wiphy_find(wiphy_id);
 		if (!wiphy)
-			break;
+			return;
 
 		wiphy_update_reg_domain(wiphy, false, msg);
 		break;
+	default:
+		return;
 	}
-	}
+
+	wiphy_dump_after_regdom(wiphy);
 }
 
 static void wiphy_radio_work_next(struct wiphy *wiphy)
@@ -2313,6 +2496,11 @@ static void wiphy_exit(void)
 	l_strfreev(whitelist_filter);
 	l_strfreev(blacklist_filter);
 
+	if (wiphy_dump_id) {
+		l_genl_family_cancel(nl80211, wiphy_dump_id);
+		wiphy_dump_id = 0;
+	}
+
 	l_queue_destroy(wiphy_list, wiphy_free);
 	wiphy_list = NULL;
 
-- 
2.34.3

