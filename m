Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102154C76
	for <iwd@lists.linux.dev>; Wed,  3 Aug 2022 21:36:53 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so3549013pjl.0
        for <iwd@lists.linux.dev>; Wed, 03 Aug 2022 14:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=X11Al+otvb1mqCp6xZM1E1PKL9zxEt5ibnsXp3lZgns=;
        b=J6ZWNGOMFkMcTDnKpWJNL122rScg7bjgvf3r6wjcy8oOjW1YiNq/+94SPlnd733j1J
         nF799bpI750NYkKghILrlxHZD5d/OGnZW4NRviMC7GwNAbuincewuQhgpyGWb9Abv7Is
         Jv36hajjupJZgEDfF+tdAkwfN3cckpraSuBW5V5toi8nCnGN4ah/UE2A/ivWal956gU6
         3h3Sg8Nawm29WI0tAj0lNjPHSndWYSB5nKOAzkq2QridQ7rMoCWbhaMW7XZZUU9sGtCz
         lSKUq2v72K5EL7yqXVwv1q2pXJB+50e+OKugtYI0urH2MAgIhTZ46bO0cv/zudq9RiOC
         YoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=X11Al+otvb1mqCp6xZM1E1PKL9zxEt5ibnsXp3lZgns=;
        b=IkTbmKopFNlVhGahYSeuph8Lcp7NG5n1B5zum1K8OI+iL2iXnTK1yX0UJoe6PhbrtR
         NzLNlGSxw1OveoL26dvAuAyaqLzx2TKDz/mx4tFYmXfLgzf98Dya1BH9LPxA+HjwM//O
         wayP5luQzIkXKxFUfao6am2hno9gbA5TfrHDXdsYgmJz3c5ys9WBut4Hat6azD8TAXED
         H2jBqR16jbY3+RUNkQMR3OpGq81qY/h4Nqb/4toz1Tu8WcP8Qu6paUbcNz3SZ4/rqyql
         aUwZv4KYgGc2UWcAEfnnHu7NTfNxj48bekHDLV4nejdDpJ1TRODiPnE1yq9E5D0tZmTr
         +0Fw==
X-Gm-Message-State: ACgBeo1bOsyIlVYbPVRiApn/L/zTYFSJjOYiKVRKfefumfPkW3hIHEMS
	BjFUI8//LEcLIiWhkA6noANawh1zjBg=
X-Google-Smtp-Source: AA6agR6s23qwJ5KMWBqwDaehBbDSyskXSKnMdr8GnCMxSf/uGiiJb3Cqr5LZs/Pt3DAUxGC2puRPoQ==
X-Received: by 2002:a17:90b:4f8d:b0:1f5:835:1b19 with SMTP id qe13-20020a17090b4f8d00b001f508351b19mr6793240pjb.63.1659562613167;
        Wed, 03 Aug 2022 14:36:53 -0700 (PDT)
Received: from jprestwo-xps.none ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id b13-20020a65578d000000b00419fc2c27d8sm11527066pgr.43.2022.08.03.14.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 14:36:52 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 11/13] scan: split full scans by band to enable 6GHz
Date: Wed,  3 Aug 2022 14:36:42 -0700
Message-Id: <20220803213644.277534-11-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220803213644.277534-1-prestwoj@gmail.com>
References: <20220803213644.277534-1-prestwoj@gmail.com>
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
 src/scan.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 89 insertions(+), 8 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index b666ba2e..e016bd4d 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -352,9 +352,24 @@ static bool scan_mac_address_randomization_is_disabled(void)
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
@@ -366,8 +381,8 @@ static struct l_genl_msg *scan_build_cmd(struct scan_context *sc,
 	if (wiphy_get_max_scan_ie_len(sc->wiphy))
 		scan_build_attr_ie(msg, sc, params);
 
-	if (params->freqs)
-		scan_build_attr_scan_frequencies(msg, params->freqs);
+	if (freqs)
+		scan_build_attr_scan_frequencies(msg, freqs);
 
 	if (params->flush && !ignore_flush_flag && wiphy_has_feature(sc->wiphy,
 						NL80211_FEATURE_SCAN_FLUSH))
@@ -524,16 +539,36 @@ static bool scan_cmds_add_hidden(const struct network_info *network,
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
+static void scan_foreach_freq_split_bands(uint32_t freq, void *user_data)
+{
+	struct scan_freq_set **subsets = user_data;
+	int idx;
+
+	if (freq < 3000)
+		idx = 0;
+	else if (freq < 6000)
+		idx = 1;
+	else
+		idx = 2;
+
+	if (!subsets[idx])
+		subsets[idx] = scan_freq_set_new();
+
+	scan_freq_set_add(subsets[idx], freq);
+}
+
+static void scan_build_next_cmd(struct l_queue *cmds, struct scan_context *sc,
 				bool passive,
-				const struct scan_parameters *params)
+				const struct scan_parameters *params,
+				const struct scan_freq_set *freqs)
 {
 	struct l_genl_msg *cmd;
 	struct scan_cmds_add_data data = {
@@ -544,7 +579,7 @@ static void scan_cmds_add(struct l_queue *cmds, struct scan_context *sc,
 		wiphy_get_max_num_ssids_per_scan(sc->wiphy),
 	};
 
-	cmd = scan_build_cmd(sc, false, passive, params);
+	cmd = scan_build_cmd(sc, false, passive, params, freqs);
 
 	if (passive) {
 		/* passive scan */
@@ -572,6 +607,52 @@ static void scan_cmds_add(struct l_queue *cmds, struct scan_context *sc,
 	l_queue_push_tail(cmds, cmd);
 }
 
+static void scan_cmds_add(struct l_queue *cmds, struct scan_context *sc,
+				bool passive,
+				const struct scan_parameters *params)
+{
+	unsigned int i;
+	struct scan_freq_set *subsets[3] = { 0 };
+	struct scan_freq_set *allowed;
+
+	/*
+	 * If the frequencies are explicit don't break up the request
+	 */
+	if (params->freqs) {
+		scan_build_next_cmd(cmds, sc, passive, params, params->freqs);
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
+
+	allowed = scan_get_allowed_freqs(sc);
+	if (L_WARN_ON(!allowed))
+		return;
+
+	scan_freq_set_foreach(allowed, scan_foreach_freq_split_bands, subsets);
+	scan_freq_set_free(allowed);
+
+	for(i = 0; i < L_ARRAY_SIZE(subsets); i++) {
+		if (!subsets[i])
+			continue;
+
+		scan_build_next_cmd(cmds, sc, passive, params,
+					subsets[i]);
+		scan_freq_set_free(subsets[i]);
+	}
+}
+
 static int scan_request_send_trigger(struct scan_context *sc,
 					struct scan_request *sr)
 {
@@ -743,7 +824,7 @@ static void add_owe_scan_cmd(struct scan_context *sc, struct scan_request *sr,
 	params.ssid_len = bss->owe_trans->ssid_len;
 	params.flush = true;
 
-	cmd = scan_build_cmd(sc, ignore_flush, false, &params);
+	cmd = scan_build_cmd(sc, ignore_flush, false, &params, params.freqs);
 
 	l_genl_msg_enter_nested(cmd, NL80211_ATTR_SCAN_SSIDS);
 	l_genl_msg_append_attr(cmd, 0, params.ssid_len, params.ssid);
-- 
2.34.3

