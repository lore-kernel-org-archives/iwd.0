Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA4AA934
	for <iwd@lists.linux.dev>; Mon,  6 May 2024 00:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714956546; cv=none; b=gI3X4ndJkqV4GkBgluJ9RHb2JezRY/3Uhf5dGPwyhKumWCnEUKZXVbiq/Xc96A6qvmdh0Pn45GntEue/+rFFjZuxjyw/UeMhgQRgn+ziiAmNM+dVjgh7dJWiypiOyhAdtPTYIMUNvcBH2VPk1X0qmgztz+uQ3t3Z46d+utiIbMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714956546; c=relaxed/simple;
	bh=tkPFAkN4DbopzBk+oQr79nVQHvTDl/GW/hsYV9DHWEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6bpQiMeBeCXoMsKAYjS6B8UDcjCQZ/Ge/Y19f00zE2bhPbQLUaPIVivURNXOiL2vqOj6ImyitN7aJkDnhRM4rN3gFM1J6bR0Ljms52cmq5vdiPgn6N+OQL1eL+44v11yp4Ni1zJZCsqL1kjQmVjc3z6XLHeFF44cbIjyBfX3Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKS52Vkv; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKS52Vkv"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2b3c1ea9a68so824409a91.1
        for <iwd@lists.linux.dev>; Sun, 05 May 2024 17:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714956545; x=1715561345; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5CrnkIpfWXsq735qycDcBC7SdKFyw2URaeP/5UWloM=;
        b=nKS52VkvIghjSGt57+oL75ffmL0J+fOuWJOU1qnXdxXEkmvRE5BYVvF+ew0S+xdSmw
         bVAcYifNEQFIoGJB8p9V5VEH0OYhRXmVznqwjW/QC0MmRD7afzDQ0IKEFQuGTSCN1uqd
         4aZD9KYrCeZIDguxmM6f4g0doSNi4eeWw/5xCOI6Md1zsZzXhGaRoB3S8hzk68cPQO2J
         4AODdol4TApA3OyE3vNxG/yENIJ4FXj/KqE32eYsP0TY82+fu3KCOOz/4ZbpFR7JSrzz
         FLIlpWYT1jtVPGsSIezHwdrjloVcxVJmsYL/9lf5z2yDm/41AIRjFy0AGr/rZ5nf4UhG
         dm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714956545; x=1715561345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5CrnkIpfWXsq735qycDcBC7SdKFyw2URaeP/5UWloM=;
        b=pUFVyFv+hboa7erJj293jGx+yVhhab/3NEe2W8sBjSsqbd2OQFHV7e8sZPvlFWWT1b
         pumO3d/kzICZDJaOl4Re84CGfgA7UW/BrEBJueI6SCWzd41IVGIShFs0roOOHuybvXc7
         1yc9zwJ8ubJD7VlaO/IcTcmoTFTKZqBQp/NbxKAUEFL8PsUxMjxnJFYckoVL+nX3jtpG
         wFTxA3l3VBkXbCyyqLYJ7Hmw12Vp29Uj+lJa7DCCNmaHR4/Be8ES2cibqRVDHzK7nXCB
         GfO06RF1RmW/vkqeFO8jagRgERVKFcz7Prgk/sA8EC3Ry87F23DF0sR/ngYTdtaxSTHl
         rLsQ==
X-Gm-Message-State: AOJu0Yy7IOfnc0QfWXAgB3tMbvA89OjCgDIngCsIKpnZktvHFbBnzT0U
	EWpLqO/vcv5T6bjogvgjpyE52h71phBN8389R+mtJUusIm/6nYQyRAEUkg==
X-Google-Smtp-Source: AGHT+IG1tbdTzRVwxnTT7lmXrKqZMSeEtL6Qr+ve3bzFUbLL39nCjx6Vap1jz1HSoZJE20DL+unGgw==
X-Received: by 2002:a17:90a:f492:b0:2a6:217b:4492 with SMTP id bx18-20020a17090af49200b002a6217b4492mr12927825pjb.3.1714956544405;
        Sun, 05 May 2024 17:49:04 -0700 (PDT)
Received: from localhost ([192.145.118.41])
        by smtp.gmail.com with ESMTPSA id gt14-20020a17090af2ce00b002adc80dab50sm6942900pjb.18.2024.05.05.17.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 17:49:04 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH v2 08/18] sae: support reception of Confirm frame by AP
Date: Sun,  5 May 2024 17:30:31 -0700
Message-ID: <20240506003518.320176-9-brandtwjohn@gmail.com>
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

Experimental AP-mode support for receiving a Confirm frame when in the
COMMITTED state. The AP will reply with a Confirm frame.

Note that when acting as an AP, on reception of a Commit frame, the AP
only replies with a Commit frame. The protocols allows to also already
send the Confirm frame, but older clients may not support simultaneously
receiving a Commit and Confirm frame.
---
 src/sae.c | 48 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/src/sae.c b/src/sae.c
index 7405a561..3ad28fab 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -930,9 +930,13 @@ static int sae_process_confirm(struct sae_sm *sm, const uint8_t *from,
 
 	sm->state = SAE_STATE_ACCEPTED;
 
-	sae_debug("Sending Associate to "MAC, MAC_STR(sm->handshake->aa));
-
-	sm->tx_assoc(sm->user_data);
+	if (!sm->handshake->authenticator) {
+		sae_debug("Sending Associate to "MAC, MAC_STR(sm->handshake->aa));
+		sm->tx_assoc(sm->user_data);
+	} else {
+		if (!sae_send_confirm(sm))
+			return -EPROTO;
+	}
 
 	return 0;
 }
@@ -1083,16 +1087,34 @@ static int sae_verify_committed(struct sae_sm *sm, uint16_t transaction,
 	unsigned int skip;
 	struct ie_tlv_iter iter;
 
-	/*
-	 * Upon receipt of a Con event...
-	 * Then the protocol instance checks the value of Sync. If it
-	 * is greater than dot11RSNASAESync, the protocol instance shall send a
-	 * Del event to the parent process and transition back to Nothing state.
-	 * If Sync is not greater than dot11RSNASAESync, the protocol instance
-	 * shall increment Sync, transmit the last SAE Commit message sent to
-	 * the peer...
-	 */
-	if (transaction == SAE_STATE_CONFIRMED) {
+	if (sm->handshake->authenticator && transaction == SAE_STATE_CONFIRMED) {
+		enum l_checksum_type hash =
+			crypto_sae_hash_from_ecc_prime_len(sm->sae_type,
+				l_ecc_curve_get_scalar_bytes(sm->curve));
+		size_t hash_len = l_checksum_digest_length(hash);
+
+		if (len < hash_len + 2) {
+			l_error("SAE: Confirm packet too short");
+			return -EBADMSG;
+		}
+
+		/*
+		 * TODO: Add extra functionality such as supporting anti-clogging
+		 * tokens and tracking rejected groups. Note that the cryptographic
+		 * confirm field value will be checked at a later point.
+		 */
+
+		return 0;
+	} else if (transaction == SAE_STATE_CONFIRMED) {
+		/*
+		 * Upon receipt of a Con event...
+		 * Then the protocol instance checks the value of Sync. If it
+		 * is greater than dot11RSNASAESync, the protocol instance shall send a
+		 * Del event to the parent process and transition back to Nothing state.
+		 * If Sync is not greater than dot11RSNASAESync, the protocol instance
+		 * shall increment Sync, transmit the last SAE Commit message sent to
+		 * the peer...
+		 */
 		if (sm->sync > SAE_SYNC_MAX)
 			return -ETIMEDOUT;
 
-- 
2.45.0

