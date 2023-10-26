Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30101156CE
	for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRvz45wN"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-778ac9c898dso95148185a.0
        for <iwd@lists.linux.dev>; Thu, 26 Oct 2023 13:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698352032; x=1698956832; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vspZ3063PT8rLCFF2eW8T+0lR8ve4BKekxoj2RMmcdU=;
        b=QRvz45wN8S4fZ1FxdgqtafrF7CdkD66FWdG6Sdi/3uSTdsTr0YRJUKv1q8+cFghBfM
         MPTcfpaqA8mkuo4kKhlfUnzQbqpesFOKC02s+thSdlhYgBykXn+gECIFNmDupOAjP7u6
         M9viF+a7t1vc2QUHmeLX15Chd6aW9TUO24WwK+f7abkxNEoGYU9BzTzSc9AiVuz2huQo
         q0Zk4nkuN1kBeVof05ilc09Axv+fP0eggLCtmNHVWibVJi+1BUyZCmqVXUBzo64kkHAj
         KH3RGrZnhFNoBswcDlp7sUbN/6NcQ+ry3AES9cMkWAeTU8OGhMOmgoWOgsazcWPW777K
         h0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698352032; x=1698956832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vspZ3063PT8rLCFF2eW8T+0lR8ve4BKekxoj2RMmcdU=;
        b=H8DPGE72PeBHHdZTTtlzYXYN0swg7C2gbyYVZj6bFqx3g1OqLxnq8yCYwIS65OMYu3
         OSXMHoDfc8v8OztDGzHXQlLb+4wezvpey/rKmM7VgOmrethsrRxjMw8VEf5U5syZgoxm
         HggXK9XMk25kwiExI54iS3uGXwbITyvbQMJNHhUqH4hxxI49K5+V/JEkbgiP9QH8ODiR
         Tp5KSKqcI7wDl0OGL8rzgSEVfXqg6VlynFn+qjGBLdbTayhFwdyGAtoUAZEufKuinDUe
         eCBFniYu1ogkBBEpIV2+aXz4Dkt51wHk+iTgbgVJJLpAoxyy+avTlJOVQ9AFFU7IICZz
         Jy/Q==
X-Gm-Message-State: AOJu0YxM+m3xFpwugca149AXNT5X8cNaOrKttN4Tedo/gPIF/pcVJyJl
	zNNJz34BnuxkjeC0Jt7IRpSL82oEnTo=
X-Google-Smtp-Source: AGHT+IGalYTiBJfNrfYmplahbDOR0h0VLo4KW1odU7zT6b+NCTl2WtI37zhf+DiC8JDAbaoChtddMQ==
X-Received: by 2002:a05:620a:2949:b0:76f:1318:d7d1 with SMTP id n9-20020a05620a294900b0076f1318d7d1mr379628qkp.75.1698352031927;
        Thu, 26 Oct 2023 13:27:11 -0700 (PDT)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id r4-20020a05620a298400b007742c2ad7dfsm7303qkp.73.2023.10.26.13.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 13:27:11 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 04/15] dpp: make the protocol timeout more flexible
Date: Thu, 26 Oct 2023 13:26:46 -0700
Message-Id: <20231026202657.183591-5-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026202657.183591-1-prestwoj@gmail.com>
References: <20231026202657.183591-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include a specific timeout value so different protocols can specify
different timeouts. For example once the authentication timeout
should not take very long (even 10 seconds seems excessive) but
adding PKEX may warrant longer timeouts.

For example discovering a configurator IWD may want to wait several
minutes before ending the discovery. Similarly running PKEX as a
configurator we should put a hard limit on the time, but again
minutes rather than 10 seconds.
---
 src/dpp.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index edf5b797..dff0ecaf 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -56,6 +56,7 @@
 
 #define DPP_FRAME_MAX_RETRIES 5
 #define DPP_FRAME_RETRY_TIMEOUT 1
+#define DPP_AUTH_PROTO_TIMEOUT 10
 
 static uint32_t netdev_watch;
 static struct l_genl_family *nl80211;
@@ -488,12 +489,12 @@ static void dpp_protocol_timeout(struct l_timeout *timeout, void *user_data)
 	dpp_reset(dpp);
 }
 
-static void dpp_reset_protocol_timer(struct dpp_sm *dpp)
+static void dpp_reset_protocol_timer(struct dpp_sm *dpp, uint32_t time)
 {
 	if (dpp->timeout)
-		l_timeout_modify(dpp->timeout, 10);
+		l_timeout_modify(dpp->timeout, time);
 	else
-		dpp->timeout = l_timeout_create(10, dpp_protocol_timeout,
+		dpp->timeout = l_timeout_create(time, dpp_protocol_timeout,
 						dpp, NULL);
 }
 
@@ -1316,7 +1317,7 @@ static void authenticate_confirm(struct dpp_sm *dpp, const uint8_t *from,
 
 	l_debug("Authentication successful");
 
-	dpp_reset_protocol_timer(dpp);
+	dpp_reset_protocol_timer(dpp, DPP_AUTH_PROTO_TIMEOUT);
 
 	if (dpp->role == DPP_CAPABILITY_ENROLLEE)
 		dpp_configuration_start(dpp, from);
@@ -1790,7 +1791,7 @@ static void authenticate_request(struct dpp_sm *dpp, const uint8_t *from,
 	memcpy(dpp->peer_addr, from, 6);
 
 	dpp->state = DPP_STATE_AUTHENTICATING;
-	dpp_reset_protocol_timer(dpp);
+	dpp_reset_protocol_timer(dpp, DPP_AUTH_PROTO_TIMEOUT);
 
 	/* Don't send if the frequency is changing */
 	if (!dpp->new_freq)
-- 
2.25.1

