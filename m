Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32401EE00D
	for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416507; cv=none; b=Eq3fWHwCIvp83Xpskdq/qfIVz4WdDptD7aNeBrUKEVJMmhD10urJh+2N59Gf+BdsLmv2EoJtbjwL48vyv9Jx+cwhyhpqPmfyIxPBS1DD/DyV5xRmPMxwmzPuFUrvn7xPNMrYuqVGX+fSB2qU7l1ZQA5f8D3P4vF4j7FAwYA85AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416507; c=relaxed/simple;
	bh=56w4WxzZA/9Zt9ZoWDKvtgC3SVEhzAPeQIIfxZgYOPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ba+Nj8FUvC+Zz3Jtimv0v+2tWEkHMWS6S5BmoBwzagN1yn8IwAW0Y/6a2ZHkG4UZGPp6kJ7B+hRT9uQ5g00jWZhSNlfiotV6hPXhQjCTeChxYLd7avBZshtnqKr8fgToJxDLiJvnEgZwMgKeudk/KNDoqjtHQ9jMLFStaXZxHVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6FMkFEZ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6FMkFEZ"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5e39d1e0eso636760885a.1
        for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 06:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745416504; x=1746021304; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iJWhMD0Ak1SHC17feQ2EuCc29jzgROjVtLX7aNjxWE=;
        b=Y6FMkFEZLZPhUfFlTtWUhbZesvIVPzWBPShBNdlfz47HP6P8epgEXDz+vQZh7qRf4u
         MZ6nKkpKr1yWTLcWdjukB9zOniUvV8ddkxBt24H1pvbV3O1CqPMM8q8KlYK8oR9wByf9
         OrYDyi1hkrZ+1bnraP5vFdWkGT4MU8IkXN239eLwFPUFMoYNvLqcmEsC1XJq1C/mCD8/
         Iqr8Nl91iblQ9Cny5pIdH7dGqiBbkaoPOqU0zd4Cupcyhl2TXRQTNg8Qnl/gJrcjQGV4
         xxqvlCPM7nS8iHYbE4z2cGxBwAjvF0bfbOFj0kY4crimfp8eoMk5/CjKp+ifXjBQ2+jN
         U8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745416504; x=1746021304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iJWhMD0Ak1SHC17feQ2EuCc29jzgROjVtLX7aNjxWE=;
        b=gmbN/xFLeQLNS3QBHLhAYmPbitzryKHYlhaY5IHbkzfAdDPNd4aglkJpXjA4vzZjMA
         +TSs8r/a/+Jhn1QHILL8dzyPafcwiYgd9BLmvsofRyWDC+C/ayXll53DLMj0EKfCT5Mn
         a+NH78oV/VSh/kLN8hUYeSG2/QwKan/HcY49WvktcJy68HI7hLYjDOwGo32BornqS8s3
         5WkJ7jVs85ieedg1/t4r0P3EEuu9o1vY2SfTiayLZzZUjHya2a7O64nO+zOrNQ8HwBXY
         pk73AB1wBo2lWKaeDSfWz6EUFDe17slYR0ZJ27ITZJtCRTQRkY+IYAmvG+7EkmLGLjz9
         qzdQ==
X-Gm-Message-State: AOJu0Yyrvi9Rp3cFFxiPOK7XviE/pOMldHDFmaYIWfsxfCn9xGOklsrk
	eLmy93FcCQmY9AFTI0BJnaHfSEIx4CIAesoKURtdd+vv5ZHgCfGgPHlgNA==
X-Gm-Gg: ASbGncuYr89wFPla+ABUyzLSDCWgFoY2LyjugBW2y7gIhrr8vSBHtYyMg4vOzagwEZm
	fxKT/uH6lp/FKyZ15vgBDX4+nmx4nP5ur0PvoIPnxIcmw8qlJFh3V/1GR9fV88FMZpO+1NY6nih
	m68HJEKkZ1GeAIC+g2G8dch0G/JNuRzDoNl9ywVsG0/4WbTLdG4DKS5v/byptGBoUweOx2cGVem
	dqhK+aGPyB7opA5mBIDkn0k/o6JGOnFVWd3GyRIE/dbd2M+5SxQvVK22uzystxjHC9GHpY+OOOX
	nxZuteWeMVIl3D0HGE89NY2yrKqF4NwJ1g5Itso=
X-Google-Smtp-Source: AGHT+IFtZpPBrDQMeM8C5Tsdpj0wwKLVAj0wuYuJzluinUkw17fNqta4cdc9llZCVVewM9wVVRYZ8g==
X-Received: by 2002:a05:620a:4593:b0:7c5:cd94:adc with SMTP id af79cd13be357-7c927f98545mr3225124985a.21.1745416504391;
        Wed, 23 Apr 2025 06:55:04 -0700 (PDT)
Received: from LOCLAP699.. ([50.170.153.203])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2b32741sm70733576d6.62.2025.04.23.06.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 06:55:03 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/5] client: fix get-bss command spacing/footer
Date: Wed, 23 Apr 2025 09:54:57 -0400
Message-Id: <20250423135458.11337-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423135458.11337-1-prestwoj@gmail.com>
References: <20250423135458.11337-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the new SignalStrength properties the column width needed to
be updated. In addition there was no table footer which caused
the auto-refresh to not work correctly.
---
 client/station.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/client/station.c b/client/station.c
index 5066a9f1..2c195f6b 100644
--- a/client/station.c
+++ b/client/station.c
@@ -765,10 +765,12 @@ static enum cmd_status cmd_get_bsses(const char *device_name,
 			continue;
 
 		display_table_row(MARGIN, 1, strlen(path), path);
-		proxy_properties_display_inline(bss_i, MARGIN, 10, 18);
+		proxy_properties_display_inline(bss_i, MARGIN, 14, 18);
 		display_table_row(MARGIN, 1, 1, "");
 	}
 
+	display_table_footer();
+
 	return CMD_STATUS_DONE;
 }
 
-- 
2.34.1

