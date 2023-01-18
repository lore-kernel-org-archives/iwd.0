Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3503A8C05
	for <iwd@lists.linux.dev>; Wed, 18 Jan 2023 21:18:06 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id dw9so348186pjb.5
        for <iwd@lists.linux.dev>; Wed, 18 Jan 2023 13:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaCP6S2ReChqSoGrUzR438Yo++JoT2EG/IhL3hfimK8=;
        b=G+YnqyzWxBbwZK9ivXsUC5GFd7tHJcfuv/P7fGrhMd5CzIxMZ13QodW5F0enq6FL9K
         nrkqe91NpCMawECpr1JvLiJIdP5kIxuo8V0BUA1+O+e6+90yxXPzEIleTCOaHKqlb3dC
         I5n4cmLCirW23YtT8Jp2/Oa7Xk7vU1k1LUfhiLzVyAWrk+Lplt1yEN6GA1KrYFYcnf8I
         lWSTvV8AteNA5ndCjH5Rhqs2LCG/uhjBOy4u7fTGI+mXokOviBHHpj6JgyMMF99GebyI
         zquugYjvcv7KFIApvxf8Askfx16Ns+A+LMMaZ8LbepSevGUlVt6AOCClCdYe8nGl/kvC
         53DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaCP6S2ReChqSoGrUzR438Yo++JoT2EG/IhL3hfimK8=;
        b=74U5fz9MhduFP+3ttLnQ8f/OxB1Q5QpqYwVz1EB8Tvk7jMFF2JQdsmRvonEzJIbeCq
         GD0WpDSx0JsNe6176aj4y3njJI+RYQoFzZvmWPAocy1BHB90wM0CPEbC4gfGtur8NYTa
         4EFtfQj3WgLkWDNG1xUGaf6JqqNAbNeo5luG3WOSuQJHT/t3om/ADxfvzO8E9lnjL8Gb
         b7VYo42xqM4amX/AabXOMqM/D4nt1ZgzmX1ATTZk+eTK4cXUzt2hVXVUF6zqalo8vkjD
         3eR2OYwfLWlXlHcIXC3BQ79o8inPFJ1G8S4U7NZ/T1z7LsSl7Dy+biLEXeDJaZuahNZ8
         6xEg==
X-Gm-Message-State: AFqh2krEu5n1i4kiIPkB/pxgcxCqziaZE2320fpfcnj7kBmCXlCzBRQe
	SANDlTw3wENRPxXYF8Dcl+EyeGwM+/Y=
X-Google-Smtp-Source: AMrXdXsa0hwhcrapUiMDvP0/tGM9mnLzTJ6d5HzveHpRMNmExpzSk6mmIu6895V1YbEzBi3BadPd8w==
X-Received: by 2002:a17:90b:3614:b0:226:de51:5408 with SMTP id ml20-20020a17090b361400b00226de515408mr31937919pjb.31.1674076685428;
        Wed, 18 Jan 2023 13:18:05 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090a5d0700b0022335f1dae2sm1784802pji.22.2023.01.18.13.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 13:18:04 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/3] ap: support PTK rekeys
Date: Wed, 18 Jan 2023 13:18:00 -0800
Message-Id: <20230118211801.1636194-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230118211801.1636194-1-prestwoj@gmail.com>
References: <20230118211801.1636194-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for rekeys to AP mode. A single timer is used and
reset to the next station needing a rekey. A default rekey timer of
600 seconds is used unless the profile sets a timeout.
---
 src/ap.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

v3:
 * Rename API to ap_check_rekeys. As this both starts rekeys and
   resets the timer
 * Use l_timeout_modify when the timer is reset to a new station
 * Check sta->rekey_time as well as set to 0 in case of del station.
   This ensures the station that left isn't taken into account when
   the rekey timeout is calculated.
 * Make the default rekey time zero (disabled) if no config value is
   set.
diff --git a/src/ap.c b/src/ap.c
index 1d937103..531babb2 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -106,6 +106,9 @@ struct ap_state {
 	struct l_dbus_message *scan_pending;
 	struct l_queue *networks;
 
+	struct l_timeout *rekey_timeout;
+	unsigned int rekey_time;
+
 	bool started : 1;
 	bool gtk_set : 1;
 	bool netconfig_set_addr4 : 1;
@@ -137,6 +140,7 @@ struct sta_state {
 	bool wsc_v2;
 	struct l_dhcp_lease *ip_alloc_lease;
 	bool ip_alloc_sent;
+	uint64_t rekey_time;
 
 	bool ht_support : 1;
 	bool ht_greenfield : 1;
@@ -345,6 +349,11 @@ static void ap_reset(struct ap_state *ap)
 		l_queue_destroy(ap->networks, l_free);
 		ap->networks = NULL;
 	}
+
+	if (ap->rekey_timeout) {
+		l_timeout_remove(ap->rekey_timeout);
+		ap->rekey_timeout = NULL;
+	}
 }
 
 static bool ap_event_done(struct ap_state *ap, bool prev_in_event)
