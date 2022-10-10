Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0797233CC
	for <iwd@lists.linux.dev>; Mon, 10 Oct 2022 18:27:24 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id s206so10929233pgs.3
        for <iwd@lists.linux.dev>; Mon, 10 Oct 2022 11:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cAk3ePPNh4NiPV0nEiIIOTacKphvCbMkuo9Uy1PKjgk=;
        b=bvndvNF7sTmnIdgZOskCNASrdrDQv9pnGcS6Sfrc3BFwa5uonNX/tlILCOQk4BOMoL
         Xq6ZD9hWnOZyZtB2y3zfxSJRAY7mjvQwvkf5Sb5LFCq4ZpwzkBoAcrlUBcExwXcRRZmO
         uP6bcGBqhhUNWoFcwyWr1+xqdEKGJeJNDsjKFv4Un8ojKqk52bbrq4ekyMtlpwH9G7hw
         I+altxvogci1ndWnTrOwz7sk4zICQQuUBhrzD0zJ7iD9317T5D1T/e65T/2mIFp5jE1m
         IImmeTAlJmaQ1Yc/sH9HidklaPC9MKEPhoHRs9H8tcm/rxZjwCbhfQrZAaIxlPGIGOMw
         LkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cAk3ePPNh4NiPV0nEiIIOTacKphvCbMkuo9Uy1PKjgk=;
        b=AvybXqSoyCCFfg6sST8n/cp06Vb1N4Z3SMzkIEdsAWiljEiwmxrx8wsa6HeC9faZ+y
         crkT6LcKXxxwQywL0KW4T3Dr7Uiiq5SqKJIpA+Ca0Zdh4ftqLUDGjXAriHrFXalkqSZ2
         RCJiZkFYVXXK2owHOGbcXMze0uMjGBSAQIg+x/ZDEKv0roYsGZHTtL73BFNJZIZzYfKO
         6ooFf6BG1e245bGS5o9+PGf8zFdp07RWRl5WPHSr4ITscQqcOjHklD9dINXHIKTFOdEI
         0UBaD3pQqv3rLFHg236/nFYgRLVBt5eF3XXNI4buGVimDy58e9FvjrVNZTED0URKK8Iq
         1xgw==
X-Gm-Message-State: ACrzQf3ScT9QN+3nfPRuu6an9ldPNRaacFPuACJNvygLoYaMVYCUxIfd
	qkVpTMfAhbnimi0KQJNfY/QmkV0yqb8=
X-Google-Smtp-Source: AMsMyM6XnnXKxFSQYCBk4AWkxqWV3ga0HvoqkzVwQItWNKRw73uAjkteiU76RyAGpQlagc78O9FGGA==
X-Received: by 2002:a63:b64:0:b0:439:8143:c184 with SMTP id a36-20020a630b64000000b004398143c184mr17584225pgl.22.1665426444047;
        Mon, 10 Oct 2022 11:27:24 -0700 (PDT)
Received: from localhost.localdomain (114-41-39-105.dynamic-ip.hinet.net. [114.41.39.105])
        by smtp.gmail.com with ESMTPSA id bc8-20020a656d88000000b0043a1c0a0ab1sm6395211pgb.83.2022.10.10.11.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 11:27:23 -0700 (PDT)
From: Pinghao Wu <xdavidwuph@gmail.com>
To: iwd@lists.linux.dev
Cc: Pinghao Wu <xdavidwuph@gmail.com>
Subject: [PATCH v2] client: handle wide chars for table rows
Date: Tue, 11 Oct 2022 02:26:03 +0800
Message-Id: <20221010182603.55042-1-xdavidwuph@gmail.com>
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
 client/display.c | 18 ++++++++++++++----
 client/main.c    |  3 +++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/client/display.c b/client/display.c
index b729ad4c..42b5336e 100644
--- a/client/display.c
+++ b/client/display.c
@@ -30,6 +30,7 @@
 #include <sys/stat.h>
 #include <sys/ioctl.h>
 #include <unistd.h>
+#include <wchar.h>
 
 #include <readline/history.h>
 #include <readline/readline.h>
@@ -401,18 +402,27 @@ static char* next_line(char *s, unsigned int *max, char **color_out)
 	unsigned int i;
 	int last_space = -1;
 	int last_color = -1;
+	int s_len = strlen(s);
 
 	/* Find the last space before 'max', as well as any color */
-	for (i = 0; i <= *max && s[i] != '\0'; i++) {
+	for (i = 0; i <= *max && i != s_len; i++) {
 		if (s[i] == ' ')
 			last_space = i;
 		else if (s[i] == 0x1b) {
 			/* color escape won't count for column width */
 			*max += color_end(s + i);
 			last_color = i;
-		/* Add width for non-codepoint UTF-8 bytes */
-		} else if (((uint8_t)s[i] >> 6) == 2)
-			*max += 1;
+		/* Non-ASCII */
+		} else if (s[i] & 0x80) {
+			wchar_t w;
+			int w_mblen = l_utf8_get_codepoint(&s[i], s_len - i, &w);
+			if (w_mblen > 0) {
+				/* Compensate max bytes */
+				*max += w_mblen - wcwidth(w);
+				/* Skip other bytes of this codepoint */
+				i += w_mblen - 1;
+			}
+		}
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

