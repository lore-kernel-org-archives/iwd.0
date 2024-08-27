Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105511C4620
	for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 14:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768513; cv=none; b=M52k0SH8UvTq4MniBCYI7viXoTWUdEfcb3uV5cmUWu9AqlqHpM+7Mayj5NeRhwthDjVzN+gYZfJAu48uu3l2+Zay7NhVs9VTfPqePCI73cetP3o69eWZ0B6nsZQcJKkfdnj0Wwb2pbH0aGMjXs5VNeIvDNg+rsRHyzE9n0lNryk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768513; c=relaxed/simple;
	bh=6HNUUEnnHRseH+mJ0jBWzk/kDTcAwiSPTvdzQkLQF0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KuV3FZ/IrchkU52zvvXD0mpoJ9kF9Nu/fLMPyAbFupubbU8hpsi+oeyFDD11lA4HYQNoghoDeQ+xGz59aZVTObWzgKj5Wjg/+HEbzCnpWARdSa5h7jAfgjIDMsOtzKDtR/SeH4+ZHEbNH9Nu5b2P96QZCRYDyO4LereAhsGcuEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esDxIn/5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esDxIn/5"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2021c03c13aso41826275ad.1
        for <iwd@lists.linux.dev>; Tue, 27 Aug 2024 07:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724768511; x=1725373311; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnS7fbnVMv3giJPDN9VHWSFTfWLIMLUR1CORR/RXiX0=;
        b=esDxIn/5dq6ZBj54k3/SGIkSe3DXZNuiDw7+D6P+6pLdK++qmFbxIqKhngkQVY+nuR
         qHAuHl04YKGT95ZUmIrJc+8tN9oUb+H6nkjwAANZGuCMn6vgZspNgX0fCVj1MO72bqG0
         IgCSuqeF8TmiNJ47dx5MxIWpaPf/0FYmM+2nGTMQ7a8Mlp7wUftSxKZEQsLxXMvOJJEp
         7Od72c828/j70WoPQtkCnLo+8ERIjnM49DNIHFdA+tx8/hnQSKTzc6GOnPU3FzdjzPJ8
         sMc8CMsWhQg5T0mOA1flxp/LAp6sm+d6yfw6wj0zQOdtN2ct3eeponN/42Gfcw76TTOV
         rCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724768511; x=1725373311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnS7fbnVMv3giJPDN9VHWSFTfWLIMLUR1CORR/RXiX0=;
        b=KKAqoXgoQA1sRcLp3AgFjhdn6t+JAVXamquFuDhFl2owQ4fpXGV5c3GQ+GPlS3zJMX
         PeETTX3Bq7KD6b7p21sdkaK7a2ETUhs2a2f9GiZQ9gTJ8Ezw5vRkq9XQPR6TGMVSO4Wa
         eJvZSGUXtETXuext0r3vJcP5VFgfZOt5weLYW2mx8tO59bnQ3AistQ5NU9HBTS45I//z
         J5RWVNHL4hbsFZB3aDYnhmECUhp65yPJJ00RpuXayNIEVw9HE2j7WMMfpoZcInz7zEpE
         Qx8jIXAn5nXQojLVBsb43a+SLGKSmGi2SR9woBSAWbJoIFst9FOOnRsvibVN+r+xEBXM
         vmnQ==
X-Gm-Message-State: AOJu0YzraSQv5s8VIdVMUCNcWxo4fRES8mhXWWbTEO0XdUZqEWkYqmk9
	JilRzCzHqUXKuXU4M2RWLcy18XtEseL82CF4c8SiXdt3F+fab+RalV4NEw==
X-Google-Smtp-Source: AGHT+IE+RsjJmBC4YJKeBY2o2jFfyBqQc20e7oKszHupXZpKseEU2ANm0Keave49Lxjr/+r58BcdeA==
X-Received: by 2002:a17:902:fa0b:b0:202:2f22:2fac with SMTP id d9443c01a7336-204ddccdab7mr34846505ad.8.1724768510993;
        Tue, 27 Aug 2024 07:21:50 -0700 (PDT)
Received: from LOCLAP699.locus-rst-dev-locuspark.locus ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385609099sm83635695ad.192.2024.08.27.07.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:21:50 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 3/4] dpp: allow PKEX configurators to run without multicast RX support
Date: Tue, 27 Aug 2024 07:21:24 -0700
Message-Id: <20240827142125.751023-3-prestwoj@gmail.com>
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

Since IWD enrollees can send unicast frames, a PKEX configurator could
still run without multicast support. Using this combination basically
allows any driver to utilize DPP/PKEX assuming the MAC address can
be communicated using some out of band mechanism.
---
 src/dpp.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/src/dpp.c b/src/dpp.c
index 39b66154..dad74efe 100644
--- a/src/dpp.c
+++ b/src/dpp.c
@@ -4574,11 +4574,9 @@ static struct l_dbus_message *dpp_start_pkex_configurator(struct dpp_sm *dpp,
 				dpp->interface != DPP_INTERFACE_UNBOUND)
 		return dbus_error_busy(message);
 
-	if (!dpp->mcast_support) {
-		l_debug("Multicast frame registration not supported, cannot "
-			"start a configurator");
-		return dbus_error_not_supported(message);
-	}
+	if (!dpp->mcast_support)
+		l_debug("Multicast frame registration not supported, only "
+			"enrollees sending uncast will be supported");
 
 	if (!network || !bss)
 		return dbus_error_not_connected(message);
-- 
2.34.1

