Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30AD6FD9
	for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 21:11:02 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id bj12so31443862ejb.13
        for <iwd@lists.linux.dev>; Mon, 12 Dec 2022 13:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a6GQ+Iheg52iWwyH51o4TZPAjCIunfn1a1YnRB8c1Do=;
        b=PYVKAteXWouKUZeAPvEzqRMKguNN1TBAsNLePjrv+W/E80xwB45VhjH7qsmOFhkfNk
         OqCuEe3DuGICC2sVmrmbbA/AMi77401UiBzUOqJ6lvOOmBJ/ROi/2g8xOPl8XRNcU3Pj
         rPlGsCMIKYQ6g2kLSpkqyRe29FdZvCVz7fvLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a6GQ+Iheg52iWwyH51o4TZPAjCIunfn1a1YnRB8c1Do=;
        b=vwRAfyU+ISxuDsXCEaAMuYKH+HC9QZn7PIBc0oRD94S1lHHsdgXJ0BdCXksip4wTkN
         7yt3ZuPuoxGv4f1rdvyKT1meUDyaLIwq5n8WVUh3SKKVl8wHzt4bIkJI3cGzDEKPYts0
         OQCODEmHMkWtF2D4QDo+8V3QlgzRQX99wj5dpyLI0xbaR+iFgtgBHhht4yNnbhEh+Qk2
         keebaL3CiaE1nMMot390ZuVpYuvyeSY9tPM0ntELJpIi0Z8X2LDNm3mNX0X7ZqfgUU91
         I8KBYMbpzApiuIBm5hVQ3QkIvC3KOJ7tcU+rMG8rNXSOLLe7hykzat919JnV8nHy4EhE
         SStQ==
X-Gm-Message-State: ANoB5pmWb4ts0GycplUqyO2xf1J5QGqMhWysBfErGj8HAJr0dZPA1+5K
	ZE3tVcQs579++oGo0bUR4rA35QdCcKCRzXUK
X-Google-Smtp-Source: AA0mqf6X9kT5wNHofHa00FC5zjdyrjollolPFJGKOZ2wBCrtFlwV2cOtUEs/r3uNt8d0TpyDO//aTw==
X-Received: by 2002:a17:906:eda6:b0:7c0:d2b2:eb07 with SMTP id sa6-20020a170906eda600b007c0d2b2eb07mr13623992ejb.26.1670879460751;
        Mon, 12 Dec 2022 13:11:00 -0800 (PST)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id u18-20020a1709061db200b007c16fdc93ddsm1827925ejh.81.2022.12.12.13.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 13:11:00 -0800 (PST)
From: =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To: iwd@lists.linux.dev
Cc: =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>
Subject: [PATCH] scan: call scan_finished() when periodic scans get aborted
Date: Mon, 12 Dec 2022 22:10:50 +0100
Message-Id: <20221212211050.3109050-1-alvin@pqrs.dk>
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

The blamed commit argues that the periodic scan callback doesn't do
anything useful in the event of an aborted scan, but this is not
entirely true. In particular, the callback is responsible for re-arming
the periodic scan timer. Make sure to call scan_finished() so that iwd's
periodic scanning logic continues unabated even when a periodic scan is
aborted.

Also remove the periodic boolean member of struct scan_request, as it
serves no purpose anymore.

Fixes: 6051a1495227 ("scan: Don't callback on SCAN_ABORTED")
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

