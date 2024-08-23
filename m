Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF15D188A1E
	for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434946; cv=none; b=QznSoaRTOZ2aXtGJOoF+dRPnUxSeikfYtrbp73zrDgsWKxgg19sYqxb1dSJT25oGDgZses0Gj+ZMaSlhrqGowo/2Xxk8FPlv4259AZO69ZbPfe3BmpP78ETYy1dTWiLFvhCcml5b4BztiYTBMMvtJ95/gw7WTYJyhsebHBky1AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434946; c=relaxed/simple;
	bh=tmhe17w0MUON0Ltr3IWGGWNMcO52QtlvNz0AQQLViqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUskm9o5T3btRz85QC7PY829Dol+SGiS8ySRLPlv4uJ0EUe5oOrZWWN6hwJcBBpKUP179TER3+HhT+Pzldw+SdYQVQX33++I0cqht4XqK7eYY5vJ1jNI1KMHVAS/eCGF1kUKfEWPzZF3ZQoKZUVFODG0S5KVrH434qn0ED5V2Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EltEJVza; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EltEJVza"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2702ed1054fso1659346fac.3
        for <iwd@lists.linux.dev>; Fri, 23 Aug 2024 10:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724434944; x=1725039744; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bOMbLA58dsGBxNJVuB+4YhT7/UnNmjgblcH1i5wJeVw=;
        b=EltEJVzapgqomTH3flkcctBxPXFIHjE69tAYh3rDrGLJYz7ZJ1fE0hWY7noTnVXkIe
         H4hhCaXlMY4j/Pyrwp5z4CIJOJt+FgPGgPtuB3ade6jzQAz5UpaJCRvg4MqjEdf5LBsN
         CSXt1EEZUn4X+PB94UNl30pa+dIoUgOD/iGm2mpT1uVQ+wWHSmdQfJPEVgztzQ0vxwoh
         CKE+scfgsvUldX4g9SnCLqliQ9FhSWa2QSeRK+pEykYHCcyPh+fhUBqgFY85WYTWAnUh
         gfvZW29WQNbXUglgXK9yJ6UX91jn3cKRDXFeMBSZNBGsEsWsEFoGZ4eBY0azUQlDs1Dp
         7Hmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724434944; x=1725039744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOMbLA58dsGBxNJVuB+4YhT7/UnNmjgblcH1i5wJeVw=;
        b=sNxcFoaqed1y5ZM84Ceyqncd6d8lhlhSjimmNaeRqLvhlDpHuWGJnczSjFxbIhCxWm
         qvzv1Hc5apdK859dLZj1rIG1bShd6atgKmYsgoU9rnm2zPBTA3Bj8RS4MYnxhPa/Y0G7
         yG848sOoSNx7sr145nsGNd2Xx8brXj2OFFzXjFZ94wzGYZTUqW2LHS8z7vpu1p9FzQeV
         dd8YS77H5uUqh44O5v5nDh2X2GB2vKoxVF2XEn7Ev9muU+wGuEOulP/SdBPmk707Y83d
         6aC8HKCZV7g3zoMi2dok/KgKVC7v5bCH6NCNTMuiSJ2ZeFsaLQi/woxXkTQSKG0SxQXa
         9HyA==
X-Gm-Message-State: AOJu0YzBD1A5yqWLWHbezNot4Evvyx+QyR/BUdHnd8+AaUAO2wPyoQMk
	jzHKFZCFtSVYuuMwznhPdwumEJKJ38ZxQLIRnU1DnppF2cWsQ26vJ68Xqw==
X-Google-Smtp-Source: AGHT+IGz3174ETaCOY8QybyCtSIqLhQ/QWVbw5dB4ZsxB0f4D0ckdTjf7clyQoq3JLYwyM/kRp3TvA==
X-Received: by 2002:a05:6870:808c:b0:259:88b4:976 with SMTP id 586e51a60fabf-273e6692602mr2907414fac.43.1724434943732;
        Fri, 23 Aug 2024 10:42:23 -0700 (PDT)
Received: from archdev.attlocal.net (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70e03aa9c67sm728506a34.30.2024.08.23.10.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 10:42:23 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [RFC PATCH v1 2/2] sae: Allow ability to force Group 19 / Hunt and Peck
Date: Fri, 23 Aug 2024 12:41:54 -0500
Message-ID: <20240823174220.498594-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240823174220.498594-1-denkenz@gmail.com>
References: <20240823174220.498594-1-denkenz@gmail.com>
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
index a1342d1bef94..5bc055acacfe 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3933,11 +3933,14 @@ static void netdev_connect_common(struct netdev *netdev,
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

