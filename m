Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1B021CCD
	for <iwd@lists.linux.dev>; Wed, 10 May 2023 20:42:04 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-50be0d835aaso13806986a12.3
        for <iwd@lists.linux.dev>; Wed, 10 May 2023 13:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683751323; x=1686343323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGLAkjNrRMLp3It5Tv8za4bbGAfw7sQQOVbYnmrRTis=;
        b=nzKCzccq6Pu1Y3FShqV+Zc6WTUY5nZyFDKSqhP/Ye44H9yGfHVLP6c4zjHQUqTgjZU
         AJGqNAUDq1ovAlllTEsYssE/Qr83axKgEhT7yBcAHlSb/2Fw9UyNk1Xx/wbhNob+9lid
         1z+dKiDQkerDbFOcSmc1JSMP9ksDW3hJ4+Dzajbrqz0Py6921K9GetUN6zAYYCjFeHK2
         uway+9Kz0H5LrepR9Iu0Xzm9v3NOslRApc9fFA9IGaISzfNTHz8MU28gRGKTABo9g2Zj
         so5WmDf/x7W91QDiKlqYxybVbCx5Xp5KIrWuGe0YIej6JUjnItBUbBpMlSvOgmPGS3B9
         THXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683751323; x=1686343323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGLAkjNrRMLp3It5Tv8za4bbGAfw7sQQOVbYnmrRTis=;
        b=QT21JCMXjQI/EKOrC0jV/Rpj1IIwkRxew+1miYKAiK28WYRXR0VVtTbXDvJEGHy9a3
         oBCvknpzrAahd1K/N3yKUEW1cWGNQa0STvA8rylOibMBm/KB8tu3Ky3KANMSmzHUq+/x
         atOcBvpQJsyZ9N20dJYoyGqVw/TS7K08Es9zh41KdlKGs/0W/QE0d/9MXYabrHxqqYgf
         M2Jj1j2LY+a+Y+C18cjG7vMW39eS5pKKao3IKttkgyaNqwWDvlD5Jt1uYKMpDnCccLlj
         2CO25zzBNb8FiOksmGu6U3SgYTITTZEOVx6MO0Gjzb05z2pzAGNP/YLpYgAlGHvp/TXV
         aU5A==
X-Gm-Message-State: AC+VfDy+7q0mzqVvyT5G+oQbPTuuGRwi3phvqxJHXfhuW+ehIL5mr3h/
	By6QfP/iBWKbQ7LbfMGuZIIoGo6rzZ0=
X-Google-Smtp-Source: ACHHUZ4xURUFr2zwFOP/Tn967xNnDT/V4Wuq3rAxYo2LGrZVi3x9a8WtlyxHIWTS3I46qVs1myZdEQ==
X-Received: by 2002:a05:6402:28d:b0:506:fcd5:6159 with SMTP id l13-20020a056402028d00b00506fcd56159mr15784772edv.21.1683751322447;
        Wed, 10 May 2023 13:42:02 -0700 (PDT)
