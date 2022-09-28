Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A5281F
	for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 16:36:41 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id r8-20020a17090a560800b00205eaaba073so2169782pjf.1
        for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 09:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Lf/Sq4Zhn844p9dx0dFvi3fLZvsVq7BikkxvwICxJ2M=;
        b=M4X9/TMtmr09/GAtdNjj4l+o4xm3WjEgw0y6PC7/dVLMpRwnI+7pUew/UOSG1BT+wb
         TGxMZuf/hFmsElOmLL4N7lZTIU/7HAHeGWu51iNSfv+OhGl6VdBCn4fah27sPHccWwIF
         tCsLZqKvl8x8LVBl5kvlF10pyrhXeO1no8KXfNEjqHOxupB3mGtdt2VoGg25f8f4Y3DO
         7V3eW4L8cFOovNbLj7RoAIjyh1RK55kMQIqWFuJ+Nl8UMb2t9dk6N4WhhIWZTwCGkkJX
         uVIJsslYyG9OZ6RZYz7zZRgR54UcXIH2lK5xtxcw0kpno0q5HIWtwdCzXtbs6hdUF0Hn
         hW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Lf/Sq4Zhn844p9dx0dFvi3fLZvsVq7BikkxvwICxJ2M=;
        b=gJ2G6HLbHmeWGNzhWJBpwJwUViCh+vU2Lq7h3HB569Ul5Weqq24t0iqQhewcXeA8EU
         IIFr6JhYFZJIXbc4/oUWB4zLvWPgLf88JV1+jbHwAVXMCisNp+zVmDUi13N6RECs/zVc
         wtSfF1t0A5kEiv3MapMXfu1hYYfdIASMG0E8dUcZR0euLKa4kkdlPJ8lAN1cwBZYkash
         RbZrr2aikTG+02n4QWiN6XzFJgjEGB+VQDs6JMGGKMJaObPKfDqUeG2zmuJC8VQxJHS2
         SDsEscNnguXvvyE8ehd/5c3Xde5JzqLSYfDtflZ6pZyhKDoR+35cvJtRUhIqVMHYXx4R
         EX5Q==
X-Gm-Message-State: ACrzQf0Ox+ladMHHlxfq6oUd8jO7yV6Kr+alv1TCOhYhw3/aMMqOqf1R
	SIWSgTnjGsL/8XevffaG/YJCg0diI90=
X-Google-Smtp-Source: AMsMyM52RA+a9Zz+GgmcK01mCeEpzk91FKE7wxnuYsT6cdgNiOtU1A12mpByuTdaKqtyh680X0+6Cg==
X-Received: by 2002:a17:902:9a8b:b0:17a:455:d967 with SMTP id w11-20020a1709029a8b00b0017a0455d967mr658362plp.52.1664383000714;
        Wed, 28 Sep 2022 09:36:40 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id lb12-20020a17090b4a4c00b00205fafa6768sm661184pjb.6.2022.09.28.09.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 09:36:40 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/6] station: reorder AP roam logic
Date: Wed, 28 Sep 2022 09:36:32 -0700
Message-Id: <20220928163637.344656-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are a few checks that can be done prior to parsing the
request, in addition the explicit check for preparing_roam was
removed since this is taken care of by station_cannot_roam().
---
 src/station.c | 55 +++++++++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/src/station.c b/src/station.c
index 4e07ef19..061e8747 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2763,6 +2763,31 @@ static void station_ap_directed_roam(struct station *station,
 	if (station_cannot_roam(station))
 		return;
 
+	if (station->state != STATION_STATE_CONNECTED) {
+		l_debug("roam: unexpected AP directed roam -- ignore");
+		return;
+	}
+
+	/*
+	 * Sanitize the frame to check that it is from our current AP.
+	 *
+	 * 802.11-2020 Section 9.3.3.1 about Address2:
+	 * "If the STA is an AP with dot11MultiBSSDImplemented set to false,
+	 * then this address is the BSSID."
+	 *
+	 * Address3:
+	 * "If the STA is an AP or PCP, the Address 3 field is the same as the
+	 * Address 2 field."
+	 *
+	 * For now check that Address2 & Address3 is the same as the connected
+	 * BSS address.
+	 */
+	if (memcmp(hdr->address_2, station->connected_bss, ETH_ALEN) ||
+			memcmp(hdr->address_2, hdr->address_3, ETH_ALEN)) {
+		l_debug("roam: AP directed roam not from our AP -- ignore");
+		return;
+	}
+
 	if (body_len < 7)
 		goto format_error;
 
@@ -2816,36 +2841,6 @@ static void station_ap_directed_roam(struct station *station,
 		pos += url_len;
 	}
 
-	if (station->state != STATION_STATE_CONNECTED) {
-		l_debug("roam: unexpected AP directed roam -- ignore");
-		return;
-	}
-
-	/*
-	 * Sanitize the frame to check that it is from our current AP.
-	 *
-	 * 802.11-2020 Section 9.3.3.1 about Address2:
-	 * "If the STA is an AP with dot11MultiBSSDImplemented set to false,
-	 * then this address is the BSSID."
-	 *
-	 * Address3:
-	 * "If the STA is an AP or PCP, the Address 3 field is the same as the
-	 * Address 2 field."
-	 *
-	 * For now check that Address2 & Address3 is the same as the connected
-	 * BSS address.
-	 */
-	if (memcmp(hdr->address_2, station->connected_bss, ETH_ALEN) ||
-			memcmp(hdr->address_2, hdr->address_3, ETH_ALEN)) {
-		l_debug("roam: AP directed roam not from our AP -- ignore");
-		return;
-	}
-
-	if (station->preparing_roam) {
-		l_debug("roam: roam attempt already in progress -- ignore");
-		return;
-	}
-
 	station->ap_directed_roaming = true;
 	station->preparing_roam = true;
 
-- 
2.34.3

