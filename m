Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847A56FAB
	for <iwd@lists.linux.dev>; Fri,  9 Dec 2022 19:39:35 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id r18so4186952pgr.12
        for <iwd@lists.linux.dev>; Fri, 09 Dec 2022 11:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJX/EgNsrm20KhvOSHOaaaozZDbxuZrNObBvZjtNWSo=;
        b=CBiFbtCJdkGkHlX+45PokhWEhLrUPdl6P/+SSdM5MIfKpMYDEPlBbBvuYD6bh69wG9
         njAD1Nc2Q/4O+/ubDphKwAEFivndKZdLlkP1L6E4UY/siP2AjWNCt8Pa+UJi53cIvWgC
         gsWOWTCizO0pkawswV1ayQF9tooMWmxXD6LubuyOVVTLVGR34yEc08xQ5iOlEaUMC3CF
         eZfdR92Wtbk4ltepuDRQO6sXeIKTJv5wtHVQwzJimrn4/PuIC6ytSnADQmnBL3TDlnpu
         CWSCeiPFVe+rAUuBVcxkkx5Gurw0YwxDRhwZTHeu/7Wh70vzdqAFJP5OwRwXEyIK3DBM
         POcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJX/EgNsrm20KhvOSHOaaaozZDbxuZrNObBvZjtNWSo=;
        b=fCnEdGjsFuu0rt0DtCBe+Pg9uHFZZtpTdp6kPJV31IgGmPch2i9LoiFTk56Dq4n7Bm
         fkyFMRNUQ7ZcDR0F/em9VToct0p0iF/xa7JtaxXGG8/qm+bS6ik9FmoNQ6K/8tHcFbX8
         ONizd3ySAFOUlBV4HcE5bnrLtvbiXXkF8vIGbDwNf80klPSlmD97lcoDgd4gqq6+2hwr
         khxnTKWKJaaQ/dAFZI4GxyF7wnIztOBBGy2aijUsN9grYQIVnffHk9c0M8djnEOqWUDD
         TG0cUspft5bsuxlMNsIMB5DXm/G3AG3ri7p2/oAQ23WdwnOxlVTIfoEXZy9u26VrMq1r
         bwmQ==
X-Gm-Message-State: ANoB5plvEIdgHXKUTxQnZ5cQBGq21Sn3f9a9TppIhhMPYHyn9bhOqLEk
	dE+Ioc3QOmJBDvktv7f4z91RbaqQVF0=
X-Google-Smtp-Source: AA0mqf7vdqz36EzRHG9BCaNE5akhHfXmwYZXii+WAdEaN0jWvwQ8FUbTIaKcCRdNnZUeZBcoCzBEOw==
X-Received: by 2002:a62:524c:0:b0:576:b277:2cd with SMTP id g73-20020a62524c000000b00576b27702cdmr6746479pfb.34.1670614774751;
        Fri, 09 Dec 2022 11:39:34 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id x28-20020aa78f1c000000b0056bc5ad4862sm1587638pfr.28.2022.12.09.11.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:39:33 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 2/4] ap: add support for 5GHz frequencies in AP mode
Date: Fri,  9 Dec 2022 11:39:28 -0800
Message-Id: <20221209193930.845238-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221209193930.845238-1-prestwoj@gmail.com>
References: <20221209193930.845238-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This enables IWD to use 5GHz frequencies in AP mode. Currently
6GHz is not supported so we can assume a [General].Channel value
36 or above indicates the 5GHz band.

It should be noted that the system will probably need a regulatory
domain set in order for 5GHz to be allowed in AP mode. This is due
to world roaming (00) restricting any/all 5GHz frequencies. This
can be accomplished by setting main.conf [General].Country=CC to
the country this AP will operate in.
---
 src/ap.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 8 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 69412174..72951320 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -70,6 +70,7 @@ struct ap_state {
 	char ssid[33];
 	char passphrase[64];
 	uint8_t psk[32];
+	enum band_freq band;
 	uint8_t channel;
 	uint8_t *authorized_macs;
 	unsigned int authorized_macs_num;
@@ -985,7 +986,7 @@ static uint32_t ap_send_mgmt_frame(struct ap_state *ap,
 					frame_xchg_cb_t callback,
 					void *user_data)
 {
-	uint32_t ch_freq = band_channel_to_freq(ap->channel, BAND_FREQ_2_4_GHZ);
+	uint32_t ch_freq = band_channel_to_freq(ap->channel, ap->band);
 	uint64_t wdev_id = netdev_get_wdev_id(ap->netdev);
 	struct iovec iov[2];
 
@@ -2408,7 +2409,7 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struct ap_state *ap)
 	uint32_t nl_akm = CRYPTO_AKM_PSK;
 	uint32_t wpa_version = NL80211_WPA_VERSION_2;
 	uint32_t auth_type = NL80211_AUTHTYPE_OPEN_SYSTEM;
-	uint32_t ch_freq = band_channel_to_freq(ap->channel, BAND_FREQ_2_4_GHZ);
+	uint32_t ch_freq = band_channel_to_freq(ap->channel, ap->band);
 	uint32_t ch_width = NL80211_CHAN_WIDTH_20;
 	unsigned int i;
 
@@ -3170,6 +3171,42 @@ static char **ap_ciphers_to_strv(uint16_t ciphers)
 	return list;
 }
 
