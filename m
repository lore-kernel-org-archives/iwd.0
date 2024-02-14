Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FECE5C905
	for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 19:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939534; cv=none; b=o7JEU5EulCNdp2CN9/B9jY6HDxAULb8au7G3q3FMfARF/+zoQTz01SOYSuP/rggZDj4f7j+tBgNDQM/5Ucenw+5VuzUm/JY1U8luLWo26p0TYlMUL4aUE0PrQKPGm0yJA6gHtEJdFfUtxGnRfzm5iFYOFLxRcU0rmy1u/SjmzBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939534; c=relaxed/simple;
	bh=dXVMtJYtqVf/KVtLWeITgyWS5XxpljPMwtDczMBGV+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DcGlrG7t8TYDfQbdJStsjmeCgVdetKLuIkZmdWYx1I02VA+OTVAxL9BB6Yrzio8OHbPY/ypwY76ha+bLynOiOJkHLo1SxaiqbyTUudMzgTRGnVL7hE6cIxVVqiZRJ1WPNJE/l/ZOiXg68c5tVQkNDdnh6I61StF4pZFs8gvZCXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8391RCB; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8391RCB"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so108536a12.3
        for <iwd@lists.linux.dev>; Wed, 14 Feb 2024 11:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707939531; x=1708544331; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cf30CwGE7zCljuL0ETkdjSXR31gkK7fLe0jQSlAoadI=;
        b=J8391RCBDdM4m4D+Mp1wgYbjhBTxPqcRrjZVDO7ZYyRajvTHtL40UKtZNY0nZLv7vD
         aNEl4Qblf0rgDH3kJXBSnT01jFJnedBlTczuM0ie+nQ5l6ZxKWfe+z6LFW36T610XJyQ
         uZ22/HDak/ykicHJ603wu5jw7TPocuUP/NzoK/65VrvGJ4MvFKdB4j5njjI5RqXgzhEN
         +/GpF8Hwwx9vp82TkcXQwj1NJLP2t9zZdYSWmzBXi7nLfT8BwJ5USf1t9it2ah5dIapm
         xiA+cLQVoSk8R+Ji/wYBKY8ZA9CsqUUwZnKHpF0bXQCLM70scqpQzR0yIZyxuSbwr7oW
         L5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707939531; x=1708544331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cf30CwGE7zCljuL0ETkdjSXR31gkK7fLe0jQSlAoadI=;
        b=TaPhyjD6jRUzP813hI4WTAlHjWvCIYAGJDhRhfJ8zt1aJZYp5uETHLDOVvhxHZeO7S
         oLxQDzajmEITKekMZs4AMmEwom4X94cYxLhQMFnJbogSkZ6lTfv+9ShN+TAfaqVvmqOa
         xFhmzE6g0YUdZgxvAHhiGFTck5AB5MwcH9GQUHpb7O3/BhI3pAPvSd6J2Z9qJpIgqueQ
         2FSAVJfpjCvvdYGt3gb2Sb0sKpOKN7ySCmkQD0TjAIxDa7h4IkStdm97+rCu+AkvkiiU
         aG6Ah0tN4wF0t8TGHMC5Y2FFEAf2P97H1mfr9cDpsLwt84dwSF8OUfX9ABxTQhc0X6iE
         WB6g==
X-Gm-Message-State: AOJu0YyCZydA7Ui50tVhCoXvS6EtnGFOlNbJ3ggH1vHe9tYbN6cvDB4P
	NVOr/IYSjo++orGhYZ9rTZSs/aG18JmjCat4H8Kq5gfNBWd9a1DjGoi1q8PHunI=
X-Google-Smtp-Source: AGHT+IEqF7dP2fCc5D3VCiMOfdw/FIU+hOX2wsK2KSA8ZvoIduJVF7qiBi61+vaDeFW8jOmJSUeaXw==
X-Received: by 2002:a17:902:bb8d:b0:1d9:c86c:39c2 with SMTP id m13-20020a170902bb8d00b001d9c86c39c2mr3443083pls.14.1707939531454;
        Wed, 14 Feb 2024 11:38:51 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id v2-20020a170902d08200b001db53ccb856sm1761606plv.108.2024.02.14.11.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 11:38:51 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [RFC 0/5] Using l_notice for low level IWD state information
