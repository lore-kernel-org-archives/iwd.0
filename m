Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F211A932
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 00:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956536; cv=none; b=EZlENMZ5z2DEm24uX8bM5zms1jR/OCyPbM+CxXzrHtPN496UzIH6PAQjLgFXVopVitH8qcL78gRSwfqOaPPO3HAIKer/GAiIifD8sK8RjJvbWvUY4jm5VqJOck/FR02C1liuM7R7XaGOj9NTh0/uqzIOrh2zpgDfWuaAht3PNSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956536; c=relaxed/simple;
	bh=rQIgQatvjCAJ0YijxMVwQ75DZJ3Wa+9kkyp7KMgtMRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqrQ5c1Cbxn5cUbwoPG+V2ExecqR5GXzXYf7Do68sDIdl2zUjUDGw0StJs8Znj92CX/sVLciG4tCqxGS0wTDovhIo3n2A84n02pGM0oeYvzn4l0GLUalkcdKdW8VVtFL11muZ4kJeKGJc+p3aZPoSMas/OgsFfunVWghRW9dAJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xj2ZNfmo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xj2ZNfmo"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so7070195ad.0
        for <iwd@lists.linux.dev>; Sun, 05 May 2024 17:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714956534; x=1715561334; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEv4LZx8WPK1WJDqrgB3tecjENbWp8IMFV6HYPMSNeA=;
        b=Xj2ZNfmodwdr+6mCgff11y4zTK8ZwbjMOFzQOguBxoFGotedXBqni6qQ/7TlOmxTqB
         +Hl1tDNG9z9Gdi+Jkkr33jRYlqMrSCrsD7r9nH3D7aexGnq1CWcVdHQdUoy6vtmI0oZk
         KAIgg45DBKeMWaRqLE0ixtsBXPgPV3SJnrz4/Vs1YzW8pfGn7+PuOo8MgrJBajDqSaXp
         QS3X8FyVT4Mll/rozs30TKBdeFBwJzgZCXB8mdezzGCGkIH7KY0Y1NiZqvfPDmPcn5Sd
         qapcYHTUzIzR/NtqNnXeJ4f349HjJVPIMx2HPKx/UJg3fo0wdle1jGJGzaJBU0Su+AdD
         Jgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714956534; x=1715561334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fEv4LZx8WPK1WJDqrgB3tecjENbWp8IMFV6HYPMSNeA=;
        b=AKzxevccetYUEAjXBi5R3KplYnp+csZ8BGQeNR8TzIrRits6o8SohLSJAGnfiIkyQX
         TM0v4DQYPfoyNbSCUasp/+5eqri4pc0gEYJcC38JVVChOmf0n4l/rzCZtuJeimuAl4sy
         OiYtl7Bo3G2EqNEWd210pGvU43DCnaGgn47qhlNbiceG9tJx572qWg9B2fcEFGOVpRId
         s/uNxn++RQGfikhFbqpYz/iiuLVePABYZvbt1p1aTbPEPxY0E3N7BTYO+m2uMwqBrcD0
         c5n1dghbg1hNqkzbZdXAvFKVSvPw9iHdqBiotcApwoNKAtgWNE5AlTqYJlv3XGP1QPj/
         EgnA==
X-Gm-Message-State: AOJu0YwY+XV/PbfMxCJsyhtLY0ppOrp4iPEMs5sCxmtbJCUlEMtnwftt
	0Gjqjw5KAGg/fWE7fule709cXkXN6dqYDD1TY4VAALUGeCipLM75S5Bbjw==
X-Google-Smtp-Source: AGHT+IF4yFCrzUH1pYQntqD8A6frUuAaLBQKpsyHJ0mKSJzhxcvgyHVqyYIWXVNaFXB+wwUR7qzgWg==
X-Received: by 2002:a17:902:e54c:b0:1e5:1041:7ed4 with SMTP id n12-20020a170902e54c00b001e510417ed4mr18123925plf.14.1714956534345;
        Sun, 05 May 2024 17:48:54 -0700 (PDT)
Received: from localhost ([192.145.118.41])
        by smtp.gmail.com with ESMTPSA id jy8-20020a17090342c800b001ec5f1f363csm7050584plb.90.2024.05.05.17.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 17:48:54 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH v2 07/18] sae: verify offered group in AP mode
Date: Sun,  5 May 2024 17:30:30 -0700
Message-ID: <20240506003518.320176-8-brandtwjohn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506003518.320176-1-brandtwjohn@gmail.com>
References: <20240506003518.320176-1-brandtwjohn@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When receiving a Commit frame in AP mode, first verify that we support
the offered group before further processing the frame.
---
 src/sae.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/sae.c b/src/sae.c
index 7ba9b0eb..7405a561 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -216,6 +216,18 @@ static int sae_valid_group(struct sae_sm *sm, unsigned int group)
 	return -ENOENT;
 }
 
+static int sae_supported_group(struct sae_sm *sm, unsigned int group)
+{
+	const unsigned int *ecc_groups = l_ecc_supported_ike_groups();
+	unsigned int i;
+
+	for (i = 0; ecc_groups[i]; i++)
+		if (ecc_groups[i] == group)
+			return true;
+
+	return false;
+}
+
 static bool sae_pwd_seed(const uint8_t *addr1, const uint8_t *addr2,
 				uint8_t *base, size_t base_len,
 				uint8_t counter, uint8_t *out)
@@ -1053,7 +1065,8 @@ static int sae_verify_nothing(struct sae_sm *sm, uint16_t transaction,
 		return -EBADMSG;
 
 	/* reject with unsupported group */
-	if (l_get_le16(frame) != sm->group)
+	if ((sm->handshake->authenticator && sae_supported_group(sm, l_get_le16(frame)) < 0) ||
+	    (!sm->handshake->authenticator && l_get_le16(frame) != sm->group))
 		return sae_reject(sm, SAE_STATE_COMMITTED,
 				MMPDU_STATUS_CODE_UNSUPP_FINITE_CYCLIC_GROUP);
 
-- 
2.45.0

