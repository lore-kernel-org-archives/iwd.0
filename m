Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DBFB656
	for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 19:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713209394; cv=none; b=YmZUwWTKx3q9Ku042FUZUrbq6fmtn0IHQ2RZNEKfFwMwId7enOoen9X5J+By57nL8wbdjCjibowRXG/81xmScsHqRBZ5dbFykQEcejXcoxOJ04uPczCZHZY1XFNLYyPuCLAKuSp8w/LCDxF4ElohxjrTBAqlF7AU9P0HrT233y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713209394; c=relaxed/simple;
	bh=/6+gEvNcTE7SbxKKsTVvfWqKZSR8OlnWEFQeuvx1/oE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eQb0DslhO1knHplLACVPHL65o71vUygmxB80Wtojih97vFiXOM4Q18rD83KsgjpVUcgV5iF5pdMY/Vkoam2htHXXiHmuQbMFwSfLfy5z4vizdm+/nmmyHeR8GGB0dCZbFLBaqB8o/msD3bZxmagC3/dyUiKjuQXCtidl42XCWGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cz1lHdlZ; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cz1lHdlZ"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78edc0f9636so160045385a.2
        for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 12:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713209392; x=1713814192; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nt9JLXtm+7jau8EIXdcris+h8YoBcqJmy42aFkfDLu4=;
        b=Cz1lHdlZwPDEvmi9ij2UMqr+iBn0fUmOwTq+a5eZn5tBxUi/0BArsve5wq1W8vn7sH
         g3qQ2wuT0NacBzTvjrHkhuwNmazUpLEXbuvUwffp3saJ8KTsp0TBeVMGVBi53Q18jNWC
         p5RqssV4E0ufzgpzbYf6lLBXM1e9Qn1W/xbfDsYVS/8BTRoxPMNLGhQbolwk822lsREb
         dyndDa2a8j9dECzqKJaUmJhWQZlWnmCzhBZQNG1zZSnO5Ji2XdGzf7wXZPUW+omE1Rme
         6w+0ZFPM4qUdP0srLS5x0gsIntKhCkv+/DzYDi9wAjXBwHoOhW6Tdf7MSf/s5catlQ9r
         GUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713209392; x=1713814192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nt9JLXtm+7jau8EIXdcris+h8YoBcqJmy42aFkfDLu4=;
        b=bfSD1rTdFxkpYLEbU7eHIpZ4ZVV+J0TW9PRtYbqRel2VWABE+i+u5TPFeeIm01zIXn
         TiFbk3X6noYatrQ/L3C9bUAiEFGevblrIP77f5WfkwHtVLxGhHvyL79Walch+zwwl2YR
         wwKXZPI5NM6m8xxf7KxVHu9DXmMX0tDITzHJq7ZW+E9U6R8/uqVdy8GE9MF+IU4k5L5p
         jYSVb731K8NNHp+dSeI+9gvj8li4s2h/jbQw8fMySmrp9q8YAz1EvTJGg8BrHjIGLkDD
         W0hv3MBvcpa7zRUSPRaGxxkMxWG7OQAW4gjOHzJ43cNhRcaXu4/xh5OAzwm+NUktb7yT
         ckww==
X-Gm-Message-State: AOJu0Yw//6fNbt+Iqr5jlXRuTlKxv8I8XoFQ1XoTEMM/jIt1EshmV3/x
	vFh7UnSqfhsVaTP6OU6M5+VOX/BmSdvy1+BSxVkg5UCPjPWsWgsU3slC3A==
X-Google-Smtp-Source: AGHT+IHK1FhL1aejfe2M9c40BM8jEg3LKy87En0svgJ0f7RHVxRVMaTfrbfN/vqDXlgU1cBhT+qpuQ==
X-Received: by 2002:a05:620a:45a4:b0:78e:a3d3:eec1 with SMTP id bp36-20020a05620a45a400b0078ea3d3eec1mr14597127qkb.47.1713209391738;
        Mon, 15 Apr 2024 12:29:51 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id wx8-20020a05620a5a4800b0078ecd71114dsm5003499qkn.69.2024.04.15.12.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 12:29:51 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/4] wiphy: include MAC of BSS with invalid HE capabilities
Date: Mon, 15 Apr 2024 12:29:45 -0700
Message-Id: <20240415192948.65857-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The prior print was not very descriptive, and now will log the
MAC of the offending BSS.
---
 src/wiphy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 712d20cf..8f5e46bf 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -1039,7 +1039,8 @@ int wiphy_estimate_data_rate(struct wiphy *wiphy,
 			break;
 		case IE_TYPE_HE_CAPABILITIES:
 			if (!ie_validate_he_capabilities(iter.data, iter.len)) {
-				l_warn("invalid HE capabilities");
+				l_warn("invalid HE capabilities for "MAC,
+					MAC_STR(bss->addr));
 				continue;
 			}
 
-- 
2.34.1

