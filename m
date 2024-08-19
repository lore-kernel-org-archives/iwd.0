Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE0B13B2A5
	for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083069; cv=none; b=mDj84jlQmD1nxU69guwl+NHR1SO2fvbA/lx8nNm2gL48w7e7VMLwaRi6SSiCIJuiC+gYYCKjGie6FcWQ7JraVam9oj3BFr1H4sETjh4/GGKeQfUZKDJlHK7awv0lSZaOoxpNpWS9ZfkmRxl/xMPeWK8tXO7HOr7gIfAIY+s8e7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083069; c=relaxed/simple;
	bh=dGvS93TLppkCHT7FkE+RNSg4owaFpHKRYvuTu3q412U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=azS10LWHSVl7sJGYqFUFTJa41/RWSOzuBpyaK5Rpd34w+6YpNDGHjp1Y6Gdo0Z/VqTEX11kr7v3nVdGaN3v4wXbiZvx/I+137kPtkZ6e9lShIK5f8RuQTuqsp+DhUVM2MU5iY6+vm8Fb0G2Ki1ywgyAuVFGM18c9taUj43V89Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDd7tWHZ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDd7tWHZ"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso3337708a12.2
        for <iwd@lists.linux.dev>; Mon, 19 Aug 2024 08:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724083067; x=1724687867; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5avM1BXirhrk1+l4IoOpkNGQh9n3oULhwodONX2WEJs=;
        b=IDd7tWHZ/XE1ZhtjEYZ1i8VEpHpS4doVg/NIAHzfN+NrlFti9Jon04VAdKA+o//hUm
         tobOC92CcCbzUtK97nycLgUM/CupJ0BEHJDAo8Bt6f85z2WQLn6K0C2oc6ZPsoaxZvys
         9Z3NGlROrMJxZjoDT9/iSryU8Xh110++HRjdWJP9kDUKzpzrMz7MLqmmgxevFZ5iHd3m
         SYsSWNYqjyTRNANxVjMWsxX4VL6AePoMN9Yd2IfPdYwlf6TxZ4yHhdj5swaaPreTEh3g
         8WAIR0MDDIH+lEsVIk6MIGDYaNxvR1iX1I9C/SHplYKWAiHWJF4qY9nhGOt+bJ0N+E2S
         hMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724083067; x=1724687867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5avM1BXirhrk1+l4IoOpkNGQh9n3oULhwodONX2WEJs=;
        b=f5ZID97Hvl+TKaXwI3m3J3wbYIc5oMKRyeOORQB4BvopDmKDi71uIBKh5V9odni2mk
         pAV+3gg712UMAyxn1Wlobn+P+RJBf8u4iq63ijvUVO+uRB6V7fwSE8p3bdElfRXMbCjB
         avD1VnWQkvFKIRe9TC91k2XHKGXhap++72fnbvNLt1oeB0stcNJs829zeoNNWy6/FOKj
         nWkqodGmbVJWDi1A6CUmLRZz2rfr7hq2vThuG0DSbQ/cRmqXPj1TzamyFEPaMBUFr9Gd
         un8Ho9AmYRmtBU+eKXeeUaBg7tYD/WdH4ZVPKawPWNleFfiV/wCZqBOY5vsEL1gM3/e5
         Ualg==
X-Gm-Message-State: AOJu0YxV0Zm+pdQTiv9CEnw7BPiBqlRJF6O5ybCDEM6ydulVY7TfVvB1
	N0R1POsPZJ//al5aWc+VI3pn0UWy/nXzZvIqh0cA34zQ9jMYnt+4ir447Q==
X-Google-Smtp-Source: AGHT+IEc6PF2STYdr/PtFT1Zo5wX5KSu5JqrZlG/NVkKYQ2Ao3DqNR4xFOnFpCq9jnP0FYIcIoZ+lA==
X-Received: by 2002:a05:6a21:318b:b0:1c4:2469:f893 with SMTP id adf61e73a8af0-1c9050528c7mr15347985637.46.1724083067374;
        Mon, 19 Aug 2024 08:57:47 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae0cb5asm6752277b3a.69.2024.08.19.08.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 08:57:47 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 5/6] auto-t: Add ExtendedServiceSet property
Date: Mon, 19 Aug 2024 08:57:33 -0700
Message-Id: <20240819155734.1276476-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819155734.1276476-1-prestwoj@gmail.com>
References: <20240819155734.1276476-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/util/iwd.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 1d4a5472..74bb25c0 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -975,6 +975,10 @@ class Network(IWDDBusAbstract):
         '''
         return bool(self._properties['Connected'])
 
+    @property
+    def extended_service_set(self):
+        return self._properties['ExtendedServiceSet']
+
     def connect(self, wait=True):
         '''
             Connect to the network. Request the device implied by the object
-- 
2.34.1

