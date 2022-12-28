Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7E86FAE
	for <iwd@lists.linux.dev>; Wed, 28 Dec 2022 21:44:09 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id e21so1924730pfl.1
        for <iwd@lists.linux.dev>; Wed, 28 Dec 2022 13:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wLY0QEhQiyaU9M4O3JHJWYbovNtuGKBFMM6Ms1PAwBY=;
        b=SK9TxtoeMAmRsQ35cT/l7YtPH62GCKcvBP6lSy1VBiNioB90BAoT3oHvDQQa0JLUrU
         OaHBIN1nb9yOkbBdtccQTKOB731AK5lrm1jjEWF6g9OvTuC76yZKtahlZ5KnEf4/ii8C
         XZw4WGTQesD2NdmeDkoqxYqH+tSaR2BJfX+lKlT4KVUhKgpR/TXT3nhhxmar0L6qn2Rt
         ff2g4bYVrtq58dqiWV2H/nc4jliaTjfbuvwf3Qfq0c3GuH1iTrb4iQBODLBbaNuksjBX
         rmpuKWfzNinDqdEywYIBu+kLCJ/H660dQhxd0xjNsqMOhD0NlLfupxsEmhKboIwFudiX
         yKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wLY0QEhQiyaU9M4O3JHJWYbovNtuGKBFMM6Ms1PAwBY=;
        b=78tpUrV1GKLzKnSCukuM/pCW2tFaZdZmdIwqRWtHOKU/qpdpNZYjmJlJZSMbi7demw
         W0fE0IEKmrruvFyszQJleprtffEUlmIPXMhspyCs08YZfTQTBiwIsmVqgDYF2JHyhZ1w
         m2L+T7lg6JkfGAdY6599Spb363UxwH3KhtcA/5ZYvibAgrya9yn4mOI9HzPGongcfcw5
         vAW+cLbwSSqP9GEwrnGmv71Gxcsxjh562nBgnBQFFxWIkvQfy+K/LOtQ0QZ7NhSu1/s9
         h6Zbl/vciDteCc4OVFmshw+o+j3Ecc/abpzGfdWQrFIIuFNl+4PObJ9I+Ui6cHF7xweD
         LyQw==
X-Gm-Message-State: AFqh2kqg1rTV64GSuYkPG2WRkYfEUrUJW6W1d9/L2XjHFXuzo/KjQdDu
	ai/r7NNG5mnaiB6rTxoWfBSRiDKy8qw=
X-Google-Smtp-Source: AMrXdXuoWJ9JPm/Ds85KEdYmL89E2IyDJVs8QgfbM7TNRQnk4dZfK2OuAhm9oPHI8UMjXl0/lwJj6w==
X-Received: by 2002:a05:6a00:1f06:b0:581:366b:ca63 with SMTP id be6-20020a056a001f0600b00581366bca63mr9558349pfb.34.1672263848300;
        Wed, 28 Dec 2022 13:44:08 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id o3-20020aa79783000000b0057726bd7335sm5360103pfp.121.2022.12.28.13.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 13:44:07 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/4] band: generate HT chandef from frequency
Date: Wed, 28 Dec 2022 13:44:00 -0800
Message-Id: <20221228214403.2682418-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For AP mode its convenient for IWD to choose an appropriate
channel definition rather than require the user provide very
low level parameters such as channel width, center1 frequency
etc. For now only HT is supported as VHT/HE etc. require
additional secondary channel frequencies.

The HT API tries to find an operating class using 40Mhz which
complies with any hardware restrictions. If an operating class is
found that is supported/not restricted it is marked as 'best' until
a better one is found. In this case 'better' is a larger channel
width. Since this is HT only 20mhz and 40mhz widths are checked.
---
 src/band.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/band.h |  2 ++
 2 files changed, 89 insertions(+)

v2:
 * Removed the non-HT API entirely since the caller can set the
   chandef directly after validating the frequency

diff --git a/src/band.c b/src/band.c
index 53ce9495..c89762a9 100644
--- a/src/band.c
+++ b/src/band.c
@@ -1194,6 +1194,93 @@ int oci_from_chandef(const struct band_chandef *own, uint8_t oci[static 3])
 	return -ENOENT;
 }
 
+/* Find an HT chandef for the frequency */
+int band_freq_to_ht_chandef(uint32_t freq, const struct band_freq_attrs *attr,
+				struct band_chandef *chandef)
+{
+	enum band_freq band;
+	enum band_chandef_width width;
+	unsigned int i;
+	const struct operating_class_info *best = NULL;
+
+	if (attr->disabled || !attr->supported)
+		return -EINVAL;
+
+	if (!band_freq_to_channel(freq, &band))
+		return -EINVAL;
+
+	for (i = 0; i < L_ARRAY_SIZE(e4_operating_classes); i++) {
+		const struct operating_class_info *info =
+						&e4_operating_classes[i];
+		enum band_chandef_width w;
+
+		if (e4_has_frequency(info, freq) < 0)
+			continue;
+
+		/* Any restrictions for this channel width? */
+		switch (info->channel_spacing) {
+		case 20:
+			w = BAND_CHANDEF_WIDTH_20;
+			break;
+		case 40:
+			w = BAND_CHANDEF_WIDTH_40;
+
+			/* 6GHz remove the upper/lower 40mhz channel concept */
+			if (band == BAND_FREQ_6_GHZ)
+				break;
+
+			if (info->flags & PRIMARY_CHANNEL_UPPER &&
+						attr->no_ht40_plus)
+				continue;
+
+			if (info->flags & PRIMARY_CHANNEL_LOWER &&
+						attr->no_ht40_minus)
+				continue;
+
+			break;
+		default:
+			continue;
+		}
+
+		if (!best || best->channel_spacing < info->channel_spacing) {
+			best = info;
+			width = w;
+		}
+	}
+
+	if (!best)
+		return -ENOENT;
+
+	chandef->frequency = freq;
+	chandef->channel_width = width;
+
+	/*
+	 * Choose a secondary channel frequency:
+	 * - 20mhz no secondary
+	 * - 40mhz we can base the selection off the channel flags, either
+	 *   higher or lower.
+	 */
+	switch (width) {
+	case BAND_CHANDEF_WIDTH_20:
+		return 0;
+	case BAND_CHANDEF_WIDTH_40:
+		if (band == BAND_FREQ_6_GHZ)
+			return 0;
+
+		if (best->flags & PRIMARY_CHANNEL_UPPER)
+			chandef->center1_frequency = freq - 10;
+		else
+			chandef->center1_frequency = freq + 10;
+
+		return 0;
+	default:
+		/* Should never happen */
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 uint8_t band_freq_to_channel(uint32_t freq, enum band_freq *out_band)
 {
 	uint32_t channel = 0;
diff --git a/src/band.h b/src/band.h
index 0ae5f8c0..676c63d9 100644
--- a/src/band.h
+++ b/src/band.h
@@ -101,6 +101,8 @@ int band_estimate_nonht_rate(const struct band *band,
 				const uint8_t *supported_rates,
 				const uint8_t *ext_supported_rates,
 				int32_t rssi, uint64_t *out_data_rate);
+int band_freq_to_ht_chandef(uint32_t freq, const struct band_freq_attrs *attr,
+				struct band_chandef *chandef);
 
 int oci_to_frequency(uint32_t operating_class, uint32_t channel);
 
-- 
2.34.3

