Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D4153A5
	for <iwd@lists.linux.dev>; Fri, 30 Dec 2022 22:12:25 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id s67so5608829pgs.3
        for <iwd@lists.linux.dev>; Fri, 30 Dec 2022 14:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RulqlsrqV/F/bDHG/vL50GoCGqzQVUSPE7I8apmvFXs=;
        b=YYpe5ambMIlTfq6spGq2dVmgPj1w3aBaEPJkOLH/Ex6c4+575rgJqQdQ4mvSFj3RB7
         Qe9HTh7mKSYdTOIjlbUSqmrFQc9p+sht/g1sW8QLgwBNy/tnRM8x86CJ/N9WLO1sWxYf
         1SwJku5IX8KQAYzgGcpOfKcaTb0s8I9U5q6+8caefAaxGrg6F85PJ77pOfQK48tFbB5m
         STVRI2+mKb06FpdKZj8FhSrAn7P1bYXu8mCGM5HOHLDPVlgToUV9jFGsgiNAkPBYTUWM
         pue3ALTN9b6B3Ixrpg7+M0au727qjaEz53RvFk/7j3SU7hMbbu5rpaQmLoWCDXOes+8P
         U2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RulqlsrqV/F/bDHG/vL50GoCGqzQVUSPE7I8apmvFXs=;
        b=Fe24VonpBldsdqzZ5ilyDtSivAh5UwDs/BjmL6IyVNz5nt0dDWenVMFWk84+gC2bP0
         sasgiXLOgo2lm/tkaEHqUtPo7aL7LJry/2nAjq/WYgHWL0chQ18NAkrFYhUY3gj0ble4
         uur0X7eJgytJWkX4Lnrqc7keXWY3HNL0VxeR0lKiEQHjmtVO3AXr5347KMwsguFi1tkc
         41ysgkYiz5/YcCmlBLts8aFn5AMTMtuBYFzf9mKX18Y1hROMgw33hFCsD+aFrbrUoM89
         AGKpHMkF6okPGj10nmeJJaywxhLZpk1Wv97YY4iOzfzeMVSHVM97E0IifwSiSj6u70It
         i9xA==
X-Gm-Message-State: AFqh2krzdE/XphhAHX6STsZuQ/F495xxngRCjXtllWuatJPpW+hn2yhY
	cjUNKf4khoMueDSGF/mDl0bUcu0TYQw=
X-Google-Smtp-Source: AMrXdXulphmG83zy4Vnwg+wOpkg6QLc7AW3f7iXcNW2fYAq1cb4yZyMsy8DfqwNvMprZNy9OkWPJEg==
X-Received: by 2002:a05:6a00:1346:b0:581:c216:1390 with SMTP id k6-20020a056a00134600b00581c2161390mr9740429pfu.34.1672438345102;
        Fri, 30 Dec 2022 14:12:25 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id 123-20020a621881000000b00528a097aeffsm14187833pfy.118.2022.12.30.14.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 14:12:24 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] ap: support setting country IE
Date: Fri, 30 Dec 2022 14:12:16 -0800
Message-Id: <20221230221216.2985011-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221230221216.2985011-1-prestwoj@gmail.com>
References: <20221230221216.2985011-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a builder which sets the country IE in probes/beacons.
The IE will use the 'single subband triplet sequence' meaning
dot11OperatingClassesRequired is false. This is much easier to
build and doesn't require knowing an operating class.

The IE itself is variable in length and potentially could grow
large if the hardware has a weird configuration (many different
power levels or segmentation in supported channels) so the
overall builder was changed to take the length of the buffer and
warnings will be printed if any space issues are encountered.
---
 src/ap.c | 134 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 118 insertions(+), 16 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index a989c454..1d937103 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -1061,22 +1061,123 @@ static size_t ap_build_beacon_pr_head(struct ap_state *ap,
 	return 36 + out_len;
 }
 
