Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B7D3EA71
	for <iwd@lists.linux.dev>; Fri,  1 Mar 2024 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709322068; cv=none; b=Im2wnaYYOV9Ph2xDX6jIXQL5d/qnUSRlsUeAo0JXLfQ9AyseK8zFmppSfRiHDyX4xf1kwpHxgb3ktldljE4ix1jfHUzHldMeezHceZKezkn78fE+RoKc17E9oVV5NT0XQ8ZMGDI1O+nucQ7/agkjZOx4mdZrAB3KnN3/8X/6Wlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709322068; c=relaxed/simple;
	bh=kTNGXoHMvDG/GrvNJAs49iceNFI2++f1WXnkWHQr0Og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ryu/Y5EigvEJ8AQfIUxvVQrrH3B1UwrKINYR6pyXbYQKXKp1Gk7aPQylFJwTo0XstIrC/LsWkiNWMXAo0PIJ3ilAuXar0y6wi96nJW9FF9wtEo0sLrjwgvm/Cahr8wiP4gB+A7RoQyam9a1+gfFGLXU5QOYZ0g1+V808s5GGdqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBf4Lqw2; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBf4Lqw2"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5a0cf64bafbso1312830eaf.2
        for <iwd@lists.linux.dev>; Fri, 01 Mar 2024 11:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709322065; x=1709926865; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alswkIXf7vPYGiptsX9N0GOdlXPllSG3F2QWufv5xUk=;
        b=CBf4Lqw2KNke3RXg4UjDauZ3yMB+pCkeX4VPmk274xvELp5OPZ3Dzse6Xre9IM3OI4
         ykMitypCb58hSiOJZXSl+2l/R4dTqzZ1kry//H1Zx7QAGuEo06s+mF2dHdbQF+mCsOJz
         oXLjV5xC/mr6KnYxPKjDFnlgEtX3dz7JWOOPS4BCfLSX9SK3aMYJPm/b1rqODC03TeuI
         WWfRT4U0EYoeqFFLfJ7TIoG+noumucEsXn4yvmgAgReAHLlyxzK26jn3bVM/lmyfxfoU
         0cqz1hg6aXZijouy/VNn2VL7ghYY0U+Da0AI3K/bNDvwZ5WvyvC+9UqKDXeWUKYoKwZN
         AF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709322065; x=1709926865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alswkIXf7vPYGiptsX9N0GOdlXPllSG3F2QWufv5xUk=;
        b=S40/X+376M6J6YLWkZfT10iT3V7isbArZwMb/iGGECIS6dPNPubmisf15ZbNM2i6WF
         8MuPIEMctUlgaBT8JGPmQHkWWXuPoGsGui2VPL9CR2DKMVVGA45iyddrqs2griw0HOA2
         X6OrTNC01YMKq5/uxv3yVekwTcnOPX+NbDb9UEssMyGjaIEP3JWpJQGw9n/tGZQ0CKfw
         yuCm+1tsD9z6ZxPjpI8IEBpaTmoXYwLOsJdmtYV8CdtnK7qGzY5zg+kMrfuZ1XM5HLJ+
         hgqmOf42o5oYepaFh9bM0yZOUN+OF5sEMJSWS2OCwHfbjCUN/iHLgjTsYb+LRs1z6g0+
         vSzw==
X-Gm-Message-State: AOJu0Yzif3ZT2kAbvfDBQFuFeih7tLJahpuZfcIFGYKXDYGyOTEQm9fw
	VY6DUc89pJII48DP3lw5Y008Dt0Pu2ZhjvCGBuKqzzGdbIf+0RM7UlehLhte
X-Google-Smtp-Source: AGHT+IF1+tz2BHslWTeQeTKJVdOQeHGP9xvDgBE3zjTr7dQQYj/rbrqxAnjogwMw9I81t/CCc3XGGA==
X-Received: by 2002:a05:6358:7e9d:b0:17b:f259:3098 with SMTP id o29-20020a0563587e9d00b0017bf2593098mr2423794rwn.3.1709322064998;
        Fri, 01 Mar 2024 11:41:04 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id mu4-20020a056214328400b0068fd10638c0sm2162397qvb.20.2024.03.01.11.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 11:41:04 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] eap-mschapv2: Check Password-Hash exists when loading settings
Date: Fri,  1 Mar 2024 11:40:54 -0800
Message-Id: <20240301194056.1665549-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301194056.1665549-1-prestwoj@gmail.com>
References: <20240301194056.1665549-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Caught by static analysis, the Password-Hash was never validated so
it could end up memcpying from a NULL pointer.
---
 src/eap-mschapv2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/eap-mschapv2.c b/src/eap-mschapv2.c
index ef0ce620..7f71cc82 100644
--- a/src/eap-mschapv2.c
+++ b/src/eap-mschapv2.c
@@ -532,6 +532,9 @@ static bool eap_mschapv2_load_settings(struct eap_state *eap,
 		snprintf(setting, sizeof(setting), "%sPassword-Hash", prefix);
 		hash = l_settings_get_bytes(settings, "Security", setting,
 						&hash_len);
+		if (!hash)
+			goto error;
+
 		memcpy(state->password_hash, hash, 16);
 		explicit_bzero(hash, 16);
 		l_free(hash);
-- 
2.34.1

