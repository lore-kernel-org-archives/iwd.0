Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E79874416
	for <iwd@lists.linux.dev>; Wed, 15 May 2024 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715775750; cv=none; b=ut0L6d0AE+m+yiYShkB/sTWfuRHTwYi21DvhkxvGRFz3B5c8Y1rsNVwzpwt4lL4sIyLpgCGefFt8t5/oGl2W01iPIbPaLuWV81toCCXFeoRh9BoSaRzm3oW5moxRQC0ABY4/nDztyctSxBcXpoLK5DLzllt4Ijr14L+dLM6Rcds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715775750; c=relaxed/simple;
	bh=Zbnbe3Xv0O+FWlOOeBBgSWiiHgRx2ROp9PPhEslwxgA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nQWCgug/FiKD3A1/+XxxirWDTjao6JRP/78vX0zWu48DNWy5lYMpY6D/TEb48bFr1NcEXCv1lkQ+kJfC4TMmXvK21ieSMg22keCU8RRzFbEI9dPRI3uShx3iObVHRq4Ye7gKSqddWtQuTzyKeN1HndlTP1W/lFNX6oRvskicOU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEpvXJUg; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEpvXJUg"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-792c34f891eso569414285a.1
        for <iwd@lists.linux.dev>; Wed, 15 May 2024 05:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715775747; x=1716380547; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJ9cSCCjSZZTqPjshIpSrBvU31l14zNlm4J+f/AWweQ=;
        b=SEpvXJUg5KOxVPtkjIRTXBrMAPlkTvGlCA2zWUa15FgJA9Bc3bcJ0oG5UzzQ5chOnE
         o1bjpbsbwHQcACyd1DEVH7SSiZWCYd8I+SIcnFWWLDgCq8CnoYc5vFOWYvJmjiQtJ1tx
         NlUrnaFTh8bAlXprW17srVq9y2UpfzT4PhFt9crR/+enbVf0kYwOzILOzRYFwhQuLelv
         t8oTjrcioiWgBLW1dr0NHLv59ZwKB6ahXVJBelSEcddAng7NptXSkyr9beKOqw+RygLG
         58/teYspaXIvyii5GZ8jt/ESFNxUKkygJ8cwZElKcbA4MSFFuh86+tD0rW3DvqCF0f/r
         6OGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715775747; x=1716380547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJ9cSCCjSZZTqPjshIpSrBvU31l14zNlm4J+f/AWweQ=;
        b=izLCAGUTPWuIm11GetbK8uWcjAiiiHLa7rEGh5Q6dPtVJ13r18Xd0Kuv1rZAlYF6/3
         aUbKUlHXCXSrrLC6rln390589aCtMYU3aaRyhZc2u9GVQfv5jIEd2bANlyC+hu/qdnCe
         bd6MVuhTtZNZ9JKBOj9JGx/efQfcCXENCZvZK1gfKkWkdqLjapgGfbjy/5TYknIz83KS
         rjgxJNPFEipRgkz9AVV31S4ukOLoFN7BD31/lfg0ztZuu0SXCfV0wX0iSOyl0y0P/C6r
         VVIlNewLu9I2clA3GYzzjggM97iLJeHV7b/2TjlYMxOw9YXJ/qaIWPlJfCiZmhZNBjX9
         A4Fw==
X-Gm-Message-State: AOJu0YwGiU4xsCKcH7cjNBM7E0cm0cLjYLmNU5ZJHdtbI6yL9jhr833g
	4y/AmrinRnF+UvwSNb16pWmI74kkub7Rx1xfoN+tblEGiNdupz2PUmpunZAa
X-Google-Smtp-Source: AGHT+IGoqqpXs8yCOT3CmJ8TG3aAxC/ZdLPIINcnTtBxeYwajU3AT42ARErf5nKbw7xvPPyzhS0yvA==
X-Received: by 2002:a05:620a:4791:b0:792:8be8:1c67 with SMTP id af79cd13be357-792c7600e9fmr1835765785a.64.1715775746871;
        Wed, 15 May 2024 05:22:26 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2a11e8sm669380085a.58.2024.05.15.05.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 05:22:26 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] scan: use GET_SURVEY for SNR calculation in ranking
Date: Wed, 15 May 2024 05:22:19 -0700
Message-Id: <20240515122221.333230-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515122221.333230-1-prestwoj@gmail.com>
References: <20240515122221.333230-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This issues a GET_SURVEY dump after scan results are available and
populates the survey information within the scan results. Currently
the only value obtained is the noise for a given frequency but the
survey results structure was created if in the future more values
need to be added.

