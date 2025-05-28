Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E4A21A453
	for <iwd@lists.linux.dev>; Wed, 28 May 2025 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748463033; cv=none; b=Le9WgKp4F/CzyYwj6JBYDlnv97LMlQVGGD1bqkffXHBBQZiK72zU/PxHe3OsWeFykdlyMU4+SIVsitYI/6bI54u7drgPGDomOg+gc/gd88wJIVABpF3SAqCCua8JJ1wefk9q7ONSmFhGwIg64jFTPaw7inEXr0ALiTygngWPdE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748463033; c=relaxed/simple;
	bh=GHSevJ8knEOKjyZ5raKfwt5csvl+ViHAqdwr2b2WpXA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QlX36LYgsEiJ90Dug0zOisV7Vj+pNQ6JlXlXkWobiGcQtoJUxGs6dApP3buqg3WKE6dQ4a1g+hfb6UwddLdRaWt9kp4T/2IvYw8E6rx8/CKRprW75IJfRwdP81mDh1mk1rZfBVuRD/4j/cXds0CvR7FskDrs1c4QrE55zLDJ2ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvS9XbE+; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvS9XbE+"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6faa01a3a5cso2546896d6.1
        for <iwd@lists.linux.dev>; Wed, 28 May 2025 13:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748463030; x=1749067830; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JGRh86TaHY0r3emH96RLZ48Dl4YPJHbc6osprZa9/Qc=;
        b=hvS9XbE+tQUsUCyIbc/T38yKJ+Qptg0xnA3IO/aT/giAmi7T0giHzUaShViGtcUCGW
         hjGDg8Ln/1voO18S0NUsQ1c1JQz+EWmlHwD4mCtntE31c/ohDmA+DruYDm759HD8WAT6
         N1vUZCaeK+U7asEWLdfSB5h2h26eDfosgz62e5kLvb8tEnNLNK8Jd8RAqNKG5RkSEwbn
         86iHPrCbTh7dcTZIUr2EHViMarVgfqG6lFjR2025JCu1sdyXCWVtQol22ldBqc0SVv8S
         W8GXJ2MBP3ZPPsEH0otP13MLI2qXaTuDapAeqG3x67lQQSL9unZlbhw4H5QSyTt1Oq8J
         RltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748463030; x=1749067830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGRh86TaHY0r3emH96RLZ48Dl4YPJHbc6osprZa9/Qc=;
        b=mQYs/BwYU3qf9Kck0572ybfx73AX52YMT2KQHk/6eP6W45gcc7wE8qFY5/dkHKVz7T
         VBIRtv+lajaFO17GpNEaoPRKJlirBVbUyasG/nUmaGthJDHRQOicL2tfvajUg8JjjP3Y
         qlaGbZMt+Lz5Gwo5Qcoglx4WR3/XxKvIOklsIxgxtcCx8ip4MxgsXtIaWzDxDlQR/CAv
         UUL/GIvwJn8WiUYVQEqH6lmtLBwLEcLneEnQ1Wuhjs3A8aSVI3n3/bilkR3AhS00yP16
         cGwwWk1Wj+dHHaPHJUc1MPr0MYqSobuCaSEFO6clvcRF8Tq9kAcXhGTbHxoJsoZt8mL6
         7RSA==
X-Gm-Message-State: AOJu0YyhZjW1k1MhjIcig8m3m/xoKpkX8cGwcdATAzrpECqnPfbjzU9P
	FFtKBBCJYzNiG5PvnWtiBom1Bd+mIJ0OqbmiTeoiHiPEdJQaol/+Rr6uabwUog==
X-Gm-Gg: ASbGncsg6O/UMgM0UGCSzt6LslQDkQe2K/n8/+28yx4E3pZtgsY9QdyrqWE/DHspwU5
	jmMNrWO68KLwCzdQg7QQmTK6hIu2/HuGc0CTI9kca+nt7RUhqLrVdrZ29LZJ9jaYpdxZTqNUbGW
	6DO2aElqOMzPAgK/yCpTBaYsIronn/low9F5rJEcnkCOwjp0YA351gvNWnhRcEDY6b2CP7y0PWX
	TyHdvbeB6g9lg7zwegQFQ5pPk+htvbFmvZix3za3j/FbJLrhvZRSiR0ydpqEnzOKpn+UDT8ng+S
	IM4qxR9nmUQgXlrAqR+BYBnwoWzgGpDameXuCPM1yohWTjN18d3pnvI3uLQMkQ==
X-Google-Smtp-Source: AGHT+IFhP0tXL4b5MfhU+pWBxc+u32c8hVueZ3ZJFevZ8Imal9fSjp3l6KC4fFMMKiSwRA/tIZJnAA==
X-Received: by 2002:a05:6214:d0f:b0:6fa:c512:c401 with SMTP id 6a1803df08f44-6fac512c40cmr22775036d6.37.1748463030438;
        Wed, 28 May 2025 13:10:30 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac0b2888asm10408126d6.45.2025.05.28.13.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 13:10:30 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/6] network: make clearing network blacklist a separate operation
Date: Wed, 28 May 2025 13:10:21 -0700
Message-Id: <20250528201026.598221-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a new API network_clear_blacklist() and removes this
functionality from network_connected(). This is done to support BSS
iteration when netconfig is enabled. Since a call to
network_connected() will happen prior to netconfig completing we
cannot clear the blacklist until netconfig has either passed or
failed.
---
 src/network.c | 9 ++++++---
 src/network.h | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/network.c b/src/network.c
index 4602a110..588ea5ae 100644
--- a/src/network.c
+++ b/src/network.c
@@ -168,6 +168,11 @@ static bool network_secret_check_cacheable(void *data, void *user_data)
 	return false;
 }
 
+void network_clear_blacklist(struct network *network)
+{
+	l_queue_clear(network->blacklist, NULL);
+}
+
 void network_connected(struct network *network)
 {
 	enum security security = network_get_security(network);
@@ -198,8 +203,6 @@ void network_connected(struct network *network)
 	l_queue_foreach_remove(network->secrets,
 				network_secret_check_cacheable, network);
 
-	l_queue_clear(network->blacklist, NULL);
-
 	network->provisioning_hidden = false;
 }
 
@@ -207,7 +210,7 @@ void network_disconnected(struct network *network)
 {
 	network_settings_close(network);
 
-	l_queue_clear(network->blacklist, NULL);
+	network_clear_blacklist(network);
 
 	if (network->provisioning_hidden)
 		station_hide_network(network->station, network);
diff --git a/src/network.h b/src/network.h
index 849051dd..061f47ca 100644
--- a/src/network.h
+++ b/src/network.h
@@ -74,6 +74,7 @@ bool network_bss_update(struct network *network, struct scan_bss *bss);
 const char *network_bss_get_path(const struct network *network,
 						const struct scan_bss *bss);
 bool network_bss_list_isempty(struct network *network);
+void network_clear_blacklist(struct network *network);
 
 const char *__network_path_append_bss(const char *network_path,
 					const struct scan_bss *bss);
-- 
2.34.1

