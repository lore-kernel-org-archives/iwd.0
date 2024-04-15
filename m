Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C147604F
	for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713193899; cv=none; b=CHfA4izswA9H8+OSC6N1jCOL6dQxHMf/ywm1ZB5ritprv2HuRQh1MXM3e7RUPIkWLlvnVhqwJXmwpjv7kgrTWbkVpCWlyfTq4/9oT4zqu2wBAkvMqGEiRdOMNmRBDD3RLe+b/hSsUAtq6eaIXTT/Jp64fsCAvl3VjgwpSm2oPv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713193899; c=relaxed/simple;
	bh=/6+gEvNcTE7SbxKKsTVvfWqKZSR8OlnWEFQeuvx1/oE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A4R0EiimEmPO+L7GImT8/zcoBNb2oOJE29AL9yoKr+wYBDsGFy53fUz/nQ1bup0GXWqTwCMiDdWRX9Tc0lu+5RjcqagJIQ/FG6AF//lhrS14cjV2/yQwgcCUcMjMg8zabUVPs9ydU6MJpQipoTDnMZCxcASWEKKBMdO0LRJFNwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKOoZr6p; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKOoZr6p"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78d543db3a4so252042285a.0
        for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 08:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713193897; x=1713798697; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nt9JLXtm+7jau8EIXdcris+h8YoBcqJmy42aFkfDLu4=;
        b=CKOoZr6pm8YRtxtcWO+AbiACEDFrxaaUZKEXAFBiNSV5pRENPx+kfwCRHRX7hc08YM
         mNy2l9GZs10PR5myo7LGTn1Cl2fzur+sdalr5GcNwpzpyf+9QOcCNIBpGGL9RIfGAavp
         d+UKKoT6hOCiNrUWNa8FbWzjJZkJciX9i7YCX8IzFd/OBP6/k/Y3NLFAqHFDbG/opq76
         NKTUcAUOSDr6tmxaUtblxj4INPr1N0cre/KCoAvzy7unbGxkDSOw4d4NXK660D6I1cOA
         MzkneQesiKAaTCXEWk5I1NMhA/tKhZs2kfEunfgIG/voaUHb7Xq+5zVe0mETWg0OQE20
         MNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713193897; x=1713798697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nt9JLXtm+7jau8EIXdcris+h8YoBcqJmy42aFkfDLu4=;
        b=oiNpYogTrTpNh8kbJIgX9+XU9C6rZeK1Sa8eV2E8vLzbbdWakNJkeTQB1E1nGjFSmO
         0Rw7hyMbzKOsooctpFcImmNpCuKhkSorKWSfnYmNMe7f4QF9nh4su4PJ542I8Tq13QVy
         VFKpiBIFSgBoiq3iJHDZJgbaM59nRMivQasK07PD98s7SR7qFdgB2PlUdk1oaiJy83Hp
         HdnfKrU0lT/JOiz1YZtF1Bugnvt43HSwDXc3Gg8N667qXG4DREWYcYO3XafR2apqxgjT
         IYaSntSNFCpW5huNWge1Stkez4OahQWbyGVcq5J/hvJ7qGUB9inDN63h/aOr/Yxppvix
         EPdQ==
X-Gm-Message-State: AOJu0YzeLimuRusRRpGGm7xOiUjTE/DeLVMXgk4oE2N7ILECEahHKWZv
	51iU51/7y9aXAMuIG+8/RlFZLySsLz6/IxWkgoLVz4nl2UD77Ol01DQ58g==
X-Google-Smtp-Source: AGHT+IF0su5F8S492qAKjJ/uYltxamnu9TEO2rnCZcRFxSaWl/ecG6HTXu/s2qjQUrvaYLm2Z5nMNA==
X-Received: by 2002:a37:db11:0:b0:78a:68c3:dceb with SMTP id e17-20020a37db11000000b0078a68c3dcebmr11356457qki.32.1713193897314;
        Mon, 15 Apr 2024 08:11:37 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id h23-20020a05620a13f700b0078ede2e9125sm2596549qkl.57.2024.04.15.08.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 08:11:36 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/3] wiphy: include MAC of BSS with invalid HE capabilities
Date: Mon, 15 Apr 2024 08:11:30 -0700
Message-Id: <20240415151130.40389-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415151130.40389-1-prestwoj@gmail.com>
References: <20240415151130.40389-1-prestwoj@gmail.com>
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

