Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC53B33E8
	for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768299; cv=none; b=sNN1cCUQjjQOmBSt4a/4VDgF0hFeTQ7jomGjL+Q/srR4nVE5YLWKLjBYF+FhNUghaxEO+nhLCV6a/D2R+qYoQKgcZ3FrJC8XAgFNVp0FbF8bVh5l8yjtFtpsxWHYWEhrdOaZIeZqOStRiplaP393OsEnPSy+P/V1ZEO8RS2wMNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768299; c=relaxed/simple;
	bh=DjnuHBOUqQIAEAUjN0eIYj2/c0mdp7rjjajmtqay9Z4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AYKpUGMzWtOn6tV7ifWbz8trwJO7QT3LnOr4UaPXPhj4vml1LoFaJs6RU1kKdkO+mxLA+oBovjd6JJiKLDv6iuGTl6+weGavRsnhe13nUt1LLfTv1INxvqU/2qDzxv5tJlWUqh1W1663lZFcvW71rZIeg9Tfx6tPuSW2hxHD98s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ug5D2qmF; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ug5D2qmF"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso3754040a12.0
        for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 07:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724768297; x=1725373097; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUsqTRIHYfIQDFSyLvV3HKQlNfsYbPn4HSPK/oWifFY=;
        b=Ug5D2qmFqnjmC0Yg1HZDptscvRgJA8tOWBSv3lCoFD8EYNdH3AA7GYjP56DJ+ZAO5U
         FnmgK53z4kuCwYJqZCAFmxblzaBRcWWlA2v7O2S0v0g4Not8VpCuM7j1l2oafmmoa0PS
         vES765HDWbvmzNAyeVb2yVJ54ou2yVCmrWR4VrHcDg3cyG6ABEv6AZiD2CpqM6l3uVhb
         nn1pC+unKhqb1hcADXF8BlouMMCEvRAITmg9QcD/MGv1UsIzoeg6bVGZLZVyfllc2t+r
         daMTDgOrKqbs1ONbGhoIf8nWlt38VC56FXcg1HhAFuTqzB58TY5vSoNH5JgqBhdWYUU1
         WdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724768297; x=1725373097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUsqTRIHYfIQDFSyLvV3HKQlNfsYbPn4HSPK/oWifFY=;
        b=TVGdFpdQ8pLapQecDxBjEjteIUKSxyp3rnTMz1Vr9CnHYiEAmehpBc3+kzrGZ2+dMM
         Lp73x6OzExPMtVb9hFBTNMjVcHt5qvu970yCt0ctUnJjRbqddkXKFy+/DYfsyjn/6uCw
         5IFI+scOLgVmX0XudIGkDn9N8kBe0+I2XVOI3rtRq/leEVz081SSmpXG9yUE1XX+hwtQ
         tZhLKI9icigwgv9ejfPoAz57Rwp7r+10VOZpA9x+NJr910tgl8EDh71cJ1fb86OZpW3b
         /kLzIStETo1xsSot/e6mS1JoiySQZI2sGyI46G2GswCu9c5SfWxNDPMKxaYHOaKyfX+N
         RqTg==
X-Gm-Message-State: AOJu0YxftLLj9hdXd2FEy/KCcEK3+UPU91fdp+3ErEOTxOK0OuE5iZM9
	lPwCh+ptwcURQ+doqIk2sY5dzdzPxrbi+QX/AlE6V36x8KG8GuU/eLEN+w==
X-Google-Smtp-Source: AGHT+IG3KmsQCgpwUp6A1lc/8dm2+t8IunU7s2ynS7Jb9Xxj1aJHTqGiZpRpbJ7fvNrh3Y4/ZHy4UA==
X-Received: by 2002:a17:90b:4c12:b0:2d3:cc16:826f with SMTP id 98e67ed59e1d1-2d64672be1emr14707160a91.0.1724768296741;
        Tue, 27 Aug 2024 07:18:16 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebbb17d9sm14417205a91.43.2024.08.27.07.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:18:16 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] manager: deprecate UseDefaultInterface
Date: Tue, 27 Aug 2024 07:18:10 -0700
Message-Id: <20240827141810.750603-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827141810.750603-1-prestwoj@gmail.com>
References: <20240827141810.750603-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/manager.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/manager.c b/src/manager.c
index f1aa59c7..5bedfcc5 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -894,8 +894,11 @@ static int manager_init(void)
 	}
 
 	if (!l_settings_get_bool(config, "General",
-				"UseDefaultInterface", &use_default))
+				"UseDefaultInterface", &use_default)) {
+		l_warn("[General].UseDefaultInterface is deprecated, please "
+			"use [DriverQuirks].DefaultInterface instead");
 		use_default = false;
+	}
 
 	return 0;
 
-- 
2.34.1

