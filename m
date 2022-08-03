Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC784A26
	for <iwd@lists.linux.dev>; Wed,  3 Aug 2022 21:36:51 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso3502217pjd.3
        for <iwd@lists.linux.dev>; Wed, 03 Aug 2022 14:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Tu0toSJwrfhMKIyxWFiT4DhwAcH1lPBsvlhxQp3psic=;
        b=Z0RP9HFMcj1N2DlgJsKveq/ZB4JPEYDMueukTxJvS0vvvIisHuKGetMwrZvduPz7FD
         oECVPyksnuv2T9gfDv4KTYMpjeois37SS3h0q6lJ54oBpBcj3rRHMC2uaCT45Zfzsq1A
         cRhAOQjOTZScxr7nN70icOKq2KyWpJX2sb2SkCzQhg1jttAgZbip17tKQoSA5R+WtPqk
         wgvKmdrrn0kr+Bn0s5euJpc0hg5tmqBFLFqb1nWUj1WT6M61UjgfHy0eWQWcH6q7U01t
         rmllfF5iSLD+pqzHbqDhLBKA6HL8LZEQXuvMsQce0e5jeIdf/OSJjaNluiOdwkrsiCiC
         KGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Tu0toSJwrfhMKIyxWFiT4DhwAcH1lPBsvlhxQp3psic=;
        b=vzbVS+tDrS/tn8US2vYJjhlQ/2XNBoI5qXwZbuMkswit7+RyYYVcvGMTtqX2v+m06A
         RwbeRjqmtjWwLGCoVDwfwpqut6xDMKluGe9lkhBgvID9Qp40X+iaVipYn//yUAlq4PjN
         c75KRmmiOHKMUht6Se7MmiHDtHrePjAGX4tK8w7R5e4fsYunICkIW/5ZvXPIYHbalF46
         0tre4yBeo1ABo6JnKOBRPfREYmWMXLysEwkKVz24J8dyLv5k+INlS+f9tVnrvbbEIghe
         8UZXxJKQczz42MIxaYzHVEvjKSusenOoefOOUz0EJl1V80PL/on9/KTiaz12GqS0aXJ3
         y83Q==
X-Gm-Message-State: ACgBeo1CbROIa123/AVu00ZxMKUj+VtlpfHqeyEdlC8uWowW4K3H6fvl
	kRccnNaq3LkYcuZ5ky25efZvZcP10/0=
X-Google-Smtp-Source: AA6agR4jmvtNjFvjfBvXt+OklXGaxMJk0/qgSIlkPVvmquLyhyDlpJwdUeGGRyAUapEjFc7gEX1kfg==
X-Received: by 2002:a17:90b:1d89:b0:1f5:a59:46b1 with SMTP id pf9-20020a17090b1d8900b001f50a5946b1mr6880361pjb.173.1659562610765;
        Wed, 03 Aug 2022 14:36:50 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id b13-20020a65578d000000b00419fc2c27d8sm11527066pgr.43.2022.08.03.14.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 14:36:50 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 07/13] wiphy: dump wiphy's on regulatory domain change
Date: Wed,  3 Aug 2022 14:36:38 -0700
Message-Id: <20220803213644.277534-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220803213644.277534-1-prestwoj@gmail.com>
References: <20220803213644.277534-1-prestwoj@gmail.com>
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
 src/wiphy.c | 204 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 202 insertions(+), 2 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 3a6cd48c..b9f8009d 100644
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
@@ -121,6 +123,8 @@ struct wiphy {
 	/* Work queue for this radio */
 	struct l_queue *work;
 	bool work_in_callback;
+	unsigned int get_reg_id;
+	unsigned int dump_id;
 
 	bool support_scheduled_scan:1;
 	bool support_rekey_offload:1;
@@ -341,6 +345,12 @@ static void wiphy_free(void *data)
 
 	l_debug("Freeing wiphy %s[%u]", wiphy->name, wiphy->id);
 
+	if (wiphy->dump_id)
+		l_genl_family_cancel(nl80211, wiphy->dump_id);
+
+	if (wiphy->get_reg_id)
+		l_genl_family_cancel(nl80211, wiphy->get_reg_id);
+
 	for (i = 0; i < NUM_NL80211_IFTYPES; i++)
 		l_free(wiphy->iftype_extended_capabilities[i]);
 
@@ -1819,6 +1829,182 @@ static void wiphy_setup_rm_enabled_capabilities(struct wiphy *wiphy)
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
@@ -1851,6 +2037,14 @@ static void wiphy_update_reg_domain(struct wiphy *wiphy, bool global,
 	l_debug("New reg domain country code for %s is %c%c",
 		global ? "(global)" : wiphy->name,
 		out_country[0], out_country[1]);
+
+	/* Don't dump wiphy from a GET_REG call */
+	if (wiphy && wiphy->get_reg_id) {
+		wiphy->get_reg_id = 0;
+		return;
+	}
+
+	wiphy_dump_after_regdom(wiphy);
 }
 
 static void wiphy_get_reg_cb(struct l_genl_msg *msg, void *user_data)
@@ -1876,8 +2070,9 @@ static void wiphy_get_reg_domain(struct wiphy *wiphy)
 	msg = l_genl_msg_new(NL80211_CMD_GET_REG);
 	l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY, 4, &wiphy->id);
 
-	if (!l_genl_family_send(wiphy->nl80211, msg, wiphy_get_reg_cb, wiphy,
-				NULL)) {
+	wiphy->get_reg_id = l_genl_family_send(wiphy->nl80211, msg,
+						wiphy_get_reg_cb, wiphy, NULL);
+	if (!wiphy->get_reg_id) {
 		l_error("Error sending NL80211_CMD_GET_REG for %s", wiphy->name);
 		l_genl_msg_unref(msg);
 	}
@@ -2290,6 +2485,11 @@ static void wiphy_exit(void)
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

