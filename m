Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2B928853E
	for <iwd@lists.linux.dev>; Wed, 28 May 2025 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748442480; cv=none; b=p7eLB5TrzWPAE890axEY736R/3HuptGGyvS64rWOZBMrFmsEnuTx4xg7RdBG8UzQDTOpXrLGQ6cYpFdXRGkQPPqwVN3BV45Wr78JnW10MUMQJFzolNuCjJKQB5DVX8sgqTuLItn14GUN8gR+hs4bXYosTkI5d6/b/TxY5MSNcJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748442480; c=relaxed/simple;
	bh=dZCvA/a/03VY/kq3gu/YvXXCePhS9Fh0fCDmCfQk5dg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ilhkf9YzJY6HKW/hPcYzrcb9zlfNxOwMW7Or4yqku0205A1Q3wH842mXoiZnHPMkWMXySKrTAT6X2q6IjRVQu/G0Eoe3BUvjNhxWjy/hPeSgCKWoKP1zxZmQ21FMrpWoVh9RZXRjMcIhmRoZQ2VFmuAGhUpdJxCyr+p2pwDrLOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyUtYb+C; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyUtYb+C"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fab5dfdfc8so16822556d6.0
        for <iwd@lists.linux.dev>; Wed, 28 May 2025 07:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748442477; x=1749047277; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylI4BCyghuNBCan9O+SAOrBDWcVrDMZll5egBnK/PV0=;
        b=LyUtYb+CNCVGw/1Z/qvcfmMBOBp408VZLA+r4FTsmLZWDyb7fQZGc+H6hPUCkleXUo
         qhHlURk9BhcKtbY3ILWj447fxKJb7LDgCXQaqLQfh+tCsZelDmoW38qzqXFO+cnhhiBW
         52rfSFWSMhz3b+D8OmxTDHoW7w2S/rD7MvF43rnYyfjPC0iXiDRedfsmMZF676DIXBhd
         nnq1oml60UR6gQcMQDnY4mziNgtWRmewoRF9sDg+8qWu/sFsLbxlhjz5lwFRrNfBVrH/
         q1YOKK0B8LLZzEnqOCufX43lEjlQIKt+uJB27mIKGuC4ZsIa4/OiYuvAW0uH24UmgD9A
         ZZzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748442477; x=1749047277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylI4BCyghuNBCan9O+SAOrBDWcVrDMZll5egBnK/PV0=;
        b=KLYu8Zl1gjzSyb8tzv1NlR+JBhg2r39aGPLPCVa+LHHPyyXk4l4f9M7zDeJzXESzJb
         YGmlXcQKPjCxl6fv9NbvPQP0mQXSCbEYOAZ/JLJtbVW75WI0g/4ubQuSFXVT+Kh7B/yE
         nNAQsxVnmsuxAZDDRmg8q3/8LxTKyKFnbtqZM6pTBgOmq0wog0WhLwbArami3SsIg8+d
         9YIPcPyUOodS3tmIYGdzKsTId+8hNaM5ysRvsC3Nv1brgZucg0fARTqftAdy+dkpodPW
         pTnB3xoN3l8Ww1CJCr4BCdlAaaVh3x+Kx8xVkrm8pF2hD+bHOj2HbypOSFtLeBCQ0vZp
         j4xg==
X-Gm-Message-State: AOJu0YypFqNElldyfdDZgI7GKztIg/cwMmQzOnf+ZR22/8XlcaUox0Ci
	dt+WRezeVrZPSxY/AL5rEGvZoBA6EdnuJ3KQ0KlWk9hnwFk9u4/hq8Xs95Pigw==
X-Gm-Gg: ASbGncuoi4dZLiBEgLA0EfEBcxISJQizqChEa1UmJ6pCjp99Y9F0X6F3RXUlhLBoLVz
	kt5DjTT8qgk+7JQce8gPtlMRTM5UnhVALr036VEfJAhXQAT+lwV1sS8Y2IGoU+iAnK7wfNnByps
	6VO7Mb/9TJfwQh9qMAFQHeKUQN2VMTGH0qnLUZnDN/bGm28MQNByxtYxzfVFjmBzgOtnI86OYaz
	LpiU1nVkF/htsUX3akB0TiGEuLEF1GjTNW6sBavIdGdMPStPJ8AuA3uZtWPkEUSt48S/c1195eh
	Fz9S2QPJ8Z6zCR+HkXfXXlRjNpi0Hud/LCVAozkbFQbvnHtMLVbPYxtzjrq84A==
X-Google-Smtp-Source: AGHT+IFXUDK/Fg/5xyubBjGAGg5/P6d9sWWJom/CCoNAhLzkuVBm3OscV+Z/BrrzWPHp8TV1Q676/w==
X-Received: by 2002:a05:6214:a0f:b0:6fa:c4f4:e2f1 with SMTP id 6a1803df08f44-6fac4f4e319mr4656626d6.12.1748442477419;
        Wed, 28 May 2025 07:27:57 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac0b2244fsm6960526d6.17.2025.05.28.07.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 07:27:56 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] doc: add note about timeouts to Network.Connect()
Date: Wed, 28 May 2025 07:27:50 -0700
Message-Id: <20250528142750.498252-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528142750.498252-1-prestwoj@gmail.com>
References: <20250528142750.498252-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since netconfig is now part of the Connect() call from a DBus
perspective add a note indicating that this method has the potential
to take a very long time if there are issues with DHCP.
---
 doc/network-api.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/network-api.txt b/doc/network-api.txt
index 8bc6eea6..d96fcede 100644
--- a/doc/network-api.txt
+++ b/doc/network-api.txt
@@ -11,6 +11,12 @@ Methods		void Connect()
 			the object path to connect to specified network.
 			Connecting to WEP networks is not supported.
 
+			Note: When [General].EnableNetworkConfiguration is set
+			to true a call to Connect() has the potential to take
+			a significant amount of time. Specifically if DHCP is
+			either slow, or is unable to complete. The timeout for
+			DHCP is roughly 30 seconds per BSS.
+
 			Possible errors: net.connman.iwd.Aborted
 					 net.connman.iwd.Busy
 					 net.connman.iwd.Failed
-- 
2.34.1

