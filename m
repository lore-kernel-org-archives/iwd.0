Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162954C9E
	for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 22:07:53 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id e5so19413215pfl.2
        for <iwd@lists.linux.dev>; Thu, 15 Sep 2022 15:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pyuSWfQ3D36lmHkDja8Lxuv11JcRxeiRkisYLL2DDOQ=;
        b=DNQStiwYPNNg8aCp74/gEjtSsS7h7k3gh7Zo+iK9CE8O2uPE5t79WPNx5OSNON5Gzy
         btV51qHOj5SRFEZfYgfjrNewWN2Bri4CmDKv9kU6mjuD99fpPybwSR/gY1YbmhvJ/fl+
         p3nTY6hsfXORmlmDDputc1l55gRsyy8Iied096DshCxcm2N2h9mqN7qYj3+K6X5JZjeK
         dadBgVFEnEjmyHb7dc/XQt5uH2xbmvzKMGofgBr6Gbk1+2pKA73VQqTreNq+QJISQNMx
         r8mBOBXp6wc3A3RSsPVs3SwHH0d0X1pmKQ7v5rrC/kr7VbkhfzbHrsax8RMhwN/6n9wj
         Qe9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pyuSWfQ3D36lmHkDja8Lxuv11JcRxeiRkisYLL2DDOQ=;
        b=NJfQoNqFTIilNea0Il0fGztSmHmn6qTAtqQBEVOTxkHH0+oGj2t1kPcvqHtIdqntTK
         hlKk5iI5M4DfDcSEiVLWbyMN7O26wauzawEc12ZKG5KA8snn1rqnyI2asljS7F0P7spI
         m7Mi0sdXBitoNveBah9l82IYOdRJsL00fA/2cGcvQuILYsf3z4c37DtkR9WGoCIiLhVa
         L0K7VT9WBr94a3/t+WiU4K22PutGFATGUH15MgE1/+4JZJfIM1pW6+uMjYkLSd1F/bDm
         4x8KVBlMcDBCJTxRzznhz9m7Z15fWnIr6mihZW7lTermFQ2uVAqv4j9My0Qv3iizOwBy
         MnqQ==
X-Gm-Message-State: ACrzQf0dYzOTIwNJad5rPhuSww+ouyskv4TvmhY0l/DycVhHH1Q30Asm
	WDOBUu9QorTKQByKmrIG6V6KR0kMZSE=
X-Google-Smtp-Source: AMsMyM6ff9/KdXjQeP1firmrH75tQ+uxhp4hu0nIms/IRs0ZznEfRddRsVUkWYzspt6iQ9MsUa9Row==
X-Received: by 2002:a62:7989:0:b0:541:e66c:c19a with SMTP id u131-20020a627989000000b00541e66cc19amr1961044pfc.24.1663279673377;
        Thu, 15 Sep 2022 15:07:53 -0700 (PDT)
Received: from jprestwo-xps.none ([50.54.173.139])
        by smtp.gmail.com with ESMTPSA id k2-20020a6555c2000000b0041c0c9c0072sm12147165pgs.64.2022.09.15.15.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 15:07:53 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 03/14] ft: remove OCI element from auth/assoc
Date: Thu, 15 Sep 2022 15:07:30 -0700
Message-Id: <20220915220741.1128728-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220915220741.1128728-1-prestwoj@gmail.com>
References: <20220915220741.1128728-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FT is moving to authentication via CMD_FRAME which breaks the ability
to get the OCI from the kernel (since its now an offchannel operation).
Using OCI during FT isn't that useful anyways, so its being removed.
---
 src/ft.c     | 26 ++------------------------
 src/ft.h     |  2 +-
 src/netdev.c |  3 +--
 3 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/src/ft.c b/src/ft.c
index 2285a86f..7ae78476 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -233,10 +233,6 @@ static int ft_tx_reassociate(struct ft_sm *ft)
 		rsn_info.num_pmkids = 1;
 		rsn_info.pmkids = hs->pmk_r1_name;
 
-		/* Always set OCVC false for FT-over-DS */
-		if (ft->over_ds)
-			rsn_info.ocvc = false;
-
 		rsne = alloca(256);
 		ie_build_rsne(&rsn_info, rsne);
 
@@ -276,22 +272,6 @@ static int ft_tx_reassociate(struct ft_sm *ft)
 		memcpy(ft_info.anonce, hs->anonce, 32);
 		memcpy(ft_info.snonce, hs->snonce, 32);
 
-		/*
-		 * IEEE 802.11-2020 Section 13.7.1 FT reassociation in an RSN
-		 *
-		 * "If dot11RSNAOperatingChannelValidationActivated is true and
-		 *  the FTO indicates OCVC capability, the target AP shall
-		 *  ensure that OCI subelement of the FTE matches by ensuring
-		 *  that all of the following are true:
-		 *      - OCI subelement is present
-		 *      - Channel information in the OCI matches current
-		 *        operating channel parameters (see 12.2.9)"
-		 */
-		if (hs->supplicant_ocvc && hs->chandef) {
-			oci_from_chandef(hs->chandef, ft_info.oci);
-			ft_info.oci_present = true;
-		}
-
 		fte = alloca(256);
 		ie_build_fast_bss_transition(&ft_info, kck_len, fte);
 
@@ -812,7 +792,7 @@ static bool ft_over_ds_start(struct auth_proto *ap)
 	return ft_tx_reassociate(ft) == 0;
 }
 
-bool ft_build_authenticate_ies(struct handshake_state *hs, bool ocvc,
+bool ft_build_authenticate_ies(struct handshake_state *hs,
 				const uint8_t *new_snonce, uint8_t *buf,
 				size_t *len)
 {
@@ -841,7 +821,6 @@ bool ft_build_authenticate_ies(struct handshake_state *hs, bool ocvc,
 
 		rsn_info.num_pmkids = 1;
 		rsn_info.pmkids = hs->pmk_r0_name;
-		rsn_info.ocvc = ocvc;
 
 		ie_build_rsne(&rsn_info, ptr);
 		ptr += ptr[1] + 2;
@@ -892,8 +871,7 @@ static bool ft_start(struct auth_proto *ap)
 	uint8_t buf[512];
 	size_t len;
 
-	if (!ft_build_authenticate_ies(hs, hs->supplicant_ocvc, hs->snonce,
-					buf, &len))
+	if (!ft_build_authenticate_ies(hs, hs->snonce, buf, &len))
 		return false;
 
 	iov.iov_base = buf;
diff --git a/src/ft.h b/src/ft.h
index f90fc1b2..dd56da23 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -45,7 +45,7 @@ struct ft_ds_info {
 
 void ft_ds_info_free(struct ft_ds_info *info);
 
-bool ft_build_authenticate_ies(struct handshake_state *hs, bool ocvc,
+bool ft_build_authenticate_ies(struct handshake_state *hs,
 				const uint8_t *new_snonce, uint8_t *buf,
 				size_t *len);
 
diff --git a/src/netdev.c b/src/netdev.c
index 7a14f1dd..61cb6284 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4765,8 +4765,7 @@ int netdev_fast_transition_over_ds_action(struct netdev *netdev,
 	iovs[0].iov_base = ft_req;
 	iovs[0].iov_len = sizeof(ft_req);
 
-	if (!ft_build_authenticate_ies(hs, false, info->super.snonce,
-						buf, &len))
+	if (!ft_build_authenticate_ies(hs, info->super.snonce, buf, &len))
 		goto failed;
 
 	iovs[1].iov_base = buf;
-- 
2.34.3

