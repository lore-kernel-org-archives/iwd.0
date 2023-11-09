Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F134EC8
	for <iwd@lists.linux.dev>; Thu,  9 Nov 2023 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l50e4ln6"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6c34e87b571so1049311b3a.3
        for <iwd@lists.linux.dev>; Thu, 09 Nov 2023 09:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699550725; x=1700155525; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wOXuh2XSirOrfLhzwWK02owvuoRe4FvcVlqafjNjriU=;
        b=l50e4ln63j71J5MVnlQ7pIx9kvat0Ttiu3e9tVMV1j4vvX55GBxR7nFUbW/P95s1JC
         xfNDNiszsxyZHr+aMDQLAhRohj69SxMIe5sJL7qVoDEJAjn5a91G37bC/CYD5ew9ere8
         3XfsRiKHjETdU//WCDuscvauLCZXdEeCRqd8bqqY3yU6UinD3MeVcvEhODkPWgDAdjkt
         bP9DO7NYgQfn7nvL3s6a7qregUDoRRxJjnAKyqzhRr4WlJWDC5oRUhOG3lpN4699ln8E
         NzWaJQpRUWaC7F1Z/VlJqUT3TBxXdqhOLO0lXGkpy+ihgPwC9uTPeXKUPFRYu3yiGoy/
         0Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699550725; x=1700155525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOXuh2XSirOrfLhzwWK02owvuoRe4FvcVlqafjNjriU=;
        b=kgkwEWdlJ83m/d8OIrURgUscHhdtK7qnJeys+edUGp2lmHhDLbHVzV61kouZzaZ0PK
         fii5h84fCj5IRBOwhfZxWEDBtXoiUgGfUeIQzC4Qkn9Jy+qi8ghBmHnurmHurFvpkI16
         zcozAoKlUJ/CSIXZw42qsXQT0A+4ZSNQ8zjUdgm0Cl+hBCRo83AM3ICAj/wh0GfSYNFC
         jpbHmd+PLxhffMydWrgIOhRTpH6r2WjDkbi9fnb55tiO4INjJn1vkBztYCiarGVseR/G
         xCRALNjPqsEBZzPk988b04ew66d8d+89r8qVMWGazXujRX9Hjy3qyjiQm/vzzlVvFMV7
         PlHg==
X-Gm-Message-State: AOJu0YxVG/ErUOsFeb28uyqSOmeEvy8kWw02Ug5B8jlhv4XrTT5wIC6/
	WIMgN+Nnz3IFmmdOCoVlmUijZDR3XlI=
X-Google-Smtp-Source: AGHT+IE/PMCf4KszMXForNazLlo8yxdklcK6zOTAhQ5+8JUY6c6rf2unoe3LGp/5yCwo0XJ6KWXylw==
X-Received: by 2002:a05:6a00:3a2a:b0:6c3:41fd:3a3e with SMTP id fj42-20020a056a003a2a00b006c341fd3a3emr5276233pfb.27.1699550725535;
        Thu, 09 Nov 2023 09:25:25 -0800 (PST)
Received: from localhost.localdomain ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id u8-20020aa78388000000b0068fe5a5a566sm11301447pfm.142.2023.11.09.09.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 09:25:25 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] dpp: fix removed dpp_reset in Stop()
Date: Thu,  9 Nov 2023 09:25:22 -0800
Message-Id: <20231109172522.37912-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It seems in my patch reordering both stop methods lost the actual
call to dpp_reset().
---
 src/dpp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/dpp.c b/src/dpp.c
index a0c44eda..9501f3de 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -3961,9 +3961,13 @@ static struct l_dbus_message *dpp_dbus_stop(struct l_dbus *dbus,
 {
 	struct dpp_sm *dpp = user_data;
 
+	l_debug("");
+
 	if (dpp->interface != DPP_INTERFACE_DPP)
 		return dbus_error_not_found(message);
 
+	dpp_reset(dpp);
+
 	return l_dbus_message_new_method_return(message);
 }
 
@@ -4340,9 +4344,13 @@ static struct l_dbus_message *dpp_dbus_pkex_stop(struct l_dbus *dbus,
 {
 	struct dpp_sm *dpp = user_data;
 
+	l_debug("");
+
 	if (dpp->interface != DPP_INTERFACE_PKEX)
 		return dbus_error_not_found(message);
 
+	dpp_reset(dpp);
+
 	return l_dbus_message_new_method_return(message);
 }
 
-- 
2.25.1

