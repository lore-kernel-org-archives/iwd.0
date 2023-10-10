Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A55341BC
	for <iwd@lists.linux.dev>; Tue, 10 Oct 2023 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeLre51z"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1c7373cff01so49302125ad.1
        for <iwd@lists.linux.dev>; Tue, 10 Oct 2023 06:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696946228; x=1697551028; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pxCFOGBQ6k2XnK8vVNfmg3MqVePjRgbxQ5V2oT2ivg=;
        b=WeLre51zz/bu2sX38d9UggcagQ0PzAredqFDeUVmbIdko1nZ+te+OUzbFB54cdW6jR
         iM3WRwLVJnf9VQfaK8NKsx6JL+qUQ5dr0LqybaSMbvkhr4EbC5bMUJHoSlLgpJ9mBfj4
         HpQOE4QPN2vswIHivDh/FvYl91ACsiZxnQ86FKsLH4XCoOol5ApdYMni3Th/Zq6Z7Cuv
         FrPQo2wPzbsw1YkfIFfuydJhVDNtW7+ZLdIuzGxhU2AG9jcML3RxEwkCmXmuWc7u0kbu
         +k+e6XE4rDXEiBYJ0e/nSfOKvYj4oRHmHNBOzN8UggglIrrwSMkE7x9fIaOQwnQI12kV
         Osxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696946228; x=1697551028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3pxCFOGBQ6k2XnK8vVNfmg3MqVePjRgbxQ5V2oT2ivg=;
        b=xK/w7FM842qEMQY0FFcAsv966StyB3yIwJr50rXu1mN2rof78V4Q3a2q5sg9D+NYk0
         oQENfzKgrcZSQTFcuDhfIku3DJ/XhM7euOpyTtgCGbWmLBlz38fRRCuGhFT926I5HoJ4
         PTtDnBE9uYr6tyn5EG/SasxoX9q+7FxFnD4SrgLxifatyFnMycNqG/DoAa2vrb/fn5Ka
         +/5mO8R8BOlOJNpO1KHE3re76kGDFtxNUA9Dgk6W29zY4EywvfLepAp0BS/Bncb1zLs0
         Hkq7rLSeqwQo7t0BeEykdjfhqrAAJlCA77KqlFizkWYbgfAcfM4ehkBYcBp109aE/YZ0
         85dQ==
X-Gm-Message-State: AOJu0YwxrobzScZTvajwOF5Ha/31Vt1XhGJj3lsP5ilB+IqLikXoXBqu
	efPcobt8cBr5x3aR5MkP7/4glwrq+hY=
X-Google-Smtp-Source: AGHT+IG6ajOzM6sXlhH3DRmf5xAd+enlevQja1+k8Mj2ITEtNDzwe36aku4CTYh2T3KSylmOo4tvfA==
X-Received: by 2002:a17:902:6505:b0:1c9:b57c:f269 with SMTP id b5-20020a170902650500b001c9b57cf269mr1781160plk.32.1696946228254;
        Tue, 10 Oct 2023 06:57:08 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id b10-20020a170903228a00b001b03a1a3151sm11830364plh.70.2023.10.10.06.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 06:57:08 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] eap-pwd: fix usage of compressed points (after ELL is fixed)
Date: Tue, 10 Oct 2023 06:57:03 -0700
Message-Id: <20231010135704.198723-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231010135704.198723-1-prestwoj@gmail.com>
References: <20231010135704.198723-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EAP-PWD was incorrectly computing the PWE but due to the also
incorrect logic in ELL the point converted correctly. This is
being fixed, so both places need the reverse logic.

Also added a big comment explaining why this is, and how
l_ecc_point_from_data behaves since its somewhat confusing since
EAP-PWD expects the pwd-seed to be compared to the actual Y
coordinate (which is handled automatically by ELL).
---
 src/eap-pwd.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/src/eap-pwd.c b/src/eap-pwd.c
index cd6684e7..5aa51668 100644
--- a/src/eap-pwd.c
+++ b/src/eap-pwd.c
@@ -320,7 +320,27 @@ static void eap_pwd_handle_id(struct eap_state *eap,
 				strlen("EAP-pwd Hunting And Pecking"),
 				pwd_value, nbytes);
 
-		if (!(pwd_seed[31] & 1))
+		/*
+		 * The RFC requires the point be solved unambiguously (since
+		 * solving for Y results in two solutions). The correct Y value
+		 * is chosen based on the LSB of the pwd-seed:
+		 *
+		 *     if (LSB(y) == LSB(pwd-seed))
+		 *     then
+		 *         PWE = (x, y)
+		 *     else
+		 *         PWE = (x, p-y)
+		 *
+		 * The ELL API (somewhat hidden from view here) automatically
+		 * performs a subtraction (P - Y) when:
+		 *     - Y is even and BIT1
+		 *     - Y is odd and BIT0
+		 *
+		 * So we choose the point type which matches the parity of
+		 * pwd-seed. This means a subtraction will be performed (P - Y)
+		 * if the parity of pwd-seed and the computed Y do not match.
+		 */
+		if (pwd_seed[31] & 1)
 			pwe = l_ecc_point_from_data(pwd->curve,
 					L_ECC_POINT_TYPE_COMPRESSED_BIT1,
 					pwd_value, nbytes);
-- 
2.25.1