Date: Wed, 14 Feb 2024 11:37:38 -0800
Message-Id: <20240214193743.963349-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lots is explained in the commit description but being able to run
tooling over IWD logs would be very useful to gather statistics on
how IWD is behaving with respect to connections, roaming, or whatever
else is desired. With these patches I've written a tool that monitors
only the NOTICE log level in the journal and spits out much more
concise information about IWD, for example running it against one of
the FT autotests:

 connecting to TestFT (12:00:00:00:00:01) signal: -80 load: 127/255
 connected
     No scan issued to connect
     Connected SSID: TestFT
     Connected BSS: 12:00:00:00:00:01
     Connecting time: 0ms
 initiating roam to 12:00:00:00:00:02 signal: -30 load: 127/255
 failed to ft-roam to BSS 12:00:00:00:00:02 reason: association-timeout
 disconnected
     Time connected: 5739ms
 connecting to TestFT (12:00:00:00:00:01) signal: -80 load: 127/255
 connected
     Scan time: 5320ms
     Connected SSID: TestFT
     Connected BSS: 12:00:00:00:00:01
     Connecting time: 0ms
     Time disconnected: 5320ms
 initiating roam to 12:00:00:00:00:02 signal: -30 load: 127/255
 failed to ft-roam to 12:00:00:00:00:02 reason: authentication timeout
 initiating roam to 12:00:00:00:00:03 signal: -70 load: 127/255
 FT roamed
     Scan time: 12752ms
     Connected SSID: TestFT
     Connected BSS: 12:00:00:00:00:03
     Connecting time: 230ms
 disconnected
     Time connected: 1ms
 connecting to TestFT (12:00:00:00:00:01) signal: -80 load: 127/255
 connected
     Scan time: 5318ms
     Connected SSID: TestFT
     Connected BSS: 12:00:00:00:00:01
     Connecting time: 0ms
 initiating roam to 12:00:00:00:00:03 signal: -60 load: 127/255
 failed to ft-roam to 12:00:00:00:00:03 status: 53
 initiating roam to 12:00:00:00:00:03 signal: -60 load: 127/255
 roamed
     Scan time: 12758ms
     Connected SSID: TestFT
     Connected BSS: 12:00:00:00:00:03
     Connecting time: 210ms
 initiating roam to 12:00:00:00:00:02 signal: -75 load: 127/255
 FT roamed
     Scan time: 12759ms
     Connected SSID: TestFT
     Connected BSS: 12:00:00:00:00:02
     Connecting time: 10ms
 disconnected
     Time connected: 1ms
 connecting to TestFT (12:00:00:00:00:01) signal: -80 load: 127/255
 connected
     Scan time: 5318ms
     Connected SSID: TestFT
     Connected BSS: 12:00:00:00:00:01
     Connecting time: 0ms
 initiating roam to 12:00:00:00:00:03 signal: -71 load: 127/255
 failed to ft-roam to 12:00:00:00:00:03 status: 53
 initiating roam to 12:00:00:00:00:02 signal: -73 load: 127/255
 FT roamed
     Scan time: 12752ms
     Connected SSID: TestFT
     Connected BSS: 12:00:00:00:00:02
     Connecting time: 220ms
 disconnected
     Time connected: 1ms

James Prestwood (5):
  main: add runtime flag for setting the logger
  station: use l_notice for station_debug_event, allow arguments
  station: add additional station_debug_event's
  netdev: add notice events for connection timeouts
  doc: document use of l_log APIs

 doc/coding-style.txt | 24 ++++++++++++++++++++
 src/main.c           | 14 ++++++++++--
 src/netdev.c         |  6 ++---
 src/station.c        | 52 ++++++++++++++++++++++++++++++++------------
 4 files changed, 77 insertions(+), 19 deletions(-)

-- 
2.34.1

