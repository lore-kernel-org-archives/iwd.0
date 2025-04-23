Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211C41E7C12
	for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416505; cv=none; b=iQWZf1IuRTW9udIiWojOMNv6VyT+kLomLPwSZNXDAfkFx6L4bQuap/tu7QafkiLVNE6UJenC2c/Qn1hxs+sBd0bIDZtaX39CmHTGRO+G2qQ5Lc0H0idq6PW1x5GGspqh5jX4C02U6bnibjZj84QqEzm83/clcm8YnseiRJ6sRuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416505; c=relaxed/simple;
	bh=ZK8k4UrWQC68pGBts96R0uSl8kFmdvEQak9tGPPepB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TzeXO3mfILmi8rC9T2VV2EfyGAldqPsq0o6wDHmuNEDLUcjrt6Je/efFHAGvxED1X1GS3UQoZjgfdPt2+M3SUEwplqxlW3qyUfWot7rIAfMmFFYzGEGXsxh+F2iUxabd2VeAN9li58yni+W3rHSb5fF0tkDYvIJMsWWZcubmNb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrNbvla0; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrNbvla0"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6f0c30a1ca3so72752066d6.1
        for <iwd@lists.linux.dev>; Wed, 23 Apr 2025 06:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745416502; x=1746021302; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzMpybOVuIGot5rqOzjq0Ow7enANgYBPFN3gwRAJZGs=;
        b=jrNbvla0Rm3RabJchZVXlzi5aPKZ0I1bU/9YvkgnXTzNgMG4j0w2Vx2sT7iHob8ibh
         pMQh/ISotyMn9nJZszvdIyiKK1KaJ1I6fgCQP5xb1MaxfBJCwmhFN/wg9XbsE7uiM0gY
         g5auqtHCn3t/e6Ud19wKjK47FGv5hYrza6vUAHuiwMyjwbigST8utshEeKTZZxNaIIhP
         eXjMLsyi8h1jKl3mLiJ6HrpIvMqI3YJBcILjn77DDL6IX+Q4wHY1x7NnOcbwRrKhlsQ/
         wft1YeXMcbvJgdHM8t9O6aupwKSd7J+7opTAs85lnzML9jQwgUnUanCVeqbzu92Sretr
         t/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745416502; x=1746021302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzMpybOVuIGot5rqOzjq0Ow7enANgYBPFN3gwRAJZGs=;
        b=JGQ53D49kN7ZZJfce8Z9ME56g7M1vS070sly2H/oDTTMfDb4dBj8uXQMwN0azpqKT0
         Sz57hCsyy+voeHowif2wwDDBpGUcXNIT6xLffoMXNBOc1Potmne4OjqfNtl8I/ChxHOf
         v8AxvG/29JWrtcpJRyDot8HCgyxDjyGXJnuBQDUEazmwBGcymoAZFZDnNlIFgNu/w4Z2
         6sC9dbMS0blLPKF+RwbfT0tm0Jmi89oPGUdPl1BJ9KfuWXOJZTjqyhr65+rJGd+TXDAW
         wYpwHEI1RFa2TqOwqPAbPZLy7L7zYvigH3jN66F/JJAmU/hStWELEd044H0txUCy71Gg
         l20A==
X-Gm-Message-State: AOJu0YzTUrmctS99w3nyjaGYmsPY2UUUQD/8J9nGaRliojkG5K+pUCHu
	ADZLU2GxdtoRdT520Lq5sNexNxNz1y6h45B2fAqEt3L9T5S5axVGa691Dw==
X-Gm-Gg: ASbGnctm/Ns8mLg8Y2o6pPubZ7ngPatGhR0udAljyBEyNwMzQ73vWMulDMMIK0iIFh9
	6NbNXqwli942VTh9cmBoMsJg2lG7huSbCNW4SJNyefUTBq9dpWxDftGfOw8FMl8wR9bZuxCY8iI
	WvsoxXjno1NZ+w5Jlf/39K3W89Tu/Gv6gTrKoPkgU+lM/yh6njxZb+MQHY9pwskHUPKxW41Nnuc
	l+luKhuF3/KCmaCIlLAk6pTvpUakyiGUOa47ccChwwNA/+CyrdU43CQSh5E4zPHvPlHWZ6yZ6eQ
	F6Q8Ll5C1+eKz2D5WeKaGv7AUn9yCFQ/ZHcMal4=
X-Google-Smtp-Source: AGHT+IELml86WXMvlS0lXU5jrswp9L++YpthltC8wL/7cQD5QRwYuHMtY0AnwJrkQRQbkj39pya6zg==
X-Received: by 2002:ad4:5bac:0:b0:6e8:feae:929c with SMTP id 6a1803df08f44-6f2c4570259mr331553906d6.21.1745416502623;
        Wed, 23 Apr 2025 06:55:02 -0700 (PDT)
Received: from LOCLAP699.. ([50.170.153.203])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2b32741sm70733576d6.62.2025.04.23.06.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 06:55:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/5] station: update SignalStrength/Frequency for BSS interface
Date: Wed, 23 Apr 2025 09:54:55 -0400
Message-Id: <20250423135458.11337-2-prestwoj@gmail.com>
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

When the BSS's signal or frequency changes, update those properties
---
 src/station.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index 14c93671..85ed2898 100644
--- a/src/station.c
+++ b/src/station.c
@@ -545,10 +545,21 @@ static bool station_register_bss(struct network *network, struct scan_bss *bss)
 	 * scan_bss pointer, as this one will be freed soon.
 	 */
 	old = l_dbus_object_get_data(dbus_get_bus(), path, IWD_BSS_INTERFACE);
-	if (old)
-		return l_dbus_object_set_data(dbus_get_bus(), path,
+	if (old) {
+		l_dbus_object_set_data(dbus_get_bus(), path,
 						IWD_BSS_INTERFACE, bss);
 
+		if (old->signal_strength != bss->signal_strength)
+			l_dbus_property_changed(dbus_get_bus(), path,
+					IWD_BSS_INTERFACE, "SignalStrength");
+
+		if (old->frequency != bss->frequency)
+			l_dbus_property_changed(dbus_get_bus(), path,
+					IWD_BSS_INTERFACE, "Frequency");
+
+		return true;
+	}
+
 	if (!l_dbus_object_add_interface(dbus_get_bus(), path,
 						IWD_BSS_INTERFACE, bss))
 		return false;
-- 
2.34.1

