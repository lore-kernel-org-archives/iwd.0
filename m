Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868E863DB
	for <iwd@lists.linux.dev>; Fri,  9 Dec 2022 18:23:53 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id d7so5722395pll.9
        for <iwd@lists.linux.dev>; Fri, 09 Dec 2022 10:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJE45BuRWMwDZ94EP8rqad4sHF/ci/oKjbJW/z5Fg78=;
        b=Sjk6hOzH5ackMn3L+rUglhuKz5jKS9/B+9hHlS5VKIP84fH3YTvgtaAvr4nkw+A/YZ
         VlZbP8sU1tRUcycP83vmw649Vtp/9e+oSuwqw+F/VaBK40egLdqnK4LuJbIEyADAXfMb
         cxmViyE9GwCvUYLmwfw6r7KmNpUiztdEw76LThKqaecT9qNdIFZon/1gFXSEDaNd19Dy
         4Hm6dGlVC4+GV7o29JEeq9Kq6JcsFU/pSgvuyQd4bm9Gql9DJ9CrYKw2XlNz6WQMKyYg
         MBPXc85A+392wyioySW+pnn3NRwBIe8yHc7EFQbbeK2aaXJFoOycnz6szt7Gi5Ih5XST
         d/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJE45BuRWMwDZ94EP8rqad4sHF/ci/oKjbJW/z5Fg78=;
        b=jOZ30fYPOtjpHjBZOQ4tEfDzkIxjh56KZ8n/jlma7NGcWCpjnkyQMTE9l7YFNyyCT2
         Y9SBzMT1F8zbFjOfxXe6Q0CFBzJv6iPtNcaE1klS3ZhW8QQGSZPWakqLDThb7IKp/h5t
         jY91XdinrLbHA27Md8BurS6weF6ZFZLSZUYph6d9pdZ/q+q5eNKErJ/ooNQxmMA5bGBC
         HhhMuESQpioVcHXh7C5YD/Dyxcpta3FYzK1S9/JV4DUkK6x4oAw81gQuapxMxEyTB6LX
         1dLsR7psUmi47RTz4b80ig51BLWfw8eI74uLQRk736eN339698nvrvhdDAf/3avJ1K7+
         39PA==
X-Gm-Message-State: ANoB5pn07XqUZ6rnncjSkLyDvyJrJHK56QXQj7BufXxvzbmWb6NiWsrM
	pSwJf/I7Gk2WDO3M8O+4wC+VMWu1C2s=
X-Google-Smtp-Source: AA0mqf6kYSxX+blHkO9NKqMfJtkUn3udRkfqguy283tVcsI8vyR+g6KpWJCSAFqq2Da4dZj9Qs680A==
X-Received: by 2002:a17:903:1302:b0:189:7e2f:d64c with SMTP id iy2-20020a170903130200b001897e2fd64cmr6377956plb.55.1670610232870;
        Fri, 09 Dec 2022 10:23:52 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b001897de9bae3sm1635790plb.204.2022.12.09.10.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 10:23:52 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/4] ap: add support for 5GHz frequencies in AP mode
Date: Fri,  9 Dec 2022 10:23:45 -0800
Message-Id: <20221209182347.838602-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221209182347.838602-1-prestwoj@gmail.com>
References: <20221209182347.838602-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This enables IWD to use 5GHz frequencies in AP mode. Only profile
based AP's can use this feature since additional information is
needed. A new profile key [General].Band was added which is optional
and expects a string, either "2.4GHz" or "5GHz". The existing
Channel key can then be used to specify any 5GHz channel.

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

