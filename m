Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455F22D63F8
	for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892301; cv=none; b=quXbSwEt0YjX6wq3QYiX2TN6vngGkBDX/M8ex1qoW4AoQuAVowRjAmAQSI/FYy7JVGebpOC+LNLxuzL4EPmLrfUC0YffebeTkttOOsZX9oeO1AbJp3rPqrmATafhyBCTJqpmD4VV6/SLV2uF/J1So5YWWd4v6lU+L4Si6u2lz7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892301; c=relaxed/simple;
	bh=+FoAYuymTJ81sP4i7Ah69UN0+sTLWD+4RVb7gxMxN0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MsYjvKpwNJ1gA+LecKtHVLaM6R9QjI9l27OAGe3SrpBG8HOlFHWPzmUinm3ybMecqg8L/8dV1KO3Nr8Pei3ex1HICIY/DZVESz3ik3KQ32guE327DEDNHGbU8e2pAuhAUGPbEizJtMZfFAF2XSjNSXf/O/POw6Ov8htNLdSc7bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUjhLane; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUjhLane"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b0fa7ed37dso35765551cf.0
        for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 12:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755892299; x=1756497099; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CC0BmGamT1D4MDMJVNXRH0F7SgMDOadEDPNFc3yG9s=;
        b=EUjhLaneJJ4F0k3EcCQZvmv90uX4ZPmLiRodxiobQiGxk5/B8Pq7NpxwevkwzU3Phx
         Ekm7mrvmZQCX7+Fwb2QvIv1rvBifVAR2HAOtFbVk+AVxwWFM4AVLponJxcpDxGCNvs7p
         iFtdvJ7sVv6V8LJHviOh2O/tnDq3amWFtDMzRs/Gq18lheS7hk4UKoQEp/sZychyD31Z
         b1VKZR2H0+ce5wHUZyb8mjO4gt1GYxwFTqIIvb+n4j0VIuFnOw6PCUpWpDBK4OWa7W+s
         9/zhYNVZ+2/yPkNp+Z24bHvBUn/p/+fONZGGN6iSWjhXVoEwGRsGNl5aZhRveKMozmXU
         wPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755892299; x=1756497099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CC0BmGamT1D4MDMJVNXRH0F7SgMDOadEDPNFc3yG9s=;
        b=XJDjYkdmxb6dE0bZdTzHBBLLTH0luDzH9kHQ2jy2TSehB1FV7WSNgirQrS8COLz4p4
         6XU44a21iNq2veT79+TDHCcyCm4J0/FDudz/Kt4fH6mo6bu7806IZgPlUmFbiUXW6Nnt
         B1KpcXcWkyctB6uOQIWdRLntiIa0+IF0O84JZeAmWsjX1auDTdmktUB54pSj2zcaXAsc
         MjfuCQxZQoS9ZPdW6Csr5PUF4Rsy7EYfmlBRAXEOkDnQFPypGzyvDPPl1hIWJ20mEiPJ
         XtMAyoWXKiFsPn11eW09STlACdvRI78RPmavfcUuTpF98yvp4NfNuDx9/gA6xGvAzWC9
         00rA==
X-Gm-Message-State: AOJu0Yzd5ZEV9+WoSBEsv2txBtmSDDwMy0WFmOrWrbw75qld2x66Fy5j
	2AjuGklpO4kvAj9Jl9Vhi+3LxmKZKfHFngSitn1k5HvbvVKEDkqnI0aYMv/DVg==
X-Gm-Gg: ASbGncsGbsNS4uUcWKSy1b6Xnkzf9OniGdgghMKj0epWjRYzSJvfkzlJ4xmsbyfwfsG
	CaSlbRoadQknDPh4wCovPYOI5+PadZkkC7ECCgjmhOeilJt87tk0YNhdsGA49DlNPCzUWcevVrK
	BusAZS/KOFQ/fwlTeyFgFXh5y2yq9ru9xBWIAtDeUFtLKvA4+R3llqS8F0KGZ/rc2azQ97egZBz
	P0b5g2+2DeWoexy7q2W2YoXnqQ5QLgZMIPTmg6VAA4jXTWdvKegitrjhDOfsST2brBhulES3xpa
	b6Qtjh2R8FfE5/KgZvy2MD11qh5PTA2HsURLpQgQ+y0UstTD5kPIxCp0M/RNzg715rHZe6hFmMp
	PTs+XOqBLPbefBc/gBePv8GQY3pg5PT16
X-Google-Smtp-Source: AGHT+IEmlJhaCrUEL76QVG2vtzJN/RMIRSEZx3OycMW/HTe4bjezUGUip0KXAUijtxQeEp7B2RZJww==
X-Received: by 2002:a05:622a:438f:b0:4b1:22af:3984 with SMTP id d75a77b69052e-4b29ff900b2mr64265531cf.16.1755892298720;
        Fri, 22 Aug 2025 12:51:38 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e45c4asm4913221cf.46.2025.08.22.12.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 12:51:38 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 13/15] station: check vendor quirk for BSS TM request candidate list
Date: Fri, 22 Aug 2025 12:51:16 -0700
Message-Id: <20250822195118.271122-13-prestwoj@gmail.com>
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

If the AP vendor has known issues with the preferred candidate list
ignore it and jump directly to requesting a neighbor report.
---
 src/station.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 4919f89e..3424964d 100644
--- a/src/station.c
+++ b/src/station.c
@@ -64,6 +64,7 @@
 #include "src/eap-tls-common.h"
 #include "src/storage.h"
 #include "src/pmksa.h"
+#include "src/vendor_quirks.h"
 
 #define STATION_RECENT_NETWORK_LIMIT	5
 #define STATION_RECENT_FREQS_LIMIT	5
@@ -3378,7 +3379,9 @@ static void station_ap_directed_roam(struct station *station,
 	l_timeout_remove(station->roam_trigger_timeout);
 	station->roam_trigger_timeout = NULL;
 
-	if (req_mode & WNM_REQUEST_MODE_PREFERRED_CANDIDATE_LIST) {
+	if ((req_mode & WNM_REQUEST_MODE_PREFERRED_CANDIDATE_LIST) &&
+				!(station->connected_bss->vendor_quirks &
+				VENDOR_QUIRK_BAD_BSS_TM_CANDIDATE_LIST)) {
 		l_debug("roam: AP sent a preferred candidate list");
 		station_neighbor_report_cb(station->netdev, 0, body + pos,
 				body_len - pos, station);
-- 
2.34.1

