Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF992F29
	for <iwd@lists.linux.dev>; Tue,  1 Nov 2022 20:18:00 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id m6so14528334pfb.0
        for <iwd@lists.linux.dev>; Tue, 01 Nov 2022 13:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pl/wF4QTzropjp7gVvmVx0kWZfSE+YEayUsDM/oHDxY=;
        b=dK8T+rL+el1yEgSPxZ0vb1l6qhImPZdQiNmaAhZPcZBeo4kmrTERMy3Blthq/QdFNp
         EaRsLwcR0qAE3Mus/f6MGxjdrvhs7nI1VIt85iQD1Tq7D5SkIsgRrxqY1a56+mqoZowR
         eBqiaU62ClT1+F3Ba3zijC8ktGZU/g8r7Pr1z5VJy0P9Kq/7jAIYMBIauC3i2pb5J9qS
         6Bte6xbam8b4atJ9DPIGC1nxWjCAfMZT26WxSZXL2cLrbs4ZJEozLRUo6RjzWBNj5061
         XFEQh1zqsCz7SBcGaOEHAqUmjvMpFwZu3Jk3JXH/9eDslvjpIhLn42d7naKzH2jP/02A
         FcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pl/wF4QTzropjp7gVvmVx0kWZfSE+YEayUsDM/oHDxY=;
        b=Eqvwioj++ShrXEksXmRMSVn4ukkXJSwJbyKDV4jnn4vkUS6lst9Drx4elAC/sdgHvE
         yrhODtYWIHtHi+DtUpyo0XXPLIeENWhKbY2hilPPseQmqPlHzF4OV9UihSsxOHCwUAqB
         rqfNORtgca6o9grRjC97doSP8AVz/bemklxZyC3J+LccwbjhOjMdBuzQ8s/dOH1NzyLb
         pB0ETu9MtYe9Hccpy1lnf3Au+L2QvOe1I+IeyEkkEw4UU5ruGyLbFB8uomUTGHjuR1Ms
         L1+ETursuaRpw2DR757h8RVrg0SOnLNdn047/7U6Pv51cVN8QDSrubQOBDtTsVHTL6Gz
         fD2g==
X-Gm-Message-State: ACrzQf3C08qrJuU8Hrldp7HBK/mSdMkVdvDqClEE/wmdylJASCT79T92
	I+go4UTnRFOZyb2TMIFDmW8ihkj++OY=
X-Google-Smtp-Source: AMsMyM74SwUx1fZJyynjK4e46Wo0Z43cJdpAMAdRXFXtHXC9HQ9R/nuzNTuLPb5Nf3m2Z0TVUOTHfw==
X-Received: by 2002:a05:6a00:35cb:b0:56c:a2f1:2783 with SMTP id dc11-20020a056a0035cb00b0056ca2f12783mr187649pfb.7.1667333880500;
        Tue, 01 Nov 2022 13:18:00 -0700 (PDT)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00180a7ff78ccsm6781681plg.126.2022.11.01.13.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:18:00 -0700 (PDT)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 10/17] hwsim: add remaining ciphers to supported list
Date: Tue,  1 Nov 2022 13:17:40 -0700
Message-Id: <20221101201747.143379-10-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20221101201747.143379-1-prestwoj@gmail.com>
References: <20221101201747.143379-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This list was not updated when adding the new ciphers which prevented
these ciphers from being disabled.
---
 tools/hwsim.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/hwsim.c b/tools/hwsim.c
index 0ace4c0e..7afbe4e7 100644
--- a/tools/hwsim.c
+++ b/tools/hwsim.c
@@ -176,6 +176,12 @@ static const uint32_t hwsim_supported_ciphers[] = {
 	CRYPTO_CIPHER_TKIP,
 	CRYPTO_CIPHER_CCMP,
 	CRYPTO_CIPHER_BIP_CMAC,
+	CRYPTO_CIPHER_GCMP,
+	CRYPTO_CIPHER_GCMP_256,
+	CRYPTO_CIPHER_CCMP_256,
+	CRYPTO_CIPHER_BIP_GMAC,
+	CRYPTO_CIPHER_BIP_GMAC_256,
+	CRYPTO_CIPHER_BIP_CMAC_256,
 };
 static uint32_t hwsim_ciphers[L_ARRAY_SIZE(hwsim_supported_ciphers)];
 static int hwsim_num_ciphers = 0;
-- 
2.34.3

