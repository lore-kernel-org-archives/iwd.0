Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28860446D4
	for <iwd@lists.linux.dev>; Fri,  1 Mar 2024 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709322072; cv=none; b=jFoQtl3Fn7qHDqWauisNy3bvyMHcw4Y6tzLgHmcIKKezZ8JY6aKBnk2isU3eJxAGT+rtHrxy+HPOj3Bt8TTuXoeDAGe8meVu1trPejQa4Q04BH1LD9+dzG4UjQs1DmtXqd1madq8ufTlLbcJO1rDU9pp4aCMgEJ5C//Awf/8IxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709322072; c=relaxed/simple;
	bh=IrMXSSBU4q+UOaoaVo6htH/yA890MkDVySfSVyoY4C8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PITpo5UFPmTutqCrUUGMAcwt9LQqRgqMt/oKsQfZ98q4d+DvgsUUe0Rd+k6iJWfyfm2vxdMVthziVSIXwx98oDkTYYcQ3Qd25VLYKGcbXSVn69ncOp5+EMF/V7f80iNohi9ntj1VuOcI1FQec2FYx3uHcPq7/4wNiYDbbUoVXFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIxBwn9g; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIxBwn9g"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-690578e13c4so4329106d6.1
        for <iwd@lists.linux.dev>; Fri, 01 Mar 2024 11:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709322069; x=1709926869; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ch8xBl/1eTrSRKSodBfPGgMORBECf4wGZT+guCwsCvo=;
        b=SIxBwn9gysIBXaWOcCI00Jz9Y1TcW57z1umB0xEXH+luo2liQ6jHnwi0HmSvwQwYfY
         rzkZYxI+dOsk9ifqTufcIfP6x3WH2Vc/5YlvV89FnW/jAOe6HQL/e9Tnx5pVReMSihcj
         K6Z4tMCE81YzT8jZxG98JO+Lc10gTbyDPLeDqTf97P48sYWluIqQq32p5rnZA7MrlirH
         C8acI0LAZBRXboFszn7oHQBme8whDK4T0dMgpAA8PiVz2a+O8KUq5KJWhiy5Z7uxBZbt
         38ka9j9FtJV/adIbnRzyyNKoraMWPs20OmJ4ZKq5gr2lXzOV5Y7jiq+3FU5jp60Hce8A
         Wvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709322069; x=1709926869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ch8xBl/1eTrSRKSodBfPGgMORBECf4wGZT+guCwsCvo=;
        b=egfR3y9ckYP+Hr4DQCYw3h8b6JeFfYSJZUiEWmAcpVBPJuOkViB/hu7LWSiBi/Mk2M
         o5p1vgFlXHVpxIzBpt/tcVQoFqv1kRAoU2lNHWgQErueFB9cjgTHoQcBXAVejpskbyZJ
         greasPcuUPeSofjsSDGLh1DK5wayHt0Darw91OWvdYne0v9Fccdw5mqQHTMpWLl+Lrdz
         chSsEMF37USQ0b8CmOdsIPm4t9nskzynHMeTGpS6aRCosUY7Bsbs2lxSPfviCkxiIdVs
         IwYZISGAUcJ+L2oC8bopOGdrWFjm81iXplWV2cczJRtEIpnZDhePy+lHLOtCYPFYzInX
         7bMA==
X-Gm-Message-State: AOJu0YzJ9rCuyX4c2yr60v1m+tO8DcOhKGBMebOBsTV53Tg+6ILPA0tk
	TG8CXrrebPFoREmXuv9ONf3JmXgn/xp9iBv6lkW8gcT8HcCiUmi5bA1555ym
X-Google-Smtp-Source: AGHT+IE+Drckh7z0aA0RPRPABRk8GKZxQkroCwxcIzK2zkrdcW9g1kHbrZY1hrdYNczeCUX22/dyqQ==
X-Received: by 2002:ad4:4f13:0:b0:68f:e46b:47f with SMTP id fb19-20020ad44f13000000b0068fe46b047fmr2482142qvb.17.1709322068779;
        Fri, 01 Mar 2024 11:41:08 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id mu4-20020a056214328400b0068fd10638c0sm2162397qvb.20.2024.03.01.11.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 11:41:08 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/4] client: fix two issues caught by static analysis
Date: Fri,  1 Mar 2024 11:40:56 -0800
Message-Id: <20240301194056.1665549-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301194056.1665549-1-prestwoj@gmail.com>
References: <20240301194056.1665549-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 - va_end was not being called on an error condition
 - An uninitialized struct was being accessed if ioctl failed
---
 client/display.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/client/display.c b/client/display.c
index 64125934..83214c86 100644
--- a/client/display.c
+++ b/client/display.c
@@ -230,7 +230,8 @@ static void display_refresh_check_feasibility(void)
 {
 	const struct winsize ws;
 
-	ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws);
+	if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws) < 0)
+		return;
 
 	if (ws.ws_col < LINE_LEN - 1) {
 		if (display_refresh.enabled) {
@@ -564,8 +565,6 @@ void display_table_row(const char *margin, unsigned int ncolumns, ...)
 		str += entry_append(e, str);
 	}
 
-	va_end(va);
-
 	display("%s\n", buf);
 	str = buf;
 
@@ -591,6 +590,8 @@ void display_table_row(const char *margin, unsigned int ncolumns, ...)
 	}
 
 done:
+	va_end(va);
+
 	for (i = 0; i < ncolumns; i++) {
 		if (entries[i].color)
 			l_free(entries[i].color);
-- 
2.34.1

