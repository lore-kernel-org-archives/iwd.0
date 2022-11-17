Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80E78BE0
	for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 17:29:13 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id bj12so6720405ejb.13
        for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 09:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kfxTDCnqKTjQXcj42iaLu3yaU0DCx4xJkCBGZ4J4f8Q=;
        b=gVV5gFbOjgcBYuGuxICFGnki8ONXu+5/jsjlBuohJQL6BqdeFgh1TP+dJuIzTGlNup
         XpKkzqcQR3MMrAijvWNkp5OF1Doz3XBiTEc34UDjkvZAxWOyTmOEOgTD4mMVIPMYsyE7
         UO7J+5WUWrngkpJFLj3wglC3MrmeA30vYCGKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kfxTDCnqKTjQXcj42iaLu3yaU0DCx4xJkCBGZ4J4f8Q=;
        b=bEFMeRTz88oXajVbuVAnN48PzcMb+YWoOWF7vROPezwIyLW8HQXwJ/2Z7SPUwZzRD4
         Ekj1um9Uby/UcEmo/WsdCKzK9tdYz/Q7DHW9Te/IFYiEU0dLLno77WzpC1ObJ36gas1D
         jkk3iqGXGCrTsN5tRjCDiJ5c45bktbgB/uxMkfNiNGZ5/T35ji5s24DjauZPZiaTNPL+
         QOBo2L5yfdfEwgxrYzzPPN+03OrHbtu7Uf++/Nye1yZN455zluBUg3Fd9hdsuKX3G1Si
         OzeXPXSGi5ISF3g7NKnwUuhpKjk2f1bqnu1klH+84reW4D98RPvzc8qIrr3x3uRnZuo/
         LxAA==
X-Gm-Message-State: ANoB5pkWT2F2dVH4iJAnzeJL36HDrQuUOVFwNQY/j67ecV8ioPJWEO6y
	CLrF/RnaCmXZaSh1sBw2d13z0WDS9OCqbw==
X-Google-Smtp-Source: AA0mqf5ovmGWusrLJ7DvFUJBfglw3doqmOEBMo/NY7cAgONRFnNAqrui6BZsT8Jq7bGtX/gwRVc/9Q==
X-Received: by 2002:a17:906:950a:b0:7ab:2559:8bc4 with SMTP id u10-20020a170906950a00b007ab25598bc4mr2824452ejx.682.1668706151951;
        Thu, 17 Nov 2022 09:29:11 -0800 (PST)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id e12-20020a1709062c0c00b0073d7b876621sm608627ejh.205.2022.11.17.09.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 09:29:11 -0800 (PST)
From: =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To: iwd@lists.linux.dev
Cc: =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: [RFC PATCH] scan: retry scan based on scan done events per wiphy, not wdev
Date: Thu, 17 Nov 2022 18:29:01 +0100
Message-Id: <20221117172901.2459224-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alvin Šipraga <alsi@bang-olufsen.dk>

---
 src/scan.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/src/scan.c b/src/scan.c
index 5548914a12de..c3763ee41173 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -151,6 +151,22 @@ static bool scan_context_match(const void *a, const void *b)
 	return sc->wdev_id == *wdev_id;
 }
 
+static bool scan_context_match_retry(const void *a, const void *b)
+{
+	const struct scan_context *sc = a;
+	const struct scan_request *sr;
+	const uint32_t *wiphy_id = b;
+
+	if (wiphy_get_id(sc->wiphy) != *wiphy_id)
+		return false;
+
+	sr = l_queue_peek_head(sc->requests);
+	if (!sr)
+		return false;
+
+	return wiphy_radio_work_is_running(sc->wiphy, sr->work.id);
+}
+
 static bool scan_request_match(const void *a, const void *b)
 {
 	const struct scan_request *sr = a;
@@ -231,6 +247,7 @@ static void scan_request_triggered(struct l_genl_msg *msg, void *userdata)
 	if (err < 0) {
 		/* Scan in progress, assume another scan is running */
 		if (err == -EBUSY) {
+			l_debug("XXX busy");
 			sc->state = SCAN_STATE_PASSIVE;
 			return;
 		}
@@ -2044,6 +2061,29 @@ static void scan_parse_result_frequencies(struct l_genl_msg *msg,
 	}
 }
 
+static void scan_retry_pending(uint32_t wiphy_id)
+{
+	struct scan_context *sc = l_queue_find(scan_contexts,
+					       scan_context_match_retry,
+					       &wiphy_id);
+	struct scan_request *sr;
+
+	l_debug("");
+
+	if (!sc)
+		return;
+
+	sr = l_queue_peek_head(sc->requests);
+
+	if (L_WARN_ON(!sr))
+		return;
+
+	l_debug("XXX retry pending request");
+
+	sc->state = SCAN_STATE_NOT_RUNNING;
+	start_next_scan_request(&sr->work);
+}
+
 static void scan_notify(struct l_genl_msg *msg, void *user_data)
 {
 	struct l_genl_attr attr;
@@ -2065,8 +2105,13 @@ static void scan_notify(struct l_genl_msg *msg, void *user_data)
 		return;
 
 	sc = l_queue_find(scan_contexts, scan_context_match, &wdev_id);
-	if (!sc)
+	if (!sc) {
+		if (cmd == NL80211_CMD_NEW_SCAN_RESULTS ||
+		    cmd == NL80211_CMD_SCAN_ABORTED)
+			scan_retry_pending(wiphy_id);
+
 		return;
+	}
 
 	l_debug("Scan notification %s(%u)", nl80211cmd_to_string(cmd), cmd);
 
-- 
2.37.3

