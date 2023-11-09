Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791CD37154
	for <iwd@lists.linux.dev>; Thu,  9 Nov 2023 19:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOPyj8ql"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5bf5d6eaf60so11583137b3.2
        for <iwd@lists.linux.dev>; Thu, 09 Nov 2023 11:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699559847; x=1700164647; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ij5eA0s9sfaGx/ZqHfXwHO1ED9Y3TSNEAHfqa8VCiNk=;
        b=OOPyj8qlrhZt/gyq0YaVXX346fFNVVUOI8accQKClzceXdcmyvffkph+Ll61vCauTX
         TOe7ZrnDp0K0YCO+JKgWVQMu0cIR3cOL0cZoWpUr5OdBVsjsCjOUEkGr/eRT5CGNNNw3
         TWqsLRJu67dMbOELufJeXWir5X0N1cxHQuyCaJebh7Sanih+dozrocsX5UwLKv0bSFJf
         nTTnwJMhSpvIwcN6vVe0QtTywlwOtIuxTWwK3L/OdodhuAtdRk6nCn7oNZSkeW+fYUBq
         qbDs4NOGNYb10ah0SaDsBBuD/OBepyWh0JpeT4OlzxybWKqjrQiuruo6rUrh0BOGAz1Z
         vfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699559847; x=1700164647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ij5eA0s9sfaGx/ZqHfXwHO1ED9Y3TSNEAHfqa8VCiNk=;
        b=MlVSFYrMB/vQo57Cj8mq+IPg20mFY/NtSqe7wh8tq6Ljm+qwcqJXpRxwJ+dNPfvC9F
         UK07P1Yqm7obGBKW0dUH4ykmUIxhQ4LniKhNNje6iX8v2JQb/DtfATt4B0zr8dVHGSl+
         OGoWR2rBVqhERkCFsj31nCSfcAmK9zlh1AEhT97OXLhmOuXrfHHrrLwP2v5q/vuy592h
         uNm3ED2btIPvan59zjRcK/1tcXqTFbyC70CSWr5SGLR/hHP9t5SB/SWBWMqzyEVpyGYB
         91oaWZR0Hg02iHRpm+qd4FuwO6/s20wcFfSa72LoWUKq5ZalmZY4FcnVGIUYJGIBJ0Ti
         neww==
X-Gm-Message-State: AOJu0YxgASVMWxL7ImLLp9YZuaVBj/0Kdn43W1iuMYl4O2i4vbMJmLaz
	86orw3N1bJb++2v/84RJFv/HfTDeo+I=
X-Google-Smtp-Source: AGHT+IEDlDKjdIz9MiqWGkq/2kuaaUJTgNckhGYjlcsKQzbGTgAjuJan4tOJWeHry4hMUcpy35tBJw==
X-Received: by 2002:a81:7bc2:0:b0:5a7:e445:fad9 with SMTP id w185-20020a817bc2000000b005a7e445fad9mr6022736ywc.35.1699559846916;
        Thu, 09 Nov 2023 11:57:26 -0800 (PST)
Received: from LOCLAP699.rst-07.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id w6-20020a817b06000000b0055a07e36659sm8052388ywc.145.2023.11.09.11.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 11:57:26 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] doc: document [DeviceProvisioning].EnrolleeScanDiscovery
Date: Thu,  9 Nov 2023 11:57:20 -0800
Message-Id: <20231109195720.56352-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231109195720.56352-1-prestwoj@gmail.com>
References: <20231109195720.56352-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.config.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/src/iwd.config.rst b/src/iwd.config.rst
index d9c94e01..794446b6 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -413,6 +413,25 @@ are buggy or just don't behave similar enough to the majority of other drivers.
 
        If a driver in user matches one in this list power save will be disabled.
 
+DeviceProvisioning
+------------------
+
+The group ``[DeviceProvisioning]`` contains settings used for the DPP (Device
+Provisioning Protocol).
+
+.. list-table::
+   :header-rows: 0
+   :stub-columns: 0
+   :widths: 20 80
+   :align: left
+
+   * - EnrolleeScanDiscovery
+     - Values: true, **false**
+
+       When enabled a shared code enrollee will first scan and use the results
+       to determine which frequencies to iterate to discover a configurator.
+       This greatly increases the chances of a configurator being found.
+
 SEE ALSO
 ========
 
-- 
2.25.1

