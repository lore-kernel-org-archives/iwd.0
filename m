Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FC03D99
	for <iwd@lists.linux.dev>; Mon,  6 Jun 2022 21:34:36 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id g205so13730719pfb.11
        for <iwd@lists.linux.dev>; Mon, 06 Jun 2022 14:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pf/XKRF8d80wnQHArD67s6NasBG4R7XjI5CW6vLpxjs=;
        b=g6xUHVpcTdcn8MR+YrSS/AH6WEHHopzOEr3qTmFxZXGDCHTb2tuo4sTqFDbEJGJXAi
         FEmSHHTx3W4JhZU36TJPhhRkKDX+/x0WrpRJf5We0UbIbNcrshr7nLMuuVAlR8wE1Ko2
         LsDDs28Su0SY4IC9CtlVsIEtIPYAuD1m0kHzJGe6k0M+jdurfoVB0PiJqVLQB8B9e0nN
         7mOit9LKx6pJTJLJWsg5NBPj84XQQUK4cq4BMwuUN8R5x+FFrL4JSJiXHLS3M6aeW0zR
         sUNDNcY8Xz5cNzkaWEzVNq2xugilHDYjzXMidGScLpHFWLMMa4u+HUUXtj5ZmMsx/hj+
         ykBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pf/XKRF8d80wnQHArD67s6NasBG4R7XjI5CW6vLpxjs=;
        b=46ks9bdv5Q9rH46CiTEbYqkTeONaFQoT7na5ROzmvCCqqy0MMAaUapnpaEMdxj4ib6
         T+2gxxElJCB8vFBamBF6jrBglRFg3swl0VkfN1htoZJgeI7tHIGc6Jv1cE2F/Na1E/2G
         c6Yo5XmP/nmCZvCajvnxY/UeFMuQhWCiv9F+qY/kRvjjXPQiS7WrJQIuKM0DXB+ULLWU
         juv6DwWGdW66wS3uQXvRdS4xNewCFZBCaPSAF4AYA9QydEwqrYeh2ysaXXbd+7Js6RWY
         WyM4SlH1bFze0hTrKqoG/iFGNLTRg0x9LgYlEH2spfHN8vSX8b9TpSZhXDxuBX0+rdsx
         YJkg==
X-Gm-Message-State: AOAM530Ef3KhgAgIv5ONc+wo9UUdAjaoD0xgBh/zmSoTiUZXKmMqvm9D
	qDY/e+EkTBSaLce0U74MrdiwuDXQ6KI=
X-Google-Smtp-Source: ABdhPJya7nyZELt9uh3KrieRg+ulDTGhLe+HHJOaZsFCgYX+pymHxOdrVCRyQa/xzuFrvmIZpEUlSQ==
X-Received: by 2002:a63:90ca:0:b0:3fc:8c61:c83d with SMTP id a193-20020a6390ca000000b003fc8c61c83dmr21852896pge.203.1654551276020;
        Mon, 06 Jun 2022 14:34:36 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902f39500b0015e8d4eb1d7sm10872065ple.33.2022.06.06.14.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:34:35 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] station: should still build
Date: Mon,  6 Jun 2022 14:32:14 -0700
Message-Id: <20220606213216.36873-2-prestwoj@gmail.com>
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
 src/station.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/station.c b/src/station.c
index 7c88f266..0fbc76f7 100644
--- a/src/station.c
+++ b/src/station.c
@@ -20,6 +20,8 @@
  *
  */
 
+//add a comment
+
 #ifdef HAVE_CONFIG_H
 #include <config.h>
 #endif
-- 
2.34.1

