Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDB13D88
	for <iwd@lists.linux.dev>; Mon,  8 Aug 2022 17:14:11 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so9798314pjl.0
        for <iwd@lists.linux.dev>; Mon, 08 Aug 2022 10:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=npPadd1c+74e9zEQGbL298nkfqh6ux7bBWkepYYATpM=;
        b=NdH1cRTxaD8UCT7i2Kcs8iwGRcexSbAo0H5girihTb4qjW7s9lZYJDpjk3RqBl9uLL
         Gm6P04QmqIgT0LkFZY6LrbzghPHXLkjUkfDAeIJBQLGfsZQq+lNCr54nhnHzyODSdap0
         D7GOjjPtbpLnKU2yDIgwzu/lVq8xE5DUaKSkCV8PdyF+OAj6SDGroIeqmImN9gbOTg03
         pFDH8qC/WGyiBidA4fJryYBOFs3sNEyxqqWCrPsWfAFDR2qqXDjOXsT8flvB28CvaNRp
         HHXH+3oZHgXWgPGEMtLOZ4YYiYNpCkTY6FiP+eEB/zPUxJztHN5CY1NmGA+NOC7g0+OT
         51+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=npPadd1c+74e9zEQGbL298nkfqh6ux7bBWkepYYATpM=;
        b=08+gsRGK15wuqm//rYw5RNaScS7pbQgasXFDq9EmbR7N6g9s+GhhooNgK+1eMgcgJc
         Nsn9S4SdN5U4zxB2luThvISziZRnR2vzboESyg4TUf+9isNxz96BieXFWTdLkFOIR1ZJ
         n54edTjW2zc7tMz1kfm1z3Cxs4xuUoRurgZFX/oDoh9iqeID7tMpQD5EtAoNO/OE1ywm
         2zTlhgnn41qiSGaDFLdnDjnTF1qbaw4vDXmynqNXLVsN+4w3MxIqSBHezuZW/nw1UNbW
         t/sOYhURpMTqXtHPHt2a29y1KOx3RNkhqLCRV7B+b9DieZSIjmmbJvcx/uGrbuPr/pDq
         wsDg==
X-Gm-Message-State: ACgBeo2curzVsRqmAicypzHTMJfBSHU/Qa85ksi8Q83FiE6+qvy2rIND
	gpfu4CzB/MBBi+yAwvWHqx2RqsVi2Gk=
X-Google-Smtp-Source: AA6agR4S7UUScM9XEYDXj4F9hX7b8sH+91heReyYcehN36q5g8KuqaKxzYZf0Q+lH+LfULPUeb0PnA==
X-Received: by 2002:a17:90b:2241:b0:1f5:2c5e:1080 with SMTP id hk1-20020a17090b224100b001f52c5e1080mr30579231pjb.85.1659978850236;
        Mon, 08 Aug 2022 10:14:10 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.168.145])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709026f0100b0016dd667d511sm8932754plk.252.2022.08.08.10.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 10:14:09 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/4] handshake: add force_default_owe_group flag
Date: Mon,  8 Aug 2022 10:14:03 -0700
Message-Id: <20220808171406.12931-1-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Indicates the OWE SM should only use the default group
---
 src/handshake.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/handshake.h b/src/handshake.h
index 7f597b06..f2321634 100644
--- a/src/handshake.h
+++ b/src/handshake.h
@@ -137,6 +137,7 @@ struct handshake_state {
 	bool authenticator_ocvc : 1;
 	bool supplicant_ocvc : 1;
 	bool ext_key_id_capable : 1;
+	bool force_default_owe_group : 1;
 	uint8_t ssid[32];
 	size_t ssid_len;
 	char *passphrase;
-- 
2.34.3

