Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9BD8F7D
	for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892293; cv=none; b=mF4ulCq7wXwsWHRbA/L3DJ5wdsgepTcIGJUMfCkQdRI4jS94ev5F6BGQ2VnHuPPJaURZ6TfQldnq8x51L6NnnLva3NhrUEUHDFIJF6fq0yEDyT80ysxmN3p47rEOiXIijQ0VWxZ1d8ysH3CeCd0zt0vA38ZCM/Hi+g/086X+PfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892293; c=relaxed/simple;
	bh=aUB2dE3oX8aQ7mKHNN1Ap/NSX8KtEOMM7Sh4KwAcDTQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dXokomTHyp5bVyzleNkhvKeK+AaMFPsIRCKYrfrmp9rIRrAVBhRWO4eVq3nMcNX+OZXw2VycLWwGNXyx3N09dgPLivi/a6ATAxpAur5RlsO0N+nIW2IRERHq57kbKKG9o92eDC1ceGcE+niaosYnlKXSA9r+qOOBhHUZLbshCcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWlGl6G6; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWlGl6G6"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b1098f9e9eso37031351cf.0
        for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755892290; x=1756497090; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwpZZC9TDwaGIuyCYAEe126Z5+0xqmJnTQqohkoDiCg=;
        b=aWlGl6G6XC5mwmFSDu6bHOEO9Os5WpFNGN5f3F/4hBIkDj1a89K2lsGAdPhfE0hh18
         bU5LO+i4fGnau+AE7AszKxOLxCaQve9HV0LF3sWlZ0VOe9PJuHtHTcRklIvGo16ZxFP/
         OzhCLuh0Pn/3ZN4HEk1je2cBBCyD2PWlhr87nGmo2T9yx9gsjIKmHFz9Z4jUioN1GiOH
         7Wp3Wf4csNnTbliouPUAdXg8apVJXr+R5R4XyY6rBNC3edtlAKYPDsKxiJ4MUvXM0vd2
         +wKtkwX2z7jMXIOeVEkCG7sdgHzXO26jMsiUpV8eEeqkvzcy+pOIWEzH4cH1Wx6jT/7n
         OP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755892290; x=1756497090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwpZZC9TDwaGIuyCYAEe126Z5+0xqmJnTQqohkoDiCg=;
        b=a44e3crBi5z8cqRUhk+oL0pD2qMvv4Ip2aUPx012UkVQOSSC7/kaugzwlelaMdBfBe
         j1TBd356PWZMJjeahQcYM4S1C/2sOg9yBckMbGG1vk+nP+xMIQoVSwRvQ5VT7DeaZyL1
         jAle+DhG7Fu6rKaf0ni2uH2d3D/B6BrnnwMRlUJ3FTdXwv+HvSFZC+BXoZywnv3switp
         s/MOXpkgDxCD/Uo9+HMHBXiP6qFYmE3XMymF6TgxJY3jcZu8kfFeLOUTPn5LA8Fw/5PS
         OvgMXD+x9O0Q0pOUoKVn3jm0Z++Jx21VPcujnABxP9JFaEmWQxo2p2AQ250OVdv2dyd7
         ceyA==
X-Gm-Message-State: AOJu0YxjFFWdKzIT6677ot/C1AKhQPZsu7brFX/8S/iSBk7CiKTRwmuJ
	y7qbYcz/DST+AqNnqDPBkSTbFSjNakCbug9F+u4bNZ1zblCuwoX6LcYPnMqnxA==
