Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D9F1292D2
	for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706637045; cv=none; b=R0CsWHJWQl3HO5K/yimvLcgXxFyTpdlygHTZcEjqu3F9wesf6cohi53jl1JnQ9z719Z3WSEQcCQpMMU3Hh4BUtIeKawv8VaaEFUO1dALyT1LLXDEW6aEJCbt+JU3ETtEVAGd8T0o+1OVLLQl/WOG2eVbCY8PqM9+Hrsqd8TNJPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706637045; c=relaxed/simple;
	bh=ZCsSo3/1h1z/1tTi1VJu8pc+HYN74DSqGYUxQH2I6Kc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qp4m5twSpD/qmdNWim7AjY5n6VB1Z69LwQdvl1Ky5l+BwSU6ZlVTEhn+j3R+58428uJn4Jhu8ZkO16Yt7nlpZZtUslv1uE/kjwHx37vPXqMfVjMFIsPNoqa4EO4j64NTpUktmfyjah9fJZm7AezbcT5fR2utWJxKNe10cDt98cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+h9ofn0; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+h9ofn0"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42a99202ae0so281251cf.1
        for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 09:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706637043; x=1707241843; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5nyonp2lnVFKXz39ljbrpbOlqmN3/o6w0KLDTN9o6c0=;
        b=L+h9ofn0Sfmfy6ETVcaLRT+lelkFY5SuZstbaqq6cej1Fd+sa9kRT0wVhUt5qc5HsK
         HBDxxbk5imOViiptqnl7GnmHQsq1YEDxPnCkCxwEipadWE1jG9fxwBEq5KAuHL/glnze
         tlWQhOyFP1UbW1SxrqOKQnEHzGqw5FDypKDtI9xQFl49EFcl7/WT9Jg9KpXPK+nq4zo9
         JUlaCILXD5d04EneuFbx5PAenu4zvOJO11gaNWJceLF+Z700szFMRn5jneh5dJu7nAVD
         1SpwGvtpi9f29aPJPPPmWcjDW7KUdPTWXXvSEcg/g89j8ebZmvP86eji5yzlR0DtosJw
         kZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706637043; x=1707241843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5nyonp2lnVFKXz39ljbrpbOlqmN3/o6w0KLDTN9o6c0=;
        b=kMpjT6QfbOARRUgpl900GkC2xu83+TIuFqoJR4pNvXLfi4nZ6NWn5dbCzd92j7PjaE
         atRGTSVqHV2qsb8TyRdTz1/IIoW8R67bpQqJ9LuARMAMSVbMk2Tg72/fxRSHDe3gPp2F
         9J6pc3D5n3TaF/nS+siy3D/zmePFXIeaeDVc+T8jVLtg8FAjN8AY57RdSmDlHJNcJVjj
         jeymJOzuIpQ4wb+qmsIft+4ZzyDtNl5rudqWWsrssrJMQ44WV36+cA6QP+c0Eb6ZxQzH
         +p7l+buPx4QMdOKcvehc4OTLfsaJ+kwUmrO6p0eQ/YsEYqAoJIpHcNHTSoRoaOR5r3PH
         SLAQ==
X-Gm-Message-State: AOJu0YwmwSHNC8oEyHu/2pGpNXOJk/YDJREuZzjoqB2sU1B+bdAc3XTP
	nqy2BVtBv/Jjp3dBwttbvHzzZvsWwpW4YaXqIspIaXB7njxcgI2pSQFMkLl1iqw=
X-Google-Smtp-Source: AGHT+IHLq8xAOO4N8leCWpOcge/STvbpwa3BLWhUQW7q53idupCNvB3jcgFXUj151D+0um7CpCUKZg==
X-Received: by 2002:a05:622a:1451:b0:42b:dfc4:700 with SMTP id v17-20020a05622a145100b0042bdfc40700mr1410609qtx.17.1706637042686;
        Tue, 30 Jan 2024 09:50:42 -0800 (PST)
Received: from LOCLAP699.rst-01.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id cr7-20020a05622a428700b0042a31bc98b9sm4718914qtb.24.2024.01.30.09.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 09:50:42 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 1/2] netconfig: limit DHCPv4 attempts to avoid extended netconfig times
Date: Tue, 30 Jan 2024 09:50:37 -0800
Message-Id: <20240130175038.77908-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ELL now has a setting to limit the number of DHCP attempts. This
will now be set in IWD and if reached will result in a failure
event, and in turn a disconnect.

IWD will set a maximum of 4 retries which should keep the maximum
DHCP time to ~60 seconds roughly.
---
 src/netconfig.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/netconfig.c b/src/netconfig.c
index 52307025..b31209cf 100644
--- a/src/netconfig.c
+++ b/src/netconfig.c
@@ -50,6 +50,8 @@
 #include "src/netconfig.h"
 #include "src/sysfs.h"
 
+#define DHCP_ATTEMPTS 4
+
 /*
  * Routing priority offset, configurable in main.conf. The route with lower
  * priority offset is preferred.
@@ -696,6 +698,7 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 	int dhcp_priority = L_LOG_INFO;
 	struct l_dhcp6_client *dhcp6;
 	struct l_icmp6_client *icmp6;
+	struct l_dhcp_client *dhcp;
 
 	l_debug("Creating netconfig for interface: %d", ifindex);
 
@@ -723,8 +726,8 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 	l_netconfig_set_event_handler(netconfig->nc, netconfig_event_handler,
 					netconfig, NULL);
 
-	l_dhcp_client_set_debug(l_netconfig_get_dhcp_client(netconfig->nc),
-				do_debug, "[DHCPv4] ", NULL, dhcp_priority);
+	dhcp = l_netconfig_get_dhcp_client(netconfig->nc);
+	l_dhcp_client_set_max_attempts(dhcp, DHCP_ATTEMPTS);
 
 	dhcp6 = l_netconfig_get_dhcp6_client(netconfig->nc);
 	l_dhcp6_client_set_lla_randomized(dhcp6, true);
@@ -735,6 +738,8 @@ struct netconfig *netconfig_new(uint32_t ifindex)
 	if (debug_level) {
 		l_dhcp6_client_set_debug(dhcp6, do_debug, "[DHCPv6] ", NULL);
 		l_icmp6_client_set_debug(icmp6, do_debug, "[ICMPv6] ", NULL);
+		l_dhcp_client_set_debug(dhcp, do_debug, "[DHCPv4] ", NULL,
+					dhcp_priority);
 	}
 
 	return netconfig;
-- 
2.34.1

