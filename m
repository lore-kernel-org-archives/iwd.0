Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F87833E8
	for <iwd@lists.linux.dev>; Tue,  2 May 2023 19:00:00 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7516d97a63aso228332985a.1
        for <iwd@lists.linux.dev>; Tue, 02 May 2023 12:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683053999; x=1685645999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JXnrqrJ+LOcq76P8sT+HALF5r6txP4K+F2+peVzXGjU=;
        b=EGsLqz5ke7uqCtV1cNQy1R4jP4cjZD7xVqaVTCUsciUizlRB+XK99L4v6stnlIDzXb
         iHwAUgW2LRBAU/bjzX0pV5lCFKdhMMfDoTVJ6MlRzupKbXVti8HWu31XuCDs8w3V9gfC
         hzNT+v+I+ElRn3v2Xv8EBj0LOFVjGg+Uxqe6N/8XIkCSQH6TvISRITOEeymzVg1PtFW5
         2pIXL+uO+YHlfGmTaZW6PF3VA1vxhaYGVfYVUPiDz8L55Jg9ogvLrzWB5YmQG1wkMbm4
         yo+CQLif5Akro8VjP5p8T3NG5VtuDLO42OgZsz8tre/nTWR/NTdULtMOv81dlpNDmpW3
         9gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683053999; x=1685645999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXnrqrJ+LOcq76P8sT+HALF5r6txP4K+F2+peVzXGjU=;
        b=cRBZwtXxVL0omW46yyDk9iOmEMNTEcn9H12PEvknB/eox3RdKVzBhIY/OjTmwN0ZNF
         qcUVe9jq9S4hrI8Hcsfz6KO5rSbzPg6CyP8oVWjI4n07Z2gPixCcLc8dFu7M9z3Cs46r
         rJ1dzFw4s2F6j2MrK65WoZUxlrXLuE9B4g1Rf2zzUsaFcYPY/noJVyAyJBqLiOIOdrU/
         6Vr4M6DUe+QrDOTtmubEXjWvKa/c3q4RHHyVEgQb6VsLD5ltmNuLy7PLavdjUAJCnWyt
         fPSAGb/a/prQdhCmowsOhMqCRXP41EzA1q4wrtr0FNh3KvQUS1yxmsCEaUt8UrSmuent
         Gd6g==
X-Gm-Message-State: AC+VfDzi8HMVQBr1Uvhix6NrmdeCMAP1ZOM9j4W2hoFdQlC7f+TMZ5Na
	FmGzBUUBlcAjyseZ+5b8z/Ee4UIEdMc=
X-Google-Smtp-Source: ACHHUZ4vC8ILoCqf/CNq7RJwWh9gajNgbl04fz4RYXRa4b+H3gIIJQFhL0OvmNloIqnZ3d9gZaiJVA==
X-Received: by 2002:ac8:5a07:0:b0:3f2:18e8:c766 with SMTP id n7-20020ac85a07000000b003f218e8c766mr11481078qta.67.1683053999218;
        Tue, 02 May 2023 11:59:59 -0700 (PDT)
Received: from LOCLAP699.cardinalhealth-columbus.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id r84-20020a37a857000000b0074d8eb83321sm9923191qke.27.2023.05.02.11.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 11:59:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] station: fix potential NULL access with forced roam
Date: Tue,  2 May 2023 11:59:55 -0700
Message-Id: <20230502185955.436081-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If forcing a roam using developer mode IWD could become
unconnected during the scan and result in a segfault when
the network_get_security() is called.
---
 src/station.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/station.c b/src/station.c
index be571083..9104ebf6 100644
--- a/src/station.c
+++ b/src/station.c
@@ -2482,7 +2482,7 @@ static bool station_roam_scan_notify(int err, struct l_queue *bss_list,
 	uint16_t mdid;
 	enum security orig_security, security;
 
-	if (err) {
+	if (err || !network) {
 		station_roam_failed(station);
 		return false;
 	}
-- 
2.25.1

