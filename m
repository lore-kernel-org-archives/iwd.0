Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8713A665F
	for <iwd@lists.linux.dev>; Wed,  6 Jul 2022 22:21:33 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id j3so3001234pfb.6
        for <iwd@lists.linux.dev>; Wed, 06 Jul 2022 15:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BmMZpc14Ab1wbx04tHduSMqXwFCtXithIXdMgoNEut8=;
        b=BMhSzMPTTi2F/Jko40C1oWojoi5HjPqygRZyoRT0w7bI35o+AP3vEeZjLV8Xf/3Td/
         y6CAY2QGtoiaXsoGypAR1oYiC9wMA8UxSjgYAX6KZHNVEuBmmyB+iq73VpeaWr1imnRm
         xY5psgpzpzP/PyFG2RlidMaKwdqYv6BRpQDE14DzVt0b0rY26NAa5LAkkIiZQi5tRlWR
         oSHFYoNbfiSrWKs61t4cIKZmkYcRWhQkVxNSF6OT087YVAq0fgvfTkRZuIqP8Ywgn+jw
         r1n8Y4hf+sTG5FGKclq/EC6VXkgQUmt7LfQiSujn1zhrxFcl+fYQRkGGrSJu+Qy9y+2u
         pOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BmMZpc14Ab1wbx04tHduSMqXwFCtXithIXdMgoNEut8=;
        b=obtf1Tmla6+68yfXZGgvIQ19yKcLK2yHCcEYXtbVro3bn7hwhbdjuPH1F2noG83FcE
         /s/R4vAmj9AlOMewrQyk59iUUNNmUBdC8B/kL/Gca0Y27h7bgC+QgPb24smSx7UAgp6e
         N6o66Bw8b80kidDbvO3y8Kjasz5zGQnbUXNFTYeq+iOUJxPJ43h3knwY1DbLlsWcFSgT
         iEpSjYS33GZdoyqFVXIEUW7VNQJEnx6Zs2sl5Nq0LrUBG5dl4vypvzLqYkO1ODL7kRyI
         ysNoZn1kYHMDUtUA9/feuN2jQy9IID+34SL3jLlmyXnK5hJZddM/RvsNNQoy4FXgroFr
         5qqQ==
X-Gm-Message-State: AJIora9qABoUJXDMRV2sZWIfZIB+WbzrQWqHXuCRmbOk1a83SctV+gdE
	Uo9cI2DmsUN8/ztMz+C75U6yWv8ZX9w=
X-Google-Smtp-Source: AGRyM1uXBFlFCDzVh1FoOYdSFoSzISeX6UxPImFsLSYqELobYxHXGQhK4r2NZbn58/HcHOFOh1j1fQ==
X-Received: by 2002:a17:902:c205:b0:16b:f021:4299 with SMTP id 5-20020a170902c20500b0016bf0214299mr12633929pll.70.1657146092740;
        Wed, 06 Jul 2022 15:21:32 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e80900b0016a163d1cd5sm26517696plg.253.2022.07.06.15.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:21:32 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 07/14] client: update CLEAR_SCREEN to be consistent with others
Date: Wed,  6 Jul 2022 15:19:00 -0700
Message-Id: <20220706221907.126408-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706221907.126408-1-prestwoj@gmail.com>
References: <20220706221907.126408-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clear screen used a \033 escape sequence while others used a \x
---
 client/display.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/client/display.h b/client/display.h
index c34cab9c..8e597bb5 100644
--- a/client/display.h
+++ b/client/display.h
@@ -30,7 +30,7 @@ struct command_family;
 #define COLOR_BLUE	"\x1B[94m"
 #define COLOR_YELLOW	"\x1b[33m"
 #define COLOR_OFF	"\x1B[0m"
-#define CLEAR_SCREEN	"\033[2J"
+#define CLEAR_SCREEN	"\x1b[2J"
 #define MARGIN		"  "
 
 void display(const char *format, ...)
-- 
2.34.1

