Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D617821A16
	for <iwd@lists.linux.dev>; Thu,  4 Jan 2024 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kb1ebcM4"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d98ce84e18so322224b3a.3
        for <iwd@lists.linux.dev>; Thu, 04 Jan 2024 04:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704373109; x=1704977909; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O/2rnn4V2RyAEZn+6QNqE5zq4VgLhMQvJk7CbONn1QI=;
        b=kb1ebcM4vV/ghqH9+7vW/p/UOaZE/t9MJrP4Au6NmwuIiKLB4LH/IjHnRxMxvi1hxw
         CddTsp4QR+ntEG4eDTXD5czoEslu+VaNqbk5MxCAU0dPfEtHvyKmhAd6xj8RYsqgHhDN
         RuZ6Agt4z892FbsyX7OOfFEHOoCLiK00h73nLdAp/5RbSbbJRGBvaf2om0uSNynPhbRx
         hwN64PeZWWmJrqDYv0tc3GB6aC1jKXCv9IeymNIlR4koO05wkzZ+5km5c/lOYjOYw6tt
         I1EAGUu5xuVdVQa9URalDic1dpui8S6hM1+i7iASLx8YnmHOZe6Mpk/jA4sbm2WyEeCx
         6pPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704373109; x=1704977909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/2rnn4V2RyAEZn+6QNqE5zq4VgLhMQvJk7CbONn1QI=;
        b=te/Bme+5O90DIMiU1zUwqPbn0gTqViLOhPNpeuDR0Iv0tx1mVziTXJmGDRbZWDAD2Y
         es7Hl9OaTi1r+pg5QCT8GUFtPhj7bhQlqvoXodxoO+0EH4r5zrM8y26E9N3EODdh2NMk
         S8+WEOc+21WbnzWS+E+xRMmgcUstFotAAt3heReOzHsag2svW7zT8XKCaZGVp8s61UDG
         8q+vf0ajWr3xmANQ6ynSDYdM0EJbsOHU/0hUG+eWLmsh7IMr3z8C8Hj/XjVuhG688aVB
         SnrifxoCFRjSt4trwFHj5ZHtoxASbUGC/kmtyZ2KIop2PsrbB/ZaiYZFqKc98RWyzugk
         O0ag==
X-Gm-Message-State: AOJu0YwEkXIsL/nU64StzV24z8xCIKFNpKDUQlqcFCCbxy6/mNLU2feM
	LVLe0UL2wq77vlRk/mXDMh/Rw8z2MSM=
X-Google-Smtp-Source: AGHT+IGh7ju8RQMp3PYeuI9mPOsyi+RuGt+tp1CINVyMocBcc511i1k4Db3AXWowdhfZXfg4WxmBFg==
X-Received: by 2002:a05:6a20:3c8f:b0:195:2f17:9884 with SMTP id b15-20020a056a203c8f00b001952f179884mr522063pzj.20.1704373108835;
        Thu, 04 Jan 2024 04:58:28 -0800 (PST)
Received: from LOCLAP699.. ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id n10-20020a1709026a8a00b001d3e3704d2fsm25510534plk.31.2024.01.04.04.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 04:58:28 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] monitor: include unistd.h in main.c
Date: Thu,  4 Jan 2024 04:58:26 -0800
Message-Id: <20240104125826.599998-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This fixes a build break on some systems, specifically the
raspberry Pi 3 (ARM):

monitor/main.c: In function ‘open_packet’:
monitor/main.c:176:3: error: implicit declaration of function ‘close’; did you mean ‘pclose’? [-Werror=implicit-function-declaration]
  176 |   close(fd);
      |   ^~~~~
      |   pclose
---
 monitor/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/main.c b/monitor/main.c
index e9384e1b..8f354d52 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -32,6 +32,7 @@
 #include <string.h>
 #include <getopt.h>
 #include <signal.h>
+#include <unistd.h>
 #include <arpa/inet.h>
 #include <sys/socket.h>
 #include <linux/genetlink.h>
-- 
2.34.1

