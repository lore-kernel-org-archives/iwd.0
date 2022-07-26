Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D92538D
	for <iwd@lists.linux.dev>; Tue, 26 Jul 2022 17:09:27 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id g17so13917632plh.2
        for <iwd@lists.linux.dev>; Tue, 26 Jul 2022 10:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7TTyZe83Hk9H7pabp5ySRnmEEzh4iiyvRt7AWb8wgEk=;
        b=bfRbuFuxWvcr7M3qoXlXT+RRk2GrWEL3mDQe0622WSgoO0ieyOXzf4Q2EEdSwxQUve
         uaCLbVXsc32KW2Dxwyo3qoqekKCy6ryrxhJ0TE+2fQ0F9HqooSB3OivkJeDTRkBOSnQz
         o8cc9552Ai0PIQFlsE2fvr+BR24qNMnUcuz4B6eFOQyir07NrX9dyN3OzomvW6bJzJkq
         MkIIheDni7B2idL3UyO4jpijU9QlAiaRt/KQO+KKOcXgLydDbduISkNww3Yz0xOVW99Y
         VoeQOJGLH/PuF2TZfks1ptY30ycBIjCTItF6b52AWrCF/NBK5g8ZSxm7hW1DbTuGYEwS
         lepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7TTyZe83Hk9H7pabp5ySRnmEEzh4iiyvRt7AWb8wgEk=;
        b=iSJTYF/66EJoy4rGQL99N8pwyCB0ED7Mf0UKIQclUq/nc79/Q3JOgMGm9lVm9pGh6i
         GEoafteX1QqYe/EN5LrWVmWIuqFPPb6LYh31gRMRGKwehVegJnKe0H8fc85lYVcnufgn
         wFzKs/gyzSi0GIOGgqDzjpDBAPb1umEhnMObVbWYFa6DLUvjtnjkn5v4HbwajjefF7dD
         CDpfgVy++hFIhHs3qui3QgZab3ByTvu4K0qM+5HID96DP8wJjwTturzjEMWHrXpp50V0
         YjXKtBKb1xG5RZSndepwMIb/Vg5KVnhIZFAoJ1M1oC0WB00vqIWA2Ve0owjxwRG/C5sw
         uAaQ==
X-Gm-Message-State: AJIora+Ow/C4lOL3ix107Zqd3IyXZ5BL/50lA7w3+QdjfJfSkLclu5dj
	ztlcinNsLpnJVlE4EvAUA27L3Wa3FeI=
X-Google-Smtp-Source: AGRyM1tPct5YzQGLYdF5KAnNFGZcwlnkJF1LrVu0NaWWZTMgnt+++E3eCiW1O3euiMYsM6mxfzIuyw==
X-Received: by 2002:a17:90b:1c0b:b0:1f0:23df:5406 with SMTP id oc11-20020a17090b1c0b00b001f023df5406mr168437pjb.157.1658855366844;
        Tue, 26 Jul 2022 10:09:26 -0700 (PDT)
Received: from jprestwo-xps.none (h208-100-169-68.bendor.broadband.dynamic.tds.net. [208.100.169.68])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b0016c09e23b18sm11778694pli.154.2022.07.26.10.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:09:26 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 02/10] test-runner: make developer mode optional
Date: Tue, 26 Jul 2022 10:09:12 -0700
Message-Id: <20220726170920.15929-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220726170920.15929-1-prestwoj@gmail.com>
References: <20220726170920.15929-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IWD can now be started without -E if needed
---
 tools/utils.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/utils.py b/tools/utils.py
index 7a182848..a1b3e041 100644
--- a/tools/utils.py
+++ b/tools/utils.py
@@ -411,7 +411,8 @@ class Namespace:
 
 		self._bus = dbus.bus.BusConnection(address_or_type=self.dbus_address)
 
-	def start_iwd(self, config_dir = '/tmp', storage_dir = '/tmp/iwd'):
+	def start_iwd(self, config_dir = '/tmp', storage_dir = '/tmp/iwd',
+				developer_mode = True):
 		args = []
 		iwd_radios = ','.join([r.name for r in self.radios if r.use == 'iwd'])
 
@@ -420,7 +421,10 @@ class Namespace:
 					'--show-leak-kinds=all',
 					'--log-file=/tmp/valgrind.log.%p'])
 
-		args.extend(['iwd', '-E'])
+		args.append('iwd')
+
+		if developer_mode:
+			args.append('-E')
 
 		if iwd_radios != '':
 			args.extend(['-p', iwd_radios])
-- 
2.34.3

