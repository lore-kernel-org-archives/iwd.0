Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5458F7D
	for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892297; cv=none; b=CongSt1E58WXbv0uBT1vgL+5dL+wukprF0fj/gUYlIgRsguuKHx0clUJ4V865WvoGnwaP81ZhQi1MA42IeAf5V7YieSi8+5PfX6um45PcCF5g1o/2OtC8hXeMTo1p3Z/bw8HN8lamKXslWxB5Vwj82lagOMJptj5LNfGFFf3gBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892297; c=relaxed/simple;
	bh=tWvUO47RzOCvKdgiJy2caP1qW+L88IpakPkyXc08sT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LzPsz61Qvd/NibubRQIpQ0OWgD0LOwfUi3zEChZWv/hA4NrJFUDKFqpBUKWVPX5nNSbQXqmOLMr5guInyTuK6qeaHO59srAJ35RSD6FwKagWQyTVdB4Zy06MH31i4gGAThyCOeH3mmbk/SzMStpPVXfaVCRcQJh3X7cfQ11WVyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0MmGSob; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0MmGSob"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b109c4af9eso20472441cf.3
        for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 12:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755892294; x=1756497094; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuNuBnkO8nZnxJpZubAvRzwUqvQGc9mgHcfWxsuPtd0=;
        b=c0MmGSobcztOeJyayzpXicQfcw/QY8J42lQ/+SmymLHbDwQwr6ethcbt2+FLXjWnax
         p+ZCbvkopD4TQTkjCOuLc9T8Ba8FNbdhOpHjkDUr2W4NQ6Pz9D0gWLudn6WpyxqYrsve
         pdhbCJMdCNVct5urNdVtptlCG3MfU+mDO9ZhrBjZkfNemfuaEo5F94wDc1cLOEaLjv0J
         7Rb1icR4BXewxT+9kyuFnBbTJYgETglJxF2iYIHH9JBjwxniOqM8dkOijzLVGhgt4aE8
         +aDA0ViTEPVYeGMViCKOyrkqI0arYOfF6OWYM1Sv9nv/TCV1PvCvVVPqJGLvwdvTDP1H
         iwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755892294; x=1756497094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OuNuBnkO8nZnxJpZubAvRzwUqvQGc9mgHcfWxsuPtd0=;
        b=XYboyWl768VpncCeX/F3d1w5mNarVpfGXaCQKlwVB+fq/Mqglj+ryEaOs5vBbdz6qN
         XVIqy4QztHqLr9nsDZetpudXNJnbd090xxFWKFyXb36c4vRXBTI4t/wuoJgOOpQcaKxg
         qvnnHp9oHQNoG4F0pPP9Qh77WvNRfQXC757lW+shdItGSsx8nxEkaBlcp91pAW7AQq2n
         mUHV9WXna1yh/bT8euwxywz3n4pWixTwdY1KOSAoxhgJRM1JIkdcWD6SQR7TAd4lJAZD
         jTJf/bJ2PUs29Uf2AkjuPw9qhSakDPFSPEuktrKf3G7SKY9eZmNuEVuBLZvxoiE3mXi1
         gAXA==
X-Gm-Message-State: AOJu0YxWTEnXxDYHHP033jdpuB8oswSPtezt0ZGHFjm1ASOFt4HSBs2u
	ptZMCyrpLMRYzsjFsX3ry7S5FcvukaqbSzd+1C0CJlF5vIv9yHE4E+FCcGjOaQ==
X-Gm-Gg: ASbGncviPyl4nf5tOYvJJa+MSq0iI4QyM0eq5W1ZTaVe9TeGJCNAJXUes3OgrLn5TWc
	lZyKO/GAnPi7MLDkxqniGRLmQx1hPPg9HMzSMHH7BwmyurkBmSWSbhZfW8EZWa3hSZn8Yp2jLV/
	0tQP5OEFqswKGqSjdEmb2nHnWkS7GUXccf1WA7LpfTQFFCXn0YS2aNo/XS6wmdDPXfezIosyBQF
	YEJU/3CtXXPDR6myRViqDIIk8R942Qa5Fh58HEH2/WNjGMKWXh/GaPH42x3PaGgxxhO1uVeqc3k
	ZPXbvkKYlRxTPEjUV3/V8lWfLD3kFtVr1klUr8xrjXjZXWBk099ru1eagRODvTDkCdD1iQRgQG3
	zpZs2crkrAq7Ow3AnMR3wuPYQJoxyxzE/
X-Google-Smtp-Source: AGHT+IH19QSBbgOfdR83EIvppAFKWW3AVCU6r/h2UZe8TOrn2aq4BjaMSBrvHyedrGRYavi8Y498SQ==
X-Received: by 2002:a05:622a:146:b0:4b0:8392:80e4 with SMTP id d75a77b69052e-4b2aaa3e7d5mr44203861cf.14.1755892293730;
        Fri, 22 Aug 2025 12:51:33 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e45c4asm4913221cf.46.2025.08.22.12.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 12:51:33 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 09/15] scan: store vendor quirks in scan_bss
Date: Fri, 22 Aug 2025 12:51:12 -0700
Message-Id: <20250822195118.271122-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250822195118.271122-1-prestwoj@gmail.com>
References: <20250822195118.271122-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As each vendor IE is parsed lookup if there are any quirks associated
with it, and store these in a bit mask.
---
 src/scan.c | 6 ++++++
 src/scan.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index d9f27c83..b87c4621 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -51,6 +51,7 @@
 #include "src/mpdu.h"
 #include "src/band.h"
 #include "src/scan.h"
+#include "src/vendor_quirks.h"
 
 /* User configurable options */
 static double RANK_2G_FACTOR;
@@ -1221,6 +1222,11 @@ static void scan_parse_vendor_specific(struct scan_bss *bss, const void *data,
 	uint16_t cost_flags;
 	bool dgaf_disable;
 
+	if (L_WARN_ON(len < 3))
+		return;
+
+	bss->vendor_quirks |= vendor_quirks(data);
+
 	if (!bss->wpa && is_ie_wpa_ie(data, len)) {
 		bss->wpa = l_memdup(data - 2, len + 2);
 		return;
diff --git a/src/scan.h b/src/scan.h
index 4c1ebc21..b2a63505 100644
--- a/src/scan.h
+++ b/src/scan.h
@@ -79,6 +79,7 @@ struct scan_bss {
 	uint8_t *wfd;		/* Concatenated WFD IEs */
 	ssize_t wfd_size;	/* Size of Concatenated WFD IEs */
 	int8_t snr;
+	uint32_t vendor_quirks;
 	bool mde_present : 1;
 	bool cc_present : 1;
 	bool cap_rm_neighbor_report : 1;
-- 
2.34.1

