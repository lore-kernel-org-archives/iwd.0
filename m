Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A321C29A
	for <iwd@lists.linux.dev>; Mon, 25 Sep 2023 18:54:42 +0000 (UTC)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-59c00b5c8b2so86408497b3.1
        for <iwd@lists.linux.dev>; Mon, 25 Sep 2023 11:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695668081; x=1696272881; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WzJaXNVHDuRL31ALX0/rwQRbkfJJ08kUBSnb+4iHJjk=;
        b=J/F5CaJ9AIhbYGxVk6rm6/r5mQYSmX3+3OASRC9qcqvrshfGoW2UJ6PtoATqgxxzE9
         Z+KhzskbHXtdt4YEKm67PIUwC+swkT24uaGwE+ZKoDmu2lMxw75GZvQl09ThzvoO8hur
         NVpAs4mU1oFucMAVPVZjCUtvHI6frsYqlpmSfb1hcGlRFxbF/CYjmnX2zOww7kDhbDL7
         5od5Fr6qVldDf/DWDK1PMLIq1W6zjblUyB6BM5WPx8mfPeGHH9PVTdM2s06db+ouQUES
         68CFfhFTcXsqdjtOTHsNdUd7A/TaNf5iin7kGMpzKy9yu5jCG6C1/Oh+jDhXgXLsS6Ag
         o09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695668081; x=1696272881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WzJaXNVHDuRL31ALX0/rwQRbkfJJ08kUBSnb+4iHJjk=;
        b=EDKu1VxfvzZQQ9dj9ft2A6WziOQ38EVH1tBWzI+r6NYXIK08mOnCBFp5y+UNOuOYdx
         FxPQlufE1g1CTLMVY0cHqbOlQQSC54Cz52Dz7U3f5IQxHEQefFGCsRqGzZBKFZS+ebwG
         fNDKOc9rJNHmR/Dgz04i3A9KWyCbaBdHBABtioU09wVCJ7OdaY/fOs9Pdudujm19UwzA
         KSlXfXaF2jO5QMTJeh4PZVnF2KKNVXog0pqR+cvEAt1CDhEjc7nT5crFpaNnsvjKGULu
         H03LEhTE2s9Y+TsHE00D3HyiZSmMUXE7xskD4SiGeiHcvCRzVGg9us0icis39Sf7Opc5
         5nrA==
X-Gm-Message-State: AOJu0Ywrpz/hT+GvZs5ZqrIq7bCyYiMrkZXGd4wk/D21ezEA7P61Eits
	VCIqOGvRgkBHqdviXzOKo2Kqd0yQMpw=
X-Google-Smtp-Source: AGHT+IG1A6OK1jNfmG8DdZ8hpHftk+Bv5wRwLTklqlxykwLK1lXWITovJDxTotYrQupJRu0lY7BJpA==
X-Received: by 2002:a81:8506:0:b0:598:9df6:1a4f with SMTP id v6-20020a818506000000b005989df61a4fmr7518948ywf.39.1695668081162;
        Mon, 25 Sep 2023 11:54:41 -0700 (PDT)
Received: from LOCLAP699.rst-01.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id v134-20020a81488c000000b00570253fc3e5sm2518920ywa.105.2023.09.25.11.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:54:40 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/8] doc: document [Rank].BandModifier2_4Ghz
Date: Mon, 25 Sep 2023 11:54:16 -0700
Message-Id: <20230925185422.2242494-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230925185422.2242494-1-prestwoj@gmail.com>
References: <20230925185422.2242494-1-prestwoj@gmail.com>
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
index ea366a83..294e4c7b 100644
--- a/src/iwd.config.rst
+++ b/src/iwd.config.rst
@@ -291,6 +291,12 @@ autoconnect purposes.
    :widths: 20 80
    :align: left
 
+   * - BandModifier2_4Ghz
+     - Values: floating point value (default: **1.0**)
+
+       Increase or decrease the preference for 2.4GHz access points by
+       increasing or decreasing the value of this modifier.
+
    * - BandModifier5Ghz
      - Values: floating point value (default: **1.0**)
 
-- 
2.25.1

