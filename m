Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77352AF0D
	for <iwd@lists.linux.dev>; Tue, 13 Aug 2024 15:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723564615; cv=none; b=BVM3iOWtCMw9fRMe3FKefxOGXy5xdJR54SM2cRh/xGAxx877YlSpoMdq2eIJfngiF0vDuVBzj+U76CpMp66rwVp/5L3g8eDHXDqJrZzOkM236uzc+dGXh1+F0uUeQkbn0pm4MAwNl1jS4cLeUKkDR10OIbxd85OmZjfpRmEjwfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723564615; c=relaxed/simple;
	bh=kMTA5n6IXRmtW6cDWYfD0Ws9JWGuCj4GfDlR3uc3VWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jzV+bg3JpgymR7Nm+0D/j3pTWgqtR44dksXQD2DQDCBprUzuY8sApMoTn+UdKDHiSDtAe4cze6bpswQPeg5JwvDfEQQSDS+uAIYJ6UJm6nWsrL1Mf6ZBRGjdKDYBTAMA89h3dV+rjAYJhk1WRg6VHVrgqjUVfPNLFbzhAffdvoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P017gfJD; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P017gfJD"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4503ccbc218so53184981cf.1
        for <iwd@lists.linux.dev>; Tue, 13 Aug 2024 08:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723564612; x=1724169412; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EX7DQ8XWfm7Wx1d9c/9k0ifUHByA3qMM3NT2FMgRDnU=;
        b=P017gfJDiGuL+Um1lstFxZ3p3GDOxINgun7stlSkNQVXcR9plguOJD82W5hg6vVG41
         wzKRIT4kcJWxsMVxf25vDG7PN8mik5uLrNy/Q3T5oj8qCnK+WWYDUflmGCYrSNntYhpp
         hEYndwn+ZWUxxSuCNjvStbWCUPiEKtUjii9EoHLgEZYr4vMjsVRz5p8vOXjZU9D38yg7
         F5xyklRyT6T+hCNpZbn7A6cRwsfy7heDit+bqVk7Wa5vMQuo38qhivPWtStGrm8RZkKk
         Zgop+MaNvA9/g3o0OBUKEyVidxBPRJmexAWDXDQ6PXn0KG4vSL4W4ULXHMHGrr300owt
         ybPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723564612; x=1724169412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EX7DQ8XWfm7Wx1d9c/9k0ifUHByA3qMM3NT2FMgRDnU=;
        b=fy/U4Ny36n884II/JXSSrLkVTale4ktXHDb/8m3Kx1WF88e+81M9ffmd+9F5sF+tLy
         u90kJHbOCwJQtOfsBr3+tmIdO7lXBggbtFquNM06r0ZAoa4SsDSebhL2E62bcLCPtSBy
         ATtGIGHjRzJQfDD/KtrWZcoZVj1IqrSrrm6CUiJJnuJ52tB7Vg+73b2wOqr1pOH6igC3
         K3EfcryvMvaQglIEWnmS58Aa1AxQwmKeL8chsGsnbndQbj3gYz/QLeMcGf5N66C0ZQDr
         Q4tqNllXdi5vf86AIX9I7S2SaXKH41nQmf/PpYm9kYpmqe/JjtgwjiRTc6f9ydBC9oF5
         h+pQ==
X-Gm-Message-State: AOJu0YxShKgjWvVX5bA3+t7cxnJWJ6O6FK9PwR2LLPLp82v16KQUoLgj
	xVs9Spy5PMGXdwQh+pMDnUETJWltKtw+6yctE3wJIS2353VUFkLSKvxeKw==
X-Google-Smtp-Source: AGHT+IE8AyduAh7HnY+r6+MVKBlpQYt+DgnXhcxETII18VFaloEWRz2fQxdPqMfsmqXA9D61WHMi0A==
X-Received: by 2002:ad4:5d4d:0:b0:6b7:8c94:cd15 with SMTP id 6a1803df08f44-6bf50bebf82mr63575996d6.10.1723564612445;
        Tue, 13 Aug 2024 08:56:52 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82ca2024sm35825706d6.72.2024.08.13.08.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:56:52 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 5/9] station: emit property changed for ConnectedAccessPoint
Date: Tue, 13 Aug 2024 08:56:34 -0700
Message-Id: <20240813155638.74987-5-prestwoj@gmail.com>
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

This was missed in a prior patch set. When station is connecting
or disconnecting ConnectedAccessPoint property change should be
emitted.
---
 src/station.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/station.c b/src/station.c
index 06b19db3..3b61f264 100644
--- a/src/station.c
+++ b/src/station.c
@@ -1639,6 +1639,8 @@ static void station_enter_state(struct station *station,
 
 		l_dbus_property_changed(dbus, netdev_get_path(station->netdev),
 				IWD_STATION_INTERFACE, "ConnectedNetwork");
+		l_dbus_property_changed(dbus, netdev_get_path(station->netdev),
+				IWD_STATION_INTERFACE, "ConnectedAccessPoint");
 		l_dbus_property_changed(dbus,
 				network_get_path(station->connected_network),
 				IWD_NETWORK_INTERFACE, "Connected");
@@ -1810,6 +1812,8 @@ static void station_reset_connection_state(struct station *station)
 
 	l_dbus_property_changed(dbus, netdev_get_path(station->netdev),
 				IWD_STATION_INTERFACE, "ConnectedNetwork");
+	l_dbus_property_changed(dbus, netdev_get_path(station->netdev),
+				IWD_STATION_INTERFACE, "ConnectedAccessPoint");
 	l_dbus_property_changed(dbus, network_get_path(network),
 				IWD_NETWORK_INTERFACE, "Connected");
 	l_dbus_object_remove_interface(dbus, netdev_get_path(station->netdev),
-- 
2.34.1

