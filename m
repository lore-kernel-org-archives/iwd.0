Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C628917C64
	for <iwd@lists.linux.dev>; Mon,  5 Aug 2024 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866846; cv=none; b=cra6VPJWLDQ4BvXJ62NoE1HVbnqQubTZ1wSWDE75SIT/zjIjGT5DxI/4MLNZtNFFjFVZeQXapXmnCdDnqLxdUrQN7v3bOOgBFjoq+D7X3pql53oeldEkPR8IbXV7ZoUfFtcIL73v5pNuoaPQTIUjFGoE4jHcH8/91BwQ96T+Hs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866846; c=relaxed/simple;
	bh=TnJhlZSQZlCY+Nb7XxT0I3c6X9S6tgop07v2aJ5bqcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZe87HaISCf2sAlheNvplRB0AQJ/TJ3O0pW3mOlaon5/MtXMJ9HAxE7YnHQ0nYIBTvBTlY/PnDz55HKeLQtspEFZpYNO2U7vOZ0RZJEarhUlwTUWGLUd8sA/j6xO3ltCpcsI6t3aSB3dWkyGL2BjKL56OnCUTLpKrlyY2DSsDHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3/VXJh8; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3/VXJh8"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3db22c02a42so6617804b6e.3
        for <iwd@lists.linux.dev>; Mon, 05 Aug 2024 07:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722866843; x=1723471643; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rfFQn81mZNNz2E0CwmNrnW9XEkdWldOBKCwP10Xe/Ac=;
        b=a3/VXJh8TKH0HcPfOX6ZZlbP3frevJJgO4DaMAJO9MUwHOhb6p8nOeBTvTNAVDRVgk
         sgyWnfIH4/beT0JwEgJHtsmOIBhBG0G2GQ/+cDfoJ1wBwRhayDgegpXg7tuNkCKxDyeb
         KFmmEHJmVVd6+P+aH8Fo6bodO6a+vSHSQckwcyb+Ep/ebHwR/FcurkeDZLycHulItc4D
         ynLqcScWmQO2U5znTlvrsmKErqYQmT42h9MVeAXmfbaYuI8kCT9t2YfCChKAuwjnuY0L
         TUjV7DxZjOFHXgAObwxd3fg5zY5MpkUCQSLWpd19BTG0GR/zOwAjSHDznKXkRmiWHpka
         OGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722866843; x=1723471643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfFQn81mZNNz2E0CwmNrnW9XEkdWldOBKCwP10Xe/Ac=;
        b=XIOr+6xFP20u6X3Yg9cMF9CzseULkIxzSgG65TNxsa+g85Xt6d5+AU30OWBjfC86QM
         DJvGSFXi1cj9uUj7yIZK8jpct4p2OKq8yOE/Ir0OGbeAOS/ZZerui9+57eHa7QEYWce7
         USb5XIMSu/lPbPP4WjxVDPqWXEwlUd2dAfjMGUf/JoelXuAGK6IP0sBelLn8tbiSiJVe
         xeRRSA8fAKyrKuRKcZMXsP/g221DTOFiVshjUypKIbYRbEqjeERk0Xn1AWpgtnomi+FG
         W16nOEgTTtPgwE7ST0s0EQhig2REz0H6MBj+cdMHp58a7lWUaSE9ufCKB8fBeQWQv8ct
         wVDA==
X-Gm-Message-State: AOJu0YwAcOGRINJtMhzZAvS6qAX7HlBvzli/LC7UT6BEd7/S2FiNlADc
	K8brNVEavWgfD4cVR7Od6knDTwL6+a59B+iBajLTLrBrW5Ex+OQXfGu2xw==
X-Google-Smtp-Source: AGHT+IEvFjRXPABHmBjBKNS+fzPaWjAjTh1hMpJ2Lb3thjfUwrcoCSxd0sGcMbU/DP61LJax0la/XA==
X-Received: by 2002:a05:6808:1308:b0:3db:19b9:1e39 with SMTP id 5614622812f47-3db5583fd74mr12488891b6e.50.1722866843632;
        Mon, 05 Aug 2024 07:07:23 -0700 (PDT)
Received: from archdev.attlocal.net (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db56361a88sm2654172b6e.4.2024.08.05.07.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 07:07:23 -0700 (PDT)
From: Denis Kenzior <denkenz@gmail.com>
To: iwd@lists.linux.dev
Cc: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH 1/7] monitor: Decode RMNet Mux Identifier
Date: Mon,  5 Aug 2024 09:07:08 -0500
Message-ID: <20240805140721.57518-1-denkenz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 monitor/nlmon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/monitor/nlmon.c b/monitor/nlmon.c
index e5cd545173ce..941992595412 100644
--- a/monitor/nlmon.c
+++ b/monitor/nlmon.c
@@ -7597,8 +7597,15 @@ static void flags_str(const struct flag_names *table,
 	pos += sprintf(str + pos, "]");
 }
 
+static struct attr_entry link_info_data_entry[] = {
+	{ IFLA_RMNET_MUX_ID,	"RMNet Mux Id",		ATTR_U16 },
+	{ },
+};
+
 static struct attr_entry link_info_entry[] = {
 	{ IFLA_INFO_KIND,	"Kind",		ATTR_STRING },
+	{ IFLA_INFO_DATA,	"Info Data",
+				ATTR_NESTED, { link_info_data_entry } },
 	{ },
 };
 
-- 
2.45.2

