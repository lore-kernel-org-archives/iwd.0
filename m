Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028D8D2E4
	for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 22:58:03 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f9b4a71623so8288935e9.1
        for <iwd@lists.linux.dev>; Mon, 19 Jun 2023 15:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687215482; x=1689807482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0lYLqzByAZTJFEn/TlsLOYNelhZstoZ7vdHZpy3xS4=;
        b=owVlbh3IDKmWBkqfIGPMX8U16LWo736nMtKqVwiZ2rrd6WSTiyzqpitDB5DXwkAuiC
         5z5oQHcF0zEg3svEt5zbH2u8dPI8zVoBbALuqK2plJdeADivbMctsqur7WqEMr+NV+wK
         VVc96k2rInmNfmz4XTy95ZhU62tYWHKx3W9ldhV1xC9/b6kPSJg6HaUo2uHDqWtU1jOK
         w0wbvocRXYZ3TMtAHqctg+uhCqGP6DCBX7ZwaKZ50LnrknTwVgdN2W4J5dSJ00TL0SyO
         +cC8C+u9g016tjdQQ2oB6DVEwxy3KgSZNpWJWvoNHQEzR83m3ikEU4EMyt4mRp8NE0q5
         P6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687215482; x=1689807482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0lYLqzByAZTJFEn/TlsLOYNelhZstoZ7vdHZpy3xS4=;
        b=TY80ln0Z2veZVg1bKm5zJZ4B9QJi8v9GxCOUq6bm2/Xp1A0MT0JyYzPsebZUxCTH6E
         BOduOLlEzog2IdY0PeNB9qQhrRlq6oRyvMlWEYGJAgx2FYSNunybFajIIf2l0MEkpRYP
         QUxYGMxoM2GOOjWjwJM2gIpiRuM6A+xZyhN8b3/J8YxeCam2B5F5NeGasBFMfAuqqgB7
         t+gtbczhg4eLRd5hdQowF57P9KUffy/mwYyANxd+h5VgongZMPjgeXcyOMFppI2UPk6j
         FWvz6kcIcTmXc5UmFXyqnv/PQRJrFRhf3p6tmDj7koS7enfcq9vwqvgjAUM71NWjMaEB
         RA0g==
X-Gm-Message-State: AC+VfDyyHevqG2+tIyFIC6v+VPVAIt1oXCk/4cUvpbt2bHFsT7zMIAtK
	VR/STv3KvepaMoIoMbeF9mtwLGaurLoyTQ==
X-Google-Smtp-Source: ACHHUZ7oZbp10iVlaGM8B3sYDSeQH65MRY5NCLuzBfrdPURpyPqcQRJwTTsLE7egVXSrA5CIGYfKQg==
X-Received: by 2002:a05:600c:3797:b0:3f8:f749:efae with SMTP id o23-20020a05600c379700b003f8f749efaemr6935732wmr.33.1687215481878;
        Mon, 19 Jun 2023 15:58:01 -0700 (PDT)
Received: from LOCLAP699.dhl-toledo.locus ([195.55.200.178])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d4c8b000000b0030c4d8930b1sm571946wrs.91.2023.06.19.15.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 15:58:01 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 6/6] auto-t: fix testNetconfig lease parsing
Date: Mon, 19 Jun 2023 15:57:46 -0700
Message-Id: <20230619225746.462791-6-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619225746.462791-1-prestwoj@gmail.com>
References: <20230619225746.462791-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The parsing code was breaking out of the loop on the first comment
which is incorrect and causes only part of the file to be parsed.
Its odd this hasn't popped up until now but its likely due to
differing dhcpd versions, some which add comments and others that
do not.
---
 autotests/testNetconfig/connection_test.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autotests/testNetconfig/connection_test.py b/autotests/testNetconfig/connection_test.py
index cf90993a..aed35bee 100644
--- a/autotests/testNetconfig/connection_test.py
+++ b/autotests/testNetconfig/connection_test.py
@@ -276,7 +276,7 @@ class Test(unittest.TestCase):
                 elif quote or ch not in ' \t\r\n;{}#':
                     token += ch
                 if ch == '#':
-                    break
+                    continue
                 elif ch == '{':
                     stack.append([])
                 elif ch == '}':
-- 
2.25.1

