Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829237475
	for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 21:31:41 +0000 (UTC)
Received: by mail-pg1-f177.google.com with SMTP id f11so17569585pgj.7
        for <iwd@lists.linux.dev>; Wed, 20 Jul 2022 14:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r28ZFcfxUrmrlT1fhyZI+HYXwvVxgOPhLo/OAmIYktY=;
        b=I3G4wbAiA1dc0JX/QXiVQZ3WCoAvbXSprcoj3J+m4FaBCrHqqe+lKd2oFT96VgpD+0
         p6Al+hY0vD5Dw5Z5gQJ7x7yjUQTz/ERFDqmFG7GN2FeYNtIS7tYIO/vdJZyv23kzrYM/
         myNEC9Zc+nUj2DAfEu2UhMC9JmYWTTv8H+MlTzwmQnmdc/jZI3omU2deKOCbV9n9+QPR
         pmG4eszGtqQIctDzakIV+SKdNu8SiE9c/TNEtcLXj8gQUKXHsE+nkfT/Rjw2KhVs5mwy
         H/t74MCUpc0MZbVTWbKNsVAhppA0gvWoUjvBg2AaGZv4DWeR/faoxppGP9unt+yZbNK6
         uEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r28ZFcfxUrmrlT1fhyZI+HYXwvVxgOPhLo/OAmIYktY=;
        b=eJCwpeVA20e3UuNs+8mgx14Vvhr6kVbCrGHYJahB9SEfENvxtgSOhGhW6WCF8uMWnt
         U6hvytWPf8xfCOw7rbTr8q/dR3TsMwIDAWKLl001zyx6TdMK6tlW3VFmdnMk+n+tff48
         MnZujFzgQVk5b07N+d7Xca2L7KtbI8p+g+uWj9RQOvCG61P9xWd7NMMGoXW4DyqVakA9
         TKT+dF2rDO6vX9ekZo2XjZii5OJnwNuNWUlhGaBcq29l6BpD/xzdL5/5p2Y5SKgLEkwI
         2DWbesUyJCWTUN6Iy9GirwOxUo5+kghZeEsIY1nqruJRsaPtJhRoQbaxxBDmF3HCLYK8
         Dxag==
X-Gm-Message-State: AJIora8jwaCiczO+KvzECXvwU595BCmUoAVkNRwA0J79tOduBlP/0GTv
	bH7ZM0PdpeQqn4S+C9URm6a5HTdV4yo=
X-Google-Smtp-Source: AGRyM1s/wfzxrzSW3UcOq3SnliR0btoCVAjJXtBbpkez5LNOZvMLL+w+5c6USbR+4wGd7Mhrc8uZ5g==
X-Received: by 2002:a05:6a00:1248:b0:52b:ca7:f2b6 with SMTP id u8-20020a056a00124800b0052b0ca7f2b6mr40478451pfi.82.1658352700780;
        Wed, 20 Jul 2022 14:31:40 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id y22-20020a170902b49600b0016c5306917fsm41475plr.53.2022.07.20.14.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:31:40 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH v5 4/5] build: add ie.c/netdev.h to test-band build
Date: Wed, 20 Jul 2022 14:29:31 -0700
Message-Id: <20220720212932.873353-4-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220720212932.873353-1-prestwoj@gmail.com>
References: <20220720212932.873353-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 Makefile.am | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 80377613..cffb0738 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -466,7 +466,8 @@ unit_test_kdf_sha256_LDADD = $(ell_ldadd)
 unit_test_ie_SOURCES = unit/test-ie.c src/ie.h src/ie.c
 unit_test_ie_LDADD = $(ell_ldadd)
 
-unit_test_band_SOURCES = unit/test-band.c src/band.h src/band.c
+unit_test_band_SOURCES = unit/test-band.c src/band.h src/band.c src/netdev.h \
+					src/ie.h src/ie.c
 unit_test_band_LDADD = $(ell_ldadd)
 
 unit_test_crypto_SOURCES = unit/test-crypto.c \
-- 
2.34.1

