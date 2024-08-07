Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE36113E039
	for <iwd@lists.linux.dev>; Wed,  7 Aug 2024 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054487; cv=none; b=Gt9K9tK6QamX+nqY92TNr/Dx5tW3nEzgBMoMSpBEwgFlPfuqn7whYAy/5OkvJeuQAnCEF8E/mG+s3jnDXY3HEjOgcSbc2rydfi4dVyYav2ZkYr0GFJpDo2UzVDIHhDvN388VqOQ4g0+Sokg/I1JqLNgEl+CXayl/78s40jnHJsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054487; c=relaxed/simple;
	bh=Y0FM6IdMTdYxT6n/KJsgMsZ/chZmNYalxNdE7CK3QLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=txQIasJq/PAiVpXUUb/Rm4DfVFlTFokQe/7EF3mmTC+5vtjJFYRVcEXnBeRho5nGkpvM90nF2Nwk07pjOILzIMygfJmtj6/E3xwD4KrjapjSkwj69QVvImOKV3Htew3D3EfSTaTRe2Wg0alKqeOZE4TyTKT7JyyJCxhWduO8W/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FV+HOMgh; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FV+HOMgh"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-264545214efso111247fac.3
        for <iwd@lists.linux.dev>; Wed, 07 Aug 2024 11:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723054484; x=1723659284; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7GqKrME9tW1V+rFm/dnRiB8ulNgvrCAADhugetOY0Q=;
        b=FV+HOMghAD7nLJs0o4+CoSOGh1eGB4mqtIq1DCRePo2laryRdP0eIg6SYfPNqdwIzV
         7h/VKzp86b3uTOFvtRGicK9AZpnhybTvJO5QKoTkqz+jobeieEEEkHD/fP4cUptzQlqZ
         Ujpc4AtoT/1EQZIaxtrp+kEjzj2WinN9Np804yOpOo8eQAXPes1YZ4ZVV1r/kP4aOE/X
         OdNhGfj3zANFOITRp9VjxMHuLI7w1Mi0OsLZz49YspkDfoCqgEzDuNaSd9C6M4Zyn9Ft
         CKHjHbXTZLqXe2YG2Lfwz1onZJfNrInRwVgqwZJU3QC1UKc0YnShsXA252aCt/X4i6Mv
         /vWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723054484; x=1723659284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7GqKrME9tW1V+rFm/dnRiB8ulNgvrCAADhugetOY0Q=;
        b=r5iiPz31S1Qx2Rea6TzQMm0Oo6m7azErN/s+G82dS/Ih98nPZETyOrRrXxUOiDu5Zn
         EidCq+P3Z3iMDB+WDKshXjjR54ixHcBY6Pnb+N2iM4HR9QS5CL49BZrYPkL+s7kv7DIT
         oV6GgOG4REkVWtSfVM7QEfpQKSR2/siEKJSkPDw+Hp7gVRiLSIDGrJVdCR4hV87W7TBd
         URgVkogtIcGGZiISeu6/hOxsigxL4+mDX1OdVBjwGTFFvFKinL+yK1jEbj/8pL5QpogE
         YOxKHPEfNEPfIhKBN/YDSZZ8JY6hi40/tcsJbSPTaQndSC72MRJvUMeQ7O1sqdYontxH
         gs2Q==
X-Gm-Message-State: AOJu0YxWSBWw79aci+0QgLt8i2lAWdhToS3Dkw1KcM/9rG+656MmL09V
	xdQSQ9sEM510u5IDKKeqLovHEYysl4eLD6+doVUrVwEWDxdxgEm/OR108w==
X-Google-Smtp-Source: AGHT+IHPo3D2iG00BA3AGOtzLmMkwjaXBynMkzoVRGnpxG1uJbE/eJJKcEZAXrbKKvKioMa8vzR9gw==
X-Received: by 2002:a05:6870:970c:b0:268:75d3:40dd with SMTP id 586e51a60fabf-26891eed9aemr20375203fac.49.1723054484583;
        Wed, 07 Aug 2024 11:14:44 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785d0db4sm82194685a.7.2024.08.07.11.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:14:44 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 10/14] client: add net.connman.iwd.BasicServiceSet definition
Date: Wed,  7 Aug 2024 11:14:23 -0700
Message-Id: <20240807181427.170515-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807181427.170515-1-prestwoj@gmail.com>
References: <20240807181427.170515-1-prestwoj@gmail.com>
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

