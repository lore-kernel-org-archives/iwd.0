Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67351C4620
	for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768515; cv=none; b=kpSLGxqE0Kcwjlf8hL3zuim3MUkRszGthwZ7rBd57hLRYKW6lFg1/scmJYf2dgjIN28nwkyC+bcaH200kjiwn9vL18vW8oDFr0pcjaJewkDIzd7ef7N/k3j/CBzstrQbwAO4e4Qi5jQIz97i1IUIchHMJXwKwhKRLgPG8sN7wBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768515; c=relaxed/simple;
	bh=4OeSd2SPy5Feagw4CT4hsHzqulHO1yry7kR+i7xao00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pjESDarkxfPYcQk8/AINeBETYJKgecn1XsvAt8Qv3DByKqg3I9XyjtBoN+XGIj7EiWBmhvj0s18cvDOwEndLJjjjg95FKm1bY/QtOzp4jGpSTLFvaLi4d4y16npm0yXPexIhaZYMLfUzOsnxKf3FVtGPbxFM0u7iOz8ZEE4y+OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPN1hmKg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPN1hmKg"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-201df0b2df4so45300015ad.0
        for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 07:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724768513; x=1725373313; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mjhiey7NRC+rkwJf+1XNqX2fw39I3dE4iuM5M2DZ80=;
        b=MPN1hmKgFCQLTGcZwgXSa0+bvufT8c+KqVwS1HlWp5UBlY6SSHiAYlvmKe9BnC7iPM
         4IBsJfE6VnKVgTdca4/pKPcP6hftk7u91KYi5CN7UX7NMktyw8DYwBHzUAEGZx7sLZNL
         sZ9OQUciyQtn57JmMVjsMuRVblyuJfpIcb042p62a6NqJNT7ms1LBhZVeAlRrIPm2Sn4
         s6NTJA836CiL8w9hV3vhjp97v/SItnRoxYJSoikvBTceJN+AzIFDDodKwf8FZYTC9f2i
         I5yrCzxW/jZR4+3WYtmuebrpEfkGersW5WiyZR+zNHMB+wx2LpFzW2YM2DM+rVydcpyH
         Fo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724768513; x=1725373313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mjhiey7NRC+rkwJf+1XNqX2fw39I3dE4iuM5M2DZ80=;
        b=ugAWYjqX+5npRmeADHzePlArxc0g81ao0vw/etxYVvix6VAv5jVe4kXuqdaXk9IzdU
         JGvJRibVroS6AZvKamHXJSz5ApZlyHbZQBdwP18/+a8fIEmgO4NJQLHJ48Y4XzbaXBj2
         oVB4GQzS2Te69A7vkb7mZMl8gzrBxoUeI/gB1vYvGJ+Z9jPW3+WKluAg5Ric6R1zK31R
         JkRr0JazRPN7eahpt2cl+gsxRGVn3ZbWA55aYJXw9WsM9/X6u09CAFKR11R6rSavv8k/
         uSrnWD1dMSdCcvOO094/exhM8aAAdj9ylgIuMzecr6eBxUvXjy4ZfLEQzh/Spps2W1mj
         xB7g==
X-Gm-Message-State: AOJu0YwlI39aUIHXZpmIMW4nWweLQwppdCTXUgqYllHSVWfVWpVoC2J6
	VfLxKHQcZ5ekLFnPUJhzGEWfcKbwskl60b0beeI1CPAcOigJfFyY4uJ9iQ==
X-Google-Smtp-Source: AGHT+IEWBenVyJbwsOplsFqWqWNVyKfkHZ5rAzWBDm9UZ85+JA2xfL5DALBxC0ixuHGK4qgxcuwfXA==
X-Received: by 2002:a17:903:2288:b0:203:a134:78ce with SMTP id d9443c01a7336-203a13478ecmr154212565ad.14.1724768512600;
        Tue, 27 Aug 2024 07:21:52 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385609099sm83635695ad.192.2024.08.27.07.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:21:52 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] dpp: scale PKEX timeout by the number of frequencies used
Date: Tue, 27 Aug 2024 07:21:25 -0700
Message-Id: <20240827142125.751023-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827142125.751023-1-prestwoj@gmail.com>
References: <20240827142125.751023-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the number of frequencies used is very small reduce the timeout
to avoid waiting for extended periods of time.
---
 src/dpp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/dpp.c b/src/dpp.c
index dad74efe..5d56456d 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -59,6 +59,7 @@
 #define DPP_FRAME_RETRY_TIMEOUT 1
 #define DPP_AUTH_PROTO_TIMEOUT 10
 #define DPP_PKEX_PROTO_TIMEOUT 120
+#define DPP_PKEX_PROTO_PER_FREQ_TIMEOUT 10
 
 static uint32_t netdev_watch;
 static struct l_genl_family *nl80211;
@@ -4284,7 +4285,8 @@ static void __dpp_pkex_start_enrollee(struct dpp_sm *dpp)
 {
 	dpp->current_freq = dpp->freqs[0];
 
-	dpp_reset_protocol_timer(dpp, DPP_PKEX_PROTO_TIMEOUT);
+	dpp_reset_protocol_timer(dpp,
+			dpp->freqs_len * DPP_PKEX_PROTO_PER_FREQ_TIMEOUT);
 
 	l_debug("PKEX start enrollee (id=%s)", dpp->pkex_id ?: "unset");
 
-- 
2.34.1

