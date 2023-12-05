Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DAC5F1F6
	for <iwd@lists.linux.dev>; Tue,  5 Dec 2023 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EavWg4mz"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6d857f6f1c0so3357119a34.0
        for <iwd@lists.linux.dev>; Tue, 05 Dec 2023 07:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701791226; x=1702396026; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynkjYcP7IJR8MbXlzdLEE7AfZ7IxCw3aYdjYsAQAuvU=;
        b=EavWg4mzJa6mDd9hPnWyHbUA0jUJYWEC4CKt6Bq1JiEYNUj/nabnspCDgGswqMu9Jt
         znowX28B/7Zzvr5qDf9IbSAr92henxrxPP23ie5jlT5pDvhjEvYR4khz487rl8McnmoI
         8b37Y2p3YBah3O/BQJx9v5nFS8UAAgTmAlHSuoCiZ5/EUC07/pZIn5+r0cmXQRUCnuPZ
         7fHMo1RENcdN672r+nXvihNplXwSMSxNd1fysaosi8uzsqvZix5EFqm/l4UnuGaXsY/q
         401ajU5fF20yyyUVQZfbdRKC7RR3rzm1s/bvWGUfZgeDxH/UhxTEk/3SXCJLMNabj/tr
         uEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701791226; x=1702396026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynkjYcP7IJR8MbXlzdLEE7AfZ7IxCw3aYdjYsAQAuvU=;
        b=CCicMNqsQoecJE8zoCpaacysh9mTbBg7v9QHQQNrSCiKHKMoXv3WFHzOgnpXyVoEIW
         CSED2DNW4JhBJoqpEelWDKiRYQXEO5QYDLzIga6WpRiiZ8HTs9YpW76KWsfVuBbTV1Zl
         8OdRYV8PPMVjSUwJT4mV9whRqHxKmmRe0XUZPAq+W809oEIB8L5V8Iy5g7p/37E346+E
         U3HG/Wm4GUJ5+a/VvUEg3jLkOqETwYn9jiwj8dQEtyUL+o9n+01uCPCWUutTPBB4kk+R
         sajVnKR86CtdW3bq423COy6ZOJ8EGZVPdnNNqnpLVG9TH24bWLcviIJxbBH5vm/Lmj1e
         tLvA==
X-Gm-Message-State: AOJu0Yy7IQyUplvcV8GP7S95QwoRX1A8IBt1A2Bw0H6xcM0ocdmZ6whh
	bpa3nOvwA2zN8ysRJIT5Z6L6eusvD70=
X-Google-Smtp-Source: AGHT+IGfo+OUgz9XH4pFroQvkBmED7q2NIL0wQJb5cwE6nAjeIJcfWQn/fN1RVuWHJ+cg3Hi+5n13Q==
X-Received: by 2002:a05:6830:139a:b0:6d9:b049:a26c with SMTP id d26-20020a056830139a00b006d9b049a26cmr1720521otq.15.1701791223851;
        Tue, 05 Dec 2023 07:47:03 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id kr3-20020a0562142b8300b0067aad395037sm3177567qvb.60.2023.12.05.07.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:47:03 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 09/10] sae: add debugging for incorrect password identifier
Date: Tue,  5 Dec 2023 07:46:46 -0800
Message-Id: <20231205154647.1778389-9-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205154647.1778389-1-prestwoj@gmail.com>
References: <20231205154647.1778389-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the AP rejects the auth because of an unknown identifier catch
this and log the error.
---
 src/sae.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/src/sae.c b/src/sae.c
index da00e4da..9a10292e 100644
--- a/src/sae.c
+++ b/src/sae.c
@@ -1104,11 +1104,19 @@ static int sae_verify_committed(struct sae_sm *sm, uint16_t transaction,
 	 * If the Status is some other nonzero value, the frame shall be
 	 * silently discarded and the t0 (retransmission) timer shall be set.
 	 */
-	if (status != 0 && status != MMPDU_STATUS_CODE_SAE_HASH_TO_ELEMENT)
+	switch (status) {
+	case 0:
+	case MMPDU_STATUS_CODE_SAE_HASH_TO_ELEMENT:
+		if (status != sae_status_code(sm))
+			return -EBADMSG;
+		break;
+	case MMPDU_STATUS_CODE_UNKNOWN_PASSWORD_IDENTIFIER:
+		sae_debug("Incorrect password identifier, check "
+				"[Security].PasswordIdentifier");
+		/* fall through */
+	default:
 		return -ENOMSG;
-
-	if (status != sae_status_code(sm))
-		return -EBADMSG;
+	}
 
 	if (len < 2)
 		return -EBADMSG;
-- 
2.34.1

