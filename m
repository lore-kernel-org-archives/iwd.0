Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD5C405D7
	for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CysL9+1P"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4257ba1bc5fso60953531cf.0
        for <iwd@lists.linux.dev>; Thu, 14 Dec 2023 04:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702557245; x=1703162045; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSxwELDo2cZzRWz6CJL7kDZoymdNmGBPXvNerdokW04=;
        b=CysL9+1PN6GM3FA8UL3gUrMyfz11pCToX3x3j3dj/bVI+pvhMqiAfadctu7CB8pOph
         MhNs5JQSvN6dQoZ5gGAIARzqUatqhzYm48UV22Gd80dcEwwNgJMMRcWxG/CT5fFGUCcT
         oIlzOkpC9ugqdjdn4iR4cFn9mhl4DQFRYR0kicT0xgoyKvBnfzSDEgxW3wacnpBqDKp/
         8xdDRz9VXucUsBNxw/OffPfCTSNFEXKxBWWSavpNh/o+ft2G0js/vYJPYuIcoM32Xg/V
         AFFij/68s9Es4MhD2RNZXkEPWgBmd/V9ZWGvqYIC/nnFVyDup29z0l/tn8fm0HNex2Vi
         6L/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702557245; x=1703162045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSxwELDo2cZzRWz6CJL7kDZoymdNmGBPXvNerdokW04=;
        b=tteMzW986y4PJQ3mMfVnDJ2gXyr9zcaLW+eZylPiKT8UPL4CbAa62mKkNtJaL/CMXn
         RfDWwYVaBMm8RbE6qpI44skZks7e/iZTizS+qDGGU+J8FtgAkyJp/oaLIbnrEb1djO0N
         viZ7ixdpC/OWJgwG2lcAP2rRe9dhWo2/hSbFzi+2HmDD2umsGREHBrevXVeJAnZKrDb9
         4tMYXKwF6JZWb7kytQ5NJwEbe87l5gOaon1n6yKyX6R/Po4OCSmOhPST8G3hPuZhyVjr
         rai5IV8Ie3PEKO/ApzvzAALyq1Ii4FFi3SCZJQd3SJizvz8jPFxYSP2pe8XV/1VLuatH
         eUgg==
X-Gm-Message-State: AOJu0Yy75QdCemj/hJfCqM+D4wRy9jxuO/7eo+K58ZmTyaMIOaPs+cr1
	JRKNNI1bM9lSaEGt+nIlODt4VuBcU14=
X-Google-Smtp-Source: AGHT+IHP2uUjww4gS5elmbwrLxGb4ZJ0NL3L6ZgP09kb6sQ1F8zJBHZL5rDqitHMXUE9HTD69PKalg==
X-Received: by 2002:ac8:5843:0:b0:423:98ce:48e with SMTP id h3-20020ac85843000000b0042398ce048emr14148689qth.22.1702557244647;
        Thu, 14 Dec 2023 04:34:04 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id x3-20020ac87303000000b0042551dce749sm5745883qto.46.2023.12.14.04.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 04:34:04 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v4 2/4] doc: document [Security].PasswordIdentifier
Date: Thu, 14 Dec 2023 04:33:58 -0800
Message-Id: <20231214123400.12924-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231214123400.12924-1-prestwoj@gmail.com>
References: <20231214123400.12924-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.network.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/iwd.network.rst b/src/iwd.network.rst
index 719853fa..734dcfa1 100644
--- a/src/iwd.network.rst
+++ b/src/iwd.network.rst
@@ -199,6 +199,12 @@ connect to that network.
        required if the *PreSharedKey* is not provided.  If not provided in
        settings, the agent will be asked for the passphrase at connection
        time.
+   * - PasswordIdentifier
+     - string
+
+       An identifer string to be used with the passphrase. This is used for
+       WPA3-Personal (SAE) networks if the security has enabled password
+       identifiers for clients.
    * - PreSharedKey
      - 64 character hex string
 
-- 
2.34.1