X-Gm-Gg: ASbGncsB00M3McQuGp3zsWNdrP6Pl06NnFO69YPdirE4b6IQhVQQAaXjOFNmBwX0xCm
	2SSYFuHByFqaz7CgXCrQmtfJ3hh2l4Sde1Wb82z0z37qkfcN1K8YuAeO/mN1cxGXWt/pDHf9cFV
	ftJI8IfaQPko1WMjggGTBk9W5SV11webrhjVeONKCr7u6AuVqF8eub67AthnR9c9kyGr0tDxJ34
	E2S/9wkt1hz6lYXbOcDYpR1Xe/gXiboK4okfHAd3Q7BaNjSyFkfjPM/0OUUDA7zfjP3gzYUs+RD
	O+7F9tA/e/h8OdduZ00yeEe5w5wCEjTlD/+ezpx0WoP1neLsK2UhccwRI/Cagaodh6oeE3NfYaG
	6dDyi4ohVJLkWClAVTYw5g16dE4KZEEZN
X-Google-Smtp-Source: AGHT+IG5C2XHBM1yQzebcJ0xvQTcNHIHIo6zdW/4MDT1/ZL7PruUHjDRYtqKMkCGvrL4Cb1OZpqvGg==
X-Received: by 2002:a05:622a:8ce:b0:4b0:77a3:2b12 with SMTP id d75a77b69052e-4b2aaa43bdbmr53639671cf.28.1755892290130;
        Fri, 22 Aug 2025 12:51:30 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e45c4asm4913221cf.46.2025.08.22.12.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 12:51:29 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 06/15] vendor_quirks: add two new vendor quirks
Date: Fri, 22 Aug 2025 12:51:09 -0700
Message-Id: <20250822195118.271122-6-prestwoj@gmail.com>
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

VENDOR_QUIRK_BAD_BSS_TM_CANDIDATE_LIST:
  When a BSS requests a station roam it can optionally include a
  list of BSS's that can be roamed to. IWD uses this list and only
  scans on those frequencies. In some cases though the AP's list
  contains very poor options and it would be better for IWD to
  request a full neighbor report.

VENDOR_QUIRK_REPLAY_COUNTER_MISMATCH:
  On some Aruba APs there is a mismatch in the replay counters
  between what is seen in scans versus authentications/associations.
  This difference is not allowed in the spec, therefore IWD will
  not connect. This quirk is intended to relax that check.
---
 src/vendor_quirks.c |  5 ++++-
 src/vendor_quirks.h | 15 +++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/src/vendor_quirks.c b/src/vendor_quirks.c
index ccfcb444..e005ba3b 100644
--- a/src/vendor_quirks.c
+++ b/src/vendor_quirks.c
@@ -34,7 +34,10 @@ static const struct {
 	uint8_t oui[3];
 	uint32_t quirks;
 } quirk_db[] = {
-	{ }
+	/* Cisco Meraki */
+	{ { 0x00, 0x18, 0x0a }, VENDOR_QUIRK_BAD_BSS_TM_CANDIDATE_LIST },
+	/* Hewlitt Packard, owns Aruba */
+	{ { 0x00, 0x0b, 0x86 }, VENDOR_QUIRK_REPLAY_COUNTER_MISMATCH },
 };
 
 uint32_t vendor_quirks(const uint8_t *oui)
diff --git a/src/vendor_quirks.h b/src/vendor_quirks.h
index 758073b3..6c587d45 100644
--- a/src/vendor_quirks.h
+++ b/src/vendor_quirks.h
@@ -22,4 +22,19 @@
 
 #include <stdint.h>
 
+enum vendor_quirk {
+	/*
+	 * The neighbor list in a BSS Transition Management request from an AP
+	 * contains a very sparse BSS list which generally leads to poor roaming
+	 * decisions.
+	 */
+	VENDOR_QUIRK_BAD_BSS_TM_CANDIDATE_LIST = 1 << 0,
+	/*
+	 * The PTK/GTK replay counter differs between a scan and FT
+	 * authentication. This is not allowable in the spec, but seen with
+	 * certain vendors.
+	 */
+	VENDOR_QUIRK_REPLAY_COUNTER_MISMATCH = 1 << 1,
+};
+
 uint32_t vendor_quirks(const uint8_t *oui);
-- 
2.34.1

