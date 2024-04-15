Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE37922094
	for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193897; cv=none; b=dUakAdpL4M6XxJn9cARtlSEJEqCvBYa44j3HagW0wjCi9kScufdqZ7R7q+eKqsVR8d27sNLTrYCTA/QhbYDJxOpDKoJJ5ijriOZWOkAYojsjuWZdfwbOWxZmlJSvcG3pbtSSs7SDvRWWiHEPc4JmSBEymMsbMNBlTWuh0hP2ofk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193897; c=relaxed/simple;
	bh=FXvvhYhgglFTGA/MTtoW8EKoVYfIQsLOWcOuVXhQusE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A5AwM32hBMI0gcRsHPwymtkHleLLfdfQ2SbNZz1Ir7EaOztmg1Nw0EH22LR83Y8b4/f1S71stFHMhZfc5iO17cv16/I2frnjhDyxrSgVL2GxJ8+YtI6IWQ7NpqWdO4zcHS76C22Cn+Thl4a+4QEvfw2LB8eiIeXNre/r4HMPKtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jf8SHFo/; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jf8SHFo/"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78d743f3654so320314685a.0
        for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 08:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713193894; x=1713798694; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qg/HtKrlYTuKM8FzDskV4+DY6wEwleiSsG5Gy/6Ktew=;
        b=Jf8SHFo/8DW/9CE8h4g495WtM3im97BYX3gtMnckDoMZMP9ibWPSkiiD47sAH0ayjM
         TQCc9JorFpelHxBtM1z+WLFHRLqtGp4Gu69eUEAm2BwpeM3cMvafTOA2FDLfx9a/4vzV
         1snpRmUgzJZ8BJayRdFS2KSbpdm7ea+kBxxp3lIYGQGwJ0AFhYttKdsvqLoI5n2Z3106
         Ei4UtMGoLV2jgXkQojVWVjycm9OXEpY+jB3+E90haNz1cJJjZ7Cuxge1QSUyt9CFi3rX
         6t43tjqinMrRRO5pgHoXqrV5onAKRaOJdOQqzqUiiJfSie4d5G/fa/BTRlv7E1kG6KHT
         XZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713193894; x=1713798694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qg/HtKrlYTuKM8FzDskV4+DY6wEwleiSsG5Gy/6Ktew=;
        b=o1Ew9egDSqYec8ydd6jx9dvfFs+J94ZNnYBb2y3t2VhAk4ReB6xJxfD/ZSpNqT7xBt
         YRb93Ki2/BHhsFrf7F4XOCl95ncdTvOmnmQXTi9/86GQ+4ebPbhc8cQ7jy/nNe/vKtcu
         FskXE0SGdNqnCeBT5Kl+h+2kmH9kINpgYJN5vNhotmTb54ZttkvXIykjkqY9G7e/p7Z6
         y5EbLaYX3BIKyo1JbzXA0QSMBD/ljNX6SM+tbtIYfhE3JFjXLzDKUtNFrz/9nucj1Zod
         gDtvlPoxlrwSEiz0mv7xV0f8SW25/zDvra8Ga/cA9hKmtfrvqKsryFEjT5OSUkzVVhIc
         FbMA==
X-Gm-Message-State: AOJu0YwGZwdBVWsE89NkbKzE04o58QcqOd525GrKoxrcKGGHsnO0ojcN
	j11jc2ii0xKUm7Wcd+GI3t0tnji4LcQqPSV7BH8t/ZPAOgAYaJL8Ft2h6w==
X-Google-Smtp-Source: AGHT+IGwtz+8s7P+f6uWoBm1+mu5ZtblTSTqXnbI53TdzwtBYiEZtPjLsuWnVdg/xPIC3dIhAYaC+g==
X-Received: by 2002:a05:620a:8323:b0:78e:d537:2407 with SMTP id pa35-20020a05620a832300b0078ed5372407mr7184732qkn.7.1713193894385;
        Mon, 15 Apr 2024 08:11:34 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id h23-20020a05620a13f700b0078ede2e9125sm2596549qkl.57.2024.04.15.08.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 08:11:34 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] band: return -ENOTSUP when RSSI is too low for rate estimation
Date: Mon, 15 Apr 2024 08:11:28 -0700
Message-Id: <20240415151130.40389-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was overlooked in a prior patch and causes the rate estimation
to return -ENETUNREACH if the RSSI is too low to support the
various capabilities. This return was unhandled and was treated as
if the IE was invalid which then printed a warning.

The low RSSI case should just be ignored, similar to if the IE was
not provided at all. In this case return -ENOTSUP so the caller
moves on to the next capability set.

Note: this does result in most of the estimation functions only
      returning 0 or -ENOTSUP as they do little to no validation
      on the frame, but rather just test bits. Additional
      validation could be added in the future which would be
      handled by this patch.
---
 src/band.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/band.c b/src/band.c
index 11cd965e..d71380ae 100644
--- a/src/band.c
+++ b/src/band.c
@@ -121,7 +121,7 @@ int band_estimate_nonht_rate(const struct band *band,
 	}
 
 	if (!max_rate)
-		return -ENETUNREACH;
+		return -ENOTSUP;
 
 	*out_data_rate = max_rate * 500000;
 	return 0;
@@ -319,7 +319,7 @@ int band_estimate_ht_rx_rate(const struct band *band,
 				rssi, sgi, out_data_rate))
 		return 0;
 
-	return -ENETUNREACH;
+	return -ENOTSUP;
 }
 
 static bool find_best_mcs_vht(uint8_t max_index, enum ofdm_channel_width width,
@@ -502,7 +502,7 @@ try_vht80:
 				rssi, nss, sgi, out_data_rate))
 		return 0;
 
-	return -ENETUNREACH;
+	return -ENOTSUP;
 }
 
 /*
@@ -678,7 +678,7 @@ int band_estimate_he_rx_rate(const struct band *band, const uint8_t *hec,
 	}
 
 	if (!rate)
-		return -EBADMSG;
+		return -ENOTSUP;
 
 	*out_data_rate = rate;
 
-- 
2.34.1

