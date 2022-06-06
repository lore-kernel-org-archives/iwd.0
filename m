Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B483B3D86
	for <iwd@lists.linux.dev>; Mon,  6 Jun 2022 21:34:38 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id b135so13727872pfb.12
        for <iwd@lists.linux.dev>; Mon, 06 Jun 2022 14:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RdyxG47l70tSTreVGtLugyHShIfX6yYHbo3krymDiKg=;
        b=HdkNForMmIHMwa67Xh6p5WwRAF7UNWg8Q1B3otsPU3hgPvcakvJWNbsTNp1xS+M1H3
         2uxTDXy77kcXRKvl5hqAOfYRNIhH4o8/ZNTvNYDKKjjPRStUclkDG21VpE0xL/Dxbz9H
         IXr+rPsWjnRjpOW0TmRGamOmGQUDzwOqSexkSrmxkKGOMzgQZDGnsaOj6Vl4EWAhgOwz
         p0zc9G0DM/K12UkMYEwupyL93jSD+r5kF5n35F9cIpWf2WiFU3sCTa8Tvz8Ci3z6hp3H
         0x/xtthzFRukLLa+36JlCYMsM2wSc4lWoAC0f5YNDJPVDIRcLW869Ud/rE2SUHIs2SMh
         6F8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RdyxG47l70tSTreVGtLugyHShIfX6yYHbo3krymDiKg=;
        b=hMDCwFV046QEyPgfRnNedh3yOAa1wUMeRqr6JpSZphA4TOrx6uSOEZ8tv1Fv91IPZ3
         0FBSL3RPYfTAXsqv5myoBAx16ONj5h4T7iEAEpQddmhvrG0pXZDoZf+fgCQOuVkDYh3c
         /x0XRCAlk+gaDTYZXPBvpK6j9fhOWHcbEuM5aU01EoU0GYWkO3RbvxG3K7R8/hQWWVhs
         5LzYNLec2y73or/gznuojE+Wx4wryY8DqVPdgHcG4YQ2f8gEqLgoj5xeh3I9c8UUiMUU
         IvXSldP7AvVtrLlhTw2xT/cAq9p0c9c2MnSOiE/d8Z+cUy+KEolNrNivLU3CNSWQz2jm
         /wPQ==
X-Gm-Message-State: AOAM533GgySqFMCMn+LwdYqDgfdhHLSf0g2TWXX6LFfUK1grjygJJnwJ
	2mHge/Kyn+YleDKWonaWRkC3v259csw=
X-Google-Smtp-Source: ABdhPJyXZn5HfGwmQ8CwYzIHfCxlcHpOffWkr8fX23A0p+D3eNXTeFUA3dvot/bKCVbfncSsDPiXSg==
X-Received: by 2002:a63:ec0f:0:b0:3fd:e23d:b9f9 with SMTP id j15-20020a63ec0f000000b003fde23db9f9mr3627194pgh.612.1654551278064;
        Mon, 06 Jun 2022 14:34:38 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902f39500b0015e8d4eb1d7sm10872065ple.33.2022.06.06.14.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:34:37 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] station: fix the build
Date: Mon,  6 Jun 2022 14:32:16 -0700
Message-Id: <20220606213216.36873-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220606213216.36873-1-prestwoj@gmail.com>
References: <20220606213216.36873-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/station.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index f9978c4a..f52d2fde 100644
--- a/src/station.c
+++ b/src/station.c
@@ -123,8 +123,8 @@ struct station {
 	bool autoconnect_can_start : 1;
 };
 
-// break the build
-truct anqp_entry {
+// fix the build
+struct anqp_entry {
 	struct station *station;
 	struct network *network;
 	uint32_t pending;
-- 
2.34.1