+static bool ap_validate_band_channel(struct ap_state *ap)
+{
+	struct wiphy *wiphy = netdev_get_wiphy(ap->netdev);
+	const struct scan_freq_set *supported;
+	const struct scan_freq_set *disabled;
+	uint32_t freq;
+
+	if (!(wiphy_get_supported_bands(wiphy) & ap->band)) {
+		l_error("AP hardware does not support band");
+		return -EINVAL;
+	}
+
+	freq = band_channel_to_freq(ap->channel, ap->band);
+	if (!freq) {
+		l_error("AP invalid band (%s) and channel (%u) combination",
+			(ap->band & BAND_FREQ_5_GHZ) ? "5Ghz" : "2.4GHz",
+			ap->channel);
+		return false;
+	}
+
+	supported = wiphy_get_supported_freqs(wiphy);
+	disabled = wiphy_get_disabled_freqs(wiphy);
+
+	if (!scan_freq_set_contains(supported, freq)) {
+		l_error("AP hardware does not support frequency %u", freq);
+		return false;
+	}
+
+	if (scan_freq_set_contains(disabled, freq)) {
+		l_error("AP hardware has frequency %u disabled", freq);
+		return false;
+	}
+
+	return true;
+}
+
 static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
 				bool *out_cck_rates)
 {
@@ -3214,17 +3251,31 @@ static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
 		unsigned int uintval;
 
 		if (!l_settings_get_uint(config, "General", "Channel",
-						&uintval) ||
-				!band_channel_to_freq(uintval,
-							BAND_FREQ_2_4_GHZ)) {
+						&uintval)) {
 			l_error("AP Channel value unsupported");
 			return -EINVAL;
 		}
 
 		ap->channel = uintval;
-	} else
+
+		/*
+		 * 6GHz is not supported so we can use only a channel number to
+		 * distinguish between 2.4 and 5GHz.
+		 */
+		if (ap->channel >= 36)
+			ap->band = BAND_FREQ_5_GHZ;
+		else
+			ap->band = BAND_FREQ_2_4_GHZ;
+	} else {
 		/* TODO: Start a Get Survey to decide the channel */
 		ap->channel = 6;
+		ap->band = BAND_FREQ_2_4_GHZ;
+	}
+
+	if (!ap_validate_band_channel(ap)) {
+		l_error("AP Band and Channel combination invalid");
+		return -EINVAL;
+	}
 
 	strval = l_settings_get_string(config, "WSC", "DeviceName");
 	if (strval) {
@@ -3290,7 +3341,13 @@ static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
 		l_strfreev(strvval);
 	}
 
-	if (l_settings_get_value(config, "General", "NoCCKRates")) {
+	/*
+	 * Since 5GHz won't ever support only CCK rates we can ignore this
+	 * setting on that band.
+	 */
+	if (ap->band & BAND_FREQ_5_GHZ)
+		*out_cck_rates = false;
+	else if (l_settings_get_value(config, "General", "NoCCKRates")) {
 		bool boolval;
 
 		if (!l_settings_get_bool(config, "General", "NoCCKRates",
@@ -4080,7 +4137,7 @@ static bool ap_dbus_property_get_freq(struct l_dbus *dbus,
 	if (!ap_if->ap || !ap_if->ap->started)
 		return false;
 
-	freq = band_channel_to_freq(ap_if->ap->channel, BAND_FREQ_2_4_GHZ);
+	freq = band_channel_to_freq(ap_if->ap->channel, ap_if->ap->band);
 
 	l_dbus_message_builder_append_basic(builder, 'u', &freq);
 
-- 
2.34.3

