Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B517F1A08AB
	for <iwd@lists.linux.dev>; Tue, 13 Aug 2024 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564614; cv=none; b=jopy2+KTysl45K95IKHkXESpT/DXB0pcuzk3dtAP3dtYagH8tNg5/7nhGWeua+OlVHbJx8rRLb6X8iX1pG1Ey8SMcauBBi9sGThxwFzMTmyvXDsPNuMG9qZg0k7wdmUue4xrqZC25LtXx3DA5IRR8tUYiJShWjn6VAcGP47aKyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564614; c=relaxed/simple;
	bh=7zC6ykoUJCb6Jt8r+4q72RjpJW+OKWUBOovnk/6cJKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=THcRLQmQTZICmUFchSwr7FZ6jF2lamvbFqA6q/GQwBxODcuSPIwBbnG1FmgqmUseoI1pwp3goKE62CnBHx05qESOqU4kwL6irzom+y3xiFnUEiyJSH3dS/AlFQ3Fu4gnfEllzSOBXyHOpEcNUmfnUDkMjHxVOexDAn+opdxqhZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQ/2YbDw; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQ/2YbDw"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e0857a11862so5655726276.1
        for <iwd@lists.linux.dev>; Tue, 13 Aug 2024 08:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723564611; x=1724169411; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RBbbQQ27ghq0kvYe6nKRsI9oUMREb0TxyQIFOqk6Mo=;
        b=IQ/2YbDwf3g47ARLE6wD+1xG/Ekj4sGwsUh6XA+lRIdt2VZ944fdnekl4AYSpvMjZJ
         7kfngsOhJ4Wk7m9WyhQjJ1IsK+HZcUtRDDRfnwkfk4ibGDqMlbD8ggELTEnWQI0kGzDi
         6T96ogYPaPpBkqgLUeuDBXt8TkPeHX1pUCPwswS4Qe7vOYMTDtwKJ2Cw5EZNMqcsqkfR
         hHFvtuQlflxx8qn6FkRGyEbk5Qxr6xgo6+G+Kgg5DAaabMqcd/uScJPKpFRpAy8FHSj3
         Wm4IVLmKAZJG4ufFrP8SLHv3YyFeCzahBu8tCnmpayjj1tbr4IKkDfM3We/165gaJh7g
         +Dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723564611; x=1724169411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RBbbQQ27ghq0kvYe6nKRsI9oUMREb0TxyQIFOqk6Mo=;
        b=AL6x8vr2TgyrHmkM+IJ5iYIgwGC2fj8IKW75SkVrFKuV6F16FJ9heNMJ46Fj8ZhLss
         E582HY0TQHCE9JwFwMYVCOe0p3AhIfOvhzanNAtg5Aj/FqJoU7Tfvf2BCh/gLbmO5VfC
         E4DJ5u444nYEr8e/MObn42hs5aV29qqMEapaL/k+5KUDuAJTTVLGFp34padBVwwR7ihy
         iYIkNd0TAUbOULnhslL+fft4s3ABMsSJQK1hVMpPc+k097CcbiAMg8OSOGPVpQbdJukh
         b8q6ZuufYqehnAczmCF5qOUstcxznL/x73b07VUB90GyTPxASVrPDU8PqtfeCTMkRbo0
         NrQg==
X-Gm-Message-State: AOJu0YxcTvkHnl7OmBUqYrFMNHlgzE8Ln8nAQysIxWPVs8qP53iJ2BEs
	YhZp2za/oZFev5jefZTHdekZdxvV2lmwDh9a7e6QqPNsNpK8yWajedVEfA==
X-Google-Smtp-Source: AGHT+IHlHZ5HTJd47Vj9gbYzUySLMvCjTllAij6CjzsrRqNJh/RwinbVTlIMtIBWenvhInKgnYi32w==
X-Received: by 2002:a05:6902:1026:b0:e03:55f1:319d with SMTP id 3f1490d57ef6-e113d27b97fmr4768265276.39.1723564611333;
        Tue, 13 Aug 2024 08:56:51 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82ca2024sm35825706d6.72.2024.08.13.08.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:56:50 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/9] netdev: add netdev_get_critical_signal_threshold
Date: Tue, 13 Aug 2024 08:56:33 -0700
Message-Id: <20240813155638.74987-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813155638.74987-1-prestwoj@gmail.com>
References: <20240813155638.74987-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is set via a main.conf option but to avoid duplicated settings
parsing in station add a getter API.
---
 src/netdev.c | 6 ++++++
 src/netdev.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/src/netdev.c b/src/netdev.c
index 94766552..c7d0d880 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -3713,6 +3713,12 @@ int netdev_raise_signal_threshold(struct netdev *netdev)
 						LOW_SIGNAL_THRESHOLD_5GHZ);
 }
 
+int netdev_get_critical_signal_threshold(struct netdev *netdev)
+{
+	return netdev->frequency > 4000 ? CRITICAL_SIGNAL_THRESHOLD_5GHZ :
+					CRITICAL_SIGNAL_THRESHOLD;
+}
+
 static bool netdev_connection_work_ready(struct wiphy_radio_work_item *item)
 {
 	struct netdev *netdev = l_container_of(item, struct netdev, work);
diff --git a/src/netdev.h b/src/netdev.h
index 3a772256..f89aa572 100644
--- a/src/netdev.h
+++ b/src/netdev.h
@@ -199,6 +199,7 @@ int netdev_set_rssi_report_levels(struct netdev *netdev, const int8_t *levels,
 					size_t levels_num);
 int netdev_lower_signal_threshold(struct netdev *netdev);
 int netdev_raise_signal_threshold(struct netdev *netdev);
+int netdev_get_critical_signal_threshold(struct netdev *netdev);
 
 int netdev_get_station(struct netdev *netdev, const uint8_t *mac,
 			netdev_get_station_cb_t cb, void *user_data,
-- 
2.34.1

