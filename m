Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6CF19BB1
	for <iwd@lists.linux.dev>; Tue, 31 Oct 2023 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g68LzRn/"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7789577b53fso391843385a.3
        for <iwd@lists.linux.dev>; Tue, 31 Oct 2023 11:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698778077; x=1699382877; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZN5SoWjrhb+lwqzU6FWEYrlJgK6+mg++aD/qZm4yp1Q=;
        b=g68LzRn/Et1wqSJRel2ovYS05nsZehcWHqL/LVtNGIzPPBS64cFzr5zYolQsps1oFN
         9+bM6L/ffSOP/nerxWRYx+jFhmnLkhQ3ZqBm54+/gUY11yG8+eLIJBOkWAr8TEbSm6i1
         LIuoiaUomSQHevePgPqxuJNHieiX/Uj9T/Ri6MxITAMrIVKHyvSbHBwbKJyshuN2odDH
         VdVXom/y5x+L34pITEP4BvrRMiP0NEcQQ14v1hW8qTMZJtgwtEv77NA2osrndWBwvdRI
         x/ZMRAX0Ss8pcYxJdMxiFY+O8NX+H71eUSAPbkML9Qz6REl/I+viNkZJG19ds33nycRB
         4Upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698778077; x=1699382877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZN5SoWjrhb+lwqzU6FWEYrlJgK6+mg++aD/qZm4yp1Q=;
        b=kimlaIa8e5TfbreGTdb43zEWERWKqExA4U9MdVsk9J4tfwJF2hZMs88LHUyJEbMcMm
         ySLJ9aEN7Uw5x3ayFSgBeE/zE0opFKiPTF8pdQUIHp85xKBq7Rreau//kUvIWyW12Ao7
         Jy7AiKoWlCcd4TnOllogQgtVpKfM9aTh/+P81rfgR688AXqRMJzDG/1fR0JRMaINJXQT
         ux3/S9uueNVPN0cBsI6OjjqmR0J6SDjfPZ6S4v63s3oSTSXHA2znnrVXrn3pNjE8TNBQ
         wbMcGO4d0G7XrTQgjEIuzFa1E23F09iECwcla6KHTXhrSWRYN+R0WuvkjhEHaCMRyusZ
         EvFw==
X-Gm-Message-State: AOJu0Yx1nzD4vKvfa1ze+ocJB34Cu8mn/7sP9qgPw2564VMycsggvCpJ
	s+CtMva6mQPmH2GaCY2fnJKtRi5pc70=
X-Google-Smtp-Source: AGHT+IFPP49XJEgoivZnvJ9vz4KHxZuZkaevR6LjlqdQ2Ajfz5IGC77Avo4kiGtXOx1AmtAA0SbXdg==
X-Received: by 2002:a05:620a:190d:b0:778:8822:9a3f with SMTP id bj13-20020a05620a190d00b0077888229a3fmr17260347qkb.63.1698778077298;
        Tue, 31 Oct 2023 11:47:57 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id bj30-20020a05620a191e00b00774292e636dsm736351qkb.63.2023.10.31.11.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 11:47:56 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v3 0/9] DPP PKEX Changes
Date: Tue, 31 Oct 2023 11:47:41 -0700
Message-Id: <20231031184750.722404-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3:
 * Corrected the config header check patch

 * Kept the scan/connect logic in DPP but instead changed
   __station_connect_network to be more flexible to this
   use case. I don't think there was many great ways to
   do this, I'm open to suggestions on alternatives.

   Also, I didn't forget about the need to filter the by
   SSID in the DPP scan path, I just left that out for now
   until the station <-> DPP interaction is nailed down. In
   addition to your comments I relalized that the scan notify
   callback should call __station_connect_network (or
   whatever) rather than enabling autoconnect. I'll send
   follow-up patches for this.

 * Documented SharedCodeAgent interface

 * Better documented the DPP SharedCode interface methods

James Prestwood (9):
  dpp: remove scan_periodic_stop calls
  dpp: fix config request header check
  dpp: allow enrollee to be authentication initiator
  dbus: add net.connman.iwd.SharedCodeAgent DBus interface
  station: provide new state in __station_connect_network
  doc: PKEX support for DPP
  dpp: SharedCode interface, {Register,Unregister}SharedCodeAgent
  dpp: initial version of PKEX enrollee support
  dpp: initial version of PKEX configurator support

 doc/device-provisioning-api.txt |  149 +++
 src/dbus.h                      |    1 +
 src/dpp.c                       | 1681 +++++++++++++++++++++++++++++--
 src/network.c                   |    3 +-
 src/station.c                   |   23 +-
 src/station.h                   |    2 +-
 6 files changed, 1754 insertions(+), 105 deletions(-)

-- 
2.25.1

