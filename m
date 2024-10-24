Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83E149652
	for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 16:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788404; cv=none; b=ay5WTOzXZQrGvnVmiIXX6Nt8q1Ywd8zsXMxHlZhrE2DKAIcn58vKUnu+3riimB0WdMr+etO91zVygI6C/W/DbIwr9qs4sO3fHJEASv6VM2GeM30vGOZkspgWGLPaQCv7jQdZdAAyqYkDzeyj/iHl1GlDcgQ0oHX8jW685Kqsw/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788404; c=relaxed/simple;
	bh=dHn7jSGLThaoMbEx/QzezbLNldawWtMqhWny1o1znV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HQDFyr0dClRVnv8epey2ZafSitTsT0SYUK1zhbiDHjh6LOjX55/F5xTrpOP4+qWHBUONQKjm2FWR7fsRw6mLUGDLmwYzwFOS8BCGfShVtyDvx0yx8WKrzD6H99nUGALhLxk/Zv3PdwNNjr9gUD4mE1FrYXmDteFO/88xcqzF3p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSzu55z+; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSzu55z+"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460ad98b031so6824371cf.0
        for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 09:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729788401; x=1730393201; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krpm8+olZZXBeM7oyucCBvFCqNhi/NWwQdLZGCjDOtQ=;
        b=OSzu55z+LL5jBmTcn8YGQdBL1jr0zP1g1VsMZePG+5OSWc8p9n6liGqATVaLw5avSQ
         dtOpI4ELmd3njZu+O61riKMYitBsRLBli3magw2/epudvG3HP2wDjz/Cc7LYir0Auqz/
         ZtdyOoaS+/rPhj/EqeCr3MTEgqcbjHp1GR5TnRjYPY4AgFNL6FeHZQ4+YMD+bQL7mNe3
         52sJJWbLZPmwtvcz4gMBHyJmwv1zzTbq78Y0f+rBUT7ejF0+rD6QWRXqIWW1CDP7phHJ
         5f9vnxK/HeKLSgMss81FySkNGC7Cl4wwUpsQlc+DZzIdJxH9NH18c/h+UGjL28N/pbCW
         b8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788401; x=1730393201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krpm8+olZZXBeM7oyucCBvFCqNhi/NWwQdLZGCjDOtQ=;
        b=gLel4/B8O9gSA90aoOUGvLCTj3co/SbrBKJN8R/4I/KNx03PrnQTwfS8DR7+2X5LFr
         eQuXK06Zvr3cPzQpnBsY6JDlFMpQnTahmvMm+S6BJHEBFl5MHilBcZPvyck53fxk5rCf
         5nxxnwXBw7R9kYuQtvZi6JZqy3VtazfA3uU+SrB4xpg6asvG1zggysXfnOgGKnpDVqNw
         ugsJbSXl3GQWX4bOCpljTi2UYnocjI7JZDYYSLXSb+zbH1God+k8Ml/MEBMsB7sMJAub
         PML+U6tVLsbiIc+Ysa6DS6UAEFdGgHb/nz5YUm1hxXCyig/TMxf2VMkSJWDI4oEmAzpR
         tupQ==
X-Gm-Message-State: AOJu0YxA3dXAEVTLgEa0BivlnGJui48y3xgcT+eVBnxploqwXx15T/ay
	JlQh9iCSWPz0ZkNohywvUzZQYKpu8RdVnD0DWES1Jq3j0Je+IbRYw91dHA==
X-Google-Smtp-Source: AGHT+IEofgW+Vs/hi/tkc2dAPCnJlkmvfCZsXjhBwSCSC0QnWwFm0SWHwj6APMFC/n875LHaT/Zxfw==
X-Received: by 2002:ac8:7dc5:0:b0:460:9946:56af with SMTP id d75a77b69052e-461147080f6mr82953151cf.44.1729788401400;
        Thu, 24 Oct 2024 09:46:41 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4611a19be2csm16893901cf.70.2024.10.24.09.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 09:46:41 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/5] band: check the operating class band before checking e4
Date: Thu, 24 Oct 2024 09:46:33 -0700
Message-Id: <20241024164635.176631-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024164635.176631-1-prestwoj@gmail.com>
References: <20241024164635.176631-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the band is established we check the e4 table for the channel
that matches. The problem here is we will end up checking all the
operating classes, even those that are not within the band that was
determined. This could result in false positives and return a
channel that doesn't make sense.
---
 src/band.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/band.c b/src/band.c
index 4e8eb9b0..09b2d932 100644
--- a/src/band.c
+++ b/src/band.c
@@ -1352,6 +1352,10 @@ check_e4:
 		const struct operating_class_info *info =
 						&e4_operating_classes[i];
 
+		if (band != band_oper_class_to_band(NULL,
+							info->operating_class))
+			continue;
+
 		if (e4_has_frequency(info, freq) == 0 ||
 					e4_has_ccfi(info, freq) == 0) {
 			if (out_band)
-- 
2.34.1

