Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18A015A9
	for <iwd@lists.linux.dev>; Tue, 11 Oct 2022 04:14:32 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id y1so5291542pfr.3
        for <iwd@lists.linux.dev>; Mon, 10 Oct 2022 21:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fqpd8JQ6JEAnxJ076ZqwRsqmbbzH/jJZufuIT6z9vMk=;
        b=FkYr+JFBPG+3o1cnpa9j4JJubYKpUlwjn3tLuvuAD4BYRJRNWTqCk/kfeo+hxqLbs/
         XN/CyNg0XA1AOSAUX6XC3NpFiEWY8pPpVt/QwmP62PJskNPdRWFiBrY2fUCmgM/oR/+y
         8+rf2r1tUjwNfGNaJo3pifdio25E6+mYPjGOvnlbE/GybzMVRkWqIUKp/hbMq+Zeh/VI
         AyI0H36Yn3TGClWin9qWWyO8zxwNwD4uhnPhUChQmzmsSoL3fB4ZG+SE0Fs6A1Q/QagQ
         eQTZZSpEwZ4NbPjTjzviErhegUD2OjVc90oj2eCNbtj+Dv6bzTwzGRFctNzoU/R6cAMI
         N8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fqpd8JQ6JEAnxJ076ZqwRsqmbbzH/jJZufuIT6z9vMk=;
        b=xWoo2iqDpQ90PNt9VhPDed8TvAsZ/eB+8FRxxTRvIxANvq1OxSib6pgjj/0Clr8sON
         wooNoKm0T8ddevXqo9+R76hyiiyNUYaBfD21x8RbAmO+Q6GzhU8kEvcdRyFYtjXmPNHT
         kuAwy7BjWlSSzMvujonivso6IXGyHmS1MyONg4z7WqUD62JMGj/D5q5AIJqIsQo6FDm4
         3g/DDz8VExO5RQdmOZA+/FppMB4L2PKGAUO+I3n7P9plHOwctqtvFl84ErB/c2x88Qhx
         /v0JCpc0Hk6TJv/V8E9tGkoQ4/uOmEijpbofSa/xih8B2vyGvzO4LEi+jabETnP08F3H
         UZbA==
X-Gm-Message-State: ACrzQf1tltwwDbk2BdJpgDwo7A6Wp8SNHqQIFQgzKWDRvG24XxEGXbav
	1hcufHyKJNo7vaMp4PPsGtugTrU30RA=
X-Google-Smtp-Source: AMsMyM7eKqzzlkLCMblP6Jy/1yHdDHITQ3LAjTZ5QQqU8DJuYvxzwiqrjZ2oczIjXUkVvJ7q4V+FXQ==
X-Received: by 2002:a05:6a00:b4d:b0:561:b974:94b9 with SMTP id p13-20020a056a000b4d00b00561b97494b9mr22996179pfo.26.1665461671632;
        Mon, 10 Oct 2022 21:14:31 -0700 (PDT)
Received: from localhost.localdomain (114-41-39-105.dynamic-ip.hinet.net. [114.41.39.105])
        by smtp.gmail.com with ESMTPSA id g2-20020a170902d1c200b0016cf3f124e1sm7414307plb.234.2022.10.10.21.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 21:14:30 -0700 (PDT)
From: Pinghao Wu <xdavidwuph@gmail.com>
To: iwd@lists.linux.dev
Cc: Pinghao Wu <xdavidwuph@gmail.com>
Subject: [PATCH v3] client: handle wide chars for table rows
Date: Tue, 11 Oct 2022 12:11:10 +0800
Message-Id: <20221011041108.5933-1-xdavidwuph@gmail.com>
X-Mailer: git-send-email 2.38.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Find out printing width of wide chars via wcwidth().
---
v3:
	Code simplification
	Unify handling of color escape / char width a bit

 client/display.c | 30 +++++++++++++++++++++---------
 client/main.c    |  3 +++
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/client/display.c b/client/display.c
index b729ad4c..5ec80789 100644
--- a/client/display.c
+++ b/client/display.c
@@ -30,6 +30,7 @@
 #include <sys/stat.h>
 #include <sys/ioctl.h>
 #include <unistd.h>
+#include <wchar.h>
 
 #include <readline/history.h>
 #include <readline/readline.h>
@@ -398,21 +399,32 @@ static unsigned int color_end(char *s)
  */
 static char* next_line(char *s, unsigned int *max, char **color_out)
 {
-	unsigned int i;
+	unsigned int i = 0;
 	int last_space = -1;
 	int last_color = -1;
+	int s_len = strlen(s);
 
 	/* Find the last space before 'max', as well as any color */
-	for (i = 0; i <= *max && s[i] != '\0'; i++) {
-		if (s[i] == ' ')
-			last_space = i;
-		else if (s[i] == 0x1b) {
+	while (i <= *max && i != s_len) {
+		int sequence_len;
+		int sequence_columns;
+
+		if (s[i] == 0x1b) {
+			sequence_len = color_end(s + i);
 			/* color escape won't count for column width */
-			*max += color_end(s + i);
+			sequence_columns = 0;
 			last_color = i;
-		/* Add width for non-codepoint UTF-8 bytes */
-		} else if (((uint8_t)s[i] >> 6) == 2)
-			*max += 1;
+		} else {
+			if (s[i] == ' ')
+				last_space = i;
+			wchar_t w;
+			sequence_len = l_utf8_get_codepoint(&s[i], s_len - i, &w);
+			sequence_columns = wcwidth(w);
+		}
+
+		/* Compensate max bytes */
+		*max += sequence_len - sequence_columns;
+		i += sequence_len;
 	}
 
 	/* Reached the end of the string within the column bounds */
diff --git a/client/main.c b/client/main.c
index df5c0a61..7e8dead4 100644
--- a/client/main.c
+++ b/client/main.c
@@ -25,6 +25,7 @@
 #endif
 
 #include <errno.h>
+#include <locale.h>
 #include <signal.h>
 #include <ell/ell.h>
 
@@ -50,6 +51,8 @@ int main(int argc, char *argv[])
 {
 	bool all_done;
 
+	setlocale(LC_CTYPE, "");
+
 	if (!l_main_init())
 		return EXIT_FAILURE;
 
-- 
2.38.0

