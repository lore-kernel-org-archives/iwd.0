Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9302D47F5B
	for <iwd@lists.linux.dev>; Wed,  6 Dec 2023 20:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXw+aJ1d"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5c6734e0c22so127796a12.0
        for <iwd@lists.linux.dev>; Wed, 06 Dec 2023 12:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701893889; x=1702498689; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDqoM7QjlNAhdyKyErUpySXKYYw4XfwYgeohnydEEw8=;
        b=fXw+aJ1dzQ+YC+sC2rVheVHzYzv5BND9WqlqGboTDig05qm93yVZM+ZifvADvjbEjp
         L8+PvQJYWUv84MLIbZab0btYQ2snpUo8UmKJqTof3VqMIi1iVg5sr5IJnaFhGopNPfLq
         QpwtoHbFjSx4q3XhhXY2MLxTD6cxZeE9bjSvZE9qsV0CCdyQ2NBpyaKUqVccZUS/M2Gp
         AVqEFxTP1IayIoTbV1v7RJY0GgFX8diQo/+3EkUlftVt3gjfjM6vfqabXFJj5duPg9Ku
         0q42d6n83MXfyMi+ayLH1dAM7qleHgbC7GIGCiS2NA+PVjOhIjfaAoh6puQM2gAtj043
         5oAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893889; x=1702498689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDqoM7QjlNAhdyKyErUpySXKYYw4XfwYgeohnydEEw8=;
        b=wM520JpqEVNAqtGNttSBV9qtP5YluzlJVbt4P/intHl35q/jFypNdwpwMJ4kfn7qxE
         vt0YlYedw4wv9+DtlK2bIBPuAE91nDTjYx+Ugsafy1g6VPLlpZsSHaCdKz0l+tJlySBG
         LJVWMJFNeeojFpji0C0XynTsN82LjEeTik9yJq1Uzj9kpfdMigMO7uOwT/9kyjBMv3+p
         Q68QMy7dNDTP+tF7dlpkMqPI7Qoh3LrD20hnpcvExSpspR/ICbhCnEjub4tx/+RNVI4m
         WBDBy5mcKLQ1ypAx78Ds1NpPlnzWnHc6ksqq+XwzsTtgq06nnmGz1k7YwIVsmsZ4wpkn
         iBaQ==
X-Gm-Message-State: AOJu0Yy2buiHEbn4CReLlfbiaq0vp+wLOsKykUBS6PnU453/jbuwFUkv
	K/AE33DHlIKZ2B0067Vr65ibCmZI7p3iqg==
X-Google-Smtp-Source: AGHT+IGDLlcYOQGzwu2GQswsQyzAYKex4c38+R+RPCbzmLzHH+EKkN0BK0oAFeBOys1kvfHmT3g5TQ==
X-Received: by 2002:a05:6a21:149a:b0:187:b14f:a2a with SMTP id od26-20020a056a21149a00b00187b14f0a2amr1149556pzb.20.1701893889548;
        Wed, 06 Dec 2023 12:18:09 -0800 (PST)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id by40-20020a056a0205a800b005c2185be2basm243168pgb.54.2023.12.06.12.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:18:09 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 05/13] handshake: use authenticator_fte instead of 'fte'
Date: Wed,  6 Dec 2023 12:17:54 -0800
Message-Id: <20231206201802.2139649-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206201802.2139649-1-prestwoj@gmail.com>
References: <20231206201802.2139649-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/eapol.c     | 5 +++--
 src/fils.c      | 2 +-
 src/ft.c        | 2 +-
 src/handshake.c | 2 +-
 src/netdev.c    | 2 +-
 5 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index 3d7b3d38..bad4bbb7 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -1299,7 +1299,8 @@ static void eapol_handle_ptk_1_of_4(struct eapol_sm *sm,
 		ies_len = ies[1] + 2;
 
 		ies_len += append_ie(ies + ies_len, sm->handshake->mde);
-		ies_len += append_ie(ies + ies_len, sm->handshake->fte);
+		ies_len += append_ie(ies + ies_len,
+					sm->handshake->authenticator_fte);
 	} else {
 		ies_len = append_ie(ies, own_ie);
 	}
@@ -1795,7 +1796,7 @@ static void eapol_handle_ptk_3_of_4(struct eapol_sm *sm,
 		if (eapol_ie_matches(decrypted_key_data,
 					decrypted_key_data_size,
 					IE_TYPE_FAST_BSS_TRANSITION,
-					hs->fte) < 0)
+					hs->authenticator_fte) < 0)
 			goto error_ie_different;
 	}
 
diff --git a/src/fils.c b/src/fils.c
index c3337352..f876e7e5 100644
--- a/src/fils.c
+++ b/src/fils.c
@@ -445,7 +445,7 @@ static int fils_rx_authenticate(struct auth_proto *driver, const uint8_t *frame,
 					kck_len, &ft_info) < 0)
 			goto invalid_ies;
 
-		handshake_state_set_fte(fils->hs, fte);
+		handshake_state_set_authenticator_fte(fils->hs, fte);
 		handshake_state_set_kh_ids(fils->hs, ft_info.r0khid,
 							ft_info.r0khid_len,
 							ft_info.r1khid);
diff --git a/src/ft.c b/src/ft.c
index 2cc611b8..43399828 100644
--- a/src/ft.c
+++ b/src/ft.c
@@ -922,7 +922,7 @@ static void ft_prepare_handshake(struct ft_info *info,
 
 	memcpy(hs->snonce, info->snonce, sizeof(hs->snonce));
 
-	handshake_state_set_fte(hs, info->fte);
+	handshake_state_set_authenticator_fte(hs, info->fte);
 
 	handshake_state_set_anonce(hs, info->ft_info.anonce);
 
diff --git a/src/handshake.c b/src/handshake.c
index f35da9b1..ad8533f4 100644
--- a/src/handshake.c
+++ b/src/handshake.c
@@ -528,7 +528,7 @@ bool handshake_state_derive_ptk(struct handshake_state *s)
 				IE_RSN_AKM_SUITE_FT_OVER_SAE_SHA256 |
 				IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA256 |
 				IE_RSN_AKM_SUITE_FT_OVER_FILS_SHA384)) &&
-			(!s->mde || !s->fte))
+			(!s->mde || !s->authenticator_fte))
 		return false;
 
 	s->ptk_complete = false;
diff --git a/src/netdev.c b/src/netdev.c
index f2e887b4..b9dc930e 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2777,7 +2777,7 @@ process_resp_ies:
 			 */
 			if (ie_parse_fast_bss_transition_from_data(fte,
 					fte[1] + 2, kck_len, &ft_info) >= 0) {
-				handshake_state_set_fte(hs, fte);
+				handshake_state_set_authenticator_fte(hs, fte);
 				handshake_state_set_kh_ids(hs,
 							ft_info.r0khid,
 							ft_info.r0khid_len,
-- 
2.34.1

