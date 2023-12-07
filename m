Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68464405DD
	for <iwd@lists.linux.dev>; Thu,  7 Dec 2023 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsMNPLWT"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-db54611b920so949825276.3
        for <iwd@lists.linux.dev>; Thu, 07 Dec 2023 05:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701956910; x=1702561710; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSxwELDo2cZzRWz6CJL7kDZoymdNmGBPXvNerdokW04=;
        b=GsMNPLWTft1SLaDPN0q6Xq11qt0/Gkjs3eiL6OuYMLOZikoGPIJVSylD7mJANfmWRm
         Jt5t+K+zkG08QcDJZmPg9Vu7TNylaNRkhL5hPsa0N5gpj03u26KNtWN5ZpYe2n0a5j7o
         hAiiuvOg9q0lcX//xdIi82FF+a1mBLw2vN0pXuFGlX4G0SiHENGfKKR6j53WTki4RQg/
         hQCngBClaCvZ76oboRFFtSnKRk6YzcVeww2SrztXyl13r3bYSK0ykSLLNgPX/3bQrvEs
         bk0ITLc3hYzIKbFvttWxsIHuTV3IDd7wS9EZMZxofLm9aKVjJ7GPzbZGl1COIW9oWIiL
         ckhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701956910; x=1702561710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSxwELDo2cZzRWz6CJL7kDZoymdNmGBPXvNerdokW04=;
        b=Amh6tqeqAqNwwaAFHTLbS5i3I+Gehxbd0J3do/Mdw5veGqp6vUjdDCBbVvilIpns+Z
         d/UP4g1B+pSuraT4H3t+6QzJrSLrjnmnh2RVVoEMEEGo3W5ksw+a9UxsjdRXSqftUl1n
         5/VRbDL/6mjDZ0npbImnwuuR7ZSKekii1Q9Oe5mo143A0Gna9Yh+EJHzS21pTFEgZwi4
         0kQe7qTHFJaUMYOXw/ua7z1UnAcgnRqhBMPpDu3r6Ly7CqmCfl+1G0nfUdM29fgTRk9C
         XNZYGumwNYHo4hxdGDr7xYIOlayk3bzhjfXTG/uTIE3zssOAqMZYjapRoMlkNpmFy5ab
         kdIQ==
X-Gm-Message-State: AOJu0Yz9tAAar2D8fH5vhiTS3MO0AglVsF0CQAH34ckMaVxoxeNhFAhm
	WB/D4wwIH5u/Dfo+UlcTREFM+OcKc0Y=
X-Google-Smtp-Source: AGHT+IF4pJeEyzwyNpHh9igz6bHtmWyFfAacZB5nXkCfiWIvH6tgak43uF6C9846cs0dIDc7gkyHMw==
X-Received: by 2002:a05:6902:52b:b0:db7:dacf:2f1b with SMTP id y11-20020a056902052b00b00db7dacf2f1bmr2308173ybs.98.1701956909644;
        Thu, 07 Dec 2023 05:48:29 -0800 (PST)
Received: from LOCLAP699.rst-02.locus ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id w18-20020a0cef92000000b0067a27108513sm496494qvr.67.2023.12.07.05.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:48:29 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v2 2/4] doc: document [Security].PasswordIdentifier
Date: Thu,  7 Dec 2023 05:48:20 -0800
Message-Id: <20231207134822.2458827-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207134822.2458827-1-prestwoj@gmail.com>
References: <20231207134822.2458827-1-prestwoj@gmail.com>
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

