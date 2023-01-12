Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6EA8476
	for <iwd@lists.linux.dev>; Thu, 12 Jan 2023 19:32:21 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id w3so21242206ply.3
        for <iwd@lists.linux.dev>; Thu, 12 Jan 2023 11:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqEd37xqg0TIhk91S9sCwhQq6FfXz5qJsZccc77fNOs=;
        b=DrD4eMoOvVDKlGFXOROn1WwU0yNJq3YLIuAmc3NtYeCD+ta4oWMh+Ei7fBURpJQebp
         Xq/kk69XyMv/7tWlwJONze+42FllFk0R2ZWbG26XhbHz7LqzI9rKliLxgZ1vGBph5eEG
         ztCG7wvwI1gv1BRUrxzpeuvFO9ZDUifkpkrfHb+YXXjxB49uLvDXX5/FndmLyimX6Mwr
         ICbRXoEnfZ4YycMnab9YWLk1qiK8oLN4bm1K/mEuVMb8nhCIBLBGiVdrBSr55qmf0vfy
         5UDdkqiVUmhPh36idsL1eDdAcGEYXuZB1t8xzClhdzrfI8fC6mK2lcEydn+WkmxpbXua
         uDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqEd37xqg0TIhk91S9sCwhQq6FfXz5qJsZccc77fNOs=;
        b=VM/laSXmSHIftEsxFX0glDCJlogMz2IntXZCIKl9Lnu/N9BJaYj5SCloERknk8mG+o
         KXV2a8zbD5VCvLgSEyNrwl4a5wIc7qZrUOvh9Ve+DMt3+xiquj34Dc8v6cxQI4uHjUUo
         bVecf1uEDfAJO3r5NZ9okUF9D2tXl2NKvc7OsC14fPNZOdPOT5CCXaW+oEA5J0c89GF2
         4epV50k8SOCyQ//D6bZA9PcISV/LasOtM/LG4IQyEZFpG3WzFoAzWwqcea5aLcM+BBV4
         Y18MHrWAsjKcyWtx8Tf4UTYrzzIbtJOUc90MTVl8+mVomzKHkZHYPWqpel0peNropegm
         YZ3w==
X-Gm-Message-State: AFqh2koTW9XYQQ7xpWjz3CkWwvxKuMAtWGcYzsQIRkG4vfrzbp9rB4Zw
	mLPpsx20dJYlfcNmcByo4BoRTq6mxgM=
X-Google-Smtp-Source: AMrXdXvTmyJX4QHozsMDc1iycei1dhCOA4wxtNWVz+t0Nc3Eei1ymKFXhiUE7xuqF+dFvb/mnXDSAw==
X-Received: by 2002:a17:90a:f112:b0:226:6d:1a31 with SMTP id cc18-20020a17090af11200b00226006d1a31mr8079214pjb.49.1673551941280;
        Thu, 12 Jan 2023 11:32:21 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id qe12-20020a17090b4f8c00b00218fba260e2sm12732147pjb.43.2023.01.12.11.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 11:32:20 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/4] ap: support PTK rekeys
Date: Thu, 12 Jan 2023 11:32:11 -0800
Message-Id: <20230112193212.568476-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230112193212.568476-1-prestwoj@gmail.com>
References: <20230112193212.568476-1-prestwoj@gmail.com>
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
 src/ap.c | 114 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/src/ap.c b/src/ap.c
index 1d937103..ef819724 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -60,6 +60,8 @@
 #include "src/band.h"
 #include "src/common.h"
 
+#define AP_DEFAULT_REKEY_SECONDS 600
+
 struct ap_state {
 	struct netdev *netdev;
 	struct l_genl_family *nl80211;
@@ -106,6 +108,9 @@ struct ap_state {
 	struct l_dbus_message *scan_pending;
 	struct l_queue *networks;
 
+	struct l_timeout *rekey_timeout;
+	unsigned int rekey_time;
+
 	bool started : 1;
 	bool gtk_set : 1;
 	bool netconfig_set_addr4 : 1;
@@ -137,6 +142,7 @@ struct sta_state {
 	bool wsc_v2;
 	struct l_dhcp_lease *ip_alloc_lease;
 	bool ip_alloc_sent;
+	uint64_t rekey_time;
 
 	bool ht_support : 1;
 	bool ht_greenfield : 1;
@@ -345,6 +351,11 @@ static void ap_reset(struct ap_state *ap)
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
@@ -377,6 +388,8 @@ static bool ap_event(struct ap_state *ap, enum ap_event_type event,
 	return ap_event_done(ap, prev);
 }
 
+static void ap_reset_rekey_timeout(struct ap_state *ap);
+
 static void ap_del_station(struct sta_state *sta, uint16_t reason,
 				bool disassociate)
 {
@@ -439,6 +452,89 @@ static void ap_del_station(struct sta_state *sta, uint16_t reason,
 
 		ap_event_done(ap, prev);
 	}
+
+	ap_reset_rekey_timeout(ap);
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
+	l_timeout_remove(timeout);
+
+	ap_reset_rekey_timeout(ap);
+}
+
+/*
+ * Used to initiate any rekeys which are due and reset the rekey timer to the
+ * next soonest station needing a rekey.
+ *
+ * TODO: Could adapt this to also take into account the next GTK rekey and
+ * service that as well. But GTK rekeys are not yet supported in AP mode.
+ */
+static void ap_reset_rekey_timeout(struct ap_state *ap)
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
+		if (!sta->associated || !sta->rsna)
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
+	 * Set the next rekey to the station needing it the soonest, or NULL
+	 * if a single station and wait until the rekey is complete to reset
+	 * the timer.
+	 */
+	if (next)
+		ap->rekey_timeout = l_timeout_create(l_time_to_secs(next),
+						ap_rekey_timeout, ap, NULL);
+	else
+		ap->rekey_timeout = NULL;
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
@@ -479,6 +575,8 @@ static void ap_new_rsna(struct sta_state *sta)
 
 	sta->rsna = true;
 
+	ap_set_sta_rekey_timer(ap, sta);
+
 	event_data.mac = sta->addr;
 	event_data.assoc_ies = sta->assoc_ies;
 	event_data.assoc_ies_len = sta->assoc_ies_len;
@@ -1372,6 +1470,9 @@ static void ap_handshake_event(struct handshake_state *hs,
 		sta->hs->go_ip_addr = IP4_FROM_STR(own_addr_str);
 		break;
 	}
+	case HANDSHAKE_EVENT_REKEY_COMPLETE:
+		ap_set_sta_rekey_timer(ap, sta);
+		return;
 	default:
 		break;
 	}
@@ -3628,6 +3729,19 @@ static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
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
+		ap->rekey_time = AP_DEFAULT_REKEY_SECONDS * L_USEC_PER_SEC;
+
 	/*
 	 * Since 5GHz won't ever support only CCK rates we can ignore this
 	 * setting on that band.
-- 
2.34.3

