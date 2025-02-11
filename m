Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F472690E5
	for <iwd@lists.linux.dev>; Tue, 11 Feb 2025 19:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739302028; cv=none; b=JtWQEPx8pwLTqLcnpAUS0PqK7nOkgJciFbMch0bUZ3YXwj/d6OIC4+/pp6gU21nbUUVuGET4KQOXb21/192KyQcLSk+HFq1BcEsGDZVZZ00P577Z+1tDfXtBdbG8LnPZreMW2VyOJWxLKCL76Ct3iNvIbHhiYl3q8adJB2dpWGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739302028; c=relaxed/simple;
	bh=4cFaCZGk/mNUOHMz+1CjVC5YD8greqN2nSXGRn3l2Vc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sV1/ZTbGGy7dO+iwXGy6vG6IjVEsgONIpOFpd0SkV/C+O0m0jxjfpD933N1PjiPrNgAOTwgflhKp47dWD5TTRf5woA5WZfofg/cCdiDN/NsgAmNJ7pzPc0DKMnrfLbH/XZorH0NQhRqcBxrrXHE8JhUKZ5aEfRoSGax/XRCvcGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpR8u1Xh; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpR8u1Xh"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47191bcb2afso19324791cf.2
        for <iwd@lists.linux.dev>; Tue, 11 Feb 2025 11:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739302026; x=1739906826; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPcsjCWv5c/c8BcJz5XeSG7LjKcJh+rzqMCdB5oDJ60=;
        b=IpR8u1XhnxeY11nR8UIWKZH1cqkg4V/o4QRmj2bIH63D+NXhJ/sd8KzK6tgj5n+rRH
         tZQ5OovztidE3vWNRBCjcKDCTW1WUfYCPa+AMhzTOBcmwnU3SdKGpk6VdO/VBe47Wyb+
         lEyuc72IkxjTck9QB1l9Pk9GbMCpe6RFlvzCVvlZGV79gjFdtsry8BUPhcrTPBNXDBXo
         y7QOa9qDi5+7wkTXDqErYvvP3eMkLdeGFsV+X45U3hPDdopp9y+VA56Lykf4FRYL1YAU
         EMFpIaOvL362tXb1oZIp3lB4j65kV+3LCxDHKtnBprI0vgMcgXRnu+/zf++nPqoQRN52
         JGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739302026; x=1739906826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPcsjCWv5c/c8BcJz5XeSG7LjKcJh+rzqMCdB5oDJ60=;
        b=Yoh+CK4rI7B3KWeLKUmczK+3KSovjxtKEVjS3VpLACGKxoI//Xkd82bI0/XKBpuZY2
         eyssUbFNhroDKGOcbqPHdVaTdRqCRyCE3RhsKGrmsulITPI+0WFs2JL87OwiagyTSLDw
         6C6JsLfPMRBboVs13t2kah2iDRE5TdnGdsoXOICutqoKjyD+/odb3hqV3M8rI36Pwju3
         w+4hqwMR4cm7uE2f+Cy/12dHxlQx3qhJzCxy193qU0iNq0XSNjT8DUZ/ioggmV/MXyR6
         +SwiZDzgNE3R/tUuOHcIGDqFs4jSX/4ISQ6/oeHiQHGLfhRZzuWdaZJqry/hYwa1SNxo
         fUfQ==
X-Gm-Message-State: AOJu0YwZHQpjzWICodTlw8FJTSoyJSpyXuP1t0EI37H8W7R43w1juU2P
	Gvavrm+/wKxE0rnYfAh5r603iTASYkgkgccvjvnbGe13A61ZPcIW7SLxdQ==
X-Gm-Gg: ASbGncvqlfFaVauVoVIsJhsP0VRJOWROdALt9sJA8/zDcCqw2cQfkSH9Opeq7pqOHkm
	kVZT8S0BFIJE5+r4KNfdZ2S92DuH+thWUwYdaG3IjgGioHox+IHUe1upzZNebN+ycduUkMs6/BS
	tRRzfjlNE6Q9x16pw9/zvODsI4QQipTqvr36Wt66vOWa6i4GIhCKxZObEaUTcrUsV44F1diVjcq
	DW3bp1dB3YE3tMQmQhZMWHKx1PxRlQu2nay7FG/ByCeiZGC/HvrF9814njAkGtWMvzjBlQ8CGtd
	F8cUzXbwW+cRcE+o8tw9meKD54iBBwtxD3Kdxlt+y5HjXUw54Q==
X-Google-Smtp-Source: AGHT+IHGN5C3FZNsgEZ+ooY03kHW8PH8qeCSlkE18R7Cxu2kS5ghJ+sEG/Djj3MsXl3DUitRhieb/w==
X-Received: by 2002:ac8:59ce:0:b0:471:9f06:aebe with SMTP id d75a77b69052e-471afedf725mr5731571cf.41.1739302025970;
        Tue, 11 Feb 2025 11:27:05 -0800 (PST)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4719dab7aadsm18681601cf.51.2025.02.11.11.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:27:05 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] station: print security of network when connecting
Date: Tue, 11 Feb 2025 11:26:56 -0800
Message-Id: <20250211192656.83157-4-prestwoj@gmail.com>
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

After removing the debug log in wiphy_select_akm we still should
log this information. Now it will just be logged once per connection
attempt.
---
 src/station.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/station.c b/src/station.c
index 5403c332..bb6debb9 100644
--- a/src/station.c
+++ b/src/station.c
@@ -3809,11 +3809,15 @@ int __station_connect_network(struct station *station, struct network *network,
 	}
 
 	iwd_notice(IWD_NOTICE_CONNECT_INFO, "ssid: %s, bss: "MAC", "
-					"signal: %d, load: %d/255",
+					"signal: %d, load: %d/255, "
+					"security: %s",
 					network_get_ssid(network),
 					MAC_STR(bss->addr),
 					bss->signal_strength / 100,
-					bss->utilization);
+					bss->utilization,
+					diagnostic_akm_suite_to_security(
+								hs->akm_suite,
+								hs->wpa_ie));
 
 	station->connected_bss = bss;
 	station->connected_network = network;
-- 
2.34.1

