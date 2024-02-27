Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1D4148317
	for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 19:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062529; cv=none; b=AqsWl/KH6XPE+Z/Dl1CwooEVIYyRGkPV7+6PWQ7AtK/aaTxeshUVv6hLFBHS0Y1gS6jCw+oi+lY4PTN+Oz/O6WqWEVsH7ZyPfoR+jS7Okgj5FP9Hewu9gqcrBL115vUN/CQOh6GOUReZYlkAtOibtHT/scYFC6lvDAOcCYjvNX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062529; c=relaxed/simple;
	bh=VkaocnOJlD2CsHvejPg2tFASfPJ7UmurfT4QLitdfsI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a2pADqs56vZ7Pvna4PdnMkp/Ym1GRmKu3zq46MbB1V3RJVcoGw2vBKNU/5MTvPj0FxK9osD6cCBq7+G8UVRmtrReq4liFML7a9qIbQTvM9oYet0yiJgprQ/mxojdinWSd/113HBlAjqPY54dxHqY/10r3McZadCNfWIRxEVxHAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mn3tPx9h; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn3tPx9h"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7da6e831958so936662241.0
        for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 11:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709062525; x=1709667325; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cYGzuyxj3uSOAYsTan3w5fhXx7VNiNxX9GYZZ1OGDTs=;
        b=Mn3tPx9h496hWxyY/2n/0CsVma9DAhCojwKMzMJvNsTQTAWBE3p/Z83ZNa+52u5CqV
         7WS/tlcOga8OBqtjew46XT4DAHiPotGR+NHWeeqjjt5GCLbV23YW2Ej17OMGbwefmh3c
         qfOe7TIZQTR62xkR0ytBvFp1QfkGgwnrwkBH5txLrx220v6M9yOvYh7+tUdg2Dn/Babj
         pY0sIbkmzsE0n/QucB+r0ixWWj5q2V6TW8671r2abhi4nfI6dV3fUUjdsf2/pKwBMQ5c
         CmQ29eazeib8QqyAGUzxTn3AkxObTonkCw9dXVzSBf+KuNYvMEWc3ELP9ZsiB5lwPq8U
         ms/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709062525; x=1709667325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYGzuyxj3uSOAYsTan3w5fhXx7VNiNxX9GYZZ1OGDTs=;
        b=CC1dR++Jt8p/H8coJTnlElgohjIVHkmspWezLgMy0cPb7DoRgfnwJxelr1lTNTUqpq
         6wB/jvOMKakMje64Kb3TzQ2Tg2Vwf4oaQih0eowso//YTJ5V1JjVTjue+HKgDfK2Tz5E
         veFPrtuvqzQfHWcaArjpvaMEgeBQ/Jr3t6ncOHXGLMXHlJIDFkOm3ES1vLL4+iD9uFf8
         IQUbL0Y83F6+L7S9NjeY6bXnheAPxQWES0rs9JR9oy4MgOXV6g4JBRP65zFYV6KLjUkt
         pl7UwT8wkiJXugaEp0+P2XkdWJC1QcTYZZllD6/xCGG01dpgsuUp4qmdVJlseuPgy35a
         uUlA==
X-Gm-Message-State: AOJu0YxRYUd0Uj/wZ2PlrkFsHf2KACseLIyBpF414gf7+W4c6G+KtdAe
	PVZe1Ay4KYvpU+SEY9yNg7W8RWnkQM+wcmIG/J8FxKjycf8nbbm5mMh4EzP/
X-Google-Smtp-Source: AGHT+IFSnL+0OB1/NkSUHybibs4ceXC5mD70w19LJtzL0VOsoakJ2DVXf4LjW+oAy+lpqjhmD+0p5A==
X-Received: by 2002:a05:6102:3239:b0:472:5c3e:caf4 with SMTP id x25-20020a056102323900b004725c3ecaf4mr1821819vsf.27.1709062525104;
        Tue, 27 Feb 2024 11:35:25 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id jy2-20020a05622a818200b0042e3468a98csm3866239qtb.4.2024.02.27.11.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 11:35:24 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/2] unit: fix memory leak in test-dpp
Date: Tue, 27 Feb 2024 11:35:20 -0800
Message-Id: <20240227193521.304643-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 unit/test-dpp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/unit/test-dpp.c b/unit/test-dpp.c
index 781d494a..0a4fd01f 100644
--- a/unit/test-dpp.c
+++ b/unit/test-dpp.c
@@ -331,8 +331,10 @@ static void test_key_derivation(const void *data)
 
 	if (vector->i_asn1) {
 		HEX2BUF(vector->i_asn1, tmp, sizeof(tmp));
+		l_free(asn1);
 		asn1 = dpp_point_to_asn1(i_boot_public, &asn1_len);
 
+		l_free(from_asn1);
 		from_asn1 = dpp_point_from_asn1(asn1, asn1_len);
 
 		assert(l_ecc_points_are_equal(from_asn1, i_boot_public));
-- 
2.34.1

