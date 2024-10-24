Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3383349652
	for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788407; cv=none; b=aNHoCrRWGeKSOlpZWARy35HlwrQ7U483eFnIW2uKQU4RfzxOJ9a87+P2jc2fCi1UWvip3iTcIQZRD1QGekS+BiiQWFTDwLNtEZZa1J4CqyPfoh+GjBboW0WmMyKX8IFo6y8iuCfjF9f/r80/xUm80d5EFShfHRS09xDwwH0efj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788407; c=relaxed/simple;
	bh=MR7mFNfjMKeyVOe3kundCb8YPrXlEKOF+otl2P+VVIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jhLNqnEIbxvYiIxB8XF2E0Ji6c3cJNQ+8kg7OPQ8f4MBpnD3uADvZeowmx9a5P1lIny3YpbFswsfiO9QCnqGD+NmNxvXLaL9xmF+eXnfeub7qRJsyrvhkOWYI4Hi1aRacz5xQ8c+rkT/x2N/BSX7pZhQuDE8+6b/SDKn9pIehqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhERKaKf; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhERKaKf"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460ad98b043so9657561cf.1
        for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 09:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729788404; x=1730393204; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sjWOfCdThaJarO+6nOahot5dWDiRv1jYtrAVn4BJZLs=;
        b=WhERKaKfxqzcZKSshUrRlNxxMeCKDIM50DY3XEw3C31Q5sGJAo/ZphHQ8dGRxW0Tcc
         pI/hG27FiBUOvHZe3USUYc9+gv6aatn2q5/ytlktO++3mXs6S9cBBPUWDTdYbJqwC4PM
         R+7hLTNDp8l62FUwS4drnSzJd4Nm9+iF/TcymYhc5Gnwus6O25Oex3lTFO1CirldmrGP
         yPrhCha4eLexNrj1SN41kMq8iQokgvXM8gZj5jCPLpc0Du6fA9ZvGIiyEwTYdh/C9mPn
         n8XrEIrHiRhb+N/bMm884OHa98ruvgaGkGfWueooC5yvHbfSGGMfxq3KNtV2h8aVEyhZ
         8NRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788404; x=1730393204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sjWOfCdThaJarO+6nOahot5dWDiRv1jYtrAVn4BJZLs=;
        b=UKXQ8xHIzckpCrxrv02/jZzmgjanmeyqItQeD54VNoPH5s/RhkmhjFMV2NivHYLaRX
         angKNAwE8AsYWvGqaRUknZao8bHhhH/BJj4e1w016KTezucB/yx18Wv1DGrTJWlm8AWb
         iBaXN6Bmma+BbVK0GFhUqDLaTVVRzK9/acMOWr6FRj0EZTluCl2K5GVCTlzwg2gUaJAE
         ZlK3TCXbQbtlVt5W4XL+nTp6QMfopcuLpnnqU8DmLYSaw0NKSbifuSjo9+Zv3F7t1a9t
         wOuWVPd1NKjTOaGwsHPLiBWqj/nTMMqaPBjFaArWMw2Q34KsIHlCI6G2+7f45foxaJXz
         tm/Q==
X-Gm-Message-State: AOJu0Yyt0slkKffudrKKR410jP9Mo329Shz2Yj3d1KlLWTc6CAQLyWic
	3w/BKbvl2/Gap0ISHjXGVnH07djwn170AW6THYczfMKO/21rBKlOnHyPJA==
X-Google-Smtp-Source: AGHT+IEN0DVFiE6vXwJ5xtH6pDwBSgyUrzB2vyycVU9W8pZ0bPXgTJfrQvMfcGyupplaruISMIYrCg==
X-Received: by 2002:a05:622a:19a5:b0:460:3764:2844 with SMTP id d75a77b69052e-4612526d419mr44636131cf.10.1729788403804;
        Thu, 24 Oct 2024 09:46:43 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4611a19be2csm16893901cf.70.2024.10.24.09.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 09:46:43 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/5] util: warn on invalid channels when iterating a frequency set
Date: Thu, 24 Oct 2024 09:46:35 -0700
Message-Id: <20241024164635.176631-5-prestwoj@gmail.com>
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

This should not happen but if it does we should alert the user.
---
 src/util.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/util.c b/src/util.c
index 5ce764ae..8c690fc0 100644
--- a/src/util.c
+++ b/src/util.c
@@ -464,6 +464,11 @@ static void scan_channels_foreach(uint32_t channel, void *user_data)
 	uint32_t freq;
 
 	freq = band_channel_to_freq(channel, channels_data->band);
+	if (!freq) {
+		l_warn("invalid channel %u for band %u", channel,
+			channels_data->band);
+		return;
+	}
 
 	channels_data->func(freq, channels_data->user_data);
 }
-- 
2.34.1

