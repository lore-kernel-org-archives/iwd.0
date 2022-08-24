Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0071C3F
	for <iwd@lists.linux.dev>; Wed, 24 Aug 2022 22:55:26 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id f21so18541278pjt.2
        for <iwd@lists.linux.dev>; Wed, 24 Aug 2022 15:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=gFElWuCeSR+AcV03npos0O/uoBc+c67rzeyqpJ9LpuA=;
        b=H9DAI/RNdyApcc2KDxlFM7dKVN3hn3fzTDNA/eEOsK4XpFVrqqXWJu9BQLUcv5v+GG
         eiLcw0hn7IihqxNL8BR3r1/IvA9f2ISeArrCSt0YRGpG+qOA7YgHl8n6PlOWqZxtJg97
         NFKIVY3acDi3Lq/7eY4uHrK14I9gXIYmhP6K3EI7sfQyHoyN4/yr0emu731TDTaudmvN
         Rc/51h2W0xITAwr9PKjNYRcj7+ERp33Qp5EZftmQ0/r8ZEq3iAS+FlzS/7TeHIc8HnNM
         eq9vPClAG2FzFELELx3tazytM032FftxZdcufDZlU7yY1d+qLxJKP3tHGhaFMA01iNIl
         r3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gFElWuCeSR+AcV03npos0O/uoBc+c67rzeyqpJ9LpuA=;
        b=svB5iB1Lm/5atSAmWnsYoUryKBzaYPYNQT47ZoDHMZXWt89d65CiWiAili6Tq9aWHq
         9pnbHdXRPGcvAstmjCOmS6iXSeS0DECMVdiyz162QkwCd85frGg0ssFlHXfo8TlN0O6D
         oui+zjzPxAEfYU3lqnMpT1HumSef6ySj/mLu7BAHIA9FAGgnIBWsNdw3a85qmarG3DV4
         jn8T4x89V6kt3DL7Vw6BRtkV8vorG0svHvFYAeNxK/7AwVpzLimKRXY8ugbek4uj1hNH
         FSos7alOxOv6o6qCkGoL+TqZ6beTh8w6vd9MCFm7T0i+DscpURZEGistu5t/QdvMrp+P
         rlqw==
X-Gm-Message-State: ACgBeo2e6YsOfrJWwk7vpIwIx1c9Ch9cKGvV4GcJ2TKb5pS1PQBLSLe8
	z0DQB4QY56VxLPeIJEssv30akf/aeVY=
X-Google-Smtp-Source: AA6agR7vrsprec1eHjwU4D6YQB1VAtxpyyfcnugFhHBTbH22LywuURntkxc/2Rf8D4Yz8bxm+LnfEw==
X-Received: by 2002:a17:903:286:b0:172:fa5b:d18f with SMTP id j6-20020a170903028600b00172fa5bd18fmr920905plr.51.1661381725851;
        Wed, 24 Aug 2022 15:55:25 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id jn22-20020a170903051600b0016bcc35000asm6228682plb.302.2022.08.24.15.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 15:55:25 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/9] ft: remove OCI element from auth/assoc
Date: Wed, 24 Aug 2022 15:55:12 -0700
Message-Id: <20220824225518.2558698-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220824225518.2558698-1-prestwoj@gmail.com>
References: <20220824225518.2558698-1-prestwoj@gmail.com>
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
index 3cc34fcd..36e9fc26 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4759,8 +4759,7 @@ int netdev_fast_transition_over_ds_action(struct netdev *netdev,
 	iovs[0].iov_base = ft_req;
 	iovs[0].iov_len = sizeof(ft_req);
 
-	if (!ft_build_authenticate_ies(hs, false, info->super.snonce,
-						buf, &len))
+	if (!ft_build_authenticate_ies(hs, info->super.snonce, buf, &len))
 		goto failed;
 
 	iovs[1].iov_base = buf;
-- 
2.34.3

