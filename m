Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A1646AB
	for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 16:36:42 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id l65so12981775pfl.8
        for <iwd@lists.linux.dev>; Wed, 28 Sep 2022 09:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=daoyJskCorBwtjTefK4kh/+BP86K5/WFluk80efkMnU=;
        b=ZiVEsB82xMVHfAzuAQCiJ9iryovNU3osY+fy82Lwdp0zUVq9fHAOaZY/Ue6KacVkPu
         nu2OIsRbEzn6HpDw4H9NGd37Y06mAfymBEiYqtkDmcqRgOf2xwqQOWQzt8fQZLElg2op
         riD9pk42NcjUd2Cx1PqbvxOxmnJNNEpuIJZ+BdcXHSSQOL3qUfd3vbUD4HETYXxB2FD0
         ftQdOV1PiEhtvASBHH5v7e8llwqKWSdh/SEG0W/ZmuEgJd8qzqi9Aa2OEjlNawaPc6QX
         yNfTYgUgysg66lU8Hi+FzWsUifJT3aSTVlH01ygJarj9i7CBJKqsW8T9XfeDUe4jXkki
         wrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=daoyJskCorBwtjTefK4kh/+BP86K5/WFluk80efkMnU=;
        b=XcozHWwaTMv8w/Q4LDF2AAsuH0ngKWp71VEz0f4svm3Y1GurAY50ZklNisC3NXqfFv
         6AVnXO8F4wI3PcCjCihcLOc73ub+LiEV7VAeSrdq56NK+QhiRG5HK0pZkMr4LT2XskOB
         amyRB+Ya03sgaR/zi/wAsXrAlmB1ku3McmVsA38NouKdDOKIQV9s0+4dkiBmghVxfUaX
         aUr5wu+ab0kuF7RqAjMcg/MWH8zKj20JI9nEjDJXTVJoiPaI2wbffZY+xQ4UOYJkn3xc
         aLTxkyaSlyHGJGJdzN3wmSJd+OtTmOrTLUGDL5ldMaAQK1oUBXUka7HYbTKIGmMJL5ng
         DPfw==
X-Gm-Message-State: ACrzQf06594ePZpO4Dzv/XRB/J9lRIYpSWTH6EWi3O0ZTEyI7LEqyLnP
	3IfH5Pz+zfGfZXvlSJtBzX1OyU2MPGA=
X-Google-Smtp-Source: AMsMyM6HNx2PpdiPsCvcw/2VTPmSoM3iGjSgsh/uE/sNjteHCr3GgYZAsYIaZqtsWMf5AP9HHtI+fQ==
X-Received: by 2002:a63:1a04:0:b0:42b:d33a:2613 with SMTP id a4-20020a631a04000000b0042bd33a2613mr29132928pga.429.1664383001818;
        Wed, 28 Sep 2022 09:36:41 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id lb12-20020a17090b4a4c00b00205fafa6768sm661184pjb.6.2022.09.28.09.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 09:36:41 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/6] station: check disassociation bits for AP roaming
Date: Wed, 28 Sep 2022 09:36:34 -0700
Message-Id: <20220928163637.344656-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220928163637.344656-1-prestwoj@gmail.com>
References: <20220928163637.344656-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AP roaming was structured such that any AP roam request would
force IWD to roam (assuming BSS's were found in scan results).
This isn't always the best behavior since IWD may be connected
to the best BSS in range.

Only force a roam if the AP includes one of the 3 disassociation/
termination bits. Otherwise attempt to roam but don't set the
ap_directed_roaming flag which will allows IWD to stay with the
current BSS if no better candidates are found.
---
 src/station.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index 061e8747..2ae8a6bf 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2746,6 +2746,7 @@ static bool station_cannot_roam(struct station *station)
 }
 
 #define WNM_REQUEST_MODE_PREFERRED_CANDIDATE_LIST	(1 << 0)
+#define WNM_REQUEST_MODE_DISASSOCIATION_IMMINENT	(1 << 2)
 #define WNM_REQUEST_MODE_TERMINATION_IMMINENT		(1 << 3)
 #define WNM_REQUEST_MODE_ESS_DISASSOCIATION_IMMINENT	(1 << 4)
 
@@ -2818,7 +2819,20 @@ static void station_ap_directed_roam(struct station *station,
 			dtimer, valid_interval,
 			MAC_STR(hdr->address_3));
 
-	/* check req_mode for optional values */
+	/*
+	 * The ap_directed_roaming flag forces IWD to roam if there are any
+	 * candidates, even if they are worse than the current BSS. This isn't
+	 * always a good idea since we may be associated to the best BSS. Where
+	 * this does matter is if the AP indicates its going down or will be
+	 * disassociating us. If either of these bits are set, set the
+	 * ap_directed_roaming flag. Otherwise still try roaming but don't
+	 * treat it any different than a normal roam.
+	 */
+	if (req_mode & (WNM_REQUEST_MODE_DISASSOCIATION_IMMINENT |
+			WNM_REQUEST_MODE_TERMINATION_IMMINENT |
+			WNM_REQUEST_MODE_ESS_DISASSOCIATION_IMMINENT))
+		station->ap_directed_roaming = true;
+
 	if (req_mode & WNM_REQUEST_MODE_TERMINATION_IMMINENT) {
 		if (pos + 12 > body_len)
 			goto format_error;
@@ -2841,7 +2855,6 @@ static void station_ap_directed_roam(struct station *station,
 		pos += url_len;
 	}
 
-	station->ap_directed_roaming = true;
 	station->preparing_roam = true;
 
 	l_timeout_remove(station->roam_trigger_timeout);
-- 
2.34.3

