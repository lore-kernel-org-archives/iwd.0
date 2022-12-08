Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D1E2F36
	for <iwd@lists.linux.dev>; Thu,  8 Dec 2022 23:48:21 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id 142so2439688pga.1
        for <iwd@lists.linux.dev>; Thu, 08 Dec 2022 15:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuJ/j7yzCVtHI7ExfN8DgABz0kInSEgciLBQlbjZgTc=;
        b=XtPPVWl+vSSbR8czdY7SP0X3UgX7Vq5hrneLWTD1Lqsoit8uiQjB3WEWGdSUggQil0
         W5Typxjw4NuhqmWMgSxhXGGpAq6w74vB507DXK2YrbK1xTqgz2HgYkliXOIRmasdoqHv
         RP2AZzBXR6j+Rob/AxOpwzaPlxHZuh+C2M8JhIwOlygoKOIJM9GITnYVH7eA2Jj7Y5Ev
         ifIBEDymbaYJrpyeZlS/LyAoren71X+Z3feOCEJFaSTWfls5dZ4AAjmY0soye+a+TCKY
         I2S00HYJj2ZC9D2gRnmyhgYzIEL9k27SpU3Iai0066oLvolhkO8q0KRhRbDk/4WahLd8
         GCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuJ/j7yzCVtHI7ExfN8DgABz0kInSEgciLBQlbjZgTc=;
        b=sOZXE+QMIUZ2waV2ChY67CxMLNbkXETINLrmA3cnSXbnYPudlSaccIOT7B7P4oSX91
         4TUCzgHoUOSa/lycs7cBsDr4SBDV8Dqp16jnZcUrlFyjXA8vC6sqoALuOImK0/L+8V8W
         4uxwJoc8acUumZjtDkrDNaAkcgFNbc6g8RHZ3NSdthNcu744DUa/UR7pCeWSuFniNUbp
         nxFzV3rzB7xrK9LzrfXt0cDnOTgYVL0WkPpU182xeaRUYHLRKHSTcknAbz1APw2d63Pk
         um/p6RyhNeKfL+EMTIWGT7YDTRy55D3E7UnW/Q16zK1z3u+hLC1oF2ICJhqtUAobpcey
         kpAA==
X-Gm-Message-State: ANoB5pmf6gHfOkJUYutCK/9WR4yYq8QIIja3mLFCE/CY9laNDCKPrhQa
	w2Yp7njPANaTUGP1aIQNzEHhsVuMzh0=
X-Google-Smtp-Source: AA0mqf7VPk/CEz7P01NN49N38ex0zFO/0gGwnp6FasYQYYMHWOUlWFmWQKwYA4h9xL+0Lw8RCCC8bw==
X-Received: by 2002:a62:e812:0:b0:576:ddd4:6a02 with SMTP id c18-20020a62e812000000b00576ddd46a02mr4047766pfi.22.1670543300928;
        Thu, 08 Dec 2022 15:48:20 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id f67-20020a62db46000000b005767cb32fdasm41392pfg.188.2022.12.08.15.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 15:48:20 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/5] ap: add support for 5GHz frequencies in AP mode
Date: Thu,  8 Dec 2022 15:48:11 -0800
Message-Id: <20221208234812.778191-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221208234812.778191-1-prestwoj@gmail.com>
References: <20221208234812.778191-1-prestwoj@gmail.com>
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
 src/ap.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 83 insertions(+), 8 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 69412174..7608ab23 100644
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
 
@@ -3170,6 +3171,45 @@ static char **ap_ciphers_to_strv(uint16_t ciphers)
 	return list;
 }
 
+static bool ap_validate_band_channel(struct ap_state *ap)
+{
+	struct wiphy *wiphy = netdev_get_wiphy(ap->netdev);
+	const struct scan_freq_set *supported;
+	const struct scan_freq_set *disabled;
+	const struct scan_freq_set *no_ir;
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
+	no_ir = wiphy_get_no_ir_freqs(wiphy);
+
+	if (!scan_freq_set_contains(supported, freq)) {
+		l_error("AP hardware does not support frequency %u", freq);
+		return false;
+	}
+
+	if (scan_freq_set_contains(disabled, freq) ||
+			scan_freq_set_contains(no_ir, freq)) {
+		l_error("AP hardware has frequency %u disabled or no-IR", freq);
+		return false;
+	}
+
+	return true;
+}
+
 static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
 				bool *out_cck_rates)
 {
@@ -3210,13 +3250,26 @@ static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
 	if (err)
 		return err;
 
+	strval = l_settings_get_string(config, "General", "Band");
+	if (strval) {
+		if (!strcmp(strval, "2.4GHz"))
+			ap->band = BAND_FREQ_2_4_GHZ;
+		else if (!strcmp(strval, "5GHz"))
+			ap->band = BAND_FREQ_5_GHZ;
+		else {
+			l_error("AP Band value unsupported: %s", strval);
+			return -EINVAL;
+		}
+
+		l_free(l_steal_ptr(strval));
+	} else
+		ap->band = BAND_FREQ_2_4_GHZ;
+
 	if (l_settings_has_key(config, "General", "Channel")) {
 		unsigned int uintval;
 
 		if (!l_settings_get_uint(config, "General", "Channel",
-						&uintval) ||
-				!band_channel_to_freq(uintval,
-							BAND_FREQ_2_4_GHZ)) {
+						&uintval)) {
 			l_error("AP Channel value unsupported");
 			return -EINVAL;
 		}
@@ -3224,7 +3277,12 @@ static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
 		ap->channel = uintval;
 	} else
 		/* TODO: Start a Get Survey to decide the channel */
-		ap->channel = 6;
+		ap->channel = (ap->band & BAND_FREQ_2_4_GHZ) ? 6 : 36;
+
+	if (!ap_validate_band_channel(ap)) {
+		l_error("AP Band and Channel combination invalid");
+		return -EINVAL;
+	}
 
 	strval = l_settings_get_string(config, "WSC", "DeviceName");
 	if (strval) {
@@ -3300,9 +3358,26 @@ static int ap_load_config(struct ap_state *ap, const struct l_settings *config,
 			return -EINVAL;
 		}
 
+		/*
+		 * If CCK Rates are used with 5GHz the AP will start but any
+		 * linux-based (maybe others?) station will reject
+		 * authentications and log:
+		 *
+		 * "No legacy rates in association response"
+		 *
+		 * This isn't outlined in 802.11, and a proper fix is to use
+		 * the rates the hardware supports as noted by the TODO in
+		 * ap_start(). For now don't allow CCK rates with 5GHz.
+		 */
+		if (!boolval && (ap->band & BAND_FREQ_5_GHZ)) {
+			l_error("AP [General].NoCCKRates must be true for 5GHz "
+				" band");
+			return -EINVAL;
+		}
+
 		*out_cck_rates = !boolval;
 	} else
-		*out_cck_rates = true;
+		*out_cck_rates = (ap->band & BAND_FREQ_2_4_GHZ);
 
 	cipher_mask = wiphy_get_supported_ciphers(wiphy, IE_GROUP_CIPHERS);
 
@@ -4080,7 +4155,7 @@ static bool ap_dbus_property_get_freq(struct l_dbus *dbus,
 	if (!ap_if->ap || !ap_if->ap->started)
 		return false;
 
-	freq = band_channel_to_freq(ap_if->ap->channel, BAND_FREQ_2_4_GHZ);
+	freq = band_channel_to_freq(ap_if->ap->channel, ap_if->ap->band);
 
 	l_dbus_message_builder_append_basic(builder, 'u', &freq);
 
-- 
2.34.3

