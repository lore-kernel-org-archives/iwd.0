Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244174A18
	for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 18:25:36 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id x15so10249126pfp.4
        for <iwd@lists.linux.dev>; Mon, 22 Aug 2022 11:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=R1nf1/KuwAZ9aSbanbGV6usIrn9jkYsoNPDfdYBYLpM=;
        b=pN6XXfBCkReWb9B4/GrvmEoUaNKu1j9szENargsKfb6gD34ZWhKbaYd+WACeP3sTmr
         U7RsuhuPWnKjq+FTUlcsFiMOyjObxsAHIv+H46RojJCqrfd/rcNDrQEKT2JZcd12HiYR
         zjddfFAmBWjgDU4Redzz37x7dlGcV4kY5Ga2xtFINeN3MjqktVsp/F4qD7OKou7OvgBe
         uZ710BT+CTCJ0JUxyJWGVqJs/KejYK1RfAZo76Z4J0twT+Q85hAgZmORYo4Qf00AhLLz
         0B5YOazNOTTQeT7R2ylUTQILl9E7a1d7BGv1yH+01ABb407jY1e+N17iTOdRbQDI3jJC
         Ocng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=R1nf1/KuwAZ9aSbanbGV6usIrn9jkYsoNPDfdYBYLpM=;
        b=sCTCmaYqHrcF23HTAsw5pr008gfUy2dPHNPdCmDQnTJ7qFPcNjTxQWWG4+frNaWL8c
         GIA1aidjnmoxkNK7BDpiJ3gQfOujhsBg0eVLr8t54jyJL8txn+fDGuW3bczkdlIV79fI
         ye/kKo46KRY6ztHc91DnjFVdmMFkUfQlnD2L0qQpQBRlLez1N4qP0Ti61epx/xIP8y+Y
         5hoQtW1HAr+CTwtmjkCwMHSJxus60HQP5s6x/hdimcTpgQDunwLQW9UCL69jEmjaYBJ8
         hVx0OxMR2mqtDG5iLJLU0BkSt7yUawpiAEfJt58Jltq5hTFYTyyjxm7dLdIdoyoHBXwH
         /kKQ==
X-Gm-Message-State: ACgBeo3jMjKohGdIWT/LcXU7G7XN2FX8eQAmJ+/coXmJq8hFH5Be761L
	AVNZziwLYlE2tniy5/pZGSqhXZBKQUo=
X-Google-Smtp-Source: AA6agR4c5BVGnEIPWMaNm5LPDBVBBe8hVbClblgTB4lRg1gv4pDTMqSRgqBUlCFx1t4GfsoMqF/m4Q==
X-Received: by 2002:a63:2cc6:0:b0:41c:5f9c:e15c with SMTP id s189-20020a632cc6000000b0041c5f9ce15cmr17563035pgs.241.1661192735470;
        Mon, 22 Aug 2022 11:25:35 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709026f0100b00172bd4c12b2sm1612024plk.224.2022.08.22.11.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:25:35 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/9] ft: remove OCI element from auth/assoc
Date: Mon, 22 Aug 2022 11:25:22 -0700
Message-Id: <20220822182525.2078312-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220822182525.2078312-1-prestwoj@gmail.com>
References: <20220822182525.2078312-1-prestwoj@gmail.com>
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
index 84873fbd..14d6f4f2 100644
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
 
@@ -809,7 +789,7 @@ static bool ft_over_ds_start(struct auth_proto *ap)
 	return ft_tx_reassociate(ft) == 0;
 }
 
-bool ft_build_authenticate_ies(struct handshake_state *hs, bool ocvc,
+bool ft_build_authenticate_ies(struct handshake_state *hs,
 				const uint8_t *new_snonce, uint8_t *buf,
 				size_t *len)
 {
@@ -838,7 +818,6 @@ bool ft_build_authenticate_ies(struct handshake_state *hs, bool ocvc,
 
 		rsn_info.num_pmkids = 1;
 		rsn_info.pmkids = hs->pmk_r0_name;
-		rsn_info.ocvc = ocvc;
 
 		ie_build_rsne(&rsn_info, ptr);
 		ptr += ptr[1] + 2;
@@ -889,8 +868,7 @@ static bool ft_start(struct auth_proto *ap)
 	uint8_t buf[512];
 	size_t len;
 
-	if (!ft_build_authenticate_ies(hs, hs->supplicant_ocvc, hs->snonce,
-					buf, &len))
+	if (!ft_build_authenticate_ies(hs, hs->snonce, buf, &len))
 		return false;
 
 	iov.iov_base = buf;
diff --git a/src/ft.h b/src/ft.h
index 7ae925a3..6922513f 100644
--- a/src/ft.h
+++ b/src/ft.h
@@ -43,7 +43,7 @@ struct ft_info {
 
 void ft_info_free(struct ft_info *info);
 
-bool ft_build_authenticate_ies(struct handshake_state *hs, bool ocvc,
+bool ft_build_authenticate_ies(struct handshake_state *hs,
 				const uint8_t *new_snonce, uint8_t *buf,
 				size_t *len);
 
diff --git a/src/netdev.c b/src/netdev.c
index 165dc157..6b0cd537 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4757,8 +4757,7 @@ int netdev_fast_transition_over_ds_action(struct netdev *netdev,
 	iovs[0].iov_base = ft_req;
 	iovs[0].iov_len = sizeof(ft_req);
 
-	if (!ft_build_authenticate_ies(hs, false, info->super.snonce,
-						buf, &len))
+	if (!ft_build_authenticate_ies(hs, info->super.snonce, buf, &len))
 		goto failed;
 
 	iovs[1].iov_base = buf;
-- 
2.34.3

