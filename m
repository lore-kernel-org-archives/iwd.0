Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D890AA41
	for <iwd@lists.linux.dev>; Mon, 18 Apr 2022 19:30:11 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id q3so13160678plg.3
        for <iwd@lists.linux.dev>; Mon, 18 Apr 2022 12:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/PKwy//tL1fTusKGMhLqxCIxORO3boXLVStqwLTw0gA=;
        b=nlhn5cv43nlGLA7TnrHxiz+vUkABsVNQFCmZ+BRX07c1rOlO1z2ZTr1UjG6wo1dExp
         O55i10QL3o+ydGHXfSNWaDpGBsZ55sBYLpSFFeoqWpLknVZ8DxtaXD16sfnSJjxH/3FE
         +y17XslfrS77JlLidF7H5A+Dmmram4RDJA7Hgsnr3vstIm60wZwwwUbq7DahDXGkxIBz
         91QxutARySBz/WD77iP7H1BTcJ3HdH9MBGtFn7RTfawMaZ3QFzUqyzy/8JtD0oki5PfX
         3OD88ZRqkUzduMS+CtgPrNLXXI2l6Y5xJU4kruKr83nYxT77nWoUDPl9BBgEQv1LY83f
         +3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/PKwy//tL1fTusKGMhLqxCIxORO3boXLVStqwLTw0gA=;
        b=EQrH4A+MESkaU9MUuXKXv/COmJmoJenV8/JhX3T2KrCsodBqHJS6bnEKSimA7GZOL0
         p5m9tIzBRrZxAcMtUN3yoBPPdr1VhupXy/qS/HhPOq8IJLpdX6tCbe0ebq90UWnYcReW
         fVDfdpBW9LlLBogJRANSXPbb2LnnAiSqTseq4WZ5VF9g1TPEakeO/aFyZr9mnx8qOLLn
         DRPKm0T5Vg3xmTXpbZp12/TpBE7bznsa0OPz7IiJ5Dhbps/ZFw9GB2DL3AoKuftZxcfZ
         RnFhNFkCqAdgPcWgultfoltqkNiPFKjj0N1wwpStAiCVfhQZRf0eT0Le1QUAOtfktTkY
         gLlg==
X-Gm-Message-State: AOAM531Fbswda2Z2IMZy0obFz0PKZ8xxqBYywiPtIFPagSDXaXjxm7mE
	KP4O/IHQMK+9BShRUJn+32pvLb1bEqY=
X-Google-Smtp-Source: ABdhPJyqIi42okQWx28UYLfCEiwk6+ytRTrFClXHN6tOEPl2uxulxtAP+c0qjQx3/YY2WPWVxMWuPA==
X-Received: by 2002:a17:90a:558a:b0:1ca:a819:d2d1 with SMTP id c10-20020a17090a558a00b001caa819d2d1mr19891440pji.126.1650310211158;
        Mon, 18 Apr 2022 12:30:11 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id c64-20020a624e43000000b005081ec7d679sm13275021pfb.1.2022.04.18.12.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 12:30:10 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] README: added to README
Date: Mon, 18 Apr 2022 12:28:00 -0700
Message-Id: <20220418192800.156446-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a test commit for patchwork
---
 README | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/README b/README
index 29e59a0c..cda95057 100644
--- a/README
+++ b/README
@@ -1,3 +1,5 @@
+Added to readme
+
 Wireless daemon for Linux
 *************************
 
-- 
2.34.1

