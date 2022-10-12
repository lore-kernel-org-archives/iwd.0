Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4AD28E7
	for <iwd@lists.linux.dev>; Wed, 12 Oct 2022 18:35:25 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id h13so15863529pfr.7
        for <iwd@lists.linux.dev>; Wed, 12 Oct 2022 11:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxG3xTaX7TZEbLUFVGOiAYtxJmDDjJT1BBE+07PGVKA=;
        b=iLeqruqFLp3NFR5ILrzuak7Z06h0l4V8LwHy50mTRI4zknAGuehhV/YAOoOHYpl5Ao
         eM0ATCJ1Z4wZlvSrXW1d958Rc97MsuVbExEQzwSAdhh6GOTUDbgDP1yUTzvfK4itHKB4
         ELri69LO6r6sf7sZUMJyGtCaiiV/wzGOV73O9H96cBnn0DZhORFvyZf30f/HDcRhpcIe
         qw+dS0E1cg3l8I7rwyUbFmsifWLwdt+Dt32lmBtpqunuYyvhsTJ0E7+zVGu2xPizXQr2
         xEE+XVwlpUTc6GlE/OowAac3km5SAfr/62676YvCffLvzb0UVuX4CkjFeuLcRJ6x64te
         OaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxG3xTaX7TZEbLUFVGOiAYtxJmDDjJT1BBE+07PGVKA=;
        b=7/gw/83RngegZM9JwAmpw5TIIZBBiFlQQf2LBYwnLoPgdL46bNUvFhGJJOkuVjeIsF
         SJrNOScBGpt+GpDF2k6vURx9Ic8Q+R0eINV1a8Jk8m7iLF6Eh8zZ4SFGp/KOURTw+DB/
         V7SYy177y9GFzzTBxZyJg7xNKrQoPj5T6c+nNKKWHbLOC7pBbLQ2tn7B+g4svh5/j6wG
         BOYny1r+KXB3/uOsz/Y0uu6Us7uUneT2gZFkIxJWl+ns98/EcR3+/Ovj8Tj0ERSOENSP
         sncFjZuT5bDyKmXf19GAwqjAp+Ry3qWtxVL1+FZHDP5Iz/ibH6It1XY1peXWllKNTy1b
         ZoOw==
X-Gm-Message-State: ACrzQf3OewN0wuxO9oLjNEFmzNHjkOQX7VIdQLwAI6zifEJtv7ik9jij
	KITXJhXctEch3deNhAYKo8SS9ZxcFKM=
X-Google-Smtp-Source: AMsMyM63tnpSkcmlVazdg/L0Pjn7MZKwUrVDRWNzrs1/i9nacHmLCp7LBRlePHEopGyIK72tGeTH8g==
X-Received: by 2002:a65:6bc4:0:b0:439:8ff8:e2e1 with SMTP id e4-20020a656bc4000000b004398ff8e2e1mr26803309pgw.91.1665599725091;
        Wed, 12 Oct 2022 11:35:25 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id h5-20020a17090a648500b0020d352dc81fsm1771341pjj.54.2022.10.12.11.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:35:24 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/4] client: add extra parameter for new width when printing rows
Date: Wed, 12 Oct 2022 11:35:20 -0700
Message-Id: <20221012183522.321041-2-prestwoj@gmail.com>
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

The old 'max' parameter was being used both as an input and output
parameter which was confusing. Instead have next_line take the
column width as input, and output a new width which includes any
color escapes and wide characters.
---
 client/display.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/client/display.c b/client/display.c
index 03ea33a1..df0950d2 100644
--- a/client/display.c
+++ b/client/display.c
@@ -388,24 +388,27 @@ static unsigned int color_end(char *s)
 }
 
 /*
- * Finds last space in 's' before 'max' characters, terminates at that index,
+ * Finds last space in 's' before 'width' characters, terminates at that index,
  * and returns a new string to be printed on the next line.
  *
- * 'max' should be set to the column width, but is also an out parameter since
- * this width can be updated if colored escapes are detected.
+ * 'new_width' will be updated to include extra bytes for color escapes or
+ * wide characters if found.
  *
  * Any colored escapes found are set to 'color_out' so they can be re-enabled
  * on the next line.
  */
-static char* next_line(char *s, unsigned int *max, char **color_out)
+static char* next_line(char *s, unsigned int width, unsigned int *new_width,
+			char **color_out)
 {
 	unsigned int i = 0;
 	int last_space = -1;
 	int last_color = -1;
 	unsigned int s_len = strlen(s);
 
+	*new_width = width;
+
 	/* Find the last space before 'max', as well as any color */
-	while (i <= *max && i != s_len) {
+	while (i <= *new_width && i < s_len) {
 		int sequence_len;
 		int sequence_columns;
 		wchar_t w;
@@ -424,17 +427,17 @@ static char* next_line(char *s, unsigned int *max, char **color_out)
 		}
 
 		/* Compensate max bytes */
-		*max += sequence_len - sequence_columns;
+		*new_width += sequence_len - sequence_columns;
 		i += sequence_len;
 	}
 
 	/* Reached the end of the string within the column bounds */
-	if (i <= *max)
+	if (i <= *new_width)
 		return NULL;
 
 	/* Not anywhere nice to split the line */
 	if (last_space == -1)
-		last_space = *max - 1;
+		last_space = *new_width - 1;
 
 	/*
 	 * Only set the color if it occurred prior to the last space. If after,
@@ -465,7 +468,7 @@ static int entry_append(struct table_entry *e, char *line_buf)
 {
 	char *value = e->next;
 	unsigned int ret = 0;
-	unsigned int width = e->width;
+	unsigned int new_width;
 
 	/* Empty line */
 	if (!value)
@@ -479,10 +482,10 @@ static int entry_append(struct table_entry *e, char *line_buf)
 	}
 
 	/* Advance entry to next line, and terminate current */
-	e->next = next_line(value, &width, &e->color);
+	e->next = next_line(value, e->width, &new_width, &e->color);
 
 	/* Append current line */
-	ret += sprintf(line_buf + ret, "%-*s  ", width, value);
+	ret += sprintf(line_buf + ret, "%-*s  ", new_width, value);
 
 	l_free(value);
 
-- 
2.34.3

