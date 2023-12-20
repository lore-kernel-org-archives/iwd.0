Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E545C2554B
	for <iwd@lists.linux.dev>; Wed, 20 Dec 2023 13:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POE3WztX"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bb69bfdd96so312850b6e.1
        for <iwd@lists.linux.dev>; Wed, 20 Dec 2023 05:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703077934; x=1703682734; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LvmFgFondgk5j95mpyYVC3tI+V7ZP2BtN2K2TDXIRuo=;
        b=POE3WztXCFiiH5P1GU6r//0w+V4NKnI8QujkTAXwQ6dkeAJxd5dK6UpYLM5op6qO+K
         J2egifpngzBwwTQnQzxLOefCcZCaSBtSxdLoOuCywH7tNDtd4P3crAoZNIFRHmqzte84
         8XOfLOezYqQwWqEqKMLSyHRZR61nb3Uzt7U2/ToWLBjp9a8moDjLNTSyH4vNcKH8yl9i
         7UGzBv8zV7ftd9zGEtbaa5SlF4sqfuIsYkdwV4FlkySlOR8j8jWxR86CBg0vbhfh/f+u
         E1oHLhBULmfnjQCUBYolqgr2XqjnYJI1bDWFSAt+9yY92/bC8LL2O9EyygyjHP1Dboj+
         GEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703077934; x=1703682734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvmFgFondgk5j95mpyYVC3tI+V7ZP2BtN2K2TDXIRuo=;
        b=Y5CmOtHfaf4TBt2PKVkHezZ8rfLPt4kdh+LJeEWRsQvYq80yJKkHetHUQFsVOYi9mb
         dgPW1vocKNmBNNkyKihdMRC1n3GpT6ZZ7t4YHIHRz9l7Rem+9Hb09sTH0c8np8abGET+
         il2vA21pQF3q53r1qjDVO8i6cvsT2TzlqDp9Gq3xMoW/oMGOb5RNLyaOMRWfL0MwVu75
         7D/WI2gWYUNFoQRgvY/QuTz8lQcUivUGBQMS/NAr9RooWpT2uC+Gkzvpyt5VdyNHQWEa
         jUFZWWj0kDifjdflpJ7vxXlzNhsZs+VP2Atr1fAMNkpBf+l/7JU55da4J/vCesa7igc9
         hPeg==
X-Gm-Message-State: AOJu0YzM2+FwCu8VAPpyaV69DLGi8drSvk8Um+7CKtxpZszAj4Ro1T2K
	xJ02JsYbmnS8hcB0BStKjj1IYwqg/WU=
X-Google-Smtp-Source: AGHT+IF9F1bSEvmw6DyJubJhzUwVP5gC6NMgMfVd6T9hFZxkxE6hUL8CPI3Ydwp83ApKplnPW0CLXA==
X-Received: by 2002:a05:6808:de6:b0:3b9:d5e6:2f7c with SMTP id g38-20020a0568080de600b003b9d5e62f7cmr990801oic.49.1703077933855;
        Wed, 20 Dec 2023 05:12:13 -0800 (PST)
Received: from LOCLAP699.barrett-olive-branch.locus ([50.222.209.222])
        by smtp.gmail.com with ESMTPSA id j15-20020aca170f000000b003ba3a9c553esm2109591oii.30.2023.12.20.05.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 05:12:13 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/7] station: use network_roamed
Date: Wed, 20 Dec 2023 05:11:58 -0800
Message-Id: <20231220131200.267489-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220131200.267489-1-prestwoj@gmail.com>
References: <20231220131200.267489-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/station.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/station.c b/src/station.c
index 4facc0bc..10860808 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2106,6 +2106,8 @@ static void station_roamed(struct station *station)
 		L_WARN_ON(!netconfig_after_roam(station));
 	} else
 		station_enter_state(station, STATION_STATE_CONNECTED);
+
+	network_roamed(station->connected_network, station->connected_bss);
 }
 
 static void station_roam_retry(struct station *station)
-- 
2.34.1

