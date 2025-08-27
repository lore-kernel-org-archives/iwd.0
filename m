Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560EA302742
	for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299311; cv=none; b=ppuumLsHX8AimaHAHV9Xh0nqKeG0YG85M8eq2vjlCvpQ6+UU+rTRzfnTe3TB1CcEgQsLDEhpQD7+3V7fFM/mP4U9NnZLW0FJgiEBaovY1ML0Y4cka/rjetqoCW6Y2bnP4takPYCPKV7Qp/6YjBlQBD+ToPm0d/a4ClMKrZrOFwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299311; c=relaxed/simple;
	bh=czUUobGe/EYGGRiaz52mBhkJdb47FfQGiOlOY8+UIBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PggRG05kurlwRDZDOLuwwQaC/xg+JZwo6hwyATDgvJD5rm5mgHCewNAmRMJ3qiIEqz7aIQp7JlcPBjmGWmW4padOG1XrrJkTJvnwjsQkftsbUGQksgyHlDf4rp2BHzySMU9/wZ7cIOgzYn3w1I4JAqCSyg91cgNIuwh5rfyMfks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsR4z6tn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsR4z6tn"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-244580523a0so66610215ad.1
        for <iwd@lists.linux.dev>; Wed, 27 Aug 2025 05:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756299309; x=1756904109; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9dfsxYqmiVQ+bOTiefpz82qQsde/jDBX62eNxj5ivQ=;
        b=bsR4z6tnS3YrhRKgyLRy8O1+8yK2XT0WndsMH9QzBnqrMpGWPHHjR9RQpTUfzhAiGF
         JsKSYN45mzXGzJi3Lu9poUPGamf3R2wFV59Nu9VJoIc4kcUnG+mFHOaC8sbxLdgOcvJZ
         jekjn+6zo5+RoJNwOX8kxpkd44uiCJFQZzCMt0Y+lBDposN9Clf8rVWEqxW8jZ0iYtVm
         QftIDnck5ZdT6HfSCZEYyrHBtX0+KKbjeAj5NbhfeUxksOIWJasPem93jClzuWRcAzUG
         T7Zz1BiUM3lbhqSFDdBLHyAVFvLaMb9dfBX4v5Q9Z2acTMU7rMitWyRdUcKgigrU9dKq
         AlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299309; x=1756904109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9dfsxYqmiVQ+bOTiefpz82qQsde/jDBX62eNxj5ivQ=;
        b=Ps6EJvWh025fRvZCTJz/lnrQCTcceRDtsl7WeQimBRpri+AQLxI0Rgxj7PTWaMxHxm
         VN0HinN//iIwYAnMozqHI4jNl6xdwu8l796gHkWlvGwXja2mhDho521KUkuBe4JmsDCV
         +OgBeAQm0KlQt4Xt1zpaa6F14LJ2cwi/upsHm6VTmuK5y1X/HIKzfEvhjgUApRVsubFR
         /LdsDz+iYW+HubL3O9+gJorrjibYfRqXzkPHvHcuhXhgdqluhC2aisWfYDC3cGA64Z7u
         TUe6olaLPnTwXf7Mlwe7ZbNrYdaNvQf6ROtwCyuZ+fDr23ol+MHsv08/Uh0NPQ5sbooq
         bMtQ==
X-Gm-Message-State: AOJu0Yzjp/BeDfX3pkBbxdNqmqv1woKgeJ+zkstNsP4l94LVGO8tMYbn
	llAXLuPyXW8zQM3ePk6YybnRSYDkHPfXNIXZuQN5M3qQiCiMM98eOxrIL4sH+Q==
X-Gm-Gg: ASbGncs1aQj4WJuUg7I2pV84UOvzkzs2HTXHfMnnBYMRqq9Ae1rxnCUaMBQS2brmDnZ
	7gOlgGE+c9HI4W+r8F7kMUh5LWlKbMdBgkUaQTI5W/5afRtBRObE9lzYe0STP6TYSyHg+7Czk9o
	B7n8Qm2r8GbPIzjNIfn803PGHqq4os5RvCICUaAmmqY2GBei9X4oPNsiNWLzRaDkPZ0Aa1blPNs
	UZcJKbmYPf6538TZILhXl0i4XlCZE56ixjJ+0IaiuQHTWd+PXubj3MkO458/SVft99H6LTZp6hm
	0X2wzKJOdBbokRHYxzZ0FULjwGl3IkrC1wZBcUbyYrqrlq/CPnZDkjTRPXjljs69zchfok1AhTY
	/DXLInWqjU5GC1uQNdgigg3vSo1VInDx7aLnsrNm1JNZ8+IBkrKZBoTODDniAK7A96aC1WUA1GB
	QDWQLHRXNpAB6+N8lMgoI=
X-Google-Smtp-Source: AGHT+IEufHrkcmJRkIb+Ei+t2RSD3kXJGU3Vd3D8yowEP1F0zgk+XBZ/kTl/ub13F6TjwKkpohSTSQ==
X-Received: by 2002:a17:902:e891:b0:234:cc7c:d2e2 with SMTP id d9443c01a7336-2462edc4507mr286942765ad.1.1756299309342;
        Wed, 27 Aug 2025 05:55:09 -0700 (PDT)
Received: from LOCLAP699.localdomain (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687c75b5sm121650955ad.66.2025.08.27.05.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:55:08 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 06/11] station: set vendor quirks into handshake object
Date: Wed, 27 Aug 2025 05:54:56 -0700
Message-Id: <20250827125501.477908-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250827125501.477908-1-prestwoj@gmail.com>
References: <20250827125501.477908-1-prestwoj@gmail.com>
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
index e2273153..66395a5b 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1446,6 +1446,8 @@ static struct handshake_state *station_handshake_setup(struct station *station,
 	vendor_ies = network_info_get_extra_ies(info, bss, &iov_elems);
 	handshake_state_set_vendor_ies(hs, vendor_ies, iov_elems);
 
+	handshake_state_set_vendor_quirks(hs, bss->vendor_quirks);
+
 	/*
 	 * It can't hurt to try the FILS IP Address Assignment independent of
 	 * which auth-proto is actually used.
-- 
2.34.1

