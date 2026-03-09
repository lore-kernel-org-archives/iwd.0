Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C403E3DA6
	for <iwd@lists.linux.dev>; Mon,  9 Mar 2026 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075475; cv=none; b=S51pHIrPN5a/Xk6Sh6WnwbKGziZ0s08jI52jPuTXoAP4R13UZCrW0aU8ue5Oawf3GOFYGEHfY6WfdHyH33vKB3d2RU5oUDl7gWxlokeSSYsVmwEKk+21TudwXt0n1a1Mn51oGdvnBt7p42WaEM1hcvL/SKRoEstCBzc9/o3SxE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075475; c=relaxed/simple;
	bh=Y0rK1l+ekPCmNZRrhGrR6tQ7F4yu/qKzraN2nbGxses=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EvFOPQirD44Cfj0cSpPOLceJvhSFyXU8j55yv78UaS2oiQIYve0xUXPuz9LybJrZ2XJJQ9rSN1pY51vKqrC4xlaWBgiZ8/+1wjbOdwDsStWO4OBG0VDgwbpTKHGugIOt2ru8mDUmUwaptUhmjA8MrHJOy9W8mzszj8tIAx44hLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCnCGYuJ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCnCGYuJ"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-89a1347051aso117979676d6.2
        for <iwd@lists.linux.dev>; Mon, 09 Mar 2026 09:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773075472; x=1773680272; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CJtL3/aW5oPZECcTFYDga0XtTW1LkgEvuLDXiGBWWg0=;
        b=DCnCGYuJzq3Jh3oNlZljUy5kvlr6O8jjpXtqmRZY8uKvr2+MVZBlln16N96DfuB+xR
         O598iMbX9HlWIB/RF4UXeBbJ31OgqzqG1vqCXrcnmnwkbUngKjMNUV2lV4f/uylpE1W2
         XeCw25E9NmJymUEU969faxsgShpMNuU/YjeSYEQnkllXTUfgK3zdfw9pW0Fir5UZCHg9
         gG9PJJrhZowojZAPk2L6Obg4VoeEpEqacNAxTlJj3WLyFoGbp8eJrJ1qOufGmRQ03yFr
         +wyejBuwxRMnRMU8KbG9IO74JEYR8GTdKmMZqGPv1/NKHcyLbv0RZYHOEUb6IXxOkep7
         sWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773075472; x=1773680272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJtL3/aW5oPZECcTFYDga0XtTW1LkgEvuLDXiGBWWg0=;
        b=YDFgtm8+AtXdWX2EjjK2ZH6Q7Q1fZVw9S/xsjCgH/t3am6iRyVcpA63Wvvok8aq+2O
         axdfjUh1EeRecqTOW3zVC0fNeNsquUdZBWxHQZVtTY+xU6C9FtZzQ8fawvhJabobB/vl
         XQo59ST3YLujcCa5H5gdOqnNFbeo8WHixt/L+aCglrYppaz9smEt4RoujrHjhphXVZaY
         E2OjVcVJbSgI+srUGuE4aCRUel/smGtMS3tCP7a9BwX3nHsNVDMBZM2hDlRXrAmEkWtY
         9O/SY1/xdQpDds8N1ex8JykaOIqr9DzJ7e1FFYK78mGo2/B0uFZuVem+Uye3vBVyF9Wy
         CO9w==
X-Gm-Message-State: AOJu0Yxt/AEgh847CqlLuQWUbTH4TGIc5/GdrRdby1ScIkPCU9MXe5To
	2r11b6Z4Z1zKDuWZRtLgqiFilfrv/FvlvQS6khc99jqEUdfagXs3UJv43W88RA==
X-Gm-Gg: ATEYQzysjnmlNL4jnpzKEHtT0cI/XZfLdfRfk+dh3aU9PNVKTfqpeI+8Jn+WcClqobg
	nddGgoDudJeFdB1BkuWLlxyIsbLNVR70viEOPVS27fi/deshd5ObPr/2+G6lWooKO1VLP2xBBP+
	leFLq/XF5DlvcIhX4lQlf3kpm5rWm2CT9lVPQ6buA+1BA6/1iVa4tmCAfbfbAGZzLb5845p8M1a
	abD3J07ZM41KDjTYcU94T0IQoX43HGqYo6CfS4DPreVHm7sH9MA4kwwL6UHMKFxcA13uStIfpHo
	VzeTR9lsi7GnNQDqRNwseaDmPX5wC0OvamWAoLtjCdOkCRKnWW5hWS31EwvM/R/6bQnFDCTeNax
	rph2eql4TTKvpZTiy3IrtP0nIiWr/3RE69t8uQ0C2t5zfdrKr5GhXsm+JY9lUuhMMCw2d7UcM+M
	RTXS75BHRXKF02SRMObUuzcQ1JzsiArrz+Fb6z09xkE6Rvxvz74eu8TPFzcB5vbQoM
X-Received: by 2002:a05:6214:c22:b0:899:e621:eacd with SMTP id 6a1803df08f44-89a30ad6d8cmr172848316d6.36.1773075471929;
        Mon, 09 Mar 2026 09:57:51 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57a4b079sm1704576d6.20.2026.03.09.09.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 09:57:51 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 1/4] station: check return of handshake_state_set_pmksa
Date: Mon,  9 Mar 2026 09:57:43 -0700
Message-Id: <20260309165746.2073055-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If this fails num_pmkids and pmkids would get set, but to an
uninitialized buffer. This would then fail to build the handshake
object later when copying the PMKID.
---
 src/station.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/station.c b/src/station.c
index 50997f5f..fdd4cda5 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1378,9 +1378,10 @@ build_ie:
 					bss->ssid, bss->ssid_len,
 					info.akm_suites);
 		if (pmksa) {
-			handshake_state_set_pmksa(hs, pmksa);
-			info.num_pmkids = 1;
-			info.pmkids = hs->pmksa->pmkid;
+			if (!L_WARN_ON(!handshake_state_set_pmksa(hs, pmksa))) {
+				info.num_pmkids = 1;
+				info.pmkids = hs->pmksa->pmkid;
+			}
 		}
 	}
 
-- 
2.34.1

