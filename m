Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B7A33EF
	for <iwd@lists.linux.dev>; Wed, 12 Oct 2022 18:35:27 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id 3so15757129pfw.4
        for <iwd@lists.linux.dev>; Wed, 12 Oct 2022 11:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5T/ofTPJe2X+rShYjd+1Zpcebpk+wNoK2zHiVyWxJys=;
        b=eT0dlU/Zz8jbGCHNAaDhyHgaJmBf5BB1lWa1ag0nXwpz6IszPfaJlmy4iZYWUsYdsS
         gHi8vxaQQDAz41uYYpV7MH65QDrRWP0NrhyvRzh+yYUT0fuekn0SG6/7E2ixYODE/nEj
         XILThuWUfGDYj5syvGA5nZPlLmE8KVwMUkgOFBYNpr+6Ry5BqIScUG8VkvsFjUUiSvnr
         BJLEaBqdHfoPdwaR5VSpQaqcxWQq1Wcsnr55/gdGhAJcwg0Q1/lJlKyTWgn67Uhi+xCn
         rQRpSy3MaZSJ7UF6BLbXOxIa34Cr/hzdEPXSWjyf6pMQDYKVD0OJahs0XnUyJuFPNcyz
         iT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5T/ofTPJe2X+rShYjd+1Zpcebpk+wNoK2zHiVyWxJys=;
        b=XF6d0T5+gJlvrKV+diJEfA2yP8LZUfrj4ur4rd4tJnvlSstrkplSL1Tyt8yn4hJbUp
         zdzLF5qpTuYsWYBnIFKSQOqnJAlM2/ONA2KpUZKK4hZo85ggEpbHJwLYIqgD9ckXrS8U
         y5rm8XIaHwrjtkumAeFS5e64HbgWHYtJQkkzY3DNMG+k6tVgNLGVm3gwgVZkCPpS2Orc
         xQtRAKL4LqY1O4uUM0hQuGkLGhzzPiJB6OKqnBC2Wf/ZUBo2LfNfyI5Fpw8SDgV7Eyyf
         PGWQ6iNfvlwuyjaTfh66lAM5e5o9HQEnl0bfI5A5jWhYfYShnNbugen0P5qdT3/2SkyG
         CvmA==
X-Gm-Message-State: ACrzQf1Id8gQNdSFhoz+Jd0dIKwqtOY4LEcohyKJGagXiPAQ79orLKx9
	5NK2dh7SxMPsYOZtXuz+ysOeEZBqap8=
X-Google-Smtp-Source: AMsMyM4PhCNxkXa0+mJDFjMycPibgZ9RINpaeyx9VGmRi2assQSz11gE+HIMkNe+P7c1lYkKvq7daw==
X-Received: by 2002:a63:ea48:0:b0:43c:69c4:68d4 with SMTP id l8-20020a63ea48000000b0043c69c468d4mr27041435pgk.416.1665599726505;
        Wed, 12 Oct 2022 11:35:26 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id h5-20020a17090a648500b0020d352dc81fsm1771341pjj.54.2022.10.12.11.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:35:26 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] client: fix missing character for line breaks without spaces
Date: Wed, 12 Oct 2022 11:35:22 -0700
Message-Id: <20221012183522.321041-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221012183522.321041-1-prestwoj@gmail.com>
References: <20221012183522.321041-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In nearly all cases the auto-line breaks can be on spaces in the
string. The only exception (so far) is DPP which displays a very
long URI without any spaces. When this is displayed a single
character was lost on each break. This was due to the current line
being NULL terminated prior to the next line string being returned.

To handle both cases the next line is copied prior to terminating
the current line. The offsets were modified slightly so the line
will be broken *after* the space, not on the space. This leaves
the space at the end of the current line which is invisible to the
user but allows the no-space case to also work without loss of
the last character (since that last character is where the space
normally would be).
---
 client/display.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/client/display.c b/client/display.c
index 812fa711..59086642 100644
--- a/client/display.c
+++ b/client/display.c
@@ -405,6 +405,7 @@ static char* next_line(char *s, unsigned int width, unsigned int *new_width,
 	int last_color = -1;
 	unsigned int s_len = strlen(s);
 	unsigned int color_adjust = 0;
+	char *ret;
 
 	*new_width = width;
 	*color_out = NULL;
@@ -452,7 +453,7 @@ static char* next_line(char *s, unsigned int width, unsigned int *new_width,
 
 	/* Not anywhere nice to split the line */
 	if (last_space == -1)
-		last_space = *new_width - 1;
+		last_space = *new_width;
 
 	/*
 	 * Only set the color if it occurred prior to the last space. If after,
@@ -464,9 +465,11 @@ static char* next_line(char *s, unsigned int width, unsigned int *new_width,
 	else if (last_color != -1 && last_space < last_color)
 		*new_width -= color_adjust;
 
-	s[last_space] = '\0';
+	ret = l_strdup(s + last_space + 1);
 
-	return l_strdup(s + last_space + 1);
+	s[last_space + 1] = '\0';
+
+	return ret;
 }
 
 struct table_entry {
-- 
2.34.3

