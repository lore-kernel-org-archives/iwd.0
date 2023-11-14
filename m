Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45724122F
	for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zd0EfSQT"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1dd71c0a41fso3436421fac.2
        for <iwd@lists.linux.dev>; Tue, 14 Nov 2023 09:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699982146; x=1700586946; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwojZLotuMnxVmeffT7lcFhT/Z1mjEG2j1MhEx5cyu8=;
        b=Zd0EfSQTVpdGCnCHv7VEgrcYkyg57LrAy1YCtH/MtwHwtwyaBrI8stXy4tlilXnm9H
         FzUxsVBuXuMuWFgBs4ClugNNXHucFaKrPafoC/2R0153p37OfvMBcadEihUXsIY2sb0W
         nETUcsJIYM9HqL3Xfn87AVZXNAwvNCU6toRH+Q7W4R2nc73kNb25yLY+KaECgy+ac6fl
         k7fbDh3T5Io7WzPMBerEhELa4Uf44Pa+ra4m5h6cRAiDWdINZeXLAOWOYFBUmlA+S73y
         32ljWunROE/0/LdgK6UNbRYt07cgZHNHLK57x7qkM40ROxvaTKGJWLouCKexooMP1pp0
         cfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699982146; x=1700586946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwojZLotuMnxVmeffT7lcFhT/Z1mjEG2j1MhEx5cyu8=;
        b=SKht0jB4s0SO9CSEqe3Qy7aAa61mbtuwNnwfYx08Kbd0YoJEKy3pgY8aFnSLTLu7n5
         /HEfK23ZLZ/OTso/1QYiI//R7v4WF+tK3mmWTWqEwjnWHmI26jOHBas9y4UnJsKtbhu/
         w9l+90vMTnk0HSjC6C11SlFED8W/w7zZqZvYkfWMz1crDz/WrgV1fWC3r10hGnKgvPyK
         M7l5zV7db3tmypSFJGQxKCIlq967Bamm5sFA8hZ8W56w8BGXptf9y+IwpdJ9HbpcbmmQ
         HJADF15YArs8WY49h9llOOhNRqHV4Ilt9CXyTN8i9Y+5kPnAJf8GOFMJ2r9TzwxUyG4k
         Wpow==
X-Gm-Message-State: AOJu0Ywo2RBq4dPfGo5cFFgW7hoWI7SybIdaaK6zdRX3vH5tvxmwbXqy
	jupeUM5euDNFuZQ5oz8B3UlyDLvCOTg=
X-Google-Smtp-Source: AGHT+IGloXYulKt7TfvdzsYzi314aCg0RKv0o9ysXx3+iHWOHk4wyDggA565z7x2RYYWbhPPKmrcsQ==
X-Received: by 2002:a05:6870:160d:b0:1f4:dac9:75a8 with SMTP id b13-20020a056870160d00b001f4dac975a8mr12099727oae.10.1699982146391;
        Tue, 14 Nov 2023 09:15:46 -0800 (PST)
Received: from localhost.localdomain (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id o4-20020a05687072c400b001e9a253afa3sm1429647oak.49.2023.11.14.09.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 09:15:45 -0800 (PST)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 03/11] netdev: Use CMD_DISCONNECT if OCI fails
Date: Tue, 14 Nov 2023 11:14:26 -0600
Message-ID: <20231114171455.1108856-3-denkenz@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231114171455.1108856-1-denkenz@gmail.com>
References: <20231114171455.1108856-1-denkenz@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If netdev_get_oci fails, a goto deauth is invoked in order to terminate
the current connection and return an error to the caller.  Unfortunately
the deauth label builds CMD_DEAUTHENTICATE in order to terminate the
connection.  This was fine because it used to handle authentication
protocols that ran over CMD_AUTHENTICATE and CMD_ASSOCIATE.  However,
OCI can also be used on FullMAC hardware that does not support them.
Use CMD_DISCONNECT instead which works everywhere.

Fixes: 06482b811626 ("netdev: Obtain operating channel info")
---
 src/netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/netdev.c b/src/netdev.c
index 72876f3a39a1..ebb93a74d8aa 100644
--- a/src/netdev.c
+++ b/src/netdev.c
@@ -2989,7 +2989,7 @@ error:
 deauth:
 	netdev->result = NETDEV_RESULT_ASSOCIATION_FAILED;
 	netdev->last_code = MMPDU_STATUS_CODE_UNSPECIFIED;
-	msg = netdev_build_cmd_deauthenticate(netdev,
+	msg = netdev_build_cmd_disconnect(netdev,
 						MMPDU_REASON_CODE_UNSPECIFIED);
 	netdev->disconnect_cmd_id = l_genl_family_send(nl80211,
 							msg,
-- 
2.42.0

