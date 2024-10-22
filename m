Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472AD1C9ED3
	for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729624171; cv=none; b=WgiRQ2Brk8/G89gmDZHs1VkHiFRw/Tl/zxS1QLGsQJobnT2OFohBd57D74P/Dtsj081e5B40J/wo7bOZl+yHKmlXcTeXM9OvBgCi4u3vVBy2SsQPr3YRV7b54BNZuiJEQsNNfDOr7TklJ1TcdVJEE6zbT093hQqy/aGvYYWHyMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729624171; c=relaxed/simple;
	bh=fy9saxEeOdAc2Inw7MDy0DT5tM/z2T3Vhe4JotQlYac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MnDmoATnT+2cKlEKZ+oVSc4FxokFUwHeO8UvhQqGdMQVhfX5cnfE37b5H+YSePNdzebn/8X73KNG7HVPnMaNkRlETLGqKF33D56cmn9Dswj3jM/Jyettpp5gqrBwqYx+Gich1TTipu/eoc7jummYzxvowaPBem2VAixJflxGIrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJ4TdsJh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJ4TdsJh"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4316e9f4a40so34137855e9.2
        for <iwd@lists.linux.dev>; Tue, 22 Oct 2024 12:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729624168; x=1730228968; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cleyCgLZFebwLrA8Z5Cn7hfeGHhF6AVUO0c6mbLoWI=;
        b=gJ4TdsJh5RJW49pd6uD+G0+ibr+Scofn2QrSIWokvzYpDeCQ+lm4Z3ebUHlGHWY/6J
         OYABzCyuH2MNx9CB5d/9KMKWthryU/RsNwFzzS1m1d72Q3pcRFA8jM6RXhh/cxj6mEJ8
         hPb0LnG/jlmEg7H2HzzzERVtZCxS91/5cXeVH0fIVNT5koaOAqK6mx6hVpY6nnTU2xby
         AAOoMQLIHUsV+CVWoAUDvf4LK3QBM6HRhlB9OwdEa7X00cVBRtKWpdnrBsRcTASjbPbR
         wTfKlD4xXUuaZyyvbB/MdLZa/NTYsSfXzzdzhswebJ2GO3f6/s/BBmfKw5bvP8z0QIkc
         gVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729624168; x=1730228968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3cleyCgLZFebwLrA8Z5Cn7hfeGHhF6AVUO0c6mbLoWI=;
        b=cxS3dwD5rpVbvbLfwFVVz7gga+wfk0J3mc3rjoYb60hQW4zujJeG/aUC7HER1QZz43
         3NsI5qTqbiIZV6j0u5r+Njwsn15v0puChG/gg/dfaZbSFgwY9/LInNmTUzeGRzYNuyGd
         WSENQy/m9DBKaZaoAYWnh/lliM32Yhhe9OEYUk579WSK97fUli6r1W38h1HmH2PXPdJp
         sYhIgNjEaDzNmu6haSMBOemA5iUywddYdQGQL4GrfkY6lZZckRKbn7qkEVCz1Edm3FYq
         edEMK7VX4l4xnUDg9zka4kw00OX9ptvP1pwZWFiIsNcU5PX6dZr1G8dRo8gY8ac3lDj3
         Q/Dg==
X-Gm-Message-State: AOJu0Yw0YF+H7JPudn2RJGz/FuWmlWP6P8ZlEoPAt8LhqOgly5jCXu5G
	kYfsiP8TZeuwvuStbbB8JxbeBTnrhtBJwgzjrtRRJ/sjOCkOxf49vV2o46xw
X-Google-Smtp-Source: AGHT+IFmGoQk0j/NE6omFNNE+uetm4WcNTUtV48WJA16RX7WTLHkmVXIZvaZ3HtoB00eRB4LI9ePdw==
X-Received: by 2002:a05:600c:55d5:b0:431:46fe:4cc1 with SMTP id 5b1f17b1804b1-431841440c2mr1877925e9.10.1729624168023;
        Tue, 22 Oct 2024 12:09:28 -0700 (PDT)
Received: from LOCLAP699.localdomain ([81.145.46.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f50b15csm96032055e9.0.2024.10.22.12.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 12:09:27 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 2/2] network: don't allow connection to OWE AKM if disabled
Date: Tue, 22 Oct 2024 12:09:19 -0700
Message-Id: <20241022190919.29005-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022190919.29005-1-prestwoj@gmail.com>
References: <20241022190919.29005-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/network.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/network.c b/src/network.c
index 20d9a3dd..5a856fb4 100644
--- a/src/network.c
+++ b/src/network.c
@@ -911,6 +911,9 @@ int network_can_connect_bss(struct network *network, const struct scan_bss *bss)
 		return ret;
 	}
 
+	if (IE_AKM_IS_OWE(rsn.akm_suites) && wiphy_owe_disabled(wiphy))
+		return -EPERM;
+
 	if (!config || !config->have_transition_disable) {
 		if (band == BAND_FREQ_6_GHZ)
 			goto mfp_no_tkip;
-- 
2.34.1

