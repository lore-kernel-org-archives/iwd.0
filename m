Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427596D24
	for <iwd@lists.linux.dev>; Fri,  9 Dec 2022 19:39:36 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id 140so4417971pfz.6
        for <iwd@lists.linux.dev>; Fri, 09 Dec 2022 11:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oknN9XbsJoZfrfTSDS2nOf8nWEcwLa9Ow+jWh9j7gYU=;
        b=dj7O5P1DCzjCTPCeZiASfMGQJ+IQpz+hFXtBL7/1AaAPhY82qFlF0Um24ldY2sJ1ae
         k0e0xa3CGdDFS5muYnk78A64z+bp+5XDfjiakdqoebOnt/PVy6qrY5bv49JV4oudPU6L
         +Ujm+HAUo0cwCPKBSOBpwyv3G1gbmHK/4JSv+kZaVQ67CFPkrNDQ/3i86jNXqecOLt9u
         7DJ4/S3ZiP031oG6qaSVTjb1lW5weNI/nic4flUwozBYq2Ltklmxg8wcVMy3VANV6hBx
         AMdaWCTa/7HkDhFjPSD5EgS6koHQqzMH33mDRzoIYFVLjyjftUYdVPLn+e+QI/rFLuoy
         Y6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oknN9XbsJoZfrfTSDS2nOf8nWEcwLa9Ow+jWh9j7gYU=;
        b=eHE4JCr9Eyjh5N6rnLwLr6j1Y/kh+hbAMS0ejduuF7WLY2V+54e+ZKMCwtyBOf/mj6
         404tbni4pjtsuuL/pzybnSFPrnXtZ3C5TIP5DXmkhj8cvymqloYF3dLBwr/nqWHvh4/L
         xw29qgrHCj2jtgLQDmv/7H/V/GSmUXQEqpzVARriayXfqk5L6wUZyrmqOCsK+fzmJyf+
         BQea9+JilR8oASzPTTMhKnk+Rj9Jqag9KDiQEpW8hYd56JONI4ZUylIzaMTJN8VVg+LL
         zcNN/Vu111q3pM0i3gXYFAjrRn1mRtT1lBgFTxLE6rTDnNpQLtSOkRqvbrKXzW7D2AyC
         j7Yw==
X-Gm-Message-State: ANoB5pnWIDRLkBO54QQY6aTeLvzIkehWBift16cD80Ak2bKKvIAaHZXM
	ikZcWPpAEKRsXDFeORm4vLOrzkZBEMo=
X-Google-Smtp-Source: AA0mqf7Ia718dXl8ZnklU3BlyB9vYdilf3/Owtqe0Zn4poQvqAHyhdp9ut1ZV2BD7n7modaNxJsNmg==
X-Received: by 2002:a62:ed03:0:b0:56b:9b71:ca2f with SMTP id u3-20020a62ed03000000b0056b9b71ca2fmr5959058pfh.11.1670614775629;
        Fri, 09 Dec 2022 11:39:35 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id x28-20020aa78f1c000000b0056bc5ad4862sm1587638pfr.28.2022.12.09.11.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 11:39:35 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 3/4] ap: select rates from hardware capabilities
Date: Fri,  9 Dec 2022 11:39:29 -0800
Message-Id: <20221209193930.845238-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221209193930.845238-1-prestwoj@gmail.com>
References: <20221209193930.845238-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than a list of static rates, choose what the hardware
advertises. For the case of CCK rates only include rates 11mbps
or lower.
---
 src/ap.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/src/ap.c b/src/ap.c
index 72951320..32d9e1c4 100644
--- a/src/ap.c
+++ b/src/ap.c
@@ -3438,6 +3438,9 @@ struct ap_state *ap_start(struct netdev *netdev, struct l_settings *config,
 	uint64_t wdev_id = netdev_get_wdev_id(netdev);
 	int err;
 	bool cck_rates = true;
+	const uint8_t *rates;
+	unsigned int num_rates;
+	unsigned int i;
 
 	if (L_WARN_ON(!config)) {
 		if (err_out)
@@ -3463,22 +3466,17 @@ struct ap_state *ap_start(struct netdev *netdev, struct l_settings *config,
 
 	wsc_uuid_from_addr(netdev_get_address(netdev), ap->wsc_uuid_r);
 
+	rates = wiphy_get_supported_rates(wiphy, ap->band, &num_rates);
+	if (!rates)
+		goto error;
+
 	ap->rates = l_uintset_new(200);
 
-	/* TODO: Pick from actual supported rates */
-	if (!cck_rates) {
-		l_uintset_put(ap->rates, 12); /* 6 Mbps*/
-		l_uintset_put(ap->rates, 18); /* 9 Mbps*/
-		l_uintset_put(ap->rates, 24); /* 12 Mbps*/
-		l_uintset_put(ap->rates, 36); /* 18 Mbps*/
-		l_uintset_put(ap->rates, 48); /* 24 Mbps*/
-		l_uintset_put(ap->rates, 72); /* 36 Mbps*/
-		l_uintset_put(ap->rates, 96); /* 48 Mbps*/
-		l_uintset_put(ap->rates, 108); /* 54 Mbps*/
-	} else {
-		l_uintset_put(ap->rates, 2); /* 1 Mbps*/
-		l_uintset_put(ap->rates, 11); /* 5.5 Mbps*/
-		l_uintset_put(ap->rates, 22); /* 11 Mbps*/
+	for (i = 0; i < num_rates; i++) {
+		if (cck_rates && !L_IN_SET(rates[i], 2, 4, 11, 22))
+			continue;
+
+		l_uintset_put(ap->rates, rates[i]);
 	}
 
 	if (!frame_watch_add(wdev_id, 0, 0x0000 |
-- 
2.34.3

