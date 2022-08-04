Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BF66AAC
	for <iwd@lists.linux.dev>; Thu,  4 Aug 2022 22:02:53 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id b133so680968pfb.6
        for <iwd@lists.linux.dev>; Thu, 04 Aug 2022 15:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=LgfYiM82pqVKPoeFQ7deB7V4HpJJkCf1GoVxPhKOlTw=;
        b=bl4oufDuz8iKNnnXAVevHWtcPzXWYn9ASaxxO/loLHa1H6m1qI24n2bw7/ImOQjyGI
         5uEuHf/Q3hBG+TtvBPJabGidaQ84gXV8igaBGP9sYbNvkiN4GwH8//zjFuMLrsyAlPX/
         3tkpmKj6E/bwe3Y0vq/Y2L3F4ZgyXMgqoIkYdC1ASPj5Q+uo39MsPKxk6tsOA987pMsC
         nfPQoz7qhxCt8aoDR9iH8cOymtLSthyy/MOSX6VpH9XLvxmBC9wunmZFdiMnrTwu1+of
         AgTL+SFx5uwlUZ2FvcB0QLobqU5K7dp6Z+2zy1j4iIdUaS1IAVFksmnKvFLkmbfw4q2O
         9UsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=LgfYiM82pqVKPoeFQ7deB7V4HpJJkCf1GoVxPhKOlTw=;
        b=By0YyTlqVDJAGaqF0bISninD45+NtLUWthZ9Pyr4EZviinr0/wgIDklel0WKWZsYMa
         rQme1CbEWQtU4BKaGMhsBt94eaAdzrs7/nqWxImEJKMkS56LojmPVK+vUZ1ROfrnkGrw
         KXYQ557HMrzZ7yZhAelsZxe4v6dhlqCiaMSuPBngZlmkyMxw0Eag1vu9CbhL/OGcp+nK
         xz5F2TXKzvBvjIRUgI1khaxUKz3gRDlwlPxUHXBUNmMpmBXE8q9ntqW5iYz9A2JboZ5K
         YKP4/kcZ4J9UpE//Xdqs+pM9HoT6/atVfg3n7dYBJSZObXCdFtXJfc33ledojVdV4mcY
         PdKQ==
X-Gm-Message-State: ACgBeo3VVDeWDeF7t42yRHgyrjS1F2SXGdVfERcKdHupcSBp8YAdTENu
	+5URlhgvlbqZ1Fq2D1eqsS/0Z5Mnbgg=
X-Google-Smtp-Source: AA6agR686b0D3k70+B1rONKaX3HoQNm9LDd37iJWto3lsvIIi5u/G6ZSeSogpPtOjSO2gyMk6XE9NQ==
X-Received: by 2002:a63:5364:0:b0:41a:529b:c1af with SMTP id t36-20020a635364000000b0041a529bc1afmr3299128pgl.98.1659650572320;
        Thu, 04 Aug 2022 15:02:52 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902ebc300b0016dbdf7b97bsm1376886plg.266.2022.08.04.15.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 15:02:52 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 2/3] scan: split full scans by band to enable 6GHz
Date: Thu,  4 Aug 2022 15:02:48 -0700
Message-Id: <20220804220249.508207-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220804220249.508207-1-prestwoj@gmail.com>
References: <20220804220249.508207-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel's regulatory domain updates after some number of beacons
are processed. This triggers a regulatory domain update (and wiphy
dump) but only after a scan request. This means a full scan started
prior to the regdom being set will not include any 6Ghz BSS's even
if the regdom was unlocked during the scan.

This can be worked around by splitting up a large scan request into
multiple requests allowing one of the first commands to trigger a
regdom update. Once the regdom updates (and wiphy dumps) we are
hopefully still scanning and could append an additional request to
scan 6GHz.
---
 src/scan.c | 85 ++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 76 insertions(+), 9 deletions(-)

v4:
 * Use scan_freq_set_copy_bands

diff --git a/src/scan.c b/src/scan.c
index b666ba2e..12c970a7 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -94,6 +94,8 @@ struct scan_request {
 	 */
 	bool triggered : 1;
 	bool in_callback : 1; /* Scan request complete, re-entrancy guard */
+	/* The request was split anticipating 6GHz will become available */
+	bool split : 1;
 	struct l_queue *cmds;
 	/* The time the current scan was started. Reported in TRIGGER_SCAN */
 	uint64_t start_time_tsf;
@@ -352,9 +354,24 @@ static bool scan_mac_address_randomization_is_disabled(void)
 	return disabled;
 }
 
