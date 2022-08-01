Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8E47F
	for <iwd@lists.linux.dev>; Mon,  1 Aug 2022 10:07:33 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id v5so5536700wmj.0
        for <iwd@lists.linux.dev>; Mon, 01 Aug 2022 03:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6NTBjYWmtCLHhpP/9lJDTwxAxSI1LBSoPtCcxqa0AUg=;
        b=GXpPJnJBxhqQsP1NYJPPAU6pxerQlQ4DRQuDJ8nOSDFC0ZK3rLbnh53BmVyXA2TdcW
         Iy+EjnaxXoOZXyiALJPBjuMaVe8a5ven7kkcLTTs5EKOKlUC2Z2qYyvvnG+Qk9vSLZq+
         ispa8Yz5fSSVTA+QzyRdA5dbPPTwsXFgDRHPKg7lCm3azeLuyV6eG/UsnnYgDP0Sb6Zu
         KG9Z8KECWIV3Hux7uxQrU2HtpbCNoVXS4s4Fk1A42UoMAQQZQQiv441y/m9t4h3uFMSi
         FTbxBeDDd6dMpx5HzHU7MfDtQ3kaCYiBfQalzhdOuIGd2fvU7ZNhjIlzJEZhNNDLm0a2
         FYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6NTBjYWmtCLHhpP/9lJDTwxAxSI1LBSoPtCcxqa0AUg=;
        b=3omdcVdubj1aPFm/p47iKrMh2iEkApOHG+j+lH2gjhnF6FvVFLgXExVc0nJQRM64sy
         QtBwA5zrsGNI0kk7zOht+rw/QPNyeCWdKWyNSmQCOr+ymFXZS/gY7cLrfd4OZkNuHoRT
         YxYS25hfV8GPk5V+ehyeaW9Nm3ru0PiICTHJC51ki02HF0gRRTw36umEmtAtKsXhyjic
         cdXT6GSl4h6rbf07G+DU9HfwCajY0NEgYlo8FmJXLaUpaVF2fW4fVpEEO/A5QfDKUVHG
         DDlYWCGLUQo1HtqB0G5YeFPW1bmXVXbffbsSNykhxZ2E2CcFteupM57zO9dZEQRENUmy
         XuTQ==
X-Gm-Message-State: AJIora9JA+IN29gOgJ81PYOPIF9FeDQj5yvSNB/mBbLsd+SR7kJq7L4I
	VnqfWMPcRl9KPH73delOxRCdcQoxX2U=
X-Google-Smtp-Source: AGRyM1uXGMmy/qmxR/4o2Ddhpn12zIOpiU4bUz4gNOn3y0C3WQA/aPOmzgT8ayVKGzpXbEuTAAvl6Q==
X-Received: by 2002:a7b:c4cc:0:b0:3a3:2123:8c1b with SMTP id g12-20020a7bc4cc000000b003a321238c1bmr10630255wmk.180.1659348451050;
        Mon, 01 Aug 2022 03:07:31 -0700 (PDT)
Received: from localhost.localdomain (cpc156731-sgyl45-2-0-cust617.18-2.cable.virginm.net. [82.31.54.106])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c155100b003a32167b8d4sm21686207wmg.13.2022.08.01.03.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 03:07:30 -0700 (PDT)
From: Michael Johnson <mjohnson459@gmail.com>
To: iwd@lists.linux.dev
Cc: Michael Johnson <mjohnson459@gmail.com>
Subject: [PATCH 2/2] station: Log scan results during a roam
Date: Mon,  1 Aug 2022 11:06:31 +0100
Message-Id: <20220801100631.41605-2-mjohnson459@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801100631.41605-1-mjohnson459@gmail.com>
References: <20220801100631.41605-1-mjohnson459@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provides useful information on why a roam might have failed, such as
failing to find the BSS or the BSS being ranked lower, and why that
might be.

The output format is the same as station_add_seen_bss for consistency.
---
 src/station.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 02f21c76..e39e9d4b 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2286,6 +2286,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 	struct station *station = userdata;
 	struct network *network = station->connected_network;
 	struct handshake_state *hs = netdev_get_handshake(station->netdev);
+	struct scan_bss *current_bss = station->connected_bss;
 	struct scan_bss *bss;
 	struct scan_bss *best_bss = NULL;
 	double best_bss_rank = 0.0;
@@ -2317,9 +2318,20 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 	 * for BSSes that are within the FT Mobility Domain so as to favor
 	 * Fast Roaming, if it is supported.
 	 */
+	l_debug("Current BSS '%s' with SSID: %s",
+		util_address_to_string(current_bss->addr),
+		util_ssid_to_utf8(current_bss->ssid_len, current_bss->ssid));
 
 	while ((bss = l_queue_pop_head(bss_list))) {
 		double rank;
+		uint32_t kbps100 = DIV_ROUND_CLOSEST(bss->data_rate, 100000);
+
+		l_debug("Processing BSS '%s' with SSID: %s, freq: %u, rank: %u,"
+				" strength: %i, data_rate: %u.%u",
+				util_address_to_string(bss->addr),
+				util_ssid_to_utf8(bss->ssid_len, bss->ssid),
+				bss->frequency, bss->rank, bss->signal_strength,
+				kbps100 / 10, kbps100 % 10);
 
 		/* Skip the BSS we are connected to if doing an AP roam */
 		if (station->ap_directed_roaming && !memcmp(bss->addr,
@@ -2327,7 +2339,6 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 			goto next;
 
 		/* Skip result if it is not part of the ESS */
-
 		if (bss->ssid_len != hs->ssid_len ||
 				memcmp(bss->ssid, hs->ssid, hs->ssid_len))
 			goto next;
-- 
2.25.1

