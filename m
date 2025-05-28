Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54DC220F28
	for <iwd@lists.linux.dev>; Wed, 28 May 2025 20:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748463039; cv=none; b=ECTwpHLl/zZuCfsSmV3cPUJyXvXPRDZ4JVA1nTmFsz8XXUE70CjXqvpuAxrW5d9jIOoAMwvKRhskBw1KlqeJF2ny2on3B3FoI/u39OA/bn1D8VC5xA9FhnJN6YnjG4fUavddsmFBfZc4sebCyMx6aLTF7BAWqz+PoNELhE2FMQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748463039; c=relaxed/simple;
	bh=dZCvA/a/03VY/kq3gu/YvXXCePhS9Fh0fCDmCfQk5dg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j2xKuE/NvYXdJu5P1bPawsg0vVmzky/iR5YNWyuVnlfjKOgYm4zEzIqaSxleFZgBH/vg5Bo0biIGvj0Y5wu0WXyLGQlz8U4fHQZkbvF1fJMhhcyATkGoMSZ4RWsgAwMB9UTiIqk3bqB9A2PlzBLYWas1WDtAk6HQ37fbwsC5QK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jzwp+I4b; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jzwp+I4b"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6f0c30a1cb6so2184436d6.2
        for <iwd@lists.linux.dev>; Wed, 28 May 2025 13:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748463036; x=1749067836; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylI4BCyghuNBCan9O+SAOrBDWcVrDMZll5egBnK/PV0=;
        b=Jzwp+I4bWb7J+CtPNFEgscbyKCRNDCFkXPYclxQBgFdHHxTpueRI4lC1p7BaYnxl1N
         uZcMGfNQnsLMxaQpjfMg8m5efbmRBEDp6KaXve/1BQYDLpj5zDm4In376J5kxGz3DJBt
         rAwUbzxucroShtYubl6P2Rhhw/Wb+o8vTSBL8q9YmI7kNpy5ZOkTXbduhRAN2OhMjlGE
         ATyd8v4DXtwwnmeB6l+dBYLyzxb/mxM5nyw9QGPKavl5/7Z/viRw61h72tMZslkexVAR
         pP7hbsi1Qnd9utE1ixkJ8imk3mGHKAaHVrvzO/O8MFsC+FIEw4Ae+UOKgPTlEp/uoWiY
         ylyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748463036; x=1749067836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylI4BCyghuNBCan9O+SAOrBDWcVrDMZll5egBnK/PV0=;
        b=VHYts2tzKuWFXuhZtVSIF0NUtJ4JDmL8Eqy7YYqb0ijeuo3fVTLNjTrMSj/zrrl8GA
         DMUyCUouxx7ojydgqY/JlfC5rVSXiAeR4NqtspCqRMfGYj4vUAW63OFpYfttV3bFHhov
         SF8QlTNp9APkFZPKcJe3ix0qAG626Cubjl9pD1b3zoQIuUkLzCdyjQWY0lHJHegcs+lG
         xSslBUTmXjJNlzVm5sN1IXsOk1dtA12WkjYSqFE63HJptM/g9e5G7k8/+xYuOFCtt4kz
         xH/37Xfpvg+tqHG4X61hQpe4rbGa1bnGErUyIZhaPuq26aCiP20mtNIAvatTufZEKsfv
         /ILA==
X-Gm-Message-State: AOJu0YwIyjFQkwSA2+G7TMk1PCKRQrqdqUjA8uVvN7qRzdXROlrAuWDT
	4VLitpIYrYzqRLcc2DJ3FGajEyAmX44h7hys5h7aks50MSmjHFDQqgyUndHa7w==
X-Gm-Gg: ASbGncvWT6croKEwadZf4ztFbeuLv6EGG5X+Kg7cJQqzJffbBVC8nKmv8If6/9nSEMM
	THApiEhSnMw/7AGffan7e2BBzjcm7emC7lqkL+bc/bvG55Pl/QofH/hRtkbARBIf5B9Exc/+fUh
	ul/By7GSEiQDdEN55SBEejY5/r5X8jHG/e5U3lfJkuBcPA0bq5SLvRXolUJd/3zapmvvFvjACMG
	7xRMxFeeHIAHKCbW0gALM5IQ9GiBlalZWdEnzGkN8yOlGFxxRE5XLcr0rx+o3xmuPWYdunI9SlB
	7jRvWHiAuYc+pVoqqRQTK3OxbNynWSo/0xpwzq6sE7X2AQRmMU1S00jdU0C4fA==
X-Google-Smtp-Source: AGHT+IGWqTg3y8AJH5Ok6VM5oaQRzhO+W09eYWG/IVWOytLYOV6CDeaV07X0uUJY059wYRJaX5RhrA==
X-Received: by 2002:a05:6214:e86:b0:6fa:c5be:daca with SMTP id 6a1803df08f44-6fac5beee6cmr23636736d6.7.1748463036232;
        Wed, 28 May 2025 13:10:36 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac0b2888asm10408126d6.45.2025.05.28.13.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 13:10:35 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 6/6] doc: add note about timeouts to Network.Connect()
Date: Wed, 28 May 2025 13:10:26 -0700
Message-Id: <20250528201026.598221-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250528201026.598221-1-prestwoj@gmail.com>
References: <20250528201026.598221-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since netconfig is now part of the Connect() call from a DBus
perspective add a note indicating that this method has the potential
to take a very long time if there are issues with DHCP.
---
 doc/network-api.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/network-api.txt b/doc/network-api.txt
index 8bc6eea6..d96fcede 100644
--- a/doc/network-api.txt
+++ b/doc/network-api.txt
@@ -11,6 +11,12 @@ Methods		void Connect()
 			the object path to connect to specified network.
 			Connecting to WEP networks is not supported.
 
+			Note: When [General].EnableNetworkConfiguration is set
+			to true a call to Connect() has the potential to take
+			a significant amount of time. Specifically if DHCP is
+			either slow, or is unable to complete. The timeout for
+			DHCP is roughly 30 seconds per BSS.
+
 			Possible errors: net.connman.iwd.Aborted
 					 net.connman.iwd.Busy
 					 net.connman.iwd.Failed
-- 
2.34.1

