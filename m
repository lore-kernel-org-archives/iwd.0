Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E309C2115
	for <iwd@lists.linux.dev>; Fri, 13 Jan 2023 19:25:59 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id v23so19500005plo.1
        for <iwd@lists.linux.dev>; Fri, 13 Jan 2023 11:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fYwxAPRGu9UNhOUpmv01d2alviaH8oneUnudxh29BRU=;
        b=igcqnE1q+6HPW5eHOajfp3aKg8YrNgYucsPyubDZhGbmpMsZCmYvW0cUDXOVuo3AXk
         5zzxpjMrj6VhjMBLQk/oFSRruuThVBYNz4yaENaW7YsFSxadg/m4VKH2tULwtw8H7w+j
         n6In6bHrcf3DJHdvOdX3SCZLJxoVob+MWVtxiTxYlp6MxfTt5Lqfqcd9xbKmA0HfyN98
         Pv44AQWDn9RGyzwT/sjKM/EgamPUZbu+cUn+CduLcGnF25vc54wXYswxOwoimO9Io8Z0
         EsiiEl9CWz8Ctz8EllEIX3sL1PLwFhBzK7ufzNRkKyIMR9lvXgAIZMQE91S6CyJL2IhF
         Yx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYwxAPRGu9UNhOUpmv01d2alviaH8oneUnudxh29BRU=;
        b=c3xcclCVlLJAKrZfGWgKRzndjt1qQsDsWm7qC8/gLSg32tuGxaIcLSIs9K/WdNniIU
         aLiUe6b4RpiHUM+dUtMsMAlpjrDcx1I5VTxCjpCqh71TNlLQAAb+lSBnaGWszMpJv084
         GS9oAMyjj5OMFnVX0f8uTNuCPcLzLCEHBcqWZTXbLp7GsZDSZ05xNm/4BmFZXaXDrbzJ
         5WihWvVdK1wKKdY+NT2KHZKHnuz/JzrWcuged9PEC2e3RweQ3uOio26YSx6rkPSzjfQ+
         M9Gq4jLswkeU3blYLcwgfDEco7luMEG2qcPcI8VhIpmqxHik8ph/P5wrDW3dT0wFvYvS
         2SUA==
X-Gm-Message-State: AFqh2krF+hTmAqq5AHfXqUN6J4fqecz6EKnbOb0TxSNbf6fqdJ5Li32A
	cIfdHR0GK6yMUwck0dpl+5b06H45c5E=
X-Google-Smtp-Source: AMrXdXugGH4HYADgnJyUvF00psIVf3SfrCaSXz4otz/maqIoQdt/O3ejmLM8MWFbPDhYNqsMhK1KcQ==
X-Received: by 2002:a17:902:ea95:b0:192:f4b0:a9ef with SMTP id x21-20020a170902ea9500b00192f4b0a9efmr11947744plb.32.1673637959099;
        Fri, 13 Jan 2023 11:25:59 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902ec8f00b001895d871c95sm14551789plg.70.2023.01.13.11.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:25:58 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: fix hang/crash with FT and roam scans
Date: Fri, 13 Jan 2023 11:25:57 -0800
Message-Id: <20230113192557.777947-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A user reported hangs and sometimes crashes when roaming. This is due
to FT being started without canceling/preventing another roam scan.
Then, while FT is in progress, the roam scan results come in and find
no candidates which triggers a disconnect mid-roam. This then causes
either station to never transition out of the roaming state, or in
some cases a crash.

Fix this in a few ways, first cancel the roam rearm timer when the
FT work starts. This will prevent any roam scans from occurring until
after the FT work finishes. And second don't end the FT work once
association starts and keep the work item open until after the roam.
---
 src/station.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index ad5ad724..cb0fd57c 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1999,6 +1999,9 @@ static void station_roamed(struct station *station)
 
 	l_queue_clear(station->roam_bss_list, l_free);
 
+	if (station->ft_work.id)
+		wiphy_radio_work_done(station->wiphy, station->ft_work.id);
+
 	station_enter_state(station, STATION_STATE_CONNECTED);
 }
 
@@ -2023,6 +2026,9 @@ static void station_roam_failed(struct station *station)
 
 	l_queue_clear(station->roam_bss_list, l_free);
 
+	if (station->ft_work.id)
+		wiphy_radio_work_done(station->wiphy, station->ft_work.id);
+
 	/*
 	 * If we attempted a reassociation or a fast transition, and ended up
 	 * here then we are now disconnected.
@@ -2263,7 +2269,8 @@ try_next:
 	station->preparing_roam = false;
 	station_enter_state(station, STATION_STATE_FT_ROAMING);
 
-	return true;
+	/* Keep the work item until after FT finishes */
+	return false;
 
 assoc_failed:
 	station_roam_failed(station);
@@ -2292,6 +2299,11 @@ static bool station_fast_transition(struct station *station,
 	vendor_ies = network_info_get_extra_ies(info, bss, &iov_elems);
 	handshake_state_set_vendor_ies(hs, vendor_ies, iov_elems);
 
+	if (station->roam_trigger_timeout) {
+		l_timeout_remove(station->roam_trigger_timeout);
+		station->roam_trigger_timeout = NULL;
+	}
+
 	/* Both ft_action/ft_authenticate will gate the associate work item */
 	if ((hs->mde[4] & 1))
 		ft_action(netdev_get_ifindex(station->netdev),
@@ -2747,7 +2759,8 @@ static bool station_cannot_roam(struct station *station)
 
 	return disabled || station->preparing_roam ||
 				station->state == STATION_STATE_ROAMING ||
-				station->state == STATION_STATE_FT_ROAMING;
+				station->state == STATION_STATE_FT_ROAMING ||
+				station->ft_work.id;
 }
 
 #define WNM_REQUEST_MODE_PREFERRED_CANDIDATE_LIST	(1 << 0)
-- 
2.34.3

