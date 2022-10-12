Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D258290A
	for <iwd@lists.linux.dev>; Wed, 12 Oct 2022 18:35:26 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id x31-20020a17090a38a200b0020d2afec803so2856650pjb.2
        for <iwd@lists.linux.dev>; Wed, 12 Oct 2022 11:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+V6MG0rymQeMsYvPM5LgtIrSIncJ3qS9dsrtmSj57Y0=;
        b=CdFnUZLKy3GNSvoN5LfDzM5c+DE+0cvc7L8s9EeB7WWrv48fEhdCBMkljP/iEKB7JM
         SHNCdhw6bUfVV9htMVn88gW5ezpB1ghQ7Igy210G1YYZPcwWy2HmKOThuAVfQLpfjnlz
         VUsTIvs/BKUYmhrtLUG3r0ExSiIPMEeN4VXFv8ET/saLfI6g6ce4HHhSxLZbWGaUA1MQ
         4ero/5szhwse6IgaR09VlDBc9bjW0PDuEzwEm9WlxOnVqFohk8m9ZjV7sNzE6wxHYi4+
         Eo96DksEGc7dyQ4+aVGHdQ2m6X5z8xEm0dR49XNhxUz0drxnRHbytV97qLPM6620cU2l
         0O6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+V6MG0rymQeMsYvPM5LgtIrSIncJ3qS9dsrtmSj57Y0=;
        b=0kOO7BkQlTNcDKty1eG58aRWkuBkXa4th93Ukja5qOR7zaKnOcaQzjuLZ1S0K6DNKe
         FqKNOm9fa2WX5ehDVvkpq41Lx1llGnMVc/3gW+z/+oFXSyNISr+kTKbFP7ojAU31T+Gi
         gqkThnBsQbxEiFf8l9UiPlq3pwT++HV0TIqflaTX82wgiWwhO/w2pee0/D59m1Kaj44G
         DdkY44pE8IbMDfEwAvGj1xphbXcdenafG0Z2Z7Dcoe0rdNLnOQKTS+319CwRubUuhCvi
         xxegnFig9/4LUIAOPQus6Cz1jqySw7Ix6SUOc0k/cyZfA1LmfgV6Ly0zfH6yF7kBgnkG
         qCOg==
X-Gm-Message-State: ACrzQf3eYdMcrg3v3Lk3LdyRL3N7MPQ3FbE7t88gVKzReoRf+BP04wld
	yUj/EJNXNEvOdH4fcsKMI0xbrUmzWDk=
X-Google-Smtp-Source: AMsMyM5+yqlhu6dpKi0FDn/HDv2Tkvpr8g1WVlSh/XSwKfDtqNKxlyDzeVc4XapDLsE4Chpr3kpd/Q==
X-Received: by 2002:a17:90a:a088:b0:20d:67b7:546d with SMTP id r8-20020a17090aa08800b0020d67b7546dmr6822459pjp.6.1665599725867;
        Wed, 12 Oct 2022 11:35:25 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id h5-20020a17090a648500b0020d352dc81fsm1771341pjj.54.2022.10.12.11.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:35:25 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] client: fix not accounting for color escapes after line break
Date: Wed, 12 Oct 2022 11:35:21 -0700
Message-Id: <20221012183522.321041-3-prestwoj@gmail.com>
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

Each color escape is tracked and the new_width is adjusted
accordingly. But if the color escape comes after a space which breaks
the line, the adjusted width ends up being too long since that escape
sequence isn't appearing on the current line. This causes the next
column to be shifted over.
---
 client/display.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/client/display.c b/client/display.c
index df0950d2..812fa711 100644
--- a/client/display.c
+++ b/client/display.c
@@ -404,8 +404,10 @@ static char* next_line(char *s, unsigned int width, unsigned int *new_width,
 	int last_space = -1;
 	int last_color = -1;
 	unsigned int s_len = strlen(s);
+	unsigned int color_adjust = 0;
 
 	*new_width = width;
+	*color_out = NULL;
 
 	/* Find the last space before 'max', as well as any color */
 	while (i <= *new_width && i < s_len) {
@@ -418,9 +420,22 @@ static char* next_line(char *s, unsigned int width, unsigned int *new_width,
 			/* color escape won't count for column width */
 			sequence_columns = 0;
 			last_color = i;
+
+			/*
+			 * Color after a space. If the line gets broken this
+			 * will need to be removed off new_width since it will
+			 * appear on the next line.
+			 */
+			if (last_space != -1)
+				color_adjust += sequence_len;
+
 		} else {
-			if (s[i] == ' ')
+			if (s[i] == ' ') {
 				last_space = i;
+				/* Any past colors will appear on this line */
+				color_adjust = 0;
+			}
+
 			sequence_len = l_utf8_get_codepoint(&s[i], s_len - i,
 									&w);
 			sequence_columns = wcwidth(w);
@@ -446,8 +461,8 @@ static char* next_line(char *s, unsigned int width, unsigned int *new_width,
 	if (last_color != -1 && last_space >= last_color)
 		*color_out = l_strndup(s + last_color,
 					color_end(s + last_color));
-	else
-		*color_out = NULL;
+	else if (last_color != -1 && last_space < last_color)
+		*new_width -= color_adjust;
 
 	s[last_space] = '\0';
 
-- 
2.34.3

