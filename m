Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C581F932
	for <iwd@lists.linux.dev>; Tue, 10 Oct 2023 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRl0ANtW"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5859e22c7daso3616826a12.1
        for <iwd@lists.linux.dev>; Tue, 10 Oct 2023 06:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696946228; x=1697551028; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6FnZaOAUBMa6UG5nkGioyGUUnm/qc/lpqAgmpjoqfQ=;
        b=gRl0ANtWNSof26mkEDT4zIdbTfBhAv5hUdTZMSIqcBVsy+ilBglLiQrThJKET0AbLa
         AT/wY6c5gmDEIty8JXjlFBBmViSSa2DP8PZSC3/m8mvfiSyI4c2w8atHCbVlgoGn+aLg
         OPTjs5P9KP34opn/3SVgk68Ejge4SZDiRlg60Yu6o3UfPItl350/uQQp7nHWxpExzIC1
         2onbcjZEmcMYxgahWYwnE4dKKm75/i6Ln+KXAX30p67N3enw9vE0wcKwfLnfb2bmmTiJ
         JCVEliebtv7Gyxc4xNtaJCC6BhKNl8/MNjKMfldegP1JLyMH2pSOJMOU9f4thoKsBUEr
         5AIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696946228; x=1697551028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R6FnZaOAUBMa6UG5nkGioyGUUnm/qc/lpqAgmpjoqfQ=;
        b=dh0k+vwOodkJuGPXYArQ+nK8HYc6DWdb4tvC2pOrZ0cEKf4CKCMoZzLVrQ4K4WXlWp
         0EFKJ4YdgrONi4GnrPE6/T+iLpSrIox758e0czYoJ+PYKWid8MXmg/eGMYhu9bQfnkfH
         OxcZpSYzu7nvnHBsFC/H8iauyYh9Q343ftJ8bQDWBjlohy58V3/hyNHGoz9zn07Ccyp+
         i3+MMG/DuGGVdU4qZfyz04mlPun8MqUaANaY9iUKn075VvVsEbq0h1kuTj3Xx1xCGCDQ
         W060v0HdaQT+ctSdP88o8lHbGGLYRVT7B2C7ciAiKbjpYCIV459WdTjDo8qB5MBx7bOz
         4Atg==
X-Gm-Message-State: AOJu0YzeEFBn4UCROuE3PkZdyQBW2fx5t3meyWifk7tVaN+5Nqs5RsgS
	gbK+j1q1eLqDSS+/oqlNtZoihnMnNGk=
X-Google-Smtp-Source: AGHT+IFxIYcIMSR+0ujUe1ZY8ttwWejKFD53VRg1dg4MUFhDy5iMM1WIZ8uIB4n1XuA8hYZYdOQY/w==
X-Received: by 2002:a05:6a20:5488:b0:159:f71f:4083 with SMTP id i8-20020a056a20548800b00159f71f4083mr17540973pzk.6.1696946227769;
        Tue, 10 Oct 2023 06:57:07 -0700 (PDT)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id b10-20020a170903228a00b001b03a1a3151sm11830364plh.70.2023.10.10.06.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 06:57:07 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] dpp-util: fix incorrect ASN1 compressed public key encoding
Date: Tue, 10 Oct 2023 06:57:02 -0700
Message-Id: <20231010135704.198723-2-prestwoj@gmail.com>
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

The prefix to the X coordinate was incorrect when using compressed
points. This has been modified to match the ANSI X9.62 spec.
---
 src/dpp-util.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/dpp-util.c b/src/dpp-util.c
index a2640076..0406a4dc 100644
--- a/src/dpp-util.c
+++ b/src/dpp-util.c
@@ -767,11 +767,11 @@ uint8_t *dpp_point_to_asn1(const struct l_ecc_point *p, size_t *len_out)
 
 	/*
 	 * Set the type to whatever avoids doing p - y when reading in the
-	 * key. Working backwards from l_ecc_point_from_data if Y is odd and
-	 * the type is BIT0 there is no subtraction. Similarly if Y is even
+	 * key. Working backwards from l_ecc_point_from_data if Y is even and
+	 * the type is BIT0 there is no subtraction. Similarly if Y is odd
 	 * and the type is BIT1.
 	 */
-	if (l_ecc_point_y_isodd(p))
+	if (!l_ecc_point_y_isodd(p))
 		point_type = L_ECC_POINT_TYPE_COMPRESSED_BIT0;
 	else
 		point_type = L_ECC_POINT_TYPE_COMPRESSED_BIT1;
-- 
2.25.1

