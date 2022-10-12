Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B17817CF
	for <iwd@lists.linux.dev>; Wed, 12 Oct 2022 14:03:31 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id x6so16303162pll.11
        for <iwd@lists.linux.dev>; Wed, 12 Oct 2022 07:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lh2CudZlTZ6sjEPT+e4N2S7fdz4kE0D2RKuhRfxAql0=;
        b=Tus13x6ndthA1cBXA3Ng7rOtevpQyEEaa9qK8V6Y6vlpnQpLCtxwX1X+JNdKGxqBjR
         7W5O3Ga9Niu9dgGig3us/1d1SPUKnzun4gBlcGSky/hYvy3oSRpI7nCUtFDySMdkH5FO
         wk0PXjh8pw+5BIRzHnxXYxCDZn6Zmk+3iV8WmMHa7j9loQVgrr7byRInS0QfBAhi3t9S
         px8+L6Q4G7V2PI3kI4bCeTf4+YfVLF3EnySVRDNlc6+1h75dHRlm20JQuSHnjF7e/3Az
         15QsXcrn4XUxbGKSz2hnqd0t8nRFflPT6spQnLJDrPVZilFRYuEyKyekLI9VktldVhlY
         +2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lh2CudZlTZ6sjEPT+e4N2S7fdz4kE0D2RKuhRfxAql0=;
        b=B2vQqE0DxwEjF+phgCiuruaYNmqTTKCxI0rh/KfNrAwWNGN7pDzVZoha9b/NeHSHuq
         h6EYsGctH0r7vu5ghRUxefupYmgDJ7DrIUOicNfFV3bYXlY8RC9PfL/2RCj58kYHMMhq
         kESqFKX8ULDuPsdvOfW6IEEm9sJqyoMpJdbAdK/hGlHoX8nBbif+9695Oi7/HJSG9wPe
         OUyUOT1z+TBXBmEWcmQBWdI49bE5TFVHLbqktOCuxooddoTGHTIfGeI1+8x4B5WIARAb
         D0s5zMVD6X9FrDQGeC6pqesrQWwCMjUOy1HVHPFdEj3mJIMKIkCZTzNpLVRvpUSxxZsR
         uCZg==
X-Gm-Message-State: ACrzQf3ecpdvAedUIbP5F8j9Yy2INeTjcy9wXWYPzqaF/emgPRjQoT8b
	slnCGKqokmAlu2csa3eyQg7GIbZOjJA=
X-Google-Smtp-Source: AMsMyM72RaNsCS61M/AEnjCxT4o2f8tnhoHtgX2ptmH4pKFc6Gt0cmvegXmbDWPlJDqcTKR/wsZ+Tw==
X-Received: by 2002:a17:903:4d4:b0:17f:7ecc:88e3 with SMTP id jm20-20020a17090304d400b0017f7ecc88e3mr28538395plb.169.1665583410380;
        Wed, 12 Oct 2022 07:03:30 -0700 (PDT)
Received: from xps.test.cs.nctu.edu.tw (IP-168-124.cs.nctu.edu.tw. [140.113.168.124])
        by smtp.gmail.com with ESMTPSA id z11-20020a63190b000000b0042aca53b4cesm9672514pgl.70.2022.10.12.07.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 07:03:29 -0700 (PDT)
From: Pinghao Wu <xdavidwuph@gmail.com>
To: iwd@lists.linux.dev
Cc: Pinghao Wu <xdavidwuph@gmail.com>
Subject: [PATCH v4] client: handle wide chars for table rows
Date: Wed, 12 Oct 2022 22:02:57 +0800
Message-Id: <20221012140256.70306-1-xdavidwuph@gmail.com>
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
 client/display.c | 35 ++++++++++++++++++++++++++---------
 client/main.c    |  3 +++
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/client/display.c b/client/display.c
index b729ad4c..ddd9551c 100644
--- a/client/display.c
+++ b/client/display.c
@@ -30,6 +30,7 @@
 #include <sys/stat.h>
 #include <sys/ioctl.h>
 #include <unistd.h>
+#include <wchar.h>
 
 #include <readline/history.h>
 #include <readline/readline.h>
@@ -398,21 +399,37 @@ static unsigned int color_end(char *s)
  */
 static char* next_line(char *s, unsigned int *max, char **color_out)
 {
-	unsigned int i;
+	unsigned int i = 0;
 	int last_space = -1;
 	int last_color = -1;
+	unsigned int s_len = strlen(s);
 
 	/* Find the last space before 'max', as well as any color */
-	for (i = 0; i <= *max && s[i] != '\0'; i++) {
-		if (s[i] == ' ')
-			last_space = i;
-		else if (s[i] == 0x1b) {
+	while (i <= *max && i != s_len) {
+		int sequence_len;
+		int sequence_columns;
+		wchar_t w;
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
+			sequence_len = l_utf8_get_codepoint(&s[i], s_len - i,
+									&w);
+			if (sequence_len < 0) {
+				sequence_len = 1;
+				sequence_columns = 1;
+			} else
+				sequence_columns = wcwidth(w);
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

