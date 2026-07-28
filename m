Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB843191CE
	for <iwd@lists.linux.dev>; Tue, 28 Jul 2026 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253710; cv=none; b=g+oB5KywxLiBJ1mlcgFgs0c/ZVGzQP6Di9whR6avY+crFLwEOnxXl0UxIDE0AlNl2HAXMHQB4tGZGv7skfh5snSLuWcNCRza6y3fR6OFxT6Ypb4yFBjqJIka4M61q0mzZ/dV8yPFh5xf+oUrcGFzuanSOImYiafWWsewD9HxLgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253710; c=relaxed/simple;
	bh=zuBfm6sCNi+XissdK0UEsOWDZmbwk7sRtfZv2ozoXYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHL/xAuUINBHsFjIG+OQHuoTSIRO+RJKzqptG559R4Q01oHimVxsTHtOgKT9mp4x6mhpgzNgBllXkCS81cDu3hwWfPoqFULCEl89P86DryLAJlP0ildvGT6CnXrLsdSijQ1j27yi746cIbfZaIIaNKKqggYGET28yE3UaaaAecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrxisXOC; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrxisXOC"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39c9452244aso38780661fa.3
        for <iwd@lists.linux.dev>; Tue, 28 Jul 2026 08:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785253707; x=1785858507; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0myssMzs54ETZcmYuu7tGk0MyaK1Bc14jx33Hl5rWHA=;
        b=YrxisXOCH9p5Os+XWMJHH7nZU8IBDFX24HcMdy98SeYjbvr4ryTH3hB56rKUl5XCz2
         IydMYALdwN27YOUFwuTjGt4M0U6nvFVkulZgbPowhIb9wcTCqosM2AicUCOYZSftaljG
         Gg9R/o/MWdWTkHFodWRKkHf1EurwYJr6lI2wCvBbikX6Qjvd7oawBT9EKSTpgFZfiJWo
         mVG2QQo6oZ92ZF8kYJLF11ymkfv9RECI4y+jhATdiloym24102a5hZr//V80TfNMDlZC
         LUmi742iJLMUzaGj3hlLCqU+ykA/2TY4Vlg35UWmbDij/LtYmwu2p8x+fNX5kaC/O8HT
         Ngfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785253707; x=1785858507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0myssMzs54ETZcmYuu7tGk0MyaK1Bc14jx33Hl5rWHA=;
        b=HwnIkABoC1gjGcEnQcXsjuzfe1eejYjPtnmGj7/clulOy63+AVketT+uHxh6wNrrRg
         XjH2xPyKKlLBdMqbhtF5phAmKEwsH06VqfhT/1XRdOuIScv2TPEL8b2aeshyB65+xsIJ
         Xgs6jHPDznRhmyMdKKHKAZbFL0TPEGWTuXBYRBqD3WN9HrB7Pdh5Oe19Dz2hv87Upk0Z
         FG4F1KK9jdaJWByumP4n+einXfXLE5F6TA4wPY5cUePmw2T6yZSHWjb7Ee08BV7gJ5Ji
         BoBji7A/wjNV+1Fih/oOaZ9mw+/MTY4ncXImUygXslR15cVIOIablRztpMzTie2mJ68j
         wGjA==
X-Gm-Message-State: AOJu0YzEpNI+ojPfGMNfHDMQhcXPSY82XMWFmcHc7En1+DdgqetcakCi
	g4he2oVSpgWyVAPOgY7z7dtODC5zX8sxb/gZRocnU8ofOor1DNGLtWVb7uqJQEt2GjQT9g==
X-Gm-Gg: AR+sD13kkwLUXoaT2O7U1XKCpPYWvT8bGIxrMi/GQAfAdmbAZLlFOQ3wjRYTlP7EhUK
	dwS8hGJf4srPNpUlHpj6nG7JmVvFrJFlH2nTrBUpk65+ZzKM3dqiVjVUmI+Pk+WK2zSkOv5rZKx
	MQsKjO5nIAjhsch3qaEQ1otkh1eKaqIIF5hNQNXVXIZlbg3UwX3mS6lUdyEMJEHdVedxryV9BfU
	rozVoORFQv+jNJw7pC+gE3qnOcbTaee0M7biwi6bQIExRjgtwHtZ9oEtVPda6Lb6lNvEkn//ht2
	0cFjyZqX4HlBq1RciMzXOFW2zOONj2s4Wo92zhQRuiyI5czIhk7fjXQekm7T2ySqDI3rfcGtsAX
	cvHlUqzm2NhYhDu97EEfHGuOnHMcrHuk064Zv8YnuNzkyHeu9MK4wD4265zxYX8CMsXV2VqpkAh
	iIl7E32jYz0CGPa4Tddg==
X-Received: by 2002:a2e:ab06:0:b0:39c:83b8:a887 with SMTP id 38308e7fff4ca-39f51f07ed0mr6070431fa.33.1785253707134;
        Tue, 28 Jul 2026 08:48:27 -0700 (PDT)
Received: from ultra-pc (s3.2dsites.ru. [188.187.190.12])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f22187e5csm19807431fa.16.2026.07.28.08.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 08:48:26 -0700 (PDT)
From: Aleksman4o <aleksman4o@gmail.com>
To: iwd@lists.linux.dev
Cc: Aleks Man <aleksman4o@gmail.com>,
	prestwoj@gmail.com,
	denkenz@gmail.com
Subject: [PATCH v4 5/5] client: widen BSS property value column
Date: Tue, 28 Jul 2026 18:46:44 +0300
Message-ID: <20260728154729.3485557-6-aleksman4o@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728154729.3485557-1-aleksman4o@gmail.com>
References: <cover.1784069194.git.aleksman4o@gmail.com> <f9cb0ba9-da64-48b1-a8a9-3fe5c463b568@gmail.com>
 <20260728154729.3485557-1-aleksman4o@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aleks Man <aleksman4o@gmail.com>

The get-bsses table used an 18-character value column because Address
was the only property. Make room for longer values such as RSN
capabilities while keeping the table within 80 columns.
---
 client/station.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/client/station.c b/client/station.c
index 5066a9f1..eccf8314 100644
--- a/client/station.c
+++ b/client/station.c
@@ -754,7 +754,7 @@ static enum cmd_status cmd_get_bsses(const char *device_name,
 
 	sprintf(header, "%s BasicServiceSets", network_get_name(network_proxy));
 
-	proxy_properties_display_header(header, MARGIN, 10, 18);
+	proxy_properties_display_header(header, MARGIN, 10, 47);
 
 	for (e = l_queue_get_entries(bss_list); e; e = e->next) {
 		const char *path = e->data;
@@ -765,7 +765,7 @@ static enum cmd_status cmd_get_bsses(const char *device_name,
 			continue;
 
 		display_table_row(MARGIN, 1, strlen(path), path);
-		proxy_properties_display_inline(bss_i, MARGIN, 10, 18);
+		proxy_properties_display_inline(bss_i, MARGIN, 10, 47);
 		display_table_row(MARGIN, 1, 1, "");
 	}
 
-- 
2.55.0

