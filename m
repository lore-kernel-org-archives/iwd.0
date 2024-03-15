Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7666119BA2
	for <iwd@lists.linux.dev>; Fri, 15 Mar 2024 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501508; cv=none; b=h7Id5oPhy6yP1kjemWo6MWgyz4KmcWuAKHLfFvwPphmB8ijBCHwS9BGqhZCMrWrQtFgvvlANd7FS/1eixF3PPfaO6htDB9Xr1zktzMEhgeGtfP3b8jpC/GUhuzS04imWaAXzNW8pFm80PLTb84oUQZTr0TvkPCz8uinKnvMN7+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501508; c=relaxed/simple;
	bh=C8c7pv4XiwVMUVsem5h5Q4ABs+4D1iT5FCUer1vEaPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P4DasEKSoIcE9lEwXC7NMQLu4LRZ+fLg1761jBSeKRLfJuHMJIbdjl8fMcmDX4ftrLAv/oz+SXHX8iJxFK1yg1flvoXkDjlilS4JEFWYZETh92QzqsqvUOTgHgdryxlrT6MXDa8uzslsmUjcF1E+TsVS47jHE897YaK8Ja6UBYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwTpeuRg; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwTpeuRg"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-789d0c90cadso123214585a.3
        for <iwd@lists.linux.dev>; Fri, 15 Mar 2024 04:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710501506; x=1711106306; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9H5LxKffXrPWzGf33UP2hJ7EZDz4gHPYI/8uyiHwUbc=;
        b=NwTpeuRgUo2ebBn4LLRibtfIvQerN1XROhbXhSKizygqZ7TEDym+dIRjjItNjoeCGt
         L6V4H4NaGf29WvJtimf/rxh7KBw+90X8+PXKbCHo9qDh6TivGnYi3Xc1lJzBAqfdk5A0
         jiCPj/Oi/kHxsPbs22zEAYivAGkKkHjEtGw4qV9frauBjbml10ae0dOAmZioIjFV5MTy
         xNQq1ETr6Eq6pHq7W5UFIk7ZocSTWhJhVfpCZW5WdJbXCKF9GxOJaSBoWhwhgSjhc3x5
         Eq89ikE6jhjxnSr5jx1OVNUwqiZnS+VXZPViC1a82ZRBfcrA7k6hNtQp5c9iUOSLX+6s
         4oIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710501506; x=1711106306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9H5LxKffXrPWzGf33UP2hJ7EZDz4gHPYI/8uyiHwUbc=;
        b=v7GHwEkSKzXtZ5iSl157GcUbOZSZ4EMo9Me/aQndK6AKBdyqwFbQcMBtmzFWY5wVO9
         6k5U4r6uVO/YVsEP16695nSkFer6Bpc132Vpl1Vi5tWxe7BiYhztujsbqoq1RT8J8wWu
         LkSTSkq0qV1Myiik1yIsbsL4D8rKGeBfCAWwgnQ2/xcdbw1jAFgIvlK6DwQvegQHt4cA
         LHje7wNXcqOoeLUrE5Tg6I+uBjuJwpvezMoHesEcd4VgykhSN37fDZoSJP6GCqbEJQPu
         DcAwIsho9nebdcBIGFrhJVSCSw/Wvxsvvy5wZd30b2ytM3EPkQDyKWm9eRGfOrJAbZDv
         g/ow==
X-Gm-Message-State: AOJu0Yx0OrEgQDwYiyuEMdda3Do3ldvxtqzqJm+vokb7a3HrhMCG3YU/
	NF/6Eti7oZp1ezCUvhc1+1bWJcZfqTwKALVqRPBwmjdaVwVlvYdCL1XMZkci
X-Google-Smtp-Source: AGHT+IEnjtOdfD/b3Lpdse7XY02edQVsnIX8ju3CJPcNC42voIlpyqfesha3NGAVl1tOWjHuXvyT6Q==
X-Received: by 2002:a05:620a:13db:b0:789:e70c:a349 with SMTP id g27-20020a05620a13db00b00789e70ca349mr801983qkl.48.1710501506088;
        Fri, 15 Mar 2024 04:18:26 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id f18-20020ae9ea12000000b007884dd207b8sm1915251qkg.55.2024.03.15.04.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 04:18:25 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] iwmon: fix incorrect mask printing HE capabilities
Date: Fri, 15 Mar 2024 04:18:21 -0700
Message-Id: <20240315111821.116213-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was changed from too large of a mask (0xff) in an earlier
commit but was masking 5 bits instead of 6.

Fixes: 121c2c5653 ("monitor: properly mask HE capabilities bitfield")
---
 monitor/nlmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index 6fe63b8d..9fee5bde 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -1689,7 +1689,7 @@ static void print_ie_he_capabilities(unsigned int level,
 {
 	const uint8_t *ptr = data;
 	uint8_t width_set = bit_field((ptr + 6)[0], 1, 7);
-	uint8_t mask = 0x1f;
+	uint8_t mask = 0x3f;
 
 	const char *he_channel_width_bitfield[] = {
 		[0] = "40MHz supported (2.4GHz)",
-- 
2.34.1

