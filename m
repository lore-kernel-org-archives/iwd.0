Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4934FDDC5
	for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824834; cv=none; b=JWH1onOgD6yH+PzuRfTo+ZSZp9UGQ6Q+1EWZ/9jP68QrC7zbdkRUK+ST0IUSbllK1tNOT/8dcnscNjNEIQr22nADAJrDBxGhxHa2CiRcM7fKsW2NUJvm4Uko8VHTZGO55+UzB9tVqX8WYOFuwfZtMoAfKi1RISTI+w5S866Vlbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824834; c=relaxed/simple;
	bh=LKOLMgwRlXclT/LJV0BeSKWn/MQTquqFJ8TqOMEQy18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=doyQKmzhfZY8n7Os973L2Yp31KbzO6XVHQnklvP+10LuPI9V7Evap/xZTaEcaBEe8ptk4so1VAQRGa/OnKVTFyqGAri+/gL+JGCW8Kac9DgvhphX+Pg1RBJAzM13Onetfwf5vHMZf1ozxDi0ciUaS2CyBI74AGz0A9iXENtaWdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ/Yamef; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ/Yamef"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2279915e06eso77759765ad.1
        for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 10:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744824832; x=1745429632; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VaekLyAKuIdZRCwGgVgIY20foZUnIETjgh9ETN9tBU=;
        b=dJ/YamefOtVE1QKZu7lCn+r+bJYy0kCWK5ORP6qY1E1RnLlMAuIOUXet3i6bfOveO9
         7hOq23PA00eVGa59R4nN023v6xCzPqL4CTRJNd8Qal+JSYY51myySUjQwUiWhPnzdjO9
         wCLvv54y7AW3Y4Y+4jOwz/HKVjfePFC/SqwZnVZ4iP38tatsBcfTlY8DqgDIjaEvV/mi
         IhzondCMlFad/rGrq8edKPkmuEsOkNOHdRE42DWYBlMIFlmxNtdenJo5gdZIZO479l1I
         DxQtmTrkHxbpYgULCxGDGHqf2t21rPd4QILCynHLNW6KtDKGZdaQ3mkIHBx5rK6J2soF
         YnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744824832; x=1745429632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VaekLyAKuIdZRCwGgVgIY20foZUnIETjgh9ETN9tBU=;
        b=J0y0PtgZi5G16jUNQcUK9uXtpB5E7av9k8/E5P5dvk0noFiYk+CxIsCxT7sumBejyf
         iRKdWNI9tvuyyvNhYoZ71S4M4NqEHua9DOUYgzPZuVn1WTaXAvRhMf2LsA1YS1UaarUE
         h1PzunJxNRzKGoRtMTm87Ca9TAFBY5WnGlmRoZXcG+zf3qgGLOvah8DtiqA0sBjw+xH7
         EL2mkA43RdLZMdpcA798ickhnVYXhivLzVxHOTzR4kpCPXOOgwFP1AcLhPoASEvcQycj
         VS/fYUZ9DdXmOqoI5vi3Td/ru54Iz89pyqGFppYXj/JNMyUqiwzOtmkpFEm10Q7rKar8
         62Lw==
X-Gm-Message-State: AOJu0YwslBzukoNJZcNnk/xEUvw0lXUztmdHrZ44iTjeoqY6D7IQIPcQ
	gcY+47aCZOIModhx2SHdOofD0H8KNiuBRwpo87mVqknjRLIyrXp/QJkpDg==
X-Gm-Gg: ASbGncujPszWW5WNQhdrT01TO0o81We4Dez1qGbQKUFWUKFQ50VQnEsyqCcHKWllmpd
	4DPq9k977bmypa6qVjTR51GQkwCF2OQm3elnPKDkeMpf3duigzqraSYVjJ5pb8OYByPtKU+Rvl8
	62jgYKT5YZ1WpmuoIX9ReA3dYU5B3ZTj9khrLmhmbq4I76rh5vUe/a6v4nIFvPiCbdWYxKf7eh9
	u2NqmMn/idPQgm4BjPQL90hUso5DPq/dpxrcc39mEIafxVgntFP4SLpnOhtnYQ4dCUfR6DHsMG8
	PZRwn5BYpdIRYvbJfnnXM2N37KMsTeGeDLGRi+gufEQF/oRJw2E=
X-Google-Smtp-Source: AGHT+IEz0EmQt4wRDKBNdV2q/r4KoXTyEXvdTqxI5MFFkPEG65ulX5FoQGpBIL6stqTtO0VX/qyaQw==
X-Received: by 2002:a17:902:ce82:b0:223:47e4:d288 with SMTP id d9443c01a7336-22c359836c3mr32063465ad.47.1744824832220;
        Wed, 16 Apr 2025 10:33:52 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1cd56sm17093055ad.83.2025.04.16.10.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:33:51 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/9] scan: fix out of bound array access for survey results
Date: Wed, 16 Apr 2025 10:33:38 -0700
Message-Id: <20250416173345.136025-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416173345.136025-1-prestwoj@gmail.com>
References: <20250416173345.136025-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The survey arrays were exactly the number of valid channels for a
given band (e.g. 14 for 2.4GHz) but since channels start at 1 this
means that the last channel for a band would overflow the array.

Fixes: 35808deb ("scan: use GET_SURVEY for SNR calculation in ranking")
---
 src/scan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/scan.c b/src/scan.c
index aeab6516..dfd667bb 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -143,9 +143,9 @@ struct scan_survey {
 };
 
 struct scan_survey_results {
-	struct scan_survey survey_2_4[14];
-	struct scan_survey survey_5[196];
-	struct scan_survey survey_6[233];
+	struct scan_survey survey_2_4[15];
+	struct scan_survey survey_5[197];
+	struct scan_survey survey_6[234];
 };
 
 struct scan_results {
-- 
2.34.1

