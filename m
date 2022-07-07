Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE3F2589
	for <iwd@lists.linux.dev>; Thu,  7 Jul 2022 17:57:28 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id b9so4879929pfp.10
        for <iwd@lists.linux.dev>; Thu, 07 Jul 2022 10:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BmMZpc14Ab1wbx04tHduSMqXwFCtXithIXdMgoNEut8=;
        b=CN1PnVX7agQYi6DaKBGIyE+NTmnlHTJl8Eg56RBP1UzAd4oQ3Ywqz61V8MD2GX75Nz
         PkmFJjS/WpZX0Ii0xff/vLWcUg9RO8Xjyd3yXMJXHxUJvwVisuubZbSzJS0nVEyiIne2
         j2Q1gVT8eepMFXuoN62wZ27rQR0++rITzXsllNtoiGlLXNBdBA+y71pHLgV3QKDB3irO
         xyXXh8LJmOO64oBI+Y62h8H9t4/s3aHHVKDXxjmXuu5BZgACqDqH1AQgqhPbXx3nWNZv
         HnU2z+ja9L9d+yEjQNwL8uHWzJzVfXpPSFefEuIE8m35MqJ2HQ/TCjSpmDW6T+Du0tpU
         DwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BmMZpc14Ab1wbx04tHduSMqXwFCtXithIXdMgoNEut8=;
        b=fbC/3Bgv7kTScj77YFIFokl7F5Bk0SIk1m1KpO38ZCcZ8nru4BwAO2VY0k6Dyr2k6k
         PhiNY276ozoX6j8i4PZ132hB3zJeIsNucPViIzs9S7SByVPpyAx6zHbWvR4cbj5OTgeW
         EExoCQPzg98a6zMKWDMGgie/iBCXvJxbPcHeH7JCTG3+TEY6SXwDaT1zW687/66JuIpU
         OhHwXBkZvUipxnn+RL143kahbSA4tDDCfOocuKEfjp7zXGwtk57mYnTLdQB5uZYizPfc
         354KIHKrD3iZAcNzODziVTFvp6ctK7Ra8nqGEqrA8cFHt16+t1pXwlCEbY+ulhQQutC8
         U2JA==
X-Gm-Message-State: AJIora/vtFMim0LGWT2bJo+7w4XnN+HgEwdUBjD5X7CMMohPyBUaoLYc
	uB3Ps9oS3RXXimm3jA/dQOqW5DcydsU=
X-Google-Smtp-Source: AGRyM1tnm8Y9eq+UTzZMkrddRcClLsPNhV1O3RdaaV+GcpNSqywRRo7aMMRKE8e3tWlInwR7VAtaog==
X-Received: by 2002:a17:90b:1a81:b0:1ef:9e9d:a08a with SMTP id ng1-20020a17090b1a8100b001ef9e9da08amr6590052pjb.58.1657216647484;
        Thu, 07 Jul 2022 10:57:27 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b001618b70dcc9sm28855223plg.101.2022.07.07.10.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:57:27 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 07/14] client: update CLEAR_SCREEN to be consistent with others
Date: Thu,  7 Jul 2022 10:55:04 -0700
Message-Id: <20220707175511.224597-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220707175511.224597-1-prestwoj@gmail.com>
References: <20220707175511.224597-1-prestwoj@gmail.com>
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

