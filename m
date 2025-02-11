Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3162690EF
	for <iwd@lists.linux.dev>; Tue, 11 Feb 2025 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302028; cv=none; b=UdTAIr48BgFzlKFwTGM9Zug5pO9XupZ5glpgvymXJnD5tWj4alXODFchvLs0akrtXhWPyW6/0UlI7eNdvF7h8LZ83IrWI/Sm/QQGaZ027ylcWT5DwAZXUbVFoKrzHZjL6u0B3WvXN2VXLl0XvnydcIdveh789FBx40xiRc5G/Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302028; c=relaxed/simple;
	bh=9pClswXSsZ5AX374x0YoBAYYuHQMKaDsMRLo7gQS9nA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sYu+4k+DOHQkNIXdkn/bhZbYEfXR+uH/qqB7PXn/krO6y4oStncYcw05D3aFCua2/O+IzvHmzekMZsmrHyMNTAYmjqq5AxR9H1nb42CzcEoOZxIYJqA9ldOguMU20W0Uks9L3EYT9b9PW0WVo5fQarIITH0Zlis/7mRngLA34Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrB4sgTi; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrB4sgTi"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46c8474d8f6so49129351cf.3
        for <iwd@lists.linux.dev>; Tue, 11 Feb 2025 11:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739302025; x=1739906825; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NP/a1qZML3T2OhAr0dqWzGNQ551Bn9BoWtVMdFbccTc=;
        b=SrB4sgTiWDt7u+FHab8/TvYXCGOBAfbMaio+3vcI3zwUYawYZsG2C27cnIRK7k7mKs
         wwxCUkw43QMwKl51jmOlPv0EzJGFX0vgX+mLp1nmpi0RDY8ohhnUGSeFEwFBSrZ1uz+n
         jSzVyURTlZKQWwZDAw/LlMEkM+qYpXsrWED4URsVPCuDyTRqwucxCzJHgjP6nLixEgnm
         3tfmVMNsE36XYKDr5yuRkro9EpJST+94yazS/lXwkIn0b1p8WJEHviKX2KJbYKpq7oOD
         PaEvCPsbNPpM3VXdPK1+GxrjMXwB0r87g6ftB9kaBA8EGAcUsNLVG3yPKAZ2WkjM+kMj
         JJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739302025; x=1739906825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NP/a1qZML3T2OhAr0dqWzGNQ551Bn9BoWtVMdFbccTc=;
        b=pzDNolTA5b10Df8zjsmGoha5rYoBePUBg+79uWcglI3Qd7SSAqQhkVnJtffBMvB2O3
         9LmLnVQVA5nrH+xX4gvS2UZIjxV6nkWz7o+oQEYLqJmB9qr6WDAC6dsivR7ItHDfCZUN
         v/1ltKzNTXNctjYdwQMjA8AOZQCl6W3UeKWH/IR6GbsFaYyjhB0908LK5ikN+xzX9lNk
         A70KMyYL9VHEpLgviI+h5F3uHeH4SVgeWpCqruynPNhzQny5RhkCxYnwWoqKLvQWKwl+
         cx/Xkl0ENZNHNsxIO5MLCeYfDCQ4qaULMI8MSJKiluYibvzQXe7WoE7OHbMK/V/HEfAJ
         dAcA==
X-Gm-Message-State: AOJu0YyLZWqajDoj1TWrp3+eNquNR0VEzynXacIJm8HTIlrGf4TiQOMp
	kg5asDsmAhVFAqNeGZf9VIyjCRJUuByfw2T/VXZAAmQAZPdn/oWmrKhMgg==
X-Gm-Gg: ASbGncvG3SGUXDSIykNF85y4EI8xzkg09zp/m/Wcd3N6axbBc482hEwK6DbDo15Bhls
	XX8XaTuMelQK2w9D9Rs4E8HVHmSZ+7SqWoYLYCQ+lJXrN0ACzyTcYDa/rHz/5IG0maGJ+vJ/85L
	2YOPlm2YspFx5o+ZO1kWqNWJnyFvedNawn4CXHWumiyTIro2iY3F8dco60/k5op7w3odN9f4nlQ
	D0zSzrlCPjNM/5Vn0mbc09DsoKicaZgGOPGY+D8c//aKpAVVS8917u+p8f7CiISkUIe72GwIkVp
	kpixRo38Ju7QG9rDII1FlggQleR//gXPyFz+m9bwPnd1bbitiw==
X-Google-Smtp-Source: AGHT+IHH8WSVns09t62ZGmp4rkGMaD4lgrzumqE1SmhWfpiPYr6D8cWmKGfm2OS/4TqQtKNk7nLtzw==
X-Received: by 2002:a05:622a:181b:b0:471:8a7e:906b with SMTP id d75a77b69052e-471b061af98mr550391cf.17.1739302024776;
        Tue, 11 Feb 2025 11:27:04 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4719dab7aadsm18681601cf.51.2025.02.11.11.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:27:04 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] wiphy: clean up some spammy prints
Date: Tue, 11 Feb 2025 11:26:55 -0800
Message-Id: <20250211192656.83157-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211192656.83157-1-prestwoj@gmail.com>
References: <20250211192656.83157-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First, wiphy_select_akm is called multiple times for any connection
so we shouldn't be printing in here as its redundant.

Second, the external auth print was in a similar situation but this
would even print when scanning, which really clouds the logs.
---
 src/wiphy.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/src/wiphy.c b/src/wiphy.c
index 3d761251..c7df648a 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -245,10 +245,6 @@ static bool wiphy_can_connect_sae(struct wiphy *wiphy)
 			return true;
 
 		/* Case 3 */
-		iwd_notice(IWD_NOTICE_CONNECT_INFO,
-			"FullMAC driver: %s using SAE.  Expect EXTERNAL_AUTH",
-			wiphy->driver_str);
-
 		return true;
 	}
 
@@ -312,8 +308,6 @@ enum ie_rsn_akm_suite wiphy_select_akm(struct wiphy *wiphy,
 		 * met, we can fallback to WPA2 (if the AKM is present).
 		 */
 		if (ie_rsne_is_wpa3_personal(info)) {
-			l_debug("Network is WPA3-Personal...");
-
 			if (!wiphy_can_connect_sae(wiphy)) {
 				l_debug("Can't use SAE, trying WPA2");
 				goto wpa2_personal;
-- 
2.34.1

