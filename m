Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD52E3195FB
	for <iwd@lists.linux.dev>; Wed,  3 Dec 2025 15:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764774212; cv=none; b=CBKzETkkNpHAdD1UO9cIMm3FXq9yMJ5HsWzH3vkFS5oEZZWyXgK1SVU2+MFFYlIPM2ef+H74yovzc/aGSQ8Cg76a3LD0RwNmjJeFhotWQXmz9/Rc58YIbvn9hKgLsb/r9FsJcpG8l9vOl9gNIBo2GtdEvXrJftSdQUotfIPQZRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764774212; c=relaxed/simple;
	bh=Q70J3c3//s17FJz5v3+tfPZ8jjjZhqzuedGijSM3Xvs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kmj4JVz36oDcKbOJ6H8ELoR+e9rARBd8um0DC5lv2tIMMa1uW25VRkaNwiZ3sztR0t9xyqDQxm+w7DCB8K2q0LgiZxB9V5eXpn+g9fZfHoTxxcmAMk06SktviA9lLFGb8lWOXIYRYKmfUM270afpsTTj8bbZ5OHE3MVdNXPgyJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dChsXf2n; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dChsXf2n"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-299d40b0845so110742385ad.3
        for <iwd@lists.linux.dev>; Wed, 03 Dec 2025 07:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764774209; x=1765379009; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fvydNfxy586Cv93Ha3UJbF0jrh+65SFUXm99O0e5MHs=;
        b=dChsXf2nt3s8pRofXPJbkE4anv07rfB3UZtSeadi2S9jUakLcZWsNdppq3Ys5oSpbX
         J0CePU/Iv6l+zAxWMjOCCol7nmHKDC0pzZVWx4WJN6Jjn4DyIHia/NwDKQUbB/RSoy9c
         VdYs2uZpV1vjWPoaUHZb5iCwNPdU2915wqq9AIKEU/bGapr4mVd9nQFIf/2lcczBDfeU
         ro+V+pZZH/3aVEGhSzbZ/jQCM7GrN3ea6h9aHXKoDU3MyVzkRMkJO/wQqjAvPamYW39D
         WpR821m+vkhrn+thr0y+V+I+fbEft3iDRYg9pxzKazBTKUiTqdsmIb/XvXfz7CrTfHbF
         76Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764774209; x=1765379009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvydNfxy586Cv93Ha3UJbF0jrh+65SFUXm99O0e5MHs=;
        b=FqTfBXChUmGz9nmCBqwsmwgzzW+DjnD58YTt7lzMARm/ReWlvtMV+5JZSHrHc8cGQG
         Xr8xKNKKp4p0Ig75u4tEhS96jPD27QBlSVYXriC18q9QPVXkZR2ZbiA59FAeEMiap4wm
         N7At5Ru6mhttejmrNBZmJs+2nIfOtCUjgvWdFKnb0Xes5pEqjzmFrkkKsVNVE4MzdQW8
         9vCBihIjNEfxY+nLpsHhWc79LTXsloNuop4d/c4M3vpHSEuCqpY5TTR95mjcM8XCzdf9
         SfVrAjk+IzeFBm65n8vnUQswyJ/Khg8d2qb8kIUo17E47Ek1It/fVq2Fop8EFLbuP3zr
         DQDg==
X-Gm-Message-State: AOJu0YzoZoreahILeWqDnH1Ui4DnyLOA0REyyNckU9cymj8Q2ZgYKI2w
	0Q6RQlzH5gMyYtc5bTKh564ChYXKHH1ClHYvH4++grx2eJ7iPjuIQQaWtInHOQ==
X-Gm-Gg: ASbGnctsxdPUf2bjdXJjjih997I1AutDxd0KVvDyW0toUfTGVGCmnQ1i3892XrbEz2Z
	RXykRajQgLuQBjCKMvON+zRAgkLdLbgdasapuxTuteK1dx+YRaxg5WCX2+ZonfrFILjke86krww
	0pzjv3ZcGXNNFyVqBPJue8QShey7SK2kgeZ5SPZnRGge+oH9P/mdK0YftfpNzDA1zRP/z6IIEgS
	Wz/ZstDHwfgDlDT52VqNPnOYodn4rqDii+qESuDHERPa45FGsoP5WrZBqyrfiX2J/bWjJDltSy6
	zDnYKC6R20zvpnsgHDnalWPf0Yr8Y9SNGKmt2rF5/5217Wv6qvg+zThvc4HDLLZfbLZLzWJnft8
	/s9p8O8B0Qmtc6Wzz9s/ZgVZHCLiROJQjGlUDhIjboIPfjuinHJestNL7GVSM34ktyq+j8QXp84
	ix65g1Gj6yYcmdNEHHy254xtBW0ALM0cw=
X-Google-Smtp-Source: AGHT+IFFDQxv0ORAv6lR4fLIRmazNUvOdFLWWSZaBXSiQhnQ9mwxjc4lMGLY5rE/j+zLOLd+wLZ+3g==
X-Received: by 2002:a17:903:1ace:b0:298:8ec:9991 with SMTP id d9443c01a7336-29d684010d3mr31266425ad.37.1764774208731;
        Wed, 03 Dec 2025 07:03:28 -0800 (PST)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb5c6c9sm191211675ad.97.2025.12.03.07.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 07:03:28 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: check return of handshake_state_set_pmksa
Date: Wed,  3 Dec 2025 07:03:21 -0800
Message-Id: <20251203150321.916124-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If this fails num_pmkids and pmkids would get set, but to an
uninitialized buffer. This would then fail to build the handshake
object later when copying the PMKID.
---
 src/station.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/station.c b/src/station.c
index 50997f5f..6c9e8d13 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1378,9 +1378,13 @@ build_ie:
 					bss->ssid, bss->ssid_len,
 					info.akm_suites);
 		if (pmksa) {
-			handshake_state_set_pmksa(hs, pmksa);
-			info.num_pmkids = 1;
-			info.pmkids = hs->pmksa->pmkid;
+			if (!handshake_state_set_pmksa(hs, pmksa)) {
+				l_warn("failed to set PMKSA to handshake");
+				pmksa_cache_free(pmksa);
+			} else {
+				info.num_pmkids = 1;
+				info.pmkids = hs->pmksa->pmkid;
+			}
 		}
 	}
 
-- 
2.34.1

