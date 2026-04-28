Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D43F2EBBA4
	for <iwd@lists.linux.dev>; Tue, 28 Apr 2026 11:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777376901; cv=none; b=mDwZLY7P2+vJNx7fHkUrPgVDtfiI33DOdE4VEskebJZYQ21YMklxXDBgZPzzmOOOSTd768AbcqD7+CfiPfBFzOHMN0rbpwUH3uiIbGdq95OfsSMkU1LCp1SJDa+1I3FsX29LVjv0JOhkGCoCWnvLuibVvn48fbMmY2RBP4inTCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777376901; c=relaxed/simple;
	bh=rrf4QzQ5+yriyS38qmvIGptfN+qqnbKnX89io8NXA58=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1srFovH1GTcMwJKAGDJwEyPjb+QELNtELd7qN2WGVUpaNGUshUI7S06ZLaJKBkDFDSbxyfHCdF8dV0O7nXeLUTrxy1lYxTqzdJKCYCxlK13EHmMIjHjyFBpl9usozj6XulhL51iaH/rxRp99/HfxP08u45iUueBXmjaybUEvXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at; spf=pass smtp.mailfrom=irregular.at; dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b=q0oH4zRO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irregular.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b="q0oH4zRO"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so66898995e9.1
        for <iwd@lists.linux.dev>; Tue, 28 Apr 2026 04:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=irregular.at; s=google; t=1777376899; x=1777981699; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnUIzS5gJt/XEKHOKXkluFOuCylFSLjKPANxE/qf9RU=;
        b=q0oH4zROiVkCBc1dCihAqE6JanSuOSe/tb9uIt/IvN3tuEKwUxLRBgQCrKG6Rq7TXU
         5n3k2LNHowcaT+0MBiR8TGGXsrncyxNM6+FXFiG7uAIxmws3MD89+2gRRwi5iVgtjaP7
         yg+JZOERJnm4zVYpK+caKqkqpWE5h0SRYatQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777376899; x=1777981699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HnUIzS5gJt/XEKHOKXkluFOuCylFSLjKPANxE/qf9RU=;
        b=Zj2kKgoXUCXNz6yO5RcO/cEY9oPBqHcdGC9rHNkyETyxDmXICABF7NSxOZR55M7K2p
         k3KdX6IRAOy8gv9AvDKB+D4IhTz7oUFN9RqFib/mfgvKXhSMPAQZNuvsDBQqAuzXkuX4
         nmtMO+h2djF5zAYQNQFXVTI9yoPEOi5BTmT/yucr9oRyMftjDXe1fgMjBUgmlD7xYyiL
         QJqasqpzGG5bIb16jWFBcfVDwT30yMDQldSKs0mJ/pfKaNALU2wzU4fXt2T2QZwHs48a
         7WcY+LuDLionyQbZ32FqvuCzpPXAbs6RGZT5r+bCYh202bevutFUxWrhLZsENbBNV9VO
         n+1A==
X-Gm-Message-State: AOJu0YyR6clqEQVrlFyq9sYCopzpvDNBvTjorJtQergKR1woDeh74oZD
	O5Z1YBSXq8i1iYHOWXhyWpCZwDjZh4i6OkMRRy78hJiTlojuh6R5mczFLjcQy8z3si3DZ/4RxVI
	yCrNk
X-Gm-Gg: AeBDietIbzD9Gk91E8a1y6hSRBfxQey/M6OE8CCyDCRK/N44vYvs4uAHONdOK5L9r+e
	uAnJjXMHsuqzT1bZ8qtv/LlRGpRNPuC5oOaKr9z1F5C6r0ml/YK9try5lCA1ugUgiJU7GrtH9uc
	ltgdVDUSVtpFEEEgvm+SGLt62d6lSXxn0fZUsuFrnz0F73yK45KFoM4BbEmg34vZ/OzXQjIBwjh
	zJVznOeH3cPBUb9c2z0YqNxdP8JhroyBgdFjkE5huYft2xX+4eknN3/2iNDRQKum3UuIuS9aTfS
	E5jSSpT0OgH2k1Fhv4Gizm/fRTcb97ZTvdsLI/8xrnHYLkaC9YvCUmRw9qm6wMdWytGbEuTqUiT
	XHMcdl/WO9IGddbrlsgUR0jQ1NymMAh9gmzn2jWbwnb+WwQDHPblM47eAZtVevp+Z1R+Hd5gWID
	6sp36i+nxXaaahUeb1hyZvIq1YfD4KrKjBkCJmmUU7GefYGi2Wj1Gfc2Bo52Zubasexp5Qc5fm0
	WsHnLGU8+Lv7daOtpo8oCRm+IYRvTw3tiqyvUMUYyx77aC3ATKZ08VeZlVPi6GqSMWolf35tTXS
	wYS62hPkW7gUqR2uoWbWNT1XgAi4f/HVoJ6kZ6vS/fjy6bUjhXnde0gb5qaySMsw7woA2mWhIG9
	xuQUXxwzXyg==
X-Received: by 2002:a05:600c:4645:b0:48a:7aad:4425 with SMTP id 5b1f17b1804b1-48a7aad4537mr3747835e9.3.1777376898639;
        Tue, 28 Apr 2026 04:48:18 -0700 (PDT)
Received: from mkurz-macbook-pro.fritz.box (2a02-8388-82c0-2a80-411b-7cbe-f9f6-9ad1.cable.dynamic.v6.surfer.at. [2a02:8388:82c0:2a80:411b:7cbe:f9f6:9ad1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a775eb91dsm16862895e9.20.2026.04.28.04.48.17
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:48:18 -0700 (PDT)
From: Matthias Kurz <m.kurz@irregular.at>
To: iwd@lists.linux.dev
Subject: [PATCH 2/2] doc: document externally managed profiles
Date: Tue, 28 Apr 2026 13:47:57 +0200
Message-ID: <20260428114809.75413-3-m.kurz@irregular.at>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428114809.75413-1-m.kurz@irregular.at>
References: <20260428114809.75413-1-m.kurz@irregular.at>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document [Settings].ExternallyManaged in iwd.network. The setting
marks profiles that IWD may read but must not update during normal
network operation, while explicit removal remains allowed.
---
 src/iwd.network.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index 892c6eb8..2b5c3f0e 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -174,6 +174,14 @@ The group ``[Settings]`` contains general settings.
        Properly configured Access Points will typically update this setting
        appropriately via Transition Disable indications.  User customization
        of this value is thus typically not required.
+   * - ExternallyManaged
+     - Values: true, **false**
+
+       If enabled, the profile contents are managed by an external
+       application.  IWD will read the profile but will not update it as a
+       side effect of network operation, for example to persist connection
+       metadata or security material learned at runtime.  Explicit profile
+       removal through the KnownNetwork Forget method is still allowed.
    * - UseDefaultEccGroup
      - Values: true, false
 
-- 
2.54.0

