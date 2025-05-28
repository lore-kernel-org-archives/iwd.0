Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2192221D3E9
	for <iwd@lists.linux.dev>; Wed, 28 May 2025 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748460487; cv=none; b=JUh7/j6cLXW4/9jyPdJoa/FsqOTQ1ASxM8R9wmH4o4edlCZcIVyKppAhxTpV4c29bECShbAfaB95iw1Oph66jBK9aJRlxaEyYlosxsYgtN9qDDPl6qoUbhWTW4C1EZw3YZE8ZUsxPmU1xJIGqez2/670LVIESp15b2T831xdloI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748460487; c=relaxed/simple;
	bh=e/Ku+IiCT5OyYaAto4SYQGyzD+/AqhxDIq4o8wo3so0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dxPXQcdT0nSDrMwMTy+4QhCO75O5v21gAUgP9an1G+90SbKGJrCZj7ZZK8gPmU5T7DdsaIncCPq7nN0o1fjTRmByEDVj++M3M4MZwXvyRQ57jTtTUJDSFxQkR6PvqZWyOZGJP9pJA+6z5MWyVnrmf4Pcef8hel8LOUAtpKwibwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgRJ5Jws; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgRJ5Jws"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6faa5c69550so2700966d6.3
        for <iwd@lists.linux.dev>; Wed, 28 May 2025 12:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748460485; x=1749065285; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0uxIflcmTv72ZL+LXWqwaFNOZAFpyJkwGCr3ZB7wRIk=;
        b=lgRJ5JwsHnRk32PH68KdKU3YxlW6KAbPx6VJszuWCeMi5omgoQtiZi7ej33KWtx1+9
         XjUxryhCN67S3ThLZpKgpa+3m+vabJC0XXg98e6+l/a74GJfmCXtL47iFjFmrHozHKAT
         vw+Lh7IjBldzfOoqNwYdvLRkE+5npbceY2YB3xRcvQl5QmwNRyR69D79Zj4j2y/nf7qg
         2xMZ+iWXIEofPn2fYbqdpgtJODI7+wyLGhWtEzVvRUA3a9gamUo4HcHS7qvhm9oRUi9V
         MK7r7HtWpa/ajwfRWSjqqXIKp3Bv4Wr0FNlgsQUGdex6Kzar3qL3r4pg/xr0PnOLMWzm
         ABhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748460485; x=1749065285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0uxIflcmTv72ZL+LXWqwaFNOZAFpyJkwGCr3ZB7wRIk=;
        b=Z3fcGqnQfwjNVp0pqxecKA0+uwyVGebFQ44wOhDYRnswylvJj4iIEo75OAUOOk7k8e
         IpC4hAIk6aIii0kdszCEJxtHpjuZ23Jeqv4azjSc1RlPkz77Vs+IVuTnD3QlKVUzzu/l
         sAZWD8cCC8nZpcGysaheE69JRUEVsqoSAOnDZY2H4H11JafUvhZ58TT/h75mkPK9gujz
         V5EnIWF2hj8Dqd3EoHTAJ9Id3PHR3J/nFybGb3npUuJKUqdkEIQDZdNyEdjoJVKkTHq7
         9qAFAJdS+f+5D13XycW66DorMGZnj45om1wG0j+PxHoMMv32i7C3XCYjy3SK/Bn7pyOy
         VdbA==
X-Gm-Message-State: AOJu0YwBo+S+W2oUjGvd+QPHlbviN9pkaFw7txd2Qzoz24+LjhK/dSbF
	DTHneb5nY8OBm3M2wqhzmfk0X+qH6OcuobeRMF3RxwUofWYRK4vWr3rDYLJ4lw==
X-Gm-Gg: ASbGnct9UM6EZ6xgdhvfC3uZ0uoiEmf5GaxETK/vmBWvVhNpIz4l16eN1vdIFtkgv2R
	mxH7Y1YJrsyTUx6gVoIEZ/LCrJAPakLdv2Z8rUaUukDdoZhUI2CAWXHOR/cCrU2esnejPUSLEGm
	SPwukHp+FZ8ko8YM1oeFI3i4xnSSBlhGAvkFQBSgU3Kum4XgiIxxv6b26YUAHKfrVzEy89A0/9z
	3SFZCn9OU/i9N7cDlGl3kJEHbAjR5CC9fvsc8jq7v79Sc6gxi4wSlCJpoqSBaCG1MQeygcQlb12
	OGhC82/AP7iUTnhSrnaRz60w30El6TCxoBVIXEOiQec5ms9Oovz9q6/w8mWDy4xlQfwPvqTA
X-Google-Smtp-Source: AGHT+IGBwjAtNJxqNWzZYKq9vF8JQINmMSPAaaeRENcFcXkLd1YiM/HCwwkyd/qo89rHB779OnOUQg==
X-Received: by 2002:ad4:5ec9:0:b0:6f2:c7b0:3b16 with SMTP id 6a1803df08f44-6fa9d157088mr257150046d6.6.1748460484653;
        Wed, 28 May 2025 12:28:04 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac0bc7bbcsm9987626d6.96.2025.05.28.12.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 12:28:04 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/2] sae: check return on sae_send_commit()
Date: Wed, 28 May 2025 12:27:58 -0700
Message-Id: <20250528192759.555623-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If this fails, in some cases, -EAGAIN would be returned up to netdev
which would then assume a retry would be done automatically. This
would not in fact happen since it was an internal SAE failure which
would result in the connect method return to never get sent.

Now if sae_send_commit() fails, return -EPROTO which will cause
netdev to fail the connection.
---
 src/sae.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/src/sae.c b/src/sae.c
index 3305dfdc..87e64041 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -994,7 +994,8 @@ static int sae_process_anti_clogging(struct sae_sm *sm, const uint8_t *ptr,
 	sm->token_len = len;
 	sm->sync = 0;
 
-	sae_send_commit(sm, true);
+	if (L_WARN_ON(!sae_send_commit(sm, true)))
+		return -EPROTO;
 
 	return -EAGAIN;
 }
@@ -1074,7 +1075,9 @@ static int sae_verify_committed(struct sae_sm *sm, uint16_t transaction,
 			return -ETIMEDOUT;
 
 		sm->sync++;
-		sae_send_commit(sm, true);
+
+		if (L_WARN_ON(!sae_send_commit(sm, true)))
+			return -EPROTO;
 
 		return -EAGAIN;
 	}
@@ -1129,7 +1132,9 @@ static int sae_verify_committed(struct sae_sm *sm, uint16_t transaction,
 				sm->group);
 
 		sm->sync = 0;
-		sae_send_commit(sm, false);
+
+		if (L_WARN_ON(!sae_send_commit(sm, false)))
+			return -EPROTO;
 
 		return -EAGAIN;
 	}
@@ -1294,7 +1299,8 @@ static int sae_verify_confirmed(struct sae_sm *sm, uint16_t trans,
 	sm->sync++;
 	sm->sc++;
 
-	sae_send_commit(sm, true);
+	if (L_WARN_ON(!sae_send_commit(sm, true)))
+		return -EPROTO;
 
 	if (!sae_send_confirm(sm))
 		return -EPROTO;
-- 
2.34.1