@@ -377,6 +386,8 @@ static bool ap_event(struct ap_state *ap, enum ap_event_type event,
 	return ap_event_done(ap, prev);
 }
 
+static void ap_check_rekeys(struct ap_state *ap);
+
 static void ap_del_station(struct sta_state *sta, uint16_t reason,
 				bool disassociate)
 {
@@ -439,6 +450,93 @@ static void ap_del_station(struct sta_state *sta, uint16_t reason,
 
 		ap_event_done(ap, prev);
 	}
+
+	/*
+	 * Set the rekey time to zero which will skip this station when
+	 * determining the next rekey.
+	 */
+	sta->rekey_time = 0;
+	ap_check_rekeys(ap);
+}
+
+static void ap_start_rekey(struct ap_state *ap, struct sta_state *sta)
+{
+	l_debug("Rekey STA "MAC, MAC_STR(sta->addr));
+
+	eapol_start(sta->sm);
+}
+
+static void ap_rekey_timeout(struct l_timeout *timeout, void *user_data)
+{
+	struct ap_state *ap = user_data;
+
+	ap_check_rekeys(ap);
+}
+
+/*
+ * Used to check/start any rekeys which are due and reset the rekey timer to the
+ * next soonest station needing a rekey.
+ *
+ * TODO: Could adapt this to also take into account the next GTK rekey and
+ * service that as well. But GTK rekeys are not yet supported in AP mode.
+ */
+static void ap_check_rekeys(struct ap_state *ap)
+{
+	const struct l_queue_entry *e;
+	uint64_t now = l_time_now();
+	uint64_t next = 0;
+
+	if (!ap->rekey_time)
+		return;
+
+	/* Find the station(s) that need a rekey and start it */
+	for (e = l_queue_get_entries(ap->sta_states); e; e = e->next) {
+		struct sta_state *sta = e->data;
+
+		if (!sta->associated || !sta->rsna || sta->rekey_time == 0)
+			continue;
+
+		if (l_time_before(now, sta->rekey_time)) {
+			uint64_t diff = l_time_diff(now, sta->rekey_time);
+
+			/* Finding the next rekey time */
+			if (next < diff)
+				next = diff;
+
+			continue;
+		}
+
+		ap_start_rekey(ap, sta);
+	}
+
+	/*
+	 * Set the next rekey to the station needing it the soonest, or remove
+	 * if a single station and wait until the rekey is complete to reset
+	 * the timer.
+	 */
+	if (next)
+		l_timeout_modify(ap->rekey_timeout, l_time_to_secs(next));
+	else {
+		l_timeout_remove(ap->rekey_timeout);
+		ap->rekey_timeout = NULL;
+	}
+}
+
+static void ap_set_sta_rekey_timer(struct ap_state *ap, struct sta_state *sta)
+{
+	if (!ap->rekey_time)
+		return;
+
+	sta->rekey_time = l_time_now() + ap->rekey_time - 1;
+
+	/*
+	 * First/only station authenticated, set rekey timer. Any more stations
+	 * will just set their rekey time and be serviced by the single callback
+	 */
+	if (!ap->rekey_timeout)
+		ap->rekey_timeout = l_timeout_create(
+						l_time_to_secs(ap->rekey_time),
+						ap_rekey_timeout, ap, NULL);
 }
 
 static bool ap_sta_match_addr(const void *a, const void *b)
@@ -479,6 +577,8 @@ static void ap_new_rsna(struct sta_state *sta)
 
 	sta->rsna = true;
 
+	ap_set_sta_rekey_timer(ap, sta);
+
 	event_data.mac = sta->addr;
 	event_data.assoc_ies = sta->assoc_ies;
 	event_data.assoc_ies_len = sta->assoc_ies_len;
@@ -1372,6 +1472,9 @@ static void ap_handshake_event(struct handshake_state *hs,
 		sta->hs->go_ip_addr = IP4_FROM_STR(own_addr_str);
 		break;
 	}
+	case HANDSHAKE_EVENT_REKEY_COMPLETE:
+		ap_set_sta_rekey_timer(ap, sta);
+		return;
 	default:
 		break;
 	}
@@ -3628,6 +3731,19 @@ static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
 		l_strfreev(strvval);
 	}
 
+	if (l_settings_has_key(config, "General", "RekeyTimeout")) {
+		unsigned int uintval;
+
+		if (!l_settings_get_uint(config, "General",
+						"RekeyTimeout", &uintval)) {
+			l_error("AP [General].RekeyTimeout is not valid");
+			return -EINVAL;
+		}
+
+		ap->rekey_time = uintval * L_USEC_PER_SEC;
+	} else
+		ap->rekey_time = 0;
+
 	/*
 	 * Since 5GHz won't ever support only CCK rates we can ignore this
 	 * setting on that band.
-- 
2.34.3

