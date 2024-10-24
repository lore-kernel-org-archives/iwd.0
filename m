Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79291D9A49
	for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729788405; cv=none; b=hGqs9giAmLsWsac/qraqks7Elpodxxfds78fp+PK1iYcxCbd6OSZX1ZwVZdL7shvnSOt3z43T1ySC2Gq0larmygko/y6RbcWXUopECp3jYozMsJDXBtRl7nd228jn5gXDBop0O7HpVxJFqwo+dhJ3Fb6ESBnIjlYWkn0nL5cT+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729788405; c=relaxed/simple;
	bh=hu+iBkHF+G2LcA7qhUm9vgvbIUqTExPESbJJeNgdxHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ewlmE2LX3CPwea7iBu1x0Yzb03iYh682485320l4HgTpd5TdamUO4htC6yDny8qlSMtuk38+wvJ2R+Hy9FSLnvDP2GK9u53C19JHBoIUEf17dHuF+YbNldX2y7bIiFf4t9X68wBUb/EDu/6KG2gJ9NFsAzBDWwEl/NY69yiansA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAmA4uyt; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAmA4uyt"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5ebc349204cso604483eaf.3
        for <iwd@lists.linux.dev>; Thu, 24 Oct 2024 09:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729788402; x=1730393202; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bG0HBg2wVgGue8OUx9KsA7YxbRb+qvZfore06uaKbXg=;
        b=EAmA4uytH6Q730cTatz7MiMRmaMHtNuGwxU411ThaTmoNqv7+kyt6hHRVXJgrUHR9r
         r/8emBeWI4gmWwgUAIdaRN3tcxpx/ydpVoyvk1NqYK9Cs7rhXoSokHCZpcQ6fvi7xrC5
         n+w2cQegFJ15fAiS8sauRGEyYz3FWzjoIaVQI/ddjYdEKlpiZwtCRJ8ZyqltHN+iwWMd
         RTqSI9hSreE/N0KAFGnqXy7f56j7EtPCE+Wucf3fxIrisYb1AnbmNW1i9uA95RJfni6L
         zNo0pqYKhingdHhxOROwX6EnpzOHWqzp0a+YVvAoL9i9YiPA0lsWSRcuF0heu/wX5Kav
         wvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729788402; x=1730393202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bG0HBg2wVgGue8OUx9KsA7YxbRb+qvZfore06uaKbXg=;
        b=D3CYVtXmWlF9wBZ8Rvfra7UvXPWaAyydNDWXXh1Q90ooZggXXW9zgm0Gpwp1PgCRr1
         GnJk5HZU9P8vK22lOGGibvsOLxBFHL9KtiBxKHUfL/rbX/jVGBuJJDWHmeN8AJVaUD00
         S0JhZgVO3tIajvlywsGsMktdJCp4DZdUH0bOKp6jgbhDUpDSuj1OfhLlfY22xJh0Lzy9
         ZZ8PJZ/wa1orMnoe6VZvT7cCyhCKEg9NcWNgUQKaAhdFAZuXaHxHwcwPhwIuW51dENq8
         uUyK0a0g/ZcBpro2Hmy0pAoEOADh6neeSkExyERH7AZ3ty64jXGR2Mqqf/kAkwQLjoyi
         unZA==
X-Gm-Message-State: AOJu0Yxbbn8/hTZ57eR8p1SJzz0pKokwWsA3JRDS0l3f0VBh2Ofw/u8g
	gXx5Qyd6H86qwfnRw3J4Qx6eeQfcozKEFFTbRMjoLNu/S2ctiRm5XxoqTQ==
X-Google-Smtp-Source: AGHT+IFzkkIt9tiU/4W9dxZFUBtiMAepEwsCxDr+HIE0d+SPSV8SILHPW+wKu2ZWgxYmNxUBOPmVcg==
X-Received: by 2002:a05:6359:4589:b0:1c3:7cbf:f124 with SMTP id e5c5f4694b2df-1c3d81b4757mr500132055d.24.1729788402563;
        Thu, 24 Oct 2024 09:46:42 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4611a19be2csm16893901cf.70.2024.10.24.09.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 09:46:42 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/5] scan: warn on zero frequency when adding to request
Date: Thu, 24 Oct 2024 09:46:34 -0700
Message-Id: <20241024164635.176631-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024164635.176631-1-prestwoj@gmail.com>
References: <20241024164635.176631-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This shouldn't ever happen, but if it does we want to alert the user.
---
 src/scan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/scan.c b/src/scan.c
index 2ffbef6d..c1ccc234 100644
--- a/src/scan.c
+++ b/src/scan.c
@@ -292,6 +292,9 @@ static void scan_freq_append(uint32_t freq, void *user_data)
 {
 	struct scan_freq_append_data *data = user_data;
 
+	if (L_WARN_ON(!freq))
+		return;
+
 	l_genl_msg_append_attr(data->msg, data->count++, 4, &freq);
 }
 
-- 
2.34.1

