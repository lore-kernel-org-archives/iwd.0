Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15CD8F7D
	for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892289; cv=none; b=kpidOiSdGz3bk8jOXFTbaDwW3Kn5MGXa8KuZeCbtMrtEhg0WkNEASdo9uiHihvWHTG84MSKjBHCHcRyTLS2QJoHbBvACYUyt+d1gzLd7iGmpEBGinXkbGJMKMrUgEjVxejWHC/YODCDbYeMextOfxmulznlyWGtwxmlA2pyLEOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892289; c=relaxed/simple;
	bh=tKILDrTlEQlguvq39EEeAV8B5GJI3JKiIQCdGlBoLn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DDn1xEUmVU8NCPRLQsN7t5tA4uomgNRvMWXusjwuPUsgn5Z+P377gZDGwSnXAZVXYl9wTUC0vYpMR8gqvjcUarG6luPSRFRsKA/SHZT12TTCjKJEPIVrEFaGG2dOP+4eaj57xM9kTmNnaHn/mnDV+Lh9v6ZkYnlXpc1wcO8a3b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Topd97qp; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Topd97qp"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e87055e1b6so374846685a.1
        for <iwd@lists.linux.dev>; Fri, 22 Aug 2025 12:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755892286; x=1756497086; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M70ElFNZoSzcjyW9BsfyDRV9YjE88huvNfk2tOXxM78=;
        b=Topd97qpZjKfvoLv6vkbo6wn22zmaXHbV81hnFLK8ijWueJ485ZMoCWj6lj87gbggo
         yNE5lKgt5tbixobJ2+qi2h/ETNDGTZfRAwdOuKPTCTeknNu8ZcusrgKkrMBvX7N+4D4w
         WBPGXJ+shhPkWpYsdl0lD2ciWJ2+H06rWTvlK5fVMmfQfd9pLcBdB7RVY6HAoFTgIKnb
         ZIBWddcVBo+qZX8dlS2USj2jE2e9BEmeQQudWE8e1o/zUsY0PstASOnV66HA4whTtNzy
         nw/MojcxAj1C1gPVtiIVjw/tMFifvDOGLkU+ZCdCLgRgt3AC3XSbJwaGy12toFKtJP9M
         Wtgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755892286; x=1756497086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M70ElFNZoSzcjyW9BsfyDRV9YjE88huvNfk2tOXxM78=;
        b=GK5Dr6Dcll2LwmvVTSafLwmkqrEcXhxWISVlpbVrt+J2RodvVzUzFUAtRy1X+j9g3a
         v1OqnwixxjhKXm6w2T5Tx7e80bcxg4gr/uXdJjLJhADMGI2WHyyhiW84ztFFsA9+4Zjd
         3CqQFHZJRq1fmr+TbK69rX5NZyH8gmNnfuT9yASEEtRaMKGli7MyVhQnXS2UUXvE/dcC
         qiAoPY5Kai6/Ggpp1HqwKGkYv/deWAokLPfz1iFQpQ0dwwtg9iUGWcV97EEWQoeGYILy
         XQ+Wdq6DIJ/mQohEGGDfjgyj/RSwHXIE32fk+/W/7D5U7V1gtVyPqq+zWSg8U4DBt+xC
         OgRA==
X-Gm-Message-State: AOJu0YxJ0sP6g+RtJM5bv1hdSrQK205u0rXolToatDAJQKIhzhexVUbi
	kaOt20z4vqaNl1Dq5GY6UVeQy04PtAFafcvEITaXWv7Dgu+D/3pz6JSUQ1z+2g==
X-Gm-Gg: ASbGncstn1iDKxPNdzaY0eBHDrboo0u6nk9v2p/ZHdOKPyZWEuAXTWQgt45yafhiK7Z
	VVOTtw3AATWeczBR7ueQpImAVsUiyrzZJZjHtTDpmW/7kYbLGWdrXDh6z+2Ds2GJksvqSksAcy4
	u80BzZwlb+4r/cbdwHgE6ghuKCu1l1iymq0wtuT+gsDS8YnnyEhbC/Hu2RKdlgYSnRpzzqop0Ur
	yFwmZxTT4kIQDR5uDNeqEy6jyKU2LuWQsxZVGpujtnS6GY9feVIjmf9vJEstp88IAjTstVe68nl
	HrqakcQTms7M0FPFv0BYXG8sh1QDPsGf4aWtE2dXFOrNwPpJfPNdWiHg5jF0VB/9zeOv8UxEjN1
	tOjBSJPXknmAQiToHLMYPd4YJMinTAjgk
X-Google-Smtp-Source: AGHT+IERjg9V+DLlEZmr3NYnGgWk8rvHtiUVeqwzRr7SIdONVUtrPqD0qVV6KUScMI7oiKJgf8HgSQ==
X-Received: by 2002:a05:620a:4445:b0:7e9:f1b1:ad92 with SMTP id af79cd13be357-7ea10f7228dmr544561585a.23.1755892286287;
        Fri, 22 Aug 2025 12:51:26 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b2b8e45c4asm4913221cf.46.2025.08.22.12.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 12:51:25 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 03/15] scan: check support before using colocated flag
Date: Fri, 22 Aug 2025 12:51:06 -0700
Message-Id: <20250822195118.271122-3-prestwoj@gmail.com>
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

---
 src/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/scan.c b/src/scan.c
index dfd667bb..d9f27c83 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -414,7 +414,8 @@ static struct l_genl_msg *scan_build_cmd(struct scan_context *sc,
 	if (params->ap_scan)
 		flags |= NL80211_SCAN_FLAG_AP;
 
-	flags |= NL80211_SCAN_FLAG_COLOCATED_6GHZ;
+	if (wiphy_supports_colocated_flag(sc->wiphy))
+		flags |= NL80211_SCAN_FLAG_COLOCATED_6GHZ;
 
 	if (flags)
 		l_genl_msg_append_attr(msg, NL80211_ATTR_SCAN_FLAGS, 4, &flags);
-- 
2.34.1

