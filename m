Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2728C07
	for <iwd@lists.linux.dev>; Sun, 22 Sep 2024 21:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727038846; cv=none; b=I8RZDM5pR2aMd5qe1TQkegnfmQyDlRlaftZU00GGn7f0DAPpq5lIavLKkpV9cvyx6SOdPB/QuhV87Nhe0e5v2Dr08SXcHHoA3SRiJ3WY75oz3oCqqpd8FCSGcnXZlaWACbPUr5pO/oRW4WiNo8LDtiADT2FdyILr2KhLCufqs6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727038846; c=relaxed/simple;
	bh=D+ommAxliR+lu+7BCL9AGKCfGsUoDXxKtEao6+h35DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpCWJfMp7Pwdr2wY7pAofBmNb7oUn02iNMhUX9KPXlKki215iG4H8CxbkZzO+c0VnLCOAL8Y/0+0rl2vGz+D/uIXHtEcM5g5cExVecJ6AurcOZMWy+p6NYMsW+9eokumBeRRcRQz2GFabArqqO6C8acZ2Q/+NNgfXKT50d1Ws8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+QB24YK; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+QB24YK"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e03e9d1f8dso2048357b6e.2
        for <iwd@lists.linux.dev>; Sun, 22 Sep 2024 14:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727038843; x=1727643643; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xt6ViLxkX8c1OyDOR0PdD/JHcP0hdIHIkF/+txuwAJA=;
        b=S+QB24YKRZMk2YGNYsumgYA8AF+7jFtmXOjL7SmbDDBisjuDaW/wJi0FLnvZUbeNxx
         RbSn1FybunJ5J+qoKoOBLiLQSpacSRY4Xr4nOmkuhCWalq3RpAfCffF5RQKbfANgK4fE
         Wqe7pOGYkHSjKjifV+w3Y6kLqRIDKE+kdABMg1zVg8RaIGa9d325cB2+Up1t8M0ePa7r
         aAQ6Gv4CokJxQuJT0hpZTTvei9+K86BrYNTI97dCsHHdV8esIkMgABV4vpoE78HRC7vf
         hYtCvFv5vjXsMJ6mZEYSIAMxIgs7DftZtpMQ21fePmfDpIPgevl4e6ZUl1YIlMFOXWo8
         mtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727038843; x=1727643643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xt6ViLxkX8c1OyDOR0PdD/JHcP0hdIHIkF/+txuwAJA=;
        b=xLRMozgUZW6buZpj7vtiNlhJQ4RH7UIfqUuQg2QyGxICtUSLrLOqyVOhtQS0V3Uv9l
         O/YwsoNlE8CocwI8bmjtVDlKrYXc8eJiLZ09f+SV+v2/w3jZdvh/qmEpOGzIrk2NSNyE
         chJHkoLoPNn03B8x6b4G+dW7saG8aF+ivHbZx1pgI4Ib+gRuj4oV5ozSJwHI28EI/jst
         q8aWfCFJv97bXhnQGMNPIUyBwR5Osqk7fI4IAR/BqNoqJYRWtRUg6nsMT+YRw+gbTWYN
         WukIR+6f8VAWlX8ObL5haEd8xLomgyP+LcP2LrQvodg34NIGZbPZ48sA5F62vJwmiit5
         qcYQ==
X-Gm-Message-State: AOJu0YxFPT2Cxhb7lEHJ+sA9h6MFngKM3/yNczc4uETYsD5c2mAN5ECy
	wqshSW2SXkwcYjDvPSAJn90sS8RvapBwKo9M6cWtv9ndxVp5RFFWhZOT+A==
X-Google-Smtp-Source: AGHT+IFbRwzV5pMOhLNPpKD3QcA/zfqcDi6ntcTxb8VoKAO1IlKsnEDthQ3ikffnUREjo3da/t3YUg==
X-Received: by 2002:a05:6808:1a07:b0:3d9:27f5:5251 with SMTP id 5614622812f47-3e271b5f515mr6356664b6e.5.1727038843667;
        Sun, 22 Sep 2024 14:00:43 -0700 (PDT)
Received: from localhost.localdomain (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e580778e8dsm1413438eaf.29.2024.09.22.14.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 14:00:43 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH v2 2/2] sae: Allow ability to force Group 19 / Hunt and Peck
Date: Sun, 22 Sep 2024 16:00:12 -0500
Message-ID: <20240922210040.1073989-2-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240922210040.1073989-1-denkenz@gmail.com>
References: <20240922210040.1073989-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/netdev.c |  5 ++++-
 src/sae.c    | 20 ++++++++++++++++++++
 src/sae.h    |  3 +++
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index 1b50a540d8ca..d298977a1964 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -4033,11 +4033,14 @@ static void netdev_connect_common(struct netdev *netdev,
 		netdev->ap = sae_sm_new(hs, netdev_sae_tx_authenticate,
 					netdev_sae_tx_associate,
 					netdev);
-	else
+	else {
 		netdev->ap =
 			sae_sm_new(hs, netdev_external_auth_sae_tx_authenticate,
 					netdev_external_auth_sae_tx_associate,
 					netdev);
+		sae_sm_force_default_group(netdev->ap);
+		sae_sm_force_hunt_and_peck(netdev->ap);
+	}
 
 	if (sae_sm_is_h2e(netdev->ap)) {
 		uint8_t own_rsnxe[20];
diff --git a/src/sae.c b/src/sae.c
index 97c0af052f14..eb4634848afa 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -1550,6 +1550,26 @@ struct auth_proto *sae_sm_new(struct handshake_state *hs,
 	return &sm->ap;
 }
 
+bool sae_sm_force_hunt_and_peck(struct auth_proto *ap)
+{
+	struct sae_sm *sm = l_container_of(ap, struct sae_sm, ap);
+
+	sae_debug("Forcing SAE Hunting and Pecking");
+	sm->sae_type = CRYPTO_SAE_LOOPING;
+
+	return true;
+}
+
+bool sae_sm_force_default_group(struct auth_proto *ap)
+{
+	struct sae_sm *sm = l_container_of(ap, struct sae_sm, ap);
+
+	sae_debug("Forcing Default Group");
+	sm->force_default_group = true;
+
+	return true;
+}
+
 static int sae_init(void)
 {
 	if (getenv("IWD_SAE_DEBUG"))
diff --git a/src/sae.h b/src/sae.h
index 668d084f3402..4a59999bfba0 100644
--- a/src/sae.h
+++ b/src/sae.h
@@ -34,3 +34,6 @@ struct auth_proto *sae_sm_new(struct handshake_state *hs,
 				sae_tx_authenticate_func_t tx_auth,
 				sae_tx_associate_func_t tx_assoc,
 				void *user_data);
+
+bool sae_sm_force_hunt_and_peck(struct auth_proto *ap);
+bool sae_sm_force_default_group(struct auth_proto *ap);
-- 
2.45.2

