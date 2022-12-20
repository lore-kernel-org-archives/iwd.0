Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42F47E
	for <iwd@lists.linux.dev>; Tue, 20 Dec 2022 21:43:30 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id v23so8533686pju.3
        for <iwd@lists.linux.dev>; Tue, 20 Dec 2022 13:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoVxVSpVDriyDQNpHxubOB+S8bbM87MXS3mHz5U3W5A=;
        b=BRKQBmG+52oeYQ5NLk0JK7cO5ha0VM5zKVk5t/5ujphpRUcB/SeOdmJnWqIhHschno
         IdvL3Ch4K7j/ESIMZ1Bw+g1e1SdPE+69u2oqBz/y05r3qwnGCj8CobFs+8LCOWXgbEJ3
         XcyD9axbpUsZ4/q52EpEIUxr55SJAgP6duTh/O7kFfFNGMnrB6caYSgbgobZlJw8E3GI
         bIwtm641LFkiYevVYLAVG6MDPwfnoEoRSSjgw6hBs2f0u088xyL0876R+F1m2G6rapjO
         vLZN636yatrL+UUm/xDigUctuzrQ+wzJbb7MNnbA+2aguAdOUuBpj9EWkKMeESp85omV
         2p8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AoVxVSpVDriyDQNpHxubOB+S8bbM87MXS3mHz5U3W5A=;
        b=vppchtc9fbH7MlfkACue9BYiqyR/MrKeKtfy8g4769dw+muPIKZ/XAJi8HYPpxJ4q4
         XHJFo6Ue4RvrtC7kZlbTBCkx+ZcAk34MZ5+XrLxo5SOb/hop7nEtxdtLBtvifGr8KHd4
         HAe+IZaUhlw/pr5mvx0cfOUuz9vFZlNQIbQ0UAtefdfYMLcydhY006BcLAKIY5H2cSjM
         4Z/3awbDl8Z/pFzv1qhvFDp9A2nrjS3ezvjWjfWBsedo/y0GFscpAqHBilqNGKveypKZ
         XQvIsB8y83oSe/qR4R6foxQ1TWDno2fYMgXOf0joL7EskAMhwOg75iy0YmICnMF7tj/J
         b1Hg==
X-Gm-Message-State: AFqh2kpc9/bbdPj/6X+e3hqiAA73oHTZ34z+VK1lPFZ3ifoCi8LoaXO6
	aPSDlmO5ZwXiKNSLqSvSAdr/oj5Rhnk=
X-Google-Smtp-Source: AMrXdXveYKiXAE5tYFae6TCOc9QqHZ6XfZAMMyTznCVNhD1eXqzvzUxa9dUqjObc+tuB7645RI+RGQ==
X-Received: by 2002:a17:90b:124b:b0:220:7147:c981 with SMTP id gx11-20020a17090b124b00b002207147c981mr14547388pjb.29.1671572610202;
        Tue, 20 Dec 2022 13:43:30 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id e88-20020a17090a6fe100b00219cf5c3829sm8153301pjk.57.2022.12.20.13.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 13:43:29 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 10/10] ap: generate chandef for starting AP
Date: Tue, 20 Dec 2022 13:43:18 -0800
Message-Id: <20221220214318.2041986-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221220214318.2041986-1-prestwoj@gmail.com>
References: <20221220214318.2041986-1-prestwoj@gmail.com>
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
---
 src/ap.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 58fb4a6b..2d859538 100644
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
@@ -2556,8 +2557,6 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struct ap_state *ap)
 	uint32_t nl_akm = CRYPTO_AKM_PSK;
 	uint32_t wpa_version = NL80211_WPA_VERSION_2;
 	uint32_t auth_type = NL80211_AUTHTYPE_OPEN_SYSTEM;
-	uint32_t ch_freq = band_channel_to_freq(ap->channel, ap->band);
-	uint32_t ch_width = NL80211_CHAN_WIDTH_20;
 	unsigned int i;
 
 	static const uint8_t bcast_addr[6] = {
@@ -2605,8 +2604,13 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struct ap_state *ap)
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
@@ -3326,6 +3330,7 @@ static bool ap_validate_band_channel(struct ap_state *ap)
 	struct wiphy *wiphy = netdev_get_wiphy(ap->netdev);
 	uint32_t freq;
 	const struct band_freq_attrs *attr;
+	int ret;
 
 	if (!(wiphy_get_supported_bands(wiphy) & ap->band)) {
 		l_error("AP hardware does not support band");
@@ -3345,6 +3350,22 @@ static bool ap_validate_band_channel(struct ap_state *ap)
 		l_error("AP frequency %u disabled or unsupported", freq);
 		return false;
 	}
+
+	if (!ap->supports_ht)
+		ret = band_freq_to_chandef(freq, attr, &ap->chandef);
+	else
+		ret = band_freq_to_ht_chandef(freq, attr, &ap->chandef);
+
+	if (ret < 0) {
+		l_error("AP unable to find chandef for freq %u", freq);
+		return false;
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

