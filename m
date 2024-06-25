Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FF11DFC5
	for <iwd@lists.linux.dev>; Tue, 25 Jun 2024 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320802; cv=none; b=L7aNOhUi1oOvLeN0tnf93/iGXh3PGvMgKBAZb/sgGaXRV6KSLFfpyF2VNqwGoiisjb2jMP3xcL4vKI2n/Wyqxaw7yF5gvWCry/Ves3aK121HG6IQDdvzowy6xqhZC0ZV0EUftvSL6/1z9EqrS/OHqQTZZh8fzwPIuQzMbPoxb/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320802; c=relaxed/simple;
	bh=RCaWVQcR9A7imwYjqT8S60TtbVUlnoG2+25cuKluqgg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=df/11BDVuEMV7ucgaHod/dfR79yX/89+Pqt3LmphtFzEVXn68Gq+WFTDBYxb4P6ahSge30iCE9pnDqtaNH7Q5zY9Q+Cv+KVSNJDzMCuz/1vyUwPv7fpEQeMtCLNjuzEmmF/7os9zBYEvynqwE4rzGe1iN3gEorJjNo4pRcbbs4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B52gwPkb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B52gwPkb"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f9b523a15cso39335905ad.0
        for <iwd@lists.linux.dev>; Tue, 25 Jun 2024 06:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719320800; x=1719925600; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fs2IB9eeSxruGP/2upHGcxD2i9Ylwf0yAcwE+BbQGhU=;
        b=B52gwPkboJjZA48CsaxFpaPOxTUZgYtPOS84MibYmOcjaTEVz5CqVAmpmAIgN5e4RQ
         lgvs7vsVl7HpGjt0eLXHNSlSFRSs0hC3Hucb4+/041nV8Hrldn8JxIV8eWMBMvkDCotf
         sqN7uc8FU1yrxM00DUTMCVOICH+299LEvehZFFgfGeb3tqBSFRVhJf7+qzXEMZ7dJPgW
         IbzM35GPolMoYIH+/lmI1nyfqeadwpca44WzIxOHwItIoI0E1urHGVCeBegORD21jSft
         DZRRum4SP4IOiKzimtCAv374OwWUWKmKGDSXocVRdmg8HPdbPswmkA4EcwGASd4syh3w
         nVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719320800; x=1719925600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fs2IB9eeSxruGP/2upHGcxD2i9Ylwf0yAcwE+BbQGhU=;
        b=IsTIQYXChRAAS2rs2WfTFd+dknueen55wHNPbpEFFzGdkLe3MG5eDc0JLRS3f8Zely
         G5+K/qWHDdn9rUfgxgIeEvaMo05BNNW0/nrBxx5hjWSfLaHqaqEzLxuxWUREP6JNwT3m
         CGnod8WXQquPwenziJYAwzZVLUVqLnvOB3dQj/DghC915sX7p17XDbq7pfEdTqcRzyLd
         Q7Is1zCSmycfUXPp2J/KlDt8PTUNrWV4Xppsr0RVF8AWBdWehzAjErKpGtMnbqEd9NY1
         CTi0U9T7EoYmCt/08T6akxYFcF9UcihkTN1+y4J8LJbvnEEGQ7llzBU+dJJkvipdY9zj
         Vpcg==
X-Gm-Message-State: AOJu0YwbU1qHNyoHxJuNFaSkqtrXpkxYm3eYnKOgE5HSqrhOsQYuOZDj
	FgrCRxrNk8egXRUTRbYl/in6ZwGABhTsmlAygvspkBih9iu/ICL4R4xOTg==
X-Google-Smtp-Source: AGHT+IH1ZovZkbXzsnTe/KBFEpj6pBiq9Lt8zuLL84yhTSr1BuJqlcKbUUkTjJHlruLcu9c3EnD3QA==
X-Received: by 2002:a17:903:228b:b0:1f9:f6e6:5ada with SMTP id d9443c01a7336-1fa0fb04498mr118361715ad.22.1719320800252;
        Tue, 25 Jun 2024 06:06:40 -0700 (PDT)
Received: from LOCLAP699.localdomain ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d5bf2sm80778305ad.189.2024.06.25.06.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 06:06:39 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/7] netdev: use nl80211_parse_attrs for deauth event
Date: Tue, 25 Jun 2024 06:06:18 -0700
Message-Id: <20240625130624.385553-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Especially for parsing a single attribute, nl80211_parse_attrs
makes the most sense to use here.
---
 src/netdev.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 5b79d267..bada1ab5 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -1328,12 +1328,10 @@ static void netdev_cmd_disconnect_cb(struct l_genl_msg *msg, void *user_data)
 static void netdev_deauthenticate_event(struct l_genl_msg *msg,
 							struct netdev *netdev)
 {
-	struct l_genl_attr attr;
-	uint16_t type, len;
-	const void *data;
 	const struct mmpdu_header *hdr = NULL;
 	const struct mmpdu_deauthentication *deauth;
 	uint16_t reason_code;
+	struct iovec iov;
 
 	l_debug("");
 
@@ -1349,17 +1347,11 @@ static void netdev_deauthenticate_event(struct l_genl_msg *msg,
 	 * deauthenticating immediately afterwards
 	 */
 
-	if (L_WARN_ON(!l_genl_attr_init(&attr, msg)))
+	if (L_WARN_ON(nl80211_parse_attrs(msg, NL80211_ATTR_FRAME, &iov,
+						NL80211_ATTR_UNSPEC) < 0))
 		return;
 
-	while (l_genl_attr_next(&attr, &type, &len, &data)) {
-		switch (type) {
-		case NL80211_ATTR_FRAME:
-			hdr = mpdu_validate(data, len);
-			break;
-		}
-	}
-
+	hdr = mpdu_validate(iov.iov_base, iov.iov_len);
 	if (L_WARN_ON(!hdr))
 		return;
 
-- 
2.34.1

