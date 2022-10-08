Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8DB10F3
	for <iwd@lists.linux.dev>; Sat,  8 Oct 2022 07:56:57 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id i6so1336134pli.12
        for <iwd@lists.linux.dev>; Sat, 08 Oct 2022 00:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JwnenL+wtIIe+fncZZVh+iCgJ2GGlU5UH8GVo2Aiwo4=;
        b=UUv7OmnrdPo/6HLCGRQUyZjdkebwoxVmM9BZQ2tsNZ3Sbjyp7BgY11U25cjyqC1Dys
         Z/AmrarQTAYaaM3GZTrxrPeoPZI+wKpytEqCpSKMGibeYGcdjkc0FerXI3N7lmeWGQmM
         6f1/lNUB33gauj7+g5JAoX9efY4LM/WRqRZoWFvoyKl3N2JnFpSx7v5fqx956fG1B/vT
         k6kq3QSfph/ZyVo+CDc5sK2Xy0bi5TAiK3Ri3xd0qQ6CNr55ObX74o3d4fLMh76THLE6
         SltV64fIg9Nv648+1fgSk3+fWQQvvYn6wrWQtamcthC7h/iyGWMwqL9Ztl4IHw83OqVK
         tKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JwnenL+wtIIe+fncZZVh+iCgJ2GGlU5UH8GVo2Aiwo4=;
        b=WF/E/Fh24lZb1Qsik/ViuDcXJpLXSE3bhFU92x6ECXTEgO3ECgADqh3qUtVGnSzzoa
         gEi7hJoPXGcDLrqP2TTzEt6W2d6xVUgKVnLzKx0hGJ5w2os5ssyVkf7P3FqZWqK8mTIw
         vArug1rx+joVlGX1zXMoFq+aZXFRVOE+rmfPQXEhlZ6heoYokdsjIWuBpdf+Zrn4oTBs
         NWEm+J23xu8q0xmL5Ty1FFUaC4QOq5DFChxH0v4FRO02slOYFhphqx9CzR2mgNGTS2jx
         i1bYuqaMYO9M/YmaFrCB1Rtt25e/YO3suNIMgQuqCjNlqG/6IxF0tC3TPfBFEI1dCIz9
         S7hg==
X-Gm-Message-State: ACrzQf2r09yzB44R0liqQnBsRWIR8KybmDYKP52sfhnkGbgeSQq3Izfe
	i486oS3L8tlBFVv3wDSnk5764rselMo=
X-Google-Smtp-Source: AMsMyM4XRHyRA7KNLVpx/UKoNw+6lBZba7wXued5aD1oKwopZeyZJWivfj8FZxvgqBBW4ytbtyX3PQ==
X-Received: by 2002:a17:903:11c8:b0:179:de93:bd7e with SMTP id q8-20020a17090311c800b00179de93bd7emr8563430plh.95.1665215816302;
        Sat, 08 Oct 2022 00:56:56 -0700 (PDT)
Received: from localhost.localdomain (114-41-39-105.dynamic-ip.hinet.net. [114.41.39.105])
        by smtp.gmail.com with ESMTPSA id d14-20020a170903230e00b00177e5d83d3esm2770792plh.88.2022.10.08.00.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 00:56:55 -0700 (PDT)
From: Pinghao Wu <xdavidwuph@gmail.com>
To: iwd@lists.linux.dev
Cc: Pinghao Wu <xdavidwuph@gmail.com>
Subject: [PATCH] client: handle wide chars for table rows
Date: Sat,  8 Oct 2022 15:55:10 +0800
Message-Id: <20221008075509.26252-1-xdavidwuph@gmail.com>
X-Mailer: git-send-email 2.38.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Try to find out printing width of wide chars using current locale and
its byte length before falling back to non-codepoint UTF-8 bytes method.
---
 client/display.c | 16 +++++++++++++++-
 client/main.c    |  3 +++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/client/display.c b/client/display.c
index b729ad4c..dcbe11f8 100644
--- a/client/display.c
+++ b/client/display.c
@@ -26,10 +26,13 @@
 
 #define _GNU_SOURCE
 #include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
 #include <signal.h>
 #include <sys/stat.h>
 #include <sys/ioctl.h>
 #include <unistd.h>
+#include <wchar.h>
 
 #include <readline/history.h>
 #include <readline/readline.h>
@@ -401,15 +404,26 @@ static char* next_line(char *s, unsigned int *max, char **color_out)
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
+		/* Non-ASCII, try wchar */
+		} else if (s[i] & 0x80) {
+			wchar_t w;
+			int w_mblen;
+			if ((w_mblen = mbtowc(&w, &s[i], s_len - i)) > 0) {
+				/* Compensate max bytes for wide char */
+				*max += w_mblen - wcwidth(w);
+				/* Skip other bytes for this wchar */
+				i += w_mblen - 1;
+			}
 		/* Add width for non-codepoint UTF-8 bytes */
 		} else if (((uint8_t)s[i] >> 6) == 2)
 			*max += 1;
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

