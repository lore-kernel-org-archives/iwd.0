Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE1D847C
	for <iwd@lists.linux.dev>; Thu, 12 Jan 2023 19:32:22 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so24683917pjj.2
        for <iwd@lists.linux.dev>; Thu, 12 Jan 2023 11:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOA1KJtJe0EYrXWOZX9o8wFbgdeUO4B/DZqAfRPT/Pw=;
        b=nWkXtpMJfgqnUjfYg1yBbQHT1L8iOnD+nXJCpajSo3w7qeJzZ4FSOuwe0NE4zPMAHa
         2oFddEak1wtF+h17E2qSlKrSLCuWUz7J9nuind0GcQM+tv10nUHLidc12XrK2sXMzJKs
         OmN17HXopZtPoDILajMh0LQ2Z/a60Gckqi+2mRI4Dhub6CZFAdgmUeQsQqnZoE0JbT7K
         cDrIrWHt99w4esswY9MdwoUFO7jzdFTE1Ub+t49xwvQwP5pM5+fouoNeg+9Lzhjnsl6W
         RIvBxqutwVc0c7aK8aonEHvprPDAyHFkotB6nMRrMiflzocmwbIJ1z7e62NtboOEDkms
         eKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOA1KJtJe0EYrXWOZX9o8wFbgdeUO4B/DZqAfRPT/Pw=;
        b=MW/KkvkmXIiqEpc1iKNstpGfNOQrnj/2+0oD7lGO7/QuLzvdWMzNztCxK1ICU5hpae
         him31eVAg6zS0h31yTGQA2V9Jfew4VuFK31Qa7GDCr3n+R71xTpMqPQfu76T8UEwvnNi
         /6kv2imWM6L7EcPI7T7hc8X5LyoeHKXtXLKcGGugxL3k0KcojrfYjJblKIzUSSxZlctU
         04edmzKilgHWbhbgxP4kyz8oR+L1pkqKbeJZDK7GfNFsbME6Y9ic7y4Y5lBpT846ERLc
         UZ1cYwXUvaNDEvIWa2z+JFQDxYG24avqnrepVxUi2Ot7RrTVBoJuOtR3/SO7wws4oYC9
         l2Yg==
X-Gm-Message-State: AFqh2kr2dZOixTdDXWZvSSmrZaJi0pDGNtydpEc1VoABxDKdgBmaQgGB
	MpHUQIlDRI1941PBLPh+vpeYD1GAqwE=
X-Google-Smtp-Source: AMrXdXsqxLXVG7MPr/sY4C73I0mdCCA14WS6NA8KjP9/6Jf/7xnbBcqa70Ia4mjweWe5v0ZtYolBnQ==
X-Received: by 2002:a17:90a:fa88:b0:225:f20f:150f with SMTP id cu8-20020a17090afa8800b00225f20f150fmr62510818pjb.9.1673551942465;
        Thu, 12 Jan 2023 11:32:22 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id qe12-20020a17090b4f8c00b00218fba260e2sm12732147pjb.43.2023.01.12.11.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 11:32:21 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 4/4] doc: Document RekeyTimeout for AP profiles
Date: Thu, 12 Jan 2023 11:32:12 -0800
Message-Id: <20230112193212.568476-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230112193212.568476-1-prestwoj@gmail.com>
References: <20230112193212.568476-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 src/iwd.ap.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/iwd.ap.rst b/src/iwd.ap.rst
index 823aba99..ce402f91 100644
--- a/src/iwd.ap.rst
+++ b/src/iwd.ap.rst
@@ -67,6 +67,13 @@ The group ``[General]`` contains general AP configuration.
        ensure the country is set, and that the desired frequency/channel is
        unrestricted.
 
+   * - RekeyTimeout
+     - Timeout for PTK rekeys (seconds)
+
+       The time interval at which the AP starts a rekey for a given station. If
+       not provided a default value of 600 seconds is used. A value of 0 will
+       disable PTK rekeys completely.
+
 Network Authentication Settings
 -------------------------------
 
-- 
2.34.3

