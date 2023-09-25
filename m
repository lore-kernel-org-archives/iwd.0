Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C6B1C29A
	for <iwd@lists.linux.dev>; Mon, 25 Sep 2023 18:54:46 +0000 (UTC)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59f7cc71e2eso31628907b3.0
        for <iwd@lists.linux.dev>; Mon, 25 Sep 2023 11:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695668085; x=1696272885; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCnx4kc9nA54IsbuiKqcciAI0MXgs/shVFtiXk52sx4=;
        b=j7agyiZxhOAj/73bSB2ZY1uS0oU4o19zpeqpu1kqz/M+/Vh97/MLMpzP3kRMSklXfB
         LG55fKOjZlIj2Z2u04kZ+60A2VIN7/hE4qvGZ5hZmh/AzRehU6+1ItKmgZHPY5ecepys
         efpR5/LYC6UDgRGxj1Vgmg+KRchAGn+ANW8nyUWZjGht6OsQBNGOLLlhhQysyDnHkrno
         1JjiPeVf75fnW0E65rIqdWecL/eJ3qkf0sc6dw39LTxBf9a4dk4Qk2kvUD7ZWyc2pM3K
         P3Iax9ZogPqScMk+BdEpwGd4t4u6czmtihF+6w+1UbGeajEZo+RNBLPh8EDZTNjtH4tp
         YNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695668085; x=1696272885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCnx4kc9nA54IsbuiKqcciAI0MXgs/shVFtiXk52sx4=;
        b=TnWRqaf7cHMdKOsT6fp652rCgQSoSCnOVNEWRiyA1y8x7DxXegcmFXfHvAOWeaaZXF
         909DSW9pcgLkTYJWXySIKN6hRwyXiDvl5GU2KlxOjcMp7ikEFGV7NoAwiwsz9A0Pj/5c
         s4wxbHtuXPYm0ZHMS6IRC3ei4DUEtlIdXZu95wkjqfaRpcqs9MDZ7wlURm5BFogtToMv
         7LIvBBUo6A+F1/LnRc2yUoKRMuMKai1NZRd/o6dl24mG6/wFcGZQFUMui6X4uSOzc5R9
         Fta4Kso3GkXX68FwSziksVAqS/bZ3QsSl00qQ+DnFrA7OcpQI/rsM4N4jN8GY3+iXrMf
         WS3Q==
X-Gm-Message-State: AOJu0YwZOtY/msmFXVVXYbFjGiBsxNOER/ZLI7bm3y5GyQm1e70onrT2
	tT/zWot5mUeSEsPHVQsqEJB4LPViMMI=
X-Google-Smtp-Source: AGHT+IHu6i7acTpw5I0y4FxwRoP/wrSeIm6W8szuj4Mn6d9pCKFwqN/Qh/VoF77NhYy4l89ohq9SSA==
X-Received: by 2002:a05:690c:2a0b:b0:59f:4c52:2f51 with SMTP id ei11-20020a05690c2a0b00b0059f4c522f51mr7737494ywb.17.1695668085576;
        Mon, 25 Sep 2023 11:54:45 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id v134-20020a81488c000000b00570253fc3e5sm2518920ywa.105.2023.09.25.11.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:54:45 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/8] scan: filter user-disabled bands for periodic scans.
Date: Mon, 25 Sep 2023 11:54:20 -0700
Message-Id: <20230925185422.2242494-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230925185422.2242494-1-prestwoj@gmail.com>
References: <20230925185422.2242494-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support user-disabled bands periodic scans need to specify a
frequency list filtered by any bands that are disabled. This was
needed in scan.c since periodic scans don't provide a frequency
list in the scan request.

If no bands are disabled the allowed freqs API should still
result in the same scan behavior as if a frequency list is left
out i.e. IWD just filters the frequencies as opposed to the kernel.
---
 src/scan.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index 9b1cc30a..84cf0f38 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -990,9 +990,53 @@ static void scan_periodic_destroy(void *user_data)
 	sc->sp.id = 0;
 }
 
+static struct scan_freq_set *scan_periodic_get_freqs(struct scan_context *sc)
+{
+	struct scan_freq_set *allowed;
+	struct scan_freq_set *band_6g;
+	const struct scan_freq_set *supported =
+					wiphy_get_supported_freqs(sc->wiphy);
+	uint32_t band_mask = 0;
+
+	if (RANK_2G_FACTOR)
+		band_mask |= BAND_FREQ_2_4_GHZ;
+	if (RANK_5G_FACTOR)
+		band_mask |= BAND_FREQ_5_GHZ;
+
+	allowed = wiphy_get_allowed_freqs(sc->wiphy, band_mask);
+	if (!RANK_6G_FACTOR)
+		return allowed;
+
+	/* 2.4 and 5Ghz are disabled, this is not a workable configuration */
+	if (!allowed)
+		return NULL;
+
+	/*
+	 * 6GHz is special because initially its disabled until the regdom is
+	 * established so (unless user disabled) we should always include those
+	 * frequencies for periodic scans.
+	 */
+	band_6g = scan_freq_set_clone(supported, BAND_FREQ_6_GHZ);
+	scan_freq_set_merge(allowed, band_6g);
+	scan_freq_set_free(band_6g);
+
+	return allowed;
+}
+
 static bool scan_periodic_queue(struct scan_context *sc)
 {
 	struct scan_parameters params = {};
+	struct scan_freq_set *freqs = scan_periodic_get_freqs(sc);
+
+	/*
+	 * If this happens its due to the user disabling all bands. This will
+	 * cause IWD to never issue another periodic scan so warn the user of
+	 * this.
+	 */
+	if (L_WARN_ON(!freqs))
+		return false;
+
+	params.freqs = freqs;
 
 	if (sc->sp.needs_active_scan && known_networks_has_hidden()) {
 		params.randomize_mac_addr_hint = true;
@@ -1010,6 +1054,8 @@ static bool scan_periodic_queue(struct scan_context *sc)
 					scan_periodic_notify, sc,
 					scan_periodic_destroy);
 
+	scan_freq_set_free(freqs);
+
 	return sc->sp.id != 0;
 }
 
-- 
2.25.1

