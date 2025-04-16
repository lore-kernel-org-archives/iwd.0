Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ED621771A
	for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824845; cv=none; b=UX2NqZvPEzQE1zeIpqrIQU6MZaXU7GhQD0uUQHFj3sdESr7QGXbVcmXeAINtdery93Ym1sUBsxviiMzQgdPXQCaNFXxxzRvNTZtWcUQqeOnoiI5FeiC7g8HHaV8HS424fKaQCnQol2zS8HaisvdxO3mmcFBv5iWg1zS1pWKF2V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824845; c=relaxed/simple;
	bh=I1HXDgiQZ0EO58Hzj5K5E5s9AyUwL0HBp2nvmphEAss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cZryEouBzlGckk0p5OV2q+s7w17K6Oawvwq3++kGp7N6gLUBtxfzXiB47rx0JZxbZwKUMgrm14FFeB0oL05MYIzQrQKVEQorpvPrL0gUTtKTu0GIgN5ri8kOtLEX94Zyjl7HbOEGI6PtyC49Ayc5s9UryWyO+yrxw4Ikd3pJvxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ilD5qq9q; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilD5qq9q"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2279915e06eso77762995ad.1
        for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 10:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744824843; x=1745429643; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdmR46fR1q/2NLqiayvrSdUK4+coqayyHe5vqaWROL0=;
        b=ilD5qq9qRtPxYQSbFkU6X2Q8kAxRNgWjDK+4Bdh4gxd1Jtm4WnAOKm0WSjY0OyW6Xc
         OqyUXw4jA88iwJkDbxL6NZSSpkZ3iqP2IaEHD6Qse3TZD2Y0JOtdP8zSJ6+wv44TDT5m
         0wbtAIW5vZxN+VYnxH1td8lS93787ccu8gWNfhysiqXkUyN+jz5ZW2NztUB/TmHWXJcJ
         4lFe8K7EVrSYWc6JKoUvDBXVkeufsKwXwCQqA/NNuTY4JfqkbxHteynqHikiL7CH4dlg
         FdMv18qPkkN+uvg4j6TXyeDbq41nHwnnIA3SgIxrkHdj/kArk9Jkm28612V5ik9q320X
         Ajog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744824843; x=1745429643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hdmR46fR1q/2NLqiayvrSdUK4+coqayyHe5vqaWROL0=;
        b=Y/O2pTIvVijEEKK4AK5eToGotZVMo5xsPJ3vlI0BIEhMpfdoFG9SStdfwKTrWhH4kv
         GlRA0+LG33z308G/m/mWLG7mZTG4MN0jiu8tFBMO4RSEDhqRvQ3EMm34NwEcdqc5mYbx
         cUDP1k4tMChsUG2f5OLrB9BYTWHzlGfvNeige/eh9mXs7bCAasK9mLS+mECdNCRXInWi
         Ocpcz88/sjqs4BtUZ2eswsBjTP+Q9hFd4RgoRU6/HoGOaDpuagLEBAp9Rnsm4ElgOXj7
         588G7n671UD2fmRprkPOnj+xR1MBBDAsj3k4ywye+sbF1OPb96j2lpd+EqldEk/UcGqC
         RvXQ==
X-Gm-Message-State: AOJu0YyIdvghvk/BD1VFqWUo6imTC3Cw23NGAaojv+EqY3md9fMc1m10
	1dreqEKk/bXTyzdXxTg1izwb7pshxnz/QBIzZKejBSSm5Mu285BTGpybJA==
X-Gm-Gg: ASbGncvAqW+GkeQYWBBmlUON6wkyFa4WgjVn3OEotppbFEXEi9zoP6+l3Dnus/Ljq2Y
	2i5sh+OZPJMdWSW1mTfCA6EXrq6kG/iYiAt+o0x4uL9S6cYkmY5w8kEEXVzhYy8HLoMdcyMDYwT
	cbw2m2O0lhZ9mIfMRg31qN3FKoc3gFPUOrFn4dzSs50mD//iIEPTw+KUBEhMjIE0K5fgUGsbqGN
	nLIgb4akQlGw3AhGH51dQnvp7GyQ7wjJtiQ+AyvK/Ig4yC4HMu1EBW45ixGuFn333fPyHQLWdYN
	XU5TzoF3ae9Xo2kwTT9OwOpvkFjcCg5Yjkhw5EgSu1KzObGM+FA=
X-Google-Smtp-Source: AGHT+IHObPcgwcZgJJaVuY+mEPrWxjuwKLz3BM990h3xoue7XA35rv0sNlbYYfXZaTxaO6eVKT/9JQ==
X-Received: by 2002:a17:903:3202:b0:21f:988d:5756 with SMTP id d9443c01a7336-22c3596b8d1mr46043135ad.42.1744824842898;
        Wed, 16 Apr 2025 10:34:02 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1cd56sm17093055ad.83.2025.04.16.10.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:34:02 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 8/9] station: check return when advancing iterator
Date: Wed, 16 Apr 2025 10:33:44 -0700
Message-Id: <20250416173345.136025-8-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416173345.136025-1-prestwoj@gmail.com>
References: <20250416173345.136025-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: f4ec1ee5 ("station: add Affinities DBus property")
---
 src/station.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index 9972ea76..14c93671 100644
--- a/src/station.c
+++ b/src/station.c
@@ -4836,7 +4836,8 @@ static struct l_dbus_message *station_property_set_affinities(
 		return dbus_error_invalid_args(message);
 
 	/* Get first entry, there should be only one */
-	l_dbus_message_iter_next_entry(&array, &new_path);
+	if (!l_dbus_message_iter_next_entry(&array, &new_path))
+		return dbus_error_invalid_args(message);
 
 	if (l_dbus_message_iter_next_entry(&array, &new_path))
 		return dbus_error_invalid_args(message);
-- 
2.34.1

