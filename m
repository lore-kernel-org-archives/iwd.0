Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A7521771A
	for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744824846; cv=none; b=VWxFzjyBAORvsrUwtzLu2mAJd0NVyl25eIFpspSqY371VfEZZTrRlGSg04IGpBAFh/RND2x8gn86EN2viL8jogVUmZHE/2DbKH9FTOOtBLl01N9el6F5yzha6TLGyVRAthv3pdIqKvjKGIADFugNKCYjyhL/Btg4Gn5CD/s8yi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744824846; c=relaxed/simple;
	bh=Z/nnC3Cna9IjTUAuozv/F8ig8MhOQ8SqtqNjC2iO7O0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eB5f4AQ0HVygXqQulcm0zwnj22wZxDKSmsw2f3FTpw8Mqg/3S5AshCoG3p1oOi/Nd6Nt4xckaFUp48D1Krd+DoW04Ydr2ygSjpd/zWumvGEIZIA90CV971oUDa4GBmS8oOrVRNSG/oB3R/yDdBMZbbZ8JfeCy/qOKW/FUm5RrzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEv7kN0O; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEv7kN0O"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-225477548e1so70815125ad.0
        for <iwd@lists.linux.dev>; Wed, 16 Apr 2025 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744824844; x=1745429644; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjBN5rmIkSQZwddzlU59QQ2kd5YCP3q9EwonR82BCAs=;
        b=cEv7kN0Oi5kygFTpnIhSfwGrkcPhi+w0cS7I7mQYRyyW6wQKaQOBBqRW+nfiKn81Pd
         06XdWDwiIWojyeLIEzkXaO9CotemkpRecXfPD0ADFT2nyS6EbZEuVifKl7+kE/XNj6hX
         shNyDOEtv20iFr2yFQWVpIqJtDWBS41uBAY+wIz3KFvzbq52TVEm3qwKs25p4HbK7oup
         GkW20WHCFfQCFGWUv0W1YIswO/RYrgwQ7k8Y7l/g31T1H8se8XwVhOfgJPpP1FFtc0Ui
         M+UJtykQPll36Dix7FZ7WT2jyzqDVJuNq1Ni42uO3lUH6yQx6pxbyw3MuS8Jb/uBGoZA
         KXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744824844; x=1745429644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjBN5rmIkSQZwddzlU59QQ2kd5YCP3q9EwonR82BCAs=;
        b=HJ2rYLApH4KfMFl5d4ZjOZzNveNUgwKmvJUiGizt2PcpNxwiXX3h+DD0DebtY+e011
         OHydcL4t2NQZahPCBZqlhEVxl+HCVZS/4DDR2DEKAZZPRiGTSWEK2NoYggIM+El9tEVX
         yMTyn83jEv+QGTlIUcXScBbpu1q4FJKhhjk4814Rj7ieTls7JQwp59VZHNYfLLMFZ2At
         PAEUdKmHPTPC4bBkKhY2VubH+XGbPoDHgE0gwbqQnNjhJ2sL8HG4/38unmI2boQzMIIE
         1rtm/uOEeV1C4drepxKA/2bt+1N7EojucjHaRxRD7HRTc8MlirHE/IF+gRZ4yl2kxui/
         uj4w==
X-Gm-Message-State: AOJu0Yy/4OirhBgN/SXX6E85IQ/L+Ne5maYNibyfw4I6srI1jH8qaAIp
	cn5fmsqCN+c1kDpMJKmt1C09sdWrZFe9DIy35SlGgjU4QeRYzUuNRwM9IQ==
X-Gm-Gg: ASbGnctD/tw44xeGdJ9Z9GijPWVD7ZsktGbrvJH6ycx7OXWbu1PBNMYuFlve6dYo5kQ
	MV5/pbyM9+x/7WbLtkmO4rBXVxNjzN8ErsGK+g/qtRDI0Df3Ho5VTovKI8cWXTSCGwcynt0IexL
	fk7WOvt5m9jwKw1KR7aOO8N1uZrNbkwjRbgSLHdYk3fqZO589DBjJnHyVqDGf2RKB0KepdPqJs3
	I8CnsbAT8EYovtOe2PxViDQLvk8mFIr01gPadxbxZSm4+hIjM7KbqHmpkH9E3JjkzuwmFFxhaoG
	yu4dGH1ncwpjWcn2cvSeOZT2ZCcKCA1AAVfQepLeoQjAwAumDPQ=
X-Google-Smtp-Source: AGHT+IGRZuhxYKeel5xoy2b335x0iadkStx7lOasoVp630iUhyUd05maxYln+Hrty3ImfMc+fKBmwA==
X-Received: by 2002:a17:902:e810:b0:220:cb1a:da5 with SMTP id d9443c01a7336-22c3595df17mr44775005ad.40.1744824844582;
        Wed, 16 Apr 2025 10:34:04 -0700 (PDT)
Received: from LOCLAP699.localdomain ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1cd56sm17093055ad.83.2025.04.16.10.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:34:04 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 9/9] eap-mschapv2: Fix leak of state->user on error path
Date: Wed, 16 Apr 2025 10:33:45 -0700
Message-Id: <20250416173345.136025-9-prestwoj@gmail.com>
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

Fixes: 6dc5d2c3 ("eap-mschapv2: Load credentials obtained from agent")
---
 src/eap-mschapv2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/eap-mschapv2.c b/src/eap-mschapv2.c
index 1639f578..00976d73 100644
--- a/src/eap-mschapv2.c
+++ b/src/eap-mschapv2.c
@@ -544,7 +544,8 @@ static bool eap_mschapv2_load_settings(struct eap_state *eap,
 	return true;
 
 error:
-	free(state);
+	l_free(state->user);
+	l_free(state);
 	return false;
 }
 
-- 
2.34.1

