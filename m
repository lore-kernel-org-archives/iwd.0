Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E364486AFA
	for <iwd@lists.linux.dev>; Fri, 12 Jul 2024 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720801872; cv=none; b=uiMH0boCq52NFWWCRlWzpUe/lw/D9OLRiNCVsAm33su7+FzvW1SAIME9DeE2WvtInjuFyshs18SiwgLYceQF3oBO6saEG9cRP5cQDF+VSShYc6lPMPRhM1ZWFM1FdhAmvmnxk+OQV8kpe6CUglA/vaaqFS2nmMuZy/OGQyCrJjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720801872; c=relaxed/simple;
	bh=wMQZwd0kijRta11by/h13ptnB9sJofcJ5eL/EkgPaLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mWdSTmKMNE/8iQOjfgNUFqddAHiEPes2cR9Z4IC6uTqRJ8afCQWQhdSSy2uEy8GHALhRUhM2qEk2ACEJimwkTx5mt2j1ci4oaHfIuhhxAh5H+NmuJ5/jac/BLFOnaQz6tftMJ7t1lFTkb+IbtLuKDFwNOEW3JtS2f8S3SBk991M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com; spf=pass smtp.mailfrom=getcruise.com; dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b=a78rOyI/; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=getcruise.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getcruise.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getcruise.com header.i=@getcruise.com header.b="a78rOyI/"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-79f083f5cb6so130546585a.3
        for <iwd@lists.linux.dev>; Fri, 12 Jul 2024 09:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getcruise.com; s=google; t=1720801869; x=1721406669; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vXJ4FW4MhB+xJaezk+LLHIHZAbbkJot+ITDY9QeClBE=;
        b=a78rOyI/IbwLlbV8lBAGG80ycxz9WilK/xcoYlpCTA5WrlW1Z/qdawqSJZjU5n3ZHo
         vbPxM64zU7ibN1NYfJTG7EWgtcoERopQE2kZlySKLuawzB/yZgKEi80mSziJNY8nJV9q
         0q/fxnJ8FDQbsH+KNEh9//i53HtNP8kxUG57JAugqtZ3byzJZJQVLmIcUGV7OZJBQBX7
         qwSO48ZrqXtF7bWwYI1ZtKouIjfe0SH7pOx9GCb7CXcziaPICL0WouUdyh/5DOWG7xk0
         ZhHp7WIv7GpHqCcYepa+iqEcXPWhWWqKLv/Pg5E17RUy1vJBTz7ZYgUaXzPLusEosMQe
         rZsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720801869; x=1721406669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vXJ4FW4MhB+xJaezk+LLHIHZAbbkJot+ITDY9QeClBE=;
        b=bRLps98M5o/xUDu59j/fgL2F3ei5bbcK3Auj2fh6r7hhhiV/Nkhe/wweCmkwJbS9FD
         MYOkakHACGW8ek4opPDMW+VOnAmItv/llFDSpWT4FnG3pMOKMooSgJLqLR6RKj+4D45k
         OtKIAu73X9YxM46zavkiYb3XJQ+rpZvjvBXck5GKt5KKXwY8S15g+lXf+CyciGFhzYuu
         4EDq/YNVxOu/NaXhTA0jTVfI2cBULpAwDyfiECq0e/EP7YtnioerX9Rsa7KFkqi2BNsk
         Ev1HeAnEaeCyTyS6FUC/zVQzWyKgApjioTBovda4m3vcW74jfTUJtXTjpMHpm2eQhV60
         jmfw==
X-Gm-Message-State: AOJu0YzGzsb9xDG8f0sVE/OwyXgckhAWXk0sYGmTXnwRJJrqL9Q4SnKM
	IOMN0gojPLCjFApDAh+Fq860AAnamJYBuQo3YgE8OqsoG30ixP+KHO3qWS3THFRuGLyUPoahSkq
	lYzrU8d6Mw81YYPbrwRVukX+WeAfivyNWV9YoECkJF/JrkbuKLSAj4qow+FZoDK+S4tukR2lcE7
	Z98HIJd+I5zYwG8wc3M3kJWW7wEoWNjCl9qimuUbvyODM=
X-Google-Smtp-Source: AGHT+IGt+wdm4sbo7UP9osjU22buZpvT1+l1qtla+RCNVhMyS7mBz20CM9WClUl9n0/AR6MyfMdVTw==
X-Received: by 2002:a05:620a:470b:b0:79f:1559:272e with SMTP id af79cd13be357-79f19ae387dmr1596816685a.61.1720801868679;
        Fri, 12 Jul 2024 09:31:08 -0700 (PDT)
Received: from localhost.localdomain ([140.177.191.129])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f19028ab0sm415943185a.64.2024.07.12.09.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 09:31:08 -0700 (PDT)
From: Steve Schrock <steve.schrock@getcruise.com>
To: iwd@lists.linux.dev
Cc: Steve Schrock <steve.schrock@getcruise.com>
Subject: [PATCH] main: update usage with logger option
Date: Fri, 12 Jul 2024 16:29:39 +0000
Message-ID: <20240712162954.23746-1-steve.schrock@getcruise.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/main.c b/src/main.c
index 93d4e87c653a..beaf228fb3cd 100644
--- a/src/main.c
+++ b/src/main.c
@@ -154,6 +154,7 @@ static void usage(void)
 		"\t-p, --phys             Phys to manage\n"
 		"\t-P, --nophys           Phys to ignore\n"
 		"\t-d, --debug            Enable debug output\n"
+		"\t-l, --logger           Override default stderr logging\n"
 		"\t-v, --version          Show version\n"
 		"\t-h, --help             Show help options\n");
 }
-- 
2.43.0

