Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A709139589
	for <iwd@lists.linux.dev>; Tue, 14 May 2024 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715696375; cv=none; b=TQXKGkLL++eM5+LKbanvoY2QQrV81f8bcv3a4Dol0zfp2xU7rDZlToQAiGodqDL1hZ5CakYvCT7+BKWT6R9IfZOEAIDGJNDtm8G+zPhiU0bEE61Z2b0bQsByJ8+qrgUbBCW5l/HKvG0SgcADjAgE0zLiC/ymo181AnV8/ASRprQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715696375; c=relaxed/simple;
	bh=EaxKL/84g4ULI7CfYTO8RQgeXcTOii58NZ1/LIMHcs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jmfZN/Q3YlHX8z0K69tpZ45eOEQY8JsdVQ16JZ3agE/vYVgASB0ZzkOxYo4P1PYZE8g7M/oYny7tPeqLet1fLW9WF0ydqF8MI2acrcDaC4zdpK1OrUIrPwWgzaTouMxeo/0ELmkUG4Q8yccEUx9Oe/ahktiwRT+EJhLc4BRlVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJp4gPiL; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJp4gPiL"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-420160f8f52so14878495e9.0
        for <iwd@lists.linux.dev>; Tue, 14 May 2024 07:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715696371; x=1716301171; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrkOXJ7QoRpfEOxioFQtxI1IVrPOFesRvqJ1x7s4b6c=;
        b=ZJp4gPiLsrCMcAaDrdrE3NditScpEEAYLnae9rlaTK9BxUvnTLL7tMVu5T4x7FRpK7
         RkyLGz5/GlsKAxVmj+Rdryn4fgq+3Lz3gaCIYcFCyrpogtSGJ+mJwQiSiYi9/6Z1Wxwg
         6R4COBqYVf9X1RAyYJ9TR9yIqghDKsfcfZsLh9ylMk5y1+ntGCP9iRJ2p92X6ZlEjpCY
         jaz0lxsTSO3fIyybN//W2VRWc2g/gQxXvqLZk9T+5AJrmu2VvWKfDr2yNDwKbsQjOuua
         yoA5hWd2hhQzOjCEJTtpFxwuN+Hxdiieux+9udEMv8ax35GNiQ/VGWKTByMl9UoOOGG+
         X1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715696371; x=1716301171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrkOXJ7QoRpfEOxioFQtxI1IVrPOFesRvqJ1x7s4b6c=;
        b=Xv73qJFzLLVknWrIuWxYuaQr31g3KvfzKPts1HPawHN/Bvta9yNpHITbElTgjJB52Z
         I6sRcdL7MrNBAhsYh0HyanePf+VcdH+QVrcQP9fsXnKFf5AUBL/YeZdzwrtttVGxVhLg
         PQ+tRLULd2It/BK2nhDpdzrR+W9hEZpICm/DdEur+1xbW8+EDPUe4oy4CHyXeVdT1saY
         C1L/U2mwMUT/6JgUhSoj8FY/5and5/USNgxpDQ99cA6DvVB6i5dcDRnDfF8WBxzaqzUl
         oUIi7XMzTbn4Q+GHarDFbEcHopmLme8NGWnc56zO7AZopLl148jGoZ1eDLFL8zZdD1Fg
         RUig==
X-Gm-Message-State: AOJu0YzKoFAYcvy+rvWQfD3djzMV2lI7U79T23MpHdt66HUQH/QGiVpl
	Z7Ix3aS9qkMyLZUxdkDkNyXAvfWUYrXhUiDMzQARitbazVI4XgDmXOD3XaTR
X-Google-Smtp-Source: AGHT+IEEmkzB4tqVvjHwCBHgeU+3JjzIBawqaPkf4BQSOau9NuIrmN2AFPUinLdvoqOUEc5tC+KbLA==
X-Received: by 2002:a05:600c:3594:b0:41b:f41a:c67e with SMTP id 5b1f17b1804b1-41fead6ae4dmr87651295e9.33.1715696371218;
        Tue, 14 May 2024 07:19:31 -0700 (PDT)
Received: from LOCLAP699.dhl-toledo.locus ([195.55.200.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f9ffe26acsm153448085e9.1.2024.05.14.07.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 07:19:30 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] unit: add test for band fallback
Date: Tue, 14 May 2024 07:19:23 -0700
Message-Id: <20240514141923.291148-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240514141923.291148-1-prestwoj@gmail.com>
References: <20240514141923.291148-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test uses the same country/country3 values seen by an AP vendor
which causes issues with IWD. The alpha2 is ES (Spain) and the 3rd
byte is 4, indicating to use the E-4. The issue then comes when the
neighbor report claims the BSS is under operating class 3 which is
not part of E-4.

With the fallback implemented, this test will pass since it will
try and lookup only on ES (the EU table) which operating class 3 is
part of.
---
 unit/test-band.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/unit/test-band.c b/unit/test-band.c
index 855fb67f..606bb854 100644
--- a/unit/test-band.c
+++ b/unit/test-band.c
@@ -670,6 +670,19 @@ static void test_conversions(const void *data)
 	assert(!band_channel_to_freq(192, BAND_FREQ_5_GHZ));
 }
 
+static void test_conversion_fallback(const void *data)
+{
+	enum band_freq band;
+	const uint8_t cc[] = {'E', 'S', 0x04};
+
+	/*
+	 * Without a fallback, this would fail. There is no operclass 3 in the
+	 * global operating table (E-4)
+	 */
+	band = band_oper_class_to_band(cc, 3);
+	assert(band == BAND_FREQ_5_GHZ);
+}
+
 int main(int argc, char *argv[])
 {
 	l_test_init(&argc, &argv);
@@ -736,6 +749,7 @@ int main(int argc, char *argv[])
 	l_test_add("/band/6ghz/freq", test_6ghz_freqs, NULL);
 
 	l_test_add("/band/conversions", test_conversions, NULL);
+	l_test_add("/band/conversion fallback", test_conversion_fallback, NULL);
 
 	return l_test_run();
 }
-- 
2.34.1

