Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFF96FBC
	for <iwd@lists.linux.dev>; Wed, 28 Dec 2022 22:32:35 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id d3so17251699plr.10
        for <iwd@lists.linux.dev>; Wed, 28 Dec 2022 14:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moFZXKdsfPgoJa4MjdjZ8x0fkJVSOcP3+f9jLjbciVM=;
        b=WkmAPFyaVuCoR9w3pKnUfTl/9uMkkM1ymkRL9EPejMYsxpVa/J864OzhBPUsyzNUGr
         2+kGYlrAFzn/lcOFhupdfBbvp1fPcyvyuYJYo2qEzp7I3N+rj/0PKPtb7cTiQ6CdVLAA
         TbmJyGE/LkpqKBfnFMxpFI5Q/K91mxHuIfRixD+LiUJJLpJ2jCA3U4xiFD+KdAc/7BUx
         MPoyq3uGhd0VVdfJ+yZYdZOD7AUkasWa2RRBE6c7gbsNQlMJ14aluUDs14K7/7mjyhiF
         yYWAqbfP5yw27k/CeHZd7XYs14gCQVy03qqwJy+zZ/VvbAsq2r8bkThwSgC4W3SMaEZN
         M+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moFZXKdsfPgoJa4MjdjZ8x0fkJVSOcP3+f9jLjbciVM=;
        b=CQAFOdv4NLBzwsnJDGo+9KUwEXD1EqjxDFfgOBMh+HpsR1qZPgO8twldWBau/InOpI
         U2CPaKahXEz2Tmdu9DUdswy3/WbUE8WAxaltnjpWi+D1uwypFJPquspW7B+tBixFFZIs
         dgNigbIfc5VvB1E7PpIPPIxuBL8qIDJYJpl9zsXedJBLBIGzv9luqC17WuJgdGVhI7VY
         g0lglmdxSoGWoRDZeODuUCXcWZSfWavpIR1Er7HfKQrYtrJ46B9W8t02OpPl48eWY2u7
         GTilSWmF8QIYe2HJZ1pGr1SAbm+8tfxNLQqBI5dFkWUUfrEMPANMy3xt4SZre2YfK1NH
         zL2A==
X-Gm-Message-State: AFqh2ko5B29rYUcujX/EvajW7sZRc8MPnD7tBhuYn13SBJ+0aRmoBvN+
	YwunTpJRRHa7p/JZ7X9G35lflvYstEw=
X-Google-Smtp-Source: AMrXdXtWw5DxsZLghyAo2m00V892D4Iqa0l3n5JK679riKcLzoFsKxnXfAkSoMw+ku4eVQ8KVzBGKg==
X-Received: by 2002:a17:903:200b:b0:192:467e:7379 with SMTP id s11-20020a170903200b00b00192467e7379mr23844155pla.49.1672266755092;
        Wed, 28 Dec 2022 14:32:35 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id t8-20020a170902e84800b0017849a2b56asm11549544plg.46.2022.12.28.14.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 14:32:34 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/4] ap: generate chandef for starting AP
Date: Wed, 28 Dec 2022 14:32:30 -0800
Message-Id: <20221228223231.2686276-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221228223231.2686276-1-prestwoj@gmail.com>
References: <20221228223231.2686276-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To include HT support a chandef needs to be created for whatever
frequency is being used. This allows IWD to provide a secondary
channel to the kernel in the case of 40MHz operation. Now the AP
will generate a chandef when starting based on the channel set
in the user profile (or default).

If HT is not supported the chandef width is set to 20MHz no-HT,
otherwise band_freq_to_ht_chandef is used.
---
 src/ap.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

v3:
 * Reordered this before the HT builders so the build wont
   fail if applied incrementally.

diff --git a/src/ap.c b/src/ap.c
index b505499d..a8c415d5 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -72,6 +72,7 @@ struct ap_state {
 	uint8_t psk[32];
 	enum band_freq band;
 	uint8_t channel;
+	struct band_chandef chandef;
 	uint8_t *authorized_macs;
 	unsigned int authorized_macs_num;
 	char wsc_name[33];
@@ -2469,8 +2470,6 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struct ap_state *ap)
 	uint32_t nl_akm = CRYPTO_AKM_PSK;
 	uint32_t wpa_version = NL80211_WPA_VERSION_2;
 	uint32_t auth_type = NL80211_AUTHTYPE_OPEN_SYSTEM;
-	uint32_t ch_freq = band_channel_to_freq(ap->channel, ap->band);
-	uint32_t ch_width = NL80211_CHAN_WIDTH_20;
 	unsigned int i;
 
 	static const uint8_t bcast_addr[6] = {
@@ -2518,8 +2517,13 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struct ap_state *ap)
 	l_genl_msg_append_attr(cmd, NL80211_ATTR_WPA_VERSIONS, 4, &wpa_version);
 	l_genl_msg_append_attr(cmd, NL80211_ATTR_AKM_SUITES, 4, &nl_akm);
 	l_genl_msg_append_attr(cmd, NL80211_ATTR_AUTH_TYPE, 4, &auth_type);
-	l_genl_msg_append_attr(cmd, NL80211_ATTR_WIPHY_FREQ, 4, &ch_freq);
-	l_genl_msg_append_attr(cmd, NL80211_ATTR_CHANNEL_WIDTH, 4, &ch_width);
+	l_genl_msg_append_attr(cmd, NL80211_ATTR_WIPHY_FREQ, 4,
+				&ap->chandef.frequency);
+	l_genl_msg_append_attr(cmd, NL80211_ATTR_CHANNEL_WIDTH, 4,
+				&ap->chandef.channel_width);
+	if (ap->chandef.center1_frequency)
+		l_genl_msg_append_attr(cmd, NL80211_ATTR_CENTER_FREQ1, 4,
+					&ap->chandef.center1_frequency);
 
 	if (wiphy_supports_probe_resp_offload(wiphy)) {
 		uint8_t probe_resp[head_len + tail_len];
@@ -3255,6 +3259,32 @@ static bool ap_validate_band_channel(struct ap_state *ap)
 		l_error("AP frequency %u disabled or unsupported", freq);
 		return false;
 	}
+
+	if (ap->supports_ht) {
+		if (band_freq_to_ht_chandef(freq, attr, &ap->chandef) < 0) {
+			/*
+			 * This is unlikely ever to fail since there are no
+			 * 20Mhz restrictions, but just in case fall back to
+			 * non-HT.
+			 */
+			ap->supports_ht = false;
+
+			l_warn("AP could not find HT chandef for frequency %u"
+				" using 20Mhz no-HT", freq);
+
+			goto no_ht;
+		}
+	} else {
+no_ht:
+		ap->chandef.frequency = freq;
+		ap->chandef.channel_width = BAND_CHANDEF_WIDTH_20NOHT;
+	}
+
+	l_debug("AP using frequency %u and channel width %s",
+			ap->chandef.frequency,
+			band_chandef_width_to_string(
+				ap->chandef.channel_width));
+
 	return true;
 }
 
-- 
2.34.3

