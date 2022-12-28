Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF106FB7
	for <iwd@lists.linux.dev>; Wed, 28 Dec 2022 21:44:11 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id c7so11484195pfc.12
        for <iwd@lists.linux.dev>; Wed, 28 Dec 2022 13:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BGpUUu+4c3LBvlr12j3kYbGqJDg/UOZqtxxkjUD5wQ=;
        b=byjVYBRIbGHCZWdjRgbVIswDsHjU4rwzda9YFuZICIqIu/sFWv6IdfZe2BnMkgzxdo
         PY5S4k9G1P4qfEvQZOwuALiGB0FhIzV1yc0b74+prTjyxPA5CNboP9AGwDl2i4ab4ATV
         2mmCtU5PMct6JKcLmBOB/Nbxgd7OJaUgCkhycDWcA62Z20kLNIGloUw8tsJGVmhRgM/d
         rPjE3cNULopMsYqmWbZ4S98UAXKKl7H7FO+Y8G/ZNEBR1jdb5QC4ScEbds5rMJr49PgM
         HWspsQeFitm8jEIif1WX/YxPfzpRDXEv1flmFyZqFXSuajhSUJoDDUTqWMOnKLBqPM6h
         UPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BGpUUu+4c3LBvlr12j3kYbGqJDg/UOZqtxxkjUD5wQ=;
        b=I5oDlrng+yrtoOn49oYLj4p/esSnjZmT4KSUFdwgb7l/eJAijk3Wn1n5TKUIW3rLmS
         DwjSSQ1sfRUw7aVt1D8AgUtBR/lW0FqerZ/ozJ11LHb3v6diHIZttKd4jl/fXT4bpnVJ
         ZEXcZSEGGqsrp4M1Sw00k7mkHUXreWtD2M6LFZl90LIpDw0uSnU7e3Eq0w1h4vJ3Qikk
         Nv1gVrIbWUgUNrB83yL1cP1GInt5JM2/IFZp3B54RMAxFFfjcd+hhgOLwQ8Z7v0gxAjh
         SClMOlc8HnDL7LFeOOLeMCcv6+sdNmttI5zFB0uGgw+KSSbiHzyqki2ozYWYNvOokCtZ
         QeKQ==
X-Gm-Message-State: AFqh2krsYuJ0I/n4hahfRQuTqQARVJrt4EhdtkLmI4izkoVXbWQKZbMf
	yG0yEqwkp11oQFHdbdcTkzwz11OVkas=
X-Google-Smtp-Source: AMrXdXtbzpW8kCkUKwJnmisGV7QCAM3c0JcHKfqHEMNjKuYS+I140YfU15OvnKvNVCW1OT0EKhiv8A==
X-Received: by 2002:a05:6a00:430d:b0:580:cb88:d19 with SMTP id cb13-20020a056a00430d00b00580cb880d19mr18549303pfb.31.1672263850645;
        Wed, 28 Dec 2022 13:44:10 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id o3-20020aa79783000000b0057726bd7335sm5360103pfp.121.2022.12.28.13.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 13:44:10 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/4] ap: generate chandef for starting AP
Date: Wed, 28 Dec 2022 13:44:03 -0800
Message-Id: <20221228214403.2682418-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221228214403.2682418-1-prestwoj@gmail.com>
References: <20221228214403.2682418-1-prestwoj@gmail.com>
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

v2:
 * Create chandef manually for non-HT since its very simple
 * Fall back to non-HT in the unlikely event the HT chandef
   fails to be created

diff --git a/src/ap.c b/src/ap.c
index d9a81651..a989c454 100644
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
@@ -2567,8 +2568,6 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struct ap_state *ap)
 	uint32_t nl_akm = CRYPTO_AKM_PSK;
 	uint32_t wpa_version = NL80211_WPA_VERSION_2;
 	uint32_t auth_type = NL80211_AUTHTYPE_OPEN_SYSTEM;
-	uint32_t ch_freq = band_channel_to_freq(ap->channel, ap->band);
-	uint32_t ch_width = NL80211_CHAN_WIDTH_20;
 	unsigned int i;
 
 	static const uint8_t bcast_addr[6] = {
@@ -2616,8 +2615,13 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struct ap_state *ap)
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
@@ -3356,6 +3360,32 @@ static bool ap_validate_band_channel(struct ap_state *ap)
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

