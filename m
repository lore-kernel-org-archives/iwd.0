Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42FE347B0
	for <iwd@lists.linux.dev>; Tue, 10 Oct 2023 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpCp+zkg"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6934202b8bdso4664621b3a.1
        for <iwd@lists.linux.dev>; Tue, 10 Oct 2023 06:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696946229; x=1697551029; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8rZsKz3kuPjzOGAX7c+tlxaRnMVCQ281fEYBhf1FIA=;
        b=JpCp+zkgjSkPIuLYNeMSZWZbFBCrvNHdl9ww5N9nWTuLCRcYxy/GePCyCKtxbV3wcA
         SfyvZOEejkRNQekaCoACfejR2sEPVOkGKXrL+08KUpG3sKjRq0AugDPGI8zxv2p0FPS1
         jeEn929yDjrJzMrdmNleG3vsjbAJLQILEUQ/P0D5VBoMB4vJSLlZh4CmIe7hA5R8ErX6
         Kppd33T10tDjaHOFV8XcSI0McufGJAoIANUtrCOV4g4TSEIrGHqbLAzncc3CynjQrpTI
         +j+S66p2mZxQ0/QaXVbbofcUZVKrXZ1sjfnsJ1uOROBosQVEawqclaE+B5AAOPvpzeXo
         uxig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696946229; x=1697551029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8rZsKz3kuPjzOGAX7c+tlxaRnMVCQ281fEYBhf1FIA=;
        b=PhUOmPNL62jYsuBev9XciIH7iWUPxIjZ6K7p4TCneLuS4q6xCPf6HLU+HJC0djGVQp
         Ex0eVsKRDpQVRRAeUohSRtAkVK3u/clYvj8CXneCJ5BfCl20c7mH3wUs19/Ncr6jV3CA
         AuP1PnwonEjexLqAY74fsawUFpVbPfWKIbdNa41rw/muWodMBmXgqmqgQ4M8GOYQqjjd
         Hs5awC7k4Cqd5cY7Ww9ko3qJYYIuvnPS9jWcrM3JsLWlT66zpXoNZiDeY14xnHrulVXJ
         tSoHL96uqo+7tb0etW7kV854HktrjHAr264OvowpZxrBDxT+xTZlFTioaCNieuG77xLr
         t9Ig==
X-Gm-Message-State: AOJu0Yy0x6BNSDFelzCi+zQJNaVu6XpP6hVU6EJCCS7m3ZzFnOwz7XpP
	NCVutqpdDJ1vJe7AGrx16czMaWKSkzA=
X-Google-Smtp-Source: AGHT+IFIPU+IAJ9rklsuLyszu21jvmWqo+Kddn31/TWaN5zJxrb2zxrNsT91LwELN6s26ev0x3Z5gA==
X-Received: by 2002:a05:6a20:1596:b0:15c:7223:7bb1 with SMTP id h22-20020a056a20159600b0015c72237bb1mr22845421pzj.20.1696946228839;
        Tue, 10 Oct 2023 06:57:08 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id b10-20020a170903228a00b001b03a1a3151sm11830364plh.70.2023.10.10.06.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 06:57:08 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] sae: fix usage of compressed points (after ELL is fixed)
Date: Tue, 10 Oct 2023 06:57:04 -0700
Message-Id: <20231010135704.198723-4-prestwoj@gmail.com>
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

SAE was also relying on the ELL bug which was incorrectly performing
a subtraction on the Y coordinate based on the compressed point type.
Correct this and make the point type more clear (rather than
something like "is_odd + 2").
---
 src/sae.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/src/sae.c b/src/sae.c
index cfd4d650..336954b4 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -511,7 +511,29 @@ static struct l_ecc_point *sae_compute_pwe(const struct l_ecc_curve *curve,
 		return NULL;
 	}
 
-	pwe = l_ecc_point_from_data(curve, !is_odd + 2, x, bytes);
+	/*
+	 * The 802.11 spec requires the point be solved unambiguously (since
+	 * solving for Y results in two solutions). The correct Y value
+	 * is chosen based on the LSB of the pwd-seed:
+	 *
+	 *     if (LSB(y) == LSB(pwd-seed))
+	 *     then
+	 *         PWE = (x, y)
+	 *     else
+	 *         PWE = (x, p-y)
+	 *
+	 * The ELL API (somewhat hidden from view here) automatically
+	 * performs a subtraction (P - Y) when:
+	 *     - Y is even and BIT1
+	 *     - Y is odd and BIT0
+	 *
+	 * So we choose the point type which matches the parity of
+	 * pwd-seed. This means a subtraction will be performed (P - Y)
+	 * if the parity of pwd-seed and the computed Y do not match.
+	 */
+	pwe = l_ecc_point_from_data(curve,
+				is_odd ? L_ECC_POINT_TYPE_COMPRESSED_BIT1 :
+				L_ECC_POINT_TYPE_COMPRESSED_BIT0, x, bytes);
 	if (!pwe)
 		l_error("computing y failed, was x quadratic residue?");
 
-- 
2.25.1

