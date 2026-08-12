Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B363402B99
	for <iwd@lists.linux.dev>; Wed, 12 Aug 2026 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526279; cv=none; b=Hj7GdgBh3Eyn3IBvFQ+WVYPBUU4TKISfW6PYXZ4jJennUGASNm7xrLdqVmQd7aFoQXi7xmiXyUHwFJSZrZQ/5ZYGuR/a6lJZtnhSTTlHEmCzp6B1dSSJ0Mw0UPa06MqC63aC9GKLf+RvykOlWv4jJjlHKF8Y0wLFj8HzBWxLYZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526279; c=relaxed/simple;
	bh=T09zQp9qsyadxXrx7ixn8I9YvZGBIn0AwhxZW3+EQNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnYgks8JGgKdOkmiOXSbpAKVx4I4xCY7I+JEgdwL9tKwGWomfiIQ/s/0itHKNRbp4LGDrR4s4M6tBZCo+eLc4jqIxFMSvZ+iC1eb+bXRwrRcHcxZuJFVzhVdYyczEMLG/hBexSHBfPhbD7p7bH9aXILV1scg+wSXxHLFGNV6BF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=axKGS0FS; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="axKGS0FS"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b01910b499so662315e87.0
        for <iwd@lists.linux.dev>; Wed, 12 Aug 2026 02:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786526276; x=1787131076; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cdXPIxQi8QufPC0VjF3WPT6L/oAcXZpj39XK0cBRPck=;
        b=axKGS0FSyzwO7BEl/LC0v9wT5BtDLiAgH6kZA02BfULGaspxgFlJcZKKov6bptAz5l
         aFv4JZZ0r0+GqIZlof7HupRUfSq774joWY2gIxdJnm/LmMsDEHEwkRM18E0GCmfSTAk7
         zPPMfUHRvn1T2lCkjRlKWumfWNiQcHoqoHT9ZzvqUW63eBJl6/sHWKOBZ095QDsA2Snc
         riluUKv8L6xeLMvDzUpX77q1zjWOzBMj8RCjDOBaBMUAytZVjVD4al2vuMRtf9gC+TCV
         N8CfBX6jt4aaEKE+WthoAy4ImbLltKwDJVcruTkifIbphVqShqfq21HUheOFOFt2IDLQ
         ETiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786526276; x=1787131076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cdXPIxQi8QufPC0VjF3WPT6L/oAcXZpj39XK0cBRPck=;
        b=Hca3hfqDOhbs2bpmxZG0N8aEKnbaR4XfxcGjHyHBctSxDyD4i/lPf8sqBGRgVnnVLV
         3289rCu6ri0bEzvT1tPLFMvZHPl+Kb904RID12Rs17mFW0g9r/feF9vCfpb9S4vCxrMu
         lGaJ8dBzylIBLxyfPCXxKryqJa51tUf85jvmWb15aveN/JrP5BAwNN330Hqs1Ju+Hvqa
         pkYYs8y6+AHkQBWebVFj54lmjUphNSy/DzzLgT/WktX2dwX1ntwg+nEtbiX903IT32CE
         j5DLzfHLav40vFLuuM0nOPeksGZ04gG4gQBxn9EpmHbNw2+18qA/lKc8b0qJAXSamMCe
         4QIA==
X-Gm-Message-State: AOJu0YzXG2K+3d4J3qZgcn7MPM329G/mW7aW7Nj0GExwGQaegdWvf8Qj
	ucBXsLh/vdGsowfqc6odXhoyf54G5R4ERmijbNBp+tTJ80IiOz8nWvjCsOAVcnkE
X-Gm-Gg: AR+sD12ZqCbPP+ru3kNGVmffK7h0h+NuQVu3DjYyWXYDncJEvrBQjgD3mjyQ8Bcps4i
	0bFfjhfh6CGO6IXRXG5XvCgefMGpbWDi16xd9g5HCn30T8QWb5dcYlh7cjc2wKI2ejvgG0yzJHl
	zicF4uSFaLOutIOaKD+q1s/blsh9qakWSxMh76HQqJ9CeI/qO67iOkNMNwQhlzD7FsZMgBemzxP
	a9Anl/LYr/63RaFh/pFLS/zO3FJYKDm4QtDstC0k0iEob+O5EsXYwU4JnoPqVzZqIbzIyhv/+zV
	zD16upsqyu5Gob+M0BkTArMek1Xq0jFYm84dn2eS4LZnYJhHtjZ032emoRxs1TiXSk7GWSbOMlc
	/aMCKk35grMjsFpiQ6LzfY7Yp++UIuJiuFty7SgSQ7AHyA/uXfGQ919gVdMrsdWbJUYJKlj/9xo
	dHR9WtENebG25sqPbjkTaCgdwA0iMbfN65r4KDXQf2TqnphmIZOJlhakSX/DNwPTckBAzeuY8bl
	ESJHhE42/Ys
X-Received: by 2002:a05:6512:159b:b0:5b2:aad1:7dc2 with SMTP id 2adb3069b0e04-5b44e958d14mr631858e87.21.1786526276013;
        Wed, 12 Aug 2026 02:17:56 -0700 (PDT)
Received: from aai01 (dtuguest20.nat.net.dtu.dk. [130.226.71.20])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b44d024cfesm370474e87.45.2026.08.12.02.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 02:17:55 -0700 (PDT)
From: Inti Manuel Yabar-Pagaza <intimyp@gmail.com>
To: iwd@lists.linux.dev
Cc: Inti Manuel Yabar-Pagaza <intimyp@gmail.com>
Subject: [PATCH 1/2] client: fix double free in agent prompts
Date: Wed, 12 Aug 2026 11:16:51 +0200
Message-ID: <b0cd1601613af65b70fee70a50ef5e8272eda171.1786525748.git.intimyp@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1786525748.git.intimyp@gmail.com>
References: <cover.1786525748.git.intimyp@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

display_agent_prompt_release() destroys the stdin l_io but leaves the
file-static pointer set. Both creation sites are guarded by "if (!io)",
so it is never recreated and any later use touches freed memory.

RequestUserNameAndPassword is the only request that prompts twice, so
the password prompt installs a read handler on the destroyed io. The
input is never read and no reply is sent, and the Cancel handler or the
exit path then destroys the same io again:

  free(): double free detected in tcache 2

Clear the pointer at both destroy sites. l_io_destroy(NULL) is a no-op.

Fixes: df32279a31c3 ("client: Enable non-interactive mode support for agent prompts")
---
 client/display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/client/display.c b/client/display.c
index f0f3282a..103e4769 100644
--- a/client/display.c
+++ b/client/display.c
@@ -860,6 +860,7 @@ void display_agent_prompt_release(const char *label)
 	if (!command_is_interactive_mode()) {
 		rl_callback_handler_remove();
 		l_io_destroy(io);
+		io = NULL;
 
 		return;
 	}
@@ -975,6 +976,7 @@ void display_exit(void)
 	rl_callback_handler_remove();
 
 	l_io_destroy(io);
+	io = NULL;
 
 	l_signal_remove(window_change_signal);
 
-- 
2.55.0

