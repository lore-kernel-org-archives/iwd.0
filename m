Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A0F20E0
	for <iwd@lists.linux.dev>; Mon, 27 Nov 2023 03:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d57yKAi4"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6d7ed2c143eso2565807a34.3
        for <iwd@lists.linux.dev>; Sun, 26 Nov 2023 19:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701055277; x=1701660077; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z7PHrc6hwq2B5m4fnvyOmgdSuJI+kiBZQV/FYmlAF70=;
        b=d57yKAi4SA2+mnwXHs0jjvCyvt+61NuWcYPjn6k5z4om1ur7tjBwzHyY8+Sxh405ez
         +PgVSVXrz4It107Jde2IATwD9hH6Lt9yciN6RoYce5yV1SJrixNc3zChG9ywLCk0mBsp
         g/CuQEdxfUhCbhOZlDJXKt2C5y3UMvLnBjiPM3Laeu+3VDwHu52VaPp3XUEXzpFBp/Wd
         qCGbNorsmI1GW6IApK+jrxyc2byczv9m0O6GAjIKRfc449WQQot2NxWT2DBOELzOxE/K
         GbLI8KKeDiP9RefBVpgrgdoPY/Km1YFXrbO3KY3P6ZwHdFx+NrmHSziBR1MPrCMR3KEh
         ca4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701055277; x=1701660077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z7PHrc6hwq2B5m4fnvyOmgdSuJI+kiBZQV/FYmlAF70=;
        b=qECYQHZ3+d/5OzU3Y5LpFWc715N4WSEvx57W5G0LhKujPQ0H4fR6LC5CgxF8nI5Pl0
         V9a4qqEazpNqlkLsXjI3N4rgKWo41H/9JoU+x6M00swDtEUjju6GL13FlfWxnJZYlwMB
         0ylfcoeHXJfYNvGjnEYfJfgmdsLNMiP+u3hvFvnQWTccsK0YDavFq7DBT4wsDlI7Ge8X
         CFyxboGTOTz8f0UOK2Zh4vqd9i7cgq4C3LtNgpIbGwSptkPP2DLWgQAbci0XMxXqo2ok
         9GA7fgHE0nqw4G4XxBQ56n+CIuSPQXRX4aptLl2eC/AnMEKGOEx+4aCD9WzMFJJ5D4NK
         ekEw==
X-Gm-Message-State: AOJu0YzOGzx6d0ubJQwBfPFN0TTx6rZncN6vq7LMy4x15HRtz/Z+xYJ6
	LOUMs/dsQNJ7lyemFX7JXkhU+La/0sg=
X-Google-Smtp-Source: AGHT+IGrvTv/3YlzLbos4a0uRBbZnhOMzJDrAV/pNUWiXzPapmu7DUiY0OdeG6RTSrP+tHdDXxAnbw==
X-Received: by 2002:a05:6870:164b:b0:1fa:2bbf:a500 with SMTP id c11-20020a056870164b00b001fa2bbfa500mr6909531oae.24.1701055277451;
        Sun, 26 Nov 2023 19:21:17 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id lm24-20020a0568703d9800b001fa24002089sm1077123oab.30.2023.11.26.19.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 19:21:17 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: gerickson@nuovations.com,
	iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] adhoc: Fix compilation on old systems
Date: Sun, 26 Nov 2023 21:19:55 -0600
Message-ID: <20231127032029.1316478-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

  CC       src/adhoc.o
In file included from src/adhoc.c:28:0:
/usr/include/linux/if.h:234:19: error: field ‘ifru_addr’ has incomplete type
   struct sockaddr ifru_addr;
                   ^
/usr/include/linux/if.h:235:19: error: field ‘ifru_dstaddr’ has incomplete type
   struct sockaddr ifru_dstaddr;
                   ^
/usr/include/linux/if.h:236:19: error: field ‘ifru_broadaddr’ has incomplete type
   struct sockaddr ifru_broadaddr;
                   ^
/usr/include/linux/if.h:237:19: error: field ‘ifru_netmask’ has incomplete type
   struct sockaddr ifru_netmask;
                   ^
/usr/include/linux/if.h:238:20: error: field ‘ifru_hwaddr’ has incomplete type
   struct  sockaddr ifru_hwaddr;
                    ^
---
 src/adhoc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/adhoc.c b/src/adhoc.c
index 2b15f2bd4236..e787dab17ce4 100644
--- a/src/adhoc.c
+++ b/src/adhoc.c
@@ -25,6 +25,7 @@
 #endif
 
 #include <linux/rtnetlink.h>
+#include <sys/socket.h>
 #include <linux/if.h>
 
 #include <ell/ell.h>
-- 
2.42.0

