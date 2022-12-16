Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6493128F3
	for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 17:26:22 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso6815714pjt.0
        for <iwd@lists.linux.dev>; Fri, 16 Dec 2022 09:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTDdI4aYLss09n2Vx+1DB4AKeW+kEyCe6GmYOQFENm4=;
        b=NEsF+ipdZsSTEj3U9XMlDBeCzzPjJZpyIhIPNfnqpTuQW/NQdSL2/QjKqG2w79nDPv
         wYnCVyXa0OyQ3hOAbTVCX76xoCChEnhwzkVnnTgnnD7zgTzm5GsgjUlGzPXkmng/O6m/
         Ulo/yd6W5HqPds3KzTGRvL097EIJrIfhVA1osYorgc4ikFZcv1C4OhGOflcURII/goSO
         IeO1YinlNoEXoDdln4zt+LCmz5UNs0ytoI5n0IGiCskCDYE2fliDvidYaTcoRn2Qy3P3
         0EN7CyV7gx4za/l42KuxY+Ui8u46JKxRJuzsoLvC61pkg6F7IlAGwumUTF8Fro003erq
         GGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTDdI4aYLss09n2Vx+1DB4AKeW+kEyCe6GmYOQFENm4=;
        b=Fy9hA2x3MhIGQhq5sFvPOgdaPwwDL8dd8V8Xoqscf6AfvtdWDgA1eG+vgAH26N7M06
         OqcIEDTyO3kgQpGIiU7mNacdDzgGsaj6oP7RTHypdNTGmVEM5Y9mWs9hWhV+TZEdampi
         FSXM2vNRE8GqPRrAEA9frumyTLTwZlQWJgsLgxE3oaFf0oC9P14OXBfzXV1suCuweOzB
         /XiHdeBGHkxcRb29DlQLfprNXY1J5caRN6Gq5H5Yp7SdHj2eA5jwW94MryHhicu8lCwW
         iV27Cw/AbY1hBKmwHk3V3FGF0lETLCOe32UsCEiNxcY9HykDrGEcCsuipoj11kDZDz2N
         1yvA==
X-Gm-Message-State: ANoB5pkfo5YMOYctJbuVSqQme9RvJ67xOstWYBXWJUbRv3m2WmkX4eTJ
	AhYlx0feDxP2YO8WSFTYXt1mu2ZRjds=
X-Google-Smtp-Source: AA0mqf6Q3NQJbWuHOL2IitODN5lfYKbquFJxz1muMmvTa8UyWoWXiVSqEvX20/8TVSGBvPzhCOBZaA==
X-Received: by 2002:a17:902:9b84:b0:189:38a1:8c04 with SMTP id y4-20020a1709029b8400b0018938a18c04mr32436597plp.50.1671211581666;
        Fri, 16 Dec 2022 09:26:21 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902da8500b00188fdae6e0esm1913636plx.44.2022.12.16.09.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 09:26:21 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/8] wiphy: don't parse dumps from unregistered wiphy's
Date: Fri, 16 Dec 2022 09:26:02 -0800
Message-Id: <20221216172606.1799396-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221216172606.1799396-1-prestwoj@gmail.com>
References: <20221216172606.1799396-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no reason to parse these since IWD won't use them.
---
 src/wiphy.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index 3777bd58..f3a2a039 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -2015,6 +2015,10 @@ static void wiphy_dump_callback(struct l_genl_msg *msg,
 	if (L_WARN_ON(!wiphy))
 		return;
 
+	/* Unregistered means the wiphy is blacklisted, don't bother parsing */
+	if (!wiphy->registered)
+		return;
+
 	while (l_genl_attr_next(&bands, &type, NULL, NULL)) {
 		switch (type) {
 		case NL80211_BAND_2GHZ:
-- 
2.34.3

