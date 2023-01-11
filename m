Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54839BD02
	for <iwd@lists.linux.dev>; Wed, 11 Jan 2023 20:15:55 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id 36so11319001pgp.10
        for <iwd@lists.linux.dev>; Wed, 11 Jan 2023 12:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxTylj1+B/tRyvCyNloTDqGnsGWuMshyD1prRpecyDQ=;
        b=UaWU3HDLVZ5rfEt+x/8/1RsfTGrQh1c7sJesetAsb5b8QyUmLkio/VyQb2eCH4GiPV
         tcW4RZwkAnNCs6Im9beKet64/vtQtKxXpRkq/zkLhny1wfYVhR1gCGHqNmll6gkm6/1N
         M5ETUNFLJW4RIk0BamNtvz+rWnNJwoctlTejXbALs4cqIkPDSOQVT2xKLs7Irfh2pH3f
         l5cmvYmCFP2TittuwHD9vcvSMNU0VMM9qwMfAOoUTln0sutxmmvEl4l6JgmK1HQudg90
         yOEGKpdu7RVwKoHgsp7+HbEjSiuARxLD3qvR3vCR5ICd4Szz8Gdm90CagzaK1QSz0H0o
         AFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxTylj1+B/tRyvCyNloTDqGnsGWuMshyD1prRpecyDQ=;
        b=jjrx7XSsBE2HWmC2MVbqjFZYcN62HTmAttBH4Cwbh9D1yyjsKas/hE7+mMOijTenhe
         ubkqeV8PG/hPBXKL6mUztNx96z+3cHTU1R8lLpcjdazaEPnSH8z3UKSHpiqprkK5DWiK
         5mdig1edVWtGZllVc0xJ23j6uNah3hht+ORkPaNDG75+8OsLD4cj+1X4lEXuRTbMDzS9
         IXhx+onk6xGt4XJflJBApPy4K3UcwwGrkuKrsHR6uWQR9N0i0zJ18Uu8zvaADXM2FOTq
         Whr7THu2JYPT2jtwbA0WSYMMTXkh24YHh4Pyf8N/F5Avs276zboAaJ/p4FEDdCkFAYXk
         9U6A==
X-Gm-Message-State: AFqh2kqv8cGO5BWe3tBWbZufUVArRnGE8zOg1pFLqIq6yEsRL30t4LeN
	UffUZHlRDTS+mbLrYcCWOSx0tO/2HQ4=
X-Google-Smtp-Source: AMrXdXusqsp0SK1ra9wR1ypN9WcOJhQBUXPUIC0M1tGGz3E5HLIOBt3/2BciK/v+O7BCsvOl/NsURA==
X-Received: by 2002:a62:7bd8:0:b0:580:963d:8064 with SMTP id w207-20020a627bd8000000b00580963d8064mr3526632pfc.20.1673468154689;
        Wed, 11 Jan 2023 12:15:54 -0800 (PST)
Received: from jprestwo-xps.none ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id i6-20020aa796e6000000b005884d68d54fsm6733904pfq.1.2023.01.11.12.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 12:15:54 -0800 (PST)
From: James Prestwood <prestwoj@gmail.com>
To: iwd@lists.linux.dev
Cc: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 7/9] eapol: relax secure bit check on 2/4
Date: Wed, 11 Jan 2023 12:15:41 -0800
Message-Id: <20230111201543.397692-7-prestwoj@gmail.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20230111201543.397692-1-prestwoj@gmail.com>
References: <20230111201543.397692-1-prestwoj@gmail.com>
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Old wpa_supplicant versions do not set the secure bit on 2/4 during
rekeys which causes IWD to reject the message and eventually time out.
Modern versions do set it correctly but even Android 13 (Pixel 5a)
still uses an ancient version of wpa_supplicant which does not set the
bit.

Relax this check and instead just print a warning but allow the message
to be processed.
---
 src/eapol.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/eapol.c b/src/eapol.c
index d31116b6..55c4b6d8 100644
--- a/src/eapol.c
+++ b/src/eapol.c
@@ -512,8 +512,7 @@ bool eapol_verify_ptk_2_of_4(const struct eapol_key *ek, bool ptk_complete)
 	if (!ek->key_mic)
 		return false;
 
-	if (ek->secure != ptk_complete)
-		return false;
+	L_WARN_ON(ek->secure != ptk_complete);
 
 	if (ek->encrypted_key_data)
 		return false;
-- 
2.34.3