Received: from LOCLAP699.unipharma-middelburg.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id q22-20020a056402041600b004ad601533a3sm2237700edv.55.2023.05.10.13.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 13:42:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/1] wiphy: fix regdom change wiphy dump logic
Date: Wed, 10 May 2023 13:41:51 -0700
Message-Id: <20230510204153.715304-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230510204153.715304-1-prestwoj@gmail.com>
References: <20230510204153.715304-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain drivers change the regulatory domain when the client roams.
First XX, then the country the roam target is using. Depending on the
timing the second regdom event can come while the first is still
dumping. This was not handled gracefully/nicely in IWD and it would
just issue another dump (it tries to cancel but if the dump started
there isn't anything that can be done). AFAIK the kernel should be
able to handle this but based on the behavior we saw it seems to not
be able to, or at least not reliably.

When the second dump comes in and GET_WIPHY is issued the kernel
stops replying to any messages which obviously causes IWD to completely
hang up waiting for various acks (set_station, set_key, etc.).

Now if another dump is ongoing (and cant be safely canceled) a flag
will be set when another dump is needed. The first dump will be
waited for and only once completed will another start. This also
ensures there is at most 1 pending dump when before any number of
dumps could be queued which is pointless since only the last dump
request matters.
---
 src/wiphy.c | 103 +++++++++++++++++++++++++++-------------------------
 1 file changed, 54 insertions(+), 49 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 2db2d2cd..dbffa44e 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -67,6 +67,7 @@ static int mac_randomize_bytes = 6;
 static char regdom_country[2];
 static uint32_t work_ids;
 static unsigned int wiphy_dump_id;
+static bool dump_queued;
 
 enum driver_flag {
 	DEFAULT_IF = 0x1,
@@ -123,6 +124,7 @@ struct wiphy {
 	bool work_in_callback;
 	unsigned int get_reg_id;
 	unsigned int dump_id;
+	bool dump_queued : 1;
 
 	bool support_scheduled_scan:1;
 	bool support_rekey_offload:1;
@@ -2066,18 +2068,23 @@ static void wiphy_setup_rm_enabled_capabilities(struct wiphy *wiphy)
 	 */
 }
 
+static void wiphy_dump_after_regdom(struct wiphy *wiphy);
+
 static void wiphy_dump_done(void *user_data)
 {
 	struct wiphy *wiphy = user_data;
 	const struct l_queue_entry *e;
 
-	/* This dump was canceled due to another dump */
-	if ((wiphy && !wiphy->dump_id) || (!wiphy && !wiphy_dump_id))
-		return;
-
 	if (wiphy) {
 		wiphy->dump_id = 0;
 
+		if (wiphy->dump_queued) {
+			wiphy->dump_queued = false;
+			wiphy_dump_after_regdom(wiphy);
+			return;
+		}
+
+		/* No other dumps queued, emit done */
 		WATCHLIST_NOTIFY(&wiphy->state_watches,
 				wiphy_state_watch_func_t, wiphy,
 				WIPHY_STATE_WATCH_EVENT_REGDOM_DONE);
@@ -2087,6 +2094,12 @@ static void wiphy_dump_done(void *user_data)
 
 	wiphy_dump_id = 0;
 
+	if (dump_queued) {
+		dump_queued = false;
+		wiphy_dump_after_regdom(NULL);
+		return;
+	}
+
 	for (e = l_queue_get_entries(wiphy_list); e; e = e->next) {
 		wiphy = e->data;
 
@@ -2160,38 +2173,48 @@ static void wiphy_dump_callback(struct l_genl_msg *msg,
 	}
 }
 
-static bool wiphy_cancel_last_dump(struct wiphy *wiphy)
+static void wiphy_dump_after_regdom(struct wiphy *wiphy)
 {
-	unsigned int id = 0;
+	const struct l_queue_entry *e;
+	struct l_genl_msg *msg;
+	unsigned int *id = NULL;
 
-	/*
-	 * Zero command ID to signal that wiphy_dump_done doesn't need to do
-	 * anything.
-	 */
-	if (wiphy && wiphy->dump_id) {
-		id = wiphy->dump_id;
-		wiphy->dump_id = 0;
-	} else if (!wiphy && wiphy_dump_id) {
-		id = wiphy_dump_id;
-		wiphy_dump_id = 0;
-	}
+	if (wiphy)
+		id = &wiphy->dump_id;
+	else
+		id = &wiphy_dump_id;
 
-	if (id) {
-		l_debug("Canceling pending regdom wiphy dump (%s)",
+	if (*id) {
+		/*
+		 * If the dump hasn't hit the kernel we can safely cancel it.
+		 * Otherwise set the dump_queued flag and once the current dump
+		 * has completed, another will start. This also ensures there is
+		 * only at most 1 pending dump.
+		 */
+		if (!l_genl_family_request_sent(nl80211, *id)) {
+			l_debug("Canceling pending regdom wiphy dump (%s)",
 					wiphy ? wiphy->name : "global");
 
-		l_genl_family_cancel(nl80211, id);
+			l_genl_family_cancel(nl80211, *id);
+
+			/*
+			 * If there is already dump queued (dump_queued=true)
+			 * the destroy callback will end up starting another
+			 * dump. If this happens nothing more needs to be done.
+			 */
+			if (*id)
+				return;
+		} else if (wiphy) {
+			wiphy->dump_queued = true;
+			return;
+		} else {
+			dump_queued = true;
+			return;
+		}
 	}
 
-	return id != 0;
-}
-
-static void wiphy_dump_after_regdom(struct wiphy *wiphy)
-{
-	const struct l_queue_entry *e;
-	struct l_genl_msg *msg;
-	unsigned int id;
-	bool no_start_event;
+	l_debug("Dumping wiphy after regdom change (%s)",
+			wiphy ? wiphy->name : "global");
 
 	msg = l_genl_msg_new_sized(NL80211_CMD_GET_WIPHY, 128);
 
@@ -2199,37 +2222,22 @@ static void wiphy_dump_after_regdom(struct wiphy *wiphy)
 		l_genl_msg_append_attr(msg, NL80211_ATTR_WIPHY, 4, &wiphy->id);
 
 	l_genl_msg_append_attr(msg, NL80211_ATTR_SPLIT_WIPHY_DUMP, 0, NULL);
-	id = l_genl_family_dump(nl80211, msg, wiphy_dump_callback,
+	*id = l_genl_family_dump(nl80211, msg, wiphy_dump_callback,
 						wiphy, wiphy_dump_done);
-	if (!id) {
+	if (!*id) {
 		l_error("Wiphy information dump failed");
 		l_genl_msg_unref(msg);
 		return;
 	}
 
-	/*
-	 * Another update while dumping wiphy. This next dump should supercede
-	 * the first and not result in a DONE event until this new dump is
-	 * finished. This is because the disabled frequencies are in an unknown
-	 * state and could cause incorrect behavior by any watchers.
-	 */
-	no_start_event = wiphy_cancel_last_dump(wiphy);
-
 	/* Limited dump so just emit the event for this wiphy */
 	if (wiphy) {
-		wiphy->dump_id = id;
-
-		if (no_start_event)
-			return;
-
 		WATCHLIST_NOTIFY(&wiphy->state_watches,
 				wiphy_state_watch_func_t, wiphy,
 				WIPHY_STATE_WATCH_EVENT_REGDOM_STARTED);
 		return;
 	}
 
-	wiphy_dump_id = id;
-
 	/* Otherwise for a global regdom change notify for all wiphy's */
 	for (e = l_queue_get_entries(wiphy_list); e; e = e->next) {
 		struct wiphy *w = e->data;
@@ -2237,9 +2245,6 @@ static void wiphy_dump_after_regdom(struct wiphy *wiphy)
 		if (w->self_managed)
 			continue;
 
-		if (no_start_event)
-			continue;
-
 		WATCHLIST_NOTIFY(&w->state_watches, wiphy_state_watch_func_t,
 				w, WIPHY_STATE_WATCH_EVENT_REGDOM_STARTED);
 	}
-- 
2.25.1

