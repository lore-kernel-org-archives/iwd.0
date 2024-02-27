Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4277339BC
	for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058865; cv=none; b=IqoCzwAKt8tJyjy86jQ5w0hvsLzreYG+tUB26w/YdSD5twySzmLJRlQt7vLo46B26gzEqSYCjukjXvJ9q3Sl5dQXLWF7VR/9aTsZC0UVSxbNI6lPKyF6+xYOxPh7ZvWEL/CPaUSJpL5uJ90YkQ9hOgP5O2flY8yicPoL+34F3rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058865; c=relaxed/simple;
	bh=hxuOAU7yZ4d/QaaxY5YH52JxNDXskqN1t1jBqT4UNss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h9F8SWm+u0vYQS1IXCROntJAB/wMReFZYr3BPP8dsoFar8spD8JYKWA4P42PZEUxiIUtU39+XSa19CozDJT+yEOrcDploabpsohShGPlwpNI13hzirCRlFr1B6b82qm5lpywO0rksGq9v0OYGPEQCmGDX/zH168FK32lg5iJa40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbMmubah; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbMmubah"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42e8758fd52so11535321cf.1
        for <iwd@lists.linux.dev>; Tue, 27 Feb 2024 10:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709058862; x=1709663662; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8e+d9Q0M78PZG4a7n45cz1GrVJxFpOQPG69Nd2dcQS8=;
        b=EbMmubahux1M9s9d7cjoYjvtjDaUwbtnX1LYHWCWApGXfsKe5vFJgZ+msIeXKqkN5e
         8cJIjciJX4UqBrXPjl8WJ859tVuzymkUyVq12syY8gPaJGRzP0s5pTp+VYvjP6US7W1m
         Kw/L4AKlMLJZNLnmj9u9Z6DH1fBCpiN6IzFGpZBaTjuvoysCCW5wFkrK3eaoTIN5uJ6B
         SFZkMUjrEIUx6xdTNT1iUspoRtn0wrzCYaTU6UdNokJu6JRq9I17IU8pzo26PzZL/aPf
         MuCM8N5s7oiChDcbYTWdlSAEwg32jSmV3r4mn9P34dltF67BuJOZscdnw3zf5FXYMaGg
         GbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709058862; x=1709663662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8e+d9Q0M78PZG4a7n45cz1GrVJxFpOQPG69Nd2dcQS8=;
        b=kExbZMyyb7fW2XLVCrlsy+rICIeHl4UpjO/aTEUMh7Nm7Yi+cwc2XreTwlo5Kw681s
         7ctA9rh3kekF9aexuyJf32Jv1yeyEIwGN9wJob313k/Wk/Mq9mJdg7VgiB79LZaW1sx2
         r/vCW6xKMBu9INIRIUjgZ363EpUOU4t+x6f8ATlgHfY/rDsdndZ2W7QMpphmgVq15BuG
         7i80tWF0bj7fRMpfWrluBviOdkm4760AEQGKo/j21fbMiajsuuRsrduUfexX1ScukTX0
         YhkjAGIYS+r5hit0SdjGI9/StpAAqQIfrhgYBdmKy0j1ZW1ryG7MGU1eaGGtpdY1j5u+
         lhpA==
X-Gm-Message-State: AOJu0YxbryOi5FlnSfU/wzuHC5XpVN6K+B5Iw0P/U8owsxjkXRwg7e3a
	KB+XHhgcXS6mqqg8Wp26xXcR52oPa+7NW2+FyMCD8MJqmDfbDw0ykz78bFbf
X-Google-Smtp-Source: AGHT+IHIDDiUGUUtEj2K99vKj15j8H6E9LUjJQZdf+bKGdyBItUSjqRj1oy0RJHmxw5wMSGEz82T/w==
X-Received: by 2002:ac8:5c4c:0:b0:42e:a842:d9dc with SMTP id j12-20020ac85c4c000000b0042ea842d9dcmr448191qtj.65.1709058862112;
        Tue, 27 Feb 2024 10:34:22 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id jy2-20020a05622a818200b0042e3468a98csm3819617qtb.4.2024.02.27.10.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:34:21 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 01/11] doc: Document UseDefaultEccGroup
Date: Tue, 27 Feb 2024 10:33:55 -0800
Message-Id: <20240227183405.257206-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.network.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index 734dcfa1..b178c20c 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -174,6 +174,13 @@ The group ``[Settings]`` contains general settings.
        Properly configured Access Points will typically update this setting
        appropriately via Transition Disable indications.  User customization
        of this value is thus typically not required.
+   * - UseDefaultEccGroup
+     - Values: true, false
+
+       Forces the use of the default ECC group (19) for protocols using ECC
+       (WPA3 and OWE) if set true. If unset IWD will learn the capabilities of
+       the network based on its initial association and retain that setting for
+       the duration of its process lifetime.
 
 Network Authentication Settings
 -------------------------------
-- 
2.34.1

