Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E4F134BD
	for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713704033; cv=none; b=iqODEcohaRgMRxtcsYhG1ehFX6mTPfonVizhIPIighc7/so7ytcZnfaTKdoG5E9RPE2G3PXbZinhN2Wfh8+f623bI3A6U7Iw2fea858N7IpKC0UY/4qioMtP5RA+QP5NKAMX5pAfcgZoao9ylLmyH5LDDiyew/wbydVHNE9vQ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713704033; c=relaxed/simple;
	bh=KSqVNXJAzwRZNdXuYPVxpWhELcovp1U195/KHof8DKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ju3PqBGeODWengkNgUARsqT/947fH0ZECz/44HRzrMrK6i586So3t9pSeQK/bL4uKmI1LtbSwfLZTKiqs6OfuJzyrKb5mdM95gTOSAERBTibI+HHzgDG3/xWBmnXi5rdbKJBYZ1fw92ZaYZmfz/v5mr7CgBtQO4YzZUkUpAxNLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGCWPTyg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGCWPTyg"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e3ca546d40so28486325ad.3
        for <iwd@lists.linux.dev>; Sun, 21 Apr 2024 05:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713704031; x=1714308831; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sc7Bi3BtpcquWPNmKpc6bVHtZ49jfz+XY+SvcGcoCR8=;
        b=HGCWPTygEuuEY0tTY1LtNNJ7A4rEQpkDNKQbFALeEgMRn9jxlBrkIYBQ7/IYCyJN/u
         FN0NEaZ0y8p4Mz+OREwq0j8ujzrYnWZQuiB8dZH/bPMuspgttp9kCfwjl2RXL7bCfDui
         xsDW2HlmTNVCLO9m4qEGSii1JAcwYPyAhkj5fnmX3SXS2ot9maQmwfz8vRcw2IoQmYlr
         pRmO3lxIRLBRLVICeCsoDd3L4nJyvg7CngosVfIObvKIDODSfOO+VsNDpNJks6NTLeZ0
         SRqz02aTkCn2ZSgYyKKmZxkPvix+a5sM9l3fGmuvhf9waNUOEeZ8yeZQP2QFY9CKPzXA
         0BEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713704031; x=1714308831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sc7Bi3BtpcquWPNmKpc6bVHtZ49jfz+XY+SvcGcoCR8=;
        b=L6kW+ZfebyssKkVjryP+/OHBYXTE3cue7LEXJCLCbhJQEMk8khvgA4QNEr/ztg2nDg
         UehwCZo7eOFl8YPjAtZ19Zbvf4jRk9PxSbGwZJanbSmGM99eO74ZP7Flbfz9oJ2UJbs6
         dbhc+X4r34DEf6aPdrXWp2iT7hqFb9RrerEIhIK5P1m+zHPQ4oT1jE2Ia0oTm8mFOOI5
         jfvxhortC15/ToEVCviFCEoxzEYeFHZnIC9sjze/T26dJli9VsHadP4bonj7sRL5/H9S
         iW3fseK5R3GeEVxC+62B/Ygxds/ccOKmlrmEIuICEC6/6f4OBetJ+kFF6Pc7One26zHH
         AVhw==
X-Gm-Message-State: AOJu0YxNqPR0QZyNa73LkMHv/4IyOR6ipqakJpUHThmyXtRZ+mu1txs3
	zIzSulU5iffybNp+vtcRVvvk/CbhrReBUqkyRoplMgcMTmkYEdXt8csKoN/D6Ig=
X-Google-Smtp-Source: AGHT+IG0/D5+JedD95KCmpaw28VfbQmzZenhjnY70qfXnugWHLdtYtkmS/acUt+8W8pZVcFlwfCSNg==
X-Received: by 2002:a17:903:943:b0:1e4:3c7f:c060 with SMTP id ma3-20020a170903094300b001e43c7fc060mr9715528plb.66.1713704031485;
        Sun, 21 Apr 2024 05:53:51 -0700 (PDT)
Received: from localhost ([185.169.0.163])
        by smtp.gmail.com with ESMTPSA id e11-20020a170902784b00b001e0bae4490fsm6398646pln.154.2024.04.21.05.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 05:53:51 -0700 (PDT)
From: John Brandt <brandtwjohn@gmail.com>
To: iwd@lists.linux.dev
Cc: John Brandt <brandtwjohn@gmail.com>
Subject: [PATCH 07/11] sae: support reception of Confirm frame by AP
Date: Sun, 21 Apr 2024 05:50:37 -0700
Message-ID: <20240421125050.6649-8-brandtwjohn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240421125050.6649-1-brandtwjohn@gmail.com>
References: <20240421125050.6649-1-brandtwjohn@gmail.com>
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
 src/sae.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/src/sae.c b/src/sae.c
index 8a1e311a..da55c764 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -906,9 +906,13 @@ static int sae_process_confirm(struct sae_sm *sm, const uint8_t *from,
 
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
@@ -1059,16 +1063,24 @@ static int sae_verify_committed(struct sae_sm *sm, uint16_t transaction,
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
+		/*
+		 * TODO: Sanity-check received Confirm frame from the client. For now
+		 * AP-mode SAE support is experimental and we simply accept the frame.
+		 * Note that the cryptographic confirm field value will still be checked
+		 * before replying with a Confirm frame.
+		 */
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
2.44.0

