Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F201360
	for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 16:42:55 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id v8so13720631edi.3
        for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 08:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bq29Y2mHD4lnTpVIqu+VsnyFefvXWo9JkM2EM+uUM9s=;
        b=UY+PrmILgCpa+Xa3xWI+uPbayzsDJwUklx7hSIt29EIh+XThwXqTiHNLWjOzWsmV3f
         dlXG75RLHiyYcezmFxYYL1GUOao+YA3SLOQ9GmhKI7iaGO2nK9UnCnAqIlHCVmdY8mdd
         1Kz+vA3pyx8LJ7ddJ9LIo9lDY4+pQb4FKC0D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bq29Y2mHD4lnTpVIqu+VsnyFefvXWo9JkM2EM+uUM9s=;
        b=QC443XWMzNt//6hw6MSEhQA/1eKyMLCN2lSKLB/OshLO/5C4kXtd6I5wr6Q+HNedqD
         XurnAkldSeOasuTt3RZKtyuQIbVwQqJTx9AiURuK4Zvw8ACuatEK/V6eu9OsWz9aGnXt
         +11uCY/15QJT8oRvJcKNMq7ck345f25JH7285kGfOquojLI9eMQR8gh87mdWxSGYnU9m
         +AFbvBZnQkoKfba5fcFKOa+QxjoCK8AX/QTRIZaQSfN1AsxoecLib5dJpsu4hSxQ7hku
         oWHGe9xGIRIGzKMnXOPR6CM2HOh3+JOOHAaCpRVFccm5P4d7GxL3v0mPLAfJEq/BIVJT
         hWdQ==
X-Gm-Message-State: ANoB5pnEs8/uYNmrW9/FxVmSevUV1VDdJCPyd4hSXGw/K2w9n8V751tG
	4bpUV3N5ZiceTOrkT2JP0InJPJ2GPcVlgasM
X-Google-Smtp-Source: AA0mqf6bKhcvd6IiIN3OBO4KTOmrm1m1mDykYM7CGGBFGOEnkjmpzGsS4iEPqayPIR0d3m7QP1x/hw==
X-Received: by 2002:a05:6402:1154:b0:462:16a2:a2e7 with SMTP id g20-20020a056402115400b0046216a2a2e7mr13917559edw.6.1670863374336;
        Mon, 12 Dec 2022 08:42:54 -0800 (PST)
Received: from localhost.localdomain ([193.89.194.60])
        by smtp.gmail.com with ESMTPSA id l8-20020a056402344800b0045d74aa401fsm3935124edc.60.2022.12.12.08.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 08:42:53 -0800 (PST)
From: =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To: iwd@lists.linux.dev
Cc: =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: [PATCH] Revert "scan: Don't callback on SCAN_ABORTED"
Date: Mon, 12 Dec 2022 17:42:50 +0100
Message-Id: <20221212164250.3075444-1-alvin@pqrs.dk>
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

This reverts commit 6051a1495227bbe7ba357f6995d4dbe4a4862331.

The blamed commit argues that the periodic scan callback doesn't do
anything useful in the event of an aborted scan, but this is not
entirely true. In particular, the callback is responsible for resetting
the station scanning state to false. Failure to do so means that the
station scanning state remains true indefinitely if a periodic scan is
aborted, and no further periodic scans can be performed by iwd.
---
 src/scan.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index 5d2f2957748a..dbc46a754d16 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -83,7 +83,6 @@ struct scan_request {
 	bool canceled : 1; /* Is scan_cancel being called on this request? */
 	bool passive:1; /* Active or Passive scan? */
 	bool started : 1; /* Has TRIGGER_SCAN succeeded at least once? */
-	bool periodic : 1; /* Started as a periodic scan? */
 	/*
 	 * Set to true if the TRIGGER_SCAN command at the head of the 'cmds'
 	 * queue was acked by the kernel indicating that the scan request was
@@ -997,7 +996,6 @@ static void scan_periodic_destroy(void *user_data)
 static bool scan_periodic_queue(struct scan_context *sc)
 {
 	struct scan_parameters params = {};
-	struct scan_request *sr;
 
 	if (sc->sp.needs_active_scan && known_networks_has_hidden()) {
 		params.randomize_mac_addr_hint = true;
@@ -1015,13 +1013,7 @@ static bool scan_periodic_queue(struct scan_context *sc)
 					scan_periodic_notify, sc,
 					scan_periodic_destroy);
 
-	if (!sc->sp.id)
-		return false;
-
-	sr = l_queue_peek_tail(sc->requests);
-	sr->periodic = true;
-
-	return true;
+	return sc->sp.id != 0;
 }
 
 static bool scan_periodic_is_disabled(void)
@@ -2242,13 +2234,7 @@ static void scan_notify(struct l_genl_msg *msg, void *user_data)
 
 		if (sr->triggered) {
 			sr->triggered = false;
-
-			/* If periodic scan, don't report the abort */
-			if (sr->periodic) {
-				l_queue_remove(sc->requests, sr);
-				wiphy_radio_work_done(sc->wiphy, sr->work.id);
-			} else
-				scan_finished(sc, -ECANCELED, NULL, NULL, sr);
+			scan_finished(sc, -ECANCELED, NULL, NULL, sr);
 		} else if (wiphy_radio_work_is_running(sc->wiphy,
 							sr->work.id)) {
 			/*
-- 
2.37.3

