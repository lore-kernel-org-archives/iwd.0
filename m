Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B961EEA3D
	for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 13:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416508; cv=none; b=qdh54h3ttOraBDLMjAyB1Bv3KuOuNKqWYO/MLj+ZIlGzikb7W6OOHOYpgxh+tGXrDW4cYzar/7zCKf5SRjSq2Y6qbgovvVgQa1nblSAThbhWm3/lSNQ3zVJMpQO7Go8iR69fzEOHvs1eDrHjLYsmCfIat+xUhbjYzb7aewawbzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416508; c=relaxed/simple;
	bh=gJfcBDq+25X0rK29/pOZ5IExDC/X3ELFPqM1yQXy+h4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WochY0T9SXtg/KsOGBxd410HPO94+959gY3Vk9WMIytYzPlxNeBDxEpx2WuqcTo4iO2MHxftmC+s2rPQ45TNMRVYDtuHY0Vh2JeF7y69v62WtLl+7I7nRcan8lhHSy39cjY61jzGwZW/AWwj47fmOtT9t4B32mx03PMES2GU95s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVsk1fBc; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVsk1fBc"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e8efefec89so59729666d6.3
        for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 06:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745416505; x=1746021305; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wC/7q9RbWeiunxOSTr0Qq3aODpW3fgDqRJjXbvNBcM=;
        b=BVsk1fBcDNNVGowL/gmjSC9zLBt43PdkIjyjMIe/MSMTvlwscwvZryGRDStkaB5jS9
         y5UEVOVhBhDYtvpWGwVI5Fxp2idFugtr6X37C/3CYwHRdn9O4KokS4x46M8L0Ef7BziN
         kMCUXPl0YKHpmhPKmwdUOn4itHd+wj2altByhBamFTUwFMp3I0ya0scy7k2mbflUaXTc
         yTcX2SNprbLkoEswxHv7FZAwr9WHf73LYOF2seJNAwH4heGqjYVVQLW11pa57qBYETai
         j4QGRsACAXyZnqwBDkFqUKOLq+YzoJ6xtFnYRCghiiQ04Gi8kv9H7GIBQhNv5ApIilAn
         yANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745416505; x=1746021305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wC/7q9RbWeiunxOSTr0Qq3aODpW3fgDqRJjXbvNBcM=;
        b=H/p6CTeTGBwAzHu/6dyI+KTWfHkZ/OvT2Z5gC0IlRrpF7hoM+SSFvsbJnp3GlX3yV6
         9kMx5Ph0gWa/Sd+/46Z8QQITVukvfhu0zBex/FdenfJ6lThbLPkJsvFahgUwbPRSdoKt
         hNgGCgyrJhUnklHBgkXqloT+JRY7S1+JpgoJoIIF7whC7nAkvBgsGKurGCsRFH7faUTw
         n6Wf3ruHwI1RgdVRGDzeT6fFqscIqutGcpmFUj1aM6zOa+gBGwb1c5lOee9wmkY6TDZ4
         1BlR1dIUV2V1a0aprFnQ2eKOwY5YtIDjGGk4hsackMEAmYd7lTq+L5zoGy7oztZpPi2C
         QSqQ==
X-Gm-Message-State: AOJu0Yzc0PYZPppTa13Gq0lNaR5uhX3xyIDc8WG/hvjD2GB7iSoOJAv/
	JjyMwy1InImW7x3RWJBBO3Tm6DcyqkHfm8mBuBAXNHLBofN0tbxyiixxVg==
X-Gm-Gg: ASbGnctdDYXR6T0EcGe00g0Kw9M3KExZWyw3Enc7sZj8BBzjY7zp88pceYxahcB2VOI
	eDeex1R2TkP+mdM4S9ShXkPk9eetMsdo+ixXz50y+jD8dQBLE1hONTaG9vC2ktqwmEyFZ6eT9oM
	3MOpsx3STN+DjrPf7ta1tsKP0ZkZgCuOA2dAiv+nCn5XBQSq2SPBFO43/bbwVlcoXvyPdSHUePO
	qp5R6al8OchXkVcx3bYE43VVdc4Gp+j2ZYRqYpucIvSQZFgLXDqhD1uLc7tFVKszT2BIUELhGFj
	ZpaYLei1gAy3i8SPCiTTtZjIbf45PBS7RgU+N5A=
X-Google-Smtp-Source: AGHT+IGiFBHiBrqyjF37z3+dxB6UHjBXwpLGU/wzG7mJ7UubCtRTzI1vg9fIuUopPowjaRGI1QVdyg==
X-Received: by 2002:a05:6214:415:b0:6d4:1425:6d2d with SMTP id 6a1803df08f44-6f2c46a5e3emr304940516d6.43.1745416505292;
        Wed, 23 Apr 2025 06:55:05 -0700 (PDT)
Received: from LOCLAP699.. ([50.170.153.203])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2b32741sm70733576d6.62.2025.04.23.06.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 06:55:04 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/5] doc: add new properties to BSS interface
Date: Wed, 23 Apr 2025 09:54:58 -0400
Message-Id: <20250423135458.11337-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423135458.11337-1-prestwoj@gmail.com>
References: <20250423135458.11337-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds SignalStrength and Frequency properties
---
 doc/basic-service-set.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/basic-service-set.txt b/doc/basic-service-set.txt
index f827ca02..32dc0d6f 100644
--- a/doc/basic-service-set.txt
+++ b/doc/basic-service-set.txt
@@ -8,3 +8,11 @@ Object path	/net/connman/iwd/{phy0,phy1,...}/{1,2,...}/Xxx
 Properties	string Address [readonly]
 
 			MAC address of BSS
+
+		int16 SignalStrength [readonly]
+
+			RSSI of BSS in dB
+
+		uint32 Frequency [readonly]
+
+			Frequency of BSS (MHz)
-- 
2.34.1

