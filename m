Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2231D0E13
	for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708164; cv=none; b=Yvf0FLJ4/fVHxF7jBp49Rqnf8Y4Is/3Wbr8l330UkZu20G7xxYnxa2gQZqKVjBXp+ITFpFiqc7YcuLmcDPPxf1O0BLV65FbtdUM2dFwhaV+qeWlF/uqCk0RMGjmy6eHqzvH5zuIUUnDr6srLfn7l5EYBLr6+pmRavsniGxOD/co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708164; c=relaxed/simple;
	bh=hUc3JMsSH9MJrzBwRge9tDni+5tOZDKc6AHr4/PuXJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l90WZ54PEhgHaWe9LpN9wcrJ925qijNLHMHX08BsH9DSvr+vcOH/wFsBQZhIkvEA8Q299vfqUYBjBr9h4+BOn8MDFgTIaepUidjoIbMtASumMS3JTltK0Kwf2otN1tBE1U2HynYTlMpl255JIXN97dY3KMrs2y10tTfvH8HMhjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcOJRn/l; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcOJRn/l"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea12e0dc7aso51753a12.3
        for <iwd@lists.linux.dev>; Wed, 23 Oct 2024 11:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729708162; x=1730312962; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aP1EsuKzBrfHY7uwCOVu6kTse0CaJzkRX4cZQ4vWMmY=;
        b=AcOJRn/lKNfc6HeTfnHeYLIGaWSmK+MAs2DzUEAD02RSDlzMw0A3VjP04plQubXEcr
         WpY26rMUKmsGTY9cbMdwgf9h+ZjoXYwdj3ppdYd+5FhB+7v6A4v+XV6Zd7TaoxrCaLeg
         fQWFPNacRwVRdDyBTOAMkDEiRFftR/iMUf20GUhIitZvC/ZzmzJS4h4+Jq7RrChvxiZQ
         rENaUVyO0FSGC1oyP5tr20LvHvtSXia8GgS6okkz1s2EAki95Pnw71TQFUkqnAhl/I+/
         Wkp9jWSKZ0a08MeQH0VdCGT74dfhI/liM9Gxt2R2BE+438A+ho0sfYFy8lv0Qxoyaa84
         NDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729708162; x=1730312962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aP1EsuKzBrfHY7uwCOVu6kTse0CaJzkRX4cZQ4vWMmY=;
        b=OqR+dHqebJVflQnORWAG2lVvhjCuUMIY+vx7N5i9jWBKQM5fkuOueF8GFWNJ2AXEi7
         LssjJwRHQpDhQAGFP4HsmGlM4DNBVPNzvTVqmssSRYIOZjIRffHgS3VhdhdQfRWC0BOi
         z2SxI4dn6A9LamQTGybLOuMBS1ShADK13hqqXFq04r+7FnDwqbKqw3WfJ5vCO6NErlJO
         KSSUVCruD2Y/Ck8J32gFi36/EQSgTTftZb6u3OoYnhh1VPa68vU7/jooeESIDMeIgkZd
         BaEkf+i6WgxacS4my3N2RmhPo2+lK/JEA6z73g5oDSyCcLwmCpjPn2NilodqTsDLhW84
         k63g==
X-Gm-Message-State: AOJu0YyPri9BOPaO9B3i/0gWIl4ASpnXqlA6K7oLf0XN7rIcZZNebpdh
	EOHRIMZo/YVgYO3FRvLYOKJ4zFMCrLyleYpNFPuQhMZX9x2q/1m4cGcC45dN
X-Google-Smtp-Source: AGHT+IGp+JwKcN1W/SmMPIm/pSvTCzRfHIYjzdg0V/L7aAydrZGhW8zjAxArQQ/pE1G/WB7ja1v/7Q==
X-Received: by 2002:a05:6a20:438e:b0:1d9:6d08:4b43 with SMTP id adf61e73a8af0-1d978b37d6cmr4400169637.22.1729708162437;
        Wed, 23 Oct 2024 11:29:22 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabc11a7sm7024871a12.60.2024.10.23.11.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 11:29:22 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/4] network: fix OWE transition BSS selection
Date: Wed, 23 Oct 2024 11:29:11 -0700
Message-Id: <20241023182912.128388-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023182912.128388-1-prestwoj@gmail.com>
References: <20241023182912.128388-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The selection loop was choosing an initial candidate purely for
use of the "fallback_to_blacklist" flag. But we have a similar
case with OWE transitional networks where we avoid the legacy
open network in preference for OWE:

/* Don't want to connect to the Open BSS if possible */
if (!bss->rsne)
	continue;

If no OWE network gets selected we may iterate all BSS's and end
the loop, which then returns NULL.

To fix this move the blacklist check earlier and still ignore any
BSS's in the blacklist. Also add a new flag in the selection loop
indicating an open network was skipped. If we then exhaust all
other BSS's we can return this candidate.
---
 src/network.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

v2:
 - Fixed issue where the loop returned the first candidate, not
   the actual BSS that its currently checking.

diff --git a/src/network.c b/src/network.c
index 5a856fb4..cd8b0ee9 100644
--- a/src/network.c
+++ b/src/network.c
@@ -1281,6 +1281,7 @@ struct scan_bss *network_bss_select(struct network *network,
 	struct l_queue *bss_list = network->bss_list;
 	const struct l_queue_entry *bss_entry;
 	struct scan_bss *candidate = NULL;
+	bool skipped_open = false;
 
 	for (bss_entry = l_queue_get_entries(bss_list); bss_entry;
 			bss_entry = bss_entry->next) {
@@ -1300,30 +1301,34 @@ struct scan_bss *network_bss_select(struct network *network,
 		if (!candidate)
 			candidate = bss;
 
+		/* check if temporarily blacklisted */
+		if (l_queue_find(network->blacklist, match_bss, bss))
+			continue;
+
+		if (blacklist_contains_bss(bss->addr))
+			continue;
+
 		/* OWE Transition BSS */
 		if (bss->owe_trans) {
 			/* Don't want to connect to the Open BSS if possible */
-			if (!bss->rsne)
+			if (!bss->rsne) {
+				skipped_open = true;
 				continue;
+			}
 
 			/* Candidate is not OWE, set this as new candidate */
 			if (!(candidate->owe_trans && candidate->rsne))
 				candidate = bss;
 		}
 
-		/* check if temporarily blacklisted */
-		if (l_queue_find(network->blacklist, match_bss, bss))
-			continue;
-
-		if (!blacklist_contains_bss(bss->addr))
-			return bss;
+		return bss;
 	}
 
 	/*
 	 * No BSS was found, but if we are falling back to blacklisted BSS's we
 	 * can just use the first connectable candidate found above.
 	 */
-	if (fallback_to_blacklist)
+	if (fallback_to_blacklist || skipped_open)
 		return candidate;
 
 	return NULL;
-- 
2.34.1

