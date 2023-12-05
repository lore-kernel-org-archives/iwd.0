Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C06C5AB85
	for <iwd@lists.linux.dev>; Tue,  5 Dec 2023 15:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dl6atQKD"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-77dccb3e4baso377568685a.0
        for <iwd@lists.linux.dev>; Tue, 05 Dec 2023 07:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701791220; x=1702396020; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddG2NgAFohCJV7Cc17A4DZHKBY27rv39aR8NPt62Fzw=;
        b=dl6atQKD3bVYTSqsiWFbrQgq6m9rHt6mYfzfGZ7mwwpG+v11EqkkDIsNLR9pwbf66H
         bF4L55VdWbKE5ofwblHX4X9RMCvMx/X84Ck+Qd83msu0BqDfwP+AmSRKMLqHmBtxhyBX
         6Qk5Rh7TY8xv/hnoJqKg3FmUwi+hXbW9pjZAIwT8xKlFKmF0QOckYSTngOiLOAikB8Ix
         UuUbhhfDyfFqo5ZYt7+YVNzuyUoXBPeQQ8wCkM0RGlc9fAm1zPJDmSeP6URcerK5XUR5
         TRZds/je4KfFBHFGXxedu+g7hykPItTCm9qkVVRNHVFxB7vfR4xyfx3HbOKEeSFuJM0w
         Hfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701791220; x=1702396020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddG2NgAFohCJV7Cc17A4DZHKBY27rv39aR8NPt62Fzw=;
        b=qTNG2jcmDAem5ItFpWAMQ9LDGVS4Y6ezFM968/y6f8F3PiZ1wYPVByA3L9ZfvaglRY
         dHJ5VkN0na7doTehfWRQZYqTCnszXEIeSYZ/klFJB+x/iMb+mmyZKR7rVZwJvPRXta23
         iDWGDD2bmAg2riL70N/grNqeUh4vWcA+XmywtjoiU5Wu3P/WwSkxW1KhZwfOP/ctAwB+
         5IBQQoSUMMsPFYkHkJpMSs/3QWa5F+Xk4LG7iG5/opL+BzRXrO99lVn7wWk8cTI28tmM
         OMSi6sdgGxMT6v2znfphTVbNsd5NsHzx6r0tZS6NRRQvcXB1ehRAnacPFVQyEaEuqKza
         5czg==
X-Gm-Message-State: AOJu0YxD2xtIwmU1w39QRJ2ho7XkjGFJvyqtTiKUO7lMyaVXSJ7o2pSP
	v4i+hgyTuATkZoGMf0YuNhPeMrIv0VA=
X-Google-Smtp-Source: AGHT+IGE9wGwptqBKMRQY+Ei6QRQHr4DnmXgwh/B936o+5Euv+kOKQM/sgQVPa6M8Qeu2JQycTOojw==
X-Received: by 2002:a0c:efd4:0:b0:67a:9f66:5afd with SMTP id a20-20020a0cefd4000000b0067a9f665afdmr1515894qvt.12.1701791220366;
        Tue, 05 Dec 2023 07:47:00 -0800 (PST)
Received: from LOCLAP699.rst-02.locus (50-78-19-50-static.hfc.comcastbusiness.net. [50.78.19.50])
        by smtp.gmail.com with ESMTPSA id kr3-20020a0562142b8300b0067aad395037sm3177567qvb.60.2023.12.05.07.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:47:00 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 06/10] doc: document [Security].PasswordIdentifier
Date: Tue,  5 Dec 2023 07:46:43 -0800
Message-Id: <20231205154647.1778389-6-prestwoj@gmail.com>
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

---
 src/iwd.network.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index 719853fa..d467b7b1 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -199,6 +199,16 @@ connect to that network.
        required if the *PreSharedKey* is not provided.  If not provided in
        settings, the agent will be asked for the passphrase at connection
        time.
+   * - PasswordIdentifier
+     - string
+
+       An identifer string to be used with the passphrase. This is used for
+       WPA3-Personal (SAE) networks if the security has enabled password
+       identifiers for clients.
+
+       Note: if the network does not support password identifiers but one is
+       set in the profile it will be ignored and removed upon a successful
+       connection to the network.
    * - PreSharedKey
      - 64 character hex string
 
-- 
2.34.1

