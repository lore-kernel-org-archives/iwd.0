Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1B15393
	for <iwd@lists.linux.dev>; Fri,  1 Dec 2023 04:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDsAItis"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-58dd3528497so963853eaf.3
        for <iwd@lists.linux.dev>; Thu, 30 Nov 2023 20:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701403271; x=1702008071; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eILKpuDg7r0TljykUlpQ2QKhq2g0nlqOdwBJvQ0OAA=;
        b=RDsAItisoe6fwprB4FmhaRsCyQqhAxj3bdCnr4RGQWK03Ufs1rmBIfrUa3oSHqjQmO
         GvjfTfBlRpuAR73LKp6gLcqRz07l4givdue5fHelHq6lKTqqfzhzhRrI2AxCJ9nflFi8
         +a+xxnZA0kp3AuqNGggqLngGLLIMZr4HRtT7IDixFV4KcRf85NrXDmDWA8qu15vEMJ0G
         cn2jIGiaZUG7HxAR6PdIsbZQsYUGHwOVGNAsi+IrCfmC6JwspTUt0HhIjfPfDXlzgzi5
         BDcDbS9GBzNkT4xhupwUFjxKOl7WJDtHNfAupDwIbyazgNn6rUWi/rx8W7CjRjekWFyw
         Vyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701403271; x=1702008071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eILKpuDg7r0TljykUlpQ2QKhq2g0nlqOdwBJvQ0OAA=;
        b=KLM5YTFU3ZHSmatA23asQnw5K6JHbrxkoIzI78+yNxSzWEZu6an1KF2RPf6/Sgm/xH
         IWMIEZ0fA1PKN0LJL3EID8Vx64dHL7j/tEECJBKmmBBtwFU5ZnYQJiVSNC5DjWQQiSXU
         F3EoYe3f3KMZz8lyndgIBeSzUEvAOZSjcUyevRkaxzhLz7kmWUSjlxTwNGmYgLGrtRrC
         t3D8r42NMJfsz2VlvExUqPw+dLfEyThAH1NJ2UJa4UcjfmhbPbNfo6NEnA/47PdGAUn5
         ONN21fJr6PjgjhbK9n7WpU2m3LLvcSPlfHXScvoxYvPP5lKNgF3guuIJ/TH3modtJdXj
         JzhA==
X-Gm-Message-State: AOJu0YxohkOWN5eOf+CwEJnHA36yhLgX1ccivMjUKtplYTWE4e+fCf14
	PwbOdVrdHtDQBXnKQFDQXLrUdVnnjFg=
X-Google-Smtp-Source: AGHT+IEmTveNyNfi8Q36Kj1ws+MhVh+fM2KN5hni+eZjimUYfwQMwaMfHq3t6yV1GvlU0o0rENK/LA==
X-Received: by 2002:a05:6820:54e:b0:58d:1fe0:b2a0 with SMTP id n14-20020a056820054e00b0058d1fe0b2a0mr2028039ooj.5.1701403271299;
        Thu, 30 Nov 2023 20:01:11 -0800 (PST)
Received: from localhost.localdomain (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id o3-20020a4ad143000000b0058ab906ae38sm404005oor.2.2023.11.30.20.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 20:01:11 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 3/7] p2p: Simplify cleanup of ies
Date: Thu, 30 Nov 2023 22:00:03 -0600
Message-ID: <20231201040020.161143-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201040020.161143-1-denkenz@gmail.com>
References: <20231201040020.161143-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use an _auto_ variable to cleanup IEs allocated by
p2p_build_association_req().  While here, take out unneeded L_WARN_ON
since p2p_build_association_req cannot fail.
---
 src/p2p.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/src/p2p.c b/src/p2p.c
index c823b2b134dd..b66a45cc0bcd 100644
--- a/src/p2p.c
+++ b/src/p2p.c
@@ -1500,19 +1500,18 @@ static void p2p_try_connect_group(struct p2p_device *dev)
 	struct iovec ie_iov[16];
 	int ie_num = 0;
 	int r;
-	struct p2p_association_req info = {};
+	struct p2p_association_req info = {
+		.capability = dev->capability,
+		.device_info = dev->device_info,
+	};
 	struct ie_rsn_info bss_info = {};
 	struct ie_rsn_info rsn_info = {};
 	uint8_t rsne_buf[256];
 	uint8_t wfd_ie[32];
+	_auto_(l_free) uint8_t *req_ie =
+		p2p_build_association_req(&info, &ie_iov[ie_num].iov_len);
 
-	info.capability = dev->capability;
-	info.device_info = dev->device_info;
-
-	ie_iov[0].iov_base = p2p_build_association_req(&info,
-							&ie_iov[0].iov_len);
-	L_WARN_ON(!ie_iov[0].iov_base);
-	ie_num = 1;
+	ie_iov[ie_num++].iov_base = req_ie;
 
 	if (dev->conn_own_wfd) {
 		ie_iov[ie_num].iov_base = wfd_ie;
@@ -1564,15 +1563,11 @@ static void p2p_try_connect_group(struct p2p_device *dev)
 
 	l_steal_ptr(hs);
 	dev->conn_retry_count++;
-
-done:
-	l_free(ie_iov[0].iov_base);
 	return;
 
 error:
 not_supported:
 	p2p_connect_failed(dev);
-	goto done;
 }
 
 static void p2p_peer_provision_done(int err, struct wsc_credentials_info *creds,
-- 
2.43.0

