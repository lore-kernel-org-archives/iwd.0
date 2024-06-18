Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0800613BC31
	for <iwd@lists.linux.dev>; Tue, 18 Jun 2024 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729951; cv=none; b=Y2t9AcXcZVNPfRNNy1TeW6cG6tUeLoEX/wYkWcmXzWUWd863afNTx4URtxqpXMvQ9bU5Ve/Zmw0Q9bM+3ydpgPh1JCm2ZLqFPKniMZvMuzuPcR/W5CQWvSxhjccMWeStt1d2/jkxffeA/JKRW/SUpZraqniuNOFntumNDHn07aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729951; c=relaxed/simple;
	bh=1f0d615K+oWHY4fZX+gIJLmlr8SAxj4iBQJBduSXNCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r59sBwgXH2wMuIOScsHOSl3KLH/u0msQQo5GudQZgtxvEI1Xl/+pDvSZJ8AASF+/ZSEq0AXy3N59p5wJ0W0yzkq21YOB20FgjvZ82aTlImZfpTfsgN3toUGAZogCJgNdQcmcYlMJkGy2OUB+jFgI3UUROC2e+qfN1uwSRUvp3Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kwkc38ky; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kwkc38ky"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-797e2834c4eso2073085a.0
        for <iwd@lists.linux.dev>; Tue, 18 Jun 2024 09:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718729948; x=1719334748; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbN+oW9si7tCvQ8TmgJ5F2whYRufSAGMcQWP4dm6WT4=;
        b=Kwkc38ky/gGqkCeA8ZCzNv40FMOfIWNqRoLnMgC9nlAmXAbsZaAZCkPzVCtbD1f3jY
         O9qFEVavfu0sh6lzmj2GVHlcz4gvZYWcJCjGNt8/yLeqS6N3iqK1PWDFaSzBRRG9B58s
         +TEP+t0aqG+UUQUMOkawLK1fmwZXSBdK3vzCfxwQf+bq8XeOCOkJGV5L6SEMOJx1uoix
         kqFIuc2ARsW3SZPV80pwH6oqLllgcmkz7LAQXRIo1tf9E0hmj1267MqLgsTkX96RmFSU
         4H+aihQ1OgBcLzJeHxTag34JQpiUhpZ4e3NSxkrbPSTBYBfA6BtrJq7USv0Ql4T4sHU3
         i7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718729948; x=1719334748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbN+oW9si7tCvQ8TmgJ5F2whYRufSAGMcQWP4dm6WT4=;
        b=AUGBiTAJlaEz9q2peuDyk54CQf8whoULILtbi+PSTJDswkUOUjrGUgPDeEzY+8KeHw
         T8qaQItT4nR3MhzuxTLkI66KL5Snwh+k0co6XjaVma3lojluZnvZiYR092442WRicqeA
         usEDnt36HUREA50ZFoHMY95u8C0PEibO4Ttu+0yy/WGuCHelvpH+mVNuiMBxVHIPjPyb
         mZJ9qH5k1HiQMoHy1L2hfj4It9U/pLVGjYr3UAjVt+mQq26ZCJ3rG8XmcscNgKgHvuJQ
         wAWrRoZ0e4b5lhTLiod0gPoo7562M367sYOORoSzYBw7kLNntpyYfk1WD7FXdr2iEj/I
         0qQw==
X-Gm-Message-State: AOJu0Yz2E4s65FrRcELS9d09uNEe6mq2++kmCbIwZxGwX1tQ+7mBi4gE
	cAntzSttVJMZeHGKrNLMAPLkF1wtCw59RxtSsXS1uNloQNMN07U8UsG3xg==
X-Google-Smtp-Source: AGHT+IE8Y1AtN2NoFYMo/gPJu9JUH8WOmG/2KWivkDe/fR/a6OgeVP26HtLCQNer3H9b/vWkQGFYwA==
X-Received: by 2002:a05:620a:4141:b0:795:4e67:1ef5 with SMTP id af79cd13be357-79bb347ce14mr70563885a.11.1718729947525;
        Tue, 18 Jun 2024 09:59:07 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798b49e4c82sm533688785a.88.2024.06.18.09.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 09:59:07 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 08/10] scan: use GET_SURVEY for SNR calculation in ranking
Date: Tue, 18 Jun 2024 09:58:52 -0700
Message-Id: <20240618165854.113598-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618165854.113598-1-prestwoj@gmail.com>
References: <20240618165854.113598-1-prestwoj@gmail.com>
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
 src/scan.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 src/scan.h |   2 +
 2 files changed, 151 insertions(+), 7 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 55d560d4..76ea379b 100644
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
@@ -1925,11 +1991,88 @@ static void get_scan_done(void *user)
 	l_free(results);
 }
 
+static void get_survey_callback(struct l_genl_msg *msg, void *user_data)
+{
+	struct scan_results *results = user_data;
+	struct scan_survey_results *survey = &results->survey;
+	struct l_genl_attr attr;
+	uint32_t freq;
+	int8_t noise;
+	uint8_t channel;
+	enum band_freq band;
+
+	if (nl80211_parse_attrs(msg, NL80211_ATTR_SURVEY_INFO, &attr,
+				NL80211_ATTR_UNSPEC) < 0)
+		return;
+
+	if (nl80211_parse_nested(&attr, NL80211_ATTR_SURVEY_INFO,
+					NL80211_SURVEY_INFO_FREQUENCY, &freq,
+					NL80211_SURVEY_INFO_NOISE, &noise,
+					NL80211_ATTR_UNSPEC) < 0)
+		return;
+
+	channel = band_freq_to_channel(freq, &band);
+	if (!channel)
+		return;
+
+	/* At least one frequency was surveyed */
+	results->survey_parsed = true;
+
+	switch (band) {
+	case BAND_FREQ_2_4_GHZ:
+		survey->survey_2_4[channel].noise = noise;
+		break;
+	case BAND_FREQ_5_GHZ:
+		survey->survey_5[channel].noise = noise;
+		break;
+	case BAND_FREQ_6_GHZ:
+		survey->survey_6[channel].noise = noise;
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
@@ -1938,13 +2081,12 @@ static void scan_get_results(struct scan_context *sc, struct scan_request *sr,
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

