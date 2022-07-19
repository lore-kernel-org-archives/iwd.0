Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CB553A7
	for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 22:32:00 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id w7so828223plp.5
        for <iwd@lists.linux.dev>; Tue, 19 Jul 2022 15:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wg0FqvAGdQmhWcx1Rh6Wtr2dDeDZXDZaJsqxMuBDV3g=;
        b=Ld23kgmVlkcgklKQ5YXxLOkpLtdfqmmWPgDYhfzxGTzE7Gxen/EXdJJ6vLI2eVm9jW
         5lEIWx+2lwWCqqoAIRQdGGXS6EDuZXrj8asxsGi7beH0K7us6EVUeMPUnSxzGK5KG77a
         6y9YDGE9ouNsGNTRppJVa+8QXuSRG3Bsg/DyPYJ1/q5SzfIC9kY3/T6sYh2e0DWLfl3F
         P8jb/nVi39XkgBYK6badu+1lwdkNEJ/rxNdY/UoVyqSnt4J37/jPyHd3fyQwLpNtZiLe
         eD9g4cMhf5vPcUx7xMbuM+CJcDMpNkwqpg2j2bzU/eM0XDcCJYsvkMdzvZSgQSu8EZkk
         3SPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wg0FqvAGdQmhWcx1Rh6Wtr2dDeDZXDZaJsqxMuBDV3g=;
        b=oP3Xt0NgiuaIlYhuA/NVGas9O8AZtd7iimaZePMUUk6Vhv4uBHPNgdzDpS9xKJYRSU
         CZLuE5goSFAOlrtM7FPLoa4tx4/FUNQbSz5MVvqToclfllqnIQ6DwR5HGo8aNSbTHWV9
         9ix0WTqUeBfh+WKCjOwwI+5QGAuCriWJXblzIJ7Uhiqtd2eQ2CGuu7ui8g7xsePSvCPm
         EHJVgRR0kQ/qv4A+d81EXvmswx1OIeg3+KUdxLVCSvF1FjXKoqa9OgXYtwqPY94nhpW2
         QKHIjI4Ds9HHrNgH0crEJYMaZRWnY9+KCMDiMtRTAfjyH8mARseIgfjjz18u8pRNvBD6
         f+pw==
X-Gm-Message-State: AJIora+TLjHC3oA8HXKvGlSRIoQ4Ic/fk1RwC4fooMTBdIRezuCamMoW
	YtmsLpfk2S0vfy4HbJasIVX8eCNKFW8=
X-Google-Smtp-Source: AGRyM1snjyeUwaqPcfYy1xWZ+JjPMUQtOww+0wUXTVsi70qqLMlzs+9riBmztdl434aMbMNCCLOLng==
X-Received: by 2002:a17:90a:460e:b0:1f1:acb6:34 with SMTP id w14-20020a17090a460e00b001f1acb60034mr1761885pjg.167.1658269919641;
        Tue, 19 Jul 2022 15:31:59 -0700 (PDT)
Received: from localhost.localdomain ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id g3-20020a170902e38300b0015e8d4eb1c8sm12067154ple.18.2022.07.19.15.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 15:31:59 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/2] wiphy: fix strange compiler bug with gcc 11.2
Date: Tue, 19 Jul 2022 15:29:50 -0700
Message-Id: <20220719222950.540619-2-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220719222950.540619-1-prestwoj@gmail.com>
References: <20220719222950.540619-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There appears to be a compiler bug with gcc 11.2 which thinks the vht_mcs_set
is a zero length array, and the memset of size 8 is out of bounds. This is only
seen once an element is added to 'struct band'.

In file included from /usr/include/string.h:519,
                 from src/wiphy.c:34:
In function ‘memset’,
    inlined from ‘band_new_from_message’ at src/wiphy.c:1300:2,
    inlined from ‘parse_supported_bands’ at src/wiphy.c:1423:11,
    inlined from ‘wiphy_parse_attributes’ at src/wiphy.c:1596:5,
    inlined from ‘wiphy_update_from_genl’ at src/wiphy.c:1773:2:
/usr/include/bits/string_fortified.h:59:10: error: ‘__builtin_memset’ offset [0, 7] is out of the bounds [0, 0] [-Werror=array-bounds]
   59 |   return __builtin___memset_chk (__dest, __ch, __len,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   60 |                                  __glibc_objsize0 (__dest));
      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~
---
 src/wiphy.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/wiphy.c b/src/wiphy.c
index a52d0941..4dcfb8b3 100644
--- a/src/wiphy.c
+++ b/src/wiphy.c
@@ -1187,7 +1187,15 @@ static struct band *band_new_from_message(struct l_genl_attr *band)
 	toalloc = sizeof(struct band) + count * sizeof(uint8_t);
 	ret = l_malloc(toalloc);
 	memset(ret, 0, toalloc);
+
+#if __GNUC__ == 11 && __GNUC_MINOR__ == 2
+_Pragma("GCC diagnostic push")
+_Pragma("GCC diagnostic ignored \"-Warray-bounds\"")
+#endif
 	memset(ret->vht_mcs_set, 0xff, sizeof(ret->vht_mcs_set));
+#if __GNUC__ == 11 && __GNUC_MINOR__ == 2
+_Pragma("GCC diagnostic pop")
+#endif
 
 	return ret;
 }
-- 
2.34.1

