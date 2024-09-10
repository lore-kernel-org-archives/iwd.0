Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B07517ADE9
	for <iwd@lists.linux.dev>; Tue, 10 Sep 2024 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994078; cv=none; b=r/hpmEdOy4ZAM9tMG4pY1/czchm0jUcxKPJ+zAaFyZwLU2Vesjbjb/0cUJ2nGKivu04OFLCwhtA0n0/tXPVnF+K1lyUwQhAZv2jvXgwU4De+sERKOSJPQucabqljOUorItKev3NZOoSvKJecdBKzkZ/7efLJ0GbRPuAopMwrQkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994078; c=relaxed/simple;
	bh=DiNBtDFLqYCcMraMTSZxz3mBZbNDrw5y1454oZFNTno=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FfA7kXKUGX90IC62qwUAVYbOPhQ8PjeijV2hYZhBN9wZvQme6uy2yQh+1h+ejaomiGt8kEPaIXea497Z9otbInPV8PoTrAYBFj3vjzk+e3lbXlCOSMzJpBiN+gm3oncnbcXxgy8TbtKbzSuffSWDYHc6nNBWA9Yll1u36ZjI3bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jb2N5/jZ; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb2N5/jZ"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-50108a42fa9so1487626e0c.3
        for <iwd@lists.linux.dev>; Tue, 10 Sep 2024 11:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725994075; x=1726598875; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RO51ENR0ty4NtT4Z9l7ftws9mGxfElV4iQnnHG2dVLk=;
        b=Jb2N5/jZ5jLJa5m0rt0FhVVsyL5iajmfWTqZp5ggomukk7cfRVZ5aUWkrlCoqwfHqM
         +N9yDso3ivYTZZdq5jP/yRFQUY2nF6w7pdp70c4dUW67NbgfzqTGVKBE1RBlQfSUWnma
         mQ+lc3spUKI8ISRwZI56u46QobM2xKdfD+va1+5QzR9iD91mjvYS0JhO4RbFlHVyUW+O
         IqK5L2fpcM3c3oPdX1G6tjuAHiIiCYoVoR130fm2wq9WzRUT/jPquGGsZxk9DMpcVLH/
         6PISnogLw5maH7Dwzj41qBDvC9ZaKejj9I1wiiTJddLrZ2sEPuFYjMLtD37dMPl4Waol
         8APw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725994075; x=1726598875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RO51ENR0ty4NtT4Z9l7ftws9mGxfElV4iQnnHG2dVLk=;
        b=CeaxXtKbkK5RyBQHBkLmswXVxCpCDu9E/aeorDculEX0ThLWAY9ZEIXFsBtP759eQa
         KNVlQfDhRz3fnnmJR/613tVaCWryNIQedq8jzBDYEv1GjpBYZJLgKadGxQfdOX7XT2lk
         TZvh+GKVPkWTjGKDGpn7IIP41QaA55w+YwaECciia1MP+SLsBNoc9L+ZB0RVDTr3iQPT
         iVmfIMke2XtM6V0chngm+jbCnunQe2QH5gg99xjA/N2w5U5Yfy+I9W48Y78hyZkLJX2C
         J0pQpBm/4FeMHA4LNO5VFdpHqE8J3wexOghybvlCoHQmPg9lTVZQi2JWe5Y1qreh3wrc
         9KXw==
X-Gm-Message-State: AOJu0YyjI67bTVGQWVI3Td+RRLvxTRRLWQuFvivJxLtQgy+A4hXF26wM
	SQiDJdWU9pPJwdZ5B3ek8VtwMPpUArmrdYucP9YoTIO3U/CpZ+x6UuWZzA==
X-Google-Smtp-Source: AGHT+IG3x4olq3jAA7KBCuRJdXr7/x8TG2pfZ3uYOaarQW3SIpkJ6/Y1mf08UgV+NTEYFCc4wLmnhA==
X-Received: by 2002:a05:6122:2092:b0:501:281b:eae with SMTP id 71dfb90a1353d-501e77bdf4bmr11549005e0c.0.1725994075131;
        Tue, 10 Sep 2024 11:47:55 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c53474d8ccsm32809426d6.96.2024.09.10.11.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 11:47:54 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: fix crash if affinities watch gets removed
Date: Tue, 10 Sep 2024 11:47:50 -0700
Message-Id: <20240910184750.126488-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the affinity watch is removed by setting an empty list the
disconnect callback won't be called which was the only place
the watch ID was cleared. This resulted in the next SetProperty call
to think a watch existed, and attempt to compare the sender address
which would be NULL.

The watch ID should be cleared inside the destroy callback, not
the disconnect callback.
---
 src/station.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 56a90f5f..44f5f771 100644
--- a/src/station.c
+++ b/src/station.c
@@ -4598,7 +4598,6 @@ static void station_affinity_disconnected_cb(struct l_dbus *dbus,
 	struct station *station = user_data;
 
 	l_dbus_remove_watch(dbus_get_bus(), station->affinity_watch);
-	station->affinity_watch = 0;
 
 	l_debug("client that set affinity has disconnected");
 
@@ -4611,6 +4610,8 @@ static void station_affinity_watch_destroy(void *user_data)
 	struct station *station = user_data;
 	bool empty = l_queue_length(station->affinities) == 0;
 
+	station->affinity_watch = 0;
+
 	l_free(station->affinity_client);
 	station->affinity_client = NULL;
 
-- 
2.34.1

