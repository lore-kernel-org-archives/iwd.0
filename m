Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D01214658D
	for <iwd@lists.linux.dev>; Tue, 19 Nov 2024 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026284; cv=none; b=YjKu2+VKa00SZoEg/QOCpBqV/6qegKBEnt/8UNg4WyIjblN+vRn4zsh7ioOUL/1WDSoUq3JUkeQ/D2bHF5znzkGZGLwgSoAgIlHRYHsv7a+x46SpOEpiMnLbpNSJrvTCO5WfC3L48sdJOvRhNHt7bz4jMK7CRowuvWxecsgEb94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026284; c=relaxed/simple;
	bh=e5WhAp3OZKnYz512TSi9RyyBFogrh5qzLsHWOL/kCkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dKsqGmmwZHB2IuADfOc5G+DAeecrdeKRr2MINO6VUzWkJvLfRJmoGaOIWlbkErffHYumBrIAgJi1Sqly65XUxgkLQw2rmvkRhSxFDdM4T18eYpFf7gFJXaLEwg84cOQhsUy31nuN5NB2wW8Jg4593HmwVj4kXeBUkYkT4iwSmO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e78O489X; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e78O489X"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21116b187c4so23248765ad.3
        for <iwd@lists.linux.dev>; Tue, 19 Nov 2024 06:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732026282; x=1732631082; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naKvJExB+FpupQscRR3Z9VDlualxusR9hLF+5prY9zQ=;
        b=e78O489XOSE6/1rq/WrSDNeGtoEtUP7E/7G+svRZW6ozwlmDxGhT6Lx6vQpTR0EJSO
         61rBjwSbDYrZH073cPkot68bMn3mWgzYgLDEnxbEs/OVt/ECLW5CzzqiXKLwBRQtH0Ew
         djKE5myLs+CfgNSaqzNG+qJBY2YoZ3wD8Q6B3hxNgyRlxboWULP8FolIkc/pW6CMz2+N
         /J+FlHpqZ/OLTcZHDxHD5KutWOXixUZWyHEZxXluWvn0HEaN1tul1FDLXWtB3+8zSrm4
         eed+NCjNbeX+yv1ey3nDUUt+amlhL/rUR9dkUHdtuzwSz2rb2Z7oSUngwNXFERTM/kiS
         JYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732026282; x=1732631082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naKvJExB+FpupQscRR3Z9VDlualxusR9hLF+5prY9zQ=;
        b=FPTtpk/2uW7426tYfd8sq1/hWU2DKXeSU+BONRtcq1iIAhnPMEGH7j440dfJTx+PG5
         Q4J6t8MyNjW+Msgs5oCYCZ5GDjepBs4fsx7o5tK19iIctf8unDtrL9cCkyVH+mZZuR12
         c/XE5phrOboGgxQwpBoZ/c9hcMeQmdUmo4CXlpMsC3WwPGVbZ7JZG/eB2kEqjscbqWtw
         SQBbzCzUzIqg0PxYFJs/mRmARYhs8Vk6K3YMSkRKtM1Ub8RNnAUKwON/tojMhO3LzLFo
         I27RMXwN3RNI5cJuL+xEv8uHAaQfDTzIE+o8lFoxWxk+/w2bT/sbxRXMil7FeLWbn8eP
         mkXw==
X-Gm-Message-State: AOJu0YzvHCrowuvs4eH6MQHFRo3xMNvAU5M4jdj7xCY8TSfortzGVB1n
	T7+DUHX8NPBYJ224k6cc2R81pLdGtdq6wa5zEjCNHCJG5ukG70fvf/Tnig==
X-Google-Smtp-Source: AGHT+IHl/2+iGOdg9KCXlYHO4JY0NMULJYHqxHFItfSNxwrWsvXQ6Uy5noI8O80R13lTA74l6ebuIQ==
X-Received: by 2002:a17:902:e54c:b0:20f:aee9:d8b8 with SMTP id d9443c01a7336-211d0d72ac0mr187971495ad.20.1732026282280;
        Tue, 19 Nov 2024 06:24:42 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212389529b6sm29219115ad.236.2024.11.19.06.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 06:24:41 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/8] network: use util_exponential_decay
Date: Tue, 19 Nov 2024 06:24:26 -0800
Message-Id: <20241119142430.323074-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119142430.323074-1-prestwoj@gmail.com>
References: <20241119142430.323074-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/network.c | 35 ++++-------------------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/src/network.c b/src/network.c
index cd8b0ee9..0a40a6c5 100644
--- a/src/network.c
+++ b/src/network.c
@@ -56,6 +56,7 @@
 #include "src/erp.h"
 #include "src/handshake.h"
 #include "src/band.h"
+#include "src/util.h"
 
 #define SAE_PT_SETTING "SAE-PT-Group%u"
 
@@ -212,31 +213,10 @@ void network_disconnected(struct network *network)
 		station_hide_network(network->station, network);
 }
 
-/* First 64 entries calculated by 1 / pow(n, 0.3) for n >= 1 */
-static const double rankmod_table[] = {
-	1.0000000000, 0.8122523964, 0.7192230933, 0.6597539554,
-	0.6170338627, 0.5841906811, 0.5577898253, 0.5358867313,
-	0.5172818580, 0.5011872336, 0.4870596972, 0.4745102806,
-	0.4632516708, 0.4530661223, 0.4437850034, 0.4352752816,
-	0.4274303178, 0.4201634287, 0.4134032816, 0.4070905315,
-	0.4011753236, 0.3956154062, 0.3903746872, 0.3854221125,
-	0.3807307877, 0.3762772797, 0.3720410580, 0.3680040435,
-	0.3641502401, 0.3604654325, 0.3569369365, 0.3535533906,
-	0.3503045821, 0.3471812999, 0.3441752105, 0.3412787518,
-	0.3384850430, 0.3357878061, 0.3331812996, 0.3306602598,
-	0.3282198502, 0.3258556179, 0.3235634544, 0.3213395618,
-	0.3191804229, 0.3170827751, 0.3150435863, 0.3130600345,
-	0.3111294892, 0.3092494947, 0.3074177553, 0.3056321221,
-	0.3038905808, 0.3021912409, 0.3005323264, 0.2989121662,
-	0.2973291870, 0.2957819051, 0.2942689208, 0.2927889114,
-	0.2913406263, 0.2899228820, 0.2885345572, 0.2871745887,
-};
-
 bool network_rankmod(const struct network *network, double *rankmod)
 {
 	struct network_info *info = network->info;
 	int n;
-	int nmax;
 
 	/*
 	 * Current policy is that only networks successfully connected
@@ -250,12 +230,7 @@ bool network_rankmod(const struct network *network, double *rankmod)
 	if (n < 0)
 		return false;
 
-	nmax = L_ARRAY_SIZE(rankmod_table);
-
-	if (n >= nmax)
-		n = nmax - 1;
-
-	*rankmod = rankmod_table[n];
+	*rankmod = util_exponential_decay(n);
 
 	return true;
 }
@@ -2018,10 +1993,8 @@ void network_rank_update(struct network *network, bool connected)
 
 		L_WARN_ON(n < 0);
 
-		if (n >= (int) L_ARRAY_SIZE(rankmod_table))
-			n = L_ARRAY_SIZE(rankmod_table) - 1;
-
-		network->rank = rankmod_table[n] * best_bss->rank + USHRT_MAX;
+		network->rank =
+			util_exponential_decay(n) * best_bss->rank + USHRT_MAX;
 	} else
 		network->rank = best_bss->rank;
 
-- 
2.34.1

