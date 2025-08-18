Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C2723815D
	for <iwd@lists.linux.dev>; Mon, 18 Aug 2025 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527451; cv=none; b=AUTytyWZbVewUGcIZd7diFI716vLO+35/oPhS0qPcB1saudbKniDNqI6/AMni1zqfZrRjoWaX6S2qHGuxU0zoSH+6VSpzLxoAIbFVLBA8BuT/iDh3LK7/F1fOAz7hla6lI6KMqs8UzwbAnX5TDUio46e38nVNeKV18g/o259T+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527451; c=relaxed/simple;
	bh=/SVU+LSZyM37qXKjw8N8K/lt2sahZ1DksE7zIZz7TeM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VELdKJjW/N3z/9FQtbu3me7xuoY5i1gy4sHhFBGeWtyiXFd5n6I30+2IzlJBipOOSHxKTAZjmZbNgmO8oe36liy2aLI97hbxjCWgmgGbCrFPQIoSMOHHACraFCsg2Fr3V/nqQ6Zyagz4xd1ZDBCAlvsoA/ahCVb4cI9/gkmA1Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ddt96BZw; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ddt96BZw"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b121dc259cso19650891cf.1
        for <iwd@lists.linux.dev>; Mon, 18 Aug 2025 07:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755527448; x=1756132248; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nq9cyefCN3AtJdFLPIIEsjhVMplCGGt1dNkEoMLdxxc=;
        b=Ddt96BZwXLL5MAgwsxY76XY2hxXwj47P4ycYuNX6yZaXp8Tu00ztmHrzEThmP10+8p
         VkJ5KgXxypllkIdE7HNALwFo6hmaeKTYSmxp1F7ICB3ffoso0C9DpFoK7QUW7Ldtpq/z
         wkM9C8m/RyfqvFxfYF+mN7NhaaXoZNvgRAL3ha6yVtLOosl8fnMAY3lMjiP2H3PKOUoV
         Xq5zOmrKxBcgCtoMEwqvlNODu5cJQl1Jkcxp0a0Q+64ZyyC5py2rfnzxZl1w0aFhpiBv
         2qFxR+VUxmXoqI9TOvQWAVMQQOTcCYnUJp2p8aZF9K92hfGqq6T32NxjE+ZKq460tHJc
         cHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755527448; x=1756132248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nq9cyefCN3AtJdFLPIIEsjhVMplCGGt1dNkEoMLdxxc=;
        b=NABfMjglplegPubC8X4go/6gTpsIHi6JTNTHXKS6hMEMuP/rBl/72isqpy89oa+1mU
         T7wumDnb2317M22T/S/4nCh7HsyNu3IoYDoh6xUOPRNq03l1DmgWPbmKpSZniodmuB+j
         BoZPmsuA8VcwNsmjIvRJ0weTWwVJNj2bkbV027C46zagsoFtvYy64eXDjVMJzuOMWnAX
         +03dCugq5jjy5M9sEAh0lxTvut7Uc3MAv5t+ZZJgXvGSy2ld9QziS8fbmgSmzYLJtBqx
         PWUq9I9dusnm1/PcO7YbOKM6j9ZMGpyKhWMhA5Xm6HRJzYyrPc5Or6EhR00V1Q2hq/yR
         3yag==
X-Gm-Message-State: AOJu0YzxWlRNTQLwcC9jXnIgVYbrs+2KBuL1TQoHA1iDj4ICL8JZ6FeN
	aMSr8Zt7KY68DePTC6AAyWnF5Gjc6rlz8+Abucw7ct1m3uwGgW/OXDp22CNy1w==
X-Gm-Gg: ASbGncvMVqjq/UPbYah2kIhXFMuqpQguBNSmTX+c/iCwiYpSP8267em9kzo92e6ViFm
	UGzFCEhW+6+DXgi+S07bGZO/Aqzlb/aQletZk11xfNCtpMaVySOx8D7c2fLbZlXK/kie96FJB5y
	KEdk+kehduVtVGpU82WOpc5JAB0QBIOxS8Ie8XbSTh7ykUvCeZMj/scrDX3Vy0eNQPrZIrcZiSr
	pqbPpeHHP8WFSOQa0zAsLPooaCqynOlNwHKaWl/TMsf9J/gCUiHWyJBUdxd9wJnGQyVrNLGHm1c
	NGAOY7RAhIHRqOR4ksnQWO5sXm9KGZCdJ4bbSvwSlcCMGHFZPXLxhlnSuUBFw8EYvKcB1uZ0eCs
	w/3JHXVUiGxETe0RUNTpTKsRxB/FZPO9A
X-Google-Smtp-Source: AGHT+IGgjI22EZyb+OROBwF9rZkz3iNtpnQLSd9I+wF4F3QLabtE9jFY4QpC/TnKj3xoVYEDGbfSbg==
X-Received: by 2002:a05:622a:418d:b0:4af:1bfb:1658 with SMTP id d75a77b69052e-4b11e0a14bamr192404831cf.12.1755527448046;
        Mon, 18 Aug 2025 07:30:48 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc5aeaasm52781531cf.19.2025.08.18.07.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:30:47 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 3/4] auto-t: make waiting for channel switch configurable
Date: Mon, 18 Aug 2025 07:30:40 -0700
Message-Id: <20250818143041.283887-3-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818143041.283887-1-prestwoj@gmail.com>
References: <20250818143041.283887-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 autotests/util/hostapd.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 611d8a63..5db5ef21 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -288,13 +288,15 @@ class HostapdCLI(object):
         cmd = 'RESEND_M3 %s' % address
         self.ctrl_sock.sendall(cmd.encode('utf-8'))
 
-    def chan_switch(self, channel):
+    def chan_switch(self, channel, wait=True):
         if channel > len(chan_freq_map):
             raise Exception("Only 2.4GHz channels supported for chan_switch")
 
         cmd = self.cmdline + ['chan_switch', '50', str(chan_freq_map[channel])]
         ctx.start_process(cmd).wait()
-        self.wait_for_event('AP-CSA-FINISHED')
+
+        if wait:
+            self.wait_for_event('AP-CSA-FINISHED')
 
     def _get_status(self):
         ret = {}
-- 
2.34.1