+static struct scan_freq_set *scan_get_allowed_freqs(struct scan_context *sc)
+{
+	struct scan_freq_set *allowed = scan_freq_set_new();
+
+	scan_freq_set_merge(allowed, wiphy_get_supported_freqs(sc->wiphy));
+
+	if (!wiphy_constrain_freq_set(sc->wiphy, allowed)) {
+		scan_freq_set_free(allowed);
+		allowed = NULL;
+	}
+
+	return allowed;
+}
+
 static struct l_genl_msg *scan_build_cmd(struct scan_context *sc,
 					bool ignore_flush_flag, bool is_passive,
-					const struct scan_parameters *params)
+					const struct scan_parameters *params,
+					const struct scan_freq_set *freqs)
 {
 	struct l_genl_msg *msg;
 	uint32_t flags = 0;
@@ -366,8 +383,8 @@ static struct l_genl_msg *scan_build_cmd(struct scan_context *sc,
 	if (wiphy_get_max_scan_ie_len(sc->wiphy))
 		scan_build_attr_ie(msg, sc, params);
 
-	if (params->freqs)
-		scan_build_attr_scan_frequencies(msg, params->freqs);
+	if (freqs)
+		scan_build_attr_scan_frequencies(msg, freqs);
 
 	if (params->flush && !ignore_flush_flag && wiphy_has_feature(sc->wiphy,
 						NL80211_FEATURE_SCAN_FLUSH))
@@ -524,16 +541,18 @@ static bool scan_cmds_add_hidden(const struct network_info *network,
 		 * of all scans in the batch after the last scan is finished.
 		 */
 		*data->cmd = scan_build_cmd(data->sc, true, false,
-								data->params);
+							data->params,
+							data->params->freqs);
 		l_genl_msg_enter_nested(*data->cmd, NL80211_ATTR_SCAN_SSIDS);
 	}
 
 	return true;
 }
 
-static void scan_cmds_add(struct l_queue *cmds, struct scan_context *sc,
+static void scan_build_next_cmd(struct l_queue *cmds, struct scan_context *sc,
 				bool passive,
-				const struct scan_parameters *params)
+				const struct scan_parameters *params,
+				const struct scan_freq_set *freqs)
 {
 	struct l_genl_msg *cmd;
 	struct scan_cmds_add_data data = {
@@ -544,7 +563,7 @@ static void scan_cmds_add(struct l_queue *cmds, struct scan_context *sc,
 		wiphy_get_max_num_ssids_per_scan(sc->wiphy),
 	};
 
-	cmd = scan_build_cmd(sc, false, passive, params);
+	cmd = scan_build_cmd(sc, false, passive, params, freqs);
 
 	if (passive) {
 		/* passive scan */
@@ -572,6 +591,54 @@ static void scan_cmds_add(struct l_queue *cmds, struct scan_context *sc,
 	l_queue_push_tail(cmds, cmd);
 }
 
+static void scan_cmds_add(struct scan_request *sr, struct scan_context *sc,
+				bool passive,
+				const struct scan_parameters *params)
+{
+	unsigned int i;
+	struct scan_freq_set *subsets[2] = { 0 };
+	struct scan_freq_set *allowed = scan_get_allowed_freqs(sc);
+	const struct scan_freq_set *supported =
+					wiphy_get_supported_freqs(sc->wiphy);
+
+	/*
+	 * If 6GHz is not possible, or already allowed, or the frequencies are
+	 * explicit don't break up the request.
+	 */
+	if (!(scan_freq_set_get_bands(supported) & BAND_FREQ_6_GHZ) ||
+			(scan_freq_set_get_bands(allowed) & BAND_FREQ_6_GHZ) ||
+			params->freqs) {
+		scan_freq_set_free(allowed);
+		scan_build_next_cmd(sr->cmds, sc, passive, params, params->freqs);
+		return;
+	}
+
+	/*
+	 * Otherwise a full spectrum scan will likely open up the 6GHz
+	 * band. The problem is the regdom update occurs after an
+	 * individual scan request so a single request isn't going to
+	 * include potential 6GHz results.
+	 *
+	 * Instead we can break this full scan up into individual bands
+	 * and increase our chances of the regdom updating after one of
+	 * the earlier requests. If it does update to allow 6GHz an
+	 * extra 6GHz-only passive scan can be appended to this request
+	 * at that time.
+	 */
+	subsets[0] = scan_freq_set_copy_bands(allowed, BAND_FREQ_2_4_GHZ);
+	subsets[1] = scan_freq_set_copy_bands(allowed, BAND_FREQ_5_GHZ);
+
+	scan_freq_set_free(allowed);
+
+	for(i = 0; i < L_ARRAY_SIZE(subsets); i++) {
+		scan_build_next_cmd(sr->cmds, sc, passive, params,
+					subsets[i]);
+		scan_freq_set_free(subsets[i]);
+	}
+
+	sr->split = true;
+}
+
 static int scan_request_send_trigger(struct scan_context *sc,
 					struct scan_request *sr)
 {
@@ -649,7 +716,7 @@ static uint32_t scan_common(uint64_t wdev_id, bool passive,
 
 	sr = scan_request_new(sc, passive, trigger, notify, userdata, destroy);
 
-	scan_cmds_add(sr->cmds, sc, passive, params);
+	scan_cmds_add(sr, sc, passive, params);
 
 	/*
 	 * sr->work isn't initialized yet, it will be done by
@@ -743,7 +810,7 @@ static void add_owe_scan_cmd(struct scan_context *sc, struct scan_request *sr,
 	params.ssid_len = bss->owe_trans->ssid_len;
 	params.flush = true;
 
-	cmd = scan_build_cmd(sc, ignore_flush, false, &params);
+	cmd = scan_build_cmd(sc, ignore_flush, false, &params, params.freqs);
 
 	l_genl_msg_enter_nested(cmd, NL80211_ATTR_SCAN_SSIDS);
 	l_genl_msg_append_attr(cmd, 0, params.ssid_len, params.ssid);
-- 
2.34.3