From the noise, the SNR can be calculated. This is then used in the
ranking calculation to help lower BSS ranks that are on high noise
channels.
---
 src/scan.c | 172 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 src/scan.h |   2 +
 2 files changed, 167 insertions(+), 7 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index d3f0ad31..8699fe3e 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -132,6 +132,18 @@ struct scan_context {
 	 */
 	unsigned int get_fw_scan_cmd_id;
 	struct wiphy *wiphy;
+
+	unsigned int get_survey_cmd_id;
+};
+
+struct scan_survey {
+	int8_t noise;
+};
+
+struct scan_survey_results {
+	struct scan_survey survey_2_4[14];
+	struct scan_survey survey_5[196];
+	struct scan_survey survey_6[233];
 };
 
 struct scan_results {
@@ -140,6 +152,9 @@ struct scan_results {
 	uint64_t time_stamp;
 	struct scan_request *sr;
 	struct scan_freq_set *freqs;
+	struct scan_survey_results survey;
+
+	bool survey_parsed : 1;
 };
 
 static bool start_next_scan_request(struct wiphy_radio_work_item *item);
@@ -217,6 +232,9 @@ static void scan_context_free(struct scan_context *sc)
 	if (sc->get_fw_scan_cmd_id && nl80211)
 		l_genl_family_cancel(nl80211, sc->get_fw_scan_cmd_id);
 
+	if (sc->get_survey_cmd_id && nl80211)
+		l_genl_family_cancel(nl80211, sc->get_survey_cmd_id);
+
 	wiphy_state_watch_remove(sc->wiphy, sc->wiphy_watch_id);
 
 	l_free(sc);
@@ -1663,6 +1681,8 @@ static void scan_bss_compute_rank(struct scan_bss *bss)
 {
 	static const double RANK_HIGH_UTILIZATION_FACTOR = 0.8;
 	static const double RANK_LOW_UTILIZATION_FACTOR = 1.2;
+	static const double RANK_HIGH_SNR_FACTOR = 1.2;
+	static const double RANK_LOW_SNR_FACTOR = 0.8;
 	double rank;
 	uint32_t irank;
 	/*
@@ -1689,6 +1709,13 @@ static void scan_bss_compute_rank(struct scan_bss *bss)
 	else if (bss->utilization <= 63)
 		rank *= RANK_LOW_UTILIZATION_FACTOR;
 
+	if (bss->have_snr) {
+		if (bss->snr <= 15)
+			rank *= RANK_LOW_SNR_FACTOR;
+		else if (bss->snr >= 30)
+			rank *= RANK_HIGH_SNR_FACTOR;
+	}
+
 	irank = rank;
 
 	if (irank > USHRT_MAX)
@@ -1824,6 +1851,41 @@ int scan_bss_rank_compare(const void *a, const void *b, void *user_data)
 	return (bss->rank > new_bss->rank) ? 1 : -1;
 }
 
+static bool scan_survey_get_snr(struct scan_results *results,
+					uint32_t freq, int32_t signal,
+					int8_t *snr)
+{
+	uint8_t channel;
+	enum band_freq band;
+	int8_t noise = 0;
+
+	if (!results->survey_parsed)
+		return false;
+
+	channel = band_freq_to_channel(freq, &band);
+	if (L_WARN_ON(!channel))
+		return false;
+
+	switch (band) {
+	case BAND_FREQ_2_4_GHZ:
+		noise = results->survey.survey_2_4[channel].noise;
+		break;
+	case BAND_FREQ_5_GHZ:
+		noise = results->survey.survey_5[channel].noise;
+		break;
+	case BAND_FREQ_6_GHZ:
+		noise = results->survey.survey_6[channel].noise;
+		break;
+	}
+
+	if (noise) {
+		*snr = signal - noise;
+		return true;
+	}
+
+	return false;
+}
+
 static void get_scan_callback(struct l_genl_msg *msg, void *user_data)
 {
 	struct scan_results *results = user_data;
@@ -1849,6 +1911,10 @@ static void get_scan_callback(struct l_genl_msg *msg, void *user_data)
 		bss->time_stamp = results->time_stamp -
 					seen_ms_ago * L_USEC_PER_MSEC;
 
+	bss->have_snr = scan_survey_get_snr(results, bss->frequency,
+						bss->signal_strength / 100,
+						&bss->snr);
+
 	scan_bss_compute_rank(bss);
 	l_queue_insert(results->bss_list, bss, scan_bss_rank_compare, NULL);
 }
@@ -1925,11 +1991,104 @@ static void get_scan_done(void *user)
 	l_free(results);
 }
 
+static void get_survey_callback(struct l_genl_msg *msg, void *user_data)
+{
+	struct scan_results *results = user_data;
+	struct scan_survey_results *survey = &results->survey;
+	struct l_genl_attr attr;
+	uint16_t type, len;
+	const void *data;
+	const uint32_t *freq = NULL;
+	const int8_t *noise = NULL;
+	uint8_t channel;
+	enum band_freq band;
+
+	if (nl80211_parse_attrs(msg, NL80211_ATTR_SURVEY_INFO, &attr,
+				NL80211_ATTR_UNSPEC) < 0)
+		return;
+
+	while (l_genl_attr_next(&attr, &type, &len, &data)) {
+		switch (type) {
+		case NL80211_SURVEY_INFO_FREQUENCY:
+			if (len != 4)
+				return;
+
+			freq = data;
+			break;
+		case NL80211_SURVEY_INFO_NOISE:
+			if (len != 1)
+				return;
+
+			noise = data;
+			break;
+		}
+	}
+
+	if (!freq || !noise)
+		return;
+
+	channel = band_freq_to_channel(*freq, &band);
+	if (!channel)
+		return;
+
+	/* At least one frequency was surveyed */
+	results->survey_parsed = true;
+
+	switch (band) {
+	case BAND_FREQ_2_4_GHZ:
+		survey->survey_2_4[channel].noise = *noise;
+		break;
+	case BAND_FREQ_5_GHZ:
+		survey->survey_5[channel].noise = *noise;
+		break;
+	case BAND_FREQ_6_GHZ:
+		survey->survey_6[channel].noise = *noise;
+		break;
+	}
+}
+
+static void get_results(struct scan_results *results)
+{
+	struct l_genl_msg *scan_msg;
+
+	scan_msg = l_genl_msg_new_sized(NL80211_CMD_GET_SCAN, 8);
+
+	l_genl_msg_append_attr(scan_msg, NL80211_ATTR_WDEV, 8,
+					&results->sc->wdev_id);
+	results->sc->get_scan_cmd_id = l_genl_family_dump(nl80211, scan_msg,
+						get_scan_callback,
+						results, get_scan_done);
+}
+
+static void get_survey_done(void *user_data)
+{
+	struct scan_results *results = user_data;
+	struct scan_context *sc = results->sc;
+
+	sc->get_survey_cmd_id = 0;
+
+	get_results(results);
+}
+
+static bool scan_survey(struct scan_results *results)
+{
+	struct scan_context *sc = results->sc;
+	struct l_genl_msg *survey_msg;
+
+	survey_msg = l_genl_msg_new(NL80211_CMD_GET_SURVEY);
+	l_genl_msg_append_attr(survey_msg, NL80211_ATTR_WDEV, 8,
+				&sc->wdev_id);
+	sc->get_survey_cmd_id = l_genl_family_dump(nl80211, survey_msg,
+						get_survey_callback, results,
+						get_survey_done);
+
+	return sc->get_survey_cmd_id != 0;
+}
+
 static void scan_get_results(struct scan_context *sc, struct scan_request *sr,
 				struct scan_freq_set *freqs)
 {
 	struct scan_results *results;
-	struct l_genl_msg *scan_msg;
 
 	results = l_new(struct scan_results, 1);
 	results->sc = sc;
@@ -1938,13 +2097,12 @@ static void scan_get_results(struct scan_context *sc, struct scan_request *sr,
 	results->bss_list = l_queue_new();
 	results->freqs = freqs;
 
-	scan_msg = l_genl_msg_new_sized(NL80211_CMD_GET_SCAN, 8);
+	if (scan_survey(results))
+		return;
+	else
+		l_warn("failed to start a scan survey");
 
-	l_genl_msg_append_attr(scan_msg, NL80211_ATTR_WDEV, 8,
-					&sc->wdev_id);
-	sc->get_scan_cmd_id = l_genl_family_dump(nl80211, scan_msg,
-						get_scan_callback,
-						results, get_scan_done);
+	get_results(results);
 }
 
 static void scan_wiphy_watch(struct wiphy *wiphy,
diff --git a/src/scan.h b/src/scan.h
index 516b6152..0bfc9e47 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -75,6 +75,7 @@ struct scan_bss {
 	uint64_t parent_tsf;
 	uint8_t *wfd;		/* Concatenated WFD IEs */
 	ssize_t wfd_size;	/* Size of Concatenated WFD IEs */
+	int8_t snr;
 	bool mde_present : 1;
 	bool cc_present : 1;
 	bool cap_rm_neighbor_report : 1;
@@ -89,6 +90,7 @@ struct scan_bss {
 	bool dpp_configurator : 1;
 	bool sae_pw_id_used : 1;
 	bool sae_pw_id_exclusive : 1;
+	bool have_snr : 1;
 };
 
 struct scan_parameters {
-- 
2.34.1

