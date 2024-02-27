Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3103C099
	for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058869; cv=none; b=uqCiJ3D8z+O6MNlXes443GLqOHoVFrjv6MFjxOdIIwqJz3UHQX4a1P8JDu6WorzZi1AHtqbDNDLX1sMtgbzqioPSkp66N8+el/1YJeUoIn5TWhHO0ZVfu0vu+yrzmuFtVQi6yxUijayVpC5Y4FwD/Q/3oG3HH85uLSRWGDqAxnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058869; c=relaxed/simple;
	bh=b9v04I3UJlbA75DuUVjSm53RIvGqH9JCoBAR6+C1g44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MHJVN3E4vKc69beKKXEDlKzrFUqpH99ane5A1PTF1eFYgAH7u+Xjv3/pEt3rkTihoMq/A6kXSPqdTSBEgbLgsGHsKiCcVnAUqstgrZNamEEX49A/zd9Z9mjC5QhNCekDLgx/bmKEnqi2i9RlBKn6GuhFLtn2xonRkuEHepHbtp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qk7Z3jD4; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk7Z3jD4"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42e67ee5b48so18891191cf.1
        for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 10:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709058867; x=1709663667; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcDX9X5I466bQE2GWJxS89Sx30t9cTiszCnW3wMRqeg=;
        b=Qk7Z3jD49NJn4BSW3Lb/UjRuekHQEd8WPUUxU5K8d3RNsZWZjyyW6wBANTCPnA6wUW
         22A1nmTNItbZTut0/qmFu+GCwf8AY6U7GqRX/4VtxxAAM+Ni3tVXlTziTYqdKSTrF1TW
         LsMat4a2wvJoHJjT2o9+LY9BuA17tq+APdBELPzlvb6o3bulGy6bcZTh60R+MeQA+MfP
         vmACs7keEp4gH7ZjrylfBga2jl2CjmUQUr6FT+V6tC3GLBROOo3EL8LboWrsJ8KWJrGj
         Iowua3jHo/DiikVadiYjYPrRKpLdzRHqUUdMAycBxqvTKlkJHWe6lN6oF8c8NIAKoCwb
         CaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709058867; x=1709663667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcDX9X5I466bQE2GWJxS89Sx30t9cTiszCnW3wMRqeg=;
        b=rnnyykAcXGYvled6/3cF4LvNyF84qZC5Ey/vVpc6x4QQI/mBPc1dxPqX504cKMvT2F
         yOXr7h79fVlLuZz2qjh70xdr9Zza7ydsgucWLfa+Iy4lOP8p9JZA65jBJ3HmOp7swrPo
         17kTcLxkaAdBRIkvxonyYTE5XN8YAboKhja36yRw7f7iGOBhioWZb+8sHVSIWnApR9MJ
         br1tAGVLwFa/a+NuD/MNNIs+B0JwR4Z54CKRqGjY1xJo2GTtqpHJU3Bw0qWvHQK0qq7A
         jjb8uNWyu+XfbfaZk8flhbdTiMjWqzosJLfjP89M7PQpSaz8oz7ZTCQv1A5GytRx1J6V
         u1Bg==
X-Gm-Message-State: AOJu0YyXuJl7jSm8PXH4Sit+4xMTsZnSS+4XVM22f+Rk7R0uIgM/K2Xg
	P2abW33ie/Chtwf0YnQZtcj1he+aNsbxau5cLrsGinMAI74UN6ipT4SLy8bG
X-Google-Smtp-Source: AGHT+IEmsiaHZOikfRqyR2aOyYWs1Us10elg7Ktr4p4xys/icnAwcE/KJsa2G1iCyKC94ThwTGH0Kg==
X-Received: by 2002:ac8:7e94:0:b0:42e:81ab:6111 with SMTP id w20-20020ac87e94000000b0042e81ab6111mr7227152qtj.52.1709058867033;
        Tue, 27 Feb 2024 10:34:27 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id jy2-20020a05622a818200b0042e3468a98csm3819617qtb.4.2024.02.27.10.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:34:26 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 05/11] sae: remove sae_sm_set_force_group_19, use handshake
Date: Tue, 27 Feb 2024 10:33:59 -0800
Message-Id: <20240227183405.257206-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227183405.257206-1-prestwoj@gmail.com>
References: <20240227183405.257206-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the flag set into the handshake to force the default ECC group
---
 src/netdev.c | 3 ---
 src/sae.c    | 8 +-------
 src/sae.h    | 2 --
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/src/netdev.c b/src/netdev.c
index 8a7ff092..d80ce10f 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3834,9 +3834,6 @@ static void netdev_connect_common(struct netdev *netdev,
 			}
 		}
 
-		if (bss->force_default_sae_group)
-			sae_sm_set_force_group_19(netdev->ap);
-
 		break;
 	case IE_RSN_AKM_SUITE_OWE:
 		netdev->owe_sm = owe_sm_new(hs);
diff --git a/src/sae.c b/src/sae.c
index 9a10292e..bf9fb0ff 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -1459,13 +1459,6 @@ bool sae_sm_is_h2e(struct auth_proto *ap)
 	return sm->sae_type != CRYPTO_SAE_LOOPING;
 }
 
-void sae_sm_set_force_group_19(struct auth_proto *ap)
-{
-	struct sae_sm *sm = l_container_of(ap, struct sae_sm, ap);
-
-	sm->force_default_group = true;
-}
-
 static void sae_free(struct auth_proto *ap)
 {
 	struct sae_sm *sm = l_container_of(ap, struct sae_sm, ap);
@@ -1501,6 +1494,7 @@ struct auth_proto *sae_sm_new(struct handshake_state *hs,
 	sm->user_data = user_data;
 	sm->handshake = hs;
 	sm->state = SAE_STATE_NOTHING;
+	sm->force_default_group = hs->force_default_ecc_group;
 
 	sm->ap.start = sae_start;
 	sm->ap.free = sae_free;
diff --git a/src/sae.h b/src/sae.h
index ec29e624..668d084f 100644
--- a/src/sae.h
+++ b/src/sae.h
@@ -30,8 +30,6 @@ typedef void (*sae_tx_associate_func_t)(void *user_data);
 
 bool sae_sm_is_h2e(struct auth_proto *ap);
 
-void sae_sm_set_force_group_19(struct auth_proto *ap);
-
 struct auth_proto *sae_sm_new(struct handshake_state *hs,
 				sae_tx_authenticate_func_t tx_auth,
 				sae_tx_associate_func_t tx_assoc,
-- 
2.34.1

