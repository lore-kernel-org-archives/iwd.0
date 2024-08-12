Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814514206B
	for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477598; cv=none; b=kodZH0sBKENyvWjeJNc1rpw3FxHRSa5RSyy7TJaV1Ejdq7EXHufWj93nDUqHlUl1UmkAU976b809ae+vX9MPj5U3Wgg9GL8bygDJatQua/Co+uLj5SgFz0XbpxImggm3eTIg1JFPIpAA4qdc30yDmmHc59bBforq5ui9X+iIJ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477598; c=relaxed/simple;
	bh=Y0FM6IdMTdYxT6n/KJsgMsZ/chZmNYalxNdE7CK3QLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KCj9Dy4uj8dubogZ9oHptyelQ6Ra+pWW1HTz/jq9Gt1zk9cpCOMUXH/a/vYcbLRnd9uUoQOlC3Lml6BCOKD/uBauydMOOiLjfgNMrp4aU8uSSTOy8m76OC+xJd1afuqdTXAaPIeqE05zCQUY546RKuxoSCip4Ox/EI1daPl/gBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqIhPm0s; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqIhPm0s"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a156557029so5116647a12.2
        for <iwd@lists.linux.dev>; Mon, 12 Aug 2024 08:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723477594; x=1724082394; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7GqKrME9tW1V+rFm/dnRiB8ulNgvrCAADhugetOY0Q=;
        b=BqIhPm0sn/3sVGdipmji0pyEa+lrsCZEuj2nmVQdrRQBHoOzp86bMl+KmPRXdVnR4G
         SrTXtx1UkvDbiYVsnV77e0QMxG1n2ewHjHmGNjmqPwiDyfxQ16ADJGxXhWGVCsasMKRJ
         UgZ26ENOSUvymgK3WGmkVeTmSCG5TDbI+04nu9sLTWFo+CXnan4BnN7zyxbsEK7DoCO2
         oSjb6xfrrZ5WBWOcj7N0UpRRI3KSG+vwtLq7Dg/V7Aoh3+MWjJgYGbr6qWdRQj4i1oqC
         cqFpHOGTxo/TgfdGkLHriG0aWpVQmx4rMrxqdKTjx5Nx1u0I1jQmqOe4f55W1xKQTKlG
         NqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723477594; x=1724082394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7GqKrME9tW1V+rFm/dnRiB8ulNgvrCAADhugetOY0Q=;
        b=intEgIKaE+PqYR9lNdtG3iV5d74aIXLDbftITBl0rLG4jZ4XBWqZd3LCblZyVQFeyH
         Z2IGm74BR1YRthl9t2LjgcECms6Ti/R69qm4UjsCkMF3SgVO4ciKaIuw0y8rbYNDZYGs
         q4tnGcb1HZmniDwa5Lz3pTRDjQdCK12+qNytysxRhNGRpIeBi2QhTtAKKblZOzEX4iG8
         vjq0t+NOe+3nYarYlsqPIqxcSo7aKVW/sgO9IrrRcAVeP+73lgwGhUUjIfqhlbOkulqs
         lQzDt5zWReRt6n04mO52yl505/LjZl5ghnG0PA3P99KQSbJ7oXQrCinYR933AexFESQ7
         EB9g==
X-Gm-Message-State: AOJu0Yxd51N1v4CO8iU7DcdNLuJ/eBi/mkXl+kXck75XoF1kkfH/xANk
	NRlR5F6fBMWKT/GKe9CqZ0NhZ0PFDivBpWa3Z5AocLzWtnGTX4KIp17frg==
X-Google-Smtp-Source: AGHT+IHDIm7Z3RcNnCqvMaj/Oms+vtKimJU8Mpgs+GWEVuEU+YQAGdqZnUCfXIrtuGFyfNlYPJZtDw==
X-Received: by 2002:a05:6402:2187:b0:5b9:3846:8bb8 with SMTP id 4fb4d7f45d1cf-5bd44c2da65mr521312a12.12.1723477594388;
        Mon, 12 Aug 2024 08:46:34 -0700 (PDT)
Received: from LOCLAP699.vf-sint-niklaas.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd190adb45sm2224931a12.32.2024.08.12.08.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:46:33 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 09/13] client: add net.connman.iwd.BasicServiceSet definition
Date: Mon, 12 Aug 2024 08:46:09 -0700
Message-Id: <20240812154613.126522-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812154613.126522-1-prestwoj@gmail.com>
References: <20240812154613.126522-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 client/dbus-proxy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/dbus-proxy.h b/client/dbus-proxy.h
index f0a5d38a..32300f41 100644
--- a/client/dbus-proxy.h
+++ b/client/dbus-proxy.h
@@ -41,6 +41,7 @@ struct proxy_interface;
 #define IWD_DPP_INTERFACE                "net.connman.iwd.DeviceProvisioning"
 #define IWD_DPP_PKEX_INTERFACE \
 				"net.connman.iwd.SharedCodeDeviceProvisioning"
+#define IWD_BSS_INTERFACE                "net.connman.iwd.BasicServiceSet"
 
 typedef bool (*proxy_property_match_func_t) (const void *a, const void *b);
 
-- 
2.34.1

