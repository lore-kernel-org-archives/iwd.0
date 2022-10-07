Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79EF4C80
	for <iwd@lists.linux.dev>; Fri,  7 Oct 2022 19:59:40 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id y136so5811343pfb.3
        for <iwd@lists.linux.dev>; Fri, 07 Oct 2022 12:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PtBi06s7pypBJTzIoBWY0QEV6ZEAuaptWYT3owZYKxI=;
        b=grT6IBsov2pz/1A/4Jk03Ulj5MjWQs1qkA3U9Mg8yujx6JODTB6xLlQZYc8+ua1kN5
         +9DXC8cZy0SyJ0Ad+oDuD+HxUtxxQxy0q3bE1yeo2Zpt6f3q9dRzcHMFdI81bh0tGvvf
         iXGohu+TChMcc5ijV9/w7yhN07pGl1PstV17nEk+vuQ6ZcQLj1G+m772YlyBVL+UNzI0
         Ei2vZbvV0MYbh8lTXMl+cubq/lKfxr2vLv3mx8/GFEXPq6F/sVhfKEdrlvQGukZjenU+
         hxAqPAzj7NVQNI7XIAHOS5hpGMtA0nFEttiOZQq01WyFP57CLt8eU6yBSvy9zBXYezxR
         vvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtBi06s7pypBJTzIoBWY0QEV6ZEAuaptWYT3owZYKxI=;
        b=vapQMqqMf3QuEJNFin471AK7NfUXIsnbADz3BHOa8494xzZ5+6v5npsCdkXDvt1Mms
         IGWlW5ysFy3sEEybmk+W2htGkD8ZE//sF/DSemXdgB/PTen3mB9I0V0liVtl00HY7FdP
         GlUMz9gqSnyPdPGBs1rxcST4KUof8nEF5VKqkB7kqRUHUEQd+qd6IUxB9uuNpdwLGHul
         qK7z5zOBtSR77jBGys9RtJ4FmRq+oPGPCyN+pmm6sbZ6d49TRXGyzTAApyq4hTSJo1BS
         BH+LXcwvlCOdtqq817IZ4yKwkXiDpc2Qq0w3l6Kt/C61JFymAsfYHtq52phH0xKmQBSD
         J4/w==
X-Gm-Message-State: ACrzQf2EF9w2G7JxRpuMamDH2ncYNWjNpQspoaGk81vg4Z7UwMtm/PA9
	AJPPyHdhOi7T3nWjSyyqsp3jXuAsYVc=
X-Google-Smtp-Source: AMsMyM6YNZmFCeYzRp73wu4A63UEXNGK4O2A4CvLF4pn7tsHWA026gwNkRhqrKztU11U6dqj5/tG2A==
X-Received: by 2002:a63:1d1:0:b0:43a:348b:63fd with SMTP id 200-20020a6301d1000000b0043a348b63fdmr6194558pgb.52.1665172779977;
        Fri, 07 Oct 2022 12:59:39 -0700 (PDT)
Received: from jprestwo-xps.none (h67-204-159-212.bendor.broadband.dynamic.tds.net. [67.204.159.212])
        by smtp.gmail.com with ESMTPSA id 142-20020a621794000000b005623f96c24bsm2032965pfx.89.2022.10.07.12.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 12:59:39 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] client: better support utf-8 for table rows
Date: Fri,  7 Oct 2022 12:59:37 -0700
Message-Id: <20221007195937.8842-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The utf-8 bytes were being counted as normal ascii so the
width maximum was not being increased to include
non-printable bytes like it is for color escape sequences.
This lead to the row not printing enough characters which
effected the text further down the line.

Fix this by increasing 'max' when non-codepoint utf-8
characters are found.
---
 client/display.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/client/display.c b/client/display.c
index 2b0fd4f7..b729ad4c 100644
--- a/client/display.c
+++ b/client/display.c
@@ -410,7 +410,9 @@ static char* next_line(char *s, unsigned int *max, char **color_out)
 			/* color escape won't count for column width */
 			*max += color_end(s + i);
 			last_color = i;
-		}
+		/* Add width for non-codepoint UTF-8 bytes */
+		} else if (((uint8_t)s[i] >> 6) == 2)
+			*max += 1;
 	}
 
 	/* Reached the end of the string within the column bounds */
-- 
2.34.3