+static size_t ap_build_country_ie(struct ap_state *ap, uint8_t *out_buf,
+					size_t buf_len)
+{
+	size_t len;
+	size_t i;
+	int spacing;
+	uint8_t *pos = out_buf;
+	uint8_t nchans = 1;
+	struct wiphy *wiphy = netdev_get_wiphy(ap->netdev);
+	const struct band_freq_attrs *last = NULL;
+	const struct band_freq_attrs *list = wiphy_get_frequency_info_list(
+							wiphy, ap->band, &len);
+
+	if (!list || wiphy_country_is_unknown(wiphy))
+		return 0;
+
+	if (L_WARN_ON(buf_len < 5))
+		goto no_space;
+
+	*pos++ = IE_TYPE_COUNTRY;
+	/* length not yet known */
+	pos++;
+
+	wiphy_get_reg_domain_country(wiphy, (char *)pos);
+	pos += 2;
+	*pos++ = ' ';
+
+	buf_len -= 5;
+
+	if (ap->band == BAND_FREQ_2_4_GHZ)
+		spacing = 1;
+	else
+		spacing = 4;
+
+	/*
+	 * Construct a list of subband triplet entries. Each entry contains a
+	 * starting channel and a number of channels which are spaced evenly
+	 * and use the same TX power. Any deviation from this results in a new
+	 * channel group.
+	 *
+	 * TODO: 6Ghz requires operating triplets, not subband triplets.
+	 */
+	for (i = 0; i < len; i++) {
+		const struct band_freq_attrs *attr = &list[i];
+
+		if (!attr->supported || attr->disabled)
+			continue;
+
+		if (!last) {
+			/* Room for one complete triplet */
+			if (L_WARN_ON(buf_len < 3))
+				goto no_space;
+
+			*pos++ = i;
+			last = attr;
+			continue;
+		}
+
+		if (spacing != attr - last ||
+					attr->tx_power != last->tx_power) {
+			/* finish current group */
+			*pos++ = nchans;
+			*pos++ = last->tx_power;
+			buf_len -= 3;
+
+			/* start a new group */
+			if (L_WARN_ON(buf_len < 3))
+				goto no_space;
+
+			*pos++ = i;
+			nchans = 1;
+		} else
+			nchans++;
+
+		last = attr;
+	}
+
+	/* finish final group */
+	*pos++ = nchans;
+	*pos++ = last->tx_power;
+
+	len = pos - out_buf - 2;
+
+	/* Pad to even byte */
+	if (len & 1) {
+		if (L_WARN_ON(buf_len < 1))
+			goto no_space;
+
+		*pos++ = 0;
+		len++;
+	}
+
+	out_buf[1] = len;
+
+	return out_buf[1] + 2;
+
+no_space:
+	return 0;
+}
+
 /* Beacon / Probe Response frame portion after the TIM IE */
 static size_t ap_build_beacon_pr_tail(struct ap_state *ap,
 					enum mpdu_management_subtype stype,
 					const struct mmpdu_header *req,
-					size_t req_len, uint8_t *out_buf)
+					size_t req_len, uint8_t *out_buf,
+					size_t buf_len)
 {
 	size_t len;
 	struct ie_rsn_info rsn;
 
-	/* TODO: Country IE between TIM IE and RSNE */
+	len = ap_build_country_ie(ap, out_buf, buf_len);
 
 	/* RSNE */
 	ap_set_rsn_info(ap, &rsn);
-	if (!ie_build_rsne(&rsn, out_buf))
+	if (!ie_build_rsne(&rsn, out_buf + len))
 		return 0;
-	len = 2 + out_buf[1];
+	len += 2 + out_buf[len + 1];
 
 	len += ap_write_extra_ies(ap, stype, req, req_len, out_buf + len);
 	return len;
@@ -1094,11 +1195,11 @@ void ap_update_beacon(struct ap_state *ap)
 {
 	struct l_genl_msg *cmd;
 	uint8_t head[256];
-	L_AUTO_FREE_VAR(uint8_t *, tail) =
-		l_malloc(256 + ap_get_extra_ies_len(ap,
+	size_t tail_len = 256 + ap_get_extra_ies_len(ap,
 						MPDU_MANAGEMENT_SUBTYPE_BEACON,
-						NULL, 0));
-	size_t head_len, tail_len;
+						NULL, 0);
+	L_AUTO_FREE_VAR(uint8_t *, tail) = malloc(tail_len);
+	size_t head_len;
 	uint64_t wdev_id = netdev_get_wdev_id(ap->netdev);
 	static const uint8_t bcast_addr[6] = {
 		0xff, 0xff, 0xff, 0xff, 0xff, 0xff
@@ -1110,7 +1211,7 @@ void ap_update_beacon(struct ap_state *ap)
 	head_len = ap_build_beacon_pr_head(ap, MPDU_MANAGEMENT_SUBTYPE_BEACON,
 						bcast_addr, head, sizeof(head));
 	tail_len = ap_build_beacon_pr_tail(ap, MPDU_MANAGEMENT_SUBTYPE_BEACON,
-						NULL, 0, tail);
+						NULL, 0, tail, tail_len);
 	if (L_WARN_ON(!head_len || !tail_len))
 		return;
 
@@ -2294,7 +2395,7 @@ static void ap_probe_req_cb(const struct mmpdu_header *hdr, const void *body,
 	len += ap_build_beacon_pr_tail(ap,
 					MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE,
 					hdr, body + body_len - (void *) hdr,
-					resp + len);
+					resp + len, resp_len - len);
 
 	ap_send_mgmt_frame(ap, (struct mmpdu_header *) resp, len,
 				ap_probe_resp_cb, NULL);
@@ -2551,11 +2652,11 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struct ap_state *ap)
 	struct l_genl_msg *cmd;
 
 	uint8_t head[256];
-	L_AUTO_FREE_VAR(uint8_t *, tail) =
-		l_malloc(256 + ap_get_extra_ies_len(ap,
+	size_t tail_len = 256 + ap_get_extra_ies_len(ap,
 						MPDU_MANAGEMENT_SUBTYPE_BEACON,
-						NULL, 0));
-	size_t head_len, tail_len;
+						NULL, 0);
+	L_AUTO_FREE_VAR(uint8_t *, tail) = l_malloc(tail_len);
+	size_t head_len;
 
 	uint32_t dtim_period = 3;
 	uint32_t ifindex = netdev_get_ifindex(ap->netdev);
@@ -2584,7 +2685,7 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struct ap_state *ap)
 	head_len = ap_build_beacon_pr_head(ap, MPDU_MANAGEMENT_SUBTYPE_BEACON,
 						bcast_addr, head, sizeof(head));
 	tail_len = ap_build_beacon_pr_tail(ap, MPDU_MANAGEMENT_SUBTYPE_BEACON,
-						NULL, 0, tail);
+						NULL, 0, tail, tail_len);
 
 	if (!head_len || !tail_len)
 		return NULL;
@@ -2632,7 +2733,8 @@ static struct l_genl_msg *ap_build_cmd_start_ap(struct ap_state *ap)
 					zero_addr, ptr, sizeof(probe_resp));
 		ptr += ap_build_beacon_pr_tail(ap,
 					MPDU_MANAGEMENT_SUBTYPE_PROBE_RESPONSE,
-					NULL, 0, ptr);
+					NULL, 0, ptr, sizeof(probe_resp) -
+					(ptr - probe_resp));
 
 		l_genl_msg_append_attr(cmd, NL80211_ATTR_PROBE_RESP,
 					ptr - probe_resp, probe_resp);
-- 
2.34.3

