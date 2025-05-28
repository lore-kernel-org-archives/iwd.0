Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76991482F5
	for <iwd@lists.linux.dev>; Wed, 28 May 2025 18:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748456052; cv=none; b=orfqtnQm5hmCwv/uQozITHkl1IFS6GWfwFJDLY710yv8y/E4FaOzQMLL36/+mGYv0jwX0i0StiOQIaEsBy7O1F7l3EZdkJfxxfrXgn3a6a4/k5V50qyB/ZWuiwcvvBqZINIltQwS+ik+EhlgAZQy+/92tcdrBmImZt5XNEB/1EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748456052; c=relaxed/simple;
	bh=sO9Vqyo/U7HuSDL5+Nqhh3LPsygRaj8rNuP4fIq80BQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZUERG7cUYCOomtWlZ2jNC2zqMPZx0TI9/JWAs8wzrDdLbLXo6r44p41h5TmcruDn2oAr5SLlBCsmC0cUnnwVf5HvDKzSaxM4cnriehg3zqVQClFh5KzRp8xieDWZMFubIHEEK4GeSbadGLDzw5LSvmcWLM1LxbaMFuC1T65sY1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jwgq/sSK; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwgq/sSK"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6faa4307e15so2191096d6.3
        for <iwd@lists.linux.dev>; Wed, 28 May 2025 11:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748456049; x=1749060849; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kZMPQKiegurkpxWNM46Y0kdom6l1HtJJ+0P6ZmMo0sE=;
        b=jwgq/sSKPBJRMd2Mr7O5AJe2n9sh74pSgsCUPMhE4n/giJrjCv1ulRt2HFTMriNb2q
         adrYvgrST6OyT6cuLSyz9oGkjYzAJXlKY2TLdPQHmk87tkupNiJgtNCssx6a1aBDUmKs
         OUGubsTqltwVZTizty1GxmMeCBGNQM9D7lybIvL3y82P9V6/EWvsH6t/zQIcI4Rwz0XS
         AWOwaY7Ra4fKDK75qjbP+Vijghq2UJxsZNHb9X86QZxCzKC2vUO2W9yZwMOHdl8MTQMm
         nmiQ2GI+U0ZUJGVKVhAUGpPTHXJLigs9vLA8u13QLiaztA3/wKJA9zzbb3mBLZ+5i4Ua
         fadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748456049; x=1749060849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZMPQKiegurkpxWNM46Y0kdom6l1HtJJ+0P6ZmMo0sE=;
        b=rOXAqZJBdpYXyxR9gtmgi//kJ2UmNpqnGFC6HbaaS8qXbCjwsIoheChjqFPfyCzPnL
         V9QuUk8/9yikhHFJQCXgukz+JQa6UljzomxuTejMmTh2YDj7Nr13QfuwaqYnNkIU4DlA
         2X3xdZzW716y8Jd14g2/WenZy4Dkv+2++ec0PH3t1/PNb4DVbbuu21L08y+trTfjQVwb
         3QeomZKSxHWxAa7w1ieLDUSmxJUSkUIY5IwznBKfTXExixzndUwTgGvkIHPDYLZ4kTCL
         vZ5cwRXLNSpznqJ7CoUTABs/NdV6C0RUMQLhEwx1+r7yGumZoXjWLw+08oiwhSQn7KGI
         4Ogg==
X-Gm-Message-State: AOJu0YyUxwvHu/66yBbbQq5aUZvHxPDq32aw9Mw9I+Yyx07WqUAGkvOG
	e1BgGY7qR+q15aZYXI8QHIxBDRHgRCBHh+ACaRhZM8BLA7sh7CUdu/7T0aDWHw==
X-Gm-Gg: ASbGncuz88cELmqE701TeTuwTWGkV44e4bjQuFgDa8C1+Brfu8rb257hBRo6AGfsSA5
	YCGFF1gRhS/TfSJKKw7mjcOKByCLi2wW0fiE/ll2jOz22q3Q337xun0ac9np/a8bnPiTCdCu7i1
	ZKKlfPGiSfNyFQY0p12+cCSbpxnSGEEWBT6SKwRNVZ6+2bFg13RWPaO6oa229IhTl1JTH/QESds
	bG5oBfX/D5ZJCsXA5/kBQPBJMUguDzXLCcArJ2e4lpHop+/BlcyFNoPh2NbbjYvJF2wRONWbzgO
	y27pGtVm775iPsXCPvJwTzTCxTnWEAMbxO025ZjBdewyRSyWWAw0cH53ghXkJA==
X-Google-Smtp-Source: AGHT+IFtM+5rP8nPmmLhBM7Cnf95H10CU1mCj6qzWH0txD8dzBA3BLRkUKUJHefUg3kPrCA4OwhdyQ==
X-Received: by 2002:a05:620a:2411:b0:7c5:a2f8:e6e4 with SMTP id af79cd13be357-7ceecbe7c21mr2432942685a.29.1748456049334;
        Wed, 28 May 2025 11:14:09 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cfb8210a66sm100428085a.46.2025.05.28.11.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 11:14:08 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] sae: check return on sae_send_commit()
Date: Wed, 28 May 2025 11:14:05 -0700
Message-Id: <20250528181405.521001-1-prestwoj@gmail.com>
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
index 3305dfdc..4ca9fa61 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -994,7 +994,8 @@ static int sae_process_anti_clogging(struct sae_sm *sm, const uint8_t *ptr,
 	sm->token_len = len;
 	sm->sync = 0;
 
-	sae_send_commit(sm, true);
+	if (!sae_send_commit(sm, true))
+		return -EPROTO;
 
 	return -EAGAIN;
 }
@@ -1074,7 +1075,9 @@ static int sae_verify_committed(struct sae_sm *sm, uint16_t transaction,
 			return -ETIMEDOUT;
 
 		sm->sync++;
-		sae_send_commit(sm, true);
+
+		if (!sae_send_commit(sm, true))
+			return -EPROTO;
 
 		return -EAGAIN;
 	}
@@ -1129,7 +1132,9 @@ static int sae_verify_committed(struct sae_sm *sm, uint16_t transaction,
 				sm->group);
 
 		sm->sync = 0;
-		sae_send_commit(sm, false);
+
+		if (!sae_send_commit(sm, false))
+			return -EPROTO;
 
 		return -EAGAIN;
 	}
@@ -1294,7 +1299,8 @@ static int sae_verify_confirmed(struct sae_sm *sm, uint16_t trans,
 	sm->sync++;
 	sm->sc++;
 
-	sae_send_commit(sm, true);
+	if (!sae_send_commit(sm, true))
+		return -EPROTO;
 
 	if (!sae_send_confirm(sm))
 		return -EPROTO;
-- 
2.34.1

