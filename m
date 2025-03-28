Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD8E1C6FE9
	for <iwd@lists.linux.dev>; Fri, 28 Mar 2025 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172999; cv=none; b=jr9+qQUd7sVKyTN7Iymm3B8gVPWYyO2haz+xlRLi2WuAYw6/q1v4JV7Gt0cuWBE/pDFDD1z26LQ3mVov4NzD7UFaJ/b5xxGeGx9/s1UEqiXPW8/VC5C9zAFQUk/ydE4hAzRJwu9WS6x9PkDFsB9wmSwNr49yO4xrNIgZ+bhVJww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172999; c=relaxed/simple;
	bh=MyM83L1eBpowQ6pWl7EN/W4VKQ1GrBqt0uY75TwPUAs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IYSdGfFSdOTcKFmgFo4c4aA2IK0pk6oEKNMCEL7Mqz7Q6u32c5hBA/zTgA96dJPy+Fike/bvzGOQ+fk+99mM0AGllDtTD8hnfdoxmtmPXMn08dUQAMObq5TJ2uZ19a7ci9nieMnVtUT6LIGg3h5pSAYbGWYJaJ+ESN1PMLOiw5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWhi7vTX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWhi7vTX"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224100e9a5cso44964055ad.2
        for <iwd@lists.linux.dev>; Fri, 28 Mar 2025 07:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743172997; x=1743777797; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccTKIiVTHaYhZLj8hvKA0e5OsXRQ+klutkUMg9gJHMU=;
        b=LWhi7vTXgjkS7Zp3bqkgp1VJ8g0HeL/ieW48QsH2sMrhiS1OKBwFYHrugkb44zXf6d
         TRYOuJKenBFjVVdq3IlyyuZhfOSqx5Dw/fnAac03g7D7w/ImEeRZYylRIELPzWd7n0YO
         LnnNgUr/tiNEuqoa4MXDiO4zDgLuaHVGGSDaHdtnZ6094WlIkszQJDtEeGw4y8utYwEt
         2dJAh+xi2MDKQeE9wsQbdt0Jry2eWB8jgHyr5d+ypesFTUljNKyA9zDDu1UkTYWN1At2
         UwK2NUgy/ZdtB/ALP1Xr7QYEEIo3EBHz59k396vrGCEVKpPMeQljvWu49p/Io/nBSJ1a
         GUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743172997; x=1743777797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccTKIiVTHaYhZLj8hvKA0e5OsXRQ+klutkUMg9gJHMU=;
        b=ota5LPqKEaDGOX6RBzW84JEZICOBwLV5D+8xiArIMBruqVLmvOEGx7OhD3xuYKLOrb
         a2nfEI6JdBoKpHSDefaurplrhJzOB8LeSH5cMws/0+S9rZyHAp0e5c/Y6Qrv/Dj/ZM87
         PqrJpLV1B/2Zlc5NLOFdGuojek46wyj2vHZMn9MUEgzm2jWJm5FG28snr3TrViTkemrg
         P1E5/giY7kLwjHE+EEjVCc5y0nPi7aBABgorCqltOfy8SBPhBzM8f8pn2VShaCqbVE3E
         MqZ4t/tt8/1xBZJRuILVInfqU0Ma5bqEtl4y8cbfwVtkZLqTlMEoF2Sgt4lbzzywOdEA
         uLaA==
X-Gm-Message-State: AOJu0YwVZxj3yGA1qxYY1d2po26FcEzenqRbQW1t30xPEiyHnt9CI+GS
	lx0gQAzNtSrXvZ5mRkSG7PjThyg0UGIBclqPf/ae5o9nL5YjeVWBZIVtUQ==
X-Gm-Gg: ASbGncvYrLDFE9BB2DL2TuYBPMSxhrYq6O4f2b7tHaeEe4BNxuXUmBCLpn405A932Mf
	AfyxQ26Zumi78262dNNZnGKzGRJwX4rMOn7SnEEKL+pvcAHIwBFdieCQ3JieQbYYVrtckng+YMw
	8KbclNyyY1oR5OXMVbqSgKf2pgC1YaWuGMuamAMWQdE5BxMRrsinK9Tpx1IKioF+zTz8RZOsctR
	pwbiDq5nVsQaT2eCi2iokoZgh0PkCcEIaFAsst2OOvAZbTbCiETrz661byE+QiqCp4wnRxuzK/q
	IFmVK0FiyQcMXHNIim3S/9YJDm2PEmtejCAsjmeqoZt+QUjDLRMvGYJ98KhQCkQ51SrQHNqtMiI
	=
X-Google-Smtp-Source: AGHT+IFexosxXRBAtpLFjEFSNZ7nlDOkiN2JMU+RNFio14CE7+gNXkwf5uUFrOAGPj22BLA0JNAdag==
X-Received: by 2002:a17:902:ccd2:b0:211:e812:3948 with SMTP id d9443c01a7336-2280455d75fmr126309865ad.0.1743172996578;
        Fri, 28 Mar 2025 07:43:16 -0700 (PDT)
Received: from LOCLAP699.locus-demo-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eee2288sm18885515ad.87.2025.03.28.07.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 07:43:16 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 10/11] doc: document InitialRoamRequestedTimeout
Date: Fri, 28 Mar 2025 07:42:52 -0700
Message-Id: <20250328144253.421425-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328144253.421425-1-prestwoj@gmail.com>
References: <20250328144253.421425-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.config.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index 895a1012..9761e8fd 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -292,6 +292,12 @@ control how long a misbehaved BSS spends on the blacklist.
 
        The initial time that a BSS spends on the blacklist. Setting this to zero
        will disable blacklisting functionality in IWD.
+   * - InitialRoamRequestedTimeout
+     - Values: uint64 value in seconds (default: **30**)
+
+       The initial time that a BSS will be marked after a BSS requests a roam.
+       This is to aid in avoiding roaming back to BSS's which are likely
+       overloaded. Setting this to zero will disabled this form of blacklisting.
    * - Multiplier
      - Values: unsigned int value greater than zero, in seconds
        (default: **30**)
-- 
2.34.1

