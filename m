Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F054A1D
	for <iwd@lists.linux.dev>; Tue,  9 Aug 2022 23:04:43 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id 130so12078704pfv.13
        for <iwd@lists.linux.dev>; Tue, 09 Aug 2022 16:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZS+9KtQWxdCUZrmdPm4dxJLH4O/1o6nTgSbJ2anXDdk=;
        b=ApBgBdgwukvEtqiBRnmsQkRr3sH1wUtw0vbLrfeUz5BvPlegYAwZzIbVEz6bTZDrge
         EQ4R28hzWtsPdMciiN4ylHE4cApNLUW9OUoS9rg7GFdCSOWe+aGiB6PtTUkoF4p4Xsds
         5KzDXxp2fqczxjwjTxwS+lFZf+Ieana60ZhOqiTIUamGWauAIIF9m5vmhBptfJCd8+JU
         lYOVoL5C0mtjnQSjGk2Nd5QpgQvBN7ohuRkZlmyJVa1PR2MEh6XirvUFHpYHYtPSdiUp
         gZqwDrbItXtYH9vGgLgKngWNUgjfd7ELxQieQjhjpnQRbFQ+MGDR+dyGjdqQdPy8y71C
         z51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZS+9KtQWxdCUZrmdPm4dxJLH4O/1o6nTgSbJ2anXDdk=;
        b=Eta1czmhjbhjUR71k2NvYpASbhqZIBPfZqceqoNMn5xSYaeJyY6ynFP7OeQBW/6l5w
         /wFmeptdv8+N02yAdl97qhKWTKXWzd1u/9Cn6FIC0In7BNuJFmzCeNanRiME3broLLDJ
         l7cQILLOXqHKgVd0WxKm+LuDh2gT+dNX8TPyz5/Xc0mnYOtB4OkjWTdhFSooNTWUaETx
         rkP83q57fO+HhDYym6BQnbMEJaZjxZDN4+M/9ecd207c7J4UAYDeg2VMJEPVmhy8cpvF
         VT6+TBw9K2PAspqXo7VX969gNB1b6Q4x65lQNvksU4pt7P+5krYzxUWyAH0M9VbPNfn3
         yRZg==
X-Gm-Message-State: ACgBeo2SMndo/tgWe7EI9ShB7guX8OaXqIhbSZnexULqBW32P1Yku1ig
	SQMv+umnVv4LFAw+YPI5xT3RaBvyqco=
X-Google-Smtp-Source: AA6agR6KeCb4LNscrsPxGvU5e+xZ3jfz7xAYJ85djK4jwF+p+Q8djoPnbwh61dPUS1s7bzk1NIztVQ==
X-Received: by 2002:a05:6a00:4306:b0:52e:3bdc:2635 with SMTP id cb6-20020a056a00430600b0052e3bdc2635mr24647870pfb.79.1660086282774;
        Tue, 09 Aug 2022 16:04:42 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w13-20020a62820d000000b0052d748498edsm459063pfd.13.2022.08.09.16.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 16:04:42 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>,
	mjohnson459@gmail.com
Subject: [RFC 3/4] auto-t: add generic tx_packet function
Date: Tue,  9 Aug 2022 16:04:27 -0700
Message-Id: <20220809230428.215970-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220809230428.215970-1-prestwoj@gmail.com>
References: <20220809230428.215970-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This sends data over the raw sockets similar to test_ifaces_connected
---
 autotests/util/testutil.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/autotests/util/testutil.py b/autotests/util/testutil.py
index eae4dd89..37de49a2 100644
--- a/autotests/util/testutil.py
+++ b/autotests/util/testutil.py
@@ -53,6 +53,13 @@ def tx(fromsock, tosock, src, dst):
 
     return (frame, fromsock, tosock, src, dst)
 
+def tx_packets(if0, if1, num):
+    sock0, addr0 = raw_if_socket(if0)
+    sock1, addr1 = raw_if_socket(if1)
+
+    for i in range(num):
+        tx(sock0, sock1, addr0, addr1)
+
 def test_connected(if0=None, if1=None, group=True, expect_fail=False):
     if expect_fail:
         timeout = 0
-- 
2.34.3

