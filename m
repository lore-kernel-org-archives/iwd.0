Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4520B4D59E
	for <iwd@lists.linux.dev>; Mon,  4 Mar 2024 16:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709570939; cv=none; b=fv2Dw5/CsqqShRHS6dTi7j1ePtOLKgdPrqj4k0dXAZew1s8bN1SjG4YwFtSmQG8bXA/BOdkW3kRc11K6ec+8l7dAl5w40+Ntlw3BlWMLlIbaHLsd64vCR6dqrtZGh4OS+YVzAmx7reLzy/DqALjUFtAqkny8bGxqbnbctzHEKG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709570939; c=relaxed/simple;
	bh=VEvOBUqruPw2DvsnsRYoLXSnsIfFLZ8Br9zg6mTJQ14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HS/vXNIbyih1UAF4BqsAKNS8ETO8fBAJ+FyK8o9jRFPcCvHmNgtxXogZdUHBUoJwwejV5UYyWkN1JeI1Krr4vShpIzTWxmc2tCuJ8zoCLC1GAMj1UxglNd3eUTxUXe3sQrpElrVh7rTbnfQc9SmtUyHkR5NAj+6qthfUS5naQW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V96z5vh7; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V96z5vh7"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6901a6dca63so31106846d6.0
        for <iwd@lists.linux.dev>; Mon, 04 Mar 2024 08:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709570937; x=1710175737; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MMpzS9Ww4qrITHPPtRCX4gVxqp3MLaYXAD2gO4wlBo=;
        b=V96z5vh79OySioxsbzxQYKNjBmpJazso6JHMDO5EhYtYY0dy0nghrxZTG4eoi30z5M
         DFsht8+p0DlNXktmS5aOgZtK5vhbv/mgOBct9xHFC8fKmkYl/ITT4yP1197qXAMEY4ql
         HoOt0Ceuv5gWf7MaHMwKdCggKeG3ABmXFXApnWB92ycs2iI94dogut8P2PJuokvWWLhl
         CIz0XwJZIq9VAYlNlQfNH9Enf3PRaaCEckIpYuEov00g5MTRr1QzY/CUj+L9lb69cFhu
         QI2MWcQhOhAzp3mpkZFyz7VmJkxLz5qgoZIYNyFRvh9X3YA2n4FIYOsWAsPEiIGABr8G
         gkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709570937; x=1710175737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MMpzS9Ww4qrITHPPtRCX4gVxqp3MLaYXAD2gO4wlBo=;
        b=qlrQF3ZoF/ZDKzNZEayjFiQtz2ba5yWzFP51E/iOyphFyy79nFB1i5wkEYdKREwKDX
         zK0nQS3I7vc/byitdV1DYGiJm1OCLlY05WAajzbgCmkwySaEO7iYlNjIgpbr8UzElBYP
         lhACwlw1KYDg/JyBGxF4cMsqMxt12p3w3uPvM2TwSKGb+777fVm9GWEZAqKGamV0rIRj
         LwquhwPXAiDPrDwLW1gplovAtLYtiT3uPe+alM/sLWi0edHVFAbZxg2QyXuSlypqSJyg
         4+JAYLlWchKZSyu0wncEImAFclm1AHbO0Wqh7lukgNXu+sAIVtMyo13NBZnmyQrgnSE1
         dgCA==
X-Gm-Message-State: AOJu0YzZ1nOx/s0iYWHtVB9xjMBs4tbyyIa2W7WGR4jkdhrpZ2UFC3H6
	lhlfEl/OvzdLSOokII++Md1wWSnO6/1bmTe0sZ5PrioPkUbJEgYsrgcHJ6bq
X-Google-Smtp-Source: AGHT+IHxSbfY6jzeZG4nU2I8Xk0XV0npsK5qJC4VD/IxWSfOhhtZmAbNnOrCbDfDVcPc78C1HQOQ1A==
X-Received: by 2002:a0c:d60c:0:b0:690:4947:c2d6 with SMTP id c12-20020a0cd60c000000b006904947c2d6mr10116413qvj.47.1709570937000;
        Mon, 04 Mar 2024 08:48:57 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id qq1-20020a0562142c0100b0068fdc55ec7dsm3858466qvb.68.2024.03.04.08.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 08:48:56 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 4/5] eap-mschapv2: remove unneeded initialization
Date: Mon,  4 Mar 2024 08:48:45 -0800
Message-Id: <20240304164846.1783148-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304164846.1783148-1-prestwoj@gmail.com>
References: <20240304164846.1783148-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/eap-mschapv2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/eap-mschapv2.c b/src/eap-mschapv2.c
index 7f71cc82..1639f578 100644
--- a/src/eap-mschapv2.c
+++ b/src/eap-mschapv2.c
@@ -445,7 +445,6 @@ static int eap_mschapv2_check_settings(struct l_settings *settings,
 	if (!identity) {
 		secret = l_queue_find(secrets, eap_secret_info_match, setting);
 		if (secret) {
-			identity = l_strdup(secret->value);
 			password = l_strdup(secret->value +
 						strlen(secret->value) + 1);
 
-- 
2.34.1

