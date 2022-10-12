Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC898F46
	for <iwd@lists.linux.dev>; Wed, 12 Oct 2022 18:35:24 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id n7so17067199plp.1
        for <iwd@lists.linux.dev>; Wed, 12 Oct 2022 11:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BzxWe73widwrLCbr8k72nAG15FUFYnBMsVRxtFiJk5E=;
        b=KBu15so/K8OkoKRZLPLp+IHfAcFR30I9icGzgwwpgQPk4t9TD6sunpgrSW1XEmdJK6
         yPtg+v52+8yR7aj/cnB1SCj3E9f9kUxYdP4AgetUWVoBGrtS244Y8QcqD+wdGPc3gH5Y
         1SRCvGc3sH05RLEciZpbh7/95FHmyrsg5JwPMy/59Q11NikX6Z4LSwy4ejuhjWMzY0gx
         +axRfgb5icL4AyACV6Ia1FiVKqrPJdCRAc10NefeM0wtoF4UjV5UDFmzQ/GPTTiftTtf
         EdAk5w5wenCy3vAdAMUOHzSHO60Cw9+jxkSPSi/pcLFZYCVZFCwq25dwA2rECpyvU2Fl
         oqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzxWe73widwrLCbr8k72nAG15FUFYnBMsVRxtFiJk5E=;
        b=GXKKnuH7bO/d0tdbStilM00cfkggx9JNWoLP5wy9Pgz9LGSKKjKmwBzeuq+tiqD8Dj
         q3h1UL6YQ5qKjHlM+KKMO2w8WKz1J9+m+VuvLmd1sd0NYAL2XSWj0h65dRv3oQXTGC9x
         nS37ck9lnEnc8PR3yzWavQAc8Jr0yIIXMbjwMWTcm28vuztte1Wewgta88C9cAziOA21
         kG6p4Nv5utbeC2IXqQGqmUb123oGcDtF2UD86ZH4tgDkKO6bPu0jHovtVXpR0su8kc/N
         ACMXQHfyMMxf29+hrkTrY/www6J87nERCn/0+rS6P8shDcgDXwJfeEdJb1HdaOfylxpj
         eMSw==
X-Gm-Message-State: ACrzQf1yYuU9GZ80pN40eo7eQlBvZ66GyQr2ITyejQOryq0Hd0QX/F2f
	0/Q6JSedouEWAda+ezOMKB2Us00qmVk=
X-Google-Smtp-Source: AMsMyM6GYpmIi81nqk9zz/Y0RAhdzTScFoK2izoAIXaPRD+UjmAeORcniD3z0JM+PBaLtXFNmJIHFA==
X-Received: by 2002:a17:90a:7805:b0:20d:4fd9:9a0e with SMTP id w5-20020a17090a780500b0020d4fd99a0emr6689399pjk.169.1665599724249;
        Wed, 12 Oct 2022 11:35:24 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id h5-20020a17090a648500b0020d352dc81fsm1771341pjj.54.2022.10.12.11.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 11:35:23 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] client: validate utf-8 before displaying row
Date: Wed, 12 Oct 2022 11:35:19 -0700
Message-Id: <20221012183522.321041-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In theory any input to this function should have valid utf-8 but
just in case the strings should be validated. This removes the
need to check the return of l_utf8_get_codepoint which is useful
since there is no graceful failure path at this point.
---
 client/display.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/client/display.c b/client/display.c
index ddd9551c..03ea33a1 100644
--- a/client/display.c
+++ b/client/display.c
@@ -420,11 +420,7 @@ static char* next_line(char *s, unsigned int *max, char **color_out)
 				last_space = i;
 			sequence_len = l_utf8_get_codepoint(&s[i], s_len - i,
 									&w);
-			if (sequence_len < 0) {
-				sequence_len = 1;
-				sequence_columns = 1;
-			} else
-				sequence_columns = wcwidth(w);
+			sequence_columns = wcwidth(w);
 		}
 
 		/* Compensate max bytes */
@@ -532,9 +528,17 @@ void display_table_row(const char *margin, unsigned int ncolumns, ...)
 
 	for (i = 0; i < ncolumns; i++) {
 		struct table_entry *e = &entries[i];
+		char *v;
 
 		e->width = va_arg(va, unsigned int);
-		e->next = l_strdup(va_arg(va, char*));
+		v = va_arg(va, char *);
+
+		if (!l_utf8_validate(v, strlen(v), NULL)) {
+			display_error("Invalid utf-8 string!");
+			goto done;
+		}
+
+		e->next = l_strdup(v);
 
 		str += entry_append(e, str);
 	}
@@ -565,9 +569,13 @@ void display_table_row(const char *margin, unsigned int ncolumns, ...)
 		str = buf;
 	}
 
+done:
 	for (i = 0; i < ncolumns; i++) {
 		if (entries[i].color)
 			l_free(entries[i].color);
+
+		if (entries[i].next)
+			l_free(entries[i].next);
 	}
 }
 
-- 
2.34.3

