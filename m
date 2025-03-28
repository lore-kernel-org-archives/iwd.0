Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238351C549E
	for <iwd@lists.linux.dev>; Fri, 28 Mar 2025 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743172992; cv=none; b=NEYsAbXe78krT8nm+cJ2Dq1aXL79t3JsrWKqyZzRTlP2sJlv8MvSkvfdKZeO9ItuDmxryWCwqvSfcSRwpviPF2ya0//7VBToJul3qI1syDBtOLvHoufo73hBl/w5xlE7L3mm6ee6bQnjWTjljhuZonITZr84sPtO2gtqNnTAGnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743172992; c=relaxed/simple;
	bh=7npuyMfgiTJxY3TQz0B2H2HkysBv+k2KCT74Y9lpbBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FswxclfcXIj9g6cetagRagsAFgAbtajTDwCjeUo0X1w4D8uvLcmwzaDDvOAlt5GyER6Ps3iLhd36BVLSEZn2fkcGDqKlje+wwmG0ezWB88C+WAijuN5+rLvAY7hIQtx5bhFKTpCuR561hslyusgsMObuepwPLMwfz+FoJTm572o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bri4n+yH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bri4n+yH"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224019ad9edso5983655ad.1
        for <iwd@lists.linux.dev>; Fri, 28 Mar 2025 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743172990; x=1743777790; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZckRzf3WmhHhSs7VbGOTJarbFXgkKiw0etSKJ3Dq+g=;
        b=Bri4n+yH4IHj3owd+bAk8wLUu1dJRYGhEVWU7hMDekF1U4LfW2iifK8G45RJP+LFQW
         6I8+XOAqNd8rv381BBEZSa7BD53Yh/6g0mMctGpvhkJ0gpc+OeRCDWozTXQS5S4R39Ck
         ys74qbxlApUpbvulQyedetRVHSV5chA2/fCHlVlU0uAHT1+9IINIzkgd4vtX65jrlBij
         z/Apx1VjMulqwDt2PnCxn0pkfFtoEyOTsLftTeIh2VOXraXLkmkUK82atLgw2Br3WtWQ
         y3m+0cHgSpoD2xsySvR1keA7EL+tNtlVV6OdpRmDvLadBZ293Ex/kpynBvcvxG63XIqg
         z9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743172990; x=1743777790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZckRzf3WmhHhSs7VbGOTJarbFXgkKiw0etSKJ3Dq+g=;
        b=JGRYl0jS+potX7AAVqIwqDTjAa+oaieOEdcO2e4FdNXE3sALDJ3zHBsn9EqWc1/sMp
         oO5FqaJnCO3Li26f8ap5tAdPMVUnKh00mbZJZRqWAhZEeOsKso9BodkzNx0tTH4YwuZx
         rzpGH00vo9FMpo4ffvH732cps26z11zWSOatAoUXDuxFMKymDl57cdydV2MK1kwfwfgM
         ey6Y2R8oOremavTpQeYiNteunJK1cI5fks7bl0m8Y4qwmbUxQ/IU9563guNEaGvdKZ0j
         Kx5nt872CQ9qLMN4Xj32WYT/rdw2ZpJEcekfy5Hymwbbct9uXZlf/QqXR2AnPOegc3r2
         m7rQ==
X-Gm-Message-State: AOJu0Yz1RlJGBuw0G3mWPkQJvqVTD2zKYfhJ0lzMl9w6t2ZHW/llMhXe
	C9+oDFFlqDKAf1XiYiQnji5u275Tve/RQA+0tssowxoJkyN8IMaH9IckEg==
X-Gm-Gg: ASbGnct1IWdqZ+4zLze3Jl6kADX8Ynfdz62ZOCLtGXPPD4pF034xCWSxy9DfWERMEbj
	QGPCW4F03GXRfNheNFZhG8arqBrEHQx96PxVPgRfRKwL1WYlxMrKPxp/6Qdzvk7Zgosnfw4eaDU
	/V6s+i9xcYEFggZQ4+HCrRbfYYdbVtZHFm46qyBtRU/KQhfGjeluhp0R6/bb07WWDcVYGnQ/91y
	J99gIWXr/sDLMdXUwmTsIEUhi8gxaOy+4T0L1+A4rHuA3qOuub/AOVfvRQCbPCYB3U96JfkKACf
	mgzSKEAVjHGHIl6cG0B2xdGPKfGapktFEStKUenK1n0I/6HWXCk/rJr07x9nVrk3BV7qrXFPVFx
	qvnV6pkgQ1w==
X-Google-Smtp-Source: AGHT+IFfNXkjtvvUreLLZTDA3xG0IFVq4j8dupkHidwcX0Lbbm9BWXvXZ7iZSm/ctMdaAWv3mYrd9g==
X-Received: by 2002:a17:903:1c1:b0:210:f706:dc4b with SMTP id d9443c01a7336-228048ab247mr99377385ad.13.1743172990025;
        Fri, 28 Mar 2025 07:43:10 -0700 (PDT)
Received: from LOCLAP699.locus-demo-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eee2288sm18885515ad.87.2025.03.28.07.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 07:43:09 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 06/11] netdev: add netdev_get_low_signal_threshold
Date: Fri, 28 Mar 2025 07:42:48 -0700
Message-Id: <20250328144253.421425-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250328144253.421425-1-prestwoj@gmail.com>
References: <20250328144253.421425-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/netdev.c | 8 ++++++++
 src/netdev.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 2a6d94fc..048681f5 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -463,6 +463,14 @@ uint8_t netdev_get_rssi_level_idx(struct netdev *netdev)
 	return netdev->cur_rssi_level_idx;
 }
 
+int netdev_get_low_signal_threshold(uint32_t frequency)
+{
+	if (frequency > 4000)
+		return LOW_SIGNAL_THRESHOLD_5GHZ;
+
+	return LOW_SIGNAL_THRESHOLD;
+}
+
 static void netdev_set_powered_result(int error, uint16_t type,
 					const void *data,
 					uint32_t len, void *user_data)
diff --git a/src/netdev.h b/src/netdev.h
index 6299934e..4ac1de40 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -158,6 +158,7 @@ const char *netdev_get_name(struct netdev *netdev);
 bool netdev_get_is_up(struct netdev *netdev);
 const char *netdev_get_path(struct netdev *netdev);
 uint8_t netdev_get_rssi_level_idx(struct netdev *netdev);
+int netdev_get_low_signal_threshold(uint32_t frequency);
 
 struct handshake_state *netdev_handshake_state_new(struct netdev *netdev);
 struct handshake_state *netdev_get_handshake(struct netdev *netdev);
-- 
2.34.1

